Return-Path: <linux-kernel+bounces-775637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F50B2C2C2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F9444E3A4A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFBB3376BB;
	Tue, 19 Aug 2025 12:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MrRgKEKm"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F2C20C000
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755605434; cv=none; b=jzEbUGnbmBwRfb+IGYsGaqIi7NCeKRZlc5oXLGNuovwBWfkhO2zwQ5LQqnqm3Wncf6T+0SQbzU8SjLcgmXI2/9SIwANNSi2k2glhK5zUQhT8tTFNr59y4yap7roTtb5ytSVO1kZIQwdZhNf5qjvo9pTe6UtqbKdSVGIdL5aVU4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755605434; c=relaxed/simple;
	bh=nqRaXwOYUnbNG0j2pkHNtlxp7R1a7PqyphjeUytPpmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sR04ePA9ntnEOWaIytpkrcWft2E7PXNoKjdXXD8NehaimBFdXxT2l9frUz7I1NrtK0DUvthRXtZlgcoMhsyJSi5iUiOI4ej3H3u+56cvEazVyGwArSq8Br16zCJYCuWywlilSxE2MUa17d3ggyjhKxEho7EYCIQrXafnlX8QGvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MrRgKEKm; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a15fd04d9so39716565e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755605431; x=1756210231; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2R8D30km/KSA0O4LJJjN/QUo92gPxApdF/JdH5YvZSM=;
        b=MrRgKEKmifbADj5O9EzoyijMXjJ3Ds00E8WZjlEqINctrzxGyyATb67UO3k1lwpdr/
         F+df57i7A0XP/RyYehUgvy1PEHw3ap7h00FVQtKztNUZGcXCwVKK5cezF3wP9E46E6E1
         9n57cHM0aOESOJMoQARsmFLtgFtcRMYeDzl+b6O4aFd9WCUogXfazcpei1esjjcialp/
         S/TRaRXNZg7EWuvSBsG9Tfz+O/x2zaXpW+uHErt6NoYvbjavwXcFhZVJGO1hWNq/yJGU
         4HfiLvvGmhZl9WYMXP04OjbfAncWtzu06xNQxzwQw0GbH60Y9z6zHnuP1EUVp3fhfKO6
         x+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755605431; x=1756210231;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2R8D30km/KSA0O4LJJjN/QUo92gPxApdF/JdH5YvZSM=;
        b=jKRaSh9e4KleKByVzDkzLeuh/BwMltYjEqG6BZ9mmp21JEzHHAa/5i/WuLbNOFLF5v
         avpllp6fGnH7/0kQlMz2k2nRnYD8QrN8lrqYoKatJMcMug9GrMGiQWGu5RkCD1uCzRmt
         LdbaISsT+aof1862LybHFvbVeol68qnMU4XWXB0acRmy5T01y9TedRUk0S4jcgbxCG6o
         xlLMYowCZk+SWxP8RW4YP3hUJ+YQiAIQY8ySI1VJ0PCplWezzd3/GKd2GENIHG9BvAIC
         haIr4xPG+P9/n0S+XjzIyR9+iKMkVNBt8YilkRajrWikdOjaPGh0uuSRbYu69TfXyh0f
         +5xA==
X-Forwarded-Encrypted: i=1; AJvYcCVNXRsz1sT4j5YgzxpY+v0RZ5D/oN1+FoJ0Xgzu/IM7qCc+k3ELrGQ5JIKl4NMvoTBIGvTFy7Jrc1beHQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAVn/5bXuw8YrKvwRaV9kDIhniyMLYz0QJGBHbRb9BErGmMMRs
	mgrgsuPe7GPkYWSjdLFUceKKZyrauk1Jzj+WEV27mG+Bq4bmE1J6+a/8Ii6dQNcWmh4=
X-Gm-Gg: ASbGncs0b3mWe0GLtICGS7K4WVyHk3FeYD4I+A3WVJYEVDtZOirK+ZWWy+HpLlgdMat
	yW1GE/cBsSHiQeSNzu708ezBIRCBs7dpOvA2PjJntGqYLJ0eULCwBCIHge23SBurRZLC4VYnEY9
	ARYYOwBNOm0VkEyk4Y+ZI31wXniVjblsTEa0v9x1DCJ/IM7qss4LJU1IAZQPycj1SOu8LBOWUkt
	jKGU7mWbYDFhZO59c1xn7N0V7ICmfBJyh8WqrnPoHwCsaTJ/+31PfziTGL+iY9FNH2DGuJm7D35
	Otxv7BYVy2tS4dcUUPerQ+DQUKbmxoZb5pd+KRuumv+eZAgmj1Lhpz/kVvSfh0zkBbhEY9dNlH6
	cDChfMgYnEDDuJ7Ok/7YsgPwtOOqcXMvkc3MlzrbHu2auwztAdtgQ2M16WNJAzMPxw//e4NHob6
	vC3w==
