Return-Path: <linux-kernel+bounces-816316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBF0B57245
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F92A17DCA7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01BD2EA159;
	Mon, 15 Sep 2025 08:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wv/toyx9"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B072EA730
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923347; cv=none; b=BnNuuWXr6Xh7E/ZP/wkqORgYQtNRhLyYoG5UQd+NiosWuwVGRoCBln2Vbju3B+hSKD8UFJGT9kvUufXUXgYavklY85td0w6qNNKuklpgSkpw0QBGTRCsO+kIPWYoB7eYECoWq7OQsBN9/CmUqy195bDUhLaHjhJFTcH+adysn9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923347; c=relaxed/simple;
	bh=y84VDV0rZer94jeWEUGutZ+DiGlWK+mnb2KewZUqkys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSSFi2YBjQRB7mqsmn+oS5njNDUSsw09rdO1OtwcSn4t1/sl1rIwUwzqGKitFqttjrUyGCv8sEhoTgsbO8fmyIrqjTaDnF4q8PqeqWlCYplcDU/+njQ6noUSvo9WmMO0fFfReQe9xcK6Agv60Upd0hj0S613LfU0BiLnd3gjJTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wv/toyx9; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f72452a8eso4512994e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757923344; x=1758528144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFtIJBuALfkec7VGR4PeH5fwH/AzmTzDZVD8lAug6hM=;
        b=Wv/toyx9Ty3pulYm0UcY4Q/22F4JSMxYIgAJgtualy/TduDl02If2eBvuqedo1soNX
         3r6JqdGUftebh7ifqZMCbnlclJ17cHGe8auMfd+SxsSUflkOzCUmO7WEyZdwfhJCY4V0
         0BY3MSYlqtP31LbKNUrpvGQZPhoWm+zHkyF0apmA0n9QytU3xh5uDQLlzu4blI2muobw
         YoCiSoIwFj/0kVVS/gij0aVwIJrz+rNg6TgME+6y8cbPzkv4JHpu6wnTE7Is2TdUYCSz
         xE8lCCvcQLvzMyIFFAMWt+mfn6+12PQtZ+mVTvFbqJ8Uy9BBUv7/wbkEEk4dgb9B+ty9
         awtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757923344; x=1758528144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFtIJBuALfkec7VGR4PeH5fwH/AzmTzDZVD8lAug6hM=;
        b=wJHScMoH+igQ1A47dpzafwWTiAfMMA2Cj3FMQNqUufQr2+8l44xwjSAysPTL5vssqA
         qE3i4iX7hb2qJw36i01rFTxWI1zDYpc21b+27i76+HdzXq2l3JnQp1UQ5+jCPLDE7JMl
         PSY/Eku+SyNq8FGMYMHEI1YF7IAk/9DpNvjhUQ9LE6z6ydN1P3xmvzVm9a/NgEWfSq2a
         CHoFttjweCxRGI6HOmaYTuOdH4K3RgQT9o4FjV014ObY9J2K8Qz+xiuRPrdl+Xh0J2Uj
         411l/VG+ekfkQy3ZllglrQYGG638snPPys0sOZvACmIF9G1kFu9pwxzpckbcH4U7cOrs
         MbkQ==
X-Gm-Message-State: AOJu0YyI05Dbg68To0SEr6Zg3SsfIe3VIKVh3hcxr9y5j3Ai6hqhOVk2
	0r8cBVCrXHUDfH4Fgul/GQMgjcs8uYpmAJxZzx7BXaOandUmkPJe46wO
X-Gm-Gg: ASbGncuicyIUXfZLz025ukuqYs2MC9vJ45ZWb32NkpPvirqYb6Q/1mdqUBzrgfeulFT
	rlGweI0RQeb39y3XcXoH6F4aYCkzhfyM506vgwL2deVCR9Fu6HdTjR+qixR393kRQ0gKA7dkfge
	bKIn78UuIKJHwhPkS45EFxnmbBSTgu9YiF6lnM2WbbUcgC0YUHaBmRYV05TDUicku+U4kNYE3mr
	+KRlmLHAYls85BVgQ/FFlflXkRbqM4Dke57jAmNiMgoJLbSi/BUdqxkJkq9DI3kARfn6xM2a9JX
	yVUGUz4CirSGQLy65DEAU6Wnde1VyKaKyAupgef1QDEAA95eHB0dH0FrkmEN2FMabKW1TIpRCxQ
	0RcNYMeKdXYTr7+mLuyTFbBaw
X-Google-Smtp-Source: AGHT+IFe/jx4tFil9RjxwhD7bREzvIlC8fQ/134z0bvttum74XEn5yTMqRq0eo1UbfObzzjuNO/n+Q==
X-Received: by 2002:ac2:4f01:0:b0:56c:4159:4e39 with SMTP id 2adb3069b0e04-57049f1b51fmr3830912e87.16.1757923343830;
        Mon, 15 Sep 2025 01:02:23 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e6460dec4sm3392381e87.103.2025.09.15.01.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 01:02:23 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Dmitry Osipenko <digetx@gmail.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 02/11] ARM: tegra: Add ACTMON node to Tegra114 device tree
Date: Mon, 15 Sep 2025 11:01:48 +0300
Message-ID: <20250915080157.28195-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250915080157.28195-1-clamor95@gmail.com>
References: <20250915080157.28195-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for ACTMON on Tegra114. This is used to monitor activity from
different components. Based on the collected statistics, the rate at which
the external memory needs to be clocked can be derived.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/nvidia/tegra114.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/nvidia/tegra114.dtsi b/arch/arm/boot/dts/nvidia/tegra114.dtsi
index 5e695431ad2e..08f81a3d11de 100644
--- a/arch/arm/boot/dts/nvidia/tegra114.dtsi
+++ b/arch/arm/boot/dts/nvidia/tegra114.dtsi
@@ -248,6 +248,18 @@ ahb: ahb@6000c000 {
 		reg = <0x6000c000 0x150>;
 	};
 
+	actmon: actmon@6000c800 {
+		compatible = "nvidia,tegra114-actmon";
+		reg = <0x6000c800 0x400>;
+		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA114_CLK_ACTMON>,
+			 <&tegra_car TEGRA114_CLK_EMC>;
+		clock-names = "actmon", "emc";
+		resets = <&tegra_car TEGRA114_CLK_ACTMON>;
+		reset-names = "actmon";
+		#cooling-cells = <2>;
+	};
+
 	gpio: gpio@6000d000 {
 		compatible = "nvidia,tegra114-gpio", "nvidia,tegra30-gpio";
 		reg = <0x6000d000 0x1000>;
-- 
2.48.1


