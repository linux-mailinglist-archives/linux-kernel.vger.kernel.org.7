Return-Path: <linux-kernel+bounces-804608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85360B47A66
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 12:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29F543B2C2E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 10:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C2A23BF9C;
	Sun,  7 Sep 2025 10:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="hc03FQYd"
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067101DFFC;
	Sun,  7 Sep 2025 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757239825; cv=none; b=QaaNMTcBuRC+PC8s223vNCs5SXaMGVH0ymmmk1ym9CXc3C7/OmI4mEYiSy4XvMyGnyIRg7l2iDUvvHaWgM9LoxBBAdUvBikd9tj8FgqvF71TG22/sh6ygdggsP7pq4/3EMuPOqDRZDHP31K1+eey6Itq80ulvP1WcGPnRwPN/NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757239825; c=relaxed/simple;
	bh=/NGT1Qkl+yYDAgztruIk9vnxR8tINNuLHgUV8TQ9ORU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GeRAdr6bxNQTCjQvHKH8LwdEvmfB+MP5BeeaJS91O1oFJF6Sz7WHsjCCVwwPPbQIYoP7zoJuVSVowMa8c7T7QSj93D7vDYVA1T7CQjEx2i3IcxKVvfSYpRm1ufl2F5zlfeAQIT8j7viai+0vEyaJ5t4+qplA3/E76ncblA0WRWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=hc03FQYd; arc=none smtp.client-ip=80.12.242.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id vCKfu08fdECYkvCKfuuyyI; Sun, 07 Sep 2025 12:09:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1757239754;
	bh=uA4HeivR6PVwO0g+VXDUo1YMd6lQsA63AuQAC1Ts17w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=hc03FQYd+h7OwC6H/vvKaATLVZczj65zEP7xYfci0Xb6iwFAQBsN6yvDLBntbN5Wc
	 lsxNvHHR7YHrrfK6fnYoOPWnkehPB+xN1lKnfAr1hbo/RZakTBvKC9EizmohQR95Az
	 Dt7K6eb8EFDmhs8ub9R8Nv/HUAczEMZD+NBSkz3hJuF9ABag95K5gg7n6NdA9kQcah
	 D9N2ggCcxZFe1YYuvyl7qPV+A6I9ohKaVKxB13x1PYdO+1irPeuXmK2F8Go5U8S1dT
	 pkn4izdTl9AgCht1dtv26+db7m2xnb7Bi5AwGPW9PLs96E5y2TZ8jSyfPSWWo1n2wZ
	 2lZNKHZdAPHBQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 07 Sep 2025 12:09:14 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform/x86: xiaomi-wmi: Use devm_mutex_init()
Date: Sun,  7 Sep 2025 12:09:09 +0200
Message-ID: <bb5d7a57e11eb580f610276a351a01a993341fb8.1757239732.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_mutex_init() instead of hand-writing it.

This saves some LoC, improves readability and saves some space in the
generated .o file.

Before:
======
   text	   data	    bss	    dec	    hex	filename
   3520	   1112	     64	   4696	   1258	drivers/platform/x86/xiaomi-wmi.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   3069	   1040	     64	   4173	   104d	drivers/platform/x86/xiaomi-wmi.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/platform/x86/xiaomi-wmi.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/platform/x86/xiaomi-wmi.c b/drivers/platform/x86/xiaomi-wmi.c
index cbed29ca502a..b892007b9863 100644
--- a/drivers/platform/x86/xiaomi-wmi.c
+++ b/drivers/platform/x86/xiaomi-wmi.c
@@ -26,13 +26,6 @@ struct xiaomi_wmi {
 	unsigned int key_code;
 };
 
-static void xiaomi_mutex_destroy(void *data)
-{
-	struct mutex *lock = data;
-
-	mutex_destroy(lock);
-}
-
 static int xiaomi_wmi_probe(struct wmi_device *wdev, const void *context)
 {
 	struct xiaomi_wmi *data;
@@ -46,8 +39,7 @@ static int xiaomi_wmi_probe(struct wmi_device *wdev, const void *context)
 		return -ENOMEM;
 	dev_set_drvdata(&wdev->dev, data);
 
-	mutex_init(&data->key_lock);
-	ret = devm_add_action_or_reset(&wdev->dev, xiaomi_mutex_destroy, &data->key_lock);
+	ret = devm_mutex_init(&wdev->dev, &data->key_lock);
 	if (ret < 0)
 		return ret;
 
-- 
2.51.0


