Return-Path: <linux-kernel+bounces-788344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E52CB38330
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E61DE7C309B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F49352FF3;
	Wed, 27 Aug 2025 12:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U9o2A23h"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDE8350D56
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299595; cv=none; b=FLx4rCXA+2QiE1KYIycf5s/EHsCSDXmtohI3y1TIYaJ4lmVFaoKR9r1UxDpBNer6i5xYUqkbat8dx7gv7uOGwxbw95mZ2N2/zKIWcfRDAvaj5PLfSsYJpTDFfe1WajFzjaJZx2lQQ+rSDjT+Oq6rRXiVmhqDV7AHu0HahDvbLcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299595; c=relaxed/simple;
	bh=ilKTGpL8p+yK7fouXhyJKKJIn3wFUBwNKCBuAYnOCV8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FzcEgB39r4/uhrlbjNP1gZuYXKmb8RSOzrYXN80cqg6PFwecAOHg1Nw5qAvMB7FxEizTe0lsOWSNAG4kHE2W8qtSGLEjRJBIHxqn/VGzq505ZY9TePIErygBXeip+jI9lRhahO35NeagfC8+9lVB3u9s7XqgPUVn2hgVRZbZgys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U9o2A23h; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45a1b004a31so52229755e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 05:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756299592; x=1756904392; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DCeRnvwIwToVT9tzVGSX3TKpkZOwpXXqQJD8l0qKSjo=;
        b=U9o2A23hz7dbXATl8ejM4MT2S7bzy7BTNjXWKnlpPT3wDe7uA+lSa/qXWWzoOX3Pt8
         Yqq4rqhxzxQCfzkCUW015I0HuIHy4ipb0mHcIk4lo2XCC15xeZ7w6HeydUmHGM2YssIM
         DjCg9D8JC7Rbc9aW+5UZcLlEzrN5GaNr/ka8ttYQ2Z0Juj6faHNdAAG4uyEKm7tZY0ay
         OR+ojVAZVyJnTkH41D6cP0d4sDiw91xPw9dBvSHXhT2cQ/b3khrPaTYxoPkFnrIDRH9f
         HqnTwHgK4SVd8uQq/AAIaVnzNMxuw8Ed32fFNa6uHEw0/1QekAVYUJLDlhtODP3vYwQh
         f2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756299592; x=1756904392;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCeRnvwIwToVT9tzVGSX3TKpkZOwpXXqQJD8l0qKSjo=;
        b=rthsdfbR20oSqpOur8lopu+Sqz3kuWPYBhZHTdHLCCLI/dK/XvZ8L92Y7c5qZ1B/Bq
         Art/XY34Cm8XeWoLlJkxdX9EIm+FHFH9GxMX80yfyfNZ/y4M54u7ZCvAVGeANMRtmAOF
         tQvkbk1zgho314ZT9m85rR3+VdzuxRMBw5v5XYpA/a2J6sIym5CMO+QYGPkqpu166FuQ
         yTpePadakb+QmRnWl/vZRiATABIX931ZmBKA+MJ2fRcGIgc9F5kPBIum/PxoXZ+nGk4J
         cxEBF67KsWz68eoMzgNRqkhgKpqogzlhI9ZP7TlEOzmV06n3cTrAQg5OEm/qG9uf+NGg
         DVOA==
X-Forwarded-Encrypted: i=1; AJvYcCX/tK4+O4WW5FiykPlbBFJCwmzKlPQZ/oYNOF5FONJscILDJ/KXSW4tSqmrYcz8KZLA7L4Uu3HAnhLRBOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJG5IAOdtDEWzW1Mivir+ksHijShwFwMHy8XAjozDbMsuKPtbr
	ibMg5hnePcgb/tjMzB74f9e7x1YeEk8IUCD6ATq4dNfUsqJ2NF26BZoBSEK5PxvfxL0=
X-Gm-Gg: ASbGncvwUhuWnr59qtyPvz6Q1IRXwRgwMJN9PvjQ+xbOSM8nTzq/jfuaQR2TO9fAL3d
	EqwM7ABC7Mry934YkYVPGriLyGQcMIm6B47n32OnFrNLPEidOpWuMuMpM9rDvH8Z4rTaSKVAd66
	bG1AAyOYQC0bLCUyoU71zjE7+Nzy9J5XnWEUTcuNshUtHFUNWvVwf0+LrawUhy8TU25vAOUyIrZ
	2G11d9gpRoaUs7P1OZlj69ZXCr0NpNSyBVlF2/63yfZyh8b9ARYi3OqbEatNdam7SMAwTwrRDa3
	IPX+BwtIMvhoBb54w59LHYyxr1QbsMKKizJ+qeBE7rri/8ediogQTl3O44EZjfXuBb3b9onDpvq
	O1Kcn1O/ONe3VUeAAimfyBCHJuds3HRbzlXZmIzly35T5c96FFYrWNRrtqgg2J0BQgBG329HbaE
	phl9PBL/1rLhNz
