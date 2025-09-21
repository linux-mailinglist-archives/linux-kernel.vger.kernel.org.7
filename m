Return-Path: <linux-kernel+bounces-826172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A7DB8DBD2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 15:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9B4517851F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 13:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA872D6E4A;
	Sun, 21 Sep 2025 13:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpLkx+a5"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472721ACEDA
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 13:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758461267; cv=none; b=Hy5oXsXV9mX91jgvSo8tTbGb/vQKS37qBhFFbKRVshJIVrtAYGiJpL0aGMCPKqUhG7WMOx3QDox3akx6Auo9Z+4FaomKEMQe67PVc7ivURYPy+f4uHnVDjCrY0F7Yv5dTdm+ir78zFPIi8yUMuF1Me8+tsUE4SZ6cuwT3eZ+qcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758461267; c=relaxed/simple;
	bh=BYJAfX8Ywmm+fJlTq83GsVFmVYUs5CH9DAnRyLFosY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lu2AeXSj0mzoBL/doEZANNWPJCUhSUqIWlps8JM57w4YliN8Ejnz2VC9u8KTn23TwVCuWkrUCBKvB0guZs7bjjIwUdDmp1sjZDsIeNeRa75Hd7e8vLldEQ/7jAfWFi6ObyWD4tpvH3kPJekKdLaJdNsx8Yj66ES2ITPyS5eT00k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpLkx+a5; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32df5cae0b1so3893790a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 06:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758461264; x=1759066064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OitEWw+Gz/Q+VImRIz1krAC633zPmVjutn3//oeJREU=;
        b=dpLkx+a5HRjEXavGit22TBC+B2SKQLgLJOgESBWB7bbApWxrh5geWWfaE0pBeV0NOP
         4kTXPVgUf0/7Ah7ZtuX8DdmxobuWe/U+VL2iuGyMAfNNdPk0I5ApHMjdQqQ6ZjkxNqfF
         4gAYFe/H/0ig9LgwHFcHssMXufyIL7MqUY6kqTT4IFeQKwLWiieryXo6GwVjxMraC0ST
         9psf89TGUTQqHPI79XQM5rQ3vnI9zcdFxaFzLdOA0k6yxa26Ty4JfbhqlThSpDwDahGK
         B7feFpmJ6pymCFpxYupxQ9El0mmf99Z93wn/aXAGh+LZ4dXsEnob4VYO5HJyVSuDCYRW
         98vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758461264; x=1759066064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OitEWw+Gz/Q+VImRIz1krAC633zPmVjutn3//oeJREU=;
        b=c8OUKWOZQXzRQxLyOWw7xRNseKwtCqGBvTHqnynGPyeTnXbR7Jtbk5GT/x1SIFXVHq
         Kci6Q6hQvbAgseRZvwSTmOnyOFfjUa7qz834paOdClY5eZ2T05gwmmsRUGVKpDqRiaw/
         yCZr1OIXG/vD5AhwfNPooyIQ1ys7kzGxbOJQJ7o8QtjmRnihMVABo6mR85vF8izY9geY
         mNMLltl3R6VBZibD4BVAw59fcmkPdZoE4OIs2hEHI07D99bDzqR2+ZVbPBCVREvHEePo
         FK/PQ4NbWypyyg6y3Yhva6TPERVcWTKCkb/86uFMRa8AA8NqJLAJHNyKfYS7yGSc2b9T
         L3pQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/vbN3v9SnmhJ9bGT2VtyTPWPI9GYf3a+4NGAgNP+d7jQtWrCo4ZtMWJsZCL4d99pc/N2JYp8WvmvCiEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0KXmu8Ute9DkBBq5D/Mm3IqMlAekRgZTXHSMKXrZGC60J4QsE
	g+Gksa8wvzX2boeXbDGB+QEJMt/aH8LAeeHrv7JeyPtFMWSmcfBHn22h
