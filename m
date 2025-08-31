Return-Path: <linux-kernel+bounces-793537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4E8B3D4E5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 21:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE134179E72
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 19:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E9727602A;
	Sun, 31 Aug 2025 19:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+svRBbS"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEF919D89E;
	Sun, 31 Aug 2025 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756668182; cv=none; b=LeQgKMZONynx26X3RS0CaMXCtKlNOC3xlf62WOiN6leUFuEWBKl9qFPRAaZRWcnXDJD8rkbzdOabUlPhn113GWwg4PqyEw9KzK8aNgsMUXTgl+pOl9Dfg1hfqpxnawJjosews5wOqg60Bb+YkRIRZG+bIXCKvv+roXxLCrJML/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756668182; c=relaxed/simple;
	bh=CbCff7WnxsS6J7stxa7pIncOKua91mLgE+ZaX6aIzWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SdHBwhh9/yNgO9uTE6hRRlyNjATl+0D6cDFz+/L9rRDJFTICUFwvhFwFFRx52AHi0LYFZLEfhWHX1p0gXDFZpE2ReyFxQWy5Q/MtrwD5bdlrVcPEA7xkcPugvZX1Jx/mDU+udxFwS3gOyMfNgNSDmuB2yLQ6Z4TceCDXnDfAPhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+svRBbS; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-327e5b65e2cso1883979a91.2;
        Sun, 31 Aug 2025 12:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756668180; x=1757272980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LYdqga2UZn0l7KZz7GVGu4hJVZ86hvaVSdUZ6IyURfo=;
        b=i+svRBbSK7SiLzoSmEa6DA1jwMKy5mCd1QKfd804tuCCHiurAlmX8YEavYXwokkgb+
         fjk15vtyFmkZE9nocXzg3iEsvZ9oBfnvvgLCKofv3T7CmW66my4HQQrLaxF8DW9Oi2Q4
         aL7KAo/X78ZbNF2NwUCpzIDS3GoHof9rXTGr1yB27JXX6JlK0KUpF3jvUZHr9P4jRaLy
         5/1MeR+iF4KbXzS1+r0OzC8kDd6KEMQxGvaxbydKI1FD9PW1a3Q/ybbJmBdJ922vLpkz
         9FjuCw363eXjDSc2cU8w8w5YNJSmpVKIC9mP93sAjBVY+9NfAsGTarY+XW9ybGJZ9c82
         vgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756668180; x=1757272980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LYdqga2UZn0l7KZz7GVGu4hJVZ86hvaVSdUZ6IyURfo=;
        b=uNuCBZWT8+ZlD6TYhHXqk9auTXoUHZ7Hn89N+kZR0FQ7URKYLDJpY2TZi2cZx52vmA
         6cR/4fReZoDHjlxacv9RCBdpbhRbXml5SzDE1wHHEX8YgFKF8A+6auNAy+jF/Y0hH8Zb
         V2aE03akE1rE5lMJ77FmiMF5TQb8BByYOaMZUhOdSnqCZ88RnA3nTN5gTOK1ZX3vITzG
         hmJ0YsGhdNkSAogRr8zPXAKPXLQkj5irZRk89kPzzOvOZcESF/EL4itG+KyzkglQN0uK
         RRKOZT12p4cTW/z3Z2IUxdeSZyyIJ+RDkAuMNnJhfr3EV2xSYqJQxrOV2Gp+VpyLe40h
         Ikiw==
X-Forwarded-Encrypted: i=1; AJvYcCVKI0z/BZdKOXZem3BaBGz9Vqpb7Z5q5NShD9YvcWFzr6UQEs/J20QlQAfO8bwpItXj3EyUpr4bk/qS@vger.kernel.org, AJvYcCVr19EKXjk67Eg5N/Io0lAaVaazIvYe9xt3WVcmE2OWzkUke8hiP/qTqQgkrhWoqO0al5FcKvo5ARMp+DY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7AdNl3zZ00tLyvdLPxcn6XiB6iQjL7yjT5SifJGo/15sO0XvI
	DC65UaDsY+9f+7V4eJMxuuFIIAm1PfX7Wdi2ZjwybzNU5il5hvBxdiXPJ4+4Dd6JRUY=
X-Gm-Gg: ASbGnct3vQ91ODRyOQA0uvbJanvt2dPgsGCi7Rn0JtdTg7mwhgUPm8t8MPpLkxlZzRl
	uksgDVHMp0DfXEfxpT/6eVzDzuVscYpLAhpn0euCu5BKRBoq46Bxz32BCI2EIVtO0upjqlLGnEQ
	vCduXkXsD4w6YsXk/q0u6T1BHPNDRVwjneMNty4L9sgymOd4DiShECYvnheO0kO0QkRya5+IAbM
	Mb3+BCa7bh484uwTKhw5VkLOQn9Sz3/RDO2qYOVuo6zTebiwkwY6TnoEA/JzM/AVoArDbpZhlm2
	zR6WwQ2XfTvEcmYDbTJM1/B2uhkuk/9KUvQIqjtV+kwJh2WuBfrVZJew6iSQYl2WoJHmJGnZtBt
	DrBa+7rVEBZtB+XovCMwU4qTjP6gwZoaUu+92m6LwGoEHMrzefJUPSAxzCzv1lAE=
