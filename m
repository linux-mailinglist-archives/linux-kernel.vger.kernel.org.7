Return-Path: <linux-kernel+bounces-745854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 878F8B11FA7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18AA818901C4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68191C8FBA;
	Fri, 25 Jul 2025 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKBTVhP4"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE6D2E36EC;
	Fri, 25 Jul 2025 13:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753451714; cv=none; b=MuXCYVs+9SPdUykVUidlrgfQQx0BOPFUuzK82Pvi8QzsJcwJJ2V90OKIe+DNLqB8PkF61YZN+UjCvcLuH89qldpfviVWl8weWuPqn9mbzEeHtJXY5rJb23Ab+4RJuzgmF1FhtIi/KDl7ougJBTgVRwV4YQhwAwW7NFerglM4hFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753451714; c=relaxed/simple;
	bh=1QGaiJuXGooJbjDTXt8uTgaAYzOPuDwwDL5PCOM4O+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HilI0sm/wFCE/SzozI5tQWJHRhjb+Y5M9/r/fMreCk47Yfuriu2W9K4c/Q/IvWNyOPrF4CUqh+V1bnXLJyZFG9BLvt2w7gAWM0A3EzBF3OfsJJz+Cb0cg1BzDyGIgSuM2qpCP5tRxZYIe4Kv/1Kugtc9NWBlXZHsr+RVuS9MZbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKBTVhP4; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-311e2cc157bso1945517a91.2;
        Fri, 25 Jul 2025 06:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753451710; x=1754056510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WNTDfjxhZB9Hjmc5HFtSd7mAOD+kVA3++KbmQ5chN8w=;
        b=NKBTVhP4SBzimb3WBJC65IOvMpPP+w5EyZQisXfXWSPykdlPealfGOwLPlzSOCnDAm
         pP7UjqtXVsv/vwHTr+QY3amMn7M3KWd/lufZSmqlHS067V6l/3vwwA3ISErWEPag9WaU
         UwND+0lMTcw4XTl0IcaZj4ixFgisatlRTf/D7bzyjk8xmvmgN6r29rmiiHrJnUi7DNZk
         yd8RvFOE90KiGsYibiqnEP0F1ZgxolusvkfdXep7PEJhIOYgJNq6NubIu0yUPIq8scLT
         iMmxw9GXPxZe9IvAD1Vv/RG0DMTldLZ4SeIfmInuS8n+zrRkjOZCI93NGWZPUOFAdZuF
         mS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753451710; x=1754056510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WNTDfjxhZB9Hjmc5HFtSd7mAOD+kVA3++KbmQ5chN8w=;
        b=VVX+HhpfO/qMcuF8peGeRIcisVRzjIMJ1Z3Eop6HQYE5H+BtrZ0q67vDknnxczxmWB
         jGTHWjFlshMl7aZFE/jFSnivEfRfhDfyR0MxtrjJXy+MxZ55UragSYI1bdpO+gpWa6er
         mopksf7QqetJ3vr0VWjEKIkg5XZWc/XTamyYFhX1gI/NRrHcKwD6Lbu+njvlIVhB89eb
         1tnBVivsL+jyQmbzaSgs9XauGWK532MLohbIPaHERteGYeZXOLAcj8HMPB6U8tiv06dh
         i2WRI9k2fQ6WQIE+rlpSSR+bLW+2DI9/QnXs3vNH390YEgvijqjXWp9J8t6Mah1p8YqZ
         B1ww==
X-Forwarded-Encrypted: i=1; AJvYcCVR5VxL7g5F1bYm+mdrmvr78vQZmpKlTQtVQG0XrgyUBP3+YGd2HSSMx0vxGc8WAqYOU4dXucrzbdzF@vger.kernel.org, AJvYcCWnyDSUAjq5wr3Ovm1/XNPC1qSyboRKn2deBWlxPWJyI/zlsOukv3U1zj/u41FS7ef6wXeE+UB3TG+dB7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6vJb3/OMLcdnmYut6frzkCHYIqAIrxGIRPdHDtpxkE9mobSjH
	CmK4AAfCs994s5cxTn73my0rn7KeMvVV6hI63SDnAbg3FB4Qd4sekxEusMH0khAt
X-Gm-Gg: ASbGncu6/CspKKAqD8wh4uJrOhuRcxmwoIlNS/QMtZIdRLL/oRSGRKMy8A4x7sMNtNF
	hfJo6BgEm6yAs4KrDawlCfgtBdInChufYKHZm1dQ85vvLG+mLOugOmUO9pkbjSgFMhnTd63kOY0
	khykRpzBdQOsqjdaWwP8Vrp2g92hTeJut8oPX2r4sD+h/K1PgjWG29UTM4ZXXWmTIf9JEvu7jCU
	mSx0wvIUDBrNa9cHyvCW8yiW6hOJ6Bs3UQ+eGF7C3qY1BNY4algEDWJRVBH2fbSp/flZAsLje9I
	U2/IP+f2ifK86AreKzUUesHESyGKoSU1tQytXmk8DNMBA/k8du6Fn6/JsSe06ArpBTmO5WMz5+m
	MGBid+AelYc5W0M95hvwsfa+2Ioa6LJQIe81MKfhFvgHQY75US/Hr6GTz3u2CazqhEWDruwrQp6
	lx7w==
