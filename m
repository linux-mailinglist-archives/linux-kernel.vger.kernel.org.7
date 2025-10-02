Return-Path: <linux-kernel+bounces-839848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04833BB291F
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 07:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64EFB189A465
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 06:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B2728724E;
	Thu,  2 Oct 2025 05:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuX1zhDF"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C524225DCF0
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 05:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759384775; cv=none; b=S76WahzxMW6EzXG9ljg7zPM/LLcugBWlFjGV2+e4U/TTPUvmWtqxvXDZ/XSvd5rzMyW5pNN7WlrGVD2uAI8jDmDgBYE80vdPr7zdaOGOjNhjY/HixPFhcjqTt0/43LDYO86WsTryxWYosCTqtpl668t/9r4xwqLY2fsk0Hy/wsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759384775; c=relaxed/simple;
	bh=mdyh66CC0ysfpLTFQ/QCn8Fp6gsTGspR1xxD+UPCFlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JtRGlGm/D4d7G4j6YxZ/G5QQgeTqn46hb8dt7hHI7weYpqpaenfDoFTERN/D9J/oSOAtgYn3HesHDxzXWGjZ7Z8zpxSfbHKXYOz6XgZWSTznQZIc+FhmqrZqR+tW64eV6pQdXWrpMaVje29F/R61tlgl3HLSOh+cZIGzoVHvQBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuX1zhDF; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-26983b5411aso4137975ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 22:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759384772; x=1759989572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wRgZLcXLzz03eAT3wGnGVWClP73FxYDXA1esECAK3sM=;
        b=VuX1zhDFOiTAYiF1pAaySk9iPBGNuYedGceEylXurQSeI8lEBPnz5itSTvwR6TCgLL
         VyJz9YYnnzz4gVUSrtvCo+xGyUZ5DoayxZ0yLsRhasWMnHNMsJxgdTHwMtkjSS87oHCi
         7DajJ5fcS8q68j41QWcHYF2U19gRWRcm5B8UKpoUmO7ZKbMiGMTV1iRhuGPVoPEe+CKW
         P1UvXyL/ZVr6u1m0H2WO4wfg8gj4/RXD7aa84rCRwuetFBcR3kplrePKFmDCAGFZ6bX9
         OyNMPiRprCg4ew57W/9akJNeJvFCbfC/4EFjGmKsjlFQq02LtVLYNx1yPI5Qco+93kdk
         sRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759384772; x=1759989572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wRgZLcXLzz03eAT3wGnGVWClP73FxYDXA1esECAK3sM=;
        b=X4XoUi7ufMPziFFR+Aqdau6HB7fb3XGwRXXhdWD+ot4xlMy1Hfk04SM8LdOP3bpYzo
         keAIiroU4c2VLOj54Zp0bZbFqUcFXM9VO1ZkWb8Gv6Gfx6sNWykI5AUBYrnRDstgZnau
         tisnBJMJcY65pIOvLYy4yqjiNRrGZA4e4bAiIumNeduZAzLMHoADg/jLMh6A4/z6k7e3
         w0/+kpgUXHD6wBJGUcvQwHFe6JHqP3AkiISAZrpw0JJGtNRlZdgGCOILIbXLUWB2mPe5
         vH3sQBf9ZNKkUU9AWR1MY5Z9s7wdIs9WYliFsi/IaxEvhHTEPW1NtGmPa3cqeUWgIJEU
         hdmA==
X-Forwarded-Encrypted: i=1; AJvYcCW+/73CHJlKSNWhwD6Df8UUJa9HZu77cwIW15mLwOdj4PeRJ0HZESaxegiHAz3PvuZ4RR3Ce4kuTuVGCZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy281Lxhc2cVh+ALZQPjH3ahZ4EB6LpT0+x1aCGGA13cSPI9lPW
	/hwK90H5hybOvfwYmo1g6PfOgjT9chP+MYDkxfhX+jy/NwtpVonkJwRF
X-Gm-Gg: ASbGnct9fdYYSHF0j0SzSpkSIUZgKI2Vr5BUm3xObo0gaUcKZFHOCeEIyRumroCZJ0m
	uwTpdSLROhlfa5vyNTzAqzHudIIord/FKcXk66HM20lyV/L0Mt1czKMR820x88RlveGHFEiiS/S
	INVm5ffNd4YFWSOB/1bnubM94AtmxYCeUvvXtE3rTbh4SgAwkXk/0CyAxi/n/1JMWMhAz8x/gp7
	VOPThJxuiUFbAVB1OME5P4wWQwe4B2+IdVIu+cKxSdoUIDKw4Jl2q/RgdBTRMQHu2E2+1K+vHjk
	0XVALASlFekiRxkCjHorASXkKtOqkrUn2qDThcNNJL8uJ3juNrcTF4HKQ1y/gaO23TuaoAlI9XK
	TwwXq/4UwtmpNK05nK/JVC7TUlnmsOt72Pr8nCu9ZqZrPZ4IYIkwMhuAQPQ==