X-Gm-Gg: ASbGncuHdO2TnRzLUugqBGu3ADpIhdWI6ZExg4JatZJFYyqf/6Zli16ufh+/Vcftui2
	KaaNVHmSd4st1GbYOSz0bmrExO1XHf7SDMIzqAnaFtSNK4NFed24hDEWgdVsRvJVJIyVZcp5pbc
	g1V+q4e+0ZcAtqK+VlkNP96TdzXLiHrg2iCTpx6EXKcD9PI38jQhMlYeXqgbSjh4ZFBBTCzobYF
	7xQqK7vqGBnVnuGpCzebzDaW/LsfSQfGNBY43qjoinbL2EADcs9epxErGVklvB6EGCWLavaVxAa
	Ao1VVWwuupBUPrs9AUBl4NT5T+O/m2CO7SAbYkDQOth1MIDDwAnRBM1J9vf8SXWrmm6px0nYDQr
	aUUmLNs1kS7++syfItGupb2Feh0oVz/b8qXu36UiVEUU0
X-Google-Smtp-Source: AGHT+IEUuqlJ7FSNOLXySDcmdLbiqAPabvyytIQHjHbBO5Vl6QGpGw/MCpjpoXAvXksxJCQcHTnIEQ==
X-Received: by 2002:a17:90b:2249:b0:32b:c5a9:7be9 with SMTP id 98e67ed59e1d1-3309835ef66mr11311226a91.25.1758461264243;
        Sun, 21 Sep 2025 06:27:44 -0700 (PDT)
Received: from gmail.com ([106.222.198.22])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f0fc4cfbcsm5550155b3a.61.2025.09.21.06.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 06:27:43 -0700 (PDT)
From: Joshua Jayasingh <joshuajayasingh08@gmail.com>
To: groeck@chromium.org
Cc: gregkh@linuxfoundation.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joshua Jayasingh <joshuajayasingh08@gmail.com>
Subject: [PATCH] Subject: [PATCH] firmware: google: Add comments to coreboot_table.c
Date: Sun, 21 Sep 2025 18:54:46 +0530
Message-ID: <20250921132446.1974-1-joshuajayasingh08@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The coreboot_table.c file contains no comments, making it difficult
for new developers to understand the logic for parsing the coreboot
tables and locating firmware entries.

This patch adds comprehensive comments throughout the file, explaining
the purpose of key functions, structs, and complex operations to improve
overall readability and maintainability.

Signed-off-by: Joshua Jayasingh <joshuajayasingh08@gmail.com>
---
 drivers/firmware/google/coreboot_table.c | 187 +++++++++++++++++++++--
 1 file changed, 177 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
index 882db32e51be..d78038bd069f 100644
--- a/drivers/firmware/google/coreboot_table.c
+++ b/drivers/firmware/google/coreboot_table.c
@@ -2,7 +2,11 @@
 /*
  * coreboot_table.c
  *
- * Module providing coreboot table access.
+ * Module providing coreboot table access. This module creates a new bus type
+ * ("coreboot") and a platform driver. The driver finds the coreboot table in
+ * memory (via ACPI or Device Tree), parses it, and creates a new device on the
+ * coreboot bus for each entry in the table. Other drivers can then register
+ * with the coreboot bus to interact with these specific entries.
  *
  * Copyright 2017 Google Inc.
  * Copyright 2017 Samuel Holland <samuel@sholland.org>
@@ -21,26 +25,52 @@
 
 #include "coreboot_table.h"
 
+/* Helper macro to get the coreboot_device from a struct device. */
 #define CB_DEV(d) container_of(d, struct coreboot_device, dev)
+/* Helper macro to get the coreboot_driver from a const struct device_driver. */
 #define CB_DRV(d) container_of_const(d, struct coreboot_driver, drv)
 
+/**
+ * coreboot_bus_match - Match a coreboot device with a coreboot driver.
+ * @dev: The coreboot device.
+ * @drv: The coreboot device driver.
+ *
+ * This function is called by the driver core to determine if a driver can
+ * handle a specific device. It iterates through the driver's ID table and
+ * compares the coreboot entry tag of the device with the tags supported by
+ * the driver.
+ *
+ * Return: 1 if the device's tag matches an ID in the driver's table,
+ * 0 otherwise.
+ */
 static int coreboot_bus_match(struct device *dev, const struct device_driver *drv)
 {
 	struct coreboot_device *device = CB_DEV(dev);
 	const struct coreboot_driver *driver = CB_DRV(drv);
 	const struct coreboot_device_id *id;
 
+	/* If the driver doesn't have an ID table, it can't match any device. */
 	if (!driver->id_table)
 		return 0;
 
+	/* Iterate over the driver's supported tags. */
 	for (id = driver->id_table; id->tag; id++) {
 		if (device->entry.tag == id->tag)
-			return 1;
+			return 1; /* Found a match. */
 	}
 
-	return 0;
+	return 0; /* No match found. */
 }
 
