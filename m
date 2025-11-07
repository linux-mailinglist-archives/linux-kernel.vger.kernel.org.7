Return-Path: <linux-kernel+bounces-890267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AB3C3FA8C
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A73464F11CF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5152F31D75E;
	Fri,  7 Nov 2025 11:09:13 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2111.outbound.protection.partner.outlook.cn [139.219.17.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7898331B81C;
	Fri,  7 Nov 2025 11:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762513751; cv=fail; b=QYrxRFup6wZcmE+vz74EKsk0nGyz/IkKsI/JxdgBauTjRAO283QJu44isneEIvkAST898fCDr8FEqOH64vQroF+2aOedeBW8jj8kGhXjg5ip2lEn0F5u3kAfCiyKbRN9PDahoQMLGzQLd/KvhOgx6Bi1l12IGmcpPDquKHJTMuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762513751; c=relaxed/simple;
	bh=ZqrXIXWIFl3QjiE1o2y500s0CX0D0lLb9NXFXexY75I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pvsh+Bb4M3tqIkmQNHfn6PmA+R5zUTfYEnX4H40KWkAr7SFFkQQj6AXvDeM7lebyk4cJLgXPVgCxbNeKFNR5K7luXlBu+wGp2YLuzPCa7I9E55vMiC/HlwOR7mjnKIcgXrGIEuFIXnkvNIUd7bvTGQfvz72KvtxtvU1iB2DzmUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from ZQ2PR01MB1305.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::14) by ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 10:54:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7z++mRuCYrPOwlJ2dh+6jaLd144Y8a9pP7S6FuR8Sb55fss39ScrMieYZCo//e3cOWl3XClQZP0yitXS7/i+5xxkoyIklpTCRNoKJLtRlO3O3blhKxRMf83pN7xvvjH6xNAdHbGbBt7Q/9sZ3BKJz66MiN/TgpOftz7Jdt03AhOrq40DbSwSyBVFZ3HrxuAUQXvSYuEpj92PB2lBu41VtYcbANuogZ3gZz6nWkH/ZKKrMbyfvA3HAmU6dyCSxgIOgOk+JBmW6B9ijFVmTNQhaLskBT8I11joZg6y/8tujkga5AJCcFKk4fmmQBPBlwJ7WvD0cYA8SfZRuwDqIxi4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqHGOPzizN1ZM8vl7b5SmVvlZOgfrD7BiMDWGn+mZbg=;
 b=G/SiKD+vkzaMMo9r258OZd1cs0ngBHS9b8Pj1V2YpJJbB8qUL1LsPGhyLvu9CaAIZPsC26UD6vZtDFPwEvbQRRvtK7aOTtX3tMeD+C8HKTHeBB28ybE1ASuCwzOWgugST27/5kU+dN6Y37HGkVmpWVdPPJIqRqZDqbCcXDsIUiXG71J/BwhIax7UbXNCxkrcyxIHoTuOWPHBk4Lmd9QK0k7xhFA/OV0i2d1xBeVAUkHMV7CtB4ETYdUHH3dvoAA9O/Z47HpaEvifL9YzIma0dw8nZLN3B+jTDekhJIZjXdx15tbQGPuILnKB4NV1Yt17Mtsw9D9odLobSjggfEsB6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1305.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 09:55:42 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 09:55:42 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] riscv: dts: starfive: Split jh7110-common.dtsi and move opp table to it
Date: Fri,  7 Nov 2025 17:55:26 +0800
Message-ID: <20251107095530.114775-5-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20251107095530.114775-1-hal.feng@starfivetech.com>
References: <20251107095530.114775-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0014.CHNPR01.prod.partner.outlook.cn (10.2.0.83)
 To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn (10.2.1.78)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	ZQ2PR01MB1307:EE_|ZQ2PR01MB1305:EE_|ZQ0PR01MB1302:EE_
