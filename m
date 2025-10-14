Return-Path: <linux-kernel+bounces-853261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA34BDB0E7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 00550356922
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDDA2C032E;
	Tue, 14 Oct 2025 19:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0SAQDtC"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70198235072
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760469991; cv=none; b=PpOQU9ESSnHXu0x810vrdlndiw07xV7TqsCAw2vxEFoeq9RC6qIIpHFGafsPaM4a05kWPC1MyIXsCJcMkN4ip/6duVBEXR2CZzOh3MFErvpwDNSk69fujftDbA+mLqg1J3L2nsrQKI/1P8imO1PXVD86lMS/lOTu8bPYu+yIVwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760469991; c=relaxed/simple;
	bh=fZ2lmAplBig7Ej+JsrNEWrTslwMnZPM3WtSgacCl74E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bU6yf07NeArfjm0FM3ApHwUiiZ7z996vkR6JdagrMS9/Fhh15/i/KWvFd2gtCyr3N9Z/iPlXEszFAdCnSoTZH7LFXagv1hI2wHAhOxD/trHC0krsL5wL7rgfajT2CrRYCkcPjy04tsm8GBm978RyERNSvw6G/nIqRVORdwIeH00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0SAQDtC; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-650304a822aso688314eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760469988; x=1761074788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHj2o7EikP5ncHLSx75L5WIqeqxqTpkWVTbaajhRFdY=;
        b=W0SAQDtC9M3BZY8w+Pbd7q2ATF4w7N95TPTPMtjhMJq4BAmLS38CheFeAjpbbtjVol
         fcgODTgb9QRgHiRlZ6QP83689oAAA1LuZgCBwCHsCBLNtlfTMli+YgwSBYSzquw++8fY
         uO+Nt6s5gaH2HjbZOBxJiVm6POGxwC6VSiUt67qcQeXhyAZPRYz3N2Aie6c/kHdfSB9D
         H0cIEOtsGcA7EURGRqJIiQeXL4smh6JRMf9UpkzW7giDMwqmWjPG28bXL863/C4dAh2+
         1YSK/cFRzqsyHXkbnIGpOuqEm3JaNTN1tKpFentWEv4Ca0iW/ya0qvf12Mcc/bJOVm9d
         5+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760469988; x=1761074788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eHj2o7EikP5ncHLSx75L5WIqeqxqTpkWVTbaajhRFdY=;
        b=IMdqk0P0pwdvSr2j+8iJQgYw/HkmUxsMbwBNolNmhjoXT0mO5qf7RLn8a0Hsc/uQkc
         sM3C8w9OBt5aaKm7M6otClFfsOHglLlw6swfchDZsdLlRlkmXrX1W86zVHatyAt+5Y03
         jJS8gRTLPotApSfqpi+tqtW5oiHrDbyLk3d2dXwjW1tAG3Emu/aBFpuGip6wcy9fmKXQ
         U5mC5MNDEBlwO5/3XXt96uUdh5zNjBQ6bxi6C/bCnxfQ+1MtRbpSLX+cclmHwzIxyYbG
         pKKm1y66GqengN4FA/1jIpHtbgkkDH8ufvszxGRos6Yyy3JsCQR6GqY+Y1+OrH4kH1HT
         iMhg==
X-Forwarded-Encrypted: i=1; AJvYcCV0ey1ayxCInLQCVhgxjj2TA+tMLsLspov/6AQczieNFO0K+kfJUqEJV3PD1wtX7HZD76TYZNSTMgaJGtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDZ5ODLcFNHAc3ZYleylW8CLDUgB9weBgKGZpH37/XN9gHiT6K
	GYBzrrAmf9ynyVne1XhyHZ9O3jv8D21fuN7wjYbPOeBVQD+AuBnfjQUC
X-Gm-Gg: ASbGncvkVCVKQcyFw7jbxODImfNLnBLJ1sG+HuXrntRRd9xNdl2nbg9DpEvJyXibE9L
	dHAs9pmscvMj/C1QJMP2hzXi06OQJZblXhBPbMEwEbuCGKB579VbBGUzODQMwQ8eC1+bWfmGVXC
	UV86+OXyubt9SqQrEIr5g4AO6NqVGuuDvvF2dSo6PwHeTSwp8GFUjuowcvUL9UjhBXcdKNlaula
	5IOpY1THKY8WtsdfxKvmquaPniuKWkQWlQjUAb+xzwKQO83xTqz440ZNI/aVu/1jmBcPn5Kw9p4
	MO/SuH9TXwoh88bwejYt7H0rRqp3TQ7jZ1H1BenLJCHC4B6Hl3JJI3ZZktP7Ll4xBMOk62QdOll
	Cbs/acBTuQ7lssqrJHa5UmX0nrbf9ffOIaqFYukdlYqyHEEKmxkm45fwfDUJ3Kd90a1XW8uCy16
	hDqLfiQZuhix3YJtBTqu7JjHXH1yHBAPrgoHd9ncMHtxiZATVmAROqG9zszcJkkxTAMbJqhKc+Y
	5C1sQ==
X-Google-Smtp-Source: AGHT+IGpw9Z0DqqqaYc7jrfIT4qzqxvoATfSl2lPXdgh0jkAvhk0Wy0FALGUWrAmivzsiW51YvVpGw==
X-Received: by 2002:a05:6820:4dc7:b0:650:4db7:22ed with SMTP id 006d021491bc7-6504db725b3mr87792eaf.0.1760469988343;
        Tue, 14 Oct 2025 12:26:28 -0700 (PDT)
