Return-Path: <linux-kernel+bounces-844836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7479DBC2E2D
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 00:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B1AE4E6A5F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 22:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF11258CFA;
	Tue,  7 Oct 2025 22:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZciYFxZ"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D4F23D281
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 22:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759876869; cv=none; b=ogr0m5LNTB+wPsCX+DWX9G3IWX9SlH+k6dvDY5bemd55dBLY5YECJlvwbyGwIIDVhRdoiUKE4rYUjJeJuXsM9wQ4fHRFssTLabGB5pG505uTDKMQjIb5Nm22YCd+CqNgap6Xu5hnCSGH0na1I8b9DbZv6yeNS21I2hnlotv0n9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759876869; c=relaxed/simple;
	bh=rZiQKqhCIiCr888lDLCOWnuCZ40KEFeQoLAW02e4oLI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QPUgksqbLDMVWzY9e9Ww5ywiJp92Qf4JLH1ZA2BMza4lGIj7putdAjh/uEPeeJVnSxqSgRC+5d9gztCdGPFi54pe9jhdJ7I6y7s144s11ztOLuz5X2FFVsvKcac45CNYopc6jZ2WqpCr6Dw//kerYm/BbFuKZvNxZLTJSgBBFa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZciYFxZ; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7bc147fd11bso4193655a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 15:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759876867; x=1760481667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IBfCBek8M+CyleueLSM0/f7MhRf1ZAzzj8LCZK7gE+I=;
        b=FZciYFxZSupRQHH40nthXw1bmLh5c2l9CuSVoZxKFCDb8aNthX7FGC5v7mNMPtb/+3
         YVJRIMbWxzVFtBIF4b5BW72sOT6uCpLf6Lf41SRj7bkPnZx8T8KAi9OEudoWhPejv2+4
         jI3zapQW0yp/XaJH+TV3di4MyUl7MgKVamPhX7ehYnOZI9Yp15K6D1R2J1/xDMUfsWEZ
         2HXy2YuE1KfcUf4fd32D/nS5xkM4gOSy4APg06JDAZt163ad1a0TtfLBoNOTYFGpotjA
         MDLZvmMyBk+vbnrF+gpA74qoU3+VFStvJNmIQ/XVer44cCGLJVfl/7cHtqk5NGdsaHLQ
         ma1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759876867; x=1760481667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IBfCBek8M+CyleueLSM0/f7MhRf1ZAzzj8LCZK7gE+I=;
        b=F4c/5v6DnndiKqTH1m9MaY97jgfAWzBJghsSjUfXKXx2Ni/hjLevlqm1MNGI8kzVDB
         IX2st8d8aUwUINnYl2Mv6nk7tpWWJ+I3KZIVPzV2jIV0R34g12JrMWKT8tgRh/y0q7cN
         GC/PMTTg61bZ/s7DdeBNydNgrApwPzGP05v/kg0F1tHgxZ8sxsck9ackCF99TVyTPjUi
         rtiUR/RTqMtrpnvZWLbk0nWOJKA4sCWV9DNZpEROlwgOIf0AGmIJIxfLzZyF65YLJhaR
         S8+JwMeH8/308WRFE5CCNAwkG8mp+B6KRM510rOr+ksM0xetB3gfUyP/Tpjz7jTqogek
         ydbA==
X-Forwarded-Encrypted: i=1; AJvYcCWHjj/gNbmOduh/RCUN6hzoWughVUSoh+ijZFRo/uqazkTccas3+BYj0a2Fw55Anqp8E9t1BUj25hu+0Fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR7iYHdVJMeHC28VGxRmEmC+tGWLNPhle0OJxj9yUz46yPgOCt
	eoA+pMic3cOKZn4bGvgn8xr7rtDifbbneKaAEZNB55NUPp6U0VBiSNYd
X-Gm-Gg: ASbGnctRfhqq3jC5CGzMteBrXLMUawSXUZ8zhL8cqo7dikpfqiisN8tw6cMug9+mhqb
	2opK07ABf+gMJOJsq2JSPv0Ie1FsCasMlgZzyE/ZfLOdk/xV0rd7wDRkOL0ghX9eU2dw+kO4m2u
	BM1OfJ6Sek4aEhMBSebzM4fdiD4EZZGE9EEsO/q1bsX17vAkZxcIC8+17zmyTvsHGM5tKLhMlsP
	3ziTQGSQm7b7cPgl0znuGLbO8paUmbeLBSA3ObIX2hAu2XLYstaVM1jx+OkGnr/RZopX90jrfoA
	rp7qcSAnn2GT0cdweOtgpAwa4mBR6RmsmrlYb8kMRNbilhOuRvVTzzJzps5tZ229itWeRgZe1Zv
	T4Jzh+84U9IQgsvkHh+dyBl6RHVrkh7T5HIvMwIwgzbPLmFVCk0pVUmP9yFwEAsD+5vD8MrKdok
	98RxzXCmA+XkCFX0Ai9Ho5yzJ1bE050vnsxW/qdGqmuQFogtPOh5Ve48NCZY9rNpUzAQzDBz16
X-Google-Smtp-Source: AGHT+IE1J58eiP+VZ/SYqsE+VJxT4uZEnpYq5J2Eo/+1x4KBfgRwP/Uu6PgKxEpsZMKZSBrgZnKoSg==
X-Received: by 2002:a05:6830:d8d:b0:7af:1d61:1055 with SMTP id 46e09a7af769-7c0df784309mr973015a34.21.1759876867142;
        Tue, 07 Oct 2025 15:41:07 -0700 (PDT)
Received: from uacde259c55d655.ant.amazon.com (amazon.com.bear2.houston1.level3.net. [4.1.110.174])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7bf434f904dsm5265419a34.29.2025.10.07.15.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 15:41:06 -0700 (PDT)
From: jayxu1990@gmail.com
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	avnerkhan@utexas.edu,
	rdlee.upstream@gmail.com,
	Jay Xu <jayxu1990@gmail.com>
Subject: [PATCH] mtd: core: Add nand_id sysfs attribute for NAND devices
Date: Wed,  8 Oct 2025 06:40:49 +0800
Message-Id: <20251007224049.2798233-1-jayxu1990@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This enables userspace tools to reliably identify NAND chips for
health monitoring, bad block management, and device-specific
optimizations.

Signed-off-by: Jay Xu <jayxu1990@gmail.com>
---
 drivers/mtd/mtdcore.c | 60 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 5ba9a741f5ac..9290dbe04093 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -34,6 +34,7 @@
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#include <linux/mtd/rawnand.h>
 
 #include "mtdcore.h"
 
@@ -339,6 +340,54 @@ static ssize_t mtd_bbt_blocks_show(struct device *dev,
 }
 MTD_DEVICE_ATTR_RO(bbt_blocks);
 
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
+
 static struct attribute *mtd_attrs[] = {
 	&dev_attr_type.attr,
 	&dev_attr_flags.attr,
@@ -359,7 +408,16 @@ static struct attribute *mtd_attrs[] = {
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
+	&mtd_nand_group,
+	NULL,
+};
 
 static const struct device_type mtd_devtype = {
 	.name		= "mtd",
-- 
2.47.3


