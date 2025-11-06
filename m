Return-Path: <linux-kernel+bounces-888752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EEDC3BD1B
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C6ED1893DC5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAB9345CD5;
	Thu,  6 Nov 2025 14:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="XsKb/r75"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C81B32E695
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439799; cv=none; b=ma6BmbuisZOrr79vLUROQdhGwaIyv7nSVXUw/EmeYz1NOoGKh4g3HLis0kXmidPY5WPhn5/HbQ2DaSSHaud0LXqieTn6JGBKK9MZ9zRsIsvOyGeU97e5n9GNuJB8F5yCauP1Y0Sd7iMrS6+1bykZkMLv+qvZM7BTdyDhkO11GoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439799; c=relaxed/simple;
	bh=HLxsmV76ehddQN8d76HFTrl6xNiKy5eHzSIhXA5dsmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJbX4nBsLMiM5OiiaVxlDOi40+QPTrDipIniYF+vb/oL+xvFAKEkkDB+EokT6xiECZDSN+3s737BTgBAONMNlX3ReHbAQjBG22K/TzqojMNA5hG61OCrst0vu/vr0Fuj4CZdkAEKvYIJ3pyUIiQJ3h48FErDDjbNrone2BsYLlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=XsKb/r75; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47728f914a4so6298045e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762439795; x=1763044595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwweW3VPRm8jVDmzvseiBOYWzO9CKnZgrSha6jb9mzw=;
        b=XsKb/r75CoRvVdoB20dF/p6RE2mSqr4Aqnc0D7YmEr6knednGjN4g5K1I5SJmmwo6p
         0gy2A0OtzmMq2TclaTXKlvQYREJH0HDRjGaj2r1zjmAZIJQVURVhjqlq6Pn7ctt1y1PE
         UZ8aTwE92QYrfyY7FnL0CVET/4biqltc23d++hwmNOPmABa40teJEUzOz+X6/4Kj4zYF
         tMte4sW79PaLwyC8A1G6i7e3PolnkqgaCLup5XNEouQ0NzS+NStqsv3ZSAcQxPL1jiyi
         b3uY2FtTZKr/Ntj5oj4eiu64c/CySamVp3Czgoyqb1NdQQ8Bqg3EnRhRfMg5C+d/fCAn
         VRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762439795; x=1763044595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uwweW3VPRm8jVDmzvseiBOYWzO9CKnZgrSha6jb9mzw=;
        b=rvluXETMVMqITZGZFSc1xroBmdUZdhcQzeM7JKc3FY6SdOZ+tAYdFYzOfAgOfLcdhv
         f13D/ohDResQAVzVELX8hPKKwvpuMdxRi07jMbYsG8bIcKMaHVL3yLhwLVoFJGAI1iI+
         HHcl5XI2artwGaEIguuSETqIAZIg68ZFvPd8yF6aVpBajC3MyI4wlj6JzxMCslLWDf5+
         6qJ4mCd4QeFTx5mi1HyWfkxm09QCWOEEknpBy8KqODeWGGzGfSAukpxHbXkuSLc5WFZz
         /2IcltH71ctjE/35mFm+IjG47Jlbc5P6UkguH2Mdu29aP2NsH6hgTjVixbtid/kXwVVw
         I7YA==
X-Forwarded-Encrypted: i=1; AJvYcCWGc3sVwoBVYO2OJJi/n0ItFoJ0t+iyDbfmdfp+vmLy7FkQGhL3bwKoTCqqTIhnxfkfEfKSTqZzuzCrtEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz95YGFjWjAbE4uRF17wvy5UOzcsD6jgbU0JAnAWdkDLwWcuBq7
	zExcqDF9KyRVePmY5kZBP8PDV7oYmCR3VpNcQjvUPSntX0A6sPm82HyUJE3Poe52ojE=
