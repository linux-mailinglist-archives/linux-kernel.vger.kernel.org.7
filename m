Return-Path: <linux-kernel+bounces-835223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DCCBA6875
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 07:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DFAC18961ED
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 05:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02322298CA4;
	Sun, 28 Sep 2025 05:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHCenmbi"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48F0194137
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 05:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759038091; cv=none; b=B0ueDohSm9ulnDorXsYi9BhLpvxwkApxBuBXYz5pUmnpeP+nGrDZHwpSgYltDBY+tr72Bi/szCK8NJQHnHGKcOHFne/Jkf1Eeh0E3geNBNBVmMEFTpOs+gi/H+BzJkHgjA5rh/b1KdyRDx2XFCGz+CGWKr0la833ubby/tmcFUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759038091; c=relaxed/simple;
	bh=S0v1gHURYMdw1yi6PKnRpYcVfrORhPmC76eStiDMp8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YOk30/Tl6pSKsYWqkXuCGTL5dbsamHqvKUKQQv3JIUZBpTAeoqwv3ymFgDbs8zyBoU59Nzn+w2mxBx3L7uVKZvTElyfbhnRkm45eEWC9V1vikGUz1ojDK6LzlqylrxM4OitboLX12xLHb+20pkmrRguXk0bOWPd6r2M9lWMxaAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHCenmbi; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27ee41e074dso30062675ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 22:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759038089; x=1759642889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BIwshfVuzFnOMAKrYLI6jEhBWZi5IYNs9VlFFa/dZNM=;
        b=gHCenmbi+CUm+y9X4UKFg/5Y3cvwV+nJHPkAiWVWC/p1grh5USHHfBcMftMRxVywth
         iCfsEzXT1mL4NMkMw9eiUVqsKWs8L4MsBcbSg27hDeIOgjnbPJjNZ3Tsn4xl3WBzqMca
         C+scI0jx06Q0VpW/7l20Q5CK4YIM0UP8Z7nZTz2s6UVheSXPooQMiiylwG3sX5aVH6rg
         L+Ijtz2lQ2kHLROIDky63xEIQnvsxmhmqxnn21nYP9wJq/e47OtdtuqkWxMvSs9nG2OD
         v3mws+ZoDlrB5zBt2xHyCxF9Z0wNXdIKexydjwsWQEQzG48EQOxM0WudjtyX5UudxyXQ
         zEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759038089; x=1759642889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BIwshfVuzFnOMAKrYLI6jEhBWZi5IYNs9VlFFa/dZNM=;
        b=KeHrI56ICW2CtKJumzn5fybBNOUzIBxCWg00G5IrPX/ZOngzeCULiJ5oIPec1IXid0
         jUa8cS6OBAnBFgJtTFPL87r4E2ZIEV6fHbAPIoXBBVDGTsdP46zRMm7cFNL4Ba5jXZHF
         vvyXCtA0JrPav+EKbbXif9yp8IC+ecP2SyCnaTjBNZEAsY8tTCRVoA8j0/Ct8YcQKHF6
         Er1k+c75e+YyU4iUd8on6/sNAusCmnfQiIgxO/e6fLo4+nrf7dspVIkdgd+vt2WdKEKd
         D5yyYuzHE1gDEnJAywzGdw606J9uQlr+NP4WMK79as5exmGQgsVe4o2RSHAeqwpuo+zL
         Omig==
X-Forwarded-Encrypted: i=1; AJvYcCXvvgSDRyp5re1TKwngJpjelLqz0vfSJtLlhtBX2FAMqeBHrmfQ8MsNV52KHQGmllDVunwlYyTapdYWnko=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDbntwJi0hNqwB4WiNt7yZoRFm2GtvqgHtyvn0IdGez4lHM4Tg
	bO+W4oxpQw8ioydyX7DfNh9b96WSJaEMYYXUVxzltIYZ7LPjsRUs+QEe
