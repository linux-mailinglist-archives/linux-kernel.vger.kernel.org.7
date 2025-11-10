Return-Path: <linux-kernel+bounces-894008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D26DC491A1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E261F3B510B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489F9341642;
	Mon, 10 Nov 2025 19:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LlW1aOYj"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33835336EEB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762802957; cv=none; b=LbCKEbhW83KpplQbvPWcJXD94lZObSfHMbe191r871Lz8PtGmUSCNZnpkTCiWcT9Zrdc647sAd6qEhXvjcsNh+wtktDGWMmaKjSBoIHfDUFxocevVjEPRjuYVOn7fyyXGUEf/jV7dWjES+CumrIE2SpEWVCykQh4xt91iMZvaqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762802957; c=relaxed/simple;
	bh=Fmx4poAZFZGyLstQYwjHcQxOfV+O6exfaXpWXRFjRjM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XkqGoNeCQATcyEjsQjV+hd8Ckt3YJnPhxY060PTpMvBXJ7h94lJvUI6h2ce2Ji6Ieb8iznSYQDjc+ILbfYquVQr8ld5rZ6gAoFC0n200tu5szVO4UTgyrAbkU3X2TbR1aDalaxXn04OhXclx3egl6HQoqSQqUGK78kXltoaCehU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LlW1aOYj; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b71397df721so373592166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762802949; x=1763407749; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uUFmnn4e1bVW35KbGdGkktcuDsfeg0RhFoIgKMaFEtY=;
        b=LlW1aOYjehsbNPqZfmaJf7+hrPcZOPnRZoocNzNPDUy9WMqZq3Iqszha3F897BAIrz
         7XzLOY/6+vqRNuwb5/clGyI/7BFgfjlrwFi3HNBEdb7z2SSgNNscguYsQ1rXjjs5tGjb
         6hHkFu8dberHfpI5Ad/m+8ETBGBJ2ekMrrByT84lxTg08JYHxmk+fQYfxomtfWQ630jM
         tODK9LNSjLVrwJ8C/Gk8XygCun3ywpg0ALSwnumsuIRzI/Qlri1xcSSkQEXPsYLkX81J
         S/yoQLKCs5/xhDLxe3YldJUfeZjGHQSiAr9LsSulfH5/efrPLOmK5ye/Jgkk0ECRkZS9
         0cfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762802949; x=1763407749;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uUFmnn4e1bVW35KbGdGkktcuDsfeg0RhFoIgKMaFEtY=;
        b=kQsiHkKUIfo4Nquh30LjtmicjPr707FDlt3yhcZfHkP3ipwf74/ifsl0QO3v2L8VnW
         KxoHue8T5QBYELJCMWFEB5A7iBZbYRe4VNEOCtnEue5GB9s+2nxrGTsEqbi6XWQd51h1
         sD8KdZb7SpLH7Y1/5Yy/Y1BCQrZFcUhjf7QbAvIiycQJzDz4Xv7stCMOHA83KOAhRxLU
         9EAwLUIdA69ob2EgLQ7iOrctZORbAXfK+/ut5YAmud2y1XKyMyW4an/JEixTsqbswB7S
         t/oRJBKQr7+raE5fRAlt94mKQ/5E7GHsfGg9OI4FivqLWdmQDEHZ36Bv5iTgKzqwoLV9
         zoGw==
X-Forwarded-Encrypted: i=1; AJvYcCXH7+p/zCu5ldWNeyY0t8cqKchVI+UlknoumMWmPLwQhNHG02GXE/P2w7pi2XacQF8sQAqAk1l8wyeM6A4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx55NJZOBnZIz7XQN1VC48DhW5WrvEu9S0ldd/NnjvzDSMmtIuT
	e856ZqdpavH7C3q3uo6KK5y9U0fITyIGOa/IGtYekga3vuOOpmlU9JYUlmllPCBNRPA=
X-Gm-Gg: ASbGncv6YDuttz1rLetvdSUWn0/q4BGUWJdWExfWwdx//OFTqMEynTgRK/by8uP00ns
	d/InOuKmNhaH9+BFPgJ4jC+cNLmBfI2e18VNmcnBcHbt+y9yUdK5OD1W+ts68GeLTQBVFnXX/kw
	i/l3z5EINNbQcf+EgdesnCu9szWUEpl1qhp1r9lnofnT91w1H4gUDM4AqEgeXgL0MxR8qtRz88z
	jSK0B9B06rt7dhcyXfcdxBO8BfRlOQnESFGkFKKJKBfokliId4+2Fj6kDzRf7L2HCoDnuOztIAL
	VCn9Byto50WfKd0aO9p9VbCzm5mG/wwGDaM/keaeRYNO3rsAEtmqBJaC/gfyqd7EqyuufzlnLHJ
	pRXnGGB/EunAf4gQ3IjGtJdY6Phk81hjYBuU98FtAQL2afneDuBJQbu/GNmV2Do4UWYzq2sXSpJ
	yXDAeXjlt5EiBHI5SSFBKFG7Jtz+B/7/ss0kHKJr5VnRxcljKgMvLlRXQrKVY1
