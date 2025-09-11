Return-Path: <linux-kernel+bounces-812646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D9AB53ADF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B88A216F046
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4A636999A;
	Thu, 11 Sep 2025 17:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkmGR02q"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FC43680B9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 17:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757613445; cv=none; b=sN1fscUPwk8sBFfoqaoPp5yNDdAANTDBXWjFtgcW4irwr9kpMah6fVRxLHv5VYTblBu5nqePe6IRXCP+ZLY362n3uQ9U8P6G1JeVUmZ2cibNecVftTNKI5GkZmeMz47UuaABY/uWRSgTH6bPec2J+C1t1Ft1rdWylzJpA+Zr4bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757613445; c=relaxed/simple;
	bh=voRlcLKfoLfnlVLyVO+ZDmBOdNNCSLvdkGqha5/sHqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MCvNfsBwShcDVpZdEZwr9STTTvI9cdvHYyl4pQPcpjJka+sBLtT7Z/FhcXW0x+FurC5tepUKJp0Yc5eZCLygHNOMbz8kDQtZC+fJ0dOVTk4p2ImMANzgtqGjFxXoc2vv/MC7PZffI9PSA7MhP3hYM55tIxkYTP168cnwzWIErUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkmGR02q; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b042cc3954fso190428566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757613441; x=1758218241; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUBWcTiGE2fz4jspmliN1on/EZodfLpmty6A15u2Kyw=;
        b=CkmGR02qn1B0poIZV7j/+J13oBYkyG9eTEcitPdQzjcRwXqmHVjbnz4dhB2n/eWaNP
         LTVwfrq1zu3vtJvj+AwrWGfNR7ojwokkQJ7PQZA81usNnwjR4lE3RE4MTkfUZ9Y7iyQe
         edSFoMAH4F6zonXqdpuKEEeMfphifGNTczLDMC+Qe44y4cc/N6QqfppywxfNeQVSfVSZ
         GucCaiNPJyH1XqkAia+V2kdQKKfPweLNysXekUmQAg/TagTuCkXf1ZyRG6tdV6RyYRJj
         i3/PmF26Gqt+n047vhl89CUDVWAl2g9gy+Pt8sOxVhXfrlhE8Rg4NlPoBRhRLEGWFBwS
         vxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757613441; x=1758218241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUBWcTiGE2fz4jspmliN1on/EZodfLpmty6A15u2Kyw=;
        b=X5M4nQOqUB5uDWFArOEQ2MNaYsOcSjaBsW7RtN23qPAMdSNvA4OZifKKwq4kauxu63
         gGTUzUlcp99qpiJKu7OFJ1n8FvPekwWdK/IdaSLSG9pkbziIdPEin90W/eZhLUTeTkCS
         KvzlrHHjvmtwUW7XlEG3VYRajbD++bSBIaRJSfSJdRMQncR1+tK6R4TpFOu/VPU5bcaA
         sctCojayiWLHvMOWa1ji5KX3NAeDbiyDSXeF21RtvZsstWffkI1b7LLOlQjzsYDgAon2
         BTirSRPlRa3wZwGqvSDgOO/oY/MGCX4mlj2oZOuIxR03y0TZYVz8E0MPfBhl2Y1FLyTq
         JDUg==
X-Forwarded-Encrypted: i=1; AJvYcCWKQS2qwcPHKEbwOs7ATFpvg+MWke+7DxA4+d+NcRiJSKNvK4w8wAtD1HmI7ayy0Nw/8PsAuSC+CDvp4L0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYjSsu6QQCE91QUhwnMv3T8WaMhpjYHGC6RazcGrlV9LIayPff
	5de3buyQHwOeXZ4KEl+N6lfA+POuMp0muY3jDcVrTDOKAzqc+3l9dxqU
X-Gm-Gg: ASbGncuxYlc6nDP4GMXTeazXTbE7rSWSMn4ImYQChZOgpfyIB+NhkAmwUjGx6dGveSd
	OygO3LdyEP55j91l/lgPjeNCBMI8amTFw8lfbmfLI/H0uYjXCPyCxlgPitHJT0gOMqUsy78qa3R
	KpRXb49d5NKRm4rJsYFE85cGXmqPPeyrVZBWDbKTBZv5EmTis3Yg7yzoibkDQ+3RP8xXT0n/mUY
	aBvWyvXWXsmJxhHKUhXigAfx+oziu9t4lPZFUsNPogwYDtEFaLJ4sruX4KWAzEvcYo1zgbn7s1+
	FWdI29W3Q8KB5NcqpyayOiEMntrCUdz+OkkLjGaWYT5xXMoi7L5A7F1vrG2fJMFVRTk1dk1cXvn
	td9vx3Ueq8TnIgjtj/FSp
