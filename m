Return-Path: <linux-kernel+bounces-798828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 509D5B42385
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72D797BC3CA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAC63126DE;
	Wed,  3 Sep 2025 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o0ie7+si"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE6430DD04
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756909484; cv=none; b=ZYiEOwxMxxJYXCBZ3L2LYX5UNlxWB2UrcrLVaiWuTbkL5QmYkucf0INgxy3/Wu+wo7tZtvBd84S7GmQX8FJseylpjKTvRCdmWp45yTcJc5Eyl5mht7XAHi7h/W4LLAieWyl92FotjcK4iWDBE4/H/GKujv/kTsx3z888T7TQ3lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756909484; c=relaxed/simple;
	bh=DvCybsMaaovaYrXT+kGukCydj98f0jObaOksmSKLE7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C00x1RxvgNWiR3t4vvKa/yZcuByF6AAAB95cHN2lwAkdb2DAww5Ny7XPRHQe1V693PkPXfdxcNZ5QktbpoTmCTyw0En9GqXjSYqLAiGqnZyVmXDRQU0acFgWGpe1E0KHFdmjM4B71pt4u18vn2xQYiBjwE/zNWV+sygQpe3awNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o0ie7+si; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b89147cfbso32371735e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 07:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756909481; x=1757514281; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xEi2/PQdoB49OMbTqw0F1qOk8kSvaGQNIH9qtvm23Bk=;
        b=o0ie7+siFogBJjNrH4W80fsw2iNjR21hc6Ssw4FoITWrTxF3agQmtM172K8MTvsrg5
         vuxwyIRNWGTrmvs8BJe/ga8MMpPT1wpYZ0WyrxmDBM1lQyNjgl4/RP6xVwEtFFOyCuXa
         CdFfXP7+Ff44Acw/ybPEVbkP3y2IyhFAskYB4fmAPQ0AwkpBgDm9ZPNc+XWFV9iMD8ZZ
         IViaw5g/x1VuQ+jPUkoQ45/Op5KGIHj7jKis6Ba0ffsHCrZR7vcldMmZoDWwe0DfWLDy
         7ZbJJQ6UOZ1oBgXTBB14ZCT0q0CD/k1Zm1RzJdm2b7uKU8RxwALP5AM+cbFashCrEAdX
         pgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756909481; x=1757514281;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEi2/PQdoB49OMbTqw0F1qOk8kSvaGQNIH9qtvm23Bk=;
        b=Bw3GI/xiQ8KqowDrQ5ropugfFoOuwDmnMWmyEoS7EeXgLj33iL2+zclLgl6dhd6HTh
         fcFgr4+MWhRQOaTsLizc4DrYZWj4E/laUHG2Bg8zuEykH3rGI0R3r/Y3A0nnKCXDuP48
         Vnf3QGcpbVaYRpYV+hyNfoaFi5Bi1V+PUuQghnos93cWnOr0FDv08yujJdgXflMIZqMV
         YfNwmgYBBV49GgvZbI0IJ5jV7s74LERdf9rOJhSh61f4CYol5Q0GcQCeDU6JExIohNCX
         dyi/gDhnQ5iz0D16yZldSkh1i9czikfi/ZlQXYgB+C61J2MPLZJTIOQUyaN8RbPhgRrY
         MXFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkWyqbbL2NPlgklTkHozmtfOq06OZeJ4+fI4448GI02ioJN6R8uJbhOGKxSPai5S5clII+zXYAouOMT8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyouRkVHPO3Z4gDUCnlG2PyfCBQde3rVkPsNwmOWCGH+wQWS+FF
	FAU8v3SwbOh3LBtHTP9e1Hvj3DVjIz8WlltiaBZbA0nfzpe3fKzMgbQiWVTWNiV3Xx4=
X-Gm-Gg: ASbGnctpg0jxgn6K/MvcViDfxE/nmcLBt7qizTVbmsjjOE4P0pqgel8aZLz84vTk8U/
	OLYIx1LmO1yOTpi0BIrCTwRqXaLaXIsaF5RtiJMOsD5AKT2ojAOmiRX/GULnSBD731V7+TsC1tW
	aZ5RD3GN2VEXvCgo5+7h3ZzpbfYxO2RfLdt7q3wwsiH50N0OF+qyCDaZbEuCB6w3e7nITlxDsOR
	wGL3CK5o5yLLzRfnjKm99B9uOdYbUG6YT1uFNYtx/fQiGhPmWkHFnBttu2LUnk78aaMsJRQ1E3J
	4gfoCRuAJ1PVE5yQU2claqQ9wKpPzBM5Kqub04/hPAanwT7Ai+lJSsImH3yLr4karMBeBj062+Q
	kWRmZ/btnkqFVvM5uLm61O6NxjDSR4cU8+64Fw7oCokNKsZwRpvGxZSQla402L6Qilkg+z4Y/zt
	M/YnBehX8fbzrU