X-Google-Smtp-Source: AGHT+IHNQl/iS05xTmRf0E31VhCPdGxfwqJeYNmuqmcrWkHeSWZd3rc8bHHOKIevtAA3KAJ0hcfK0Q==
X-Received: by 2002:a17:906:4fcf:b0:b72:dee9:88df with SMTP id a640c23a62f3a-b72e047b41emr950072166b.46.1762802948548;
        Mon, 10 Nov 2025 11:29:08 -0800 (PST)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97d16esm1168178166b.35.2025.11.10.11.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 11:29:08 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 10 Nov 2025 19:29:01 +0000
Subject: [PATCH v4 18/20] regulator: s2mps11: refactor S2MPG10 regulator
 macros for S2MPG11 reuse
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251110-s2mpg1x-regulators-v4-18-94c9e726d4ba@linaro.org>
References: <20251110-s2mpg1x-regulators-v4-0-94c9e726d4ba@linaro.org>
In-Reply-To: <20251110-s2mpg1x-regulators-v4-0-94c9e726d4ba@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

Rails in the S2MPG11 share a very similar set of properties with
S2MPG10 with slight differences. Update the existing macros to allow
reuse by the upcoming S2MPG11 driver.

Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
Note: checkpatch complains about unused macro arguments _r_mask,
_r_table, and _r_table_sz, but these are false-positives due to patch
context.

v2:
- fix commit message typos: s2mp1 -> s2mpg1
- drop duplicated assignment of ::of_parse_cb in
  regulator_desc_s2mpg1x_buck_cmn() macro
---
 drivers/regulator/s2mps11.c | 69 +++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 27 deletions(-)

diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
index d840aec236dcbdc8b460f89b4cd04e42e3b3da7d..35cfea6b6d8091ba21f00e1cb82b11a8dc9bc3ec 100644
--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -650,31 +650,44 @@ static const struct regulator_ops s2mpg10_reg_buck_ops[] = {
  * (12.5mV/μs) while our ::set_voltage_time() takes the value in ramp_reg
  * into account.
  */
-#define regulator_desc_s2mpg10_buck(_num, _vrange, _r_reg) {		\
-	.name		= "buck"#_num "m",				\
-	.supply_name	= "vinb"#_num "m",				\
-	.of_match	= of_match_ptr("buck"#_num "m"),		\
+#define regulator_desc_s2mpg1x_buck_cmn(_name, _id, _supply, _ops,	\
+		_vrange, _vsel_reg, _vsel_mask, _en_reg, _en_mask,	\
+		_r_reg, _r_mask, _r_table, _r_table_sz,			\
+		_en_time) {						\
+	.name		= "buck" _name,					\
+	.supply_name	= _supply,					\
+	.of_match	= of_match_ptr("buck" _name),			\
 	.regulators_node = of_match_ptr("regulators"),			\
 	.of_parse_cb	= s2mpg10_of_parse_cb,				\
-	.id		= S2MPG10_BUCK##_num,				\
-	.ops		= &s2mpg10_reg_buck_ops[0],			\
+	.id		= _id,						\
+	.ops		= &(_ops)[0],					\
 	.type		= REGULATOR_VOLTAGE,				\
 	.owner		= THIS_MODULE,					\
 	.linear_ranges	= _vrange,					\
 	.n_linear_ranges = ARRAY_SIZE(_vrange),				\
 	.n_voltages	= _vrange##_count,				\
-	.vsel_reg	= S2MPG10_PMIC_B##_num##M_OUT1,			\
-	.vsel_mask	= 0xff,						\
-	.enable_reg	= S2MPG10_PMIC_B##_num##M_CTRL,			\
-	.enable_mask	= GENMASK(7, 6),				\
-	.ramp_reg	= S2MPG10_PMIC_##_r_reg,			\
-	.ramp_mask	= s2mpg10_buck_to_ramp_mask(S2MPG10_BUCK##_num	\
-						    - S2MPG10_BUCK1),	\
-	.ramp_delay_table = s2mpg10_buck_ramp_table,			\
-	.n_ramp_values	= ARRAY_SIZE(s2mpg10_buck_ramp_table),		\
-	.enable_time	= 30, /* + V/enable_ramp_rate */		\
+	.vsel_reg	= _vsel_reg,					\
+	.vsel_mask	= _vsel_mask,					\
+	.enable_reg	= _en_reg,					\
+	.enable_mask	= _en_mask,					\
+	.ramp_reg	= _r_reg,					\
+	.ramp_mask	= _r_mask,					\
+	.ramp_delay_table = _r_table,					\
+	.n_ramp_values	= _r_table_sz,					\
+	.enable_time	= _en_time, /* + V/enable_ramp_rate */		\
 }
 
+#define regulator_desc_s2mpg10_buck(_num, _vrange, _r_reg)		\
+	regulator_desc_s2mpg1x_buck_cmn(#_num "m", S2MPG10_BUCK##_num,	\
+		"vinb"#_num "m", s2mpg10_reg_buck_ops, _vrange,		\
+		S2MPG10_PMIC_B##_num##M_OUT1, GENMASK(7, 0),		\
+		S2MPG10_PMIC_B##_num##M_CTRL, GENMASK(7, 6),		\
+		S2MPG10_PMIC_##_r_reg,					\
+		s2mpg10_buck_to_ramp_mask(S2MPG10_BUCK##_num		\
+					  - S2MPG10_BUCK1),		\
+		s2mpg10_buck_ramp_table,				\
+		ARRAY_SIZE(s2mpg10_buck_ramp_table), 30)
+
 #define s2mpg10_regulator_desc_buck_cm(_num, _vrange, _r_reg)		\
 	.desc = regulator_desc_s2mpg10_buck(_num, _vrange, _r_reg),	\
 	.enable_ramp_rate = 12500
@@ -738,24 +751,24 @@ static const struct regulator_ops s2mpg10_reg_ldo_ramp_ops[] = {
 	}
 };
 
