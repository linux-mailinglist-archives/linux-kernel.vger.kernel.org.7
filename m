Return-Path: <linux-kernel+bounces-884784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEC0C31226
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DB5118C0736
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A612F1FF6;
	Tue,  4 Nov 2025 13:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DeLLo5xm"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E032F532F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762261757; cv=none; b=Jt/NELT+ojjjnb6IwRlF1w963RpnKniQThnn1SR5m5CqgdJCs0Ghl+OtU4e+UZgAMh5wIK6xo724dr3Bn37U1/JS+j2XoptOUGjJ8loDERv2w6tUWnUDgW86H0uY8T05Bi88nS6sGnsGpeCvfc4BNZx/X4GJI51/0hD7HnQi+2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762261757; c=relaxed/simple;
	bh=NBuMo3fA0T+jYUYuxAjSnoU2gctigcAN7afLM+xxwVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sMeDwMNAndk9F0OSFkJr5julLkQq12Z7kOVhA4xo+n+LBdsUsx+K3V2Z/HFlu+ZKvIO8eGC6+SJCdISZit/+5S8v+tHECxDAmC0ms0e4dPvqEATX+Ub9RZ9tewgtbgL7qRDFmySZIo9SR5pRlAo2ryo6nfpQ6YekBI33E6O+Wyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=DeLLo5xm; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-429bcddad32so3279174f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 05:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762261752; x=1762866552; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EeInQQFLiIKx9a2aZ0cucvmhXeQc/nRxrd1ryoO5rZk=;
        b=DeLLo5xm3OAR2rej3QloNmz9nAd9jIHTeVHP+jDZuzzNROyLeAkscZbuMojt6U951+
         JUxck4L8IsY7dur6fFmGzij1hdT0F1CgoWglVZok4QuKBU93FgLr+yOilVto6i4paSq3
         kEcW6QEI+mLK8plhwwWuIFX7JcyCtc2kJdmSiefpfn59s27BFI0ZRPi/RSnzIiUFHf2q
         2hHdT3J9uHB+fnfG0x8Eea4kTyxi6ab3C9Kk6Co0fdYgTLrsgLjVisurjo7lx2ZNJ3Ty
         8IQjMQCfZ8gzCtCNEGGTTCKs6F8nnnvYKojFYKlHqT3AeTAmXGIpahZzRhn7zUbD5xuW
         kyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762261752; x=1762866552;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EeInQQFLiIKx9a2aZ0cucvmhXeQc/nRxrd1ryoO5rZk=;
        b=hTfCvo6Lw09SXxOi/TCLfyFvAPoo+YOln7ww91kEF6YqdljzL2s7ZfXF8PV7QK4Y4/
         0G97Tg0WViXYw7YWIZgbbqsgjkDgiSp6i4XtLtTsqJyJR6ZSixGI/zurszE9PtJLa3ry
         SNzQFfHeZbXuI1Ty5aWfViWri2mH6XLArqVSnnLoC4iN1lHZ6Cc0JvSUrL7Vhe5M1nxC
         GY33T+pNgxKYcbotC5xMIr0iYgIntPMHUIGjzNE90sDb6alUASRChJgb2kobXo9WJZY0
         iYyJ+mNA/DpfJm702Pi4kPEYi6UkedtDxZoUDqXkx2uIgy2nwCBB+VG8QYjhK8ZM2QhR
         nJRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEOLW88n7I1ydBPLRjSRoP4w/Y2F1s3P8qTVSpw2Py6oM1Glq81X1I4+gOfgkNUmn/lMwzf4ZG+cPXd9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwujepHGBavngcshPPI2BRfenDJOv73gNE+FATK7hi7slVnTApB
	p4qf3+UN2Jr1y8TT1tKuckqM/jQGCPfCgNaWd+AsBsOmUnEuWbiAuEUi8K4YotfO9Gw=
