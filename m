Return-Path: <linux-kernel+bounces-824501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF94AB8968D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF9657BEE41
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9A0311975;
	Fri, 19 Sep 2025 12:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aOekwumb"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13A43101D8
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758284260; cv=none; b=qI7KtylVqnl//JGbngQNqiE7TdRZoT6YXrgQaRSPJnQJ2QrzBdAPWkXMeJDVJ3EH2Nfi2u3H1cUH7cFEr2PcyHLotqN8EVAzTdqbYRcHIqRormHlEoUsJY1CySu41gaNDj8V0OugU1C7ZnIjm89LS9ezSvJYEAvzXmJJrz7XLs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758284260; c=relaxed/simple;
	bh=uXMsVRvIWUUHVkklABfE5JimlZKe9ncD9jrhLJ/1tIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dWLiPdGq7r74S8kXNWVqqoPl4S4sV27iDn1o10nEt9WcbQgr8qrE2rgsU2ngGn7qwW9gbFjNNCwub5vloDBjCfLoOXyUFdrBCmmyo2sdw3/hBEabYnzFKRE5jIQUBZBwsDj9h61AsYcwj18HqvrnsMF9Pw7Yx8O2zmW1bfYRmzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aOekwumb; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ebc706eb7bso1039337f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 05:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758284257; x=1758889057; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TIW2cqbRLJugG5iAmnoTn2WqOkPb3SCBmhz78WCDfZg=;
        b=aOekwumbS67JQCB5kDY34mBviO7d8/N3UTXkPnSu1VJjDuQojzQ1JgSurl11vUr1cd
         pX3HdjKZL2AW8Weyrl+g1zJjq3hM4n9RnKcA6H8Gx/VVNR/bZlafA7h+x7aONWj06ekA
         pJPGkF30Ln7V92NWuTJFW3I/GFe2ShJvNhB6mmhFh8nsDM86VWm6yNuBIi/+2pEdKPMH
         EpaddFhTtWJuAB2geNue+67ne28ZCJQBjFiVjEOamD7/Bg2GVOb/GHOabLcKMMeftSnZ
         RRoh0u37hMZhJm9m956fHETGSD1PyscKuUtEQQJgUA/BoKMA3+Cw/LZobaHzMJQ7Dago
         OD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758284257; x=1758889057;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TIW2cqbRLJugG5iAmnoTn2WqOkPb3SCBmhz78WCDfZg=;
        b=btF/4s6im4Jigi/ubzVm9/4KRuUIxlqJBvPL4nxuueVet5nSMm4e0gDwEZ8dRuKhX0
         RUt5aWd1KofmZnWSO9k7jNUbC7GtaCFI70lGCYBHFJ0Ff+335YyjYEWzR0SuBmWc1C5T
         +oomkcEAikhmW1Ey01B6sVXRQrxAZH0BLtE1khyJE9YBZ0sETidy26aRtLCZk8SJqkWg
         drHJ0lnj3sccLBOQMufsy4egK3guueGbJHalfn2l/n5VSRSHJKOIdQEboTyGsJMmEaqQ
         ukRHNhDeCdsKiAgDnR1vgt5Aw5Fey8b8r3BWBEbjt/m9mhkNtMBSR70GmvyMry9fqx+u
         Kpog==
X-Forwarded-Encrypted: i=1; AJvYcCU82Ozkv17wMwaMeW4jhmsuvliErLdnWab2OAV/Dla5hcI9h45lUMfVCb8tbOBxi+voG9ssdwlv0cdas2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Oi6siQSwtUt6z8+QXEfz49hx6Ra+/Y2EoA9gsRMJyhxxRff4
	325GNObjQIoomqbnoNGxOjdguaaGqKcRLEOYo6/xggpO7B8o1S0Q7XJLYjE/XkR2Nh/AZ97/X8p
	3G4D4
X-Gm-Gg: ASbGnct2NgBCv0xNzofj6LF9xFLInpwq12C8ubsXLNvrLVimNOJbFLNjWFiPDp/65Ds
	4fM1ibYX481ysPDaotvICWgIsjVLQlaJpDs65Tt+/FM4hCwEZtJ/JvFTb1GIL+Aqnn5m1vTWiF6
	YHvMmQYtt3uXwqjTFDEthG4Dv9ZdJgxJ++DBUBpinXcl1LRJU6r+xX5LB8gb+36+7IM2q0z9Fcc
	I0l2M+hClRyZhTDeNleaNdrUpwbj4WP4nLwHP6chE/otIIobv4+vNHxLMHq96vcyvW8/MTp8C/c
	tlsXQ645LTJ0b40+HE5VcpSA1Shipm4BxASDB9qDOOS2KpjLuieQich4vzMEwMAtQTrVaXsIiCN
	hsIfe6m7TUA5AQV1NFfQ35DQ=
