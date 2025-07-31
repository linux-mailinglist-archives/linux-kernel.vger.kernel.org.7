Return-Path: <linux-kernel+bounces-752223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF77DB172B4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 939E67AC12C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD082D23A6;
	Thu, 31 Jul 2025 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V9SKa/hl"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E642C327C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753970521; cv=none; b=oQc642vVlQrdjAdNTty0S++iGztwjzPv9dX0z0dhA/tPbxBIJ+WHv2p8LDRkrRw3jv9cw1dslgxEu1pRF0vYpHwPDuq9BDdBxTVnB1/CkoR+7tr8qgJVH/ThZSC2RGJUR85F3AA04EkzBRTZC1RfUdOCWAshZ7Pid8WmDnAyzGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753970521; c=relaxed/simple;
	bh=Xpc1QjbDF2eak56qCWUaPd3vkbEYlZ3tB5wz0Bz9ZkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5PzZpxcP61A9tCgapV8bJxnDWy9qC/IJZMRT1gWEvpCcyuvTz/yYYLLPBuaCU52jUQcYqtZYNuM2BOxyUERatH4Htk3Djs1JePKAEIhp0CDq4z6bB0iGyjR46Kc//v0d1enBAlurGpaptAr3lMKtbqbbwCaBUXhuQBloNGnVuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V9SKa/hl; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4563cfac2d2so9144325e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 07:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753970518; x=1754575318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwFsTsG6VVVIEYXelcVJDGOE+gmfaFKEIVGQh0yHCdM=;
        b=V9SKa/hlIsDL1ViL0YVCGKIiUyem15H1gHQzT536tFaRzf/IehvYATULlwzSj6Xq88
         51xsSHomuQeWD+B8/i26o3EPU5IMmc2YsKehJRV2Vxhp35sJMUY3iUCW/ZG0xZEMtlR6
         bKWJ/CBCv+5zK2BqktmVB2/hVyYy5CQ6Yi0D88mKafhVfeCLNuA+0R/MosxrP2RXYL6S
         RapgxQxss0scEq/7tXR6RXs+a70gSCqYOl73PgbCsVqmtbZp7z66J00kgTnKkxRIOe9i
         2Wb1X3QD149zAtbNXjFdtzI9vIbxHYGdzG58D6H3eY0GA51M3R+iHgoiUMbgWvpHkvWo
         aHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753970518; x=1754575318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwFsTsG6VVVIEYXelcVJDGOE+gmfaFKEIVGQh0yHCdM=;
        b=FVcapgngyl6FkCTNFB5jmT8Z7PZQ2v3zYoVq2vJk+KPNYZylf0Rgr3ncLiHMp6eeLx
         A+Mmmd7UZ1euJyQZmjOJjmfHjJQVxTNMvuSAKjnK3B4MGL+A3Qc3N/yy3d5qU9x7CddD
         qJVzkeBnmY1GNR/etflCmzXfLECygjLkNCXsgPs/Ice2j5Fe2IM8UR7GkWXDi0egz5KZ
         j3Mt4eUWjHXB4uH0EE72SKTU4rvowNbtCzH+CSttNVirXzQKPaCnUbxtlQCle/DtUKjv
         VJSUGknY4cP9I1NBR5peFRuud/bBUaDA3VPjeEL9nxQrR+q9GnITbrVERGGQbupEIlTh
         68zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYwmDpQXmfUgciGx4lyEOGakxTT8KjJquzYJ7x2mLWc8j+RziiTUbsrqziNH3XsCg4lwoU7KjDRacfVQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjV40MvcY/qSBEahXuVu9tfYVwCVNV+58uWL5b0EvAQ3sXsDm/
	ivwfDTfBaAZIM3DW5jnxoogPnD9mmIdIMz4bqiBwztfSulXDou/g8OTFJNiHX3xz8Yc=
