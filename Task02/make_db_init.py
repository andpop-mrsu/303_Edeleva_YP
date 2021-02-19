#!/usr/local/bin/python
# coding: utf-8

import re


def separator(s):
    # выделение id
    id_end = re.match(r'\d*', s).end()
    id = s[:id_end]
    # выделение year
    year = "NULL"
    title = "NULL"
    genres = "NULL"
    if re.search(r'[(]\d\d\d\d[)]', s) is None:
        if re.search(r'(no genres listed)', s) is None:
            title_end = s.rfind(",")
            title = s[id_end + 1: title_end]
            genres = s[title_end + 1:]
        else:
            title = s[id_end + 1:]
    else:
        # выделение year
        year_end = re.search(r'[(]\d\d\d\d[)]', s).end()
        year_start = re.search(r'[(]\d\d\d\d[)]', s).start()
        year = s[year_start + 1:year_end - 1]
        # выделение genres
        genres = s[year_end + 1:]
        # выделение title
        title = s[id_end + 1:year_start - 1]

    title = title.replace("'", "‘")
    return [id, genres, year, title]


with open("db_init.sql", "w", encoding="utf-8") as fout:
    print(".open movies_rating.db\n", file=fout)

    # удаление таблиц, если они уже существуют
    print("DROP TABLE IF EXISTS movies", end="\n", file=fout)
    print("DROP TABLE IF EXISTS ratings", end="\n", file=fout)
    print("DROP TABLE IF EXISTS tags", end="\n", file=fout)
    print("DROP TABLE IF EXISTS users", end="\n", file=fout)

    # создание таблиц
    print("CREATE TABLE movies (id INTEGER RRIMARY KEY, title VARCHAR, year INTEGER, genres VARCHAR)", end="\n",
          file=fout)
    print(
        "CREATE TABLE ratings (id INTEGER RRIMARY KEY, user_id INTEGER, movie_id INTEGER, rating FLOAT, timestamp INTEGER)",
        end="\n", file=fout)
    print(
        "CREATE TABLE tags (id INTEGER RRIMARY KEY, user_id INTEGER, movie_id INTEGER, tag VARCHAR, timestamp INTEGER)",
        end="\n", file=fout)
    print(
        "CREATE TABLE users (id INTEGER RRIMARY KEY, name VARCHAR, email VARCHAR, gender VARCHAR, register_date DATE, occupation VARCHAR)",
        end="\n", file=fout)

    # парсинг файла movies.csv и заполнение таблицы movies
    print("INSERT INTO movies (id, title, year, genres)", end="\n", file=fout)
    print(f"VALUES ", file=fout)

    with open("movies.csv", "r", encoding="utf-8") as f:
        file = f.readlines()[1:]

        for i in range(len(file)):

            item = separator(file[i][:-1])
            if i != len(file) - 1:

                print("({}, '{}', {}, '{}'),\n".format(item[0], item[3], item[2], item[1]), file=fout)
            else:

                print("({}, '{}', {}, '{}'),\n".format(item[0], item[3], item[2], item[1]), file=fout)

                # парсинг файла ratings.csv и заполнение таблицы ratings
    print("INSERT INTO ratings (id, user_id, movie_id, rating, timestamp)\n", file=fout)
    print(f"VALUES", end=" ", file=fout)

    with open("ratings.csv", "r") as fl:
        file = fl.readlines()[1:]
        for i in range(len(file)):
            item = file[i][:-1].split(",")
            if i != len(file) - 1:

                print("({},{}, {}, {}, {}),\n".format(i, item[0], item[1], item[2], item[3]), file=fout)
            else:
                print(f"({i}, {item[0]}, {item[1]}, {item[2]}, {item[3]});\n", file=fout)
                print("({},{}, {}, {}, {}),\n".format(i, item[0], item[1], item[2], item[3]), file=fout)
                # парсинг файла tags.csv и заполнение таблицы tags
    print("INSERT INTO tags (id, user_id, movie_id, tag, timestamp)\n", file=fout)
    print(f"VALUES", end=" ", file=fout)

    with open("tags.csv", "r") as fl:
        file = fl.readlines()[1:]
        for i in range(len(file)):
            item = file[i][:-1]
            item = item.replace("'", "‘")
            item = item.split(",")
            if i != len(file) - 1:

                print("({}, {}, {}, '{}', {}),\n".format(i, item[0], item[1], item[2], item[3]), file=fout)
            else:

                print("({},{}, {}, '{}', {}),\n".format(i, item[0], item[1], item[2], item[3]), file=fout)

                # парсинг файла users.txt и заполнение таблицы users
    print("INSERT INTO users (id, name, email, gender, register_date, occupation)\n", file=fout)
    print(f"VALUES", end=" ", file=fout)

    with open("users.txt", "r") as fl:
        file = fl.readlines()[1:]
        for i in range(len(file)):
            item = file[i][:-1]
            item = item.replace("'", "‘")
            item = item.split("|")
            if i != len(file) - 1:

                print("({}, '{}', '{}', '{}' {}, '{}'),\n".format(item[0], item[1], item[2], item[3], item[4], item[5]),
                      file=fout)
            else:

                print("({}, '{}', '{}', '{}' {}, '{}'),\n".format(item[0], item[1], item[2], item[3], item[4], item[5]),
                      file=fout)

