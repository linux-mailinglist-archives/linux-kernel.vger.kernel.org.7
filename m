Return-Path: <linux-kernel+bounces-606090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E44A8AA86
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 23:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D927A3B6501
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 21:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD5C26E15F;
	Tue, 15 Apr 2025 21:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrWxDEgR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C5F257458;
	Tue, 15 Apr 2025 21:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753964; cv=none; b=X+JYtbjkNdpWb2TvOwuimQQZprW/lklNK/M7qOYGBnSSnSx3G0SwN4c+Tc+WYdwHG4UWO+lD359OSOsCO8PIwg/xKtFP951A2X7ZKvMSzb/rTzfuiIburNL3AZk2ZAQ4+6dzwsxHEdFTwXnIKV05+vEMNqsJJeG4n9DZF/gHoBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753964; c=relaxed/simple;
	bh=PVTDyzSaiIpFn2vPpTAguPeJMOjp9i2ibxMxEsqpwtU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=luJEO/2QQjhh1NwTjgYdV0Dqq+S7/x0gAZNpeUQdKXUN4Q2Oz7Iqnw91IB86SMQ4Aiwp86cuxfJGMyxv5qwjk8KHk9nXTU6jIS9/RAGgoBnpDrNjp7BYflfWju+tOODSykVfmqbnLZ4iX3hCb6nlGtB5R4O4FFLVp0IdUmcRPa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrWxDEgR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98794C4CEEF;
	Tue, 15 Apr 2025 21:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744753963;
	bh=PVTDyzSaiIpFn2vPpTAguPeJMOjp9i2ibxMxEsqpwtU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RrWxDEgRTK0ZhOd9MR4BMDNEXRcE5G/gjnmwtUjBP9KmWSqgL4BULz+k/afSa4MgT
	 CQqsW41hnNrFQABLehM4kxETZUhayV8MlQ6RSgW/Mg3+/aWxU5hMTQjtyc64Xld+l6
	 kb4H/HwTxNm/L9CSewRwAKPy1V6Z3+mL52EXY7YtEybROQ6Qg5tyQ+BSyasOSvoWwt
	 VfumhB34E+4s0eKC3u92eiCN/1t7X8HXICLEGRWBAoULY459dCRUnJ5gMsWNolMD2u
	 QUXoXytECeWN4WphHAL3M+2HS1N2dJj9cztv4ZQRRda+HKBIZwcZBJCcLrejWlZRdc
	 /ltw25iRNkQPg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA72C369C2;
	Tue, 15 Apr 2025 21:52:43 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Date: Tue, 15 Apr 2025 23:52:36 +0200
Subject: [PATCH 3/3] arm64: dts: apple: Add PMU NVMEM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-spmi-nvmem-v1-3-22067be253cf@gmail.com>
References: <20250415-spmi-nvmem-v1-0-22067be253cf@gmail.com>
In-Reply-To: <20250415-spmi-nvmem-v1-0-22067be253cf@gmail.com>
To: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744753962; l=6050;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=FkRZ7GthVmmbSujIkVNnHCgsxe2R4byiyM8zrad9aQk=;
 b=S9noVN4xTQB1SJbqDHNgWXzSMmzjFVX+fRWTLRXOciHR2Sy3C/qKKNwyTbNWTmspqZJpPnVtO
 EDTq4fBajrJBOSTVksgxKk7sENUihDeYFmybk/ZaZCE2iWK8OQET+zR
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20241124 with
 auth_id=283
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: fnkl.kernel@gmail.com

From: Hector Martin <marcan@marcan.st>

Add device tree entries for NVMEM cells present on the PMU

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
 arch/arm64/boot/dts/apple/t6001.dtsi      |  1 +
 arch/arm64/boot/dts/apple/t6002.dtsi      |  1 +
 arch/arm64/boot/dts/apple/t600x-die0.dtsi | 50 +++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8103.dtsi      | 50 +++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8112.dtsi      | 50 +++++++++++++++++++++++++++++++
 5 files changed, 152 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t6001.dtsi b/arch/arm64/boot/dts/apple/t6001.dtsi
index 620b17e4031f069874aaabadbf06b7b29ec4031e..d2cf81926f284ccf7627701cc82edff31d4d72d6 100644
--- a/arch/arm64/boot/dts/apple/t6001.dtsi
+++ b/arch/arm64/boot/dts/apple/t6001.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/interrupt-controller/apple-aic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/apple.h>
+#include <dt-bindings/spmi/spmi.h>
 
 #include "multi-die-cpp.h"
 
diff --git a/arch/arm64/boot/dts/apple/t6002.dtsi b/arch/arm64/boot/dts/apple/t6002.dtsi
index a963a5011799a0480f88688fb4372a31f0bbf806..e36f422d257d8fe3a62bfa6e0f0e0dc6c34608a4 100644
--- a/arch/arm64/boot/dts/apple/t6002.dtsi
+++ b/arch/arm64/boot/dts/apple/t6002.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/interrupt-controller/apple-aic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/apple.h>
+#include <dt-bindings/spmi/spmi.h>
 
 #include "multi-die-cpp.h"
 
