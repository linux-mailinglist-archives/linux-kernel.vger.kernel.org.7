Return-Path: <linux-kernel+bounces-694213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F59AE097B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 16:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C6E23A65F3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 14:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BCD28CF76;
	Thu, 19 Jun 2025 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LXV+9nc/"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC85233D92
	for <linux-kernel@vger.kernel.org>; Thu, 19 Jun 2025 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750344928; cv=none; b=IvZh6wJMXVSezc40+5AsIZn7NaqOzHI2AuHd+r3qy422eyiWAsV/oHYUv/c0di67c78K0QsU8UbBLgXpsiSj3HsXV1O7Zhx/hDc+5g6eTYtRPAYxPXWGYj1FaGWjwJ84pGMSt+vD32cAAOWSwf1zsVm9IKeBqteerY6FVCeVe6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750344928; c=relaxed/simple;
	bh=5zLQjefFl1xoVe/hjAGrMynvu2zXA+YnEoPsGjdFfEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oxo0JMqLVJeWOczIjbkKXqGdeKNO9wUSvzqm9ziJMNjJJ6jtfRwx4IvDOJdFMotstLKKdV+joyqMKOKBq3UVRMr9pWM1kX373n2N69pc8VVrhTuwtzSMpPV2qme/qY7TK6NZA3GSjhPyeraUnR20iVDdzRscWm1KNaZ/+vOWgzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LXV+9nc/; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a50fc819f2so770547f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jun 2025 07:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750344923; x=1750949723; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gLzhodFNjkX+gPU6aAgcbyZ8ijaQa1ht97PNw+na+88=;
        b=LXV+9nc/vNCVeHlWGbgbDdZH3dLqOuPng4aK846sesQD+tVwCDrEbNGd9GY0iEbVAM
         iTcVa17ToqJL4kH6wmbbiwNvOzRPJ5xWJCYH8+BnJ1wNo1tIa9tTtLcr8Klxsncsx9Id
         qXIkCzAAmfC7m+rfBXJOzT/8XamfD+VSEP6h4geTYMWotij7lQKMeRaUWhNxzsWSKR2n
         Q1a4jHXwZU/FT3wqqRNw3P9yqOOm6rjlo9k194gEwt6XT8b/qp8rnfbL/Y+klom13g5R
         7Ns3KFD58EuMQntKt6nzOTbNCeyr3iim41oXnfRb95gqgf6FeTGkEdvYlQ25Jna0W+0m
         P8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750344923; x=1750949723;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLzhodFNjkX+gPU6aAgcbyZ8ijaQa1ht97PNw+na+88=;
        b=WolAa3A5NLOOmRbWyfid2nMy1M4taJzumu9myLPr4/y4EUC/NwAo9+KSfdpVdtkxKN
         PpcAH2nPZ4/MwShdOJXRaWgrhwTnXFzvU09k08MiE8cnoDkGkPeEOpjsp1BFqaky2pYG
         HZUeRAz8vNprl3eTY/j6XrX/yTSN2IisxUTaFY4rom6MhCmMiFj8zMQ9DAYp9sq5laq9
         M34lRTmhtz91c2qgVqo08Hf1iDRj7PTnF7owxnf7CpeO7DEpqleUCBR1MV9QMYI0jRQ7
         LpCxVc+WYrSPr30eIO2Fz7Z+mVPj/bffgp3C7rw1KUsyGBn49vVXnMjtFQx83pOG9xPh
         mBxw==
X-Forwarded-Encrypted: i=1; AJvYcCV9NBbDkX8EFLReZbsLuHmOtHGclt25e+Qq+e8J4Fjts2cm/+QGcl7P/CjzVl35zQLcOTtEglQ4jKDsx/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv0Jyc26JKx6HClcV/z4K5Qy+raEZclJJgurYSH/Uln1KIX1Xr
	SnMWzpzL/ZjHhMzwDU08TufNrgxNZgQAu6u33hoANW3nigjl2u2cOCUBzW14DRhroko=
X-Gm-Gg: ASbGncvW8GynB+/P4a+i+z3v8eHVsdFIyvbalRUUZuFnTGCu0YU1A5z1ixjtI4bMOqa
	6vevCCxskIWMZN1+oofR/vlyQu46vBTB7o7B/JpaJiqGAdfP//BZ+x0gyWDJjes6J9yU5M0rd0Z
	6FWrVNybhGUSGhSJUcxheD0UuJ0Vxg0gaPWgXEbbbNzbEcI9GmxTWdj/kc8SoJWWvSMDsAhQ0Cr
	4y2ucOqnUNoYq3m3KM4ESQ9LXiCHM4/tzPtRPJlruRRqBoU9IPZtOHUC8szPgbWStw1ImB0u18n
	R5UlKjtlEC7IAwto0aEfYLnx26xoQLoW+h3TLE7g7FN+SHohF7C9NBh+Dp+63drQCwjebWQIrMB
	LUYpkAJa1EuA=