X-Google-Smtp-Source: AGHT+IFppDDMa2VTL2CIGZHM9gzBH35t1wQZSmplPnzJjHi59FMlVUz9oCZUMUh1Ng+uHKmRdhHOVw==
X-Received: by 2002:a5d:5d0a:0:b0:3b7:8acf:1887 with SMTP id ffacd0b85a97d-3c1333b5d05mr1714373f8f.13.1755605431436;
        Tue, 19 Aug 2025 05:10:31 -0700 (PDT)
Received: from ta2.c.googlers.com (245.92.187.35.bc.googleusercontent.com. [35.187.92.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c074d43b9asm3464410f8f.24.2025.08.19.05.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 05:10:30 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Tue, 19 Aug 2025 12:10:21 +0000
Subject: [PATCH 2/3] arm64: dts: exynos: gs101: add CPU clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-acpm-dvfs-dt-v1-2-4e38b95408c4@linaro.org>
References: <20250819-acpm-dvfs-dt-v1-0-4e38b95408c4@linaro.org>
In-Reply-To: <20250819-acpm-dvfs-dt-v1-0-4e38b95408c4@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755605429; l=2818;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=nqRaXwOYUnbNG0j2pkHNtlxp7R1a7PqyphjeUytPpmQ=;
 b=pFUBFj/DVmeY+1QROIBAVpK6j8hChOM2KVuU6gLsrewVj4sNAL6TBghVOuWhfLXWLQ2nbVtIP
 K8YHpySm5NaC08vEfS1NamJQbC18pPnsZa5Tc0q0R/snEt9EkN0plWQ
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

The GS101 CPU clocks are exposed through the ACPM protocol. Add them.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index d010b8ffc4e09562519d6796691fe573c68b7ac7..42926f8bde8889ec99ecf9fc551629a0453e788f 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -72,6 +72,7 @@ cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0000>;
+			clocks = <&acpm_dvfs_clocks CLK_ACPM_DVFS_CPUCL0>;
 			enable-method = "psci";
 			cpu-idle-states = <&ananke_cpu_sleep>;
 			capacity-dmips-mhz = <250>;
@@ -82,6 +83,7 @@ cpu1: cpu@100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0100>;
+			clocks = <&acpm_dvfs_clocks CLK_ACPM_DVFS_CPUCL0>;
 			enable-method = "psci";
 			cpu-idle-states = <&ananke_cpu_sleep>;
 			capacity-dmips-mhz = <250>;
@@ -92,6 +94,7 @@ cpu2: cpu@200 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0200>;
+			clocks = <&acpm_dvfs_clocks CLK_ACPM_DVFS_CPUCL0>;
 			enable-method = "psci";
 			cpu-idle-states = <&ananke_cpu_sleep>;
 			capacity-dmips-mhz = <250>;
@@ -102,6 +105,7 @@ cpu3: cpu@300 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0300>;
+			clocks = <&acpm_dvfs_clocks CLK_ACPM_DVFS_CPUCL0>;
 			enable-method = "psci";
 			cpu-idle-states = <&ananke_cpu_sleep>;
 			capacity-dmips-mhz = <250>;
@@ -112,6 +116,7 @@ cpu4: cpu@400 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a76";
 			reg = <0x0400>;
+			clocks = <&acpm_dvfs_clocks CLK_ACPM_DVFS_CPUCL1>;
 			enable-method = "psci";
 			cpu-idle-states = <&enyo_cpu_sleep>;
 			capacity-dmips-mhz = <620>;
@@ -122,6 +127,7 @@ cpu5: cpu@500 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a76";
 			reg = <0x0500>;
+			clocks = <&acpm_dvfs_clocks CLK_ACPM_DVFS_CPUCL1>;
 			enable-method = "psci";
 			cpu-idle-states = <&enyo_cpu_sleep>;
 			capacity-dmips-mhz = <620>;
@@ -132,6 +138,7 @@ cpu6: cpu@600 {
 			device_type = "cpu";
 			compatible = "arm,cortex-x1";
 			reg = <0x0600>;
+			clocks = <&acpm_dvfs_clocks CLK_ACPM_DVFS_CPUCL2>;
 			enable-method = "psci";
 			cpu-idle-states = <&hera_cpu_sleep>;
 			capacity-dmips-mhz = <1024>;
@@ -142,6 +149,7 @@ cpu7: cpu@700 {
 			device_type = "cpu";
 			compatible = "arm,cortex-x1";
 			reg = <0x0700>;
+			clocks = <&acpm_dvfs_clocks CLK_ACPM_DVFS_CPUCL2>;
 			enable-method = "psci";
 			cpu-idle-states = <&hera_cpu_sleep>;
 			capacity-dmips-mhz = <1024>;

-- 
2.51.0.rc1.167.g924127e9c0-goog