X-Google-Smtp-Source: AGHT+IEU5j/e9+xQRgSg21pb50+kFe5FlXJM7VGLOto6peVQI7x2WopuQi2c3s4oSklCM8+Yd4STAA==
X-Received: by 2002:a05:6000:2f83:b0:3eb:f3de:1a87 with SMTP id ffacd0b85a97d-3ee87cb37ddmr2548806f8f.56.1758284256906;
        Fri, 19 Sep 2025 05:17:36 -0700 (PDT)
Received: from hackbox.lan ([86.121.170.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbf20b9sm7655176f8f.57.2025.09.19.05.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 05:17:36 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Fri, 19 Sep 2025 15:17:12 +0300
Subject: [PATCH 2/2] pinctrl: qcom: glymur: Fix the gpio and egpio pin
 functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-pinctrl-qcom-glymur-fixes-v1-2-426ea410aa94@linaro.org>
References: <20250919-pinctrl-qcom-glymur-fixes-v1-0-426ea410aa94@linaro.org>
In-Reply-To: <20250919-pinctrl-qcom-glymur-fixes-v1-0-426ea410aa94@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Pankaj Patil <pankaj.patil@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1308; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=uXMsVRvIWUUHVkklABfE5JimlZKe9ncD9jrhLJ/1tIM=;
 b=kA0DAAoBG19EyQCVFVYByyZiAGjNSdvIDDjbI1JLB8ePj/ESqVEnWB5TaAl9s/1lTqUIn4wue
 YkCMwQAAQoAHRYhBE7z7hFOeo8qyqfRuBtfRMkAlRVWBQJozUnbAAoJEBtfRMkAlRVWZOEQAIxO
 ssFzqa8egLYxWi5IpqBNV+LRJgUFBcOn4okFexW0eomoaAP1I+WPrh26ke0+EQr11sHB60MlgJE
 e5gXfLdwfryc7rsuzJxi0sKCwWqHdxGAXYzt0cu6PeR35gVWfPahLJ8CAmQWzCsmZJnKmPJKAml
 GirTnUTj4OljMmZprdgfiNCEwBFL3gWSfUmGiCHyPwZy3qUBEdQZfLFOQSzuo8hpkwuYW2zJTv/
 p6uCbYrjSwvJNzYBG4mfXp8Uk2VNvZoJKLE5F8LthiCvIOxFLt73MwdAbHGMhXORl+ebUbnEpnk
 Iqyn1VRlrv0U4YQn5N5DUbSjlwNBjMWHZTFouRBv425krhbh50QeDQODYsLTzpEP7OmovrA1Hjm
 vH/Ynw5EjW+KUcYu8XgMIi8NLfMIswqlpiX4Cy1H2xxNjVGJlz6IAGW3u9idfxqfUMLIB8ocgT2
 k9CEc2sS59Ygq/plITHnJqqgXk+Cb9q8+n3MQ7KtWtPX0cA15/yeNZGKzeK8fgtWw6v9X/HK9p/
 oCBPl8xARiOEC2j11Kq0Q7ZkmJDPrI472Aipe3m3KG6PdxAOZtnJXV/e/d42mZ0Abl7lmSIADXC
 VVrdXijALy5qm9uMF87/f3DlyNV4kK7o10Y4nJxJwCJKEGOP+leEOm0F+9aGEJtljVZluDZh4pe
 5cK1a
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Mark the gpio/egpio as GPIO specific pin functions, othewise
the pin muxing generic framework will complain about the gpio
being already requested by a different owner.

Fixes: 87ebcd8baebf ("pinctrl: qcom: Add glymur pinctrl driver")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-glymur.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-glymur.c b/drivers/pinctrl/qcom/pinctrl-glymur.c
index 9781e7fcb3a11c85dbd5497170188e2da051215b..335005084b6bc87db6d700471264edde00370ca0 100644
--- a/drivers/pinctrl/qcom/pinctrl-glymur.c
+++ b/drivers/pinctrl/qcom/pinctrl-glymur.c
@@ -1316,7 +1316,7 @@ static const char *const wcn_sw_ctrl_groups[] = {
 };
 
 static const struct pinfunction glymur_functions[] = {
-	MSM_PIN_FUNCTION(gpio),
+	MSM_GPIO_PIN_FUNCTION(gpio),
 	MSM_PIN_FUNCTION(resout_gpio_n),
 	MSM_PIN_FUNCTION(aoss_cti),
 	MSM_PIN_FUNCTION(asc_cci),
@@ -1342,7 +1342,7 @@ static const struct pinfunction glymur_functions[] = {
 	MSM_PIN_FUNCTION(edp0_hot),
 	MSM_PIN_FUNCTION(edp0_lcd),
 	MSM_PIN_FUNCTION(edp1_lcd),
-	MSM_PIN_FUNCTION(egpio),
+	MSM_GPIO_PIN_FUNCTION(egpio),
 	MSM_PIN_FUNCTION(eusb_ac_en),
 	MSM_PIN_FUNCTION(gcc_gp1),
 	MSM_PIN_FUNCTION(gcc_gp2),

-- 
2.48.1


