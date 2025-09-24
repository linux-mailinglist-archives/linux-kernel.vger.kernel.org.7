Return-Path: <linux-kernel+bounces-830797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A83C9B9A907
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D2F3B0CCE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996C73115A0;
	Wed, 24 Sep 2025 15:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v5f+a7Df"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B9A30F542
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726926; cv=none; b=KEWVnOd1dnlAYYSHk0ttS0RWflsifTG3nQZV2xcV40FQnr1bOPSRGhxSyXzbNZFnjdLS6DYEquyLRag84CWVkANgUbKw11J4fFxR2U04+xj1beK+Y6ulpx7jVr/dP1GZY2dkXRH/A2eRxQJWhPWAATIsi/KOAPI9Yp7OtBxvHx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726926; c=relaxed/simple;
	bh=jAhvrkZLf2CPegU55/45LRXE53AONwSoY/Qaao8O1WI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qgFtgO/FMvGn2zzRwRuCKbggXY9++MDMwhVHQmKnRIzz38Iv4rFlUQawC2pMo4Ttc6ju/J0PPKrud/fg9ZIJmauk2fQtyl62ZKNRyN+Y+MnMBopWBg/w5RIJWUkWtCrSHKcFDyfFjQyc1R2KaFEUT7ooCwVI0ebs38TVB/zbPAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v5f+a7Df; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ee15505cdeso872783f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758726922; x=1759331722; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R17pkrZpppT+PTLNe8IiH1GVP2d3cCm4JBkhteQik/I=;
        b=v5f+a7Df1WYipTZxJOnRAo80AoVdqep07YHmAkLoHkOV8QJhMwxgiCJK18TeoOz019
         ujmCZY9g8Gf48Ugp+XvgUHZQkbwYNU7VRLezrNnUDMhHeWvqm6k/RPz5HR3gFfmA21rN
         jQUPFqtcQ3MurDCHwlYUVwWQth8OF82wlErKgNwYJdECicATLS89RKkfAMLaag+eK6J2
         rL7wlte4HFXAPmQ4+1GDmzNkXcbgnEWl748Fbnb2fZISZkzSuWXykPqHpLB3CfvlHs+H
         mPuooVl7hZ2LqTnYmqGOCiWhQZ8IQijLityxlbdRRg8umAqUYNCbVH2ojyxHPxgfr7PA
         LYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758726922; x=1759331722;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R17pkrZpppT+PTLNe8IiH1GVP2d3cCm4JBkhteQik/I=;
        b=X5MrrkMHg9xQ3SZcBZg86ZpdO1wVfWug7uOeRIA3BGJZkXn+aNm8hogurDgkJveYjo
         FsOCDb/uLlpd1vPW3yUoy0XYWhGV3QU9cUWHld2JZifyR7tSLZGkG+gSggWpYspMS6XA
         MzNxLZvOjfU54A6SEDAM2DcURc1zBG0Zs5MBaXEdmNPeD/ZaVPbw3DpW5p4coWB6R/NQ
         Z2ySyXL2/XFcVplRZC8HsTWqt8D7xj29CxmSqQOEsrrqSc9Bl0ooaxx1Ykxpx86OZqUE
         gxC4ZRX+PhKz8EXqvJIOLBfOzRk0gkrZnqeh77YfM+dj0giFhTY0mB6u6Mi52mnO1DAp
         N/dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbv1xHoYArZf9xvGO9cBMUlgGs9qvBr8cwxnjfs2oImMbt59xl+eQRbtWNi6CZEK6UHhmBEZW+IpXRxiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ7SvBNyX9U9saOYcNjEMe2iXtFjsJW3grFJu1MYw/Uesx13ce
	QBNoOnKp/TBiONY4vUBzmWTj1/Ga7YXmc63HMibM5bwujhCdP6479A7Hc7DWOLNP+2A=
X-Gm-Gg: ASbGnctQbrz812gDd4/m7tZvK9MI8UGLwLsuOhwPsgEUoDi0V6fivRW4F5hJXVUC/lB
	D7xCKUe/gT33rWalhyiwxOHCQtYAotEhsC2YyQqxBbCQXW+oFvwsY3foA39UfMhbBXV/eRcR6U6
	usu0KgVx3+HWloEluC5mfr2jDmsReXChVFPH+zWCkxDu45DsLmw5pl03bHodeQGqUOF36Jb4Mbq
	QgSDfUUBjMSj2i0dr5fbOChJEaiBtHaSrFRzupGqo/DmfjHwNlSwZsgY1qZIbCF5tbRn68avSlM
	/QI1O8kAz6UJPsyifebCRCplSMRGKVb5UH+o5wrl1SVKVKOo9fKzRoAy3/XPjb69Wt/gYL1G4E3
	unlqmfILudcfv/oQNC6bAlw6olaPhhdDbAexbuOtRuz3evHvvRQYclHoOdwkohGNELoNJzsH6QE
	0=