X-MS-Office365-Filtering-Correlation-Id: 0edba901-81c7-4c49-9e42-08de1de3d077
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|7416014|52116014|1800799024|41320700013|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
 /aG7xfXc0q1wdie5CvxSO3nC1+fUkXQFk5+71NBoHiFmPhNRbpv6KYsGO220RN5BYsXq5Bp/lRbgi/EceFD0dFSNBqhefp0kkT6ca0yxTfTfjDruJ6Rkz+270JIBWXfLZ8PoWkGoKJpsAznbnpt3rISbNRZH1suYl9/wJoW8yQtyQVCS4bW1ZxJrSaAVplF8zKxDfBk0S7oaB+63wnbxshIVCDxlM3SpaMNIyH3Uz1RIgGqHpde4tJk1HVRf2SlzifVCJoTJmD4RGDhasnSeg4Ye38ffZ5UDRAPdauuLC2ZMK1WHXlTaKbRm8L0zZ3cki6QP0VNfN9JKRh5/bSABa3XqdkpJ+fk73dB2HbBTa8iBTk8BHX/a8U9DliNGHOGfnWeGhhXiA47V0sTgAv34BZKt87q7Xfk0iCryRSksg9kYs4sSTZcQse0kYsuD4oOudjR+uCnuCrwB/3IBZksxNPjHPADlm8SHDNvRYf4L/KT/SLAtPnjxttVnWB5isvATCBGPGuIklj0gbeAiuZv7XOYfi7geHnVcMEaBnfKhxxYST+kwv8vc9xvJVeExuaJyjmBV/X6DlDj3DjJwdUuDyQ6VXkQtWIKwMifQh+ECq60=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(41320700013)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?ApBbncwN+6nIpAZUN1QOloH9e2XJZrQyl6TyqwO1kKvCYWPKrieJAFFrpKy0?=
 =?us-ascii?Q?pbfTzrm/g1vEJbg8T7tHbDIc+xoqDhvjkGQR5rHR2AXWJQCT1VWf0LcgTFXi?=
 =?us-ascii?Q?0xZmiYeaDlbQC11y/1q+Xr7sNnvtVe7er4hJvoqN9zR2CTZl7vcy3IpXeg+Q?=
 =?us-ascii?Q?KSjZOQ8TpewEt5YlGDqx9EFEqscFfDZjOFK5Iaa81nyNPEdrTepbL23r0VsT?=
 =?us-ascii?Q?iBNzJlT3KZQg7T+ZB0yoMlm51U25VVTYaTIKKxBo41aLtxmbELHYLhxc77Y+?=
 =?us-ascii?Q?qs89f4REgkRwUMp7XdS3Ox5rItoEbc3+jchRP0vZlxiSQF8QnrM7KZxVx4Gm?=
 =?us-ascii?Q?UTkwoYoVofelaBqY0YiLhrxlt4e5Zl3kkYsoy0kbM1+lBUUCsrnGGSXsKsFj?=
 =?us-ascii?Q?NvwAjy/WfU9hbsZIDLbfS+EpTm1qsB2Wy0rSiriyMlKl+/DSQw5e4vE0FDrj?=
 =?us-ascii?Q?dK9BZZW0b2fE4aVg96UMCro0FYFstcAPCs4KDc1SKdD2jilhN+FsF2X123yc?=
 =?us-ascii?Q?h1Emw+ag2xb450NU7QdVUPTnjzwmI68YTn593wjyDK+dBg4gC8J80g3+dbli?=
 =?us-ascii?Q?jdAUOwCwLgCiqh17aap4y/czAPwuFfa2PRuD79u6GtlkbGxeDZD1gLlsJ5W/?=
 =?us-ascii?Q?jC3y2Yg+KhQIjHAOfJd7kCH9eMdRfC6XOIcAdyPOBOpT6z8x110I2mCXr/gY?=
 =?us-ascii?Q?F607a7JEtNJDtzTkbSJjCYr20TpmRqi0epasXq0VkJVDH6MzKbJAmPekrICp?=
 =?us-ascii?Q?xa8PT5muPtKGfxdsHJ93qaqwStCJwYy5x8xrOi1cgsfI6m21yT9FqdtdwsWK?=
 =?us-ascii?Q?zfX2FxeQCPgEBNhQM0BFTdRWEVIr8a0G5UvsB5K9dz0MenbsuoSUqJJfHqG0?=
 =?us-ascii?Q?InTZghD+b8VoYV/T/zA27jzUciWj+E6PujmWfmhyuYBSqbLG9Hu1EyXyHiQg?=
 =?us-ascii?Q?usJXzUuQS4IWzg9FuEBTyOJGb7bJjEqFCTj+EVBRk+pmHdKUL9rPqz1vEh2/?=
 =?us-ascii?Q?/PK6kOwIVbY9zGK5v6W9BBf7QjrLqfU34RuVE6bGmeUcF2zkt6yP/kV2f+S2?=
 =?us-ascii?Q?DBtp9ptAvMBqCOeA2FWGER74+/BPShlsR+z8Cib9pjL506gKWF7PV7OpV51G?=
 =?us-ascii?Q?EQej1kmwhPXBAJkmS4ppxe9cXPCqPnaKekV4CjyVQKznGyUEfXJ+kSYKRxLG?=
 =?us-ascii?Q?v1L93hNfj/h31BcwHPkiaaDmG5WLc1KSalxRSdpg9h/MVSnuJvOAK2jPPQdb?=
 =?us-ascii?Q?4tcVT53ZWCe6K2B+X7jtwtzJog9S9mDZ/59SwxKGKu0WnPYLX+Ql/dio/3Vb?=
 =?us-ascii?Q?/dfi7UbMqRB3nAFvaTbkGdXFqIk0J7VX2De2exU1eEdXoFsFjwyZSwmKXjjA?=
 =?us-ascii?Q?nM5CuQ7hebHFywCvDRRhcfuBfkzK6F+QAsniDySbfarNlFOpktDSwV3y5DnS?=
 =?us-ascii?Q?Gc1kQB15eTcZyaivjNd6qFzjROwFmzl4UcjiAeAtn8RNgWr7Nhx14Lm6IYkQ?=
 =?us-ascii?Q?UsE0WR3AoYUCVHKfo9UNnjA//MEv4PwGrIFSsjDLfB1cJFekCg+7gecuN9bZ?=
 =?us-ascii?Q?5FTvYr0wAutPhADUlcohPRW/cilSz2piGQxs/1fz3T+pizKliZUt46g1xsKi?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0edba901-81c7-4c49-9e42-08de1de3d077
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 09:55:42.7640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tRBDTnwr6wPtYk3WRxW7RtTKYo8fp1cghVkpnlBoV3+csAZASCGwNB98Wkf3NyUP13ZVmg/f9Yo5PBao23aC8TQ7Rm5LVXTkpt0F0JGkOl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1305
X-OriginatorOrg: starfivetech.com

Preparing to add JH7110S based board device trees, move the content of
jh7110-common.dtsi to the new file jh711x-common.dtsi and move opp table
to jh7110-common.dtsi.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../boot/dts/starfive/jh7110-common.dtsi      | 665 +-----------------
 .../boot/dts/starfive/jh711x-common.dtsi      | 664 +++++++++++++++++
 arch/riscv/boot/dts/starfive/jh711x.dtsi      |  16 -
 3 files changed, 678 insertions(+), 667 deletions(-)
 create mode 100644 arch/riscv/boot/dts/starfive/jh711x-common.dtsi

diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
index 809274625615..dd5805ef70a1 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
@@ -5,660 +5,23 @@
  */
 
 /dts-v1/;
-#include "jh711x.dtsi"
-#include "jh7110-pinfunc.h"
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/leds/common.h>
-#include <dt-bindings/pinctrl/starfive,jh7110-pinctrl.h>
+#include "jh711x-common.dtsi"
 
