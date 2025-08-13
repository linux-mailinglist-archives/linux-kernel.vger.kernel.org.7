Return-Path: <linux-kernel+bounces-766231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D951BB24418
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8AB1585790
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6562EE5FE;
	Wed, 13 Aug 2025 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="J4hMFpAa"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3E62C21E3;
	Wed, 13 Aug 2025 08:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755073128; cv=pass; b=l8UF9tX73IIMfb/zyNqBSotzYQsmXXuk5If120bMOHzyJakLce+gfrN7tfUdmBsDPVSrOx+o43CypIoIKqI/jk63J4xR4HND/qC9uSbCenGIzTSeLxfx2F9Gdq2S1fFuqLXkCtl3jrUSHosRQMJy81zzDghvQDASVAsu3kDaETw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755073128; c=relaxed/simple;
	bh=V85chmd0rY7vxm3XZQ8p/n5O1xcDQ3XdQZypcbHIVlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i3FVduU9kRFzvRDIKHetEF769cibPDeHik1NDbkRF/9JiG5/231+CzwT4sARKrJoWqk9BP3jWCvFBhOzVA0GszmE84AcHhnngVf8BL38eO6oxs3ObsoXBOLgtS1QSLCA9WjkNYeCkJjMfOv16FtYlJk6r4d0dq50zLKJAGHQrv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=J4hMFpAa; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755073110; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Em3ZSXtvhAnqwNgp1nuh5YcQhLbSwpjOoJikabPBmjDxbBxa/P/2+wRrDDMVM7pg6Q03CH13WMKcuPO4tTJgW/hjkFl6947VgXw/p6dtKsDjNm2pDemjWNYrWG6g2pxZf0mI7nLhOocKViV5zxLajBvp6HHz4gfmU1yQQW2mEY0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755073110; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tc17qmFHa/GPucvOeBviX5DuJp7Go3v2kqed9wv4nmw=; 
	b=XC5O1fqmCvPqUV9wFxt5RZWMSwYN4eoLsDcPJfV2xD5AG0TtSka0YE+BKPuxxD+Db9V6KuIrwedXPunbHvDpVLu6HHFQPr8/dK/m1mgK5BAZjPeuQAs9m4+OglQcpXwyj54ZMsjhrmcn0SxbrjGee+eOxres7WcP1mvTn/VuaDI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755073110;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=tc17qmFHa/GPucvOeBviX5DuJp7Go3v2kqed9wv4nmw=;
	b=J4hMFpAaApTL34SWwxQ2/0XGBYXSxmedo0XTsbwDWNiRPRIsmFFManX6T/paRRFf
	pcWhibDGjzAZQoQzRb6mu97YUn+vXMzn3ETugbleZqoi/SkeSPrWyLw1SEOaLI+OUb1
	Y43GExumkIr6HAAq95PRFi57ZK3knnA3WxytRVtnIuTwJMCckQHAjilQtM3i43yuY14
	UGbLQRxBwlC6OaLAWob/FGz746otpPIDOfcHDGTpvKYlykp8bUNlYfirObFd0/2rskr
	c0oybIn7T8EmFmyPPks5ksyClzeoWMtSu+86fUJATjKYiigXEIBYcpKdmSkdP91PUIN
	nnCOAUX7YQ==
Received: by mx.zohomail.com with SMTPS id 1755073107397444.5758861641673;
	Wed, 13 Aug 2025 01:18:27 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>,
	Yao Zi <ziyao@disroot.org>,
	Han Gao <rabenda.cn@gmail.com>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 2/2] reset: th1520: add resets for display pipeline
Date: Wed, 13 Aug 2025 16:17:16 +0800
Message-ID: <20250813081716.2181843-3-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813081716.2181843-1-uwu@icenowy.me>
References: <20250813081716.2181843-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The VO subsystem of TH1520 contains a few resets for the display
pipeline -- display, MIPI DSI and HDMI controllers.

Add support for them to the reset-th1520 driver.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 drivers/reset/reset-th1520.c | 40 +++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/reset-th1520.c b/drivers/reset/reset-th1520.c
index 7874f0693e1b4..06e5dff7c524d 100644
--- a/drivers/reset/reset-th1520.c
+++ b/drivers/reset/reset-th1520.c
@@ -14,10 +14,20 @@
  /* register offset in VOSYS_REGMAP */
 #define TH1520_GPU_RST_CFG		0x0
 #define TH1520_GPU_RST_CFG_MASK		GENMASK(1, 0)
+#define TH1520_DPU_RST_CFG		0x4
+#define TH1520_DSI0_RST_CFG		0x8
+#define TH1520_DSI1_RST_CFG		0xc
+#define TH1520_HDMI_RST_CFG		0x14
 
 /* register values */
 #define TH1520_GPU_SW_GPU_RST		BIT(0)
 #define TH1520_GPU_SW_CLKGEN_RST	BIT(1)
+#define TH1520_DPU_SW_DPU_HRST		BIT(0)
+#define TH1520_DPU_SW_DPU_ARST		BIT(1)
+#define TH1520_DPU_SW_DPU_CRST		BIT(2)
+#define TH1520_DSI_SW_DSI_PRST		BIT(0)
+#define TH1520_HDMI_SW_MAIN_RST		BIT(0)
+#define TH1520_HDMI_SW_PRST		BIT(1)
 
 struct th1520_reset_priv {
 	struct reset_controller_dev rcdev;
@@ -37,7 +47,35 @@ static const struct th1520_reset_map th1520_resets[] = {
 	[TH1520_RESET_ID_GPU_CLKGEN] = {
 		.bit = TH1520_GPU_SW_CLKGEN_RST,
 		.reg = TH1520_GPU_RST_CFG,
-	}
+	},
+	[TH1520_RESET_ID_DPU_AHB] = {
+		.bit = TH1520_DPU_SW_DPU_HRST,
+		.reg = TH1520_DPU_RST_CFG,
+	},
+	[TH1520_RESET_ID_DPU_AXI] = {
+		.bit = TH1520_DPU_SW_DPU_ARST,
+		.reg = TH1520_DPU_RST_CFG,
+	},
+	[TH1520_RESET_ID_DPU_CORE] = {
+		.bit = TH1520_DPU_SW_DPU_CRST,
+		.reg = TH1520_DPU_RST_CFG,
+	},
+	[TH1520_RESET_ID_DSI0_APB] = {
+		.bit = TH1520_DSI_SW_DSI_PRST,
+		.reg = TH1520_DSI0_RST_CFG,
+	},
+	[TH1520_RESET_ID_DSI1_APB] = {
+		.bit = TH1520_DSI_SW_DSI_PRST,
+		.reg = TH1520_DSI1_RST_CFG,
+	},
+	[TH1520_RESET_ID_HDMI] = {
+		.bit = TH1520_HDMI_SW_MAIN_RST,
+		.reg = TH1520_HDMI_RST_CFG,
+	},
+	[TH1520_RESET_ID_HDMI_APB] = {
+		.bit = TH1520_HDMI_SW_PRST,
+		.reg = TH1520_HDMI_RST_CFG,
+	},
 };
 
 static inline struct th1520_reset_priv *
-- 
2.50.1