X-Google-Smtp-Source: AGHT+IHcZaQnOcpYhjyFzI9pl9OBFoLTV/VhmC5SoTMl9AG5tPVtEyRkPGlqjqBSq/5A0/JQHpN0FA==
X-Received: by 2002:a05:600c:45ce:b0:458:b4a6:19e9 with SMTP id 5b1f17b1804b1-45b517a0b56mr176257545e9.13.1756299591774;
        Wed, 27 Aug 2025 05:59:51 -0700 (PDT)
Received: from ta2.c.googlers.com (219.43.233.35.bc.googleusercontent.com. [35.233.43.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cc890b178bsm3272069f8f.52.2025.08.27.05.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 05:59:51 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 27 Aug 2025 12:59:48 +0000
Subject: [PATCH v2 3/3] arm64: dts: exynos: gs101: add OPPs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-acpm-dvfs-dt-v2-3-e1d2890d12b4@linaro.org>
References: <20250827-acpm-dvfs-dt-v2-0-e1d2890d12b4@linaro.org>
In-Reply-To: <20250827-acpm-dvfs-dt-v2-0-e1d2890d12b4@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756299588; l=8498;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=ilKTGpL8p+yK7fouXhyJKKJIn3wFUBwNKCBuAYnOCV8=;
 b=+4DwtbmbSXHX8w9ZZm7MGqJrAgJXHbEKXLufGVn24jsLCZ/kxgUxDSosmoI6WPwggJIhMNpzi
 Raq7kDhKzQbBcbDRNhbfsyzqLO9tT7VtLUJFnfjt1XEPc8+YlFumYxb
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Add operating performance points (OPPs).

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 275 +++++++++++++++++++++++++++
 1 file changed, 275 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index 746b7d8ecdc90fd746015b8322924bac66c6e363..0bd7e8181c40754f19626a49dedc3a6fe65525b8 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -77,6 +77,7 @@ cpu0: cpu@0 {
 			cpu-idle-states = <&ananke_cpu_sleep>;
 			capacity-dmips-mhz = <250>;
 			dynamic-power-coefficient = <70>;
+			operating-points-v2 = <&cpucl0_opp_table>;
 		};
 
 		cpu1: cpu@100 {
@@ -88,6 +89,7 @@ cpu1: cpu@100 {
 			cpu-idle-states = <&ananke_cpu_sleep>;
 			capacity-dmips-mhz = <250>;
 			dynamic-power-coefficient = <70>;
+			operating-points-v2 = <&cpucl0_opp_table>;
 		};
 
 		cpu2: cpu@200 {
@@ -99,6 +101,7 @@ cpu2: cpu@200 {
 			cpu-idle-states = <&ananke_cpu_sleep>;
 			capacity-dmips-mhz = <250>;
 			dynamic-power-coefficient = <70>;
+			operating-points-v2 = <&cpucl0_opp_table>;
 		};
 
 		cpu3: cpu@300 {
@@ -110,6 +113,7 @@ cpu3: cpu@300 {
 			cpu-idle-states = <&ananke_cpu_sleep>;
 			capacity-dmips-mhz = <250>;
 			dynamic-power-coefficient = <70>;
+			operating-points-v2 = <&cpucl0_opp_table>;
 		};
 
 		cpu4: cpu@400 {
@@ -121,6 +125,7 @@ cpu4: cpu@400 {
 			cpu-idle-states = <&enyo_cpu_sleep>;
 			capacity-dmips-mhz = <620>;
 			dynamic-power-coefficient = <284>;
+			operating-points-v2 = <&cpucl1_opp_table>;
 		};
 
 		cpu5: cpu@500 {
@@ -132,6 +137,7 @@ cpu5: cpu@500 {
 			cpu-idle-states = <&enyo_cpu_sleep>;
 			capacity-dmips-mhz = <620>;
 			dynamic-power-coefficient = <284>;
+			operating-points-v2 = <&cpucl1_opp_table>;
 		};
 
 		cpu6: cpu@600 {
@@ -143,6 +149,7 @@ cpu6: cpu@600 {
 			cpu-idle-states = <&hera_cpu_sleep>;
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <650>;
+			operating-points-v2 = <&cpucl2_opp_table>;
 		};
 
 		cpu7: cpu@700 {
@@ -154,6 +161,7 @@ cpu7: cpu@700 {
 			cpu-idle-states = <&hera_cpu_sleep>;
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <650>;
+			operating-points-v2 = <&cpucl2_opp_table>;
 		};
 
 		idle-states {
@@ -191,6 +199,273 @@ hera_cpu_sleep: cpu-hera-sleep {
 		};
 	};
 
+	cpucl0_opp_table: opp-table-0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <537500>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-574000000 {
+			opp-hz = /bits/ 64 <574000000>;
+			opp-microvolt = <600000>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-738000000 {
+			opp-hz = /bits/ 64 <738000000>;
+			opp-microvolt = <618750>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-930000000 {
+			opp-hz = /bits/ 64 <930000000>;
+			opp-microvolt = <668750>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-1098000000 {
+			opp-hz = /bits/ 64 <1098000000>;
+			opp-microvolt = <712500>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-1197000000 {
+			opp-hz = /bits/ 64 <1197000000>;
+			opp-microvolt = <731250>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-1328000000 {
+			opp-hz = /bits/ 64 <1328000000>;
+			opp-microvolt = <762500>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-1401000000 {
+			opp-hz = /bits/ 64 <1401000000>;
+			opp-microvolt = <781250>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-1598000000 {
+			opp-hz = /bits/ 64 <1598000000>;
+			opp-microvolt = <831250>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-1704000000 {
+			opp-hz = /bits/ 64 <1704000000>;
+			opp-microvolt = <862500>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-1803000000 {
+			opp-hz = /bits/ 64 <1803000000>;
+			opp-microvolt = <906250>;
+			clock-latency-ns = <5000000>;
+		};
+	};
+
+	cpucl1_opp_table: opp-table-1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <506250>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-553000000 {
+			opp-hz = /bits/ 64 <553000000>;
+			opp-microvolt = <537500>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-696000000 {
+			opp-hz = /bits/ 64 <696000000>;
+			opp-microvolt = <562500>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-799000000 {
+			opp-hz = /bits/ 64 <799000000>;
+			opp-microvolt = <581250>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-910000000 {
+			opp-hz = /bits/ 64 <910000000>;
+			opp-microvolt = <606250>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-1024000000 {
+			opp-hz = /bits/ 64 <1024000000>;
+			opp-microvolt = <625000>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-1197000000 {
+			opp-hz = /bits/ 64 <1197000000>;
+			opp-microvolt = <662500>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-1328000000 {
+			opp-hz = /bits/ 64 <1328000000>;
+			opp-microvolt = <687500>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-1491000000 {
+			opp-hz = /bits/ 64 <1491000000>;
+			opp-microvolt = <731250>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-1663000000 {
+			opp-hz = /bits/ 64 <1663000000>;
+			opp-microvolt = <775000>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-1836000000 {
+			opp-hz = /bits/ 64 <1836000000>;
+			opp-microvolt = <818750>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-1999000000 {
+			opp-hz = /bits/ 64 <1999000000>;
+			opp-microvolt = <868750>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-2130000000 {
+			opp-hz = /bits/ 64 <2130000000>;
+			opp-microvolt = <918750>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-2253000000 {
+			opp-hz = /bits/ 64 <2253000000>;
+			opp-microvolt = <968750>;
+			clock-latency-ns = <5000000>;
+		};
+	};
+
+	cpucl2_opp_table: opp-table-2 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <500000>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-851000000 {
+			opp-hz = /bits/ 64 <851000000>;
+			opp-microvolt = <556250>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-984000000 {
+			opp-hz = /bits/ 64 <984000000>;
+			opp-microvolt = <575000>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-1106000000 {
+			opp-hz = /bits/ 64 <1106000000>;
+			opp-microvolt = <606250>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-1277000000 {
+			opp-hz = /bits/ 64 <1277000000>;
+			opp-microvolt = <631250>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-1426000000 {
+			opp-hz = /bits/ 64 <1426000000>;
+			opp-microvolt = <662500>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-1582000000 {
+			opp-hz = /bits/ 64 <1582000000>;
+			opp-microvolt = <693750>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-1745000000 {
+			opp-hz = /bits/ 64 <1745000000>;
+			opp-microvolt = <731250>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-1826000000 {
+			opp-hz = /bits/ 64 <1826000000>;
+			opp-microvolt = <750000>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-2048000000 {
+			opp-hz = /bits/ 64 <2048000000>;
+			opp-microvolt = <793750>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-2188000000 {
+			opp-hz = /bits/ 64 <2188000000>;
+			opp-microvolt = <831250>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-2252000000 {
+			opp-hz = /bits/ 64 <2252000000>;
+			opp-microvolt = <850000>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-2401000000 {
+			opp-hz = /bits/ 64 <2401000000>;
+			opp-microvolt = <887500>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-2507000000 {
+			opp-hz = /bits/ 64 <2507000000>;
+			opp-microvolt = <925000>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-2630000000 {
+			opp-hz = /bits/ 64 <2630000000>;
+			opp-microvolt = <968750>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-2704000000 {
+			opp-hz = /bits/ 64 <2704000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <5000000>;
+		};
+
+		opp-2802000000 {
+			opp-hz = /bits/ 64 <2802000000>;
+			opp-microvolt = <1056250>;
+			clock-latency-ns = <5000000>;
+		};
+	};
+
 	/* ect node is required to be present by bootloader */
 	ect {
 	};

-- 
2.51.0.261.g7ce5a0a67e-goog