+/**
+ * coreboot_bus_probe - Probe a coreboot device.
+ * @dev: The coreboot device that was matched with a driver.
+ *
+ * This function is called by the driver core after a successful match.
+ * It simply calls the driver's specific probe function, if it exists.
+ *
+ * Return: 0 on success, or an error code from the driver's probe function.
+ */
 static int coreboot_bus_probe(struct device *dev)
 {
 	int ret = -ENODEV;
@@ -53,6 +83,13 @@ static int coreboot_bus_probe(struct device *dev)
 	return ret;
 }
 
+/**
+ * coreboot_bus_remove - Remove a coreboot device.
+ * @dev: The coreboot device to remove.
+ *
+ * This function is called by the driver core when the device is being removed.
+ * It calls the driver's specific remove function, if it exists.
+ */
 static void coreboot_bus_remove(struct device *dev)
 {
 	struct coreboot_device *device = CB_DEV(dev);
@@ -62,6 +99,19 @@ static void coreboot_bus_remove(struct device *dev)
 		driver->remove(device);
 }
 
+/**
+ * coreboot_bus_uevent - Generate a uevent for a coreboot device.
+ * @dev: The device for which to generate the event.
+ * @env: The uevent environment variables.
+ *
+ * This function adds a MODALIAS environment variable to the uevent.
+ * The MODALIAS is used by userspace (e.g., udev) to automatically load the
+ * appropriate driver module for this device. The alias is formatted as
+ * "coreboot:t<tag>", where <tag> is the 8-digit hexadecimal tag of the
+ * coreboot table entry.
+ *
+ * Return: 0 on success, or an error code from add_uevent_var().
+ */
 static int coreboot_bus_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
 	struct coreboot_device *device = CB_DEV(dev);
@@ -70,6 +120,10 @@ static int coreboot_bus_uevent(const struct device *dev, struct kobj_uevent_env
 	return add_uevent_var(env, "MODALIAS=coreboot:t%08X", tag);
 }
 