Received: from uacde259c55d655.ant.amazon.com (amazon.com.bear2.houston1.level3.net. [4.1.110.174])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65018200f2csm3597157eaf.18.2025.10.14.12.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 12:26:27 -0700 (PDT)
From: jayxu1990@gmail.com
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	avnerkhan@utexas.edu,
	rdlee.upstream@gmail.com,
	Jay Xu <jayxu1990@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] mtd: core: Add nand_id sysfs attribute for NAND devices
Date: Wed, 15 Oct 2025 03:24:55 +0800
Message-Id: <20251014192455.4007534-1-jayxu1990@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251007224049.2798233-1-jayxu1990@gmail.com>
References: <20251007224049.2798233-1-jayxu1990@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jay Xu <jayxu1990@gmail.com>

[Problem]
Currently, NAND devices do not expose their NAND ID through sysfs,
making it difficult for userspace applications to identify the specific
NAND flash chip in use. For supply management reasons, electronics
products are typically manufactured with multiple storage device
suppliers, creating a need to identify which storage device is used
on a particular product. The NAND ID is a semi-unique identifier that can
be used to determine chip-specific characteristics such as maximum P/E
cycles, which is essential for NAND health monitoring and wear leveling
algorithms.

[Solution]
This patch adds a new 'nand_id' sysfs attribute that:

1. Exposes the full NAND ID (typically 5-8 bytes) in hexadecimal format
2. Only appears on physical NAND devices (MTD_NANDFLASH/MTD_MLCNANDFLASH)
3. Is hidden on virtual MTD devices
4. Reads from the master device to ensure consistent ID across partitions
5. Handles on-demand ID reading if not already populated during probe

The implementation uses a separate attribute group with visibility control
to avoid affecting existing MTD sysfs attributes. All NAND partitions
from the same physical chip will show the same ID, as expected.

The NAND-specific code is conditionally compiled with CONFIG_MTD_RAW_NAND
to ensure clean builds when raw NAND support is not enabled.

This enables userspace tools to reliably identify NAND chips for
health monitoring, bad block management, and device-specific
optimizations.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510120356.STGKDkA5-lkp@intel.com/
Signed-off-by: Jay Xu <jayxu1990@gmail.com>
---
 drivers/mtd/mtdcore.c | 66 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 5ba9a741f5ac..215e316194b4 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -34,6 +34,9 @@
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#ifdef CONFIG_MTD_RAW_NAND
+#include <linux/mtd/rawnand.h>
+#endif
 
 #include "mtdcore.h"
 
@@ -339,6 +342,56 @@ static ssize_t mtd_bbt_blocks_show(struct device *dev,
 }
 MTD_DEVICE_ATTR_RO(bbt_blocks);
 
+#ifdef CONFIG_MTD_RAW_NAND
+static ssize_t mtd_nand_id_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct mtd_info *mtd = dev_get_drvdata(dev);
+	struct mtd_info *master = mtd_get_master(mtd);
+	struct nand_chip *chip;
+	int ret;
+
+	/* Ensure this is actually a NAND device */
+	if (master->type != MTD_NANDFLASH && master->type != MTD_MLCNANDFLASH)
+		return -ENODEV;
+
+	chip = mtd_to_nand(master);
+
+	/* If ID not populated, try to read it now */
+	if (!chip->id.len) {
+		ret = nand_readid_op(chip, 0, chip->id.data, NAND_MAX_ID_LEN);
+		if (ret)
+			return sysfs_emit(buf, "read-error\n");
+		chip->id.len = strnlen(chip->id.data, NAND_MAX_ID_LEN);
+	}
+
+	return sysfs_emit(buf, "%*phN\n", chip->id.len, chip->id.data);
+}
+MTD_DEVICE_ATTR_RO(nand_id);
+
+static umode_t mtd_nand_id_visible(struct kobject *kobj, struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct mtd_info *mtd = dev_get_drvdata(dev);
+
+	/* Only show on NAND devices (excludes UBI volumes which have type 'ubi') */
+	if (mtd->type != MTD_NANDFLASH && mtd->type != MTD_MLCNANDFLASH)
+		return 0;
+
+	return attr->mode;
+}
+
+static struct attribute *mtd_nand_attrs[] = {
+	&dev_attr_nand_id.attr,
+	NULL,
+};
+
+static const struct attribute_group mtd_nand_group = {
+	.attrs = mtd_nand_attrs,
+	.is_visible = mtd_nand_id_visible,
+};
+#endif /* CONFIG_MTD_RAW_NAND */
+
 static struct attribute *mtd_attrs[] = {
 	&dev_attr_type.attr,
 	&dev_attr_flags.attr,
@@ -359,7 +412,18 @@ static struct attribute *mtd_attrs[] = {
 	&dev_attr_bitflip_threshold.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(mtd);
+
+static const struct attribute_group mtd_group = {
+	.attrs = mtd_attrs,
+};
+
+static const struct attribute_group *mtd_groups[] = {
+	&mtd_group,
+#ifdef CONFIG_MTD_RAW_NAND
+	&mtd_nand_group,
+#endif
+	NULL,
+};
 
 static const struct device_type mtd_devtype = {
 	.name		= "mtd",
-- 
2.47.3