-/ {
-	aliases {
-		ethernet0 = &gmac0;
-		i2c0 = &i2c0;
-		i2c2 = &i2c2;
-		i2c5 = &i2c5;
-		i2c6 = &i2c6;
-		mmc0 = &mmc0;
-		mmc1 = &mmc1;
-		serial0 = &uart0;
+&cpu_opp {
+	opp-375000000 {
+		opp-hz = /bits/ 64 <375000000>;
+		opp-microvolt = <800000>;
 	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	memory@40000000 {
-		device_type = "memory";
-		reg = <0x0 0x40000000 0x1 0x0>;
-		bootph-pre-ram;
-	};
-
-	gpio-restart {
-		compatible = "gpio-restart";
-		gpios = <&sysgpio 35 GPIO_ACTIVE_HIGH>;
-		priority = <224>;
-	};
-
-	leds {
-		compatible = "gpio-leds";
-
-		led_status_power: led-0 {
-			gpios = <&aongpio 3 GPIO_ACTIVE_HIGH>;
-		};
-	};
-
-	pwmdac_codec: audio-codec {
-		compatible = "linux,spdif-dit";
-		#sound-dai-cells = <0>;
-	};
-
-	sound {
-		compatible = "simple-audio-card";
-		simple-audio-card,name = "StarFive-PWMDAC-Sound-Card";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		simple-audio-card,dai-link@0 {
-			reg = <0>;
-			format = "left_j";
-			bitclock-master = <&sndcpu0>;
-			frame-master = <&sndcpu0>;
-
-			sndcpu0: cpu {
-				sound-dai = <&pwmdac>;
-			};
-
-			codec {
-				sound-dai = <&pwmdac_codec>;
-			};
-		};
-	};
-};
-
-&cpus {
-	timebase-frequency = <4000000>;
-};
-
-&dvp_clk {
-	clock-frequency = <74250000>;
-};
-
-&gmac0_rgmii_rxin {
-	clock-frequency = <125000000>;
-};
-
-&gmac0_rmii_refin {
-	clock-frequency = <50000000>;
-};
-
-&gmac1_rgmii_rxin {
-	clock-frequency = <125000000>;
-};
-
-&gmac1_rmii_refin {
-	clock-frequency = <50000000>;
-};
-
-&hdmitx0_pixelclk {
-	clock-frequency = <297000000>;
-};
-
-&i2srx_bclk_ext {
-	clock-frequency = <12288000>;
-};
-
-&i2srx_lrck_ext {
-	clock-frequency = <192000>;
-};
-
-&i2stx_bclk_ext {
-	clock-frequency = <12288000>;
-};
-
-&i2stx_lrck_ext {
-	clock-frequency = <192000>;
-};
-
-&mclk_ext {
-	clock-frequency = <12288000>;
-};
-
-&osc {
-	clock-frequency = <24000000>;
-};
-
-&rtc_osc {
-	clock-frequency = <32768>;
-};
-
-&tdm_ext {
-	clock-frequency = <49152000>;
-};
-
-&camss {
-	assigned-clocks = <&ispcrg JH7110_ISPCLK_DOM4_APB_FUNC>,
-			  <&ispcrg JH7110_ISPCLK_MIPI_RX0_PXL>;
-	assigned-clock-rates = <49500000>, <198000000>;
-
-	ports {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		port@0 {
-			reg = <0>;
-		};
-
-		port@1 {
-			reg = <1>;
-
-			camss_from_csi2rx: endpoint {
-				remote-endpoint = <&csi2rx_to_camss>;
-			};
-		};
+	opp-500000000 {
+		opp-hz = /bits/ 64 <500000000>;
+		opp-microvolt = <800000>;
 	};
-};
-
-&csi2rx {
-	assigned-clocks = <&ispcrg JH7110_ISPCLK_VIN_SYS>;
-	assigned-clock-rates = <297000000>;
-
-	ports {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		port@0 {
-			reg = <0>;
-
-			/* remote MIPI sensor endpoint */
-		};
-
-		port@1 {
-			reg = <1>;
-
-			csi2rx_to_camss: endpoint {
-				remote-endpoint = <&camss_from_csi2rx>;
-			};
-		};
+	opp-750000000 {
+		opp-hz = /bits/ 64 <750000000>;
+		opp-microvolt = <800000>;
 	};
-};
-
-&gmac0 {
-	phy-handle = <&phy0>;
-	phy-mode = "rgmii-id";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "snps,dwmac-mdio";
-
-		phy0: ethernet-phy@0 {
-			reg = <0>;
-		};
+	opp-1500000000 {
+		opp-hz = /bits/ 64 <1500000000>;
+		opp-microvolt = <1040000>;
 	};
 };
-
-&i2c0 {
-	clock-frequency = <100000>;
-	i2c-sda-hold-time-ns = <300>;
-	i2c-sda-falling-time-ns = <510>;
-	i2c-scl-falling-time-ns = <510>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
-};
-
-&i2c2 {
-	clock-frequency = <100000>;
-	i2c-sda-hold-time-ns = <300>;
-	i2c-sda-falling-time-ns = <510>;
-	i2c-scl-falling-time-ns = <510>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
-	status = "okay";
-};
-
-&i2c5 {
-	clock-frequency = <100000>;
-	i2c-sda-hold-time-ns = <300>;
-	i2c-sda-falling-time-ns = <510>;
-	i2c-scl-falling-time-ns = <510>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c5_pins>;
-	status = "okay";
-
-	axp15060: pmic@36 {
-		compatible = "x-powers,axp15060";
-		reg = <0x36>;
-		interrupt-controller;
-		#interrupt-cells = <1>;
-
-		regulators {
-			vcc_3v3: dcdc1 {
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-name = "vcc_3v3";
-			};
-
-			vdd_cpu: dcdc2 {
-				regulator-always-on;
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <1540000>;
-				regulator-name = "vdd_cpu";
-			};
-
-			emmc_vdd: aldo4 {
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-name = "emmc_vdd";
-			};
-		};
-	};
-
-	eeprom@50 {
-		compatible = "atmel,24c04";
-		reg = <0x50>;
-		bootph-pre-ram;
-		pagesize = <16>;
-	};
-};
-
-&i2c6 {
-	clock-frequency = <100000>;
-	i2c-sda-hold-time-ns = <300>;
-	i2c-sda-falling-time-ns = <510>;
-	i2c-scl-falling-time-ns = <510>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c6_pins>;
-	status = "okay";
-};
-
-&mmc0 {
-	max-frequency = <100000000>;
-	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
-	assigned-clock-rates = <50000000>;
-	bus-width = <8>;
-	bootph-pre-ram;
-	cap-mmc-highspeed;
-	mmc-ddr-1_8v;
-	mmc-hs200-1_8v;
-	cap-mmc-hw-reset;
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
-	vmmc-supply = <&vcc_3v3>;
-	vqmmc-supply = <&emmc_vdd>;
-	status = "okay";
-};
-
-&mmc1 {
-	max-frequency = <100000000>;
-	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO1_SDCARD>;
-	assigned-clock-rates = <50000000>;
-	bus-width = <4>;
-	bootph-pre-ram;
-	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
-	disable-wp;
-	cap-sd-highspeed;
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins>;
-	status = "okay";
-};
-
-&pcie0 {
-	perst-gpios = <&sysgpio 26 GPIO_ACTIVE_LOW>;
-	phys = <&pciephy0>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pcie0_pins>;
-};
-
-&pcie1 {
-	perst-gpios = <&sysgpio 28 GPIO_ACTIVE_LOW>;
-	phys = <&pciephy1>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pcie1_pins>;
-};
-
-&pwmdac {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pwmdac_pins>;
-};
-
-&qspi {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	status = "okay";
-
-	nor_flash: flash@0 {
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-		bootph-pre-ram;
-		cdns,read-delay = <2>;
-		spi-max-frequency = <100000000>;
-		cdns,tshsl-ns = <1>;
-		cdns,tsd2d-ns = <1>;
-		cdns,tchsh-ns = <1>;
-		cdns,tslch-ns = <1>;
-
-		partitions {
-			compatible = "fixed-partitions";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			spl@0 {
-				reg = <0x0 0xf0000>;
-			};
-			uboot-env@f0000 {
-				reg = <0xf0000 0x10000>;
-			};
-			uboot@100000 {
-				reg = <0x100000 0xf00000>;
-			};
-		};
-	};
-};
-
-&pwm {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pwm_pins>;
-};
-
-&spi0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&spi0_pins>;
-};
-
-&syscrg {
-	assigned-clocks = <&syscrg JH7110_SYSCLK_CPU_ROOT>,
-			  <&syscrg JH7110_SYSCLK_BUS_ROOT>,
-			  <&syscrg JH7110_SYSCLK_PERH_ROOT>,
-			  <&syscrg JH7110_SYSCLK_QSPI_REF>,
-			  <&syscrg JH7110_SYSCLK_CPU_CORE>,
-			  <&pllclk JH7110_PLLCLK_PLL0_OUT>;
-	assigned-clock-parents = <&pllclk JH7110_PLLCLK_PLL0_OUT>,
-				 <&pllclk JH7110_PLLCLK_PLL2_OUT>,
-				 <&pllclk JH7110_PLLCLK_PLL2_OUT>,
-				 <&syscrg JH7110_SYSCLK_QSPI_REF_SRC>;
-	assigned-clock-rates = <0>, <0>, <0>, <0>, <500000000>, <1500000000>;
-};
-
-&sysgpio {
-	i2c0_pins: i2c0-0 {
-		i2c-pins {
-			pinmux = <GPIOMUX(57, GPOUT_LOW,
-					      GPOEN_SYS_I2C0_CLK,
-					      GPI_SYS_I2C0_CLK)>,
-				 <GPIOMUX(58, GPOUT_LOW,
-					      GPOEN_SYS_I2C0_DATA,
-					      GPI_SYS_I2C0_DATA)>;
-			bias-disable; /* external pull-up */
-			input-enable;
-			input-schmitt-enable;
-		};
-	};
-
-	i2c2_pins: i2c2-0 {
-		i2c-pins {
-			pinmux = <GPIOMUX(3, GPOUT_LOW,
-					     GPOEN_SYS_I2C2_CLK,
-					     GPI_SYS_I2C2_CLK)>,
-				 <GPIOMUX(2, GPOUT_LOW,
-					     GPOEN_SYS_I2C2_DATA,
-					     GPI_SYS_I2C2_DATA)>;
-			bias-disable; /* external pull-up */
-			input-enable;
-			input-schmitt-enable;
-		};
-	};
-
-	i2c5_pins: i2c5-0 {
-		bootph-pre-ram;
-
-		i2c-pins {
-			pinmux = <GPIOMUX(19, GPOUT_LOW,
-					      GPOEN_SYS_I2C5_CLK,
-					      GPI_SYS_I2C5_CLK)>,
-				 <GPIOMUX(20, GPOUT_LOW,
-					      GPOEN_SYS_I2C5_DATA,
-					      GPI_SYS_I2C5_DATA)>;
-			bias-disable; /* external pull-up */
-			bootph-pre-ram;
-			input-enable;
-			input-schmitt-enable;
-		};
-	};
-
-	i2c6_pins: i2c6-0 {
-		i2c-pins {
-			pinmux = <GPIOMUX(16, GPOUT_LOW,
-					      GPOEN_SYS_I2C6_CLK,
-					      GPI_SYS_I2C6_CLK)>,
-				 <GPIOMUX(17, GPOUT_LOW,
-					      GPOEN_SYS_I2C6_DATA,
-					      GPI_SYS_I2C6_DATA)>;
-			bias-disable; /* external pull-up */
-			input-enable;
-			input-schmitt-enable;
-		};
-	};
-
-	mmc0_pins: mmc0-0 {
-		mmc-pins {
-			pinmux = <PINMUX(PAD_SD0_CLK, 0)>,
-				 <PINMUX(PAD_SD0_CMD, 0)>,
-				 <PINMUX(PAD_SD0_DATA0, 0)>,
-				 <PINMUX(PAD_SD0_DATA1, 0)>,
-				 <PINMUX(PAD_SD0_DATA2, 0)>,
-				 <PINMUX(PAD_SD0_DATA3, 0)>,
-				 <PINMUX(PAD_SD0_DATA4, 0)>,
-				 <PINMUX(PAD_SD0_DATA5, 0)>,
-				 <PINMUX(PAD_SD0_DATA6, 0)>,
-				 <PINMUX(PAD_SD0_DATA7, 0)>;
-			bias-pull-up;
-			drive-strength = <12>;
-			input-enable;
-		};
-	};
-
-	mmc1_pins: mmc1-0 {
-		clk-pins {
-			pinmux = <GPIOMUX(10, GPOUT_SYS_SDIO1_CLK,
-					      GPOEN_ENABLE,
-					      GPI_NONE)>;
-			bias-pull-up;
-			drive-strength = <12>;
-			input-disable;
-			input-schmitt-disable;
-			slew-rate = <0>;
-		};
-
-		mmc-pins {
-			pinmux = <GPIOMUX(9, GPOUT_SYS_SDIO1_CMD,
-					     GPOEN_SYS_SDIO1_CMD,
-					     GPI_SYS_SDIO1_CMD)>,
-				 <GPIOMUX(11, GPOUT_SYS_SDIO1_DATA0,
-					      GPOEN_SYS_SDIO1_DATA0,
-					      GPI_SYS_SDIO1_DATA0)>,
-				 <GPIOMUX(12, GPOUT_SYS_SDIO1_DATA1,
-					      GPOEN_SYS_SDIO1_DATA1,
-					      GPI_SYS_SDIO1_DATA1)>,
-				 <GPIOMUX(7, GPOUT_SYS_SDIO1_DATA2,
-					     GPOEN_SYS_SDIO1_DATA2,
-					     GPI_SYS_SDIO1_DATA2)>,
-				 <GPIOMUX(8, GPOUT_SYS_SDIO1_DATA3,
-					     GPOEN_SYS_SDIO1_DATA3,
-					     GPI_SYS_SDIO1_DATA3)>;
-			bias-pull-up;
-			drive-strength = <12>;
-			input-enable;
-			input-schmitt-enable;
-			slew-rate = <0>;
-		};
-	};
-
-	pcie0_pins: pcie0-0 {
-		clkreq-pins {
-			pinmux = <GPIOMUX(27, GPOUT_LOW,
-					      GPOEN_DISABLE,
-					      GPI_NONE)>;
-			bias-pull-down;
-			drive-strength = <2>;
-			input-enable;
-			input-schmitt-disable;
-			slew-rate = <0>;
-		};
-
-		wake-pins {
-			pinmux = <GPIOMUX(32, GPOUT_LOW,
-					      GPOEN_DISABLE,
-					      GPI_NONE)>;
-			bias-pull-up;
-			drive-strength = <2>;
-			input-enable;
-			input-schmitt-disable;
-			slew-rate = <0>;
-		};
-	};
-
-	pcie1_pins: pcie1-0 {
-		clkreq-pins {
-			pinmux = <GPIOMUX(29, GPOUT_LOW,
-					      GPOEN_DISABLE,
-					      GPI_NONE)>;
-			bias-pull-down;
-			drive-strength = <2>;
-			input-enable;
-			input-schmitt-disable;
-			slew-rate = <0>;
-		};
-
-		wake-pins {
-			pinmux = <GPIOMUX(21, GPOUT_LOW,
-				      GPOEN_DISABLE,
-					      GPI_NONE)>;
-			bias-pull-up;
-			drive-strength = <2>;
-			input-enable;
-			input-schmitt-disable;
-			slew-rate = <0>;
-		};
-	};
-
-	pwmdac_pins: pwmdac-0 {
-		pwmdac-pins {
-			pinmux = <GPIOMUX(33, GPOUT_SYS_PWMDAC_LEFT,
-					      GPOEN_ENABLE,
-					      GPI_NONE)>,
-				 <GPIOMUX(34, GPOUT_SYS_PWMDAC_RIGHT,
-					      GPOEN_ENABLE,
-					      GPI_NONE)>;
-			bias-disable;
-			drive-strength = <2>;
-			input-disable;
-			input-schmitt-disable;
-			slew-rate = <0>;
-		};
-	};
-
-	pwm_pins: pwm-0 {
-		pwm-pins {
-			pinmux = <GPIOMUX(46, GPOUT_SYS_PWM_CHANNEL0,
-					      GPOEN_SYS_PWM0_CHANNEL0,
-					      GPI_NONE)>,
-				 <GPIOMUX(59, GPOUT_SYS_PWM_CHANNEL1,
-					      GPOEN_SYS_PWM0_CHANNEL1,
-					      GPI_NONE)>;
-			bias-disable;
-			drive-strength = <12>;
-			input-disable;
-			input-schmitt-disable;
-			slew-rate = <0>;
-		};
-	};
-
-	spi0_pins: spi0-0 {
-		mosi-pins {
-			pinmux = <GPIOMUX(52, GPOUT_SYS_SPI0_TXD,
-					      GPOEN_ENABLE,
-					      GPI_NONE)>;
-			bias-disable;
-			input-disable;
-			input-schmitt-disable;
-		};
-
-		miso-pins {
-			pinmux = <GPIOMUX(53, GPOUT_LOW,
-					      GPOEN_DISABLE,
-					      GPI_SYS_SPI0_RXD)>;
-			bias-pull-up;
-			input-enable;
-			input-schmitt-enable;
-		};
-
-		sck-pins {
-			pinmux = <GPIOMUX(48, GPOUT_SYS_SPI0_CLK,
-					      GPOEN_ENABLE,
-					      GPI_SYS_SPI0_CLK)>;
-			bias-disable;
-			input-disable;
-			input-schmitt-disable;
-		};
-
-		ss-pins {
-			pinmux = <GPIOMUX(49, GPOUT_SYS_SPI0_FSS,
-					      GPOEN_ENABLE,
-					      GPI_SYS_SPI0_FSS)>;
-			bias-disable;
-			input-disable;
-			input-schmitt-disable;
-		};
-	};
-
-	uart0_pins: uart0-0 {
-		tx-pins {
-			pinmux = <GPIOMUX(5, GPOUT_SYS_UART0_TX,
-					     GPOEN_ENABLE,
-					     GPI_NONE)>;
-			bias-disable;
-			drive-strength = <12>;
-			input-disable;
-			input-schmitt-disable;
-			slew-rate = <0>;
-		};
-
-		rx-pins {
-			pinmux = <GPIOMUX(6, GPOUT_LOW,
-					     GPOEN_DISABLE,
-					     GPI_SYS_UART0_RX)>;
-			bias-disable; /* external pull-up */
-			drive-strength = <2>;
-			input-enable;
-			input-schmitt-enable;
-			slew-rate = <0>;
-		};
-	};
-};
-
-&uart0 {
-	bootph-pre-ram;
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins>;
-	status = "okay";
-};
-
-&U74_1 {
-	cpu-supply = <&vdd_cpu>;
-};
-
-&U74_2 {
-	cpu-supply = <&vdd_cpu>;
-};
-
-&U74_3 {
-	cpu-supply = <&vdd_cpu>;
-};
-
-&U74_4 {
-	cpu-supply = <&vdd_cpu>;
-};
diff --git a/arch/riscv/boot/dts/starfive/jh711x-common.dtsi b/arch/riscv/boot/dts/starfive/jh711x-common.dtsi
new file mode 100644
index 000000000000..809274625615
--- /dev/null
+++ b/arch/riscv/boot/dts/starfive/jh711x-common.dtsi
@@ -0,0 +1,664 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2022 StarFive Technology Co., Ltd.
+ * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
+ */
+
+/dts-v1/;
+#include "jh711x.dtsi"
+#include "jh7110-pinfunc.h"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/starfive,jh7110-pinctrl.h>
+
+/ {
+	aliases {
+		ethernet0 = &gmac0;
+		i2c0 = &i2c0;
+		i2c2 = &i2c2;
+		i2c5 = &i2c5;
+		i2c6 = &i2c6;
+		mmc0 = &mmc0;
+		mmc1 = &mmc1;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x0 0x40000000 0x1 0x0>;
+		bootph-pre-ram;
+	};
+
+	gpio-restart {
+		compatible = "gpio-restart";
+		gpios = <&sysgpio 35 GPIO_ACTIVE_HIGH>;
+		priority = <224>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led_status_power: led-0 {
+			gpios = <&aongpio 3 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	pwmdac_codec: audio-codec {
+		compatible = "linux,spdif-dit";
+		#sound-dai-cells = <0>;
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "StarFive-PWMDAC-Sound-Card";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		simple-audio-card,dai-link@0 {
+			reg = <0>;
+			format = "left_j";
+			bitclock-master = <&sndcpu0>;
+			frame-master = <&sndcpu0>;
+
+			sndcpu0: cpu {
+				sound-dai = <&pwmdac>;
+			};
+
+			codec {
+				sound-dai = <&pwmdac_codec>;
+			};
+		};
+	};
+};
+
+&cpus {
+	timebase-frequency = <4000000>;
+};
+
+&dvp_clk {
+	clock-frequency = <74250000>;
+};
+
+&gmac0_rgmii_rxin {
+	clock-frequency = <125000000>;
+};
+
+&gmac0_rmii_refin {
+	clock-frequency = <50000000>;
+};
+
+&gmac1_rgmii_rxin {
+	clock-frequency = <125000000>;
+};
+
+&gmac1_rmii_refin {
+	clock-frequency = <50000000>;
+};
+
+&hdmitx0_pixelclk {
+	clock-frequency = <297000000>;
+};
+
+&i2srx_bclk_ext {
+	clock-frequency = <12288000>;
+};
+
+&i2srx_lrck_ext {
+	clock-frequency = <192000>;
+};
+
+&i2stx_bclk_ext {
+	clock-frequency = <12288000>;
+};
+
+&i2stx_lrck_ext {
+	clock-frequency = <192000>;
+};
+
+&mclk_ext {
+	clock-frequency = <12288000>;
+};
+
+&osc {
+	clock-frequency = <24000000>;
+};
+
+&rtc_osc {
+	clock-frequency = <32768>;
+};
+
+&tdm_ext {
+	clock-frequency = <49152000>;
+};
+
+&camss {
+	assigned-clocks = <&ispcrg JH7110_ISPCLK_DOM4_APB_FUNC>,
+			  <&ispcrg JH7110_ISPCLK_MIPI_RX0_PXL>;
+	assigned-clock-rates = <49500000>, <198000000>;
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+		};
+
+		port@1 {
+			reg = <1>;
+
+			camss_from_csi2rx: endpoint {
+				remote-endpoint = <&csi2rx_to_camss>;
+			};
+		};
+	};
+};
+
+&csi2rx {
+	assigned-clocks = <&ispcrg JH7110_ISPCLK_VIN_SYS>;
+	assigned-clock-rates = <297000000>;
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+
+			/* remote MIPI sensor endpoint */
+		};
+
+		port@1 {
+			reg = <1>;
+
+			csi2rx_to_camss: endpoint {
+				remote-endpoint = <&camss_from_csi2rx>;
+			};
+		};
+	};
+};
+
+&gmac0 {
+	phy-handle = <&phy0>;
+	phy-mode = "rgmii-id";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+
+		phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
+
+&i2c0 {
+	clock-frequency = <100000>;
+	i2c-sda-hold-time-ns = <300>;
+	i2c-sda-falling-time-ns = <510>;
+	i2c-scl-falling-time-ns = <510>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+};
+
+&i2c2 {
+	clock-frequency = <100000>;
+	i2c-sda-hold-time-ns = <300>;
+	i2c-sda-falling-time-ns = <510>;
+	i2c-scl-falling-time-ns = <510>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
+	status = "okay";
+};
+
+&i2c5 {
+	clock-frequency = <100000>;
+	i2c-sda-hold-time-ns = <300>;
+	i2c-sda-falling-time-ns = <510>;
+	i2c-scl-falling-time-ns = <510>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c5_pins>;
+	status = "okay";
+
+	axp15060: pmic@36 {
+		compatible = "x-powers,axp15060";
+		reg = <0x36>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		regulators {
+			vcc_3v3: dcdc1 {
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc_3v3";
+			};
+
+			vdd_cpu: dcdc2 {
+				regulator-always-on;
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1540000>;
+				regulator-name = "vdd_cpu";
+			};
+
+			emmc_vdd: aldo4 {
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "emmc_vdd";
+			};
+		};
+	};
+
+	eeprom@50 {
+		compatible = "atmel,24c04";
+		reg = <0x50>;
+		bootph-pre-ram;
+		pagesize = <16>;
+	};
+};
+
+&i2c6 {
+	clock-frequency = <100000>;
+	i2c-sda-hold-time-ns = <300>;
+	i2c-sda-falling-time-ns = <510>;
+	i2c-scl-falling-time-ns = <510>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c6_pins>;
+	status = "okay";
+};
+
+&mmc0 {
+	max-frequency = <100000000>;
+	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
+	assigned-clock-rates = <50000000>;
+	bus-width = <8>;
+	bootph-pre-ram;
+	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	cap-mmc-hw-reset;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins>;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&emmc_vdd>;
+	status = "okay";
+};
+
+&mmc1 {
+	max-frequency = <100000000>;
+	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO1_SDCARD>;
+	assigned-clock-rates = <50000000>;
+	bus-width = <4>;
+	bootph-pre-ram;
+	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	cap-sd-highspeed;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+	status = "okay";
+};
+
+&pcie0 {
+	perst-gpios = <&sysgpio 26 GPIO_ACTIVE_LOW>;
+	phys = <&pciephy0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_pins>;
+};
+
+&pcie1 {
+	perst-gpios = <&sysgpio 28 GPIO_ACTIVE_LOW>;
+	phys = <&pciephy1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie1_pins>;
+};
+
+&pwmdac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwmdac_pins>;
+};
+
+&qspi {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	nor_flash: flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		bootph-pre-ram;
+		cdns,read-delay = <2>;
+		spi-max-frequency = <100000000>;
+		cdns,tshsl-ns = <1>;
+		cdns,tsd2d-ns = <1>;
+		cdns,tchsh-ns = <1>;
+		cdns,tslch-ns = <1>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			spl@0 {
+				reg = <0x0 0xf0000>;
+			};
+			uboot-env@f0000 {
+				reg = <0xf0000 0x10000>;
+			};
+			uboot@100000 {
+				reg = <0x100000 0xf00000>;
+			};
+		};
+	};
+};
+
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm_pins>;
+};
+
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins>;
+};
+
+&syscrg {
+	assigned-clocks = <&syscrg JH7110_SYSCLK_CPU_ROOT>,
+			  <&syscrg JH7110_SYSCLK_BUS_ROOT>,
+			  <&syscrg JH7110_SYSCLK_PERH_ROOT>,
+			  <&syscrg JH7110_SYSCLK_QSPI_REF>,
+			  <&syscrg JH7110_SYSCLK_CPU_CORE>,
+			  <&pllclk JH7110_PLLCLK_PLL0_OUT>;
+	assigned-clock-parents = <&pllclk JH7110_PLLCLK_PLL0_OUT>,
+				 <&pllclk JH7110_PLLCLK_PLL2_OUT>,
+				 <&pllclk JH7110_PLLCLK_PLL2_OUT>,
+				 <&syscrg JH7110_SYSCLK_QSPI_REF_SRC>;
+	assigned-clock-rates = <0>, <0>, <0>, <0>, <500000000>, <1500000000>;
+};
+
+&sysgpio {
+	i2c0_pins: i2c0-0 {
+		i2c-pins {
+			pinmux = <GPIOMUX(57, GPOUT_LOW,
+					      GPOEN_SYS_I2C0_CLK,
+					      GPI_SYS_I2C0_CLK)>,
+				 <GPIOMUX(58, GPOUT_LOW,
+					      GPOEN_SYS_I2C0_DATA,
+					      GPI_SYS_I2C0_DATA)>;
+			bias-disable; /* external pull-up */
+			input-enable;
+			input-schmitt-enable;
+		};
+	};
+
+	i2c2_pins: i2c2-0 {
+		i2c-pins {
+			pinmux = <GPIOMUX(3, GPOUT_LOW,
+					     GPOEN_SYS_I2C2_CLK,
+					     GPI_SYS_I2C2_CLK)>,
+				 <GPIOMUX(2, GPOUT_LOW,
+					     GPOEN_SYS_I2C2_DATA,
+					     GPI_SYS_I2C2_DATA)>;
+			bias-disable; /* external pull-up */
+			input-enable;
+			input-schmitt-enable;
+		};
+	};
+
+	i2c5_pins: i2c5-0 {
+		bootph-pre-ram;
+
+		i2c-pins {
+			pinmux = <GPIOMUX(19, GPOUT_LOW,
+					      GPOEN_SYS_I2C5_CLK,
+					      GPI_SYS_I2C5_CLK)>,
+				 <GPIOMUX(20, GPOUT_LOW,
+					      GPOEN_SYS_I2C5_DATA,
+					      GPI_SYS_I2C5_DATA)>;
+			bias-disable; /* external pull-up */
+			bootph-pre-ram;
+			input-enable;
+			input-schmitt-enable;
+		};
+	};
+
+	i2c6_pins: i2c6-0 {
+		i2c-pins {
+			pinmux = <GPIOMUX(16, GPOUT_LOW,
+					      GPOEN_SYS_I2C6_CLK,
+					      GPI_SYS_I2C6_CLK)>,
+				 <GPIOMUX(17, GPOUT_LOW,
+					      GPOEN_SYS_I2C6_DATA,
+					      GPI_SYS_I2C6_DATA)>;
+			bias-disable; /* external pull-up */
+			input-enable;
+			input-schmitt-enable;
+		};
+	};
+
+	mmc0_pins: mmc0-0 {
+		mmc-pins {
+			pinmux = <PINMUX(PAD_SD0_CLK, 0)>,
+				 <PINMUX(PAD_SD0_CMD, 0)>,
+				 <PINMUX(PAD_SD0_DATA0, 0)>,
+				 <PINMUX(PAD_SD0_DATA1, 0)>,
+				 <PINMUX(PAD_SD0_DATA2, 0)>,
+				 <PINMUX(PAD_SD0_DATA3, 0)>,
+				 <PINMUX(PAD_SD0_DATA4, 0)>,
+				 <PINMUX(PAD_SD0_DATA5, 0)>,
+				 <PINMUX(PAD_SD0_DATA6, 0)>,
+				 <PINMUX(PAD_SD0_DATA7, 0)>;
+			bias-pull-up;
+			drive-strength = <12>;
+			input-enable;
+		};
+	};
+
+	mmc1_pins: mmc1-0 {
+		clk-pins {
+			pinmux = <GPIOMUX(10, GPOUT_SYS_SDIO1_CLK,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			bias-pull-up;
+			drive-strength = <12>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+
+		mmc-pins {
+			pinmux = <GPIOMUX(9, GPOUT_SYS_SDIO1_CMD,
+					     GPOEN_SYS_SDIO1_CMD,
+					     GPI_SYS_SDIO1_CMD)>,
+				 <GPIOMUX(11, GPOUT_SYS_SDIO1_DATA0,
+					      GPOEN_SYS_SDIO1_DATA0,
+					      GPI_SYS_SDIO1_DATA0)>,
+				 <GPIOMUX(12, GPOUT_SYS_SDIO1_DATA1,
+					      GPOEN_SYS_SDIO1_DATA1,
+					      GPI_SYS_SDIO1_DATA1)>,
+				 <GPIOMUX(7, GPOUT_SYS_SDIO1_DATA2,
+					     GPOEN_SYS_SDIO1_DATA2,
+					     GPI_SYS_SDIO1_DATA2)>,
+				 <GPIOMUX(8, GPOUT_SYS_SDIO1_DATA3,
+					     GPOEN_SYS_SDIO1_DATA3,
+					     GPI_SYS_SDIO1_DATA3)>;
+			bias-pull-up;
+			drive-strength = <12>;
+			input-enable;
+			input-schmitt-enable;
+			slew-rate = <0>;
+		};
+	};
+
+	pcie0_pins: pcie0-0 {
+		clkreq-pins {
+			pinmux = <GPIOMUX(27, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_NONE)>;
+			bias-pull-down;
+			drive-strength = <2>;
+			input-enable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+
+		wake-pins {
+			pinmux = <GPIOMUX(32, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_NONE)>;
+			bias-pull-up;
+			drive-strength = <2>;
+			input-enable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+
+	pcie1_pins: pcie1-0 {
+		clkreq-pins {
+			pinmux = <GPIOMUX(29, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_NONE)>;
+			bias-pull-down;
+			drive-strength = <2>;
+			input-enable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+
+		wake-pins {
+			pinmux = <GPIOMUX(21, GPOUT_LOW,
+				      GPOEN_DISABLE,
+					      GPI_NONE)>;
+			bias-pull-up;
+			drive-strength = <2>;
+			input-enable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+
+	pwmdac_pins: pwmdac-0 {
+		pwmdac-pins {
+			pinmux = <GPIOMUX(33, GPOUT_SYS_PWMDAC_LEFT,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>,
+				 <GPIOMUX(34, GPOUT_SYS_PWMDAC_RIGHT,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			bias-disable;
+			drive-strength = <2>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+
+	pwm_pins: pwm-0 {
+		pwm-pins {
+			pinmux = <GPIOMUX(46, GPOUT_SYS_PWM_CHANNEL0,
+					      GPOEN_SYS_PWM0_CHANNEL0,
+					      GPI_NONE)>,
+				 <GPIOMUX(59, GPOUT_SYS_PWM_CHANNEL1,
+					      GPOEN_SYS_PWM0_CHANNEL1,
+					      GPI_NONE)>;
+			bias-disable;
+			drive-strength = <12>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+
+	spi0_pins: spi0-0 {
+		mosi-pins {
+			pinmux = <GPIOMUX(52, GPOUT_SYS_SPI0_TXD,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			bias-disable;
+			input-disable;
+			input-schmitt-disable;
+		};
+
+		miso-pins {
+			pinmux = <GPIOMUX(53, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_SYS_SPI0_RXD)>;
+			bias-pull-up;
+			input-enable;
+			input-schmitt-enable;
+		};
+
+		sck-pins {
+			pinmux = <GPIOMUX(48, GPOUT_SYS_SPI0_CLK,
+					      GPOEN_ENABLE,
+					      GPI_SYS_SPI0_CLK)>;
+			bias-disable;
+			input-disable;
+			input-schmitt-disable;
+		};
+
+		ss-pins {
+			pinmux = <GPIOMUX(49, GPOUT_SYS_SPI0_FSS,
+					      GPOEN_ENABLE,
+					      GPI_SYS_SPI0_FSS)>;
+			bias-disable;
+			input-disable;
+			input-schmitt-disable;
+		};
+	};
+
+	uart0_pins: uart0-0 {
+		tx-pins {
+			pinmux = <GPIOMUX(5, GPOUT_SYS_UART0_TX,
+					     GPOEN_ENABLE,
+					     GPI_NONE)>;
+			bias-disable;
+			drive-strength = <12>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+
+		rx-pins {
+			pinmux = <GPIOMUX(6, GPOUT_LOW,
+					     GPOEN_DISABLE,
+					     GPI_SYS_UART0_RX)>;
+			bias-disable; /* external pull-up */
+			drive-strength = <2>;
+			input-enable;
+			input-schmitt-enable;
+			slew-rate = <0>;
+		};
+	};
+};
+
+&uart0 {
+	bootph-pre-ram;
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins>;
+	status = "okay";
+};
+
+&U74_1 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&U74_2 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&U74_3 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&U74_4 {
+	cpu-supply = <&vdd_cpu>;
+};
diff --git a/arch/riscv/boot/dts/starfive/jh711x.dtsi b/arch/riscv/boot/dts/starfive/jh711x.dtsi
index 6e56e9d20bb0..a380d3dabedd 100644
--- a/arch/riscv/boot/dts/starfive/jh711x.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh711x.dtsi
@@ -205,22 +205,6 @@ core4 {
 	cpu_opp: opp-table-0 {
 			compatible = "operating-points-v2";
 			opp-shared;
-			opp-375000000 {
-					opp-hz = /bits/ 64 <375000000>;
-					opp-microvolt = <800000>;
-			};
-			opp-500000000 {
-					opp-hz = /bits/ 64 <500000000>;
-					opp-microvolt = <800000>;
-			};
-			opp-750000000 {
-					opp-hz = /bits/ 64 <750000000>;
-					opp-microvolt = <800000>;
-			};
-			opp-1500000000 {
-					opp-hz = /bits/ 64 <1500000000>;
-					opp-microvolt = <1040000>;
-			};
 	};
 
 	thermal-zones {
-- 
2.43.2


