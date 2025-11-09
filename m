Return-Path: <linux-kernel+bounces-891916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C22C43CEC
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 12:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 309934E5186
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 11:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966982DECC5;
	Sun,  9 Nov 2025 11:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikgj9kXs"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446B32DE6F5
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 11:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762689185; cv=none; b=DeiRBv5VfcRqOoQ0nKFMD3eqj3mC+JXS+7v8cLq4T+JghIRXHkf2mfyMIyXUCFrtIVGiy4SJAVHEVfIx1WKGSQhBue+3OklfSDIRm43H1pKIm21Raj3kAKzRBnLO/AkHr6onxGYp3FPFM6MSIAL2iYlbQL6EsioDOJl3cAhFXjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762689185; c=relaxed/simple;
	bh=YDk5MRIGuW1x2NadRPuVP+NinleU3/BZNen7SBV7Ix4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YqlB62fslRIaQPhXNtFdL3V/KMqScj0bIpOxmQePSix9ITROVpCcV0XvWjvrB+y47NpsO+Uil6Yt91d4ZGg4WBM0NDHpfNVBAwQnmenMQU+2G0kk618GS7pAhDp5dHJA7xCkDOMocfpgzlk6ImAl78owoSx/Mw/P6BxcRw4QQF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikgj9kXs; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477632d9326so16352185e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 03:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762689182; x=1763293982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oi5/iqZfrxw/CP5GK2yW/mE7gxZjVbgvC6f7zP3R/B4=;
        b=ikgj9kXsZCo1EnYwrXQKyv0gtvl5RKyFBl4BDa5Bib6P/g2AMclfr18KdgpckCQUvH
         yCPzbtLbvK16KDM57+XRepaPcu0XDDfJMzZDAhSoQBKX2AAt6FgXX0HmTai7XSYIe8q+
         2WcvpIToaNOGZHzjzj9LZ8EFUEC0o1Py0V8vTMTVIPNCsde1FE51BrS3nXg8VYHw3Yij
         dh4E3eJFyxJYRwfPtZcQ+rNImI6/GhRDg5/fxYN4YAzVxhfHfm9Rcarxasda9rizv13P
         phoT5j2tO9xTNJN1KXzH0ROkirkI1tsvVIq/siv2LcodWheZcARM+C6geVPdOTXE+1qj
         yOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762689182; x=1763293982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oi5/iqZfrxw/CP5GK2yW/mE7gxZjVbgvC6f7zP3R/B4=;
        b=NgSfHu5vQS/h7xndj7spXwH8i+VnWlG5rMN78iAHtEgBTosALveHf01vUYiR6HDHsC
         +33wcv5Mv5KGwMpue0OyKZnCvHNGUEwHEFGmrCZO6G3xhXKMtPqJf9rzQYvXsOQFEMRJ
         NN/0WKf3GDhf2oEJ9JjoUhQmpkUHO++fAN0dQmw7qLres8SURFWnxaMhd+N6J3/gBMts
         oL27V3p5aEeTMTJ8gdlcfWM0kQYSnu6f2hB9Uref7Y6vUdM9kBgP1IcfNehMlNTqUedr
         aVVIn9jtIIIaWnhlvNR13GsqgDwHJz8HqC3wPhQDzljWwIf8WYRH32oGYPHOrO4YjFyC
         PULw==
X-Forwarded-Encrypted: i=1; AJvYcCU1hMavjGebJtShsZkb2Tzf6lCnbbf6dNsTIULwMSW7JA3QQDvc3YyFId4ogVte/ZYqAxsBp1IIA4wht8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YybRuiNkFaT3xAd0VbLxyHmCHgngpXtQPG6DljMZrAm98ch8YYQ
	3mXG4w7a2hq1b8UvcC20kldDNmRxRrl8WD1//CV34T3NcPs6F51gmNSUohFyyg==
