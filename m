Return-Path: <linux-kernel+bounces-771840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA73B28C1C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 10:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 006F71CE4BF7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 08:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDB12405F8;
	Sat, 16 Aug 2025 08:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSw/H56H"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B0D23BF83;
	Sat, 16 Aug 2025 08:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755334103; cv=none; b=fls25syJFx0XzeNhVI9vJYsmDVqH+E02+CJ+jCRR5VRW+DIF+M3EWsIwsst4H0hibEp6EeWa8LDpYin9Rm1WVcVTD/83AZU4l+/H7tBQ0ARboEsXT2Cpb4e2RzVl/LzBljeX2WxB3GX4Q4t8RMqndFWUhgju4e1FdYw24wuXN7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755334103; c=relaxed/simple;
	bh=ZiFEr88GKO2Hs9RHvAZKyj+tO8dqzvBWzvKcfZTtNF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LkmenMHo1B4KRPHVPRXEvBTDuNY1+o+qHSry18ssfZ/Qr8kXkVqkUYl+XXx8dXvA57ER6E6GF9piSHuWqjRxqw/lqEY6Y8SLdRCzD+izeAbXQfFb+e3wO20ELsg05bHmlvPhXPv1wtXYXWaE7KsCCvsQAKu0F/yD3TON398xgRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSw/H56H; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b472fd93b4aso1091385a12.0;
        Sat, 16 Aug 2025 01:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755334101; x=1755938901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCmauNf7s5FntNtudgCLlOZcs3Emgfa8V1BlciZ5v+A=;
        b=jSw/H56Hl/cjHoFgkYc2jUu7HA4DpLCXY5rzthsjWDygxT1beNC+lGs0rSjHteHUTJ
         Bx4hJvFEhIVGPzzyenuLp7uc0qxUCyVQ7s4bH4KVC0UmbCTn8HiIXWGHJ65y4rpoa2k7
         R6GotEvJBTVOttqNQJKszC7x0seErfNN/rnPLk9apnERZ4rYlErHGzi0qJDm6D7w0lw/
         G31rZUyNr2FiPl0vqfxeJvWsPlgTxpe7ytkfBR5cyy2XnyGezu8joNs63sovnRunv941
         g8azDjS4qt11MEOi25Zn/Mw27txBhEJdSDNncMeF+wqxpoIhwCI1eHHd45jtKES1tfDT
         FOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755334101; x=1755938901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCmauNf7s5FntNtudgCLlOZcs3Emgfa8V1BlciZ5v+A=;
        b=L4ouL2/ZhIKgymMbQk70xykEZWP5BOL6T5h69Rm8FjskfqORxSdu/Q+7XkURVvwCUy
         pGm/UO9svRScBVlw/ZoQnw6IVhK5Z/IBxfs23lkFNVRyjM+iHSvfHALkFLJvcrFEa0r8
         wEgMIsncKGLUlp0GWoNd/LfKf0W/+YoYmrloPdAlV2h7XdYjAnB6Cu/FAXfGGZeJjolu
         FCa9Rdp/yTEpizSYsMAFkqGdOzGzW2vUNP8y7NuLuFXPldl1kHT3dTw8LWPI1oKACwUt
         9jzaSDni92rrju7GMUHEfXQhFvzds6Eq43g0afTxutywk2LvB4YAXs8WcL2ccJxttEUC
         qppg==
X-Forwarded-Encrypted: i=1; AJvYcCV1nBJVVBO4msRLpQlzioOqXoWQz7YY7ikdbeR3l6dEtCo7Vk94M1aYMbzJTjADsnQ2+UrGzByDFCI=@vger.kernel.org, AJvYcCXXqtMQ63iTVUJ+RFyQy2oKcxNxn7i/mKIwt5Tkd/FsMtbX2xaX67bSTTqC7+UKcOtjrMz+1uBBZe4cB24s@vger.kernel.org
X-Gm-Message-State: AOJu0Yys2vjTyhKbtjxFJrbp0z3aDfdFXN8zQoihDz6U90HRFX1Y/vJT
	96kL3vjGxOESchgS8xsH0UWHuy8mHahhq6OLrQK52Tn2QgWYxKYripow
