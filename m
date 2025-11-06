Return-Path: <linux-kernel+bounces-888745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FA6C3BCD3
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC2171B2335F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9910B345CCE;
	Thu,  6 Nov 2025 14:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="OwSx66OX"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF0B345CA3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439627; cv=none; b=Fw0dUs3gwpahA4jfINONwTlihyQztPYN/junXm+Qn4GLaTajshlnFHw452Vx7bJMnzS7VTFEhquWCNsGQlpkkT0A8blOw8FCqEcKfssLIiphvCOpQfN0XaIPtxV75nfIKzmlteJ+1hz9i4GsTGT+r2VJi5Sxa1YFNz64GnNg0uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439627; c=relaxed/simple;
	bh=hEEq3L/ae0gzj3WOpTnXOnr4UtTzIJ6EJy/sUAFo6Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8aEkHovxD/JUBMyK9NbnQMaIOJR72YGYtdSYVRTXTydUcCzTOHFZ0+xjd29OKRkM3jln/nTGNSSTXioW1CK3W3xPhEZsXm2flsK/3xlOYJ557fqGwWxfW5W5Od+g5MWTbB8W2HZ0jTitrPRFQbnFABU+bJNHlKOIixx2vjeKYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=OwSx66OX; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4775ae5684fso5648645e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762439623; x=1763044423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRcWCjtMlDilsyvDCHSRbviA39Wwxv3mD4ityVRjVRs=;
        b=OwSx66OXXlLrGcWhuoOoB2voImus+qS3NzEXEyxNNZ/EJgnxpEX/lft7HS7LjNn6vt
         b2ZEd6emmxeyUzzpAMz6Z5h3ESPvict9FNkHyiQFljCeyZ7PbZZBFoFQAOnPYvHi0zVf
         l5jMnXb4EzpFMiQ0zf9MpK0Op3MtQ4Vbr/txKpdBg9BEEHeWhddht+KRG8ALwLifSsQk
         MMUs3uHx1XtL0S0Z9Ks28MQX1uSM4UrYpsuPFLm/WFh7y14QAEoJxYCIe/Ue/uKxszWl
         usbiGv+DZ/mHHeLAyKIj+RpiQ1vMZuFrv6p1im4wPYfWdAASPRfgcSRjd8Zke03XlkYo
         I+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762439623; x=1763044423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRcWCjtMlDilsyvDCHSRbviA39Wwxv3mD4ityVRjVRs=;
        b=ZGFEyFgvGiiSzXTxA/G6iZ0vfBI3n3mPAFlDYIK+htyre4VPHEB4BicpVtndzKjiHs
         uVYREeE+qxyzbFfjs7HyBKnUTSxzR2qBAptNk/sSDxuupuJH4z6hIjFXz3TQdaNCoSfk
         x1Ye0sy9Iz7pAp7qypFpJASPbbDrhapgWBKo7xPItc4NeU8q38a8GUlWjXDZZdyUevPj
         8A+H7fvnX3TmdWMC9m0gx5BiL/MugV7r88xUQMnkITXpAUvsmSooyvU6vEHagXlFCoZo
         wXDizy1iaAl42+P0wK26o3uYORC+PlyMMZwPQVSR/uGMCCgwedM7Z25KvqiVd9JY3AJb
         n5Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUpnxGLFM1W3GpXS+Am0NKM83UOOX3PdIfekzjDGDod6A4I91qeDmYnro838TkNr6DuWbMjUewXyY3R6BE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm+P72WwpX4Y03Po/46WD7k398zJdOXminbk9Ryf0U80AgfFbJ
	do200qc3dk24n8QQwHZhqMOnyLnn7XE9xnekeJ9Fh5HCORP9M6pkKUaYylQdOXP/U+U=
X-Gm-Gg: ASbGncsSRONVP3IbFebZpBU9JEpaSJUk8xLKavBdYQn0Ef4d1P0mfhzZlUyTPBDyrHA
	5uKIF7hI9ramOAHE8u73lzAUVjwB6oBXnRRPkooMeWxz+lvfl2KtuJO5cKmfEJlacHp0oCl9scP
	u971MWzdkVNP/k6YPwvK6NKBQNDbX3q5WoA3xUYAa0g5vKSKwT5SeqVO0vm/9AFdLpyHE07Xwhk
	BQ3/VT0fuabv5ssQVcEmJtGdJgnxWbqH+7/c87XcuGmT7CzldUY73sX5WMIKwtze24Awd3AayJJ
	MyFoaepUpQdtnR9ygOCB8sII5GGW5BuF1G4sCu/fi8n4gw3sWbBnxf6cSYaoxrTyD3qIlpUm6Jg
	H40p/tOO1UX3fem8h+nrUTrvMdC4XqX1rGYgU7wRWMcGHtT14tvShqKnjJ6UlNqs01ElTxRs0m9
	eEEK2ufPUsV/ifoYOcm9D8rpvfxXi/cg==
X-Google-Smtp-Source: AGHT+IFjOZpe3RBTW3YYsSQc4NlYdBXBAEieg3vjxoeBZFVhu0BwVjWkzVC4rsJ6iid+BIBeXNryvA==
X-Received: by 2002:a05:600c:828a:b0:477:e66:4077 with SMTP id 5b1f17b1804b1-4775ce2bceamr65761525e9.29.1762439620830;
        Thu, 06 Nov 2025 06:33:40 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477622661c4sm50001595e9.0.2025.11.06.06.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 06:33:40 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 1/2] reset: rzg2l-usbphy-ctrl: Propagate the return value of regmap_field_update_bits()
Date: Thu,  6 Nov 2025 16:33:26 +0200
Message-ID: <20251106143327.3049052-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106143327.3049052-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106143327.3049052-1-claudiu.beznea.uj@bp.renesas.com>
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

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
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


