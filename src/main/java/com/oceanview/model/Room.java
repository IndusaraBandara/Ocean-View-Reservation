package com.oceanview.model;

public class Room {
    private int id;
    private String roomNumber;
    private int roomTypeId;
    private String status;
    private String roomImage; // Per-room image support
    private RoomType roomType; // Join object
    // Derived booking state (for dashboard display)
    private String activeReservationNumber;
    private String activeGuestName;
    private java.sql.Date activeCheckoutDate;

    public Room() {
    }

    public Room(int id, String roomNumber, int roomTypeId, String status, String roomImage) {
        this.id = id;
        this.roomNumber = roomNumber;
        this.roomTypeId = roomTypeId;
        this.status = status;
        this.roomImage = roomImage;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public int getRoomTypeId() {
        return roomTypeId;
    }

    public void setRoomTypeId(int roomTypeId) {
        this.roomTypeId = roomTypeId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRoomImage() {
        return roomImage;
    }

    public void setRoomImage(String roomImage) {
        this.roomImage = roomImage;
    }

    public RoomType getRoomType() {
        return roomType;
    }

    public void setRoomType(RoomType roomType) {
        this.roomType = roomType;
    }

    public String getActiveReservationNumber() {
        return activeReservationNumber;
    }

    public void setActiveReservationNumber(String activeReservationNumber) {
        this.activeReservationNumber = activeReservationNumber;
    }

    public String getActiveGuestName() {
        return activeGuestName;
    }

    public void setActiveGuestName(String activeGuestName) {
        this.activeGuestName = activeGuestName;
    }

    public java.sql.Date getActiveCheckoutDate() {
        return activeCheckoutDate;
    }

    public void setActiveCheckoutDate(java.sql.Date activeCheckoutDate) {
        this.activeCheckoutDate = activeCheckoutDate;
    }
}