X-Gm-Gg: ASbGncsPZgsEhMFDtAbiqM06nUzf7iUDHy8Wnus4nI8DT/C/7IXVuuSCeLoA9r4dD7u
	P0lsA27D7Jf87sQTh2sx5wkr6vtUDJ2zA89rkq84n0O3o6HnrkdpEvrBSomvMAHXhXWXnSH7F1s
	MIxKrm48za/8gBCIpo7HUfZXPl+hsXuY3LP5hgQhW1wdkxvQC9SPUUCeib6RqS5RaHp5n8T/4lA
	Y+wJbzNPS/sh4fhz95WqT0N8Dz5/9PA2APxOyTd4mPljy5oeB6vY10otmrdjW7ERJdpj9eGSkgH
	zIXbWTY69a7PDTaKicfSpj3W8V021ZD9sqTovYYZp6jq6Po/v+Az1cUnLmt65Ggn4EwUPEsOKBy
	6mK7od5Ej/B4E7cj4u9vfb+o3dAJ/2IOOsQvFnynruXRUiiYgvJ7arqsVOurA9CDHooyNWnN95b
	MShu49LTKfDXoxqZxWJBLTH/j2SDXOR6a8Pe64g2F1
X-Google-Smtp-Source: AGHT+IF0OdPl7P7zek6LN5EpjrwqGOR8oHSE9cecr6daRpyCulT9z+cFJeMMKofyvzMK78abF/CwMw==
X-Received: by 2002:a05:600c:4f4c:b0:477:7a87:48d1 with SMTP id 5b1f17b1804b1-4777a874db1mr13826495e9.30.1762689181321;
        Sun, 09 Nov 2025 03:53:01 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4776bcfd021sm185197325e9.11.2025.11.09.03.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 03:53:00 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mtd: mtdpart: ignore error -ENOENT from parsers on subpartitions
Date: Sun,  9 Nov 2025 12:52:44 +0100
Message-ID: <20251109115247.15448-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 5c2f7727d437 ("mtd: mtdpart: check for subpartitions parsing
result") introduced some kind of regression with parser on subpartitions
where if a parser emits an error then the entire parsing process from the
upper parser fails and partitions are deleted.

Not checking for error in subpartitions was originally intended as
special parser can emit error also in the case of the partition not
correctly init (for example a wiped partition) or special case where the
partition should be skipped due to some ENV variables externally
provided (from bootloader for example)

One example case is the TRX partition where, in the context of a wiped
partition, returns a -ENOENT as the trx_magic is not found in the
expected TRX header (as the partition is wiped)

To better handle this and still keep some kind of error tracking (for
example to catch -ENOMEM errors or -EINVAL errors), permit parser on
subpartition to emit -ENOENT error, print a debug log and skip them
accordingly.

This results in giving better tracking of the status of the parser
(instead of returning just 0, dropping any kind of signal that there is
something wrong with the parser) and to some degree restore the original
logic of the subpartitions parse.

(worth to notice that some special partition might have all the special
header present for the parser and declare 0 partition in it, this is why
it would be wrong to simply return 0 in the case of a special partition
that is NOT init for the scanning parser)

Cc: stable@vger.kernel.org
Fixes: 5c2f7727d437 ("mtd: mtdpart: check for subpartitions parsing result")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/mtd/mtdpart.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 994e8c51e674..2876501a7814 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -425,9 +425,12 @@ int add_mtd_partitions(struct mtd_info *parent,
 
 		mtd_add_partition_attrs(child);
 
-		/* Look for subpartitions */
+		/* Look for subpartitions (skip if no maching parser found) */
 		ret = parse_mtd_partitions(child, parts[i].types, NULL);
-		if (ret < 0) {
+		if (ret < 0 && ret == -ENOENT) {
+			pr_debug("Skip parsing subpartitions: %d\n", ret);
+			continue;
+		} else if (ret < 0) {
 			pr_err("Failed to parse subpartitions: %d\n", ret);
 			goto err_del_partitions;
 		}
-- 
2.51.0


