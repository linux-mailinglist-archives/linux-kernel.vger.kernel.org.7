Return-Path: <linux-kernel+bounces-771834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CB1B28C0A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 10:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09AF1AA3EBE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 08:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA4923BD06;
	Sat, 16 Aug 2025 08:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nb/M7lzK"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102F72288D5;
	Sat, 16 Aug 2025 08:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755334056; cv=none; b=rOTKQ4U+P0+PLa7HTILRVja004tFZCxprpVw2ixw4ct4MCXIhpUkfjIOt9UcfyDiJWDxaR8f32FNMMepD86QY+tNrPdvxKDfaq9UuMgI4Vu1VCSpikoKknOFIANIxg2tc93mAeAPyChCi/gEN/bQyBhzylhtPuHTjM0+0FCrSQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755334056; c=relaxed/simple;
	bh=0sQpcReULpsgaFKEamkaFHveJQyplmueGHJEFMlfkEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+iqYaf0KLIzm2p+paa64kYj7Fbe1uf/4BoBvYvHVnbmURlz7LF/kXk/XgmAihqDg+fDwbYBsEqivqyqLGCRvWXwh1RcgFBkVi4PesZ3vXlyvkVjr2Xo5y2+bqes+bdI45jqlNffrLYdkemnbyHp+5/15LOWu7zLAIch9UEC1aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nb/M7lzK; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4716f92a0aso1904630a12.0;
        Sat, 16 Aug 2025 01:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755334054; x=1755938854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LjpIZbO9mvGi9jWfEQ5hnMKUvryAGp+KhC+W5IHOPY=;
        b=Nb/M7lzK/EPNV9t88CUZwQKWLqtmmqe/XljQb3O2zq6arCtATt6d82byXy+wjFTWME
         DHlFSsrCNOBZ3XL3K3SrPfzJngVDEYzBkPhZoSG4ZDvSU0wLPVQZgzU3w9jlKmk9K8nC
         nZ4HmddSZkENfbZHV7SYh+t+DY3Mff4tjzQBEWMw6DKTxQlsNNoOJxsBgU37mruc5D08
         8co8k3Ts3zPxYez55hsbG0qVzgHkU2nZMry6nadF7TwfHIr1Y+uG/4yPe9jcOKCCPIzH
         9jKNfBWiaFSRZEcdDiiE4V53vjdlmg4odJxD1HD3GQW7uit5+rNSYsT7DZsFLx1vItKu
         xeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755334054; x=1755938854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LjpIZbO9mvGi9jWfEQ5hnMKUvryAGp+KhC+W5IHOPY=;
        b=DZHIS1vya6tT/dmMzvzgAC7Qz18g/v9reGkoRNG01XjoBBMQruQygECeitLnnzOmPn
         sxIVct9y/FALrL1suFgVwZ8TPfBzaHY8aD8+xhKkTmhkZAN+Fy2H0bCMaVj5JJvX2HwO
         xoABpp1Vi1DBWoOV+4i8/Who1MvtV/prVWqExAYhFB9mXzVNG7xsWoQEHTbN3+vO1R0v
         LYLsOqWPhNz/gpHX11HABPPjrIwhFS15pi6HMuoRV0MdVZHkJ2nwgrw8n9Z0q2Gya3Gz
         4qRHF94o9drk9pxlAaAuAp8ZGzj6l64gQhez8FsggScds5xPGIaHb847QyXB2oBehlw6
         +QCw==
X-Forwarded-Encrypted: i=1; AJvYcCVl8lpqRHc4DyK4CygKhf2lc2sVClhikKczS7K5bETMrDaZ+xr2tTmWnhKKX2rx5bx0NBahYTAW2+h0VWto@vger.kernel.org, AJvYcCW3XClasQTMkiOEvTgSIpeLWkGuk/H/FM1NHhybI9bLeOvtr4+9Lkqz2gCukczW0RVZ8UQ1fgBs02g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkJO9w2lpuwqMdMnWBqKded9wVrjC3eruEqUsu4sfGNIL/vTMG
	WGwX7F4TMfQ6+q/4Kvadunt8KtYIdW0+88rz1MHiYsRwQhexV9msUtnv
X-Gm-Gg: ASbGncvxs00MElUZnOC8tADOug+Haj9AXEviFw6w2LbsS6fva8dY0IJB2xeeYT82Nba
	thS2n/R14tL9tkFyySRIwnCwF8z0Ro6dVgRREqn5y1/NX6sX5jRBWTyqnzRz05lDSuQ544d8mZp
	K6KHQWkW5T2HacSxDST53U9mcsUanzG36OnLm6P1qQ61GSuRqeCFUzN6ycEKFDd9YvqVUrxJHy7
	gD5rSbn7O9VaDu+3JdDjZsDabCSM2uIEyNTDXchgJuOoCv/wMQ7/3pO0yknIS/pUUUSBx9scFSL
	+C1pAS05zIFmQCHPAzuyHOO/oZ0ntPfxe1xZy389T1DBSVVCRMXz5ECoReB7uW2MNY0CltsDClX
	Ks6AKJNPUdLUT1i1rTPe8NA==
X-Google-Smtp-Source: AGHT+IFMTkLskiB1Qs3dIHhYx1vm6JoFKQBNN3j/TxriFzjixkZX7mXsyi+PI7KUf9M6UIn/A8Ob4g==
X-Received: by 2002:a17:902:cccb:b0:240:84b:a11a with SMTP id d9443c01a7336-2446d6e5a89mr66059665ad.17.1755334054476;
        Sat, 16 Aug 2025 01:47:34 -0700 (PDT)