X-Google-Smtp-Source: AGHT+IGrRziJjTMwT25c2OkVilDIuZjFn9L5MCkwO866+qwMljC5rb2HmLajCHH5hfA9aOIzCWZjeQ==
X-Received: by 2002:a05:600c:3143:b0:456:1c4a:82b2 with SMTP id 5b1f17b1804b1-45b8555d6fbmr141415125e9.10.1756909480609;
        Wed, 03 Sep 2025 07:24:40 -0700 (PDT)
Received: from ta2.c.googlers.com (219.43.233.35.bc.googleusercontent.com. [35.233.43.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3dc1cd4a7d2sm3996035f8f.33.2025.09.03.07.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 07:24:39 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 03 Sep 2025 14:24:36 +0000
Subject: [PATCH v3 2/3] arm64: dts: exynos: gs101: add CPU clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-acpm-dvfs-dt-v3-2-f24059e5cd95@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756909477; l=3055;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=DvCybsMaaovaYrXT+kGukCydj98f0jObaOksmSKLE7g=;
 b=pVxjq+o735XuRTrAp24zmkgSEQyM98WPeI5CRx0F32McSQr5++j2fb9E7h3fx6kzQhtnAPJ9Z
 MQlithbin71DJfR1JpELcCBTH3/EWVBxgk3BV+R9iKiPVX/zygYfDLi
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Add the GS101 CPU clocks exposed through the ACPM protocol.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index f00754692bbac39fd828ebd4ef7c269f746f2522..e355fafe2276fdfbcb573600474cbdd26a654e7c 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -7,6 +7,7 @@
  */
 
 #include <dt-bindings/clock/google,gs101.h>
+#include <dt-bindings/clock/google,gs101-acpm.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/soc/samsung,exynos-usi.h>
@@ -72,6 +73,7 @@ cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0000>;
+			clocks = <&acpm_ipc GS101_CLK_ACPM_DVFS_CPUCL0>;
 			enable-method = "psci";
 			cpu-idle-states = <&ananke_cpu_sleep>;
 			capacity-dmips-mhz = <250>;
@@ -82,6 +84,7 @@ cpu1: cpu@100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0100>;
+			clocks = <&acpm_ipc GS101_CLK_ACPM_DVFS_CPUCL0>;
 			enable-method = "psci";
 			cpu-idle-states = <&ananke_cpu_sleep>;
 			capacity-dmips-mhz = <250>;
@@ -92,6 +95,7 @@ cpu2: cpu@200 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0200>;
+			clocks = <&acpm_ipc GS101_CLK_ACPM_DVFS_CPUCL0>;
 			enable-method = "psci";
 			cpu-idle-states = <&ananke_cpu_sleep>;
 			capacity-dmips-mhz = <250>;
@@ -102,6 +106,7 @@ cpu3: cpu@300 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0300>;
+			clocks = <&acpm_ipc GS101_CLK_ACPM_DVFS_CPUCL0>;
 			enable-method = "psci";
 			cpu-idle-states = <&ananke_cpu_sleep>;
 			capacity-dmips-mhz = <250>;
@@ -112,6 +117,7 @@ cpu4: cpu@400 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a76";
 			reg = <0x0400>;
+			clocks = <&acpm_ipc GS101_CLK_ACPM_DVFS_CPUCL1>;
 			enable-method = "psci";
 			cpu-idle-states = <&enyo_cpu_sleep>;
 			capacity-dmips-mhz = <620>;
@@ -122,6 +128,7 @@ cpu5: cpu@500 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a76";
 			reg = <0x0500>;
+			clocks = <&acpm_ipc GS101_CLK_ACPM_DVFS_CPUCL1>;
 			enable-method = "psci";
 			cpu-idle-states = <&enyo_cpu_sleep>;
 			capacity-dmips-mhz = <620>;
@@ -132,6 +139,7 @@ cpu6: cpu@600 {
 			device_type = "cpu";
 			compatible = "arm,cortex-x1";
 			reg = <0x0600>;
+			clocks = <&acpm_ipc GS101_CLK_ACPM_DVFS_CPUCL2>;
 			enable-method = "psci";
 			cpu-idle-states = <&hera_cpu_sleep>;
 			capacity-dmips-mhz = <1024>;
@@ -142,6 +150,7 @@ cpu7: cpu@700 {
 			device_type = "cpu";
 			compatible = "arm,cortex-x1";
 			reg = <0x0700>;
+			clocks = <&acpm_ipc GS101_CLK_ACPM_DVFS_CPUCL2>;
 			enable-method = "psci";
 			cpu-idle-states = <&hera_cpu_sleep>;
 			capacity-dmips-mhz = <1024>;

-- 
2.51.0.338.gd7d06c2dae-goog


