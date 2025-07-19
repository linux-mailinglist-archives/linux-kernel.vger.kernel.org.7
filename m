Return-Path: <linux-kernel+bounces-737713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF7BB0AFAB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 14:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB7856363F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 12:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A318224227;
	Sat, 19 Jul 2025 12:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOfutDMa"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2512629C
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 12:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752926819; cv=none; b=QO36iuzDR3w9g4j2L/uP2kJdQ7UFJ75sTu8uQj6a5o78YmbDVygMTNHzJaz2xbrOJIZ0aRFkprumKwPC7cpQn3at7zx2M4dTNn5ySo3+Qvfqebh1hOG/51s0geX44yRhJVzmSVEICKC/dwGa52+RvV7wACV/P3andeggaWcCstc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752926819; c=relaxed/simple;
	bh=6HqLQG94GQj/P6oUjeWS2sn51kqJobq3VqK4DTDTAs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mZW3valIGwy69xUg70ue+bF2uu8hk32uYAfVmLqDgE09uJeXl0HRW2Cr5vEvcnfZUDrc6pnLscRGhPYvMfa1I0Z1J6hOgI+gcPykevcOsuFDE+rFEpofrMTsCKt4oHoOLTPDOVbEZ2rj/BGvFTH1ViTgZXG5oRtEmf4KL8wFNYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOfutDMa; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a6d1369d4eso1754456f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 05:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752926816; x=1753531616; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SAYxuxbarDVKTOv5KTcPmqdU578ljPfscuxrv251wl8=;
        b=AOfutDMawsh6eI27mEEWfCkfmpobRykTo4/JgZdZY41Qb9F8pVwnuXu9g1im17oTl7
         2Rm3oXUgW39m5tm6cvinyFBocyLhxDf6ZwYcEDSYLFqVW5mMJAymqM0lzBbuqz6GcGQn
         GRS/skD7EWELtVxxJ1zD+WvecdRAATyMgmJKCzVW7D39whMjTdd5CwaBkE7YUgyqbloU
         gSKpx+vILkjJd0Hh6r183ajEuFYhONqLyEGea5YKkokJN8wMp2dPJuPbE0CCsl04C0bh
         vHKRiXnVZYQt+ETdaV8Xk7Mg0WPpLMNWXNVxW1DW2Z2u+iNMMJSZvOcEZHVPJr7vyQpA
         BPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752926816; x=1753531616;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SAYxuxbarDVKTOv5KTcPmqdU578ljPfscuxrv251wl8=;
        b=P5zKekKpHk1V0wHl3/CzFPU9UMqcK5gGMje7KUOFd3m/m6wuC5i2X7ZZRHbLI7fTRQ
         fu+F2B693VsgfMAiBDd1kIqZ1bMVKfsxuNXgiDaCNXaxZrRKjhbHAQKp9eeu6qZpBbQH
         BT8F5GEpv0K5RuEEF3ZIRDh+X/aqwfH8tpS2pAF0ox/SUF8vfdXl/n2imIXTgcinK1tV
         ViyfzJJZPte66EoardPhoYvq+KtQe31f+cIF9uVSzCXeS/7sqSzrQENVsqhA5LHHk4w5
         JeZ6T7U60yBNmFO81QNuSX3GG6hZIQsXsBnDQE+V0pZ2cj/wnYDK4jLgWrApgTiIky40
         NsNQ==
X-Gm-Message-State: AOJu0YxUFjc+t9bYVreuTqLaUQ60WMwEVTVIbAsLqex9ihBOud+uaRE3
	Dtn7ToAwNa0Fq5/mi/UhUciWbJWKD8fxXWEEIsw/8jMGM73grdMYnJuf
X-Gm-Gg: ASbGncvRy27FzK/Tu8imqDlrtJ6xVd9YHdd9oA670miT3NyqQWUgCULSchxxw3LoJw5
	u0vOnbltrexsT0flfyDi2X2RMEuiILHJ0PGxo9neKKiGWpvEtuNSAy6HhnEvj5vfP1OcBnWfwTs
	wHUAs2/oL2wVDfKAzdx9ctFY823FGlQ22KpCzSPK1VkzLF10oY5LZOVVAGEsXP/hfa9skZZUlbB
	yLnFhKvk6BteKV2y6eDvrfl0fOJQRCoFPSQVxBwvLXIYge2IUj06qNQsl/IBGwhpxIo7vqCrY9/
	dfb24o4vIh5wKTU3yLOwBOAriAmWUP+SvF9nFfkKe9jb1UUHtvcsQqjtBFoLLP83UNzZLsdTpvK
	B6iPypAWen3VDcJ5lbxF+7R53QiBYvD1Op9wlXSZagbb+08t83Pk=