+/*
+ * The bus_type structure for the coreboot bus.
+ * This defines the bus's name and its core operations (match, probe, etc.).
+ */
 static const struct bus_type coreboot_bus_type = {
 	.name		= "coreboot",
 	.match		= coreboot_bus_match,
@@ -78,6 +132,14 @@ static const struct bus_type coreboot_bus_type = {
 	.uevent		= coreboot_bus_uevent,
 };
 
+/**
+ * coreboot_device_release - Release a coreboot_device structure.
+ * @dev: The device to be released.
+ *
+ * This is the release function for coreboot devices. It is called by the
+ * driver core when the last reference to the device is dropped. Its job is
+_ to free the memory allocated for the coreboot_device.
+ */
 static void coreboot_device_release(struct device *dev)
 {
 	struct coreboot_device *device = CB_DEV(dev);
@@ -85,6 +147,17 @@ static void coreboot_device_release(struct device *dev)
 	kfree(device);
 }
 
+/**
+ * __coreboot_driver_register - Register a coreboot driver.
+ * @driver: The coreboot driver to register.
+ * @owner: The module that owns this driver.
+ *
+ * A helper function to register a coreboot driver with the coreboot bus.
+ * It sets up the bus and owner fields in the driver's device_driver struct
+ * and then calls the generic driver_register function.
+ *
+ * Return: 0 on success, or an error code from driver_register().
+ */
 int __coreboot_driver_register(struct coreboot_driver *driver,
 			       struct module *owner)
 {
@@ -95,12 +168,29 @@ int __coreboot_driver_register(struct coreboot_driver *driver,
 }
 EXPORT_SYMBOL(__coreboot_driver_register);
 
+/**
+ * coreboot_driver_unregister - Unregister a coreboot driver.
+ * @driver: The coreboot driver to unregister.
+ *
+ * Unregisters the given driver from the coreboot bus.
+ */
 void coreboot_driver_unregister(struct coreboot_driver *driver)
 {
 	driver_unregister(&driver->drv);
 }
 EXPORT_SYMBOL(coreboot_driver_unregister);
 
+/**
+ * coreboot_table_populate - Parse the coreboot table and create devices.
+ * @dev: The parent device (the platform_device for the coreboot table).
+ * @ptr: A pointer to the mapped coreboot table in memory.
+ *
+ * This function iterates through all entries in the coreboot table. For each
+ * entry, it allocates a `coreboot_device`, copies the entry data into it,
+ * and registers it as a new device on the coreboot bus.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
 static int coreboot_table_populate(struct device *dev, void *ptr)
 {
 	int i, ret;
@@ -109,46 +199,70 @@ static int coreboot_table_populate(struct device *dev, void *ptr)
 	struct coreboot_table_entry *entry;
 	struct coreboot_table_header *header = ptr;
 
+	/* The first entry is located right after the header. */
 	ptr_entry = ptr + header->header_bytes;
+
+	/* Loop through all the entries specified in the header. */
 	for (i = 0; i < header->table_entries; i++) {
 		entry = ptr_entry;
 
+		/* Basic sanity check for entry size. */
 		if (entry->size < sizeof(*entry)) {
 			dev_warn(dev, "coreboot table entry too small!\n");
 			return -EINVAL;
 		}
 
-		device = kzalloc(sizeof(device->dev) + entry->size, GFP_KERNEL);
+		/* Allocate memory for our device struct and the raw entry data. */
+		device = kzalloc(sizeof(*device) + entry->size, GFP_KERNEL);
 		if (!device)
 			return -ENOMEM;
 
+		/* Initialize the generic device fields. */
 		device->dev.parent = dev;
 		device->dev.bus = &coreboot_bus_type;
 		device->dev.release = coreboot_device_release;
+		/* Copy the raw coreboot table entry data. */
 		memcpy(device->raw, ptr_entry, entry->size);
 
+		/* Set a descriptive device name based on the entry tag. */
 		switch (device->entry.tag) {
 		case LB_TAG_CBMEM_ENTRY:
+			/* CBMEM entries have a specific ID we can use for a unique name. */
 			dev_set_name(&device->dev, "cbmem-%08x",
 				     device->cbmem_entry.id);
 			break;
 		default:
+			/* For other entries, just use a generic numbered name. */
 			dev_set_name(&device->dev, "coreboot%d", i);
 			break;
 		}
 
+		/* Register the new device with the driver core. */
 		ret = device_register(&device->dev);
 		if (ret) {
-			put_device(&device->dev);
+			/* If registration fails, clean up and bail out. */
+			put_device(&device->dev); /* This will trigger release */
 			return ret;
 		}
 
+		/* Move to the next entry in the table. */
 		ptr_entry += entry->size;
 	}
 
 	return 0;
 }
 
+/**
+ * coreboot_table_probe - Probe function for the coreboot platform driver.
+ * @pdev: The platform device.
+ *
+ * This function is called when the platform bus finds a device that matches
+ * this driver (e.g., via ACPI or Device Tree). It locates the coreboot table
+ * in memory, verifies its signature, and then calls coreboot_table_populate()
+ * to create devices for each entry.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
 static int coreboot_table_probe(struct platform_device *pdev)
 {
 	resource_size_t len;
@@ -158,6 +272,7 @@ static int coreboot_table_probe(struct platform_device *pdev)
 	void *ptr;
 	int ret;
 
+	/* Get the memory region containing the coreboot table. */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -EINVAL;
@@ -166,51 +281,81 @@ static int coreboot_table_probe(struct platform_device *pdev)
 	if (!res->start || !len)
 		return -EINVAL;
 
-	/* Check just the header first to make sure things are sane */
+	/*
+	 * First, map only the header to perform a sanity check. This avoids
+	 * mapping a potentially huge and invalid memory region.
+	 */
 	header = memremap(res->start, sizeof(*header), MEMREMAP_WB);
 	if (!header)
 		return -ENOMEM;
 
-	len = header->header_bytes + header->table_bytes;
+	/* Verify the "LBIO" signature. */
 	ret = strncmp(header->signature, "LBIO", sizeof(header->signature));
-	memunmap(header);
 	if (ret) {
 		dev_warn(dev, "coreboot table missing or corrupt!\n");
+		memunmap(header);
 		return -ENODEV;
 	}
 
+	/* Get the full table size from the header. */
+	len = header->header_bytes + header->table_bytes;
+	memunmap(header);
+
+	/* Now map the entire coreboot table. */
 	ptr = memremap(res->start, len, MEMREMAP_WB);
 	if (!ptr)
 		return -ENOMEM;
 
+	/* Populate the bus with devices from the table entries. */
 	ret = coreboot_table_populate(dev, ptr);
 
+	/* Unmap the memory region as it's no longer needed. */
 	memunmap(ptr);
 
 	return ret;
 }
 