X-Google-Smtp-Source: AGHT+IEqQWamZYIQ2ye2qzty0CYeeLql5rk8APf3tzIf/PM4GCbdSeBa0D5K2wt+o+ufEkn5/yTdUw==
X-Received: by 2002:a17:90b:58a6:b0:327:fb42:2472 with SMTP id 98e67ed59e1d1-328156cc767mr4506361a91.28.1756668179516;
        Sun, 31 Aug 2025 12:22:59 -0700 (PDT)
Received: from fedora ([172.59.162.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2b65a2sm8402069b3a.34.2025.08.31.12.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 12:22:59 -0700 (PDT)
From: Alex Tran <alex.t.tran@gmail.com>
To: stern@rowland.harvard.edu
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org,
	Alex Tran <alex.t.tran@gmail.com>
Subject: [PATCH v1] usb: storage: sddr09: move write buffers into info struct
Date: Sun, 31 Aug 2025 12:22:47 -0700
Message-ID: <20250831192247.1120619-1-alex.t.tran@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
- Moved allocation of buffers ('blockbuffer', 'buffer') in 
  'sddr09_write_data' into info struct and freeing into 
  'sddr09_card_info_destructor' so that the operations are only 
  performed once.
- 'buffer' length is now size of a full block instead of being 
  dependent on sectors.

Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
---
 drivers/usb/storage/sddr09.c | 100 ++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 49 deletions(-)

diff --git a/drivers/usb/storage/sddr09.c b/drivers/usb/storage/sddr09.c
index e66b920e9..27c318266 100644
--- a/drivers/usb/storage/sddr09.c
+++ b/drivers/usb/storage/sddr09.c
@@ -255,6 +255,8 @@ struct sddr09_card_info {
 	int		*pba_to_lba;	/* physical to logical map */
 	int		lbact;		/* number of available pages */
 	int		flags;
+	unsigned char	*buffer; /* staging buffer */
+	unsigned char	*blockbuffer; /* bounce buffer */
 #define	SDDR09_WP	1		/* write protected */
 };
 
@@ -847,11 +849,9 @@ sddr09_find_unused_pba(struct sddr09_card_info *info, unsigned int lba) {
 	return 0;
 }
 
-static int
-sddr09_write_lba(struct us_data *us, unsigned int lba,
-		 unsigned int page, unsigned int pages,
-		 unsigned char *ptr, unsigned char *blockbuffer) {
-
+static int sddr09_write_lba(struct us_data *us, unsigned int lba,
+			    unsigned int page, unsigned int pages)
+{
 	struct sddr09_card_info *info = (struct sddr09_card_info *) us->extra;
 	unsigned long address;
 	unsigned int pba, lbap;
@@ -890,13 +890,13 @@ sddr09_write_lba(struct us_data *us, unsigned int lba,
 	/* read old contents */
 	address = (pba << (info->pageshift + info->blockshift));
 	result = sddr09_read22(us, address>>1, info->blocksize,
-			       info->pageshift, blockbuffer, 0);
+			       info->pageshift, info->blockbuffer, 0);
 	if (result)
 		return result;
 
 	/* check old contents and fill lba */
 	for (i = 0; i < info->blocksize; i++) {
-		bptr = blockbuffer + i*pagelen;
+		bptr = info->blockbuffer + i * pagelen;
 		cptr = bptr + info->pagesize;
 		nand_compute_ecc(bptr, ecc);
 		if (!nand_compare_ecc(cptr+13, ecc)) {
@@ -915,9 +915,9 @@ sddr09_write_lba(struct us_data *us, unsigned int lba,
 	}
 
 	/* copy in new stuff and compute ECC */
-	xptr = ptr;
+	xptr = info->buffer;
 	for (i = page; i < page+pages; i++) {
-		bptr = blockbuffer + i*pagelen;
+		bptr = info->blockbuffer + i * pagelen;
 		cptr = bptr + info->pagesize;
 		memcpy(bptr, xptr, info->pagesize);
 		xptr += info->pagesize;
@@ -930,7 +930,7 @@ sddr09_write_lba(struct us_data *us, unsigned int lba,
 	usb_stor_dbg(us, "Rewrite PBA %d (LBA %d)\n", pba, lba);
 
 	result = sddr09_write_inplace(us, address>>1, info->blocksize,
-				      info->pageshift, blockbuffer, 0);
+				      info->pageshift, info->blockbuffer, 0);
 
 	usb_stor_dbg(us, "sddr09_write_inplace returns %d\n", result);
 
@@ -961,9 +961,6 @@ sddr09_write_data(struct us_data *us,
 
 	struct sddr09_card_info *info = (struct sddr09_card_info *) us->extra;
 	unsigned int lba, maxlba, page, pages;
-	unsigned int pagelen, blocklen;
-	unsigned char *blockbuffer;
-	unsigned char *buffer;
 	unsigned int len, offset;
 	struct scatterlist *sg;
 	int result;
@@ -975,35 +972,6 @@ sddr09_write_data(struct us_data *us,
 	if (lba >= maxlba)
 		return -EIO;
 
-	/*
-	 * blockbuffer is used for reading in the old data, overwriting
-	 * with the new data, and performing ECC calculations
-	 */
-
-	/*
-	 * TODO: instead of doing kmalloc/kfree for each write,
-	 * add a bufferpointer to the info structure
-	 */
-
-	pagelen = (1 << info->pageshift) + (1 << CONTROL_SHIFT);
-	blocklen = (pagelen << info->blockshift);
-	blockbuffer = kmalloc(blocklen, GFP_NOIO);
-	if (!blockbuffer)
-		return -ENOMEM;
-
-	/*
-	 * Since we don't write the user data directly to the device,
-	 * we have to create a bounce buffer and move the data a piece
-	 * at a time between the bounce buffer and the actual transfer buffer.
-	 */
-
-	len = min_t(unsigned int, sectors, info->blocksize) * info->pagesize;
-	buffer = kmalloc(len, GFP_NOIO);
-	if (!buffer) {
-		kfree(blockbuffer);
-		return -ENOMEM;
-	}
-
 	result = 0;
 	offset = 0;
 	sg = NULL;
@@ -1024,11 +992,10 @@ sddr09_write_data(struct us_data *us,
 		}
 
 		/* Get the data from the transfer buffer */
-		usb_stor_access_xfer_buf(buffer, len, us->srb,
-				&sg, &offset, FROM_XFER_BUF);
+		usb_stor_access_xfer_buf(info->buffer, len, us->srb, &sg,
+					 &offset, FROM_XFER_BUF);
 
-		result = sddr09_write_lba(us, lba, page, pages,
-				buffer, blockbuffer);
+		result = sddr09_write_lba(us, lba, page, pages);
 		if (result)
 			break;
 
@@ -1037,9 +1004,6 @@ sddr09_write_data(struct us_data *us,
 		sectors -= pages;
 	}
 
-	kfree(buffer);
-	kfree(blockbuffer);
-
 	return result;
 }
 
@@ -1193,6 +1157,36 @@ sddr09_get_cardinfo(struct us_data *us, unsigned char flags) {
 	return cardinfo;
 }
 
+static int sddr09_init_card_buffers(struct us_data *us)
+{
+	struct sddr09_card_info *info = (struct sddr09_card_info *)us->extra;
+	unsigned int pagelen, blocklen, len;
+
+	/*
+	 * blockbuffer is used for reading in the old data, overwriting
+	 * with the new data, and performing ECC calculations
+	 */
+	pagelen = (1 << info->pageshift) + (1 << CONTROL_SHIFT);
+	blocklen = (pagelen << info->blockshift);
+	info->blockbuffer = kmalloc(blocklen, GFP_NOIO);
+	if (!info->blockbuffer)
+		return -ENOMEM;
+
+	/*
+	 * Since we don't write the user data directly to the device,
+	 * we have to create a bounce buffer and move the data a piece
+	 * at a time between the bounce buffer and the actual transfer buffer.
+	 */
+	len = info->blocksize * info->pagesize;
+	info->buffer = kmalloc(len, GFP_NOIO);
+	if (!info->buffer) {
+		kfree(info->blockbuffer);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 static int
 sddr09_read_map(struct us_data *us) {
 
@@ -1403,6 +1397,8 @@ sddr09_card_info_destructor(void *extra) {
 	if (!info)
 		return;
 
+	kfree(info->buffer);
+	kfree(info->blockbuffer);
 	kfree(info->lba_to_pba);
 	kfree(info->pba_to_lba);
 }
@@ -1592,6 +1588,8 @@ static int sddr09_transport(struct scsi_cmnd *srb, struct us_data *us)
 		if (!cardinfo) {
 			/* probably no media */
 		init_error:
+			kfree(info->buffer);
+			kfree(info->blockbuffer);
 			sensekey = 0x02;	/* not ready */
 			sensecode = 0x3a;	/* medium not present */
 			return USB_STOR_TRANSPORT_FAILED;
@@ -1604,6 +1602,10 @@ static int sddr09_transport(struct scsi_cmnd *srb, struct us_data *us)
 		info->blocksize = (1 << info->blockshift);
 		info->blockmask = info->blocksize - 1;
 
+		if (sddr09_init_card_buffers(us)) {
+			goto init_error;
+		}
+
 		// map initialization, must follow get_cardinfo()
 		if (sddr09_read_map(us)) {
 			/* probably out of memory */
-- 
2.51.0


