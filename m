Return-Path: <linux-kernel+bounces-854213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 499C6BDDD53
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F98B503CFC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92E7239E7D;
	Wed, 15 Oct 2025 09:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eH1UOKDC"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE38731985C
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521318; cv=none; b=uf6dDgOr/uCqh5vpCRCdPo3dCcJFgLN3p9cacGt17hJvsytywd7ieH4Trk87Kqt3SUGtmGC5DeoEcgmKOgBI2mD9NuNthG6Ce6p1oADgXW+YJ5UUve73wa9h7E2+/zSs5PVfUCXM1eK7G0QHxSBuOJceD7ir480Z61yNobRfy8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521318; c=relaxed/simple;
	bh=x/duYL1yTsMhL0k8eWiAzZY9f7fqBH4VJapCdvJb+1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LJwT3NSWzrGzp22H2yYkJkHFS5CSKm8cSvJQfZqmRIec5DaAH/eCZkpG7B02rDf5eK+oxCGZ+fnECv1TFgTQzgz0cCoUMS7e+hz3npxA32pfkjdBXcZW61O15+8K8F/m5lmfm8fi/mk+OwUJgO/5vFmySYrQIYfvIFfLxVUd6jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eH1UOKDC; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-793021f348fso5878289b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 02:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760521316; x=1761126116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tG+tl0txZhrAHciW3MyttNmS0q+Bc+HLXAgKcHRdHoI=;
        b=eH1UOKDC+U2fVO9/zjt9/n+6TVGpfls7/fyHzlJPK6qelo9j3zHV6gI09EgWe8kBgR
         Yltj+u/5GNe7/CLQL1OcW9s2DHeGtpkdXlFUg0gyhmjES923Aq7qJWEzrlrVCup1SDNA
         V86xvhIHGyjJ5XIwO5itteis6M6mxiFCQ0Nk5meGoBElyFLJVbQS/U+aIWSajXJT90Mq
         wG6pCFN+1DG45h8Nrm6AlWbJi0xkjtLzIk6trrTrqEqACeD0cfTljel30jBQdHn64Pcw
         JVN4C/Ga8QM0dzJzfrL3CkqAYq47vlVSsI3UYiJS56Qb/5Qjc6acTse54IHg2rAujTbr
         57Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760521316; x=1761126116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tG+tl0txZhrAHciW3MyttNmS0q+Bc+HLXAgKcHRdHoI=;
        b=oX2N1MQPlJxzPuJmtVt0sePTakTUa5hlzgGdan11iSIDtbG9Fj+GWwqMmFbPBwDqdP
         ZoDpDDx4D+ZcX1O4d7+hTDi/8uz9j3J+v2CH4k7/bq8jzS/REcn9X6eBtoRv7ikQEQlx
         Tr6kIBe2EoIH9k8yVCaHEzUN4UPDMnE2oMjgZPsm+A0iu3c55DiyXSib0+lIGx+IteJL
         dM7Ae2tqboEScNxYnO1SYxWoB1f5Otc6dUMl9hk3ZqeA2x5m75+oyalFe06RVDRO9QkW
         QraXjUOONPp7UmNu43PLKS/KWS2IRGXgoZ1bRtDB1vfJV+N5uws4WR2NQzSrNvB5GRGJ
         5hCw==
X-Gm-Message-State: AOJu0YyvmNIVD1MMz3hg1UjbSyS9q04/bW8ltutd59GXRWo1pxIkrlyl
	MdwMlutf1sPYqL9oCh4g6oQv9Ow1XLAHrRSUDv94J5BPoPapXMsXVDPS
X-Gm-Gg: ASbGncuGYjBIFRp1l3zOcQXUTofv5LT25zgH1g3q0vgU9V7pChwUdQ7EUXud0y48Aq/
	Any/rSXslH1C8iZq3PsVNptIu3510vLPDHw+oz1NVh1tNwYp57oane2InrFxA+EJPjCwq/makjc
	HsiC34MMHmDbslvbc58qg1Qprp6e1n4SZY2WN+106xPwnqpAFMPQAO8J0l4AxXQvjMZQt0sA798
	We2NaLY9c2AVjhBUk4ogcvcTocoTOXWoH6Bsrd1P5ITboLks0a72PcB/uXyyqAqvcWQ6pRcyrSc
	POO7kRXjndKTpl5Bff2PP9PoiRgIym3GwN5vYiGBrieoBmYtVqLHKVhDK2kxXP1oCexv6bAgKeg
	tDkCqKgFRmzb2O5lgWQjZHnz6LLVgzvVkg8mzyjRptTXPn7OsU4voAANwpxp5okwWXg==
X-Google-Smtp-Source: AGHT+IEKoQxkgbtF8i/Kt9CagehiZKqlsvVyVFzeIw42nRsVCigEnL0pnAnyRizvdIX9+O7mFeJkZw==
X-Received: by 2002:a05:6a21:32a4:b0:2da:f4be:c8d9 with SMTP id adf61e73a8af0-32da83e2597mr36570791637.37.1760521315791;
        Wed, 15 Oct 2025 02:41:55 -0700 (PDT)
Received: from localhost.localdomain ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678df8ea31sm14374155a12.42.2025.10.15.02.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 02:41:55 -0700 (PDT)
From: Rahul Kumar <rk0006818@gmail.com>
To: dinguyen@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	rk0006818@gmail.com
Subject: [PATCH] firmware: stratix10-rsu: replace scnprintf() with sysfs_emit() in *_show() functions
Date: Wed, 15 Oct 2025 15:11:17 +0530
Message-ID: <20251015094117.535157-1-rk0006818@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace scnprintf() with sysfs_emit() in sysfs *_show() functions
in stratix10-rsu.c to follow the kernel's guidelines from
Documentation/filesystems/sysfs.rst.

This improves consistency, safety, and makes the code easier to
maintain and update in the future.

Signed-off-by: Rahul Kumar <rk0006818@gmail.com>
---
 drivers/firmware/stratix10-rsu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/stratix10-rsu.c b/drivers/firmware/stratix10-rsu.c
index 1ea39a0a76c7..53c896ceca9a 100644
--- a/drivers/firmware/stratix10-rsu.c
+++ b/drivers/firmware/stratix10-rsu.c
@@ -454,8 +454,7 @@ static ssize_t max_retry_show(struct device *dev,
 	if (!priv)
 		return -ENODEV;
 
-	return scnprintf(buf, sizeof(priv->max_retry),
-			 "0x%08x\n", priv->max_retry);
+	return sysfs_emit(buf, "0x%08x\n", priv->max_retry);
 }
 
 static ssize_t dcmf0_show(struct device *dev,
@@ -632,7 +631,7 @@ static ssize_t spt0_address_show(struct device *dev,
 	if (priv->spt0_address == INVALID_SPT_ADDRESS)
 		return -EIO;
 
-	return scnprintf(buf, PAGE_SIZE, "0x%08lx\n", priv->spt0_address);
+	return sysfs_emit(buf, "0x%08lx\n", priv->spt0_address);
 }
 
 static ssize_t spt1_address_show(struct device *dev,
@@ -646,7 +645,7 @@ static ssize_t spt1_address_show(struct device *dev,
 	if (priv->spt1_address == INVALID_SPT_ADDRESS)
 		return -EIO;
 
-	return scnprintf(buf, PAGE_SIZE, "0x%08lx\n", priv->spt1_address);
+	return sysfs_emit(buf, "0x%08lx\n", priv->spt1_address);
 }
 
 static DEVICE_ATTR_RO(current_image);
-- 
2.43.0


