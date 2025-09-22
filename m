Return-Path: <linux-kernel+bounces-827489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10253B91E3C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11AD519043B5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908122E03FE;
	Mon, 22 Sep 2025 15:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bthpSdYL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB38B192B75
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758554564; cv=none; b=IQQI3Gt7ZBINCRRMG64tmvFT36X9YRiUaxv0gGy/+5bakjE3SigTYR3oq8ytmbY9uSFTXVs0C10y2Z5XzgCmXP/kTGQctj+ONd5mxGkP1c0VAXjbOdd8uCmndyxrNDg67OxqFeZ0rKe3XFmgRDNpWeQld2qY4oYKAW07DL76ynw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758554564; c=relaxed/simple;
	bh=f7AAOBOjgXPIcU9dvL/Owulz/NXNusEyUQL8u28tE64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t3Pb1h747Niq5lHVu1ETunOdJizzjGBAXsXSV1h7Vk3vheEHRGph+MYHu5go0VG3sC6ACyCKjJzolDEfLcsoPvGrqM9y8rlDb31RAmCrfr1QWEdi8xuurqoOFvcu/seyloReMAhDPUXzkHnlpBL1xEYoawOBX7SSzCRG7bNJRqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bthpSdYL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70137C4CEF0;
	Mon, 22 Sep 2025 15:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758554563;
	bh=f7AAOBOjgXPIcU9dvL/Owulz/NXNusEyUQL8u28tE64=;
	h=From:To:Cc:Subject:Date:From;
	b=bthpSdYL7IlA1gb80jBDIIEbLlx5ypcMwQy8n270nRKyvVp2qqoVwm7XVV4qo+icH
	 5mVKkxyfIopxABReot/BduZH69ZZ+QwmprRz8TxWf4Ula1sDeqBqOAQ3DHJ9SdQXER
	 6Z+3wXKI1vDydd3whAyxjhGnvfwBB1mceBXk3khO48AM/pAJbX/uPMYbhwjNvIk9wQ
	 dwt0w2Zb94GgmyvYzfKKX0TjcfUdHGJiQfM6zvWFQUp3NV3f3iXiMmrFoMgoN6Q5zZ
	 5PcHK2M0lpYFe6TI+ROeDAMKUyNM0rvsmf39zyXqGbi3CB6gIsHf/yJRfnZJjeu9Hn
	 EZV//O/2oGclg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v0iNA-00000000469-1DsI;
	Mon, 22 Sep 2025 17:22:37 +0200
From: Johan Hovold <johan@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] mtd: rawnand: omap2: fix device leak on probe failure
Date: Mon, 22 Sep 2025 17:22:04 +0200
Message-ID: <20250922152204.15702-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference to the elm device taken by
of_find_device_by_node() during probe on errors and on driver unload.

Fixes: 62116e5171e0 ("mtd: nand: omap2: Support for hardware BCH error correction.")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/mtd/nand/raw/omap2.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index b8af3a3533fc..61fd98ad5c78 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -1979,7 +1979,7 @@ static int omap_nand_attach_chip(struct nand_chip *chip)
 		err = rawnand_sw_bch_init(chip);
 		if (err) {
 			dev_err(dev, "Unable to use BCH library\n");
-			return err;
+			goto err_put_elm_dev;
 		}
 		break;
 
@@ -2016,7 +2016,7 @@ static int omap_nand_attach_chip(struct nand_chip *chip)
 		err = rawnand_sw_bch_init(chip);
 		if (err) {
 			dev_err(dev, "unable to use BCH library\n");
-			return err;
+			goto err_put_elm_dev;
 		}
 		break;
 
@@ -2054,7 +2054,8 @@ static int omap_nand_attach_chip(struct nand_chip *chip)
 		break;
 	default:
 		dev_err(dev, "Invalid or unsupported ECC scheme\n");
-		return -EINVAL;
+		err = -EINVAL;
+		goto err_put_elm_dev;
 	}
 
 	if (elm_bch_strength >= 0) {
@@ -2073,7 +2074,7 @@ static int omap_nand_attach_chip(struct nand_chip *chip)
 				 info->nsteps_per_eccpg, chip->ecc.size,
 				 chip->ecc.bytes);
 		if (err < 0)
-			return err;
+			goto err_put_elm_dev;
 	}
 
 	/* Check if NAND device's OOB is enough to store ECC signatures */
@@ -2083,10 +2084,24 @@ static int omap_nand_attach_chip(struct nand_chip *chip)
 		dev_err(dev,
 			"Not enough OOB bytes: required = %d, available=%d\n",
 			min_oobbytes, mtd->oobsize);
-		return -EINVAL;
+		err = -EINVAL;
+		goto err_put_elm_dev;
 	}
 
 	return 0;
+
+err_put_elm_dev:
+	put_device(info->elm_dev);
+
+	return err;
+}
+
+static void omap_nand_detach_chip(struct nand_chip *chip)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct omap_nand_info *info = mtd_to_omap(mtd);
+
+	put_device(info->elm_dev);
 }
 
 static void omap_nand_data_in(struct nand_chip *chip, void *buf,
@@ -2187,6 +2202,7 @@ static int omap_nand_exec_op(struct nand_chip *chip,
 
 static const struct nand_controller_ops omap_nand_controller_ops = {
 	.attach_chip = omap_nand_attach_chip,
+	.detach_chip = omap_nand_detach_chip,
 	.exec_op = omap_nand_exec_op,
 };
 
-- 
2.49.1


