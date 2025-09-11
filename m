Return-Path: <linux-kernel+bounces-812651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2FBB53AEE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6429E5A7675
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3228137059C;
	Thu, 11 Sep 2025 17:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnusQyDx"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F15636C09C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 17:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757613449; cv=none; b=kCX7QHzwmd5+e6Z/tMWmr7aAWAz7cL3dqtHXXk5WCOh0/2k1Or4F8LoiWO2PZ1clPb5NFZDUty8qATI0+2QQSOWCxXYIxLf5F1nAdldDRY5GDgCtp7CSwtVmbKugJjK64qNjOhpg8Ds//RJIsbnarDFfv7t+D+tj1XIdp+E2FBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757613449; c=relaxed/simple;
	bh=Art95FP4CDMp3B3wO95DSHb+3nyZc8ObS8pqSfOsfws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=locgB/EoL4h/zk+9ZWlaFUS7MCKvLfNPmwEazXBdL2MnPb+e0Zy6vuGmeN0rmDsBSBk9dqdzExtkYKM1eKHYaq0M/A28FoOrsxs6C8k0apJsR+bTEzNbauATiO+N5L1Z1W7JLCgeEcyOA+IKjVHn4JTw5QNUGSem5yevMpU63tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnusQyDx; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b07c081660aso46704366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757613446; x=1758218246; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eeAm2av/mnmRbyLHfv410Kah1AmetvGnLw+tWu4KGQ0=;
        b=DnusQyDxFyZaEPg75wwx8Xtu3C0WHXfvgiCivreY2Z/12MiSP02LtVHw50apCyx5cD
         OyM4wxASMEj6531iWY3RT/9yCZMj0SLxeCjMjFu4DtYuzHe4n0ZzoLLBdkqjX5pSqkZV
         NP5AwKf/Ehxn2DQAz6bFxrlfw+YsSp2fpNfN5S5i5QUBCeaIZi/qABo2Htc/ERZT/f1Y
         YVPyjY0d/lXwKz+tcSPadmWcFrULfke8I0ki5JyDFq/pnXZel/8DAqvudH6NJyVk0Icn
         +D7AcmAe/eNOQwbdwyqi73cuyPPao1anJVgsHr8V7GpGG+t7MNbwVej25UBzGx+uVXTE
         yqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757613446; x=1758218246;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eeAm2av/mnmRbyLHfv410Kah1AmetvGnLw+tWu4KGQ0=;
        b=nc3XyujSkW56TVftAiePnaK1ie42idtOVlE9gXXG5iJPj+QOPIjothqh44r+sb7M4n
         m+qazT76TNCS0ZJEHN78ujI8SUiY3g1zeqN6a/CfDAS/3BjOW3sjtK1ZnekazF+IpkBt
         u2kCOCV/Y1D3GhY7pe8ZgOa8mARx78OVcV7PaDr1ZHCYp6j0jdEO/uyZRRNT+EyxbcAq
         p1rs7KMm6kBTRp/roqjyYZgHcHhwPxeYVJSsdWceeaBoLxAX940zZqsLNPBt+qIR9cu8
         qWVBtmzrk+irdZoQ9muSB7N26GsHnYIMXRAZeehNEbLrZ+OnHckOElf8LCaEhUqaHVGQ
         lPcw==
X-Forwarded-Encrypted: i=1; AJvYcCV3j/fxM7qqtD1CwwUAk/TlDeKPHkYyl9NADeTnLjLijDisT7Z6zQTMOYNsvlrrAkNBHPZmoZtq+LQ+hPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvDI8SniAc85ltXLCgA4u5NGq8B8wPKuWMh8kZmLZa9rjF46e/
	2EfoJtD0Iv+ATkZt/g4hCyCI0Qo3ZmCFleXH9lGb3Pok6PI/h2NIU5xP