+/**
+ * __cb_dev_unregister - Helper function to unregister a device.
+ * @dev: The device to unregister.
+ * @dummy: Unused data pointer (required by bus_for_each_dev).
+ *
+ * This function is used as a callback for bus_for_each_dev to unregister
+ * a single device.
+ *
+ * Return: Always 0.
+ */
 static int __cb_dev_unregister(struct device *dev, void *dummy)
 {
 	device_unregister(dev);
 	return 0;
 }
 
+/**
+ * coreboot_table_remove - Remove function for the coreboot platform driver.
+ * @pdev: The platform device.
+ *
+ * This function is called when the platform device is being removed. It
+ * cleans up by iterating over all devices on the coreboot bus and
+ * unregistering them.
+ */
 static void coreboot_table_remove(struct platform_device *pdev)
 {
 	bus_for_each_dev(&coreboot_bus_type, NULL, NULL, __cb_dev_unregister);
 }
 
 #ifdef CONFIG_ACPI
+/* ACPI device IDs that this platform driver can bind to. */
 static const struct acpi_device_id cros_coreboot_acpi_match[] = {
-	{ "GOOGCB00", 0 },
-	{ "BOOT0000", 0 },
+	{ "GOOGCB00", 0 }, /* Google Coreboot device */
+	{ "BOOT0000", 0 }, /* Coreboot device on older systems */
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, cros_coreboot_acpi_match);
 #endif
 
 #ifdef CONFIG_OF
+/* Device Tree compatible strings that this platform driver can bind to. */
 static const struct of_device_id coreboot_of_match[] = {
 	{ .compatible = "coreboot" },
 	{}
@@ -218,26 +363,40 @@ static const struct of_device_id coreboot_of_match[] = {
 MODULE_DEVICE_TABLE(of, coreboot_of_match);
 #endif
 
+/* The platform_driver structure for the main coreboot table driver. */
 static struct platform_driver coreboot_table_driver = {
 	.probe = coreboot_table_probe,
 	.remove = coreboot_table_remove,
 	.driver = {
 		.name = "coreboot_table",
+		/* Link the ACPI and Device Tree match tables. */
 		.acpi_match_table = ACPI_PTR(cros_coreboot_acpi_match),
 		.of_match_table = of_match_ptr(coreboot_of_match),
 	},
 };
 
+/**
+ * coreboot_table_driver_init - Module initialization function.
+ *
+ * This function is called when the module is loaded. It registers the
+ * coreboot bus type and then registers the platform driver that finds
+ * and parses the coreboot table.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
 static int __init coreboot_table_driver_init(void)
 {
 	int ret;
 
+	/* First, register our new bus type with the kernel. */
 	ret = bus_register(&coreboot_bus_type);
 	if (ret)
 		return ret;
 
+	/* Then, register the platform driver. */
 	ret = platform_driver_register(&coreboot_table_driver);
 	if (ret) {
+		/* If driver registration fails, unregister the bus. */
 		bus_unregister(&coreboot_bus_type);
 		return ret;
 	}
@@ -245,15 +404,23 @@ static int __init coreboot_table_driver_init(void)
 	return 0;
 }
 
+/**
+ * coreboot_table_driver_exit - Module exit function.
+ *
+ * This function is called when the module is unloaded. It unregisters the
+ * platform driver and the coreboot bus type, cleaning up all resources.
+ */
 static void __exit coreboot_table_driver_exit(void)
 {
 	platform_driver_unregister(&coreboot_table_driver);
 	bus_unregister(&coreboot_bus_type);
 }
 
+/* Register the init and exit functions. */
 module_init(coreboot_table_driver_init);
 module_exit(coreboot_table_driver_exit);
 
+/* Standard module information. */
 MODULE_AUTHOR("Google, Inc.");
 MODULE_DESCRIPTION("Module providing coreboot table access");
 MODULE_LICENSE("GPL");
-- 
2.51.0.windows.1