X-Gm-Gg: ASbGncvJqtluB9Eo5Xf29LSm+05fvx1Ryyn1OQxLsEUTVEvcLX7ove51JAOU4Hdjtg6
	LNSpNZxYKGIN/sSTMfKO8yUl1Bc72X/yq/AgEhSjOrUWqeShdJbMZVtZePFFjMj75jeOsCf8JBL
	g9u0IttCK13SM+3AInVDHbLfQkCUInluj3Dt1mMYaLYG+uzZLyUixjJrjg5I9Ja7PDiznR8+nRZ
	mel9MrOBQ/8k+c6HWm6wn566C3zbHxcj6FRx8qTOAFFGNw//sqQn2YU4Xhv820ET9E2IMMg33zk
	xHIIwFZPaB7Ebby/gbVc8S+dKiclFr96UlI4CFtG5u0g4M0/9+IGWIEseHP9HVS9Ezc9jJdfE/3
	BJ7g46ywDJTzLrxqNHLsoZSsY4uWfOsCzGWbzeo5EoXeUh4ylns/Tp+hikNj+V7YwdiNCKQ==
X-Google-Smtp-Source: AGHT+IEazXC1/4e+3C9LIKFv0ME+i45XzCYX35RlKHJ+lvSQy9CFk/4mRB0TKiPc1PmCBPTWdT7aKw==
X-Received: by 2002:a5d:5f87:0:b0:429:d565:d7b0 with SMTP id ffacd0b85a97d-429d565da79mr4914264f8f.40.1762261751551;
        Tue, 04 Nov 2025 05:09:11 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:9ea1:7ab7:4748:cae3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc18efd3sm4554431f8f.5.2025.11.04.05.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 05:09:10 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 04 Nov 2025 14:08:53 +0100
Subject: [PATCH v4 2/8] net: stmmac: qcom-ethqos: use generic device
 properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-qcom-sa8255p-emac-v4-2-f76660087cea@linaro.org>
References: <20251104-qcom-sa8255p-emac-v4-0-f76660087cea@linaro.org>
In-Reply-To: <20251104-qcom-sa8255p-emac-v4-0-f76660087cea@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Vinod Koul <vkoul@kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Matthew Gerlach <matthew.gerlach@altera.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Keguang Zhang <keguang.zhang@gmail.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jan Petrous <jan.petrous@oss.nxp.com>, 
 s32@nxp.com, Romain Gantois <romain.gantois@bootlin.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Heiko Stuebner <heiko@sntech.de>, Chen Wang <unicorn_wang@outlook.com>, 
 Inochi Amaoto <inochiama@gmail.com>, Emil Renner Berthing <kernel@esmil.dk>, 
 Minda Chen <minda.chen@starfivetech.com>, Drew Fustini <fustini@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
 Shuang Liang <liangshuang@eswincomputing.com>, 
 Zhi Li <lizhi2@eswincomputing.com>, 
 Shangjuan Wei <weishangjuan@eswincomputing.com>, 
 "G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, Linux Team <linux-imx@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, David Wu <david.wu@rock-chips.com>, 
 Samin Guo <samin.guo@starfivetech.com>, 
 Christophe Roullier <christophe.roullier@foss.st.com>, 
 Swathi K S <swathi.ks@samsung.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 Drew Fustini <dfustini@tenstorrent.com>, linux-sunxi@lists.linux.dev, 
 linux-amlogic@lists.infradead.org, linux-mips@vger.kernel.org, 
 imx@lists.linux.dev, linux-renesas-soc@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, sophgo@lists.linux.dev, 
 linux-riscv@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2896;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=POv+vDF2xSPchjLMqtdcREByAr5wVSRC/4xfmqCj4bM=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpCfrsfPxny4b8sz641T3T8EFvMTQx5kwO1QGOR
 8pb8GTd+BeJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQn67AAKCRARpy6gFHHX
 cnqVD/97NywmsMZe+hTiJ7jxCsNyrWnMcFO+7cIL2RPel3gou8gIXIQsX7ETeIUDtcJzTZ1KqSm
 agsydioe3Mk2/PKY0XdQxNxEpMu65rEETgcwAzTyKgoU/GZTN7LqKeqxXx3S8aUCDiwGkjQifN8
 X2v8MajyRTcRmY6D54ypAgNEnFYJkeXukrUxi75A6NLw5DrkAJXiElFKV8Tfmc35UABzpEhoqVE
 T88M2BP+jZLRswE6QrLutFh322QPaF+UjIRKHUaSw4FFBTZTy5aDvugwNG/kaGN3HopwyUXjCRf
 ErGV9fj5k1xKzd0LYxkqFzXGd+anLTeceuPdxnQBJJS1WQStSlyRM8YM9o7iyG6Vpn9AwHwPQOX
 IG1GY+EPViR2egEOTkA05k9276NPSpxVnYXxSiEq5Qbk35L4ZJDO96QF/G7uILkWr5coGWSSms/
 P4UoZRGYq4KVQ/m8Q+r5upzCzXVqfEDAyKuhITS4g84ORbRJEezl5MXDte+IYVB+qcRrWEmXjBz
 8g60W21TaM8AfbRDvZtWVjkNzCIlUv68U1HsXEpCg7dJiPHZYMpZeM6sgFYNYCONcr/XTMwTODa
 ar4PeVg5WExRCx2+/p2gUOp1THWngsIY51xRK43VP8GvryZCHp/WVW7HF7s7bCwOHAoLr0/70vM
 g1Xe3JNSs8RSY5w==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