X-Google-Smtp-Source: AGHT+IECEClQ4gcDZflNr8OF37/m2/sdokkO3kp5YYljSj0gbjKCJ2YdIo/WjYchNnOtACuNuzQEKA==
X-Received: by 2002:a5d:5888:0:b0:3eb:ad27:9802 with SMTP id ffacd0b85a97d-40e7b9cd8c0mr80388f8f.2.1758726922445;
        Wed, 24 Sep 2025 08:15:22 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a996bf1sm36541855e9.1.2025.09.24.08.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 08:15:21 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 24 Sep 2025 15:14:43 +0000
Subject: [PATCH v4 3/3] arm64: dts: exynos: gs101: add OPPs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-acpm-dvfs-dt-v4-3-3106d49e03f5@linaro.org>
References: <20250924-acpm-dvfs-dt-v4-0-3106d49e03f5@linaro.org>
In-Reply-To: <20250924-acpm-dvfs-dt-v4-0-3106d49e03f5@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758726918; l=8583;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=jAhvrkZLf2CPegU55/45LRXE53AONwSoY/Qaao8O1WI=;
 b=flkdtx3/cXrM2/ZNkt5KRthl5fEZMWNALCXLHO8aK4hPDkQ2+flX6YbpaTloDjdwikO8FMxGD
 7vVqaXwRUPhBMu4sq6t/FdM0q7xG1+C5cfIf12vl+Pl5zBoNJdex6x4
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Add operating performance points (OPPs).

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Tested-by: Peter Griffin <peter.griffin@linaro.org> # on gs101-oriole
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 275 +++++++++++++++++++++++++++
 1 file changed, 275 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index 7326801c9ebf270496997839185594c3c1776577..9d0d943fb08c9ff0fcc3c84459893a3ba92226fd 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -78,6 +78,7 @@ cpu0: cpu@0 {
 			cpu-idle-states = <&ananke_cpu_sleep>;
 			capacity-dmips-mhz = <250>;
 			dynamic-power-coefficient = <70>;
+			operating-points-v2 = <&cpucl0_opp_table>;
 		};
 
 		cpu1: cpu@100 {
@@ -89,6 +90,7 @@ cpu1: cpu@100 {
 			cpu-idle-states = <&ananke_cpu_sleep>;
 			capacity-dmips-mhz = <250>;
 			dynamic-power-coefficient = <70>;
+			operating-points-v2 = <&cpucl0_opp_table>;
 		};
 
 		cpu2: cpu@200 {
@@ -100,6 +102,7 @@ cpu2: cpu@200 {
 			cpu-idle-states = <&ananke_cpu_sleep>;
 			capacity-dmips-mhz = <250>;
 			dynamic-power-coefficient = <70>;
+			operating-points-v2 = <&cpucl0_opp_table>;
 		};
 
 		cpu3: cpu@300 {
@@ -111,6 +114,7 @@ cpu3: cpu@300 {
 			cpu-idle-states = <&ananke_cpu_sleep>;
 			capacity-dmips-mhz = <250>;
 			dynamic-power-coefficient = <70>;
+			operating-points-v2 = <&cpucl0_opp_table>;
 		};
 
 		cpu4: cpu@400 {
@@ -122,6 +126,7 @@ cpu4: cpu@400 {
 			cpu-idle-states = <&enyo_cpu_sleep>;
 			capacity-dmips-mhz = <620>;
 			dynamic-power-coefficient = <284>;
+			operating-points-v2 = <&cpucl1_opp_table>;
 		};
 
 		cpu5: cpu@500 {
@@ -133,6 +138,7 @@ cpu5: cpu@500 {
 			cpu-idle-states = <&enyo_cpu_sleep>;
 			capacity-dmips-mhz = <620>;
 			dynamic-power-coefficient = <284>;
+			operating-points-v2 = <&cpucl1_opp_table>;
 		};
 
 		cpu6: cpu@600 {
@@ -144,6 +150,7 @@ cpu6: cpu@600 {
 			cpu-idle-states = <&hera_cpu_sleep>;
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <650>;
+			operating-points-v2 = <&cpucl2_opp_table>;
 		};
 
 		cpu7: cpu@700 {
@@ -155,6 +162,7 @@ cpu7: cpu@700 {
 			cpu-idle-states = <&hera_cpu_sleep>;
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <650>;
+			operating-points-v2 = <&cpucl2_opp_table>;
 		};
 
 		idle-states {
@@ -192,6 +200,273 @@ hera_cpu_sleep: cpu-hera-sleep {
 		};
 	};
 
+	cpucl0_opp_table: opp-table-0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <537500>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-574000000 {
+			opp-hz = /bits/ 64 <574000000>;
+			opp-microvolt = <600000>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-738000000 {
+			opp-hz = /bits/ 64 <738000000>;
+			opp-microvolt = <618750>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-930000000 {
+			opp-hz = /bits/ 64 <930000000>;
+			opp-microvolt = <668750>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-1098000000 {
+			opp-hz = /bits/ 64 <1098000000>;
+			opp-microvolt = <712500>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-1197000000 {
+			opp-hz = /bits/ 64 <1197000000>;
+			opp-microvolt = <731250>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-1328000000 {
+			opp-hz = /bits/ 64 <1328000000>;
+			opp-microvolt = <762500>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-1401000000 {
+			opp-hz = /bits/ 64 <1401000000>;
+			opp-microvolt = <781250>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-1598000000 {
+			opp-hz = /bits/ 64 <1598000000>;
+			opp-microvolt = <831250>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-1704000000 {
+			opp-hz = /bits/ 64 <1704000000>;
+			opp-microvolt = <862500>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-1803000000 {
+			opp-hz = /bits/ 64 <1803000000>;
+			opp-microvolt = <906250>;
+			clock-latency-ns = <500000>;
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
+			clock-latency-ns = <500000>;
+		};
+
+		opp-553000000 {
+			opp-hz = /bits/ 64 <553000000>;
+			opp-microvolt = <537500>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-696000000 {
+			opp-hz = /bits/ 64 <696000000>;
+			opp-microvolt = <562500>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-799000000 {
+			opp-hz = /bits/ 64 <799000000>;
+			opp-microvolt = <581250>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-910000000 {
+			opp-hz = /bits/ 64 <910000000>;
+			opp-microvolt = <606250>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-1024000000 {
+			opp-hz = /bits/ 64 <1024000000>;
+			opp-microvolt = <625000>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-1197000000 {
+			opp-hz = /bits/ 64 <1197000000>;
+			opp-microvolt = <662500>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-1328000000 {
+			opp-hz = /bits/ 64 <1328000000>;
+			opp-microvolt = <687500>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-1491000000 {
+			opp-hz = /bits/ 64 <1491000000>;
+			opp-microvolt = <731250>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-1663000000 {
+			opp-hz = /bits/ 64 <1663000000>;
+			opp-microvolt = <775000>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-1836000000 {
+			opp-hz = /bits/ 64 <1836000000>;
+			opp-microvolt = <818750>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-1999000000 {
+			opp-hz = /bits/ 64 <1999000000>;
+			opp-microvolt = <868750>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-2130000000 {
+			opp-hz = /bits/ 64 <2130000000>;
+			opp-microvolt = <918750>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-2253000000 {
+			opp-hz = /bits/ 64 <2253000000>;
+			opp-microvolt = <968750>;
+			clock-latency-ns = <500000>;
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
+			clock-latency-ns = <500000>;
+		};
+
+		opp-851000000 {
+			opp-hz = /bits/ 64 <851000000>;
+			opp-microvolt = <556250>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-984000000 {
+			opp-hz = /bits/ 64 <984000000>;
+			opp-microvolt = <575000>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-1106000000 {
+			opp-hz = /bits/ 64 <1106000000>;
+			opp-microvolt = <606250>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-1277000000 {
+			opp-hz = /bits/ 64 <1277000000>;
+			opp-microvolt = <631250>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-1426000000 {
+			opp-hz = /bits/ 64 <1426000000>;
+			opp-microvolt = <662500>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-1582000000 {
+			opp-hz = /bits/ 64 <1582000000>;
+			opp-microvolt = <693750>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-1745000000 {
+			opp-hz = /bits/ 64 <1745000000>;
+			opp-microvolt = <731250>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-1826000000 {
+			opp-hz = /bits/ 64 <1826000000>;
+			opp-microvolt = <750000>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-2048000000 {
+			opp-hz = /bits/ 64 <2048000000>;
+			opp-microvolt = <793750>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-2188000000 {
+			opp-hz = /bits/ 64 <2188000000>;
+			opp-microvolt = <831250>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-2252000000 {
+			opp-hz = /bits/ 64 <2252000000>;
+			opp-microvolt = <850000>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-2401000000 {
+			opp-hz = /bits/ 64 <2401000000>;
+			opp-microvolt = <887500>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-2507000000 {
+			opp-hz = /bits/ 64 <2507000000>;
+			opp-microvolt = <925000>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-2630000000 {
+			opp-hz = /bits/ 64 <2630000000>;
+			opp-microvolt = <968750>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-2704000000 {
+			opp-hz = /bits/ 64 <2704000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <500000>;
+		};
+
+		opp-2802000000 {
+			opp-hz = /bits/ 64 <2802000000>;
+			opp-microvolt = <1056250>;
+			clock-latency-ns = <500000>;
+		};
+	};
+
 	/* ect node is required to be present by bootloader */
 	ect {
 	};

-- 
2.51.0.536.g15c5d4f767-goog


