Return-Path: <linux-kernel+bounces-751901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E666AB16F09
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14CE716D699
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC072BD5BF;
	Thu, 31 Jul 2025 09:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqEBXkP2"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DE9F4FA;
	Thu, 31 Jul 2025 09:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753955605; cv=none; b=Y1G77iuWAZLFDvRrTj1WALNVSGrKqvcc4zg75kCOmIZQ1BXI0GbyMbMOyThh1UaG3hScEPyAMxsDwJlpgg91+Aykh8OBqDuAt1xRk5DEnDwgZcf5VA+5iMiTjWXm04/PlPJn4X4lsr5vW/R5z4j2TVoagozbettsFBn6X8Yop2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753955605; c=relaxed/simple;
	bh=/cp/miCCgnrS1CmGH3nRvWasypsDB5K3Zo2E+22xAXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RSLLrWK31EFn4l9wVVRyw8m0SYGduaVX9ENE7R5MDN+OB42cPICWPGn+dJcIi9crFhz5m6YuHYo6ZeKzdIOaONHjD8ILR2zarkt/dUu/5TxprMrIjEeLa3KDyFknyQ7e93xjrmI2SXt+H3vajrUV/ue2m8RG83ehSKvsgPwRoU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqEBXkP2; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a6cd1a6fecso624245f8f.3;
        Thu, 31 Jul 2025 02:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753955602; x=1754560402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HsMG0i3+AqfjEpu+Gh56Ls+b7M6/eRJtSrOLqrmM+JY=;
        b=fqEBXkP2isvtdEeavChZAa65xytK5Kf2cXROz+yyKAK+itVx7E/XqtQEKX6qkNqcnz
         evq4iJJ6wDN6gC4ELzF/JjOR2Tly0D4YH2mLk6AT+3+f4W51Kqe0rvEYxN2drGlYLd8u
         /LckwggSlJsqXjoZ9if6p81uuPaWXZrWSFTseoTVO4bz4Q3hUGn/4m7bOMxeMcuB3ExQ
         lzX7DucuuBc3Zn/hRjrjPY6/aghvASACcADkSOipq2PpTxLFFlmHdRubGRQ0U4dJ+ejq
         c+i183/SxGvy3Y9Ya4xX3HdS3waWWy4okZ72GbLdoBBrJh10Xvj26zZY+lze6oQRTCSI
         0RAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753955602; x=1754560402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HsMG0i3+AqfjEpu+Gh56Ls+b7M6/eRJtSrOLqrmM+JY=;
        b=HaYY7Pa6CcWjrufmSYlEM4No/AOVzJESyGzxmNPdUcqjs1R1YHg/h938wNL4q+T14t
         l+IG+bHD3zv/aE2urdDVyaTIdQeMEis9D5n609tFhJpzrG3reVaxB9kqjLg0Jh40wNoy
         yGBYQjuucT++3G36D0znf0MkRr7RK7lRVCSnrwMWZLV798izUym9OVB9oprIn9IeTu9T
         7SQpLOdWPr+/6Kq4mVHjqAaF80+2UtiRRRhV0EfBVE3EJe8R765BC7kMH3L2sC3Jis52
         LDOlF9U8veuk/WkBmg8qUD9bIWYwLnuihJXJVkgqToE7juOvQM+09BrrY8p/LH+Rr7B3
         /7Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXBvB23YUYOCIJ+hbxAOveZVUM9OlkhbF34zbE+ZPlIyxGMcE/4b/LWV4l+j+C0xyISmzb7xOTf2jPPYDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoH5qnal7LbLRg3+BYY8UuT/9sWBqbcA7qZyy/1oiphjt9JPcF
	QwhRR2DckELlQflVKOLg9GXe0/3YWwLJWt5pF63a5TgZ1Rq7wUfyRFvw
X-Gm-Gg: ASbGncs6xIIeeMh8Q/ubGrChQ4Wt/5VtHQ9NgPk5kDG6Ouze3K0JZqSP2VIeDYnpdEp
	8zFlgFVWrNdRtnrwkfW3ltR1Wrg35DIXLTqmSH3GaRwjh/Wxx0Hlwl62ihTEkn5co5R3rK5yqiT
	z3FHMckdVzS4knbmJHLP4tEkFMHC2dQcBsPE6xldFPp8zL+QeKAkgmv2WPoEWskjNMuorIRTmxL
	mfUYptV67EVwg1yY7uFCGWW4c6NeGMkVgwvl0zMnka2PF/Lt9CI/Iywb+zHjJS6HVGgaQ1nFF8P
	h44JTSo3G6GKpPqTac/SnEX4rjSUxCdGSn+I8jcgoRN9LuleeKrElOWztjR3d4hAuaRnxnXAhlb
	jT0Zm9I+lWZfgWeMCLMVAM0VE3oGFgkY=