In order to drop the dependency on CONFIG_OF, convert all device property
getters from OF-specific to generic device properties and stop pulling
in any linux/of.h symbols.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig             | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 87c5bea6c2a243f3be998b2c3935bc1dc23bfe22..22d0eaab35eaffac0bca58f8625ecc5c955b6631 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -135,7 +135,7 @@ config DWMAC_MESON
 config DWMAC_QCOM_ETHQOS
 	tristate "Qualcomm ETHQOS support"
 	default ARCH_QCOM
-	depends on OF && (ARCH_QCOM || COMPILE_TEST)
+	depends on ARCH_QCOM || COMPILE_TEST
 	help
 	  Support for the Qualcomm ETHQOS core.
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 1a616a71c36ace29a74a0aa23fc8173443aa49a5..8578a2df8cf0d1d8808bcf7e7b57c93eb14c87db 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2018-19, Linaro Limited
 
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/of_net.h>
 #include <linux/platform_device.h>
 #include <linux/phy.h>
@@ -748,7 +748,6 @@ static void ethqos_ptp_clk_freq_config(struct stmmac_priv *priv)
 
 static int qcom_ethqos_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	const struct ethqos_emac_driver_data *data;
 	struct plat_stmmacenet_data *plat_dat;
 	struct stmmac_resources stmmac_res;
@@ -799,7 +798,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 
 	ethqos->mac_base = stmmac_res.addr;
 
-	data = of_device_get_match_data(dev);
+	data = device_get_match_data(dev);
 	ethqos->por = data->por;
 	ethqos->num_por = data->num_por;
 	ethqos->rgmii_config_loopback_en = data->rgmii_config_loopback_en;
@@ -836,9 +835,9 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	if (ethqos->has_emac_ge_3)
 		plat_dat->dwmac4_addrs = &data->dwmac4_addrs;
 	plat_dat->pmt = 1;
-	if (of_property_read_bool(np, "snps,tso"))
+	if (device_property_present(dev, "snps,tso"))
 		plat_dat->flags |= STMMAC_FLAG_TSO_EN;
-	if (of_device_is_compatible(np, "qcom,qcs404-ethqos"))
+	if (device_is_compatible(dev, "qcom,qcs404-ethqos"))
 		plat_dat->flags |= STMMAC_FLAG_RX_CLK_RUNS_IN_LPI;
 	if (data->dma_addr_width)
 		plat_dat->host_dma_width = data->dma_addr_width;

-- 
2.51.0


