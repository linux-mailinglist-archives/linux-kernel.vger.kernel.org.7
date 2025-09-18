Return-Path: <linux-kernel+bounces-797318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7568B40EB9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCB6B16FE54
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C65935E4E3;
	Tue,  2 Sep 2025 20:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TNYkubYC"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF8A35E4C3
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 20:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756845906; cv=none; b=I+V91i00DoavL4D7OUsePVLzo5cQQELCxTucBSRq8DB4v1GC7bXl4ciNyvRHVyTLYIrZ2ARwkt0PuXkWOPWxcbF8tvBRoEZ8HL1FcjDHATrwhdw/g0oIEMkVXe3mxlmmXYyoRGVaGqApLO17vXfEq1t7pJu9qC/WmYqfA9Vyb5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756845906; c=relaxed/simple;
	bh=JNCtJ+xDdizKr2xXMcjoPILAI7WZEOPph298kz+XSto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kCwSz8yrevB1XPtCotxB3SqATYGrFEd8aRIs6WIOltRhVUb3Xwp6m+KQN6Ai1Rtugv1W9/o8/QMZr9Kz/akx4sSo4+SCxjQZn1bzui6Jl3tzeX3/6bq0T241yrvoqKRV4FNwtczLB+Z8VfPraPTsS+NE/Npnpsdci3OerBq11oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TNYkubYC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756845901;
	bh=JNCtJ+xDdizKr2xXMcjoPILAI7WZEOPph298kz+XSto=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TNYkubYCfIW8YY/a9C0HVGflEblFtmTuvjANhcZjwyzxBF4yyzQstb4vhxw2OGoLn
	 ylUefE+yrN8lN0vjS3JGurQ5xt/aIJnTrrAxa82MO9GEYnXW7ahiqWXv64E0MJDt6t
	 bDYhqRXDt3RxWzt/lz3bueVsDDEFbaHi12FPm36nliSTx2y6KgQpacKutRnT11sJcr
	 ZW8ypz2OHXpQh2L4XlGuoZNqFMpQJZZrIUtm3VBOvpMzvy+Gl2qkLzB4VTfcEJTxwj
	 z32lJj202h3NP5qKBMi8sPQF6zXdPBW26RH2j8e9oJeVjMVFT/bwa8W/keJ+44950n
	 WWjYhLajPyiUw==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 75C0917E0456;
	Tue,  2 Sep 2025 22:45:01 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 02 Sep 2025 23:44:46 +0300
Subject: [PATCH v4 11/11] phy: rockchip: samsung-hdptx: Add HDMI 2.1 FRL
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-phy-hdptx-frl-v4-11-7d69176373ce@collabora.com>
References: <20250902-phy-hdptx-frl-v4-0-7d69176373ce@collabora.com>
In-Reply-To: <20250902-phy-hdptx-frl-v4-0-7d69176373ce@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.14.2

The PHY is capable of handling four HDMI 2.1 Fixed Rate Link (FRL)
lanes, and each one can operate at any of the rates of 3Gbps, 6Gbps,
8Gbps, 10Gbps or 12Gbps.

Add the necessary driver changes to support the feature.

Co-developed-by: Algea Cao <algea.cao@rock-chips.com>
Signed-off-by: Algea Cao <algea.cao@rock-chips.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 459 ++++++++++++++++++++--
 1 file changed, 436 insertions(+), 23 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 048725544971ac4450c6e81f44c514ac320c7a55..a474400f4aa79bd15ac3378aebb9e94f54fe5e2b 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -22,6 +22,7 @@
 #include <linux/reset.h>
 
 #define GRF_HDPTX_CON0			0x00
+#define LC_REF_CLK_SEL			BIT(11)
 #define HDPTX_I_PLL_EN			BIT(7)
 #define HDPTX_I_BIAS_EN			BIT(6)
 #define HDPTX_I_BGR_EN			BIT(5)
@@ -322,6 +323,9 @@
 
 #define HDMI14_MAX_RATE			340000000
 #define HDMI20_MAX_RATE			600000000