X-Google-Smtp-Source: AGHT+IFLdTuYjVFtB4WcOmac/pGDIhuVUnjQRk2cKqBAlO+EeqLEYXAwpa1uN2KYem4Bij1+GuQ4pQ==
X-Received: by 2002:a05:6000:2811:b0:3a5:8565:44d1 with SMTP id ffacd0b85a97d-3b60dd78e32mr8146812f8f.25.1752926815752;
        Sat, 19 Jul 2025 05:06:55 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b61ca48970sm4681883f8f.57.2025.07.19.05.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 05:06:55 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Sat, 19 Jul 2025 14:06:48 +0200
Subject: [PATCH] mtd: expose ooblayout information via sysfs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250719-mtd-ooblayout-sysfs-v1-1-e0d68d872e17@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFeKe2gC/x3MQQ5AMBBA0avIrE2ihOIqYlFMmQSVDkLE3TWWb
 /H/A0KeSaCOHvB0srBbA1QcQT+ZdSTkIRjSJM0TrSpc9gGd62Zzu2NHucUKam1skasu01kJodw
 8Wb7+a9O+7wciHUjSZQAAAA==
X-Change-ID: 20250719-mtd-ooblayout-sysfs-77af651b3738
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

Add two new sysfs device attributes which allows to determine the OOB
layout used by a given MTD device. This can be useful to verify the
current layout during driver development without adding extra debug
code. The exposed information also makes it easier to analyze NAND
dumps without the need of cravling out the layout from the driver code.

The content of the new sysfs files is similar to this:

    # cat /sys/class/mtd/mtd0/ooblayout_ecc
    0      0   49
    1     65   63
    # cat /sys/class/mtd/mtd0/ooblayout_free
    0     49   16

Also update the ABI documentation about the new attributes.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 Documentation/ABI/testing/sysfs-class-mtd | 14 +++++++++++
 drivers/mtd/mtdcore.c                     | 40 +++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-mtd b/Documentation/ABI/testing/sysfs-class-mtd
index f77fa4f6d46571175b156113a1afeeb9f5f51c0f..fd3000b9cc7aee4ea9069d1869f310fefa24f97a 100644
--- a/Documentation/ABI/testing/sysfs-class-mtd
+++ b/Documentation/ABI/testing/sysfs-class-mtd
@@ -240,3 +240,17 @@ Contact:	linux-mtd@lists.infradead.org
 Description:
 		Number of bytes available for a client to place data into
 		the out of band area.
+
+What:		/sys/class/mtd/mtdX/ooblayout_ecc
+What:		/sys/class/mtd/mtdX/ooblayout_free
+Date:		July 2025
+KernelVersion:	6.17
+Contact:	linux-mtd@lists.infradead.org
+Description:
+		Newline separated list of the regions in the out of band area.
+
+		Each line contains three decimal numbers separated by spaces.
+		The first number indicates the index of the region. The second
+		number describes the starting offset within the out of band
+		area. The last number specifies the amount of bytes available
+		in the region.
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 429d8c16baf045e6a030e309ce0fb1cbec669098..552d12f749e43b7d9abb07e0235a3ef2d2a98546 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -254,6 +254,44 @@ static ssize_t mtd_oobavail_show(struct device *dev,
 }
 MTD_DEVICE_ATTR_RO(oobavail);
 
+static ssize_t mtd_ooblayout_show(struct device *dev,
+				  struct device_attribute *attr, char *buf,
+				  int (*iter)(struct mtd_info *, int section,
+					      struct mtd_oob_region *region))
+{
+	struct mtd_info *mtd = dev_get_drvdata(dev);
+	ssize_t size = 0;
+	int section;
+
+	for (section = 0;; section++) {
+		struct mtd_oob_region region;
+		int err;
+
+		err = iter(mtd, section, &region);
+		if (err)
+			break;
+
+		size += sysfs_emit_at(buf, size, "%-3d %4u %4u\n", section,
+				      region.offset, region.length);
+	}
+
+	return size;
+}
+
+static ssize_t mtd_ooblayout_ecc_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	return mtd_ooblayout_show(dev, attr, buf, mtd_ooblayout_ecc);
+}
+MTD_DEVICE_ATTR_RO(ooblayout_ecc);
+
+static ssize_t mtd_ooblayout_free_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	return mtd_ooblayout_show(dev, attr, buf, mtd_ooblayout_free);
+}
+MTD_DEVICE_ATTR_RO(ooblayout_free);
+
 static ssize_t mtd_numeraseregions_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -366,6 +404,8 @@ static struct attribute *mtd_attrs[] = {
 	&dev_attr_subpagesize.attr,
 	&dev_attr_oobsize.attr,
 	&dev_attr_oobavail.attr,
+	&dev_attr_ooblayout_ecc.attr,
+	&dev_attr_ooblayout_free.attr,
 	&dev_attr_numeraseregions.attr,
 	&dev_attr_name.attr,
 	&dev_attr_ecc_strength.attr,

---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250719-mtd-ooblayout-sysfs-77af651b3738

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