X-Google-Smtp-Source: AGHT+IHPMuDw156nJnJs5OgyJZThkk3pLHkyqwdIWaDAQFK8CUMKxMGvzXSy8IV1gB0tySPdyAa+hg==
X-Received: by 2002:a17:90a:fc4e:b0:313:d79d:87eb with SMTP id 98e67ed59e1d1-31e77a32a33mr3207824a91.35.1753451710127;
        Fri, 25 Jul 2025 06:55:10 -0700 (PDT)
Received: from SIQOL-WIN-0002-DARSHAN.localdomain ([49.36.70.207])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e63a766d9sm2797962a91.2.2025.07.25.06.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 06:55:09 -0700 (PDT)
From: "Darshan R." <rathod.darshan.0896@gmail.com>
To: stern@rowland.harvard.edu
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org,
	"Darshan R." <rathod.darshan.0896@gmail.com>
Subject: [PATCH] usb: storage: Checkpatch fix done and Clean up coding style
Date: Fri, 25 Jul 2025 13:55:33 +0000
Message-ID: <20250725135533.8410-1-rathod.darshan.0896@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The shuttle_usbat.c driver has several coding style inconsistencies that deviate from the Linux kernel standard.
This makes the code harder to read and maintain.

This patch is a pure cleanup effort to address these style issues.
The changes include:

- Adding proper spacing around operators (=, *, +, !=, etc.).
- Adjusting pointer declarations to the standard type *var style.
- Fixing spacing in pointer casts, e.g., (struct usbat_info *).
- Removing the redundant = 0 initializer for the static transferred
  variable, as it's guaranteed to be zero-initialized.
- Tidying up miscellaneous whitespace and removing extra blank lines.

These changes were guided by checkpatch.pl.
No functional changes have been made.

Signed-off-by: Darshan R. <rathod.darshan.0896@gmail.com>
---
 drivers/usb/storage/shuttle_usbat.c | 252 +++++++++++++---------------
 1 file changed, 120 insertions(+), 132 deletions(-)

diff --git a/drivers/usb/storage/shuttle_usbat.c b/drivers/usb/storage/shuttle_usbat.c
index 27faa0ead11d..d4a5ad500886 100644
--- a/drivers/usb/storage/shuttle_usbat.c
+++ b/drivers/usb/storage/shuttle_usbat.c
@@ -16,7 +16,7 @@
  * market by using some kind of translation from ATAPI to USB on the host,
  * and the peripheral would translate from USB back to ATAPI.
  *
- * SCM Microsystems (www.scmmicro.com) makes a device, sold to OEM's only, 
+ * SCM Microsystems (www.scmmicro.com) makes a device, sold to OEM's only,
  * which does the USB-to-ATAPI conversion.  By obtaining the data sheet on
  * their device under nondisclosure agreement, I have been able to write
  * this driver for Linux.
@@ -141,19 +141,18 @@ struct usbat_info {
 	unsigned long sense_ascq;  /* additional sense code qualifier */
 };
 
-#define short_pack(LSB,MSB) ( ((u16)(LSB)) | ( ((u16)(MSB))<<8 ) )
-#define LSB_of(s) ((s)&0xFF)
-#define MSB_of(s) ((s)>>8)
+#define short_pack(LSB, MSB) (((u16)(LSB)) | (((u16)(MSB)) << 8))
+#define LSB_of(s) ((s) & 0xFF)
+#define MSB_of(s) ((s) >> 8)
 
-static int transferred = 0;
+static int transferred;
 
-static int usbat_flash_transport(struct scsi_cmnd * srb, struct us_data *us);
+static int usbat_flash_transport(struct scsi_cmnd *srb, struct us_data *us);
 static int usbat_hp8200e_transport(struct scsi_cmnd *srb, struct us_data *us);
 
 static int init_usbat_cd(struct us_data *us);
 static int init_usbat_flash(struct us_data *us);
 
-
 /*
  * The table of devices
  */
