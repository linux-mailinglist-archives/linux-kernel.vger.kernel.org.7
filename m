Return-Path: <linux-kernel+bounces-887656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A4CC38D01
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 03:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 708F24F41E5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 02:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD932264AA;
	Thu,  6 Nov 2025 02:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="dbMNM1Wc"
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A62226D14;
	Thu,  6 Nov 2025 02:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762394892; cv=none; b=mLXNfsI123fT6F57EsPAFLxYnWFV544De6M9cek0Kih4ASr3EMMq6qiYQz3tFlWncXUFPBqsjHxH+ckKlJpmVBUJVU3uEpEpOHIuuOL1Ce3csimLlbjV+Nblg0gYO9yPQ8XwHjzQYqOB4bDCRhY+kXdwSA39753rXVb5d1RMdt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762394892; c=relaxed/simple;
	bh=RHowbImxlddsExia1PhBEdfrgYIGJqoTRZeTtfXTafQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=GjK9Z2vYR4sFq7rpVbZj4dLvFNeIvtqlSXFNAozx2iZGTdr/Ljen63Q5D2Fb5576Zu0W02cARiiYaV51ZEs9HtD+8SeoB4HIMGdOTNSzL89ToqKdggNZm3ZQ5gitfWH6s05iZlem71QHPIM826mYFNd/5d0qNi+IOEABtTS3gVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=dbMNM1Wc; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1762394831;
	bh=hbx/QURwIjeUHxXbRkGU120xvy1OzyC8WzA8ZpLbBU8=;
	h=From:To:Subject:Date:Message-Id;
	b=dbMNM1WcveNPRCNa+XdBH4Mgf/F0VHbSBQyfSdVE803JWmgojptyukcQt1+nWaFX6
	 3E1jAaXNr818MRUOQIQ8owxVyeDhlsi0Er56qHBGPlpFEdTOhuGvkcOzbgJNWLfQ80
	 AsFro4FFyWDnb9V9IqX3s0ngIZ+ZXhxal1q4+sc4=
X-QQ-mid: esmtpgz15t1762394829t0f07c30b
X-QQ-Originating-IP: QZPMgX2USNKo5HEA2++y4wEpyHyL9QH/EATI2ze4C+o=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Nov 2025 10:07:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4356867921177031121
From: Chaoyi Chen <kernel@airkyi.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-phy@lists.infradead.org,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Hongming Zou <hongming.zou@rock-chips.com>
Subject: [PATCH 7/9] drm/rockchip: dsi: Add support for rk3506
Date: Thu,  6 Nov 2025 10:06:30 +0800
Message-Id: <20251106020632.92-8-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251106020632.92-1-kernel@airkyi.com>
References: <20251106020632.92-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M7OGOwGJ/FwKEJNhnwTmktqSTqpPSEiEb4tzm1v004AAuRZv2UE0hzKK
	urqskMQaMtrJaOUrzCVyyKtPM1P1KQ2lcfVqw0v5vF/Ete7BZdPONjh8vrGe22hTnJmcUJi
	89SSxFIv/dNwKAugT6ry3rzoJoRD2khwH9nPUL/mmEKzFkCw12W9GQJ1mPDQwMUXhyEoyrF
	u2i6Pa5wKCzmwHqwUCd2XCN97v6j1+n9ZYmQGBVyWumSGDQ7qZYVuOKVpsbA+V1RyNBvSId
	tDvZFP518ZLfb4HmGS2b7YqI22Np/32EmiI/9MnHgjAAl/Av5QS9U9Z5nVxp5wAZZU2mP3d
	RMNp5hkZ1RCZjsCHXz5fBs7Wj/JlBe0YkivmnwweYjEyI89TtVOn2Zd2zp+GhMnLyHCbv8A
	/ZrQObm2zvP5MMsx0/wGDA4YBzcy5WeKIHt1AjEIxXniZ3Rnl0AUEXUk4Vyj++1Hjg7tx+y
	RPK58lmJJLhlmVgYFPs1OgyL5mnaavHx4zx4XVdw1tfQbKvyT/nvZOOD/SSBvfqSDVrrdjV
	wJ6xf5ifG1p7+lP1L9p3n/zqSVbbtZ9AVrPJc0OsPQ8aVf8wfGk221PKXEiuhBTrgvwPVgD
	f2WBj6WIFn7mSC9gmEvpfdby/m0piJDz2qUyQu6qhI9nuewO/62M1Fc6f1Oy6DM798/n60E
	O/QrqkxsuZ9o6mRGHvsrED+3CA0SfwiS3+okq63DPFEc4c9QX0fDBdaCQUItaeyOdrDSg9X
	E/qmwRmJA7dBP6xtkznXEJJKXelxHLiEuUAgH+tEheikZzIuKCDfjVgWqC2d0Y/UndBhHGZ
	McUeElQFh0JC1ouWR+ycH9hXLGhyyxsR6zgkhxd9d4M4MK/1k7UMoAkEXhs10yXapblKnXu
	MSU6G8smsVywpb3t7rxkPMJdfxpgGYkriDArOPoLBQ2rqMryIVNOWsfIDmbBJOYhX7nRGIB
	gOLvjovBqLFV1BvLQAWGv8EJhdsCMH1TrPZHZH++nau1Oli19Uot9vXqbDB3vEytn8Wg=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

The dsi controller found on RK3506 supports up to 2 lanes.

Signed-off-by: Hongming Zou <hongming.zou@rock-chips.com>
Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---
 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 5523911b990d..06e58cf287d3 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -192,6 +192,11 @@
 #define RK3568_DSI0_TURNDISABLE		BIT(2)
 #define RK3568_DSI0_FORCERXMODE		BIT(0)
 
+#define RK3506_SYS_GRF_SOC_CON6		0x0018
+#define RK3506_DSI_FORCETXSTOPMODE	(0xf << 4)
+#define RK3506_DSI_TURNDISABLE		BIT(2)
+#define RK3506_DSI_FORCERXMODE		BIT(0)
+
 /*
  * Note these registers do not appear in the datasheet, they are
  * however present in the BSP driver which is where these values
@@ -1643,6 +1648,18 @@ static const struct rockchip_dw_dsi_chip_data rk3399_chip_data[] = {
 	{ /* sentinel */ }
 };
 
+static const struct rockchip_dw_dsi_chip_data rk3506_chip_data[] = {
+	{
+		.reg = 0xff640000,
+		.lanecfg1_grf_reg = RK3506_SYS_GRF_SOC_CON6,
+		.lanecfg1 = (FIELD_PREP_WM16_CONST(RK3506_DSI_TURNDISABLE, 0) |
+			     FIELD_PREP_WM16_CONST(RK3506_DSI_FORCERXMODE, 0) |
+			     FIELD_PREP_WM16_CONST(RK3506_DSI_FORCETXSTOPMODE, 0)),
+		.max_data_lanes = 2,
+	},
+	{ /* sentinel */ }
+};
+
 static const struct rockchip_dw_dsi_chip_data rk3568_chip_data[] = {
 	{
 		.reg = 0xfe060000,
@@ -1690,6 +1707,9 @@ static const struct of_device_id dw_mipi_dsi_rockchip_dt_ids[] = {
 	}, {
 	 .compatible = "rockchip,rk3399-mipi-dsi",
 	 .data = &rk3399_chip_data,
+	}, {
+	 .compatible = "rockchip,rk3506-mipi-dsi",
+	 .data = &rk3506_chip_data,
 	}, {
 	 .compatible = "rockchip,rk3568-mipi-dsi",
 	 .data = &rk3568_chip_data,
-- 
2.51.1


