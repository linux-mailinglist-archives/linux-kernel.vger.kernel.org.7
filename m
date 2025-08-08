Return-Path: <linux-kernel+bounces-760088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EB0B1E64E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83D25163FBD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761C4274B39;
	Fri,  8 Aug 2025 10:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPnNQNgD"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7E0275B05
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754648053; cv=none; b=M4v5SAvhKDs0B846CuXTiVcreLWz4wfua1R0Ck0VzzcPtIv7+UpXucMir7Ss/dWmBx6PzORcELkH26pLWnTv5YRqVocRpJoCLUig/IQ6brVRdonVwYleffB9p7+tYTBLFLIFMjj0w4/bjZRToqaeEohSrvdcGOL7J1m2Xgp/7a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754648053; c=relaxed/simple;
	bh=lKRyPQrpmmpApS37wjsvnzRXaI5gL3l7fJoY0PBEgnc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BNfuza6fXv/HoN5TcGnrV2654it6Cp0hn4wfNq649RaW1r81L4jVHUkks4v1Mf+ilWkTP8nZcYRyVQ0wfb3GAm2/nsk7V/wClYpaD3dZ1BQFdTms1gDT9MGRdVqDER0+mSS3y3Kq3zPkEciLgaHTqVc3xogx2L208iYM+4nJNbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPnNQNgD; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b8d0f1fb49so1165909f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 03:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754648048; x=1755252848; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlopvggkmWltQy9MW6Am3UkajqZswoegEQEmKjx/+LE=;
        b=SPnNQNgD/zYZIsy0aSMjKi3rpsTKmJgXi8Sjae7PtK+cel2W3yE+BfWxxH/AJ2YK67
         9GGDIZFHPOTSO7TFMDgRI0fIfsuxUfFlM8YoJpOxI1bhQo7rnFMgJUW3J3FfokudTVEO
         SxUd47oCMlhXvilVvN/GuMwK1kGDMMbUAwJ6jY6RBhSpzsydZZ1FgREPsUEoM3IdPvHt
         WzN2pCQvq/zeb2wOnrfCjXn82WVLGOnGsDA8PlLMHzFOk/5TtNGr0MCu1KMdO6xLhzXJ
         7hvIGLcbX3SqRm8xqCL1vzpeNryQMBARg6V9bNrM2Nz6j6n/WWNUpVJka5qJ/eVFy74+
         ssKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754648048; x=1755252848;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZlopvggkmWltQy9MW6Am3UkajqZswoegEQEmKjx/+LE=;
        b=ItisHzfVVzi4qm+G9+9Btd+PhCVrpLT1z2Sylx2eoABCMbg5pZpW0jx1bjaJGiCcOs
         i5WjYARxZhxZ/fjCK+t+WUI/+8IUBbzt7GIKE833XhCqExU7t3yinZSWFfIoHwmc8jac
         RU6vhSZsm8g6c5UD3u/gUI8BpHOHE7DZcGqaJo3+xnlmvNb6Vv/+525/wGOMUtZxytoo
         Leup2eQkJIzqPmy61SopAd4Ym1qoGaPyRnvh5IFDqyf8kaQz8E1U2YJOa1UkzAz/qgFU
         QYtKOn5kDEd70YBtHdT1tY3e9CtYwIwrHehYgQSzzbEiewZ1c4ksWPPuvizaWvaOfK1W
         yCvA==
X-Gm-Message-State: AOJu0YwSkgO+vkAxnjnjbqIrY5dW3DurSKZuozFurwxJgJaXVOoyMv71
	LZFCcr6kBaukGmr5yhecjja5YHs2eAjcB/ZRv+E8hJjSyI92BgvUc8Aj
X-Gm-Gg: ASbGncs2PDwGJKB8EovuVd7DFVP2NfcEQTVyoEWxf40GSSRvbNhiwDwMZa3dIHpESdp
	B7+OeqUdaV2QRgigEX5M2gHYoBU4OsuJ4HjyqzcfuDF1xi4USLMYVnavG3A4FUAtfw7bfy1vhs0
	tBVtDMPiyUIyhG4iAONczfrFQNGCce9ztmsZ4wzUywGbAKAvk9Bpd5XKXUQ8EZEPFf624PIYXu6
	w2j/ib2dN6ABFiCKAVjQKnptSNdpxEq/jLtCoCtEsBUZTWrlmTm/e6P7zDz5ZOgUl92D77u3hJR
	3B8yeiWtBTCiTjt2/aMD/KAI9ct5VExbAc+O1BKNi30b8dgCAwE1HIAnrIXZu7U5k0gGTGFapZ8
	Q3oih0d39sLl+m5dZim7WsT4B8vDcQmzkdofzgBAQ8eo75XlbUVw=