X-Gm-Gg: ASbGncsUQuHuI7+XoTKTdsqQFNltnHJ5N/UiPjKeq7d/3WBHZrvwSTnbhGSTiPeJRbE
	xLW9iQ3bSHZjt6Exq7ZCDb3i1zqBQbMkuOemKXKx6hUy5WVYA7ZmWme5QYGhqxVyMC8UrMpxwyr
	/eH93FgGegy1XhyOggxsnb0ahFNtpt5GuUiFUB4Ed48HHIp8UreEuwpfBTs/oEj9qdoNNtki4s9
	+K8XeCU4t8LNz52TCfNko9LPgLcpwNDR4RIMyB4BKWVrh/7I1YXd1n/1bcVN4PqCZu1edsjgMYT
	vsZEw00sGnnUvGKnpvBHcNj5+EnREvrJAG0dop/eRS/1KKBsmEPmdhrSsnR/ttazAaVfudQWk98
	OFUQtLQfztD9P6GUIhguMGVyPqT+Kyxrs8soUe8Sk+aFh
X-Google-Smtp-Source: AGHT+IHgKzmQxn3LYtCYg7KtWdGt8UUYN/QqgIJUJEq3IBbdnq2sdaotugj5GIiwi4pi2voIkLiz3A==
X-Received: by 2002:a17:902:cf42:b0:267:95ad:8cb8 with SMTP id d9443c01a7336-27ed4a96047mr129802575ad.44.1759038089009;
        Sat, 27 Sep 2025 22:41:29 -0700 (PDT)
Received: from fedora ([172.59.161.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed67076ffsm94429295ad.39.2025.09.27.22.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 22:41:28 -0700 (PDT)
From: Alex Tran <alex.t.tran@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Tran <alex.t.tran@gmail.com>
Subject: [PATCH v1] gpio: gpio-grgpio: call request_irq after incrementing the reference count
Date: Sat, 27 Sep 2025 22:40:19 -0700
Message-ID: <20250928054019.1189591-1-alex.t.tran@gmail.com>
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

Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
---
 drivers/gpio/gpio-grgpio.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/gpio/gpio-grgpio.c b/drivers/gpio/gpio-grgpio.c
index 0c0f97fa14fc..18d972fddfac 100644
--- a/drivers/gpio/gpio-grgpio.c
+++ b/drivers/gpio/gpio-grgpio.c
@@ -227,6 +227,7 @@ static int grgpio_irq_map(struct irq_domain *d, unsigned int irq,
 	struct grgpio_priv *priv = d->host_data;
 	struct grgpio_lirq *lirq;
 	struct grgpio_uirq *uirq;
+	bool needs_req = false;
 	unsigned long flags;
 	int offset = hwirq;
 	int ret = 0;
@@ -242,30 +243,28 @@ static int grgpio_irq_map(struct irq_domain *d, unsigned int irq,
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
+	needs_req = (uirq->refcnt == 0);
+	uirq->refcnt++;
+	gpio_generic_chip_unlock_irqrestore(&priv->chip, flags);
+
+	/* Request underlying irq if not already requested */
+	if (needs_req) {
 		ret = request_irq(uirq->uirq, grgpio_irq_handler, 0,
 				  dev_name(priv->dev), priv);
 		if (ret) {
 			dev_err(priv->dev,
 				"Could not request underlying irq %d\n",
 				uirq->uirq);
+
+			// rollback
+			gpio_generic_chip_lock_irqsave(&priv->chip, flags);
+			uirq->refcnt--;
+			gpio_generic_chip_unlock_irqrestore(&priv->chip, flags);
 			return ret;
 		}
-		gpio_generic_chip_lock_irqsave(&priv->chip, flags);
 	}
-	uirq->refcnt++;
-
-	gpio_generic_chip_unlock_irqrestore(&priv->chip, flags);
 
 	/* Setup irq  */
 	irq_set_chip_data(irq, priv);
-- 
2.51.0