-#define regulator_desc_s2mpg10_ldo_cmn(_num, _supply, _ops, _vrange,	\
-		_vsel_reg_sfx, _vsel_mask, _en_reg, _en_mask,		\
+#define regulator_desc_s2mpg1x_ldo_cmn(_name, _id, _supply, _ops,	\
+		_vrange, _vsel_reg, _vsel_mask, _en_reg, _en_mask,	\
 		_ramp_delay, _r_reg, _r_mask, _r_table,	_r_table_sz) {	\
-	.name		= "ldo"#_num "m",				\
+	.name		= "ldo" _name,					\
 	.supply_name	= _supply,					\
-	.of_match	= of_match_ptr("ldo"#_num "m"),			\
+	.of_match	= of_match_ptr("ldo" _name),			\
 	.regulators_node = of_match_ptr("regulators"),			\
 	.of_parse_cb	= s2mpg10_of_parse_cb,				\
-	.id		= S2MPG10_LDO##_num,				\
+	.id		= _id,						\
 	.ops		= &(_ops)[0],					\
 	.type		= REGULATOR_VOLTAGE,				\
 	.owner		= THIS_MODULE,					\
 	.linear_ranges	= _vrange,					\
 	.n_linear_ranges = ARRAY_SIZE(_vrange),				\
 	.n_voltages	= _vrange##_count,				\
-	.vsel_reg	= S2MPG10_PMIC_L##_num##M_##_vsel_reg_sfx,	\
+	.vsel_reg	= _vsel_reg,					\
 	.vsel_mask	= _vsel_mask,					\
-	.enable_reg	= S2MPG10_PMIC_##_en_reg,			\
+	.enable_reg	= _en_reg,					\
 	.enable_mask	= _en_mask,					\
 	.ramp_delay	= _ramp_delay,					\
 	.ramp_reg	= _r_reg,					\
@@ -770,10 +783,12 @@ static const struct regulator_ops s2mpg10_reg_ldo_ramp_ops[] = {
 		_ramp_delay, _r_reg, _r_mask, _r_table,	_r_table_sz,	\
 		_pc_reg, _pc_mask)					\
 	[S2MPG10_LDO##_num] = {						\
-		.desc = regulator_desc_s2mpg10_ldo_cmn(_num, _supply,	\
-				_ops,					\
-				_vrange, _vsel_reg_sfx, _vsel_mask,	\
-				_en_reg, _en_mask,			\
+		.desc = regulator_desc_s2mpg1x_ldo_cmn(#_num "m",	\
+				S2MPG10_LDO##_num, _supply, _ops,	\
+				_vrange,				\
+				S2MPG10_PMIC_L##_num##M_##_vsel_reg_sfx, \
+				_vsel_mask,				\
+				S2MPG10_PMIC_##_en_reg, _en_mask,	\
 				_ramp_delay, _r_reg, _r_mask, _r_table,	\
 				_r_table_sz),				\
 		.pctrlsel_reg = _pc_reg,				\

-- 
2.51.2.1041.gc1ab5b90ca-goog