X-Google-Smtp-Source: AGHT+IHRiYrEzoCygb3ckQfAlUNDV712Ui9V9DGNAmSDLtmQVx2Imsk0mmPFfoDHHiLVel1tWNIbUA==
X-Received: by 2002:a17:907:3f18:b0:b04:45e1:5929 with SMTP id a640c23a62f3a-b07c35cd746mr2716566b.28.1757613441423;
        Thu, 11 Sep 2025 10:57:21 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b07b312845esm171377166b.26.2025.09.11.10.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 10:57:21 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 11 Sep 2025 20:57:13 +0300
Subject: [PATCH v3 5/9] power: supply: max77705_charger: add writable
 properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-max77705_77976_charger_improvement-v3-5-35203686fa29@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757613434; l=2821;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=voRlcLKfoLfnlVLyVO+ZDmBOdNNCSLvdkGqha5/sHqA=;
 b=AcZsQgOUf1rNaOkJW4Vo9kbZxVm8iiuTb9TTwXZPYDBbPJDGT2EAuE62vHwrRvi7zyJ+rMwg/
 tp71AXpbSf7BBky1ASlYiEo97V9gVqLX3UrgoqgMRYhbX3EfEhClDwi
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add INPUT_CURRENT_LIMIT, CONSTANT_CHARGE_CURRENT properties as writeable
to be able to control input power consumption and charging speed.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 drivers/power/supply/max77705_charger.c | 54 +++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
index 93d055458849..d6a3cd98c898 100644
--- a/drivers/power/supply/max77705_charger.c
+++ b/drivers/power/supply/max77705_charger.c
@@ -105,6 +105,17 @@ static int max77705_get_online(struct regmap *regmap, int *val)
 	return 0;
 }
 
+static int max77705_set_integer(struct max77705_charger_data *chg, enum max77705_field_idx fidx,
+				unsigned int clamp_min, unsigned int clamp_max,
+				unsigned int div, int val)
+{
+	unsigned int regval;
+
+	regval = clamp_val(val, clamp_min, clamp_max) / div;
+
+	return regmap_field_write(chg->rfield[fidx], regval);
+}
+
 static int max77705_check_battery(struct max77705_charger_data *chg, int *val)
 {
 	unsigned int reg_data;
@@ -384,12 +395,55 @@ static int max77705_chg_get_property(struct power_supply *psy,
 	return 0;
 }
 
+static int max77705_set_property(struct power_supply *psy,
+				 enum power_supply_property psp,
+				 const union power_supply_propval *val)
+{
+	struct max77705_charger_data *charger = power_supply_get_drvdata(psy);
+	int err = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+		err = max77705_set_integer(charger, MAX77705_CHG_CC_LIM,
+					   MAX77705_CURRENT_CHGIN_MIN,
+					   MAX77705_CURRENT_CHGIN_MAX,
+					   MAX77705_CURRENT_CHG_STEP,
+					   val->intval);
+		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		err = max77705_set_integer(charger, MAX77705_CHG_CHGIN_LIM,
+					   MAX77705_CURRENT_CHGIN_MIN,
+					   MAX77705_CURRENT_CHGIN_MAX,
+					   MAX77705_CURRENT_CHGIN_STEP,
+					   val->intval);
+		break;
+	default:
+		err = -EINVAL;
+	}
+
+	return err;
+};
+
+static int max77705_property_is_writeable(struct power_supply *psy,
+					  enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static const struct power_supply_desc max77705_charger_psy_desc = {
 	.name = "max77705-charger",
 	.type		= POWER_SUPPLY_TYPE_USB,
 	.properties = max77705_charger_props,
+	.property_is_writeable	= max77705_property_is_writeable,
 	.num_properties = ARRAY_SIZE(max77705_charger_props),
 	.get_property = max77705_chg_get_property,
+	.set_property		= max77705_set_property,
 };
 
 static void max77705_chgin_isr_work(struct work_struct *work)

-- 
2.39.5