X-Google-Smtp-Source: AGHT+IEDxOs2fv0eODh32EDd8cdAU32JALjDJpZubvkYuesAwi2i9gcqAOAB2Ga5J//4M2trs4Fd0w==
X-Received: by 2002:a05:6000:210b:b0:3a5:8abe:a264 with SMTP id ffacd0b85a97d-3a58abed70emr6303048f8f.37.1750344923430;
        Thu, 19 Jun 2025 07:55:23 -0700 (PDT)
Received: from toyger.tail248178.ts.net ([2a0e:c5c1:0:100:b058:b8f5:b561:423c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ebced8asm31343715e9.40.2025.06.19.07.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 07:55:22 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Jun 2025 16:55:13 +0200
Subject: [PATCH 05/11] power: supply: qcom_smbx: allow disabling charging
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250619-smb2-smb5-support-v1-5-ac5dec51b6e1@linaro.org>
References: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
In-Reply-To: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-hardening@vger.kernel.org, Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1357;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=5zLQjefFl1xoVe/hjAGrMynvu2zXA+YnEoPsGjdFfEE=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoVCTR5g7afOe/JLNddLPQnw8+CLIW9X0RRbizc
 AD20INQzGuJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaFQk0QAKCRAFgzErGV9k
 tr3SEACdCNo03bzqVOxk1mrxOgrONtYGGJjUcXqLvWuPXcJs2Dngoaq/Dg3UvuhGe8oGlZwrD+I
 Fzo4PwcBuIqf8SOc9A/MJsNyS7FJX0oYJrpNI/ta8TSk0i32NTYFCpVtmIRPN+RZ3Fpxzr1uzAL
 sqHS1LXrjlth/+XJwkdtPyFavnmeKl2MiWY6GtsC/UVNaVMKLtjA0UTv7icN/ozvlSxNhKU6tEU
 UoLYtPz9Fqwp5QiAKn847s/tKxODhKRYFOPYA0rhB985tOyhpHkYsCk+4IPIwAczS4snyPa9uuB
 YKy5vRvAT0lsVAd6Vh6UGyXh+ZXIZjXwpibHxG4yRqGSsS3qztTOfeJ/C6bXLEZ6i16fx7cwZaF
 V/9yRpXf5Aj7TTyBq8C3mXogqE+hn7RxSdnGW+PTlwKxfmzY0LQam5UY81bxoZ8ZzcNa01EP5Zf
 +kkcNaaVJ3PPSpcRRsVP7UXgNotlvibEA8VFJmQnh3EqmA5Hppn3XJfHoe+BmNnOp8h/YRfH+n4
 htj80jTZ3GTFjCOgH7wUAOiQt28xTy/QUPfcVWIKaavS4SKv40NQpof49aLlY2ArkCy635xjTuL
 Z8IcsmPymiw1jJ1zDNie+RbE6ONBiA4PQ5Q1qAx9yNC5wu5AHv2/5UsRLB+v2rk8SztZdJHlvo8
 /lcBkraryspc5oA==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47

Hook up USBIN_CMD_IL so that writing "0" to the status register will
disable charging, this is useful to let users limit charging
automatically.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/power/supply/qcom_smbx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/power/supply/qcom_smbx.c b/drivers/power/supply/qcom_smbx.c
index b1cb925581ec6b8cfca3897be2de5b00a336c920..fc2a8e20435639a9da4d966c43271beaeb57a03f 100644
--- a/drivers/power/supply/qcom_smbx.c
+++ b/drivers/power/supply/qcom_smbx.c
@@ -692,8 +692,11 @@ static int smb_set_property(struct power_supply *psy,
 {
 	struct smb_chip *chip = power_supply_get_drvdata(psy);
 
 	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		return regmap_update_bits(chip->regmap, chip->base + USBIN_CMD_IL,
+					  USBIN_SUSPEND_BIT, !val->intval);
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
 		return smb_set_current_limit(chip, val->intval);
 	default:
 		dev_err(chip->dev, "No setter for property: %d\n", psp);
@@ -704,8 +707,9 @@ static int smb_set_property(struct power_supply *psy,
 static int smb_property_is_writable(struct power_supply *psy,
 				     enum power_supply_property psp)
 {
 	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
 		return 1;
 	default:
 		return 0;

-- 
2.49.0