X-Gm-Gg: ASbGncsms8x0/8S3xBqOqPJymDNqGwb9mpNucyVTKu9L6uTzt98lnF5rIzqGXqVdHYL
	IIRF0No2P6s1RQQAFpAmAI1oTWhdgWn6ESdpqWhcypr+/Pspo7FucK7nNxFJCope9iXCUkQr1t+
	3zklmQvP2V7quKqXXNCEe9RpTbwXzPGzFl4VuU5LQ+1cuhmBpKaQFHWI+fMHh4c0N2+TeYNX/u4
	/IP6YWeNvCCFpekJIO4yre/z/OoAPqJp5vqHweau7emPIdRE6rNcCe5hU7aEcv6aSSHLpm2GH5N
	fNxz//AjCyN+q3g500ubUNHRS1ybvvKmTw0Wby4yDnGmOjt3N7wm7ZokMA7gNAvjphTN/kgxdFu
	Vjib0YPkfPLap2/D6PwyWDLeAYprdsMeCjMyJU8GjrsYCqEmc1nzEO0llLN4n7aNc0PsHE+o/8s
	B8r8eCnFU/rbYpF9BgAYZmDs6L5JQOBjRaku8olwSB
X-Google-Smtp-Source: AGHT+IGGbNMu5TPPDVt6ESZjoI+4K6fRzX8Tg/wskLMEN2NLbcif0mgNZCyLd/u4ReVocqUwcHhm0g==
X-Received: by 2002:a05:600c:4703:b0:477:639d:c85b with SMTP id 5b1f17b1804b1-477639dc896mr28168675e9.2.1762439794670;
        Thu, 06 Nov 2025 06:36:34 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce2cde0sm112185495e9.15.2025.11.06.06.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 06:36:34 -0800 (PST)
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
Subject: [PATCH 4/4] usb: renesas_usbhs: Assert/de-assert reset signals on suspend/resume
Date: Thu,  6 Nov 2025 16:36:25 +0200
Message-ID: <20251106143625.3050119-5-claudiu.beznea.uj@bp.renesas.com>
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
SoC components is turned off, including the USB subsystem.

To properly restore from such a state, the reset signal needs to be
asserted/de-asserted during suspend/resume. Add reset assert/de-assert on
suspend/resume.

The resume code has been moved into a separate function to allow reusing
it in case reset_control_assert() from suspend fails.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/usb/renesas_usbhs/common.c | 35 ++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index dc2fec9168b7..cf4a0367d6d6 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -827,10 +827,26 @@ static void usbhs_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
 
+static void usbhsc_restore(struct device *dev)
+{
+	struct usbhs_priv *priv = dev_get_drvdata(dev);
+	struct platform_device *pdev = usbhs_priv_to_pdev(priv);
+
+	if (!usbhs_get_dparam(priv, runtime_pwctrl)) {
+		usbhsc_power_ctrl(priv, 1);
+		usbhs_mod_autonomy_mode(priv);
+	}
+
+	usbhs_platform_call(priv, phy_reset, pdev);
+
+	usbhsc_schedule_notify_hotplug(pdev);
+}
+
 static int usbhsc_suspend(struct device *dev)
 {
 	struct usbhs_priv *priv = dev_get_drvdata(dev);
 	struct usbhs_mod *mod = usbhs_mod_get_current(priv);
+	int ret;
 
 	if (mod) {
 		usbhs_mod_call(priv, stop, priv);
@@ -840,22 +856,23 @@ static int usbhsc_suspend(struct device *dev)
 	if (mod || !usbhs_get_dparam(priv, runtime_pwctrl))
 		usbhsc_power_ctrl(priv, 0);
 
-	return 0;
+	ret = reset_control_assert(priv->rsts);
+	if (ret)
+		usbhsc_restore(dev);
+
+	return ret;
 }
 
 static int usbhsc_resume(struct device *dev)
 {
 	struct usbhs_priv *priv = dev_get_drvdata(dev);
-	struct platform_device *pdev = usbhs_priv_to_pdev(priv);
-
-	if (!usbhs_get_dparam(priv, runtime_pwctrl)) {
-		usbhsc_power_ctrl(priv, 1);
-		usbhs_mod_autonomy_mode(priv);
-	}
+	int ret;
 
-	usbhs_platform_call(priv, phy_reset, pdev);
+	ret = reset_control_deassert(priv->rsts);
+	if (ret)
+		return ret;
 
-	usbhsc_schedule_notify_hotplug(pdev);
+	usbhsc_restore(dev);
 
 	return 0;
 }
-- 
2.43.0