X-Gm-Gg: ASbGnct4hRvz+pFfH5rWnRGdwSWqBKTEgK31tniNVjpF5TBs8wNKXItIEqLSgTlTwK9
	yHdkFyBLOL6B8vIaf47T3TofrrKDYsraUF+5fekLsF2R+BKV2ViZ6taXVGSQbQ3JdiDVXglt3RD
	2pyQGmfRyb8Jh0xik0kGd4nyh0wPo0XpWq7MD6JJlKQvEdS5QlLN+SxjErCL5rvRjp5fOCIdGjG
	k+lLJ0eSBSpCdf0a5OGYsWXNNWBI2LY6BKfBEE9ISv9Rz1ssnr+6XRoyhX0QSjiXv0kkMdz1ddR
	HM4wGlz8rruzNHCAK3ABpSWTgODPTywJtAMO2CncfdX0HcTlO9SPD8TseIFPRESK0DVAtes2a2T
	cyPFdkrRgiRszfD1XtC4GX4dsVOR7Rz7yEKOI2MJqXGaplk5B
X-Google-Smtp-Source: AGHT+IE9qKRVnjaVEgn1UAlBxYnmTqRy8r5vlmAdzB8hFwkW2dkNsNPHqiJWxr1+s5Cb5BtT0A9yoA==
X-Received: by 2002:a05:600c:35c2:b0:456:1dd2:4e3a with SMTP id 5b1f17b1804b1-4589c2b7c59mr53270125e9.3.1753970517567;
        Thu, 31 Jul 2025 07:01:57 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589ee57c18sm28121285e9.28.2025.07.31.07.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 07:01:57 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: mbrugger@suse.com,
	chester62515@gmail.com,
	ghennadi.procopciuc@oss.nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: s32@nxp.com,
	kernel@pengutronix.de,
	festevam@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Thomas Fossati <thomas.fossati@linaro.org>
Subject: [PATCH v2 1/8] arm64: dts: s32g2: Add the System Timer Module nodes
Date: Thu, 31 Jul 2025 16:01:34 +0200
Message-ID: <20250731140146.62960-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250731140146.62960-1-daniel.lezcano@linaro.org>
References: <20250731140146.62960-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The s32g2 has a STM module containing 8 timers. Each timer has a
dedicated interrupt and share the same clock.

Add the timers STM0->STM6 nodes for the s32g2 SoC. The STM7 node is
not added because it is slightly different and needs an extra property
which will be added later when supported by the driver.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
Cc: Thomas Fossati <thomas.fossati@linaro.org>
---
 arch/arm64/boot/dts/freescale/s32g2.dtsi | 63 ++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
index ea1456d361a3..1783edb81350 100644
--- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -317,6 +317,42 @@ usdhc0-200mhz-grp4 {
 			};
 		};
 
+		stm0: timer@4011c000 {
+			compatible = "nxp,s32g2-stm";
+			reg = <0x4011c000 0x3000>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
+			clock-names = "counter", "module", "register";
+			status = "disabled";
+		};
+
+		stm1: timer@40120000 {
+			compatible = "nxp,s32g2-stm";
+			reg = <0x40120000 0x3000>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
+			clock-names = "counter", "module", "register";
+			status = "disabled";
+		};
+
+		stm2: timer@40124000 {
+			compatible = "nxp,s32g2-stm";
+			reg = <0x40124000 0x3000>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
+			clock-names = "counter", "module", "register";
+			status = "disabled";
+		};
+
+		stm3: timer@40128000 {
+			compatible = "nxp,s32g2-stm";
+			reg = <0x40128000 0x3000>;
+			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
+			clock-names = "counter", "module", "register";
+			status = "disabled";
+		};
+
 		edma0: dma-controller@40144000 {
 			compatible = "nxp,s32g2-edma";
 			reg = <0x40144000 0x24000>,
@@ -409,6 +445,33 @@ i2c2: i2c@401ec000 {
 			status = "disabled";
 		};
 
+		stm4: timer@4021c000 {
+			compatible = "nxp,s32g2-stm";
+			reg = <0x4021c000 0x3000>;
+			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
+			clock-names = "counter", "module", "register";
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		stm5: timer@40220000 {
+			compatible = "nxp,s32g2-stm";
+			reg = <0x40220000 0x3000>;
+			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
+			clock-names = "counter", "module", "register";
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		stm6: timer@40224000 {
+			compatible = "nxp,s32g2-stm";
+			reg = <0x40224000 0x3000>;
+			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
+			clock-names = "counter", "module", "register";
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
 		edma1: dma-controller@40244000 {
 			compatible = "nxp,s32g2-edma";
 			reg = <0x40244000 0x24000>,
-- 
2.43.0