X-Google-Smtp-Source: AGHT+IEdy/jbdLYN+e27n7MEC8ya/SRxMZrvBHWFoaQjCz9Rqf1J5qSgsl1RQ6XbQSmwA1BDED6c7w==
X-Received: by 2002:a5d:5f8b:0:b0:3b7:940e:6529 with SMTP id ffacd0b85a97d-3b900929571mr2062954f8f.10.1754648047920;
        Fri, 08 Aug 2025 03:14:07 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-459e58400f5sm125834915e9.2.2025.08.08.03.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 03:14:06 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Fri, 08 Aug 2025 12:13:44 +0200
Subject: [PATCH v2] mtd: core: expose ooblayout information via debugfs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-mtd-ooblayout-sysfs-v2-1-fa620506d1ce@gmail.com>
X-B4-Tracking: v=1; b=H4sIANfNlWgC/32NQQ6CMBBFr0Jm7RhaAkVX3sOwKHSASYCaTiUSw
 t2tHMDle8l/fwehwCRwz3YItLKwXxLoSwbdaJeBkF1i0Lkuc6NuOEeH3reT3fw7omzSCxpj+6p
 UbWGKGtLyFajnz1l9NolHlujDdp6s6mf/91aFCil3Ve1qo0mZxzBbnq6dn6E5juMLUT8Gi7YAA
 AA=
X-Change-ID: 20250719-mtd-ooblayout-sysfs-77af651b3738
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

Add two new debugfs files which allows to determine the OOB layout
used by a given MTD device. This can be useful to verify the current
layout during driver development without adding extra debug code.
The exposed information also makes it easier to analyze NAND dumps
without the need of crawling out the layout from the driver code.

The content of the new debugfs files is similar to this:

    # cat /sys/kernel/debug/mtd/mtd0/ooblayout_ecc
    0      0   49
    1     65   63
    # cat /sys/kernel/debug/mtd/mtd0/ooblayout_free
    0     49   16

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Changes in v2:
  - rebase on tip of mtd/next
  - expose informations via debugfs instead of sysfs
  - drop sysfs ABI documentation changes
  - update subject and commit description
  - Link to v1: https://lore.kernel.org/r/20250719-mtd-ooblayout-sysfs-v1-1-e0d68d872e17@gmail.com
---
 drivers/mtd/mtdcore.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 5ba9a741f5ac3c297ae21329c2827baf5dc471f0..6a1a514021730fb4baafbf3803e900a9ed6b21b2 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -384,14 +384,64 @@ EXPORT_SYMBOL_GPL(mtd_check_expert_analysis_mode);
 
 static struct dentry *dfs_dir_mtd;
 
+static int mtd_ooblayout_show(struct seq_file *s, void *p,
+			      int (*iter)(struct mtd_info *, int section,
+			      struct mtd_oob_region *region))
+{
+	struct mtd_info *mtd = s->private;
+	int section;
+
+	for (section = 0;; section++) {
+		struct mtd_oob_region region;
+		int err;
+
+		err = iter(mtd, section, &region);
+		if (err) {
+			if (err == -ERANGE)
+				break;
+
+			return err;
+		}
+
+		seq_printf(s, "%-3d %4u %4u\n", section, region.offset,
+			   region.length);
+	}
+
+	return 0;
+}
+
+static int mtd_ooblayout_ecc_show(struct seq_file *s, void *p)
+{
+	return mtd_ooblayout_show(s, p, mtd_ooblayout_ecc);
+}
+DEFINE_SHOW_ATTRIBUTE(mtd_ooblayout_ecc);
+
+static int mtd_ooblayout_free_show(struct seq_file *s, void *p)
+{
+	return mtd_ooblayout_show(s, p, mtd_ooblayout_free);
+}
+DEFINE_SHOW_ATTRIBUTE(mtd_ooblayout_free);
+
 static void mtd_debugfs_populate(struct mtd_info *mtd)
 {
 	struct device *dev = &mtd->dev;
+	struct mtd_oob_region region;
 
 	if (IS_ERR_OR_NULL(dfs_dir_mtd))
 		return;
 
 	mtd->dbg.dfs_dir = debugfs_create_dir(dev_name(dev), dfs_dir_mtd);
+	if (IS_ERR_OR_NULL(mtd->dbg.dfs_dir))
+		return;
+
+	/* Create ooblayout files only if at least one region is present. */
+	if (mtd_ooblayout_ecc(mtd, 0, &region) == 0)
+		debugfs_create_file("ooblayout_ecc", 0444, mtd->dbg.dfs_dir,
+				    mtd, &mtd_ooblayout_ecc_fops);
+
+	if (mtd_ooblayout_free(mtd, 0, &region) == 0)
+		debugfs_create_file("ooblayout_free", 0444, mtd->dbg.dfs_dir,
+				    mtd, &mtd_ooblayout_free_fops);
 }
 
 #ifndef CONFIG_MMU

---
base-commit: 9cf9db888f387844e063efc6296e9fa5c042995e
change-id: 20250719-mtd-ooblayout-sysfs-77af651b3738

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