@@ -214,7 +213,7 @@ static void usbat_pack_ata_sector_cmd(unsigned char *buf,
  */
 static int usbat_get_device_type(struct us_data *us)
 {
-	return ((struct usbat_info*)us->extra)->devicetype;
+	return ((struct usbat_info *)us->extra)->devicetype;
 }
 
 /*
@@ -257,7 +256,7 @@ static int usbat_write(struct us_data *us,
  * Convenience function to perform a bulk read
  */
 static int usbat_bulk_read(struct us_data *us,
-			   void* buf,
+			   void *buf,
 			   unsigned int len,
 			   int use_sg)
 {
@@ -272,7 +271,7 @@ static int usbat_bulk_read(struct us_data *us,
  * Convenience function to perform a bulk write
  */
 static int usbat_bulk_write(struct us_data *us,
-			    void* buf,
+			    void *buf,
 			    unsigned int len,
 			    int use_sg)
 {
@@ -303,6 +302,7 @@ static int usbat_execute_command(struct us_data *us,
 static int usbat_get_status(struct us_data *us, unsigned char *status)
 {
 	int rc;
+
 	rc = usbat_read(us, USBAT_ATA, USBAT_ATA_STATUS, status);
 
 	usb_stor_dbg(us, "0x%02X\n", *status);
@@ -405,11 +405,10 @@ static int usbat_wait_not_busy(struct us_data *us, int minutes)
 	 * minutes!
 	 */
 
-	for (i=0; i<1200+minutes*60; i++) {
-
- 		result = usbat_get_status(us, status);
+	for (i = 0; i < 1200 + minutes * 60; i++) {
+		result = usbat_get_status(us, status);
 
-		if (result!=USB_STOR_XFER_GOOD)
+		if (result != USB_STOR_XFER_GOOD)
 			return USB_STOR_TRANSPORT_ERROR;
 		if (*status & 0x01) { /* check condition */
 			result = usbat_read(us, USBAT_ATA, 0x10, status);
@@ -418,16 +417,16 @@ static int usbat_wait_not_busy(struct us_data *us, int minutes)
 		if (*status & 0x20) /* device fault */
 			return USB_STOR_TRANSPORT_FAILED;
 
-		if ((*status & 0x80)==0x00) { /* not busy */
+		if ((*status & 0x80) == 0x00) { /* not busy */
 			usb_stor_dbg(us, "Waited not busy for %d steps\n", i);
 			return USB_STOR_TRANSPORT_GOOD;
 		}
 
-		if (i<500)
+		if (i < 500)
 			msleep(10); /* 5 seconds */
-		else if (i<700)
+		else if (i < 700)
 			msleep(50); /* 10 seconds */
-		else if (i<1200)
+		else if (i < 1200)
 			msleep(100); /* 50 seconds */
 		else
 			msleep(1000); /* X minutes */
@@ -442,7 +441,7 @@ static int usbat_wait_not_busy(struct us_data *us, int minutes)
  * Read block data from the data register
  */
 static int usbat_read_block(struct us_data *us,
-			    void* buf,
+			    void *buf,
 			    unsigned short len,
 			    int use_sg)
 {
@@ -475,7 +474,7 @@ static int usbat_read_block(struct us_data *us,
  */
 static int usbat_write_block(struct us_data *us,
 			     unsigned char access,
-			     void* buf,
+			     void *buf,
 			     unsigned short len,
 			     int minutes,
 			     int use_sg)
@@ -535,22 +534,21 @@ static int usbat_hp8200e_rw_block_test(struct us_data *us,
 	unsigned char *data = us->iobuf;
 	unsigned char *status = us->iobuf;
 
-	BUG_ON(num_registers > US_IOBUF_SIZE/2);
-
-	for (i=0; i<20; i++) {
+	BUG_ON(num_registers > US_IOBUF_SIZE / 2);
 
+	for (i = 0; i < 20; i++) {
 		/*
 		 * The first time we send the full command, which consists
 		 * of downloading the SCSI command followed by downloading
 		 * the data via a write-and-test.  Any other time we only
 		 * send the command to download the data -- the SCSI command
 		 * is still 'active' in some sense in the device.
-		 * 
+		 *
 		 * We're only going to try sending the data 10 times. After
 		 * that, we just return a failure.
 		 */
 
-		if (i==0) {
+		if (i == 0) {
 			cmdlen = 16;
 			/*
 			 * Write to multiple registers
@@ -564,39 +562,37 @@ static int usbat_hp8200e_rw_block_test(struct us_data *us,
 			command[3] = 0x17;
 			command[4] = 0xFC;
 			command[5] = 0xE7;
-			command[6] = LSB_of(num_registers*2);
-			command[7] = MSB_of(num_registers*2);
+			command[6] = LSB_of(num_registers * 2);
+			command[7] = MSB_of(num_registers * 2);
 		} else
 			cmdlen = 8;
 
 		/* Conditionally read or write blocks */
-		command[cmdlen-8] = (direction==DMA_TO_DEVICE ? 0x40 : 0xC0);
-		command[cmdlen-7] = access |
-				(direction==DMA_TO_DEVICE ?
+		command[cmdlen - 8] = (direction == DMA_TO_DEVICE ? 0x40 : 0xC0);
+		command[cmdlen - 7] = access |
+				(direction == DMA_TO_DEVICE ?
 				 USBAT_CMD_COND_WRITE_BLOCK : USBAT_CMD_COND_READ_BLOCK);
-		command[cmdlen-6] = data_reg;
-		command[cmdlen-5] = status_reg;
-		command[cmdlen-4] = timeout;
-		command[cmdlen-3] = qualifier;
-		command[cmdlen-2] = LSB_of(len);
-		command[cmdlen-1] = MSB_of(len);
+		command[cmdlen - 6] = data_reg;
+		command[cmdlen - 5] = status_reg;
+		command[cmdlen - 4] = timeout;
+		command[cmdlen - 3] = qualifier;
+		command[cmdlen - 2] = LSB_of(len);
+		command[cmdlen - 1] = MSB_of(len);
 
 		result = usbat_execute_command(us, command, cmdlen);
 
 		if (result != USB_STOR_XFER_GOOD)
 			return USB_STOR_TRANSPORT_ERROR;
 
-		if (i==0) {
-
-			for (j=0; j<num_registers; j++) {
-				data[j<<1] = registers[j];
-				data[1+(j<<1)] = data_out[j];
+		if (i == 0) {
+			for (j = 0; j < num_registers; j++) {
+				data[j << 1] = registers[j];
+				data[1 + (j << 1)] = data_out[j];
 			}
 
 			result = usbat_bulk_write(us, data, num_registers*2, 0);
 			if (result != USB_STOR_XFER_GOOD)
 				return USB_STOR_TRANSPORT_ERROR;
-
 		}
 
 		result = usb_stor_bulk_transfer_sg(us,
@@ -629,7 +625,7 @@ static int usbat_hp8200e_rw_block_test(struct us_data *us,
 			 * the bulk output pipe only the first time.
 			 */
 
-			if (direction==DMA_FROM_DEVICE && i==0) {
+			if (direction == DMA_FROM_DEVICE && i == 0) {
 				if (usb_stor_clear_halt(us,
 						us->send_bulk_pipe) < 0)
 					return USB_STOR_TRANSPORT_ERROR;
@@ -639,12 +635,12 @@ static int usbat_hp8200e_rw_block_test(struct us_data *us,
 			 * Read status: is the device angry, or just busy?
 			 */
 
- 			result = usbat_read(us, USBAT_ATA, 
-				direction==DMA_TO_DEVICE ?
+			result = usbat_read(us, USBAT_ATA,
+				direction == DMA_TO_DEVICE ?
 					USBAT_ATA_STATUS : USBAT_ATA_ALTSTATUS,
 				status);
 
-			if (result!=USB_STOR_XFER_GOOD)
+			if (result != USB_STOR_XFER_GOOD)
 				return USB_STOR_TRANSPORT_ERROR;
 			if (*status & 0x01) /* check condition */
 				return USB_STOR_TRANSPORT_FAILED;
@@ -683,7 +679,7 @@ static int usbat_multiple_write(struct us_data *us,
 	unsigned char *data = us->iobuf;
 	unsigned char *command = us->iobuf;
 
-	BUG_ON(num_registers > US_IOBUF_SIZE/2);
+	BUG_ON(num_registers > US_IOBUF_SIZE / 2);
 
 	/* Write to multiple registers, ATA access */
 	command[0] = 0x40;
@@ -696,8 +692,8 @@ static int usbat_multiple_write(struct us_data *us,
 	command[5] = 0;
 
 	/* Number of bytes to be transferred (incl. addresses and data) */
-	command[6] = LSB_of(num_registers*2);
-	command[7] = MSB_of(num_registers*2);
+	command[6] = LSB_of(num_registers * 2);
+	command[7] = MSB_of(num_registers * 2);
 
 	/* The setup command */
 	result = usbat_execute_command(us, command, 8);
@@ -705,13 +701,13 @@ static int usbat_multiple_write(struct us_data *us,
 		return USB_STOR_TRANSPORT_ERROR;
 
 	/* Create the reg/data, reg/data sequence */
-	for (i=0; i<num_registers; i++) {
-		data[i<<1] = registers[i];
-		data[1+(i<<1)] = data_out[i];
+	for (i = 0; i < num_registers; i++) {
+		data[i << 1] = registers[i];
+		data[1 + (i << 1)] = data_out[i];
 	}
 
 	/* Send the data */
-	result = usbat_bulk_write(us, data, num_registers*2, 0);
+	result = usbat_bulk_write(us, data, num_registers * 2, 0);
 	if (result != USB_STOR_XFER_GOOD)
 		return USB_STOR_TRANSPORT_ERROR;
 
@@ -734,7 +730,7 @@ static int usbat_multiple_write(struct us_data *us,
  * other related details) are defined beforehand with _set_shuttle_features().
  */
 static int usbat_read_blocks(struct us_data *us,
-			     void* buffer,
+			     void *buffer,
 			     int len,
 			     int use_sg)
 {
@@ -754,7 +750,7 @@ static int usbat_read_blocks(struct us_data *us,
 	result = usbat_execute_command(us, command, 8);
 	if (result != USB_STOR_XFER_GOOD)
 		return USB_STOR_TRANSPORT_FAILED;
-	
+
 	/* Read the blocks we just asked for */
 	result = usbat_bulk_read(us, buffer, len, use_sg);
 	if (result != USB_STOR_XFER_GOOD)
@@ -776,7 +772,7 @@ static int usbat_read_blocks(struct us_data *us,
  * other related details) are defined beforehand with _set_shuttle_features().
  */
 static int usbat_write_blocks(struct us_data *us,
-			      void* buffer,
+			      void *buffer,
 			      int len,
 			      int use_sg)
 {
@@ -796,7 +792,7 @@ static int usbat_write_blocks(struct us_data *us,
 	result = usbat_execute_command(us, command, 8);
 	if (result != USB_STOR_XFER_GOOD)
 		return USB_STOR_TRANSPORT_FAILED;
-	
+
 	/* Write the data */
 	result = usbat_bulk_write(us, buffer, len, use_sg);
 	if (result != USB_STOR_XFER_GOOD)
@@ -860,7 +856,7 @@ static int usbat_device_reset(struct us_data *us)
 							 USBAT_UIO_EPAD | USBAT_UIO_1);
 	if (rc != USB_STOR_XFER_GOOD)
 		return USB_STOR_TRANSPORT_ERROR;
-			
+
 	/*
 	 * Enable peripheral control signals
 	 * (bring reset signal down)
@@ -958,7 +954,7 @@ static int usbat_flash_check_media(struct us_data *us,
 		rc = usbat_read_user_io(us, uio);
 		if (rc != USB_STOR_XFER_GOOD)
 			return USB_STOR_TRANSPORT_ERROR;
-		
+
 		info->sense_key = UNIT_ATTENTION;
 		info->sense_asc = 0x28;
 		info->sense_ascq = 0x00;
@@ -994,12 +990,12 @@ static int usbat_identify_device(struct us_data *us,
 	 * CDROM drives), it should succeed.
 	 */
 	rc = usbat_write(us, USBAT_ATA, USBAT_ATA_CMD, 0xA1);
- 	if (rc != USB_STOR_XFER_GOOD)
- 		return USB_STOR_TRANSPORT_ERROR;
+	if (rc != USB_STOR_XFER_GOOD)
+		return USB_STOR_TRANSPORT_ERROR;
 
 	rc = usbat_get_status(us, &status);
- 	if (rc != USB_STOR_XFER_GOOD)
- 		return USB_STOR_TRANSPORT_ERROR;
+	if (rc != USB_STOR_XFER_GOOD)
+		return USB_STOR_TRANSPORT_ERROR;
 
 	/* Check for error bit, or if the command 'fell through' */
 	if (status == 0xA1 || !(status & 0x01)) {
@@ -1092,7 +1088,7 @@ static int usbat_flash_get_sector_count(struct us_data *us,
 	info->sectors = ((u32)(reply[117]) << 24) |
 		((u32)(reply[116]) << 16) |
 		((u32)(reply[115]) <<  8) |
-		((u32)(reply[114])      );
+		((u32)(reply[114]));
 
 	rc = USB_STOR_TRANSPORT_GOOD;
 
@@ -1160,7 +1156,7 @@ static int usbat_flash_read_data(struct us_data *us,
 		 */
 		len = min(totallen, alloclen);
 		thistime = (len / info->ssize) & 0xff;
- 
+
 		/* ATA command 0x20 (READ SECTORS) */
 		usbat_pack_ata_sector_cmd(command, thistime, sector, 0x20);
 
@@ -1173,9 +1169,9 @@ static int usbat_flash_read_data(struct us_data *us,
 		result = usbat_read_blocks(us, buffer, len, 0);
 		if (result != USB_STOR_TRANSPORT_GOOD)
 			goto leave;
-  	 
+
 		usb_stor_dbg(us, "%d bytes\n", len);
-	
+
 		/* Store the data in the transfer buffer */
 		usb_stor_access_xfer_buf(buffer, len, us->srb,
 					 &sg, &sg_offset, TO_XFER_BUF);
@@ -1301,7 +1297,7 @@ static int usbat_hp8200e_handle_read10(struct us_data *us,
 
 	if (scsi_bufflen(srb) < 0x10000) {
 
-		result = usbat_hp8200e_rw_block_test(us, USBAT_ATA, 
+		result = usbat_hp8200e_rw_block_test(us, USBAT_ATA,
 			registers, data, 19,
 			USBAT_ATA_DATA, USBAT_ATA_STATUS, 0xFD,
 			(USBAT_QUAL_FCQ | USBAT_QUAL_ALQ),
@@ -1320,10 +1316,10 @@ static int usbat_hp8200e_handle_read10(struct us_data *us,
 	 * (see linux/drivers/scsi/sr.c).
 	 */
 
-	if (data[7+0] == GPCMD_READ_CD) {
-		len = short_pack(data[7+9], data[7+8]);
+	if (data[7 + 0] == GPCMD_READ_CD) {
+		len = short_pack(data[7 + 9], data[7 + 8]);
 		len <<= 16;
-		len |= data[7+7];
+		len |= data[7 + 7];
 		usb_stor_dbg(us, "GPCMD_READ_CD: len %d\n", len);
 		srb->transfersize = scsi_bufflen(srb)/len;
 	}
@@ -1340,15 +1336,15 @@ static int usbat_hp8200e_handle_read10(struct us_data *us,
 	 * bounce buffer and the actual transfer buffer.
 	 */
 
-	len = (65535/srb->transfersize) * srb->transfersize;
+	len = (65535 / srb->transfersize) * srb->transfersize;
 	usb_stor_dbg(us, "Max read is %d bytes\n", len);
 	len = min(len, scsi_bufflen(srb));
 	buffer = kmalloc(len, GFP_NOIO);
 	if (buffer == NULL) /* bloody hell! */
 		return USB_STOR_TRANSPORT_FAILED;
-	sector = short_pack(data[7+3], data[7+2]);
+	sector = short_pack(data[7 + 3], data[7 + 2]);
 	sector <<= 16;
-	sector |= short_pack(data[7+5], data[7+4]);
+	sector |= short_pack(data[7 + 5], data[7 + 4]);
 	transferred = 0;
 
 	while (transferred != scsi_bufflen(srb)) {
@@ -1356,27 +1352,26 @@ static int usbat_hp8200e_handle_read10(struct us_data *us,
 		if (len > scsi_bufflen(srb) - transferred)
 			len = scsi_bufflen(srb) - transferred;
 
-		data[3] = len&0xFF; 	  /* (cylL) = expected length (L) */
-		data[4] = (len>>8)&0xFF;  /* (cylH) = expected length (H) */
+		data[3] = len & 0xFF;	/* (cylL) = expected length (L) */
+		data[4] = (len >> 8) & 0xFF;	/* (cylH) = expected length (H) */
 
 		/* Fix up the SCSI command sector and num sectors */
 
-		data[7+2] = MSB_of(sector>>16); /* SCSI command sector */
-		data[7+3] = LSB_of(sector>>16);
-		data[7+4] = MSB_of(sector&0xFFFF);
-		data[7+5] = LSB_of(sector&0xFFFF);
-		if (data[7+0] == GPCMD_READ_CD)
-			data[7+6] = 0;
-		data[7+7] = MSB_of(len / srb->transfersize); /* SCSI command */
-		data[7+8] = LSB_of(len / srb->transfersize); /* num sectors */
-
-		result = usbat_hp8200e_rw_block_test(us, USBAT_ATA, 
-			registers, data, 19,
-			USBAT_ATA_DATA, USBAT_ATA_STATUS, 0xFD, 
-			(USBAT_QUAL_FCQ | USBAT_QUAL_ALQ),
-			DMA_FROM_DEVICE,
-			buffer,
-			len, 0, 1);
+		data[7 + 2] = MSB_of(sector >> 16); /* SCSI command sector */
+		data[7 + 3] = LSB_of(sector >> 16);
+		data[7 + 4] = MSB_of(sector & 0xFFFF);
+		data[7 + 5] = LSB_of(sector & 0xFFFF);
+		if (data[7 + 0] == GPCMD_READ_CD)
+			data[7 + 6] = 0;
+		data[7 + 7] = MSB_of(len / srb->transfersize); /* SCSI command */
+		data[7 + 8] = LSB_of(len / srb->transfersize); /* num sectors */
+
+		result = usbat_hp8200e_rw_block_test(us, USBAT_ATA,
+				registers, data, 19,
+				USBAT_ATA_DATA, USBAT_ATA_STATUS, 0xFD,
+				(USBAT_QUAL_FCQ | USBAT_QUAL_ALQ),
+				DMA_FROM_DEVICE,
+				buffer, len, 0, 1);
 
 		if (result != USB_STOR_TRANSPORT_GOOD)
 			break;
@@ -1407,35 +1402,35 @@ static int usbat_select_and_test_registers(struct us_data *us)
 				USB_STOR_XFER_GOOD)
 			return USB_STOR_TRANSPORT_ERROR;
 
-		if (usbat_read(us, USBAT_ATA, USBAT_ATA_STATUS, status) != 
+		if (usbat_read(us, USBAT_ATA, USBAT_ATA_STATUS, status) !=
 				USB_STOR_XFER_GOOD)
 			return USB_STOR_TRANSPORT_ERROR;
 
-		if (usbat_read(us, USBAT_ATA, USBAT_ATA_DEVICE, status) != 
+		if (usbat_read(us, USBAT_ATA, USBAT_ATA_DEVICE, status) !=
 				USB_STOR_XFER_GOOD)
 			return USB_STOR_TRANSPORT_ERROR;
 
-		if (usbat_read(us, USBAT_ATA, USBAT_ATA_LBA_ME, status) != 
+		if (usbat_read(us, USBAT_ATA, USBAT_ATA_LBA_ME, status) !=
 				USB_STOR_XFER_GOOD)
 			return USB_STOR_TRANSPORT_ERROR;
 
-		if (usbat_read(us, USBAT_ATA, USBAT_ATA_LBA_HI, status) != 
+		if (usbat_read(us, USBAT_ATA, USBAT_ATA_LBA_HI, status) !=
 				USB_STOR_XFER_GOOD)
 			return USB_STOR_TRANSPORT_ERROR;
 
-		if (usbat_write(us, USBAT_ATA, USBAT_ATA_LBA_ME, 0x55) != 
+		if (usbat_write(us, USBAT_ATA, USBAT_ATA_LBA_ME, 0x55) !=
 				USB_STOR_XFER_GOOD)
 			return USB_STOR_TRANSPORT_ERROR;
 
-		if (usbat_write(us, USBAT_ATA, USBAT_ATA_LBA_HI, 0xAA) != 
+		if (usbat_write(us, USBAT_ATA, USBAT_ATA_LBA_HI, 0xAA) !=
 				USB_STOR_XFER_GOOD)
 			return USB_STOR_TRANSPORT_ERROR;
 
-		if (usbat_read(us, USBAT_ATA, USBAT_ATA_LBA_ME, status) != 
+		if (usbat_read(us, USBAT_ATA, USBAT_ATA_LBA_ME, status) !=
 				USB_STOR_XFER_GOOD)
 			return USB_STOR_TRANSPORT_ERROR;
 
-		if (usbat_read(us, USBAT_ATA, USBAT_ATA_LBA_ME, status) != 
+		if (usbat_read(us, USBAT_ATA, USBAT_ATA_LBA_ME, status) !=
 				USB_STOR_XFER_GOOD)
 			return USB_STOR_TRANSPORT_ERROR;
 	}
@@ -1458,7 +1453,7 @@ static int init_usbat(struct us_data *us, int devicetype)
 	if (!us->extra)
 		return -ENOMEM;
 
-	info = (struct usbat_info *) (us->extra);
+	info = (struct usbat_info *)(us->extra);
 
 	/* Enable peripheral control signals */
 	rc = usbat_write_user_io(us,
@@ -1532,7 +1527,7 @@ static int init_usbat(struct us_data *us, int devicetype)
 
 	usb_stor_dbg(us, "INIT 10\n");
 
-	if (usbat_get_device_type(us) == USBAT_DEV_FLASH) { 
+	if (usbat_get_device_type(us) == USBAT_DEV_FLASH) {
 		subcountH = 0x02;
 		subcountL = 0x00;
 	}
@@ -1564,7 +1559,7 @@ static int usbat_hp8200e_transport(struct scsi_cmnd *srb, struct us_data *us)
 	 * Send A0 (ATA PACKET COMMAND).
 	 * Note: I guess we're never going to get any of the ATA
 	 * commands... just ATA Packet Commands.
- 	 */
+	 */
 
 	registers[0] = USBAT_ATA_FEATURES;
 	registers[1] = USBAT_ATA_SECCNT;
@@ -1576,14 +1571,14 @@ static int usbat_hp8200e_transport(struct scsi_cmnd *srb, struct us_data *us)
 	data[0] = 0x00;
 	data[1] = 0x00;
 	data[2] = 0x00;
-	data[3] = len&0xFF; 		/* (cylL) = expected length (L) */
-	data[4] = (len>>8)&0xFF; 	/* (cylH) = expected length (H) */
-	data[5] = 0xB0; 		/* (device sel) = slave */
-	data[6] = 0xA0; 		/* (command) = ATA PACKET COMMAND */
+	data[3] = len & 0xFF;		/* (cylL) = expected length (L) */
+	data[4] = (len >> 8) & 0xFF;	/* (cylH) = expected length (H) */
+	data[5] = 0xB0;			/* (device sel) = slave */
+	data[6] = 0xA0;			/* (command) = ATA PACKET COMMAND */
 
-	for (i=7; i<19; i++) {
+	for (i = 7; i < 19; i++) {
 		registers[i] = 0x10;
-		data[i] = (i-7 >= srb->cmd_len) ? 0 : srb->cmnd[i-7];
+		data[i] = (i - 7 >= srb->cmd_len) ? 0 : srb->cmnd[i - 7];
 	}
 
 	result = usbat_get_status(us, status);
@@ -1594,8 +1589,7 @@ static int usbat_hp8200e_transport(struct scsi_cmnd *srb, struct us_data *us)
 		transferred = 0;
 
 	if (srb->sc_data_direction == DMA_TO_DEVICE) {
-
-		result = usbat_hp8200e_rw_block_test(us, USBAT_ATA, 
+		result = usbat_hp8200e_rw_block_test(us, USBAT_ATA,
 			registers, data, 19,
 			USBAT_ATA_DATA, USBAT_ATA_STATUS, 0xFD,
 			(USBAT_QUAL_FCQ | USBAT_QUAL_ALQ),
@@ -1614,7 +1608,6 @@ static int usbat_hp8200e_transport(struct scsi_cmnd *srb, struct us_data *us)
 		   srb->cmnd[0] == GPCMD_READ_CD) {
 
 		return usbat_hp8200e_handle_read10(us, registers, data, srb);
-
 	}
 
 	if (len > 0xFFFF) {
@@ -1647,28 +1640,24 @@ static int usbat_hp8200e_transport(struct scsi_cmnd *srb, struct us_data *us)
 	/* If there is response data to be read in then do it here. */
 
 	if (len != 0 && (srb->sc_data_direction == DMA_FROM_DEVICE)) {
-
 		/* How many bytes to read in? Check cylL register */
-
-		if (usbat_read(us, USBAT_ATA, USBAT_ATA_LBA_ME, status) != 
-		    	USB_STOR_XFER_GOOD) {
+		if (usbat_read(us, USBAT_ATA, USBAT_ATA_LBA_ME, status) !=
+				USB_STOR_XFER_GOOD) {
 			return USB_STOR_TRANSPORT_ERROR;
 		}
 
 		if (len > 0xFF) { /* need to read cylH also */
 			len = *status;
 			if (usbat_read(us, USBAT_ATA, USBAT_ATA_LBA_HI, status) !=
-				    USB_STOR_XFER_GOOD) {
+			USB_STOR_XFER_GOOD) {
 				return USB_STOR_TRANSPORT_ERROR;
 			}
-			len += ((unsigned int) *status)<<8;
-		}
-		else
+			len += ((unsigned int)*status) << 8;
+		} else
 			len = *status;
 
-
 		result = usbat_read_block(us, scsi_sglist(srb), len,
-			                                   scsi_sg_count(srb));
+					  scsi_sg_count(srb));
 	}
 
 	return result;
@@ -1677,10 +1666,10 @@ static int usbat_hp8200e_transport(struct scsi_cmnd *srb, struct us_data *us)
 /*
  * Transport for USBAT02-based CompactFlash and similar storage devices
  */
-static int usbat_flash_transport(struct scsi_cmnd * srb, struct us_data *us)
+static int usbat_flash_transport(struct scsi_cmnd *srb, struct us_data *us)
 {
 	int rc;
-	struct usbat_info *info = (struct usbat_info *) (us->extra);
+	struct usbat_info *info = (struct usbat_info *)(us->extra);
 	unsigned long block, blocks;
 	unsigned char *ptr = us->iobuf;
 	static const unsigned char inquiry_response[36] = {
@@ -1713,8 +1702,8 @@ static int usbat_flash_transport(struct scsi_cmnd * srb, struct us_data *us)
 		 * note: must return the sector number of the last sector,
 		 * *not* the total number of sectors
 		 */
-		((__be32 *) ptr)[0] = cpu_to_be32(info->sectors - 1);
-		((__be32 *) ptr)[1] = cpu_to_be32(info->ssize);
+		((__be32 *)ptr)[0] = cpu_to_be32(info->sectors - 1);
+		((__be32 *)ptr)[1] = cpu_to_be32(info->ssize);
 		usb_stor_set_xfer_buf(ptr, 8, srb);
 
 		return USB_STOR_TRANSPORT_GOOD;
@@ -1741,10 +1730,10 @@ static int usbat_flash_transport(struct scsi_cmnd * srb, struct us_data *us)
 		 * I don't think we'll ever see a READ_12 but support it anyway
 		 */
 		block = ((u32)(srb->cmnd[2]) << 24) | ((u32)(srb->cmnd[3]) << 16) |
-		        ((u32)(srb->cmnd[4]) <<  8) | ((u32)(srb->cmnd[5]));
+			((u32)(srb->cmnd[4]) <<  8) | ((u32)(srb->cmnd[5]));
 
 		blocks = ((u32)(srb->cmnd[6]) << 24) | ((u32)(srb->cmnd[7]) << 16) |
-		         ((u32)(srb->cmnd[8]) <<  8) | ((u32)(srb->cmnd[9]));
+			 ((u32)(srb->cmnd[8]) <<  8) | ((u32)(srb->cmnd[9]));
 
 		usb_stor_dbg(us, "READ_12: read block 0x%04lx  count %ld\n",
 			     block, blocks);
@@ -1753,7 +1742,7 @@ static int usbat_flash_transport(struct scsi_cmnd * srb, struct us_data *us)
 
 	if (srb->cmnd[0] == WRITE_10) {
 		block = ((u32)(srb->cmnd[2]) << 24) | ((u32)(srb->cmnd[3]) << 16) |
-		        ((u32)(srb->cmnd[4]) <<  8) | ((u32)(srb->cmnd[5]));
+			((u32)(srb->cmnd[4]) <<  8) | ((u32)(srb->cmnd[5]));
 
 		blocks = ((u32)(srb->cmnd[7]) << 8) | ((u32)(srb->cmnd[8]));
 
@@ -1767,17 +1756,16 @@ static int usbat_flash_transport(struct scsi_cmnd * srb, struct us_data *us)
 		 * I don't think we'll ever see a WRITE_12 but support it anyway
 		 */
 		block = ((u32)(srb->cmnd[2]) << 24) | ((u32)(srb->cmnd[3]) << 16) |
-		        ((u32)(srb->cmnd[4]) <<  8) | ((u32)(srb->cmnd[5]));
+			((u32)(srb->cmnd[4]) <<  8) | ((u32)(srb->cmnd[5]));
 
 		blocks = ((u32)(srb->cmnd[6]) << 24) | ((u32)(srb->cmnd[7]) << 16) |
-		         ((u32)(srb->cmnd[8]) <<  8) | ((u32)(srb->cmnd[9]));
+			 ((u32)(srb->cmnd[8]) <<  8) | ((u32)(srb->cmnd[9]));
 
 		usb_stor_dbg(us, "WRITE_12: write block 0x%04lx  count %ld\n",
 			     block, blocks);
 		return usbat_flash_write_data(us, info, block, blocks);
 	}
 
-
 	if (srb->cmnd[0] == TEST_UNIT_READY) {
 		usb_stor_dbg(us, "TEST_UNIT_READY\n");
 
-- 
2.43.0