diff --git a/arch/arm64/boot/dts/apple/t600x-die0.dtsi b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
index 4c224e686ffe5602329f7f394d3354559c4130ab..9e4402b0bdc085a32d26048ccf1ac4ea20c1e0c2 100644
--- a/arch/arm64/boot/dts/apple/t600x-die0.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
@@ -50,6 +50,56 @@ nub_spmi0: spmi@2920a1300 {
 		reg = <0x2 0x920a1300 0x0 0x100>;
 		#address-cells = <2>;
 		#size-cells = <0>;
+
+		pmu1: pmu@f {
+			compatible = "apple,maverick-pmu", "spmi-nvmem";
+			reg = <0xf SPMI_USID>;
+
+			nvmem-layout {
+				compatible = "fixed-layout";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				pm_setting: pm-setting@1405 {
+					reg = <0x1405 0x1>;
+				};
+
+				rtc_offset: rtc-offset@1411 {
+					reg = <0x1411 0x6>;
+				};
+
+				boot_stage: boot-stage@6001 {
+					reg = <0x6001 0x1>;
+				};
+
+				boot_error_count: boot-error-count@6002 {
+					reg = <0x6002 0x1>;
+					bits = <0 4>;
+				};
+
+				panic_count: panic-count@6002 {
+					reg = <0x6002 0x1>;
+					bits = <4 4>;
+				};
+
+				boot_error_stage: boot-error-stage@6003 {
+					reg = <0x6003 0x1>;
+				};
+
+				shutdown_flag: shutdown-flag@600f {
+					reg = <0x600f 0x1>;
+					bits = <3 1>;
+				};
+
+				fault_shadow: fault-shadow@867b {
+					reg = <0x867b 0x10>;
+				};
+
+				socd: socd@8b00 {
+					reg = <0x8b00 0x400>;
+				};
+			};
+		};
 	};
 
 	wdt: watchdog@2922b0000 {
diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index bdb1cb9e406a441e458b1c735359b0148146e91b..03bfe1cb173de009b4cd46508e24358008cf42f5 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -747,6 +747,56 @@ nub_spmi: spmi@23d0d9300 {
 			reg = <0x2 0x3d0d9300 0x0 0x100>;
 			#address-cells = <2>;
 			#size-cells = <0>;
+
+			pmu1: pmu@f {
+				compatible = "apple,sera-pmu", "spmi-nvmem";
+				reg = <0xf SPMI_USID>;
+
+				nvmem-layout {
+					compatible = "fixed-layout";
+					#address-cells = <1>;
+					#size-cells = <1>;
+
+					pm_setting: pm-setting@d001 {
+						reg = <0xd001 0x1>;
+					};
+
+					rtc_offset: rtc-offset@d100 {
+						reg = <0xd100 0x6>;
+					};
+
+					boot_stage: boot-stage@9f01 {
+						reg = <0x9f01 0x1>;
+					};
+
+					boot_error_count: boot-error-count@9f02 {
+						reg = <0x9f02 0x1>;
+						bits = <0 4>;
+					};
+
+					panic_count: panic-count@9f02 {
+						reg = <0x9f02 0x1>;
+						bits = <4 4>;
+					};
+
+					boot_error_stage: boot-error-stage@9f03 {
+						reg = <0x9f03 0x1>;
+					};
+
+					shutdown_flag: shutdown-flag@9f0f {
+						reg = <0x9f0f 0x1>;
+						bits = <3 1>;
+					};
+
+					fault_shadow: fault-shadow@a67b {
+						reg = <0xa67b 0x10>;
+					};
+
+					socd: socd@ab00 {
+						reg = <0xab00 0x400>;
+					};
+				};
+			};
 		};
 
 		pinctrl_nub: pinctrl@23d1f0000 {
diff --git a/arch/arm64/boot/dts/apple/t8112.dtsi b/arch/arm64/boot/dts/apple/t8112.dtsi
index 950d1f906ba3023c1d118179207a2099345aae94..55ab72cf627efe2e3295409b9af1b2128b829801 100644
--- a/arch/arm64/boot/dts/apple/t8112.dtsi
+++ b/arch/arm64/boot/dts/apple/t8112.dtsi
@@ -787,6 +787,56 @@ nub_spmi: spmi@23d714000 {
 			reg = <0x2 0x3d714000 0x0 0x100>;
 			#address-cells = <2>;
 			#size-cells = <0>;
+
+			pmu1: pmu@e {
+				compatible = "apple,stowe-pmu", "spmi-nvmem";
+				reg = <0xe SPMI_USID>;
+
+				nvmem-layout {
+					compatible = "fixed-layout";
+					#address-cells = <1>;
+					#size-cells = <1>;
+
+					pm_setting: pm-setting@f801 {
+						reg = <0xf801 0x1>;
+					};
+
+					rtc_offset: rtc-offset@f900 {
+						reg = <0xf900 0x6>;
+					};
+
+					boot_stage: boot-stage@f701 {
+						reg = <0xf701 0x1>;
+					};
+
+					boot_error_count: boot-error-count@f702 {
+						reg = <0xf702 0x1>;
+						bits = <0 4>;
+					};
+
+					panic_count: panic-count@f702 {
+						reg = <0xf702 0x1>;
+						bits = <4 4>;
+					};
+
+					boot_error_stage: boot-error-stage@f703 {
+						reg = <0xf703 0x1>;
+					};
+
+					shutdown_flag: shutdown-flag@f70f {
+						reg = <0xf70f 0x1>;
+						bits = <3 1>;
+					};
+
+					fault_shadow: fault-shadow@867b {
+						reg = <0x867b 0x10>;
+					};
+
+					socd: socd@8b00 {
+						reg = <0x8b00 0x400>;
+					};
+				};
+			};
 		};
 
 		pinctrl_smc: pinctrl@23e820000 {

-- 
2.49.0



