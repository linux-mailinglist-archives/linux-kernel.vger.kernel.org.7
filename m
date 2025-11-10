Return-Path: <linux-kernel+bounces-893243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CE9C46E67
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F0713B817B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C843126A2;
	Mon, 10 Nov 2025 13:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="LB5621Lb"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F66130506A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781248; cv=none; b=W2GcoSV02dP388zCcBnqO4cEIGbLh1pjZUu8pqdd0HTWkoYZQVaL3olXiK/AA28piA4/0p7x2XL5lBJnRoy0UnnF+PfXv1HZ7I/yk6sotAiL4Y8vgNfj2O0oP3i1wtYCkzt8tjZyZb/+t8Ix2Fw7k9nangTt9UBIVFD6LU8PrlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781248; c=relaxed/simple;
	bh=IIDuvIHOQMTTGnrfyStRhncgP5pNPZi9zbkhUN5IVBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Km8is0s2+lnnnNZQW/aJRP5mg+AWwIIcqrWpZXXTKNTW1gX/zKswjCaEE8bboHj260gOfex33MQg7HrzM0rG7/CwLxZyn4iQkFqcmbqIe99iCZNiJ2SdpigTpzm+XDKtXIoZTa1bcYQ3ZukApSVnBSNEnoRDT8Ghe2t5TgVe61g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=LB5621Lb; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4774f41628bso14169235e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762781243; x=1763386043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zONaySYMEiPNqUd9TkBEU3WH4GqP1i4c3+qu1BbIJh4=;
        b=LB5621LbtkT1Nj5ut9g4V0TjfmEUgPtLS1GSLRSveqA5ls8kYA4N7IegQXaXpvZe/X
         3JxZlmn3UhjZXohgFFbPDw4bKDwkeXLW1rT3tY1+RWrsePsXSo5e3kyOldxrT3ePQnIF
         XfwHiiyByVOc+G5u9i81gLqUq0FT1VeWw4udLd4E3k3pH2Rb8cpQ83y49YRjT/X6y8GB
         2Gt36bU1VEbGl0BKutvYMRh0DJtdOn6n6YFTV+bUc8ZRgRFXv+QtggCk0LVoN2pYxFuz
         c3UZd6kVTawJBDkmA+GdjdCLZAMwYNYUDX/u6NJVPrmAH88yEnyIOobisU3VG3NdQG7H
         gkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762781243; x=1763386043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zONaySYMEiPNqUd9TkBEU3WH4GqP1i4c3+qu1BbIJh4=;
        b=JiceoMjuPkyvdh1Yf0KIVCNj4WlNEGIQ9HKpx/iz5uXv5y/y+3eq+lOnTWQFz70mJp
         BUZ4/vcNvULmc0ASkBpudGJH6VENCr8KpWyDD32CDMuBdKJrWClbg3lcFkU1AanG/a3y
         3/XmPW+NCvaSDUc1XqwWh5+fNpjngtglmY2qMU0UgHPCHmIesAs/nHTjYWYHXt+EMQtO
         Sizu45vCQlyAcA8O8QLwhUqzRLgJeTy21YNOlJl/7rInRILIylCsyGQktAsJLn/XJeY0
         iMc5CUNc/tZf59Jqe+Ga+i1i5zu6s+6iSbWdV/8uOyqcXl0O66CoAnnShQr5K17ZqkqC
         uTuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLK+pguikzCcXBlUOzc9ArjVbLSMj46dYFI8KTTsyPNsVqlVNyWvJRy3ItZMIwLvESnZ/7mDHavS6BkVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7QhLFvKJJdAvCzdPMQe4JuSx/so9/D6M0+INrf77PdvVbA/RQ
	khQgtnH0FsjhO7/DdNhpWS/hN+0VScJl8bnFUIoZwqlrTKepfdPdFHK+VLbalsAFqqd6iiXinFy
	1euMz6HM=