X-Google-Smtp-Source: AGHT+IEI3Vb0J4n2AX9BCIN6IjNRBOS53dIxW7SLq3sxkWkjnmbHQJDW5bVwptM7DeJS4pTCdX672Q==
X-Received: by 2002:a17:902:fc48:b0:28e:681c:a7ed with SMTP id d9443c01a7336-28e7f2f4f3cmr94645845ad.36.1759384772065;
        Wed, 01 Oct 2025 22:59:32 -0700 (PDT)
Received: from fedora ([172.59.161.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d24fdsm13543345ad.93.2025.10.01.22.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 22:59:31 -0700 (PDT)
From: Alex Tran <alex.t.tran@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Tran <alex.t.tran@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2] gpio: gpio-grgpio: call request_irq after incrementing the reference count
Date: Wed,  1 Oct 2025 22:57:27 -0700
Message-ID: <20251002055727.1488237-1-alex.t.tran@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove extraneous dropping of the lock just to call 'request_irq'
and locking again afterwards. Increment reference count
before calling 'request_irq'. Rollback reference count if
'request_irq' fails.

Suggested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
---
Changes in v2:
- converted refcnt to type atomic_t
- utilize atomic types API for refcnt
 drivers/gpio/gpio-grgpio.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpio-grgpio.c b/drivers/gpio/gpio-grgpio.c
index 0c0f97fa14fc..e4fa84e22726 100644
--- a/drivers/gpio/gpio-grgpio.c
+++ b/drivers/gpio/gpio-grgpio.c
@@ -46,7 +46,7 @@
 
 /* Structure for an irq of the core - called an underlying irq */
 struct grgpio_uirq {
-	u8 refcnt; /* Reference counter to manage requesting/freeing of uirq */
+	atomic_t refcnt; /* Reference counter to manage requesting/freeing of uirq */
 	u8 uirq; /* Underlying irq of the gpio driver */
 };
 
@@ -242,30 +242,22 @@ static int grgpio_irq_map(struct irq_domain *d, unsigned int irq,
 		irq, offset);
 
 	gpio_generic_chip_lock_irqsave(&priv->chip, flags);
-
-	/* Request underlying irq if not already requested */
 	lirq->irq = irq;
 	uirq = &priv->uirqs[lirq->index];
-	if (uirq->refcnt == 0) {
-		/*
-		 * FIXME: This is not how locking works at all, you can't just
-		 * release the lock for a moment to do something that can't
-		 * sleep...
-		 */
-		gpio_generic_chip_unlock_irqrestore(&priv->chip, flags);
+	gpio_generic_chip_unlock_irqrestore(&priv->chip, flags);
+
+	/* Request underlying irq if not already requested */
+	if (atomic_fetch_add(1, &uirq->refcnt) == 0) {
 		ret = request_irq(uirq->uirq, grgpio_irq_handler, 0,
 				  dev_name(priv->dev), priv);
 		if (ret) {
 			dev_err(priv->dev,
 				"Could not request underlying irq %d\n",
 				uirq->uirq);
+			atomic_dec(&uirq->refcnt); /* rollback */
 			return ret;
 		}
-		gpio_generic_chip_lock_irqsave(&priv->chip, flags);
 	}
-	uirq->refcnt++;
-
-	gpio_generic_chip_unlock_irqrestore(&priv->chip, flags);
 
 	/* Setup irq  */
 	irq_set_chip_data(irq, priv);
@@ -306,8 +298,7 @@ static void grgpio_irq_unmap(struct irq_domain *d, unsigned int irq)
 
 	if (index >= 0) {
 		uirq = &priv->uirqs[lirq->index];
-		uirq->refcnt--;
-		if (uirq->refcnt == 0) {
+		if (atomic_dec_and_test(&uirq->refcnt)) {
 			gpio_generic_chip_unlock_irqrestore(&priv->chip, flags);
 			free_irq(uirq->uirq, priv);
 			return;
@@ -434,6 +425,7 @@ static int grgpio_probe(struct platform_device *ofdev)
 				continue;
 			}
 			priv->uirqs[lirq->index].uirq = ret;
+			atomic_set(&priv->uirqs[lirq->index].refcnt, 0);
 		}
 	}
 
-- 
2.51.0