X-Gm-Gg: ASbGncshXh3vFvx9KkUa9jT7FglFLPT9X+sS0sQ1sYVgGrzda4xWuDnP4/JvTjHhXOK
	RX4OefBVJJahm8AxuXnJ0+syv57xohq54v+f4zNv2XPY3fvSAiZ1LpK+ewTkns2bi3WVjtuFL5W
	+TTVMbrJEKbHTvGmp8xYwcJLOQ7SCv5+iBb/nGpgj5riUaaiI2M4YLYhdtqLKcjLbxKSb6Dk4eX
	Gqcnz0+WuVafW6NVefW0o6Y/evJkIC/0YgpZa9I5yjelVjT63ANOdrJxzyBB2yUOsjgZaNkBRmf
	bmXsq3Hm0nI94vlrfzrmwrUgd2kMN/h7+J9Lr1+Vq8PV+/THIL2ER9zTXfXjbzJ2gnFfTD2Zszl
	hjOm+YCOLDkChcuKZk1fJdCvSfTbeewA=
X-Google-Smtp-Source: AGHT+IHWQ/e7gEKIVRbGfVVqsMEfZtLXJsQsAnDauGbX28j0si/mFkkcJRYuSt/yHYH7IiWICpCOKg==
X-Received: by 2002:a17:907:6ea8:b0:afe:b92b:28e9 with SMTP id a640c23a62f3a-b07c387716amr604066b.49.1757613445575;
        Thu, 11 Sep 2025 10:57:25 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b07b312845esm171377166b.26.2025.09.11.10.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 10:57:25 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 11 Sep 2025 20:57:17 +0300
Subject: [PATCH v3 9/9] power: supply: max77976_charger: fix constant
 current reporting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-max77705_77976_charger_improvement-v3-9-35203686fa29@gmail.com>
References: <20250911-max77705_77976_charger_improvement-v3-0-35203686fa29@gmail.com>
In-Reply-To: <20250911-max77705_77976_charger_improvement-v3-0-35203686fa29@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757613434; l=2453;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=Art95FP4CDMp3B3wO95DSHb+3nyZc8ObS8pqSfOsfws=;
 b=RN3URw53taYpw1iYJXq138CZsY9siQtErD7Mn6IrOOY6/U2S+nLo0enRQ/OaIiTEk+XrHgZ2r
 qYUc+85oAsUCsrqUENOfJcG2fYPovBV5nYjDZI4pD/m7ez7yIvo8e4W
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

CHARGE_CONTROL_LIMIT is a wrong property to report charge current limit,
because `CHARGE_*` attributes represents capacity, not current. The
correct attribute to report and set charge current limit is
CONSTANT_CHARGE_CURRENT.

Rename CHARGE_CONTROL_LIMIT to CONSTANT_CHARGE_CURRENT.

Fixes: 715ecbc10d6a ("power: supply: max77976: add Maxim MAX77976 charger driver")

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 drivers/power/supply/max77976_charger.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/max77976_charger.c b/drivers/power/supply/max77976_charger.c
index e6fe68cebc32..3d6ff4005533 100644
--- a/drivers/power/supply/max77976_charger.c
+++ b/drivers/power/supply/max77976_charger.c
@@ -292,10 +292,10 @@ static int max77976_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_ONLINE:
 		err = max77976_get_online(chg, &val->intval);
 		break;
-	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
 		val->intval = MAX77976_CHG_CC_MAX;
 		break;
-	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 		err = max77976_get_integer(chg, CHG_CC,
 					   MAX77976_CHG_CC_MIN,
 					   MAX77976_CHG_CC_MAX,
@@ -330,7 +330,7 @@ static int max77976_set_property(struct power_supply *psy,
 	int err = 0;
 
 	switch (psp) {
-	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 		err = max77976_set_integer(chg, CHG_CC,
 					   MAX77976_CHG_CC_MIN,
 					   MAX77976_CHG_CC_MAX,
@@ -355,7 +355,7 @@ static int max77976_property_is_writeable(struct power_supply *psy,
 					  enum power_supply_property psp)
 {
 	switch (psp) {
-	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
 		return true;
 	default:
@@ -368,8 +368,8 @@ static enum power_supply_property max77976_psy_props[] = {
 	POWER_SUPPLY_PROP_CHARGE_TYPE,
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_ONLINE,
-	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT,
-	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
 	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,

-- 
2.39.5