+#define FRL_3G3L_RATE			900000000
+#define FRL_6G3L_RATE			1800000000
+#define FRL_8G4L_RATE			3200000000
 
 enum dp_link_rate {
 	DP_BW_RBR,
@@ -329,6 +333,37 @@ enum dp_link_rate {
 	DP_BW_HBR2,
 };
 
+struct lcpll_config {
+	unsigned long long rate;
+	u8 lcvco_mode_en;
+	u8 pi_en;
+	u8 clk_en_100m;
+	u8 pms_mdiv;
+	u8 pms_mdiv_afc;
+	u8 pms_pdiv;
+	u8 pms_refdiv;
+	u8 pms_sdiv;
+	u8 pi_cdiv_rstn;
+	u8 pi_cdiv_sel;
+	u8 sdm_en;
+	u8 sdm_rstn;
+	u8 sdc_frac_en;
+	u8 sdc_rstn;
+	u8 sdm_deno;
+	u8 sdm_num_sign;
+	u8 sdm_num;
+	u8 sdc_n;
+	u8 sdc_n2;
+	u8 sdc_num;
+	u8 sdc_deno;
+	u8 sdc_ndiv_rstn;
+	u8 ssc_en;
+	u8 ssc_fm_dev;
+	u8 ssc_fm_freq;
+	u8 ssc_clk_div_sel;
+	u8 cd_tx_ser_rate_sel;
+};
+
 struct ropll_config {
 	unsigned long long rate;
 	u8 pms_mdiv;
@@ -388,6 +423,7 @@ struct rk_hdptx_phy_cfg {
 };
 
 struct rk_hdptx_hdmi_cfg {
+	enum phy_hdmi_mode mode;
 	unsigned long long rate;
 	unsigned int bpc;
 };
@@ -415,6 +451,19 @@ struct rk_hdptx_phy {
 	unsigned int lanes;
 };
 
+static const struct lcpll_config rk_hdptx_frl_lcpll_cfg[] = {
+	{ 4800000000ULL, 1, 0, 0, 0x7d, 0x7d, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 2,
+	  0, 0x13, 0x18, 1, 0, 0x20, 0x0c, 1, 0, },
+	{ 4000000000ULL, 1, 1, 0, 0x68, 0x68, 1, 1, 0, 0, 0, 1, 1, 1, 1, 9, 0, 1, 1,
+	  0, 2, 3, 1, 0, 0x20, 0x0c, 1, 0, },
+	{ 2400000000ULL, 1, 0, 0, 0x7d, 0x7d, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 2,
+	  0, 0x13, 0x18, 1, 0, 0x20, 0x0c, 1, 0, },
+	{ 1800000000ULL, 1, 0, 0, 0x7d, 0x7d, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 2,
+	  0, 0x13, 0x18, 1, 0, 0x20, 0x0c, 1, 0, },
+	{ 900000000ULL, 1, 0, 0, 0x7d, 0x7d, 1, 1, 3, 0, 0, 0, 0, 1, 1, 1, 0, 0, 2,
+	  0, 0x13, 0x18, 1, 0, 0x20, 0x0c, 1, 0, },
+};
+
 static const struct ropll_config rk_hdptx_tmds_ropll_cfg[] = {
 	{ 594000000ULL, 124, 124, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
 	  1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
@@ -532,6 +581,110 @@ static const struct reg_sequence rk_hdptx_common_cmn_init_seq[] = {
 	REG_SEQ0(CMN_REG(009a), 0x11),
 };
 
+static const struct reg_sequence rk_hdptx_frl_lcpll_cmn_init_seq[] = {
+	REG_SEQ0(CMN_REG(0011), 0x00),
+	REG_SEQ0(CMN_REG(0017), 0x00),
+	REG_SEQ0(CMN_REG(0025), 0x10),
+	REG_SEQ0(CMN_REG(0026), 0x53),
+	REG_SEQ0(CMN_REG(0027), 0x01),
+	REG_SEQ0(CMN_REG(0028), 0x0d),
+	REG_SEQ0(CMN_REG(002e), 0x02),
+	REG_SEQ0(CMN_REG(002f), 0x0d),
+	REG_SEQ0(CMN_REG(0030), 0x00),
+	REG_SEQ0(CMN_REG(0031), 0x20),
+	REG_SEQ0(CMN_REG(0032), 0x30),
+	REG_SEQ0(CMN_REG(0033), 0x0b),
+	REG_SEQ0(CMN_REG(0034), 0x23),
+	REG_SEQ0(CMN_REG(003d), 0x00),
+	REG_SEQ0(CMN_REG(0042), 0xb8),
+	REG_SEQ0(CMN_REG(0046), 0xff),
+	REG_SEQ0(CMN_REG(0048), 0x44),
+	REG_SEQ0(CMN_REG(004e), 0x14),
+	REG_SEQ0(CMN_REG(0051), 0x00),
+	REG_SEQ0(CMN_REG(0055), 0x00),
+	REG_SEQ0(CMN_REG(0059), 0x11),
+	REG_SEQ0(CMN_REG(005a), 0x03),
+	REG_SEQ0(CMN_REG(005c), 0x05),
+	REG_SEQ0(CMN_REG(005d), 0x0c),
+	REG_SEQ0(CMN_REG(005e), 0x07),
+	REG_SEQ0(CMN_REG(0060), 0x01),
+	REG_SEQ0(CMN_REG(0064), 0x07),
+	REG_SEQ0(CMN_REG(0065), 0x00),
+	REG_SEQ0(CMN_REG(0069), 0x00),
+	REG_SEQ0(CMN_REG(006b), 0x04),
+	REG_SEQ0(CMN_REG(006c), 0x00),
+	REG_SEQ0(CMN_REG(0070), 0x01),
+	REG_SEQ0(CMN_REG(0073), 0x30),
+	REG_SEQ0(CMN_REG(0074), 0x00),
+	REG_SEQ0(CMN_REG(0081), 0x09),
+	REG_SEQ0(CMN_REG(0086), 0x01),
+	REG_SEQ0(CMN_REG(0087), 0x0c),
+	REG_SEQ0(CMN_REG(0089), 0x02),
+	REG_SEQ0(CMN_REG(0095), 0x00),
+	REG_SEQ0(CMN_REG(0097), 0x00),
+	REG_SEQ0(CMN_REG(0099), 0x00),
+	REG_SEQ0(CMN_REG(009b), 0x10),
+};
+
+static const struct reg_sequence rk_hdptx_frl_lcpll_ropll_cmn_init_seq[] = {
+	REG_SEQ0(CMN_REG(0008), 0xd0),
+	REG_SEQ0(CMN_REG(0011), 0x00),
+	REG_SEQ0(CMN_REG(0017), 0x00),
+	REG_SEQ0(CMN_REG(001e), 0x35),
+	REG_SEQ0(CMN_REG(0020), 0x6b),
+	REG_SEQ0(CMN_REG(0021), 0x6b),
+	REG_SEQ0(CMN_REG(0022), 0x11),
+	REG_SEQ0(CMN_REG(0024), 0x00),
+	REG_SEQ0(CMN_REG(0025), 0x10),
+	REG_SEQ0(CMN_REG(0026), 0x53),
+	REG_SEQ0(CMN_REG(0027), 0x15),
+	REG_SEQ0(CMN_REG(0028), 0x0d),
+	REG_SEQ0(CMN_REG(002a), 0x09),
+	REG_SEQ0(CMN_REG(002b), 0x01),
+	REG_SEQ0(CMN_REG(002c), 0x02),
+	REG_SEQ0(CMN_REG(002d), 0x02),
+	REG_SEQ0(CMN_REG(002e), 0x0d),
+	REG_SEQ0(CMN_REG(002f), 0x61),
+	REG_SEQ0(CMN_REG(0030), 0x00),
+	REG_SEQ0(CMN_REG(0031), 0x20),
+	REG_SEQ0(CMN_REG(0032), 0x30),
+	REG_SEQ0(CMN_REG(0033), 0x0b),
+	REG_SEQ0(CMN_REG(0034), 0x23),
+	REG_SEQ0(CMN_REG(0037), 0x00),
+	REG_SEQ0(CMN_REG(003d), 0xc0),
+	REG_SEQ0(CMN_REG(0042), 0xb8),
+	REG_SEQ0(CMN_REG(0046), 0xff),
+	REG_SEQ0(CMN_REG(0048), 0x44),
+	REG_SEQ0(CMN_REG(004e), 0x14),
+	REG_SEQ0(CMN_REG(0054), 0x19),
+	REG_SEQ0(CMN_REG(0058), 0x19),
+	REG_SEQ0(CMN_REG(0059), 0x11),
+	REG_SEQ0(CMN_REG(005b), 0x30),
+	REG_SEQ0(CMN_REG(005c), 0x25),
+	REG_SEQ0(CMN_REG(005d), 0x14),
+	REG_SEQ0(CMN_REG(005e), 0x0e),
+	REG_SEQ0(CMN_REG(0063), 0x01),
+	REG_SEQ0(CMN_REG(0064), 0x0e),
+	REG_SEQ0(CMN_REG(0068), 0x00),
+	REG_SEQ0(CMN_REG(0069), 0x02),
+	REG_SEQ0(CMN_REG(006b), 0x00),
+	REG_SEQ0(CMN_REG(006f), 0x00),
+	REG_SEQ0(CMN_REG(0073), 0x02),
+	REG_SEQ0(CMN_REG(0074), 0x00),
+	REG_SEQ0(CMN_REG(007a), 0x00),
+	REG_SEQ0(CMN_REG(0081), 0x09),
+	REG_SEQ0(CMN_REG(0086), 0x11),
+	REG_SEQ0(CMN_REG(0087), 0x0c),
+	REG_SEQ0(CMN_REG(0089), 0x00),
+	REG_SEQ0(CMN_REG(0095), 0x03),
+	REG_SEQ0(CMN_REG(0097), 0x00),
+	REG_SEQ0(CMN_REG(0099), 0x00),
+	REG_SEQ0(CMN_REG(009b), 0x10),
+	REG_SEQ0(CMN_REG(009e), 0x03),
+	REG_SEQ0(CMN_REG(009f), 0xff),
+	REG_SEQ0(CMN_REG(00a0), 0x60),
+};
+
 static const struct reg_sequence rk_hdptx_tmds_cmn_init_seq[] = {
 	REG_SEQ0(CMN_REG(0008), 0x00),
 	REG_SEQ0(CMN_REG(0011), 0x01),
@@ -585,6 +738,16 @@ static const struct reg_sequence rk_hdptx_common_sb_init_seq[] = {
 	REG_SEQ0(SB_REG(0117), 0x00),
 };
 
+static const struct reg_sequence rk_hdptx_frl_lntop_init_seq[] = {
+	REG_SEQ0(LNTOP_REG(0200), 0x04),
+	REG_SEQ0(LNTOP_REG(0201), 0x00),
+	REG_SEQ0(LNTOP_REG(0202), 0x00),
+	REG_SEQ0(LNTOP_REG(0203), 0xf0),
+	REG_SEQ0(LNTOP_REG(0204), 0xff),
+	REG_SEQ0(LNTOP_REG(0205), 0xff),
+	REG_SEQ0(LNTOP_REG(0206), 0x05),
+};
+
 static const struct reg_sequence rk_hdptx_tmds_lntop_highbr_seq[] = {
 	REG_SEQ0(LNTOP_REG(0201), 0x00),
 	REG_SEQ0(LNTOP_REG(0202), 0x00),
@@ -656,6 +819,38 @@ static const struct reg_sequence rk_hdptx_common_lane_init_seq[] = {
 	REG_SEQ0(LANE_REG(0620), 0xa0),
 };
 
+static const struct reg_sequence rk_hdptx_frl_lane_init_seq[] = {
+	REG_SEQ0(LANE_REG(0312), 0x3c),
+	REG_SEQ0(LANE_REG(0412), 0x3c),
+	REG_SEQ0(LANE_REG(0512), 0x3c),
+	REG_SEQ0(LANE_REG(0612), 0x3c),
+	REG_SEQ0(LANE_REG(0303), 0x2f),
+	REG_SEQ0(LANE_REG(0403), 0x2f),
+	REG_SEQ0(LANE_REG(0503), 0x2f),
+	REG_SEQ0(LANE_REG(0603), 0x2f),
+	REG_SEQ0(LANE_REG(0305), 0x03),
+	REG_SEQ0(LANE_REG(0405), 0x03),
+	REG_SEQ0(LANE_REG(0505), 0x03),
+	REG_SEQ0(LANE_REG(0605), 0x03),
+	REG_SEQ0(LANE_REG(0306), 0xfc),
+	REG_SEQ0(LANE_REG(0406), 0xfc),
+	REG_SEQ0(LANE_REG(0506), 0xfc),
+	REG_SEQ0(LANE_REG(0606), 0xfc),
+	REG_SEQ0(LANE_REG(0305), 0x4f),
+	REG_SEQ0(LANE_REG(0405), 0x4f),
+	REG_SEQ0(LANE_REG(0505), 0x4f),
+	REG_SEQ0(LANE_REG(0605), 0x4f),
+	REG_SEQ0(LANE_REG(0304), 0x14),
+	REG_SEQ0(LANE_REG(0404), 0x14),
+	REG_SEQ0(LANE_REG(0504), 0x14),
+	REG_SEQ0(LANE_REG(0604), 0x14),
+	/* Keep Inter-Pair Skew in the limits */
+	REG_SEQ0(LANE_REG(031e), 0x02),
+	REG_SEQ0(LANE_REG(041e), 0x02),
+	REG_SEQ0(LANE_REG(051e), 0x02),
+	REG_SEQ0(LANE_REG(061e), 0x02),
+};
+
 static const struct reg_sequence rk_hdptx_tmds_lane_init_seq[] = {
 	REG_SEQ0(LANE_REG(0312), 0x00),
 	REG_SEQ0(LANE_REG(0412), 0x00),
@@ -819,7 +1014,12 @@ static int rk_hdptx_post_enable_lane(struct rk_hdptx_phy *hdptx)
 	       HDPTX_I_BIAS_EN | HDPTX_I_BGR_EN;
 	regmap_write(hdptx->grf, GRF_HDPTX_CON0, val);
 
-	regmap_write(hdptx->regmap, LNTOP_REG(0207), 0x0f);
+	/* 3 lanes FRL mode */
+	if (hdptx->hdmi_cfg.rate == FRL_6G3L_RATE ||
+	    hdptx->hdmi_cfg.rate == FRL_3G3L_RATE)
+		regmap_write(hdptx->regmap, LNTOP_REG(0207), 0x07);
+	else
+		regmap_write(hdptx->regmap, LNTOP_REG(0207), 0x0f);
 
 	ret = regmap_read_poll_timeout(hdptx->grf, GRF_HDPTX_STATUS, val,
 				       (val & HDPTX_O_PHY_RDY) &&
@@ -963,6 +1163,80 @@ static bool rk_hdptx_phy_clk_pll_calc(unsigned long long rate,
 	return true;
 }
 
+static int rk_hdptx_frl_lcpll_cmn_config(struct rk_hdptx_phy *hdptx)
+{
+	const struct lcpll_config *cfg = NULL;
+	int i;
+
+	dev_dbg(hdptx->dev, "%s rate=%llu\n", __func__, hdptx->hdmi_cfg.rate);
+
+	for (i = 0; i < ARRAY_SIZE(rk_hdptx_frl_lcpll_cfg); i++) {
+		if (hdptx->hdmi_cfg.rate == rk_hdptx_frl_lcpll_cfg[i].rate) {
+			cfg = &rk_hdptx_frl_lcpll_cfg[i];
+			break;
+		}
+	}
+
+	if (!cfg) {
+		dev_err(hdptx->dev, "%s cannot find pll cfg for rate=%llu\n",
+			__func__, hdptx->hdmi_cfg.rate);
+		return -EINVAL;
+	}
+
+	rk_hdptx_pre_power_up(hdptx);
+
+	regmap_write(hdptx->grf, GRF_HDPTX_CON0, LC_REF_CLK_SEL << 16);
+
+	rk_hdptx_multi_reg_write(hdptx, rk_hdptx_common_cmn_init_seq);
+	rk_hdptx_multi_reg_write(hdptx, rk_hdptx_frl_lcpll_cmn_init_seq);
+
+	regmap_update_bits(hdptx->regmap, CMN_REG(0008),
+			   LCPLL_EN_MASK | LCPLL_LCVCO_MODE_EN_MASK,
+			   FIELD_PREP(LCPLL_EN_MASK, 1) |
+			   FIELD_PREP(LCPLL_LCVCO_MODE_EN_MASK, cfg->lcvco_mode_en));
+
+	regmap_update_bits(hdptx->regmap, CMN_REG(001e),
+			   LCPLL_PI_EN_MASK | LCPLL_100M_CLK_EN_MASK,
+			   FIELD_PREP(LCPLL_PI_EN_MASK, cfg->pi_en) |
+			   FIELD_PREP(LCPLL_100M_CLK_EN_MASK, cfg->clk_en_100m));
+
+	regmap_write(hdptx->regmap, CMN_REG(0020), cfg->pms_mdiv);
+	regmap_write(hdptx->regmap, CMN_REG(0021), cfg->pms_mdiv_afc);
+	regmap_write(hdptx->regmap, CMN_REG(0022),
+		     (cfg->pms_pdiv << 4) | cfg->pms_refdiv);
+	regmap_write(hdptx->regmap, CMN_REG(0023),
+		     (cfg->pms_sdiv << 4) | cfg->pms_sdiv);
+	regmap_write(hdptx->regmap, CMN_REG(002a), cfg->sdm_deno);
+	regmap_write(hdptx->regmap, CMN_REG(002b), cfg->sdm_num_sign);
+	regmap_write(hdptx->regmap, CMN_REG(002c), cfg->sdm_num);
+
+	regmap_update_bits(hdptx->regmap, CMN_REG(002d), LCPLL_SDC_N_MASK,
+			   FIELD_PREP(LCPLL_SDC_N_MASK, cfg->sdc_n));
+
+	regmap_update_bits(hdptx->regmap, CMN_REG(0086), PLL_PCG_POSTDIV_SEL_MASK,
+			   FIELD_PREP(PLL_PCG_POSTDIV_SEL_MASK, cfg->pms_sdiv));
+	regmap_update_bits(hdptx->regmap, CMN_REG(0086), PLL_PCG_CLK_SEL_MASK,
+			   FIELD_PREP(PLL_PCG_CLK_SEL_MASK, (hdptx->hdmi_cfg.bpc - 8) >> 1));
+
+	return rk_hdptx_post_enable_pll(hdptx);
+}
+
+static int rk_hdptx_frl_lcpll_ropll_cmn_config(struct rk_hdptx_phy *hdptx)
+{
+	dev_dbg(hdptx->dev, "%s rate=%llu\n", __func__, hdptx->hdmi_cfg.rate);
+
+	rk_hdptx_pre_power_up(hdptx);
+
+	/* ROPLL input reference clock from LCPLL (cascade mode) */
+	regmap_write(hdptx->grf, GRF_HDPTX_CON0,
+		     (LC_REF_CLK_SEL << 16) | LC_REF_CLK_SEL);
+
+	rk_hdptx_multi_reg_write(hdptx, rk_hdptx_common_cmn_init_seq);
+	rk_hdptx_multi_reg_write(hdptx, rk_hdptx_frl_lcpll_ropll_cmn_init_seq);
+
+	return rk_hdptx_post_enable_pll(hdptx);
+}
+
 static int rk_hdptx_tmds_ropll_cmn_config(struct rk_hdptx_phy *hdptx)
 {
 	const struct ropll_config *cfg = NULL;
@@ -994,6 +1268,8 @@ static int rk_hdptx_tmds_ropll_cmn_config(struct rk_hdptx_phy *hdptx)
 
 	rk_hdptx_pre_power_up(hdptx);
 
+	regmap_write(hdptx->grf, GRF_HDPTX_CON0, LC_REF_CLK_SEL << 16);
+
 	rk_hdptx_multi_reg_write(hdptx, rk_hdptx_common_cmn_init_seq);
 	rk_hdptx_multi_reg_write(hdptx, rk_hdptx_tmds_cmn_init_seq);
 
@@ -1032,6 +1308,28 @@ static int rk_hdptx_tmds_ropll_cmn_config(struct rk_hdptx_phy *hdptx)
 	return rk_hdptx_post_enable_pll(hdptx);
 }
 
+static int rk_hdptx_pll_cmn_config(struct rk_hdptx_phy *hdptx)
+{
+	if (hdptx->hdmi_cfg.rate <= HDMI20_MAX_RATE)
+		return rk_hdptx_tmds_ropll_cmn_config(hdptx);
+
+	if (hdptx->hdmi_cfg.rate == FRL_8G4L_RATE)
+		return rk_hdptx_frl_lcpll_ropll_cmn_config(hdptx);
+
+	return rk_hdptx_frl_lcpll_cmn_config(hdptx);
+}
+
+static int rk_hdptx_frl_lcpll_mode_config(struct rk_hdptx_phy *hdptx)
+{
+	rk_hdptx_multi_reg_write(hdptx, rk_hdptx_common_sb_init_seq);
+	rk_hdptx_multi_reg_write(hdptx, rk_hdptx_frl_lntop_init_seq);
+
+	rk_hdptx_multi_reg_write(hdptx, rk_hdptx_common_lane_init_seq);
+	rk_hdptx_multi_reg_write(hdptx, rk_hdptx_frl_lane_init_seq);
+
+	return rk_hdptx_post_enable_lane(hdptx);
+}
+
 static int rk_hdptx_tmds_ropll_mode_config(struct rk_hdptx_phy *hdptx)
 {
 	rk_hdptx_multi_reg_write(hdptx, rk_hdptx_common_sb_init_seq);
@@ -1108,7 +1406,7 @@ static int rk_hdptx_phy_consumer_get(struct rk_hdptx_phy *hdptx)
 	if (mode == PHY_MODE_DP) {
 		rk_hdptx_dp_reset(hdptx);
 	} else {
-		ret = rk_hdptx_tmds_ropll_cmn_config(hdptx);
+		ret = rk_hdptx_pll_cmn_config(hdptx);
 		if (ret)
 			goto dec_usage;
 	}
@@ -1409,7 +1707,7 @@ static int rk_hdptx_phy_power_on(struct phy *phy)
 	int ret, lane;
 
 	if (mode != PHY_MODE_DP) {
-		if (!hdptx->hdmi_cfg.rate) {
+		if (!hdptx->hdmi_cfg.rate && hdptx->hdmi_cfg.mode != PHY_HDMI_MODE_FRL) {
 			/*
 			 * FIXME: Temporary workaround to setup TMDS char rate
 			 * from the RK DW HDMI QP bridge driver.
@@ -1455,7 +1753,11 @@ static int rk_hdptx_phy_power_on(struct phy *phy)
 		regmap_write(hdptx->grf, GRF_HDPTX_CON0,
 			     HDPTX_MODE_SEL << 16 | FIELD_PREP(HDPTX_MODE_SEL, 0x0));
 
-		ret = rk_hdptx_tmds_ropll_mode_config(hdptx);
+		if (hdptx->hdmi_cfg.mode == PHY_HDMI_MODE_FRL)
+			ret = rk_hdptx_frl_lcpll_mode_config(hdptx);
+		else
+			ret = rk_hdptx_tmds_ropll_mode_config(hdptx);
+
 		if (ret)
 			rk_hdptx_phy_consumer_put(hdptx, true);
 	}
@@ -1476,16 +1778,49 @@ static int rk_hdptx_phy_verify_hdmi_config(struct rk_hdptx_phy *hdptx,
 {
 	int i;
 
-	if (!hdmi_in->tmds_char_rate || hdmi_in->tmds_char_rate > HDMI20_MAX_RATE)
-		return -EINVAL;
+	if (hdptx->hdmi_cfg.mode == PHY_HDMI_MODE_FRL) {
+		unsigned long long frl_rate = 100000000ULL * hdmi_in->frl.lanes *
+					      hdmi_in->frl.rate_per_lane;
 
-	for (i = 0; i < ARRAY_SIZE(rk_hdptx_tmds_ropll_cfg); i++)
-		if (hdmi_in->tmds_char_rate == rk_hdptx_tmds_ropll_cfg[i].rate)
+		switch (hdmi_in->frl.rate_per_lane) {
+		case 3:
+		case 6:
+		case 8:
+		case 10:
+		case 12:
 			break;
+		default:
+			return -EINVAL;
+		}
 
-	if (i == ARRAY_SIZE(rk_hdptx_tmds_ropll_cfg) &&
-	    !rk_hdptx_phy_clk_pll_calc(hdmi_in->tmds_char_rate, NULL))
-		return -EINVAL;
+		if (!hdmi_in->frl.lanes || hdmi_in->frl.lanes > 4)
+			return -EINVAL;
+
+		if (frl_rate != FRL_8G4L_RATE) {
+			for (i = 0; i < ARRAY_SIZE(rk_hdptx_frl_lcpll_cfg); i++)
+				if (frl_rate == rk_hdptx_frl_lcpll_cfg[i].rate)
+					break;
+			if (i == ARRAY_SIZE(rk_hdptx_frl_lcpll_cfg))
+				return -EINVAL;
+		}
+
+		if (hdmi_out)
+			hdmi_out->rate = frl_rate;
+	} else {
+		if (!hdmi_in->tmds_char_rate || hdmi_in->tmds_char_rate > HDMI20_MAX_RATE)
+			return -EINVAL;
+
+		for (i = 0; i < ARRAY_SIZE(rk_hdptx_tmds_ropll_cfg); i++)
+			if (hdmi_in->tmds_char_rate == rk_hdptx_tmds_ropll_cfg[i].rate)
+				break;
+
+		if (i == ARRAY_SIZE(rk_hdptx_tmds_ropll_cfg) &&
+		    !rk_hdptx_phy_clk_pll_calc(hdmi_in->tmds_char_rate, NULL))
+			return -EINVAL;
+
+		if (hdmi_out)
+			hdmi_out->rate = hdmi_in->tmds_char_rate;
+	}
 
 	switch (hdmi_in->bpc) {
 	case 0:
@@ -1498,10 +1833,8 @@ static int rk_hdptx_phy_verify_hdmi_config(struct rk_hdptx_phy *hdptx,
 		return -EINVAL;
 	}
 
-	if (hdmi_out) {
-		hdmi_out->rate = hdmi_in->tmds_char_rate;
+	if (hdmi_out)
 		hdmi_out->bpc = hdmi_in->bpc ?: 8;
-	}
 
 	return 0;
 }
@@ -1761,6 +2094,31 @@ static int rk_hdptx_phy_set_voltages(struct rk_hdptx_phy *hdptx,
 	return 0;
 }
 
+static int rk_hdptx_phy_set_mode(struct phy *phy, enum phy_mode mode, int submode)
+{
+	struct rk_hdptx_phy *hdptx = phy_get_drvdata(phy);
+
+	if (mode == PHY_MODE_DP)
+		return 0;
+
+	if (mode != PHY_MODE_HDMI) {
+		dev_err(&phy->dev, "invalid PHY mode: %d\n", mode);
+		return -EINVAL;
+	}
+
+	switch (submode) {
+	case PHY_HDMI_MODE_TMDS:
+	case PHY_HDMI_MODE_FRL:
+		hdptx->hdmi_cfg.mode = submode;
+		break;
+	default:
+		dev_err(&phy->dev, "invalid HDMI mode: %d\n", submode);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int rk_hdptx_phy_configure(struct phy *phy, union phy_configure_opts *opts)
 {
 	struct rk_hdptx_phy *hdptx = phy_get_drvdata(phy);
@@ -1828,6 +2186,7 @@ static int rk_hdptx_phy_validate(struct phy *phy, enum phy_mode mode,
 static const struct phy_ops rk_hdptx_phy_ops = {
 	.power_on  = rk_hdptx_phy_power_on,
 	.power_off = rk_hdptx_phy_power_off,
+	.set_mode = rk_hdptx_phy_set_mode,
 	.configure = rk_hdptx_phy_configure,
 	.validate  = rk_hdptx_phy_validate,
 	.owner	   = THIS_MODULE,
@@ -1856,17 +2215,62 @@ static void rk_hdptx_phy_clk_unprepare(struct clk_hw *hw)
 
 static u64 rk_hdptx_phy_clk_calc_rate_from_pll_cfg(struct rk_hdptx_phy *hdptx)
 {
+	struct lcpll_config lcpll_hw;
 	struct ropll_config ropll_hw;
 	u64 fout, sdm;
 	u32 mode, val;
-	int ret;
+	int ret, i;
 
 	ret = regmap_read(hdptx->regmap, CMN_REG(0008), &mode);
 	if (ret)
 		return 0;
 
-	if (mode & LCPLL_LCVCO_MODE_EN_MASK)
+	if (mode & LCPLL_LCVCO_MODE_EN_MASK) {
+		ret = regmap_read(hdptx->regmap, CMN_REG(0020), &val);
+		if (ret)
+			return 0;
+		lcpll_hw.pms_mdiv = val;
+
+		ret = regmap_read(hdptx->regmap, CMN_REG(0023), &val);
+		if (ret)
+			return 0;
+		lcpll_hw.pms_sdiv = val & 0xf;
+
+		ret = regmap_read(hdptx->regmap, CMN_REG(002B), &val);
+		if (ret)
+			return 0;
+		lcpll_hw.sdm_num_sign = val;
+
+		ret = regmap_read(hdptx->regmap, CMN_REG(002C), &val);
+		if (ret)
+			return 0;
+		lcpll_hw.sdm_num = val;
+
+		ret = regmap_read(hdptx->regmap, CMN_REG(002A), &val);
+		if (ret)
+			return 0;
+		lcpll_hw.sdm_deno = val;
+
+		ret = regmap_read(hdptx->regmap, CMN_REG(002D), &val);
+		if (ret)
+			return 0;
+		lcpll_hw.sdc_n = (val & LCPLL_SDC_N_MASK) >> 1;
+
+		for (i = 0; i < ARRAY_SIZE(rk_hdptx_frl_lcpll_cfg); i++) {
+			const struct lcpll_config *cfg = &rk_hdptx_frl_lcpll_cfg[i];
+
+			if (cfg->pms_mdiv == lcpll_hw.pms_mdiv &&
+			    cfg->pms_sdiv == lcpll_hw.pms_sdiv &&
+			    cfg->sdm_num_sign == lcpll_hw.sdm_num_sign &&
+			    cfg->sdm_num == lcpll_hw.sdm_num &&
+			    cfg->sdm_deno == lcpll_hw.sdm_deno &&
+			    cfg->sdc_n == lcpll_hw.sdc_n)
+				return cfg->rate;
+		}
+
+		dev_dbg(hdptx->dev, "%s no FRL match found\n", __func__);
 		return 0;
+	}
 
 	ret = regmap_read(hdptx->regmap, CMN_REG(0051), &val);
 	if (ret)
@@ -1943,6 +2347,9 @@ static unsigned long rk_hdptx_phy_clk_recalc_rate(struct clk_hw *hw,
 
 	rate = rk_hdptx_phy_clk_calc_rate_from_pll_cfg(hdptx);
 
+	if (hdptx->hdmi_cfg.mode == PHY_HDMI_MODE_FRL)
+		return rate;
+
 	return DIV_ROUND_CLOSEST_ULL(rate * 8, hdptx->hdmi_cfg.bpc);
 }
 
@@ -1951,6 +2358,9 @@ static long rk_hdptx_phy_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct rk_hdptx_phy *hdptx = to_rk_hdptx_phy(hw);
 
+	if (hdptx->hdmi_cfg.mode == PHY_HDMI_MODE_FRL)
+		return hdptx->hdmi_cfg.rate;
+
 	/*
 	 * FIXME: Temporarily allow altering TMDS char rate via CCF.
 	 * To be dropped as soon as the RK DW HDMI QP bridge driver
@@ -1979,23 +2389,26 @@ static int rk_hdptx_phy_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 				     unsigned long parent_rate)
 {
 	struct rk_hdptx_phy *hdptx = to_rk_hdptx_phy(hw);
-	unsigned long long tmds_rate = DIV_ROUND_CLOSEST_ULL(rate * hdptx->hdmi_cfg.bpc, 8);
+	unsigned long long link_rate = rate;
+
+	if (hdptx->hdmi_cfg.mode != PHY_HDMI_MODE_FRL)
+		link_rate = DIV_ROUND_CLOSEST_ULL(rate * hdptx->hdmi_cfg.bpc, 8);
 
-	/* Revert any unlikely TMDS char rate change since round_rate() */
-	if (hdptx->hdmi_cfg.rate != tmds_rate) {
+	/* Revert any unlikely link rate change since round_rate() */
+	if (hdptx->hdmi_cfg.rate != link_rate) {
 		dev_warn(hdptx->dev, "Reverting unexpected rate change from %llu to %llu\n",
-			 tmds_rate, hdptx->hdmi_cfg.rate);
-		hdptx->hdmi_cfg.rate = tmds_rate;
+			 link_rate, hdptx->hdmi_cfg.rate);
+		hdptx->hdmi_cfg.rate = link_rate;
 	}
 
 	/*
-	 * The TMDS char rate would be normally programmed in HW during
+	 * The link rate would be normally programmed in HW during
 	 * phy_ops.power_on() or clk_ops.prepare() callbacks, but it might
 	 * happen that the former gets fired too late, i.e. after this call,
 	 * while the latter being executed only once, i.e. when clock remains
 	 * in the prepared state during rate changes.
 	 */
-	return rk_hdptx_tmds_ropll_cmn_config(hdptx);
+	return rk_hdptx_pll_cmn_config(hdptx);
 }
 
 static const struct clk_ops hdptx_phy_clk_ops = {

-- 
2.51.0


