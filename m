Return-Path: <linux-kernel+bounces-804164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706D5B46AFA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 13:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94063B6094
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 11:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E33227510B;
	Sat,  6 Sep 2025 11:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFKgf/Dx"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBC618DF8D;
	Sat,  6 Sep 2025 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757157637; cv=none; b=pHgQS+Y54Yhw1jO5rw06LA/aepUyqdrE/LEyYjpDRFpSDURPaVjqXzmUcLAl0vQyZYDwYQBCDd/BUk/UKg5coC4moBwlwvs91iYyG54fJcLsd318NnSIcfxCON6/TZRoTykzN9z1Mc/vGcyTUzl0DpEbUK4MSQXD7yqhfe0bpY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757157637; c=relaxed/simple;
	bh=EAgNf2qCHkKh2b2xYSu0emsdPpOAv++cCMQXLtPlrO8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A4tZmhmr2pYslSnstQk6Rf/LJ63rmige9Cf0NrMsDBCC6FDwtxRx/Fmr13Si67OXA1UL4J08UkFV9MfwaTag5zJLSUU8rkCsIzdQaMDU4YC1azqB3k7STgvomov03xUoJyN97Hkt3JOEpV6TiGSZoK+2ugWVEHW5JRTSKv6lhvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFKgf/Dx; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b83ae1734so16777265e9.0;
        Sat, 06 Sep 2025 04:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757157634; x=1757762434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=phOTkO8Gp6UOyxxexRbWZlNYnHe4XUhUoNN0wC8w1EE=;
        b=CFKgf/DxdCCF3zucQT34zkTZvYzFGkJSsCvoilfZ8ytxLk5XOtNsk9Yj/bEayq7MJG
         C32Qk4dQfI5DPsxfgVn4PeHzwx0QdN59TAgOWaCdZGIbLXwcn1zldf0nAQbMEq1WdWOK
         8rdWN1FaDNzb0JwKgDSEfmU1alwKOCp6zhATAbTxc0jUfNfgSF7O+ScjEeSZt0aQYWtq
         KcW2aMa0D6CwBFA4M0evUqvtJGOu9dSvm2hnri3xOmKb7pAeeJSx6QDu6bnbAofnq7ee
         vyWXA9f0JOT+jvwfRxs8YheNPqzNDNDgLCnT9myMsbt0DTYJ0ITqxG9mbVxwqs93Zpg8
         vNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757157634; x=1757762434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=phOTkO8Gp6UOyxxexRbWZlNYnHe4XUhUoNN0wC8w1EE=;
        b=qlW6LhLdsJjW5MVf6ELESJV7uUjKbWKfZnhVKQZxV02F1RNSi4V7lvM/ENJFWreIKz
         tOb8PDiUN3BVBm2iN3eMHz1WPv6O+weYY3Fwn2197pI6E42OVU/zr9CIC4qt77ZXfaAv
         HKZ1g92Mo2KGW/0NMTSG74dg1CtF3+Mzd4jgfRH9JyFhiWKcBP8IveI8Yh1kBs3NdzmN
         F66d8WmXR6uHLw0AVFqWKk7Id+u7lh5nKkQKZKkLW1gMQfkXlbS/vBjKNAc0RuTtCcLR
         fqIoWrf6niQrzz/Y1wMja+yzvXMA2cbL7ZKT+0ynntkyUQo6IRjQtqNZsmcO0sTzvjFn
         R8rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj42c/o9XgLNtMR2rumuqtadAMDkDRJPI3ofs/17Zcgj8rMOGieLmmfsEaaGm5zV+ASMVETkl8yRxv0/Jn@vger.kernel.org, AJvYcCXHZ1UM9Y9vs+FpspuyHJJN39VafZQnAvFEqvPxpOMXPGErff/KNxekXTsNqlm1eWB/Wftg6Q04ESEE@vger.kernel.org
X-Gm-Message-State: AOJu0YxmonBx78x60BRy1H3cY9HlobUjoZY4wP9TVCUL878SUjcjZWve
	fpndAxqmSLmUzXXQPGw9XRgXc22a3AwnzcFYSByzroFRzVaEzjSdJGL4+defbwQH
X-Gm-Gg: ASbGncujGc+XMAQ928zLJk6e05UzYkExH+AclJw1xRA5Re4gcQ3IBNp20+Y8TtLjJV8
	EM0kgmM85WyT5fQL22oQ/+2xfSVUyovBKfqhZMkW/7HU4AtPkEaD+F2yWX5krBd2KV2RGNeQeJx
	5x1QLjOg/QmRMRQEqHShvZrXGnbdK/3uaHPxqSf6ynmTUOjPhzbie0f+k52JMP/xHS/cCNk0Jqr
	HcumZoMwUaWnstrCVT63vFdxn7izUCPjpqnKRN0HWU8Q1BrndYjhv1oMpgUzmc9nx/5xs/KkYmb
	k/a3od328BLke2TJUT6UqcLGHdAwA8bPbm9mnNsRxwC5rwSzvHI0LYVJx2wThQQVwkIR4j9UEUN
	4Rbt4W1GEkLmh+HHM9rOx9Kgjwc97YfAhUqJosA==
X-Google-Smtp-Source: AGHT+IHT2DCsTdLyK7hMXnyf7nuV8L5ZvBVobCadVxozJnday1OLD/JOCxtfevqmsVo0tPUhkWbrSw==
X-Received: by 2002:a05:600c:3516:b0:456:1824:4808 with SMTP id 5b1f17b1804b1-45dddedde1amr15969715e9.32.1757157633669;
        Sat, 06 Sep 2025 04:20:33 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45de18f4824sm6646655e9.10.2025.09.06.04.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 04:20:33 -0700 (PDT)
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
Subject: [PATCH v2 1/2] arm64: dts: rockchip: add GPU powerdomain, opps, and cooling to rk3328
Date: Sat,  6 Sep 2025 11:20:29 +0000
Message-Id: <20250906112030.1829706-1-christianshewitt@gmail.com>
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
Changes since v1:
- Use opp_table_gpu not gpu_opp_table to fix dtb schema warnings

 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 39 +++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 6438c969f9d7..01ed2bfa7ee1 100644
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
+		operating-points-v2 = <&opp_table_gpu>;
+		power-domains = <&power RK3328_PD_GPU>;
 		resets = <&cru SRST_GPU_A>;
+		#cooling-cells = <2>;
+	};
+
+	opp_table_gpu: opp-table-gpu {
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


