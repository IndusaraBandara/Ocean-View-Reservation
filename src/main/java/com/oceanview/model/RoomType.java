package com.oceanview.model;

public class RoomType {
    private int id;
    private String typeName;
    private double ratePerNight;
    private String roomImage;

    public RoomType() {
    }

    public RoomType(int id, String typeName, double ratePerNight, String roomImage) {
        this.id = id;
        this.typeName = typeName;
        this.ratePerNight = ratePerNight;
        this.roomImage = roomImage;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public double getRatePerNight() {
        return ratePerNight;
    }

    public void setRatePerNight(double ratePerNight) {
        this.ratePerNight = ratePerNight;
    }

    public String getRoomImage() {
        return roomImage;
    }

    public void setRoomImage(String roomImage) {
        this.roomImage = roomImage;
    }
}
