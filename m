Return-Path: <linux-kernel+bounces-891754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4B0C43635
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 00:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7630188EB9B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 23:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1688529D27E;
	Sat,  8 Nov 2025 23:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hRDC9uU1"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A404629D270
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 23:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762643616; cv=none; b=EBNwXeXsgnXJvNOML0iShmNLXNDdAc2y5l+vPj0ptqcwG1BBGFR0i1YghJvCllpokcvvmbr+y0oGmUUEsBNiPstK253h9gaQ/jwkYX7BJ0b1TfWgbgrWWTu3Mq++qeU0nAOZ41Dh3IbNncgDRxy4UtvfWcg8g5x5NTI/CcHm/+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762643616; c=relaxed/simple;
	bh=2sKf1rUf7Yyibfx/hY6iRlou4EFmIhXP3XoaRsvqQGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHtRum/Aq5bF/7/AKc8vr3I+CLrWOe65rrL5KJkZ6NSQqNgZWJETEIA2TlocUprnmg97/TWgWvKsEjoj0F36B69U8e3m95enRzJcmZ5herPZTN3NSXai4gi8Ee3owFF259TpqKTGYRtmzdpWpxySYp+TbZTbQvfJqRfhm0SNVKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=hRDC9uU1; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64180bd67b7so23668a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 15:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1762643613; x=1763248413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jp3aBA3u4fWo7xiq7xdD0SMcDBXI+jskP2t4r2Vw08s=;
        b=hRDC9uU13Y+ZrcO4icz5roJCxCUEROE98mBcIdH//AQTN7CaWGWRcm+zC7TpCEs7U6
         uLKhhvclo14cf0I81Euo5QNfcG7Kh6Lgwe2UczskyKxsNuUqlyQuqWzAJJgQ+Rfx/fTN
         5frLrGIzt4n8Gk9M+6ycTlbZwmqbZ43Wlus2RKrfOCPIXOS9RBhOgEHY1XuQMrTHi6iz
         it+uLUsoALIs+yVBOyInDfAPmjP6LstpavisR6MsP8Dk3ZVGo618SO6s/xSsSd3O7LgJ
         Lm8tBuMMWjuxTZfW9Rxcm3UkUlyjYWUR3qfHhYHgeaoxDePQ8Uh5FqdVkryu3gSo/ZDR
         v5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762643613; x=1763248413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jp3aBA3u4fWo7xiq7xdD0SMcDBXI+jskP2t4r2Vw08s=;
        b=nUihaf/lO/yuUPEDuk2/Xm1HC3ViPn/9GQIfapz7IIeBjuSE4ZT1rroSrJ3+g+oBtK
         VVOyUGd5w1smtEdfGoSKprArGG5vPbsxSap/yLGMjMehPYNi9p1Pqf1Jp5HEfwklKr2P
         Xadj7yMkPZ3F3E9p34PMsHmXAQrbxuLao37dZdiq7cSvopsC8yazObpeOYr3Qvsvr745
         B14z8ayXx3YCcgkQewDXeGVJwlwpX8UeBagaamxncwS4DjGd5RboFvjnq477VRFI9NAC
         JwLd3vjzTmF1S9luvTuN7NqOCYaXxWACT0SVPR/U6Wl410a+JZVm54A46zQcp/YXWfiK
         Davg==
X-Forwarded-Encrypted: i=1; AJvYcCWUYLc7rkyCGAg/149oHX/lXuT7YIDzR+X8B6LdvrhYZRChTe9wIEkiVU0GUftIT4fatc4hctttI7CrFaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaGLChIkjXj/QAG9XIkBo+K7nDx9+gnzM+t0Q7+YSWe8ILLXiL
	bmfxqkr9cThDkHENC2sDBAHb1ZEtPSYb9VOtYRG5DsUfyBiqirVFzRD0
X-Gm-Gg: ASbGncsdt5eKVESGREFjFBAJAW+b5UYvOobgldwfncE2bgf8AM4NiVW8mTzSB/X+/he
	tbNp7aAIcFzse3ejlHYNAMjoW+Q+fVkjxLk4Owu3HkZID5Ata51A0GlnuEoKqgUmbORrZQ5VSyf
	Ibf97i6m6RYRHIudbqvidGKnVdVTC3sZHgvxl8Iw5oxscjTAdox4M2Pzl3uGBuyNpSWBG9mUbjo
	c8/1rD6wFj9U45WS05w569ylUL9TGIC2XBH7Jflqj0vuqrN/ZkzHzG0ENmZoHImxo/gmgF/xCSF
	+IkS4Fr3uwxe/IxuQVTWVyK0q+SN9oDY4Rshwd6pvYPxJ4Mw5xe181kgVmCTJb1cbExCUjWXJzm
	OX7bA/0el9V59aOPcSCy5HCvRAVJZuWg9+qJtFLrxbjZRwgkOMfPRkkOGske9buLPOc7oRDGwUo
	QbNttjI3rg4UM0rKJAu4fvVvKIOiflQ9b41stHcTP/qWP6leWeaL34vSu2Pi0EbGIRljj+Lb6SG
	cyASz5Kp+yBWQUAR2zTneULf/6/X/I1