X-Gm-Gg: ASbGncseFs8cNAWygBX31jfuuJ1Y3byE76EQlA/oa3ORW7BWg8NP0TBQ9QOPLTSeEJz
	6s77p7SktASTT7/fNHcTlNDu6Jp0izqE/n95khFHEdbfGgVlKjvFkPX858IO71E0ZEP8ztqU+Pp
	H4ZsFt4nvxq99mDZkxL1smecLZrkSxB0Ow4csXluuWp1HvMLjfPzlZP7WZ68WIJ/2ri6aOaOLv0
	f2V7sYfUwD2iZ8bb4lIgEf7qM2x9Xn4tJ3YX1pAoCan0FFxsFFVl316mmvoXLHiJ1OY/ujjd/YP
	086EIl4ZL2bhS7z/CyyY666z6MAkJ0i5uvnZTmpVlmiRkJY1W56QOdKc9udJ+TZ0Nz7o7+CAli2
	ho2ayWK1eZzIGKO4sNJlDVGVtwXL8T7NQldipm+yXQSdcJjkAIUXGyRQCAd/ig+zVVUrNsaLJuy
	rZzB+neRIFH3blhrsRCUqjS7F4SxovlIUhvAcsmxM6
X-Google-Smtp-Source: AGHT+IGRjW5jYXUQs3FMSK3rF2Zk8OgQrLJjOb7vJvXyAistMoH7ZmxUoheJZm9Vj55JPADLzlThSw==
X-Received: by 2002:a05:600c:37c6:b0:477:78db:19ca with SMTP id 5b1f17b1804b1-47778db1ceamr53254255e9.3.1762781243335;
        Mon, 10 Nov 2025 05:27:23 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47778daf2c3sm94207025e9.10.2025.11.10.05.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 05:27:22 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 1/2] reset: rzg2l-usbphy-ctrl: Propagate the return value of regmap_field_update_bits()
Date: Mon, 10 Nov 2025 15:27:14 +0200
Message-ID: <20251110132715.724084-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110132715.724084-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251110132715.724084-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Propagate the return value of regmap_field_update_bits() to avoid losing
any possible error. With this, the return type of
rzg2l_usbphy_ctrl_set_pwrrdy() was updated accordingly.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- collected tags

 drivers/reset/reset-rzg2l-usbphy-ctrl.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
index 4ecb9acb2641..9ce0c1f5d465 100644
--- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
+++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
@@ -117,13 +117,13 @@ static const struct regmap_config rzg2l_usb_regconf = {
 	.max_register = 1,
 };
 
-static void rzg2l_usbphy_ctrl_set_pwrrdy(struct regmap_field *pwrrdy,
-					 bool power_on)
+static int rzg2l_usbphy_ctrl_set_pwrrdy(struct regmap_field *pwrrdy,
+					bool power_on)
 {
 	u32 val = power_on ? 0 : 1;
 
 	/* The initialization path guarantees that the mask is 1 bit long. */
-	regmap_field_update_bits(pwrrdy, 1, val);
+	return regmap_field_update_bits(pwrrdy, 1, val);
 }
 
 static void rzg2l_usbphy_ctrl_pwrrdy_off(void *data)
@@ -138,6 +138,7 @@ static int rzg2l_usbphy_ctrl_pwrrdy_init(struct device *dev)
 	struct regmap *regmap;
 	const int *data;
 	u32 args[2];
+	int ret;
 
 	data = device_get_match_data(dev);
 	if ((uintptr_t)data != RZG2L_USBPHY_CTRL_PWRRDY)
@@ -161,7 +162,9 @@ static int rzg2l_usbphy_ctrl_pwrrdy_init(struct device *dev)
 	if (IS_ERR(pwrrdy))
 		return PTR_ERR(pwrrdy);
 
-	rzg2l_usbphy_ctrl_set_pwrrdy(pwrrdy, true);
+	ret = rzg2l_usbphy_ctrl_set_pwrrdy(priv->pwrrdy, true);
+	if (ret)
+		return ret;
 
 	return devm_add_action_or_reset(dev, rzg2l_usbphy_ctrl_pwrrdy_off, pwrrdy);
 }
-- 
2.43.0