X-Google-Smtp-Source: AGHT+IHS+Yna4XLdm1AXyYdne1Nc2qQhOZVR/XY/PwPIfRBT/zicTIWQPLhsl4HER3UQKSwd/WutEw==
X-Received: by 2002:a05:6000:178f:b0:3b7:8473:31c3 with SMTP id ffacd0b85a97d-3b794fe4fa7mr5105901f8f.9.1753955602212;
        Thu, 31 Jul 2025 02:53:22 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c3bf956sm1918578f8f.24.2025.07.31.02.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 02:53:21 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] mtd: lpddr: Remove space before newline
Date: Thu, 31 Jul 2025 10:52:47 +0100
Message-ID: <20250731095247.2165158-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is an extraneous space before a newline in a handful of printk
messages. Remove the spaces.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/mtd/lpddr/lpddr_cmds.c  | 10 +++++-----
 drivers/mtd/lpddr/qinfo_probe.c |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/lpddr/lpddr_cmds.c b/drivers/mtd/lpddr/lpddr_cmds.c
index 14e36ae71958..290fd0119e98 100644
--- a/drivers/mtd/lpddr/lpddr_cmds.c
+++ b/drivers/mtd/lpddr/lpddr_cmds.c
@@ -142,7 +142,7 @@ static int wait_for_ready(struct map_info *map, struct flchip *chip,
 		if (dsr & DSR_READY_STATUS)
 			break;
 		if (!timeo) {
-			printk(KERN_ERR "%s: Flash timeout error state %d \n",
+			printk(KERN_ERR "%s: Flash timeout error state %d\n",
 							map->name, chip_state);
 			ret = -ETIME;
 			break;
@@ -186,7 +186,7 @@ static int wait_for_ready(struct map_info *map, struct flchip *chip,
 	if (dsr & DSR_ERR) {
 		/* Clear DSR*/
 		map_write(map, CMD(~(DSR_ERR)), map->pfow_base + PFOW_DSR);
-		printk(KERN_WARNING"%s: Bad status on wait: 0x%x \n",
+		printk(KERN_WARNING"%s: Bad status on wait: 0x%x\n",
 				map->name, dsr);
 		print_drs_error(dsr);
 		ret = -EIO;
@@ -321,7 +321,7 @@ static int chip_ready(struct map_info *map, struct flchip *chip, int mode)
 			/* Resume and pretend we weren't here.  */
 			put_chip(map, chip);
 			printk(KERN_ERR "%s: suspend operation failed."
-					"State may be wrong \n", map->name);
+					"State may be wrong\n", map->name);
 			return -EIO;
 		}
 		chip->erase_suspended = 1;
@@ -468,7 +468,7 @@ static int do_write_buffer(struct map_info *map, struct flchip *chip,
 	chip->state = FL_WRITING;
 	ret = wait_for_ready(map, chip, (1<<lpddr->qinfo->ProgBufferTime));
 	if (ret)	{
-		printk(KERN_WARNING"%s Buffer program error: %d at %lx; \n",
+		printk(KERN_WARNING"%s Buffer program error: %d at %lx\n",
 			map->name, ret, adr);
 		goto out;
 	}
@@ -736,7 +736,7 @@ static int do_xxlock(struct mtd_info *mtd, loff_t adr, uint32_t len, int thunk)
 
 	ret = wait_for_ready(map, chip, 1);
 	if (ret)	{
-		printk(KERN_ERR "%s: block unlock error status %d \n",
+		printk(KERN_ERR "%s: block unlock error status %d\n",
 				map->name, ret);
 		goto out;
 	}
diff --git a/drivers/mtd/lpddr/qinfo_probe.c b/drivers/mtd/lpddr/qinfo_probe.c
index 137ae5f0a19b..42281e460c62 100644
--- a/drivers/mtd/lpddr/qinfo_probe.c
+++ b/drivers/mtd/lpddr/qinfo_probe.c
@@ -55,7 +55,7 @@ static long lpddr_get_qinforec_pos(struct map_info *map, char *id_str)
 			return minor | (major << bankwidth);
 		}
 	}
-	printk(KERN_ERR"%s qinfo id string is wrong! \n", map->name);
+	printk(KERN_ERR"%s qinfo id string is wrong!\n", map->name);
 	BUG();
 	return -1;
 }
@@ -112,7 +112,7 @@ static int lpddr_pfow_present(struct map_info *map, struct lpddr_private *lpddr)
 
 	return 1;	/* "PFOW" is found */
 out:
-	printk(KERN_WARNING"%s: PFOW string at 0x%lx is not found \n",
+	printk(KERN_WARNING"%s: PFOW string at 0x%lx is not found\n",
 					map->name, map->pfow_base);
 	return 0;
 }
-- 
2.50.0