Received: from junAIR ([212.192.12.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d57f12esm31048215ad.157.2025.08.16.01.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 01:47:34 -0700 (PDT)
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
Subject: [PATCH 1/7] clk: sunxi-ng: a523: add missing usb related clocks
Date: Sat, 16 Aug 2025 16:46:54 +0800
Message-ID: <20250816084700.569524-2-iuncuim@gmail.com>
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

Several clocks were omitted when adding the original driver. These clocks
are necessary for USB 3.0 to work correctly. I added these declarations
according to the driver's BSP code.

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
---
 drivers/clk/sunxi-ng/ccu-sun55i-a523.c      | 32 +++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun55i-a523.h      |  2 +-
 include/dt-bindings/clock/sun55i-a523-ccu.h |  4 +++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
index 1a9a1cb86..7bf41e628 100644
--- a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
+++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
@@ -853,6 +853,31 @@ static struct ccu_mux usb_ohci1_clk = {
 	},
 };
 
+static SUNXI_CCU_GATE_DATA(usb2_clk, "usb2", osc24M, 0xa80, BIT(31), 0);
+
+static const struct clk_parent_data usb3_parents[] = {
+	{ .fw_name = "hosc" },
+	{ .hw = &pll_periph0_200M_clk.hw },
+	{ .hw = &pll_periph1_200M_clk.hw },
+};
+
+static SUNXI_CCU_M_DATA_WITH_MUX_GATE(usb3_clk, "usb3", usb3_parents, 0xa84,
+				      0, 5,	/* M */
+				      24, 3,	/* mux */
+				      BIT(31),	/* gate */
+				      0);
+
+static const struct clk_parent_data usb3_suspend_parents[] = {
+	{ .fw_name = "losc" },
+};
+
+static SUNXI_CCU_M_DATA_WITH_MUX_GATE(usb3_suspend_clk, "usb3-suspend",
+				      usb3_suspend_parents, 0xa88,
+				      0, 5,	/* M */
+				      24, 1,	/* mux */
+				      BIT(31),	/* gate */
+				      0);
+
 static SUNXI_CCU_GATE_HWS(bus_ohci0_clk, "bus-ohci0", ahb_hws, 0xa8c,
 			  BIT(0), 0);
 static SUNXI_CCU_GATE_HWS(bus_ohci1_clk, "bus-ohci1", ahb_hws, 0xa8c,
@@ -1290,6 +1315,9 @@ static struct ccu_common *sun55i_a523_ccu_clks[] = {
 	&bus_ths_clk.common,
 	&usb_ohci0_clk.common,
 	&usb_ohci1_clk.common,
+	&usb2_clk.common,
+	&usb3_clk.common,
+	&usb3_suspend_clk.common,
 	&bus_ohci0_clk.common,
 	&bus_ohci1_clk.common,
 	&bus_ehci0_clk.common,
@@ -1422,6 +1450,7 @@ static struct clk_hw_onecell_data sun55i_a523_hw_clks = {
 		[CLK_MBUS_DMA]		= &mbus_dma_clk.common.hw,
 		[CLK_MBUS_VE]		= &mbus_ve_clk.common.hw,
 		[CLK_MBUS_CE]		= &mbus_ce_clk.common.hw,
+		[CLK_MBUS_USB3]		= &mbus_usb3_clk.common.hw,
 		[CLK_MBUS_CSI]		= &mbus_csi_clk.common.hw,
 		[CLK_MBUS_ISP]		= &mbus_isp_clk.common.hw,
 		[CLK_MBUS_EMAC1]	= &mbus_gmac1_clk.common.hw,
@@ -1474,6 +1503,9 @@ static struct clk_hw_onecell_data sun55i_a523_hw_clks = {
 		[CLK_BUS_THS]		= &bus_ths_clk.common.hw,
 		[CLK_USB_OHCI0]		= &usb_ohci0_clk.common.hw,
 		[CLK_USB_OHCI1]		= &usb_ohci1_clk.common.hw,
+		[CLK_USB2]		= &usb2_clk.common.hw,
+		[CLK_USB3]		= &usb3_clk.common.hw,
+		[CLK_USB3_SUSPEND]	= &usb3_suspend_clk.common.hw,
 		[CLK_BUS_OHCI0]		= &bus_ohci0_clk.common.hw,
 		[CLK_BUS_OHCI1]		= &bus_ohci1_clk.common.hw,
 		[CLK_BUS_EHCI0]		= &bus_ehci0_clk.common.hw,
diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.h b/drivers/clk/sunxi-ng/ccu-sun55i-a523.h
index fc8dd42f1..d6916c728 100644
--- a/drivers/clk/sunxi-ng/ccu-sun55i-a523.h
+++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523.h
@@ -9,6 +9,6 @@
 #include <dt-bindings/clock/sun55i-a523-ccu.h>
 #include <dt-bindings/reset/sun55i-a523-ccu.h>
 
-#define CLK_NUMBER	(CLK_FANOUT2 + 1)
+#define CLK_NUMBER	(CLK_MBUS_USB3 + 1)
 
 #endif /* _CCU_SUN55I_A523_H */
diff --git a/include/dt-bindings/clock/sun55i-a523-ccu.h b/include/dt-bindings/clock/sun55i-a523-ccu.h
index c8259ac5a..26b2e9dc8 100644
--- a/include/dt-bindings/clock/sun55i-a523-ccu.h
+++ b/include/dt-bindings/clock/sun55i-a523-ccu.h
@@ -185,5 +185,9 @@
 #define CLK_FANOUT0		176
 #define CLK_FANOUT1		177
 #define CLK_FANOUT2		178
+#define CLK_USB2		179
+#define CLK_USB3		180
+#define CLK_USB3_SUSPEND	181
+#define CLK_MBUS_USB3		182
 
 #endif /* _DT_BINDINGS_CLK_SUN55I_A523_CCU_H_ */
-- 
2.50.1


