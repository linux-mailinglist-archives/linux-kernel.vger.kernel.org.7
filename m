Return-Path: <linux-kernel+bounces-888750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDBDC3BD2A
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 385503BF73D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662423451A9;
	Thu,  6 Nov 2025 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="BqiUnyFA"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D70344033
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439795; cv=none; b=abJGvLW66rImVBZPU6mto79Wl+lKbjGkrW7379RwreKkpZGoRXxeBjZjyBMSLGpxwheWea29VbfhXUm53M2werj1xVxlUn8f9WihQLh3eeNrn0F95xxndr7TOffZ8xyC7+nUGhSwO7L8CZW6ycrfKJiuEYxCnrR6LGq7iqRWTdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439795; c=relaxed/simple;
	bh=0Rs0cg6v3aK456W1TwBmzVlhKZcHd5ys8jD5bJHQdqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HomKgbHXV3SJ/99AEOKqjnrGUHqaOciauCL9v8f//6wDVVzb+gnsK7O5hmVrA+0t4fKRjR5qy/43izH6CogL2gjSJ5sUl6UKBhLBapBp8I2o2YvVnQ/14hCKC8KlFgnvle54JTLz2QW9wqnyJjx4pMsUFM9+ZPqShMLtcpPkIH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=BqiUnyFA; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477563e28a3so8464515e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762439792; x=1763044592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XE9x4fc+RYkdMj5Dyqr3FFUVL1ho5xKWs3x4k2mRU9k=;
        b=BqiUnyFAmaUiATROfZfca6cWy/dUFe9ei80fdZI8rky+Oz36M/6j4P/FbELMkkUl93
         JdvEfsA9i/XJidLRpIboisXCQvFAnR6ycYaKcI+U/ljIqPp0wB5SnKzyD6p6sQu0aMRD
         1OyZpwPCoh5bQzVERNDXBowFzfPcQAEv55OQVI4exAQd5I2L9rYF5WzzHDCIJS9j0BLm
         O/SG8lmBJnpv6c1V6CNN+oYuvMEeoD2BOiI2qCiCuogAunrwzYNs4p5+GzE++XGvmWYC
         QtmsMT175LnayNFNJH4q+CTwKyz/8jnPg35nPD6C5sqbqBtnv6Blz8sythMD4jqNnHCv
         nMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762439792; x=1763044592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XE9x4fc+RYkdMj5Dyqr3FFUVL1ho5xKWs3x4k2mRU9k=;
        b=rkubJ0PgbEtVLW8vr8L6Dt6SETf6fL+2kCkDYccAeMsJZ48Szh61OfZhLP9K0VoV9z
         weRm4+Iv5AHfq+z0FmgJEfeCQ9GmX1044/mxIIThLhs9U+tFolQ5TyGRHr6MfyqDw3iy
         fvsw/sQkcGXRDlTgOH3LJKZ3lhRjFr9gS/Pq5kNCKVkJpGGom+p4wiMA4URWe2WhZZW0
         pQTXXhmKEY4mt8jTJmFtUWnntTx+0Xeq0/hzEHFITb/xmu/5FdyrI4Vsze5/uR0LBybk
         sC+830jekQFrBauimjkoJnSn5/6L0RgLwIm132ekvu2kEjAvIIZ1d3W/Fdx66lvi9Whb
         F3wg==
X-Forwarded-Encrypted: i=1; AJvYcCVA9/wZdcuQ0RUQHoF7FC2XIqrcvB+Sb8pwAe1MruXrAlKLIBQMHUAJoSZyyNawAKl8OSZDrokinLF/JpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHyFNjDZBsta+/mMUeRgHrk7Sym9Z0hNP2QBSs+ZJeM74rftuw
	Wvyj7XWTUvkXzibo8HHJ6+cOK/VeaG8TptYNd/TdgzV0mlTOUGqofVhndQVBxxIBrlA=
X-Gm-Gg: ASbGncupF9Fu8LlAH0oG+xDVdz090Ui4DjxGhYwRB33EccRckKwoPB9Vtoy4MNBYXC8
	3muDwM4WbvfexxQxKljJEFNhkBa1eIssWr5JwRagX3rCHWnBPP3P/FSOiiIHA4kUqs6wJO7toGa
	yxE51KSCqImKSuwl9NxAfIeap3IBF1VdRyZfKiqFbfOERxo2trlH4ykOh6HRNGxpZTXnarXbyIP
	tcXTtgbqKBLK7L7XwbjdHJ1rLAPNoOmZ9IL1woXUL4Q6rB972buyUf7Rtu67RvrAJOiepIqoT4z
	hQFjfjEkDtVkzG/4AIQdqZ24CtBz/uJEJ6U+5ws0Ko6VvQiQh6AxPASQjC9agAZaKZWvUxreRsl
	Ub7fB+uW6Xap8s3fOZbu18ROg+GADu+bvcCIu3S/3AViL9evL+LwEp7y0khiEFtTmOf8jL8OZxZ
	vksdf8BkjqXH7IXykAFKEY2o6eLmAgfQ==
X-Google-Smtp-Source: AGHT+IEYmXAoxIWRbuO5Z5xzzS2DR8XcUCus9/JcNYZ03UIg/MNn6rvkUWlxrMimVAu8IkCZl+3psg==
X-Received: by 2002:a05:600c:35c3:b0:477:19af:31c2 with SMTP id 5b1f17b1804b1-47762030d69mr32505245e9.9.1762439792001;
        Thu, 06 Nov 2025 06:36:32 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce2cde0sm112185495e9.15.2025.11.06.06.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 06:36:31 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org,
	p.zabel@pengutronix.de,
	yoshihiro.shimoda.uh@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	kuninori.morimoto.gx@renesas.com,
	geert+renesas@glider.be
Cc: claudiu.beznea@tuxon.dev,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 2/4] usb: host: ehci-platform: Call reset assert/deassert on suspend/resume
Date: Thu,  6 Nov 2025 16:36:23 +0200
Message-ID: <20251106143625.3050119-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106143625.3050119-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106143625.3050119-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The Renesas RZ/G3S SoC supports a power-saving mode in which power to most
of the SoC components is turned off, including the USB blocks. On the
resume path, the reset signal must be de-asserted before applying any
settings to the USB registers. To handle this properly, call
reset_control_assert() and reset_control_deassert() during suspend and
resume, respectively.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/usb/host/ehci-platform.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index 57d5a7ddac5f..f61f095cedab 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -454,6 +454,17 @@ static int __maybe_unused ehci_platform_suspend(struct device *dev)
 	if (pdata->power_suspend)
 		pdata->power_suspend(pdev);
 
+	ret = reset_control_assert(priv->rsts);
+	if (ret) {
+		if (pdata->power_on)
+			pdata->power_on(pdev);
+
+		ehci_resume(hcd, false);
+
+		if (priv->quirk_poll)
+			quirk_poll_init(priv);
+	}
+
 	return ret;
 }
 
@@ -464,11 +475,18 @@ static int __maybe_unused ehci_platform_resume(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct ehci_platform_priv *priv = hcd_to_ehci_priv(hcd);
 	struct device *companion_dev;
+	int err;
+
+	err = reset_control_deassert(priv->rsts);
+	if (err)
+		return err;
 
 	if (pdata->power_on) {
-		int err = pdata->power_on(pdev);
-		if (err < 0)
+		err = pdata->power_on(pdev);
+		if (err < 0) {
+			reset_control_assert(priv->rsts);
 			return err;
+		}
 	}
 
 	companion_dev = usb_of_get_companion_dev(hcd->self.controller);
-- 
2.43.0


