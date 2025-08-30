Return-Path: <linux-kernel+bounces-792935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F30EFB3CAA6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 13:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9231BA2796
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 11:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E7E277804;
	Sat, 30 Aug 2025 11:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNf2Uh1C"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB14246BD7;
	Sat, 30 Aug 2025 11:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756554702; cv=none; b=YkXe0GSz1L1D8a681HWoipdEYubiTR1SO2WlydoD2p2B06IZ4JjKIqF1g9DRFCeTvk0cGQHihNpaYCIPLz3AVaMDhyg/7a5gkIF+882mJ45esYmuL79c4QUqE+BWpduBNQPrZDtnZ/IUTBrdiaAkGxJhagQnS8DvBghU2ehkMk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756554702; c=relaxed/simple;
	bh=mSi9aPJGkTKO7jwbg8t3WzZNF7twXZW2oTObg0ef+8k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CgipS93eWQZlEdMLzZTQ19XfNIZl5bnl9D9tBdTYnzpGybMOMfYEmHirX0G+uDH1pLypzEPkZOcEhfm8xEltdz1pKgwptKbCEcvSBuNRyvfZW24Nby0HrixCT2xfkKmVCDBqcw3oxh426dVFiybNJOl6iF9mnMn8+lKJN92FqL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNf2Uh1C; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3c46686d1e6so1781538f8f.3;
        Sat, 30 Aug 2025 04:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756554699; x=1757159499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GokYqYG+lmT2oxJ+O2O4SIepQEUsvS6Oqvc1Ps5nstE=;
        b=iNf2Uh1CuCyoM5Sve84RflR3c8mQpsX1e8UH/Fl3Z90WBuX0fXqP6Vhb0smN9vwWQ8
         WEbsMZzgdq85JM5iBdxd4dux0LCpRbjTduRB+IBOKVKak4Pw5Sb0sLJfihLDcX8PjFNZ
         J3ptriFap2KaMIvQBmk6OYlybBpM0HKApIEjq44zHsagIh1JeCJcnlMnEsetjYURRXeH
         WlvW1sZPkBiqrhk+wMzQBjEQWexE7lxKnKwcXOsY3wNk9qvNCwtPoWPXB8vSddwdx7E7
         HpebIdItrRtAs9yq8nOXnT4Px1Dkfh/XyDBdnYVmZVq75+2v/RX3IF5k5m/xVEyjZ/G9
         N+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756554699; x=1757159499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GokYqYG+lmT2oxJ+O2O4SIepQEUsvS6Oqvc1Ps5nstE=;
        b=GTW3y37RnDaFY51o2+R1Iu4O01uK5ySoBO7E4Xps1t8MaL+BO0IPAcEXD/5xjdD3P+
         pL59MDpu2t2sH/zeaq+lb9F7HASxu67F7190q137vHpZnTNUNyDmqyEChg/n5E2vOCPb
         fpUD9zI6oiPMfUkpMI4dlamK4CEAQvoTcqFYh734VHcO2uLmza26rw6EVeAzaNBqpSE7
         p5gzRddDDKNTT3dULMXCZHwDIo51DGDqK/Sx+eiEyfkv3IFCeliR4UE9P8SXnJHrTUTV
         MKpdbsn0flE4AlcQ194cbm/5++r3k4bUZMpw8LJlSSgpeG3YUtbTHup4NBRTf2NWH2hh
         1vjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4XO3/+3hBPT4s02/r9iL3qSiVXWZitVgXE4b8jo8UZkNvSSn8o875JvWh/Oxmo7FN4hT0E7bY6sGG@vger.kernel.org, AJvYcCW3HNh20UR7lV2jistm529CrHfPBeqWOGeZ906Ro3XQiCJooKK4zKWhyoS/2XvrfL6CiKDDUCQ57NPW8HZz@vger.kernel.org
X-Gm-Message-State: AOJu0YymrvK+COdEkYsBWLWZiL0laKDwgaNNXQcW3BPXSTNZhAopPK/2
	2XWf6mqHm1GxoSgX9O9Cg0c6M836SiMLxqaepNV4xx8SDZA0Wi5WP7PP
