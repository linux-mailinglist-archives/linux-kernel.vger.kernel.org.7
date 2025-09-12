Return-Path: <linux-kernel+bounces-813560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 494CAB547A4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B065485E8E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A70B27BF99;
	Fri, 12 Sep 2025 09:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XhI3DojY"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6F82D6E5C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757669047; cv=none; b=NyCwTIADJokcZ/WSZ9p9v3uHkQ/AY8w52L5kYLy0nFQ3t5oF7sBeFQl7RitNGoLsJlJcDlw60fxT5+DHmMl0krMAL3V28opHzYl7anpazWqyya9ojPx/S2/UGAvtHzAZWPPY60GkMKYcRDEnJDu/3xkpzf0j/Y+IxT6W6A/N8Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757669047; c=relaxed/simple;
	bh=+bVJ+4hy5vMtuVwCqUQtQcNPKerS7zzgW7OjoDwLJD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bzz9UIgQhrS2VmKd2ZGsAHlkciB5WWy5pnuhXfM1XVhCn0LDmPR1l3llkH4axDJkdICWpKfc406Sq6FF7N3r/BIVk0b3ojuK4vo8AeICMDufA/W2kE+mbeImhbTuFFFxcsnhmBfcdAh+GqMVm41lTrLZUn1lEKT3bOUUWfFljMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XhI3DojY; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45dd0d53e04so3041925e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757669042; x=1758273842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BOMYwUSj3ToMRrs1GbfaZczlic4yEzoQ0wQhZEu+bgo=;
        b=XhI3DojYX1yHSioSnY/jgX0719BbhGvKyMU/pE1mcXdBZ813hxB6E/IUgN+KcLRsJp
         d0HGk7MQVM/HCxxJlK2FM2IZMpAb8tpUewhIp/8jkBe9VWEbh39R9q3f39dByIZh2R1m
         A1hrQ7dDN9y5Zmv/FSi3nfuoJdLnTDkO9Zdp+xd2eZNCvIof6htbqgp00GE4UEzN+eAi
         q024Eep7dEToGe5T/LPF3m0Rh4MaE6j+YR3Y5keR73hi0YppnF+6S1HuOgWjR9FD8qbh
         tPO3YaaIGFYn5azHzsHmCwbyopHZSG+QRq+A5GDJUIA6Hfa3R3lrlzlZ/v4lSLffkou8
         sXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757669042; x=1758273842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BOMYwUSj3ToMRrs1GbfaZczlic4yEzoQ0wQhZEu+bgo=;
        b=GAmQs5MM/cJnYfpaWeJSWIQfBp1i2oXkWBOhuNE5xxT+22TJIwDETolaC9lrioVfCG
         jTsb8LLpWaRyWVF+IwlNckAiT4RiRumP8A/zA90pFz4NkVZdatjmAALaGSlSfcI85V7U
         Al2rsDS+FxDv2EJAH4M7eqYdcvQER2vlIMess+/SYlLorAgy6NNJYLUySUkaCl0NBZY/
         jjh05h/vqihmFC6VpImL1tkqnaGMxu1ozhuPUN0TANr0RqswM8b9hDQD5FZiMRE/iaZy
         Jl8Z78HXqUy0BTVzG/5v4P54GmMwSZ83Gqa3CppLxMKR5QF8YF2gDqXCNgsQjNk7JIJG
         pqZw==
X-Forwarded-Encrypted: i=1; AJvYcCUd3G9xV0ag7Pn3AdlkohQsL07xP5ppIaH8yUr6hSiHCE5IEqya4yMoPmW0wjfCnXG3hqCaRiGnkhLCN4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxaq/jEwwMF16xo4PoPh1ac0/taIXge4y6cx71vpd7VPc6qPcVw
	T44BfTWQbaEpBWl0R58QZgNQmon2uB8uGd6DSj5KqrHjQBqOl5PsD02v9jmuJA3mW2o=
X-Gm-Gg: ASbGncttQyH8i5O8jaOEM8799D8x7ksK9q6SsIPfcVxTguWBJ5PszAdZ4kjG+AcP/nd
	pVFgRl+wSP4SeJYb2f2kh+vC5xSaV80SRammBUhFGVO9e4R65TCN8PTzClDMtPRedXfZv+D513M
	h7R8UUeILMOhrOqyt0aZT+0666C1AuW74hxIN5miqVQpHO5ZsTu4uTrTgYLlhKfels/O64oiWeN
	LjMxIQiUbQVxMw7fG+S5Q13/hn+yMdxfSkHpjwDh4FOoz7xiO0v/ijKcH6J+TkSWxqFVtBKWL3H
	BNb6kvh5CF4pHUaJOkCO45CCrEqGZsWBre6j/xh3OiXdIoEr1Wx2Iw0lsr3BRz4DdDdsm/+9QOS
	13fOtxg48mPeLVsuHb3I1u6VqwmCwfa4Z1w==
X-Google-Smtp-Source: AGHT+IFZ4LkljsZAZV2KGxX2vnp7A1Ij/erNB1dV87KomdD4NYdDAGsePpI/vQBLekU2xgSQDZkE4w==
X-Received: by 2002:a05:6000:2503:b0:3d4:c46b:e57e with SMTP id ffacd0b85a97d-3e765536c58mr1041490f8f.0.1757669042563;
        Fri, 12 Sep 2025 02:24:02 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607d7b3esm5727337f8f.46.2025.09.12.02.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 02:24:01 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] pinctrl: Simplify printks with pOF format
