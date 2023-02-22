class Dogs

    attr_accessor :id ,:name, :breed
    def initialize(id,dog_name,breed)
        @id = null
        @dog_name = dog_name
        @breed = breed
    end


    def self.create_table
        DB[:conn].execute("DROP TABLE IF EXISTS dogs")
        sql = <<-SQL
        CREATE TABLE IF NOT EXISTS dogs(
            id INTEGER PRIMARY KEY
            dog_name TEXT
            breed TEXT
        )
        SQL

        DB[:conn].execute(sql)
    end

    def self.drop_table
        sql = <<-SQL
        DROP TABLE IF EXISTS dogs 
        SQL

        DB[:conn].execute(sql)
    end


    def save
        sql = <<-SQL
        INSERT INTO  dogs 
        (dog_name, breed)

        VALUES (?, ?)
        SQL
        #insert the dog
        DB[:conn].execute(sql, self.dog_name, self.breed)
    end


    def self.create
        dogs = Dogs.new(dog_name: dog_name, breed: breed)
        dogs.save
    end

    def.new_from_db
        #self is equivalent to dogs.new
        self.new(id: row[0], name: row[1],album: row[2])
    end

    def self.all   #returns an array of rows from database that return our querry
        sql = <<-SQL
        SELECT * 
        FROM dogs
        SQL

        DB[:conn].execute(sql).map do |row|  #iterate over a new array to give new ruby object
            self.new_from_db(row)
    end

    def self.find_by_name(name)
        sql = <<-SQL
        SELECT * 
        FROM dogs
        WHERE dog_name = ?
        LIMIT 1
        SQL

        DB[:conn].execute(sql, dog_name).map do |row|
            self.new_from_db(row)
    end

    def self.find(id)
        sql = <<-SQL
        SELECT * 
        FROM dogs
        WHERE id = ?
        LIMIT 1
        SQL

        DB[:conn].execute(sql, id).map do |row|
            self.new_from_db(row)
    end


    def self.update
        sql = <<-SQL
        UPDATE dogs
        SET dog_name = ?
        where dog_name = ?
        SQL

        DB[:comm].execute(sql, dog_name).map do |row|
            self.new_from_db(row)
    end
end
