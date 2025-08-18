Return-Path: <linux-kernel+bounces-774317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D66B2B11A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA29686607
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA95338F2A;
	Mon, 18 Aug 2025 18:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AmG4cvHG"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7203731195F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543569; cv=none; b=lyJhN7H/Yr22oNU0ocKq4cjqWMRmglXv4BuNubBt3ro+YD7Vh/5bhIcfQKK6j5D0WjYsEKlWdKxNN3E5tHHkhmK77C3aLskkX72YAhPEpkw08k2q4PGdiUo2sQsO5TW3RepwwQ/x2UXzEWJjBIBcHStNyedhNvuvO7CPwc14mbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543569; c=relaxed/simple;
	bh=el3xrYwaVGQefWYaDxmiTe5W3BPJzshwsEXNIOoIpTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nk0K0DoAOV22mFD219mz+gzuRpESK/kwMXfnNl/em29tFqjwvW7ENWY111yXmGxmMsBoWWtbtHAEg7qXuLbRzBsi1NZ7FOPPitwAWGnEtNLCIBG9KrBtDYDLjZ0KVaSS0e4bQjZb1fAdkPGSkZn+SN3beNJomlVgUSYmC88zGyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AmG4cvHG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755543565;
	bh=el3xrYwaVGQefWYaDxmiTe5W3BPJzshwsEXNIOoIpTk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AmG4cvHGiZM7vgoJFSmTySGogdafj/gIAlVi1eZNmSEOr5iqnAfw7XGJWNW+VRmFW
	 GUEFCUqNrlTwfGcAzG8PL3r298PnlugN6DXuiIHGd1ITgidqOBsXunjbLcr5TXDJjW
	 msdq/L8lSMAuYIOZvojLMxQBoXEn+GRZdE1p89OGh3gyY1jc04XJiO45VxPzyXbSAP
	 LaIEkFslDkQwtLDtHE4wwOJSuJ+i9W91Z4GaLYlQJ11n8wFI7ML5SV7Y3nQv9w4x/R
	 rvH6xHJ7wow3lx2KiVxY0UwU8bVoDUWoGYqtegZcdMpYA30+oFasxAgJ/31vpfwJcs
	 ds0d+p/0Bq4lA==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 89F6917E04C0;
	Mon, 18 Aug 2025 20:59:25 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Mon, 18 Aug 2025 21:59:07 +0300
Subject: [PATCH v3 07/14] phy: rockchip: samsung-hdptx: Consistently use
 [rk_]hdptx_[tmds_] prefixes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-phy-hdptx-frl-v3-7-c79997d8bb2b@collabora.com>
References: <20250818-phy-hdptx-frl-v3-0-c79997d8bb2b@collabora.com>
In-Reply-To: <20250818-phy-hdptx-frl-v3-0-c79997d8bb2b@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.14.2

Fix the naming inconsistencies for some of the functions and global
variables:

* Add the missing 'rk_hdptx_' prefix to ropll_tmds_cfg variable
* Replace '_ropll_tmds_' with '_tmds_ropll_' globally
* Replace 'hdtpx' with 'hdptx' globally

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 62 +++++++++++------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 495427fc44b385e23da02cd21eefdb137d8b5fdb..f2202b1195e7f24c455acdfa9bf2482ddddd6866 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -32,17 +32,17 @@
 #define HDPTX_O_PHY_RDY			BIT(1)
 #define HDPTX_O_SB_RDY			BIT(0)
 