Date: Fri, 12 Sep 2025 11:23:52 +0200
Message-ID: <20250912092351.162307-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2536; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=+bVJ+4hy5vMtuVwCqUQtQcNPKerS7zzgW7OjoDwLJD0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBow+anDJAMN9wRUbRQ5JlQl3eiWjS4RDs50mngh
 v0da2zDAfqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaMPmpwAKCRDBN2bmhouD
 18n5D/4hSZl8udzkB2YzvH4Z9aKuFcLBa9CFrbK1nRLSDu5FSjWXEXWKEbFj1MHjLOqSErjfA6f
 fc2Ubu88L88RmHPoMzOYbLoElN/YbJz/dIcfvMLod8fnzL+nyanIDfXmVZtUmmDYQSgiudqq55N
 OgcP1rd3Njv+m6SEpSi9mucEgKnmUW/IXbyBYlD+Kf9WQMw6AGL4ICHWW/kdhFOk5ZcOjb1HnW4
 OAHTA2vvtVF74+R8APPWN46YH+EFMlIbmGxIAT4HXnpqw9hdoUbIXp5OqY+f027EOcWS+tUlw/L
 U+PodlsU4UHYaoRtvkk8VhihoB1YgDyYkotQtLGqHYP970ckzBwoScgk7ZWMrRY67jWusybohk/
 s0Sp6GbG2Iio6vqkiMMxTYn9Yvj1+Gifxh39F+gN7GBgU9oAjMTiPuB3aEF7oV1Pm9sO+X13wCk
 JZrp9Lr7mtvLvnSqC8NcPGe6K4RBMSK16uLP8KVuigMVo22/6w4qqL3uOChq/sXCS5+s5ImXBOQ
 XMGDwuPVLAxgzYT7HmVuCKaR23ULDBoq29eCZLj3YUNm5MuzgKkthjnb9mQWiHhNWP25F0eJDuD
 ujygi2OswjTMsQQ+Ad8fb301JcyprI6J6eqSPB4ZFgCmc1C+y4Btbks/pdsehgKkZWjRTK3XoZC PTV13F72brgao+g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Print full device node name with %pOF format, so the code will be a bit
simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/sprd/pinctrl-sprd.c      | 9 +++------
 drivers/pinctrl/sunxi/pinctrl-sunxi-dt.c | 7 +++----
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/sprd/pinctrl-sprd.c b/drivers/pinctrl/sprd/pinctrl-sprd.c
index c4a1d99dfed0..16cf9d15f247 100644
--- a/drivers/pinctrl/sprd/pinctrl-sprd.c
+++ b/drivers/pinctrl/sprd/pinctrl-sprd.c
@@ -258,8 +258,7 @@ static int sprd_dt_node_to_map(struct pinctrl_dev *pctldev,
 
 	grp = sprd_pinctrl_find_group_by_name(pctl, np->name);
 	if (!grp) {
-		dev_err(pctl->dev, "unable to find group for node %s\n",
-			of_node_full_name(np));
+		dev_err(pctl->dev, "unable to find group for node %pOF\n", np);
 		return -EINVAL;
 	}
 
@@ -276,16 +275,14 @@ static int sprd_dt_node_to_map(struct pinctrl_dev *pctldev,
 	if (ret < 0) {
 		if (ret != -EINVAL)
 			dev_err(pctl->dev,
-				"%s: could not parse property function\n",
-				of_node_full_name(np));
+				"%pOF: could not parse property function\n", np);
 		function = NULL;
 	}
 
 	ret = pinconf_generic_parse_dt_config(np, pctldev, &configs,
 					      &num_configs);
 	if (ret < 0) {
-		dev_err(pctl->dev, "%s: could not parse node property\n",
-			of_node_full_name(np));
+		dev_err(pctl->dev, "%pOF: could not parse node property\n", np);
 		return ret;
 	}
 
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi-dt.c b/drivers/pinctrl/sunxi/pinctrl-sunxi-dt.c
index 5f13315ebff3..50a16f3bd131 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi-dt.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi-dt.c
@@ -274,8 +274,7 @@ static void fill_pin_function(struct device *dev, struct device_node *node,
 			if (!strcmp(pins[pin].pin.name, name))
 				break;
 		if (pin == npins) {
-			dev_warn(dev, "%s: cannot find pin %s\n",
-				 of_node_full_name(node), name);
+			dev_warn(dev, "%pOF: cannot find pin %s\n", node, name);
 			index++;
 			continue;
 		}
@@ -283,8 +282,8 @@ static void fill_pin_function(struct device *dev, struct device_node *node,
 		/* Read the associated mux value. */
 		muxval = sunxi_pinctrl_dt_read_pinmux(node, index);
 		if (muxval == INVALID_MUX) {
-			dev_warn(dev, "%s: invalid mux value for pin %s\n",
-				 of_node_full_name(node), name);
+			dev_warn(dev, "%pOF: invalid mux value for pin %s\n",
+				 node, name);
 			index++;
 			continue;
 		}
-- 
2.48.1