X-Google-Smtp-Source: AGHT+IGemsR0OuxveqoCLuvT35vA4jAjT0f4VTJglt6MI1GNIHLfcz8g6Jk7qZLukmNg7JdbfDQkvg==
X-Received: by 2002:a05:6402:4415:b0:634:6d87:1d28 with SMTP id 4fb4d7f45d1cf-6415e856c10mr2612380a12.35.1762643612939;
        Sat, 08 Nov 2025 15:13:32 -0800 (PST)
Received: from blackbox (dynamic-2a02-3100-a9b3-6600-1e86-0bff-fe2f-57b7.310.pool.telefonica.de. [2a02:3100:a9b3:6600:1e86:bff:fe2f:57b7])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-6411f814164sm7642807a12.13.2025.11.08.15.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 15:13:31 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 7/7] mmc: meson-mx-sdio: Ignore disabled "mmc-slot" child-nodes
Date: Sun,  9 Nov 2025 00:12:53 +0100
Message-ID: <20251108231253.1641927-8-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251108231253.1641927-1-martin.blumenstingl@googlemail.com>
References: <20251108231253.1641927-1-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The meson-mx-sdio (and mmc core) only support one MMC/SD/SDIO slot
(device) per host. Thus having multiple mmc-slot nodes (one for the up
to three supported slots with one device each on the meson-mx-sdio
hardware) can be problematic.

Allow specifying all slots (with their respective device) connected to
the meson-mx-sdio hardware in device-tree, while making sure that only
the enabled one(s) are actually considered by the driver.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mmc/host/meson-mx-sdio.c | 37 ++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
index e8b63dc45dd8..5921e2cb2180 100644
--- a/drivers/mmc/host/meson-mx-sdio.c
+++ b/drivers/mmc/host/meson-mx-sdio.c
@@ -493,23 +493,30 @@ static struct mmc_host_ops meson_mx_mmc_ops = {
 
 static struct platform_device *meson_mx_mmc_slot_pdev(struct device *parent)
 {
-	struct device_node *slot_node;
-	struct platform_device *pdev;
+	struct platform_device *pdev = NULL;
+
+	for_each_available_child_of_node_scoped(parent->of_node, slot_node) {
+		if (!of_device_is_compatible(slot_node, "mmc-slot"))
+			continue;
+
+		/*
+		 * TODO: the MMC core framework currently does not support
+		 * controllers with multiple slots properly. So we only
+		 * register the first slot for now.
+		 */
+		if (pdev) {
+			dev_warn(parent,
+				 "more than one 'mmc-slot' compatible child found - using the first one and ignoring all subsequent ones\n");
+			break;
+		}
 
-	/*
-	 * TODO: the MMC core framework currently does not support
-	 * controllers with multiple slots properly. So we only register
-	 * the first slot for now
-	 */
-	slot_node = of_get_compatible_child(parent->of_node, "mmc-slot");
-	if (!slot_node) {
-		dev_warn(parent, "no 'mmc-slot' sub-node found\n");
-		return ERR_PTR(-ENOENT);
+		pdev = of_platform_device_create(slot_node, NULL, parent);
+		if (!pdev)
+			dev_err(parent,
+				"Failed to create platform device for mmc-slot node '%pOF'\n",
+				slot_node);
 	}
 
-	pdev = of_platform_device_create(slot_node, NULL, parent);
-	of_node_put(slot_node);
-
 	return pdev;
 }
 
@@ -642,8 +649,6 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
 	slot_pdev = meson_mx_mmc_slot_pdev(&pdev->dev);
 	if (!slot_pdev)
 		return -ENODEV;
-	else if (IS_ERR(slot_pdev))
-		return PTR_ERR(slot_pdev);
 
 	mmc = devm_mmc_alloc_host(&slot_pdev->dev, sizeof(*host));
 	if (!mmc) {
-- 
2.51.2