X-Gm-Gg: ASbGncs5vhRGJfKsmTvfKXtFHD+m2LBUBWUhCtcNbcirN2UPaQo1o/JEiSnLca2df4E
	LaybNh3B1woLO0CkUu6yhyH2tw2xUfCjYGFMPl5Q8PMoKrYCYLU1neg1nfXTDMxFI3T/RIKEo8Q
	n4niSl8bJs5iSMTiUVK3bbrZNDpXAUOa1+F2r1kqWT00XclOJ0W7wyTfuc3sSoaJFA4JgAhJHWH
	5XlZP52Xrv0Np8DgvA7mDUv+Jj0o3tg4W7d7JsDKvR+t3SP3SLnHeYH9y9wXfi0zPLkyElq58Tg
	sK/gAD884aLtyBteRLVhx3R0hsheBR4NLxpf5FGjjYQj+zRGII+gvgE7U1865MbLLlZMIhzqgQq
	1y4oLx+gUWVs2aeWhKrpqlS9A2E4l1qLIdUSvtw==
X-Google-Smtp-Source: AGHT+IHyb14KPLvEBP1uzF4N+Mv+SwihHqssUNY/21QMVDEC/beh+sytji1kJH6KwbNaJwZlIJr5gg==
X-Received: by 2002:a5d:5d10:0:b0:3d0:ebf6:90d2 with SMTP id ffacd0b85a97d-3d1e01d5561mr910309f8f.43.1756554699143;
        Sat, 30 Aug 2025 04:51:39 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b732671b7sm68161555e9.3.2025.08.30.04.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 04:51:38 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 1/2] arm64: dts: rockchip: add GPU powerdomain, opps, and cooling to rk3328
Date: Sat, 30 Aug 2025 11:51:34 +0000
Message-Id: <20250830115135.3549305-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Bee <knaerzche@gmail.com>

Add GPU powerdomain, opp-table, and cooling map nodes for the Mali
GPU on the RK3328 SoC. Opp-table frequencies are sourced from the
Rockchip Linux v4.4 vendor kernel while voltages have been derived
from practical use and support work: keeping voltage above 1075mV
and disabling the 500MHz opp-point avoids instability and crashes.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
These changes have been in-use with Armbian and LibreELEC for many
years without issue. Investigations into crashing (esp. with rkvdec
running) have led to voltage tweaks and dropping 500MHz. Changes
cannot be justified in technical detail, but are field proven over
a large number of users, boards, and cheap power supplies.

 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 39 +++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 7d992c3c01ce..b99c78ecc4a9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -331,6 +331,11 @@ power: power-controller {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
+			power-domain@RK3328_PD_GPU {
+				reg = <RK3328_PD_GPU>;
+				clocks = <&cru ACLK_GPU>;
+				#power-domain-cells = <0>;
+			};
 			power-domain@RK3328_PD_HEVC {
 				reg = <RK3328_PD_HEVC>;
 				clocks = <&cru SCLK_VENC_CORE>;
@@ -570,9 +575,13 @@ map0 {
 							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 					contribution = <4096>;
 				};
+				map1 {
+					trip = <&target>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					contribution = <4096>;
+				};
 			};
 		};
-
 	};
 
 	tsadc: tsadc@ff250000 {
@@ -651,7 +660,35 @@ gpu: gpu@ff300000 {
 				  "ppmmu1";
 		clocks = <&cru ACLK_GPU>, <&cru ACLK_GPU>;
 		clock-names = "bus", "core";
+		operating-points-v2 = <&gpu_opp_table>;
+		power-domains = <&power RK3328_PD_GPU>;
 		resets = <&cru SRST_GPU_A>;
+		#cooling-cells = <2>;
+	};
+
+	gpu_opp_table: gpu-opp-table {
+		compatible = "operating-points-v2";
+		opp-200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <1075000>;
+		};
+
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <1075000>;
+		};
+
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <1075000>;
+		};
+
+		opp-500000000 {
+			/* causes stability issues */
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <1150000>;
+			status = "disabled";
+		};
 	};
 
 	h265e_mmu: iommu@ff330200 {
-- 
2.34.1


