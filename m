Return-Path: <linux-kernel+bounces-798827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C8FB42381
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C55183AD56F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA723112C4;
	Wed,  3 Sep 2025 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z4iikCw1"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554D23093CD
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756909483; cv=none; b=VrLwvb+UayQCTq9MZF6xGVPVdXoASz4Si0pZLrpXHuwkfzEzY/6pS023WcT9jbuw+/fZnlcntGj/4G7hoxb8E1og+3/KwRD75zoQ31e+VEkHtl/FH4FwUVGBaMJETVFRmhcgDe7L/EOywMQSKy08kF5IkqJ3VKCBtRZ00x8jWeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756909483; c=relaxed/simple;
	bh=O0ZaIGzNEXwrghncj9YNIJwIZXgEV0h6GP+O9Ob9bCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ArARRCjqdcMTANgEp62xxPIgDQkWSNq+QWTSiujHWzfCKzEWYN93PQIaiNGG/dpcqSsIvgZ/WY5/na4vsSOWjTFXqUwQl2HSG8tnbw2la8rv6Tc0ZSAIjHLIx6d96o7Yt5AO4QPqcuLBjniyy4jqDImPHy/ji04PBUlPIxRbuBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z4iikCw1; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3dad6252eacso835138f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 07:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756909480; x=1757514280; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dXbwYHHwDtZG7uyxiQ/Fmn5Mt+BEh2eODNORnfwMtFM=;
        b=z4iikCw1gTz5ZpisslL/pguJonOHjVLMnpGioM/7uchq32IcYVHDmsPLA3h8fDyZMf
         De8Y/nYwbtVq/YFoDpbyoD2E3X49f5wyjG0asUJcE9ZUzRjMygqiJTOTlwG8wpcHpkdv
         chbXc/Fb20qikQuBd4pmDx7AszFRe9B+RvAAohuE4OYoJA/MkvBs+7VvKI39pO/uXqGy
         yLry0Fn7/Rwz+tcuIRgJvKpenUS0a9MXSp2quJnWTIczTXfHTL/jojil1YGBean5/XN5
         s5ntOTq1H/TSfuYmLrPuX6JUNNPUuWJH7AQqo2LqQLquwxsT/UeezZUoNLMcgNzMuJDT
         3tEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756909480; x=1757514280;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXbwYHHwDtZG7uyxiQ/Fmn5Mt+BEh2eODNORnfwMtFM=;
        b=bJs3ONyBfYo5iqo774Iy9g0ZN4zF/QNzo+3zXQIM8eupvelnLPC4VimXz9nFI56Ja0
         7RRnx7UyM4BbWrEqeTQ3HphYfMgMi1GvgCf8mpPoK5zS4/xBwbfkwVYFeYKP0DkL1roX
         UJvtZunTZrSzsGNY4F4lRuw5CNC/h6aKoacazg2CrACJHxjgiYEdUu5vRtNk3POy2Pmb
         nAUlkabEirMNiaEa8fHKGoj7pjQc/9gnOpwJPC/cp6N/hGaJiMw9m0saZENN5rAb4K6M
         JflpPPDo7uCr9GaTLoTbxDIaoe2jcH4lvfe30sVIfKI/bop2ZCqqlQ2Dv8y/5aWv3Y91
         GvFg==
X-Forwarded-Encrypted: i=1; AJvYcCWv2am0xb8MdkknkDRfB4Jv/o8iOr7XWfELqqCfLv9y59ror+yVmg6E5LbpPZWJpvIngwpVwuYIbCzyToA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG2lPkBEsP5OQeuzcaF+WuvTuG2DM82Lhncjo0C67gFhNQ+614
	gcAOwnh6qaaxST78S/CqiR8UBADHNXxG1aAaQj/oizjFexjXvKA3Y0oLyZeOydDBFLA=
X-Gm-Gg: ASbGncsCDr+cCZxAB5ywKWpQfeiidyvfUC3t37fSqXdyeb5QVyHg9tzK37K3kFnX/BG
	mKr8VIvkNrlozpAmYXyfHJmZ5A3UdO/wxw1LoAleQhg2ObafkdVTIPY8ETAlF1XO1NGW0NwLF7H
	AA9e1HjsLnMRHk8+C0eRoBuNYvYlpv6TfbXBtE1vi4n5XFvdGewgMfZZfwtXQJmL8FMlEn1Rbzo
	FGzqABA+ufnw0apsd7z5YaTHVysFmNO2HfF+s0ULLJPQrPEpYFy1x812BzFx1n66PXX/z4LEp1j
	xVOOGsG5ygk8Xa8GYedGfLg33XhkChFYtLLMHtdkuzy5hppequGQK+Cs7If/sjVoqZ7YBC7kxFm
	p0GeGs/CKPlmRv5Y4CV8TprnxbX2JsS/mRekxyaS7uW0Q9hWLSFcKbWEhSvxUhSZ8NWoLnKcdHl
	TyOw==
X-Google-Smtp-Source: AGHT+IGElUVvAdnTLsoSyPE4S7KSi1NXgc85bTjMPXuYMbOZdz2o4+8xSGY8r8pqxR543TVqoUC2FQ==
X-Received: by 2002:a05:6000:1884:b0:3d8:7c6e:8ad4 with SMTP id ffacd0b85a97d-3d87c6e9003mr8330251f8f.10.1756909479612;
        Wed, 03 Sep 2025 07:24:39 -0700 (PDT)
Received: from ta2.c.googlers.com (219.43.233.35.bc.googleusercontent.com. [35.233.43.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3dc1cd4a7d2sm3996035f8f.33.2025.09.03.07.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 07:24:39 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 03 Sep 2025 14:24:35 +0000
Subject: [PATCH v3 1/3] arm64: dts: exynos: gs101: add #clock-cells to the
 ACPM protocol node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-acpm-dvfs-dt-v3-1-f24059e5cd95@linaro.org>
References: <20250903-acpm-dvfs-dt-v3-0-f24059e5cd95@linaro.org>
In-Reply-To: <20250903-acpm-dvfs-dt-v3-0-f24059e5cd95@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 willmcvicker@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756909477; l=858;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=O0ZaIGzNEXwrghncj9YNIJwIZXgEV0h6GP+O9Ob9bCc=;
 b=Vo6WkR/E//OV0DsTSlpds8sKzQhNQBSu+HqfP4AtDKHJiLDyc7STDizBG48Nhd4baH1I3LEcE
 1EAmsYRXET3B43eHFQZqaTcqLTcXr2LlCFSs8nmManOhkxRVzbBznF4
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Make the ACPM node a clock provider by adding the mandatory
"#clock-cells" property, which allows devices to reference
its clock outputs.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index c0f8c25861a9ddb5bbd256b62c66a645922ca74e..f00754692bbac39fd828ebd4ef7c269f746f2522 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -202,6 +202,7 @@ ext_200m: clock-2 {
 	firmware {
 		acpm_ipc: power-management {
 			compatible = "google,gs101-acpm-ipc";
+			#clock-cells = <1>;
 			mboxes = <&ap2apm_mailbox>;
 			shmem = <&apm_sram>;
 		};

-- 
2.51.0.338.gd7d06c2dae-goog