-#define HDTPX_REG(_n, _min, _max)				\
+#define HDPTX_REG(_n, _min, _max)				\
 	(							\
 		BUILD_BUG_ON_ZERO((0x##_n) < (0x##_min)) +	\
 		BUILD_BUG_ON_ZERO((0x##_n) > (0x##_max)) +	\
 		((0x##_n) * 4)					\
 	)
 
-#define CMN_REG(n)			HDTPX_REG(n, 0000, 00a7)
-#define SB_REG(n)			HDTPX_REG(n, 0100, 0129)
-#define LNTOP_REG(n)			HDTPX_REG(n, 0200, 0229)
-#define LANE_REG(n)			HDTPX_REG(n, 0300, 062d)
+#define CMN_REG(n)			HDPTX_REG(n, 0000, 00a7)
+#define SB_REG(n)			HDPTX_REG(n, 0100, 0129)
+#define LNTOP_REG(n)			HDPTX_REG(n, 0200, 0229)
+#define LANE_REG(n)			HDPTX_REG(n, 0300, 062d)
 
 /* CMN_REG(0008) */
 #define OVRD_LCPLL_EN_MASK		BIT(7)
@@ -411,7 +411,7 @@ struct rk_hdptx_phy {
 	unsigned int lanes;
 };
 
-static const struct ropll_config ropll_tmds_cfg[] = {
+static const struct ropll_config rk_hdptx_tmds_ropll_cfg[] = {
 	{ 594000000ULL, 124, 124, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
 	  1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
 	{ 371250000ULL, 155, 155, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
@@ -456,7 +456,7 @@ static const struct ropll_config ropll_tmds_cfg[] = {
 	  1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
 };
 
-static const struct reg_sequence rk_hdtpx_common_cmn_init_seq[] = {
+static const struct reg_sequence rk_hdptx_common_cmn_init_seq[] = {
 	REG_SEQ0(CMN_REG(0009), 0x0c),
 	REG_SEQ0(CMN_REG(000a), 0x83),
 	REG_SEQ0(CMN_REG(000b), 0x06),
@@ -546,7 +546,7 @@ static const struct reg_sequence rk_hdtpx_common_cmn_init_seq[] = {
 	REG_SEQ0(CMN_REG(009b), 0x10),
 };
 
-static const struct reg_sequence rk_hdtpx_tmds_cmn_init_seq[] = {
+static const struct reg_sequence rk_hdptx_tmds_cmn_init_seq[] = {
 	REG_SEQ0(CMN_REG(0008), 0x00),
 	REG_SEQ0(CMN_REG(0011), 0x01),
 	REG_SEQ0(CMN_REG(0017), 0x20),
@@ -588,14 +588,14 @@ static const struct reg_sequence rk_hdtpx_tmds_cmn_init_seq[] = {
 	REG_SEQ0(CMN_REG(009b), 0x00),
 };
 
-static const struct reg_sequence rk_hdtpx_common_sb_init_seq[] = {
+static const struct reg_sequence rk_hdptx_common_sb_init_seq[] = {
 	REG_SEQ0(SB_REG(0114), 0x00),
 	REG_SEQ0(SB_REG(0115), 0x00),
 	REG_SEQ0(SB_REG(0116), 0x00),
 	REG_SEQ0(SB_REG(0117), 0x00),
 };
 
-static const struct reg_sequence rk_hdtpx_tmds_lntop_highbr_seq[] = {
+static const struct reg_sequence rk_hdptx_tmds_lntop_highbr_seq[] = {
 	REG_SEQ0(LNTOP_REG(0201), 0x00),
 	REG_SEQ0(LNTOP_REG(0202), 0x00),
 	REG_SEQ0(LNTOP_REG(0203), 0x0f),
@@ -603,7 +603,7 @@ static const struct reg_sequence rk_hdtpx_tmds_lntop_highbr_seq[] = {
 	REG_SEQ0(LNTOP_REG(0205), 0xff),
 };
 
-static const struct reg_sequence rk_hdtpx_tmds_lntop_lowbr_seq[] = {
+static const struct reg_sequence rk_hdptx_tmds_lntop_lowbr_seq[] = {
 	REG_SEQ0(LNTOP_REG(0201), 0x07),
 	REG_SEQ0(LNTOP_REG(0202), 0xc1),
 	REG_SEQ0(LNTOP_REG(0203), 0xf0),
@@ -611,7 +611,7 @@ static const struct reg_sequence rk_hdtpx_tmds_lntop_lowbr_seq[] = {
 	REG_SEQ0(LNTOP_REG(0205), 0x1f),
 };
 
-static const struct reg_sequence rk_hdtpx_common_lane_init_seq[] = {
+static const struct reg_sequence rk_hdptx_common_lane_init_seq[] = {
 	REG_SEQ0(LANE_REG(0303), 0x0c),
 	REG_SEQ0(LANE_REG(0307), 0x20),
 	REG_SEQ0(LANE_REG(030a), 0x17),
@@ -666,7 +666,7 @@ static const struct reg_sequence rk_hdtpx_common_lane_init_seq[] = {
 	REG_SEQ0(LANE_REG(0620), 0xa0),
 };
 
-static const struct reg_sequence rk_hdtpx_tmds_lane_init_seq[] = {
+static const struct reg_sequence rk_hdptx_tmds_lane_init_seq[] = {
 	REG_SEQ0(LANE_REG(0312), 0x00),
 	REG_SEQ0(LANE_REG(0412), 0x00),
 	REG_SEQ0(LANE_REG(0512), 0x00),
@@ -971,7 +971,7 @@ static bool rk_hdptx_phy_clk_pll_calc(unsigned long long rate,
 	return true;
 }
 
-static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx)
+static int rk_hdptx_tmds_ropll_cmn_config(struct rk_hdptx_phy *hdptx)
 {
 	const struct ropll_config *cfg = NULL;
 	struct ropll_config rc = {0};
@@ -980,9 +980,9 @@ static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx)
 	if (!hdptx->hdmi_cfg.tmds_char_rate)
 		return 0;
 
-	for (i = 0; i < ARRAY_SIZE(ropll_tmds_cfg); i++)
-		if (hdptx->hdmi_cfg.tmds_char_rate == ropll_tmds_cfg[i].rate) {
-			cfg = &ropll_tmds_cfg[i];
+	for (i = 0; i < ARRAY_SIZE(rk_hdptx_tmds_ropll_cfg); i++)
+		if (hdptx->hdmi_cfg.tmds_char_rate == rk_hdptx_tmds_ropll_cfg[i].rate) {
+			cfg = &rk_hdptx_tmds_ropll_cfg[i];
 			break;
 		}
 
@@ -1002,8 +1002,8 @@ static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx)
 
 	rk_hdptx_pre_power_up(hdptx);
 
-	rk_hdptx_multi_reg_write(hdptx, rk_hdtpx_common_cmn_init_seq);
-	rk_hdptx_multi_reg_write(hdptx, rk_hdtpx_tmds_cmn_init_seq);
+	rk_hdptx_multi_reg_write(hdptx, rk_hdptx_common_cmn_init_seq);
+	rk_hdptx_multi_reg_write(hdptx, rk_hdptx_tmds_cmn_init_seq);
 
 	regmap_write(hdptx->regmap, CMN_REG(0051), cfg->pms_mdiv);
 	regmap_write(hdptx->regmap, CMN_REG(0055), cfg->pms_mdiv_afc);
@@ -1045,25 +1045,25 @@ static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx)
 	return ret;
 }
 
-static int rk_hdptx_ropll_tmds_mode_config(struct rk_hdptx_phy *hdptx)
+static int rk_hdptx_tmds_ropll_mode_config(struct rk_hdptx_phy *hdptx)
 {
-	rk_hdptx_multi_reg_write(hdptx, rk_hdtpx_common_sb_init_seq);
+	rk_hdptx_multi_reg_write(hdptx, rk_hdptx_common_sb_init_seq);
 
 	regmap_write(hdptx->regmap, LNTOP_REG(0200), 0x06);
 
 	if (hdptx->hdmi_cfg.tmds_char_rate > HDMI14_MAX_RATE) {
 		/* For 1/40 bitrate clk */
-		rk_hdptx_multi_reg_write(hdptx, rk_hdtpx_tmds_lntop_highbr_seq);
+		rk_hdptx_multi_reg_write(hdptx, rk_hdptx_tmds_lntop_highbr_seq);
 	} else {
 		/* For 1/10 bitrate clk */
-		rk_hdptx_multi_reg_write(hdptx, rk_hdtpx_tmds_lntop_lowbr_seq);
+		rk_hdptx_multi_reg_write(hdptx, rk_hdptx_tmds_lntop_lowbr_seq);
 	}
 
 	regmap_write(hdptx->regmap, LNTOP_REG(0206), 0x07);
 	regmap_write(hdptx->regmap, LNTOP_REG(0207), 0x0f);
 
-	rk_hdptx_multi_reg_write(hdptx, rk_hdtpx_common_lane_init_seq);
-	rk_hdptx_multi_reg_write(hdptx, rk_hdtpx_tmds_lane_init_seq);
+	rk_hdptx_multi_reg_write(hdptx, rk_hdptx_common_lane_init_seq);
+	rk_hdptx_multi_reg_write(hdptx, rk_hdptx_tmds_lane_init_seq);
 
 	return rk_hdptx_post_enable_lane(hdptx);
 }
@@ -1122,7 +1122,7 @@ static int rk_hdptx_phy_consumer_get(struct rk_hdptx_phy *hdptx)
 	if (mode == PHY_MODE_DP) {
 		rk_hdptx_dp_reset(hdptx);
 	} else {
-		ret = rk_hdptx_ropll_tmds_cmn_config(hdptx);
+		ret = rk_hdptx_tmds_ropll_cmn_config(hdptx);
 		if (ret)
 			goto dec_usage;
 	}
@@ -1469,7 +1469,7 @@ static int rk_hdptx_phy_power_on(struct phy *phy)
 		regmap_write(hdptx->grf, GRF_HDPTX_CON0,
 			     HDPTX_MODE_SEL << 16 | FIELD_PREP(HDPTX_MODE_SEL, 0x0));
 
-		ret = rk_hdptx_ropll_tmds_mode_config(hdptx);
+		ret = rk_hdptx_tmds_ropll_mode_config(hdptx);
 		if (ret)
 			rk_hdptx_phy_consumer_put(hdptx, true);
 	}
@@ -1492,11 +1492,11 @@ static int rk_hdptx_phy_verify_hdmi_config(struct rk_hdptx_phy *hdptx,
 	if (!hdmi->tmds_char_rate || hdmi->tmds_char_rate > HDMI20_MAX_RATE)
 		return -EINVAL;
 
-	for (i = 0; i < ARRAY_SIZE(ropll_tmds_cfg); i++)
-		if (hdmi->tmds_char_rate == ropll_tmds_cfg[i].rate)
+	for (i = 0; i < ARRAY_SIZE(rk_hdptx_tmds_ropll_cfg); i++)
+		if (hdmi->tmds_char_rate == rk_hdptx_tmds_ropll_cfg[i].rate)
 			break;
 
-	if (i == ARRAY_SIZE(ropll_tmds_cfg) &&
+	if (i == ARRAY_SIZE(rk_hdptx_tmds_ropll_cfg) &&
 	    !rk_hdptx_phy_clk_pll_calc(hdmi->tmds_char_rate, NULL))
 		return -EINVAL;
 
@@ -1921,7 +1921,7 @@ static int rk_hdptx_phy_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	 * while the latter being executed only once, i.e. when clock remains
 	 * in the prepared state during rate changes.
 	 */
-	return rk_hdptx_ropll_tmds_cmn_config(hdptx);
+	return rk_hdptx_tmds_ropll_cmn_config(hdptx);
 }
 
 static const struct clk_ops hdptx_phy_clk_ops = {

-- 
2.50.1