X-Gm-Gg: ASbGncuAhbcYVCZ/G2QtycPkxUYwbXMIvLZ+53Z/xkQKrb390GZEvcD10R9sp1JlTSp
	BCqOP80b9jHCvWI5lsKfLgT1XSqhfE/F7Edgbb6rnUyI3XXeTesjXw1KPKu7PFlt8/ieYmwQtDK
	ajrWzH4q8jwj5Pje4quow1yyRtKAvPI3iFmP7O0SkaiPH5aUAnrC861ynwA8c4S/lMYBZoqQ9Cb
	FhUlFs0941SckMPRHSCc/HCQNqktE0vq9HA4MzpOP8dpLIGEL46pcc1UZ7jg4HGCEMwutbO6TMg
	oife5DQkEdX7C1B1/tl0vqSUM/vc/8KVFxoAPp9ybK6jEMCN4sRjgfxelXrVwB3MaH5UkIVj216
	Rkv8POoViMRk=
X-Google-Smtp-Source: AGHT+IGpbFzYzzfHGbiZJhEqwpiiL3XiXv/bsEZ7XwHQ7nIZIbLySNrguZk+IP+kgbrq8QPu+xMORg==
X-Received: by 2002:a17:902:dac1:b0:234:d778:13fa with SMTP id d9443c01a7336-2446d866269mr71913515ad.26.1755334100952;
        Sat, 16 Aug 2025 01:48:20 -0700 (PDT)
Received: from junAIR ([212.192.12.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d57f12esm31048215ad.157.2025.08.16.01.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 01:48:20 -0700 (PDT)
From: iuncuim <iuncuim@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 6/7] arm64: dts: allwinner: a523: add DWC3 USB3.0 node
Date: Sat, 16 Aug 2025 16:46:59 +0800
Message-ID: <20250816084700.569524-7-iuncuim@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250816084700.569524-1-iuncuim@gmail.com>
References: <20250816084700.569524-1-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Kalashnikov <iuncuim@gmail.com>

After adding the phy bindings, we can also add dwc3 node, which uses the
previously added usbphy2 and part of usb3 from combophy.
All settings declared in dwc3 node are obtained from the x96qproplus' dtb.
BSP contains an additional glue driver for dwc3, but it seems that it is
not needed.

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
---
 .../arm64/boot/dts/allwinner/sun55i-a523.dtsi | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index 233365496..ec170888a 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
@@ -606,6 +606,27 @@ mdio0: mdio {
 			};
 		};
 
+		dwc3: usb@4d00000 {
+			compatible = "snps,dwc3";
+			reg = <0x04d00000 0x100000>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			dr_mode = "host";
+			clocks = <&ccu CLK_MBUS_USB3>, <&ccu CLK_USB3>,
+				 <&ccu CLK_USB2>, <&ccu CLK_USB3_SUSPEND>;
+			clock-names = "bus_clk", "ref_clk3", "ref_clk2", "suspend";
+			maximum-speed = "super-speed";
+			phy_type = "utmi";
+			snps,dis_enblslpm_quirk;
+			snps,dis-u1-entry-quirk;
+			snps,dis-u2-entry-quirk;
+			snps,dis_u3_susphy_quirk;
+			snps,dis_u2_susphy_quirk;
+			snps,dis_rxdet_inp3_quirk;
+			phys = <&usbphy 2>, <&combophy>;
+			phy-names = "usb2-phy", "usb3-phy";
+			status = "disabled";
+		};
+
 		combophy: phy@4f00000 {
 			compatible = "allwinner,sun55i-a523-usb3-pcie-phy";
 			reg = <0x04f00000 0x100000>;
-- 
2.50.1


