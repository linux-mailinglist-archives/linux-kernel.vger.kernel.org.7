Return-Path: <linux-kernel+bounces-817054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEF3B57D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C63F82A0323
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A061E31B80B;
	Mon, 15 Sep 2025 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aOnKUDbF"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84BA315D3F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757942940; cv=none; b=LsMtsID4qSbhq3iWOhmpuC7Z6ARVcbS6NwcWLGmS6PPBMAqPkBeZsv0Ydl5VbrbA9AzLpF7GapYC5UcEkdzskpndFwLIL/dLDz1XXRdHX9UxC0chgBHxkdqX45EBeNd2lKBp+Itei68+3bOos1EIaTN4bwuwrpm8CO+xEK5VO+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757942940; c=relaxed/simple;
	bh=8SarEJ16dSlZ9x1yrNhQOTftvxArDoGFQxpONMxdWhg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qZphQE4BLiuN364Ef02ZYI0zyVUWEFHZaMD1CLPvYfFcCBoTnrOZflzqEJjRwJ+IU4hpBXum55Pdleqpyb+fIPaKnszgTRKZy51txQVXTSYsFOps92JLTcxJ/giiH+A1TfbHnKZnGZ/lyN0EbgWMm0oh1PGDZoSdOgkg9/KDWBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aOnKUDbF; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45f2f10502fso4876405e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757942935; x=1758547735; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TVHbhdFlZbCxCpedbs0oq4d1TdjX8kTA2AdsFzOlTX4=;
        b=aOnKUDbFR1raxqstrrMnLs5ypmeW7+AMEVklnkECqgrc4fy2fRdI+Lmn0VOvRx7jZD
         oCfji401BjVk/5MoU1xNP16B/dDiFORlmLOkHebSxIA+oIGO/LlIlZreER9qle+vMhkc
         OICEZfNCkWcx6LdmZc5h10XtNy6EArBCUz1f8Nka7vanhDeNYmOcMIILAl0fqgNT/MZ7
         /hnpLgmOdgDp19jyf10cFEU+uVn8PNRHfD9hSUuroHGDX1TEIXaD79WSZZzvBH70BTst
         d3q8EdV3wWiIKSSfoLYD2BZkmvKaSodY3Yhco6S5nqFm3q8hwFPaUtzoE2+NjA7cEPOk
         9UzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757942935; x=1758547735;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVHbhdFlZbCxCpedbs0oq4d1TdjX8kTA2AdsFzOlTX4=;
        b=aUvJhmKbbW2XeK8b0Juss44N66O32Efit4E3xpxZx1DYZcJ9g4NOkkC3nQn8+HzwIF
         Z89QWRPA+ZUHjpu88KMa7WDisWLanFB1VgUTy9Ct2xzLJNr8wlZRIHYHNqKgRXRDUO+A
         /sl07IkQOzA2Iow9bFzPUBf3d5pvBfEDhVjXc1Ya/6um3w5eBHwitXHqckkBxd66gyaG
         NvbuNUQm+ckp1VUHN5nukxobdpzPG7biRA+0QxX6y3BLhdPkA952oLaMrgix9tAQ6thJ
         fzaC2qaGOwAms9R5kVW3VsGdcpJ1TCJ1pxg+guQU36amgQ7b3FP7kkGHWCjJyiRHO/rf
         Lpdg==
X-Forwarded-Encrypted: i=1; AJvYcCVzr8bRpgyZt7YsgCQAn+5Xp9tS3Kf9hsh2L3zoaQvWeNiAb5a/xc4ENZ0GtJQairUL7ThC2LpaAIGFC1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzn+OPzFlI6458N0MG3VJU8Pn9M/nsqy1zeQxXpmnrHxVmOgTG
	z3vcp+JoJbPJAsq4jGhW9R1iyGYcTG0rrImbPBYqhIYiD4b5bhD//F4+zKFbqwwkmAE=
X-Gm-Gg: ASbGncuxwAhWLcemRljUR31dT1M9EfpVKvePtiYFc3QKRBxX7qqjBzfvzGlYrMBALbV
	hwSApvD/EidCzVFyqtbRa8HumtGmvOUKqFTcs0CDbBoptLgV+YjAY5MJ2Tc0GD/y1lV6PLow7Yz
	7XiBQ9tWeSuKdnUDP/mVZUnZSrXlBxBSKaMU6n8nxJDrcIY/1xv8VafWWXw+Hco+m5yu9mxrw2S
	iBKna3xwaopM8R82GbIhjs1fHNkzpzj+vFm1kFohb26kyB3tREJPbuswM3LVPLl0rNFojCn8ak4
	mLe0+rwCpH+/OkPEhUxOM3ElEUS5yy/PAV8ipizw8gHEjC9v3JAjGAcgsK9J7BM5wCEoG/B+e2x
	GhC1oYpRwmEhei0NYINBxTx6la2sAkIXu70o=
X-Google-Smtp-Source: AGHT+IGJnCCPqoXVoOCe6Ybp+0WcFTMjegCGCm0f9UTm2uDhPrB0URHDEtkSoTR5+vGjmhJzeUElrA==
X-Received: by 2002:a05:600c:2317:b0:45d:d9ca:9f8a with SMTP id 5b1f17b1804b1-45f211ff8c7mr80370585e9.27.1757942934909;
        Mon, 15 Sep 2025 06:28:54 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:41:eee1:5042:e713:2e9a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e9fd89af70sm5978874f8f.43.2025.09.15.06.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 06:28:54 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 15 Sep 2025 15:28:32 +0200
Subject: [PATCH 3/3] arm64: dts: qcom: msm8916: Add SDCC resets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-msm8916-resets-v1-3-a5c705df0c45@linaro.org>
References: <20250915-msm8916-resets-v1-0-a5c705df0c45@linaro.org>
In-Reply-To: <20250915-msm8916-resets-v1-0-a5c705df0c45@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Vincent Knecht <vincent.knecht@mailoo.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Add the missing resets for the two SDCC controllers to allow fully
resetting previous hardware state from the bootloader.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
Unlike the previous two commits with the MDSS resets, this is more
"cleanup" than "fix", so I omitted the Fixes tag and Cc stable here.
There are no reported issues with the reset omitted.
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index de0c10b54c86c7795b7a0d1ecd80652e60e117b6..d3a25a837488c940f7f9dd08d0aa4054aeed014c 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -2127,6 +2127,7 @@ sdhc_1: mmc@7824900 {
 				 <&gcc GCC_SDCC1_APPS_CLK>,
 				 <&xo_board>;
 			clock-names = "iface", "core", "xo";
+			resets = <&gcc GCC_SDCC1_BCR>;
 			pinctrl-0 = <&sdc1_default>;
 			pinctrl-1 = <&sdc1_sleep>;
 			pinctrl-names = "default", "sleep";
@@ -2148,6 +2149,7 @@ sdhc_2: mmc@7864900 {
 				 <&gcc GCC_SDCC2_APPS_CLK>,
 				 <&xo_board>;
 			clock-names = "iface", "core", "xo";
+			resets = <&gcc GCC_SDCC2_BCR>;
 			pinctrl-0 = <&sdc2_default>;
 			pinctrl-1 = <&sdc2_sleep>;
 			pinctrl-names = "default", "sleep";

-- 
2.50.1


