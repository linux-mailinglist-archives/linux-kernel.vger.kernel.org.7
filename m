Return-Path: <linux-kernel+bounces-826501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BEAB8EAE3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 03:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0619189C15C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 01:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9764B165F1A;
	Mon, 22 Sep 2025 01:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="JmZ/zCQA"
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763681A238C;
	Mon, 22 Sep 2025 01:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758504100; cv=none; b=LQFcGfAz0pZr40MzjE+MZ7kZKIOhea2kQ/AeWb5CrSmNe8MaLvonKpkr0zR5PUQvMykagOUs3ZqzFl/XIaJRR8vp6ipEWEFKtHd4yhRdWc9tnusR6h5J2fTfivXqotHdzYZs4IwTZrlK8keG2SokmDzRSfIrBtTD11bTVruiGe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758504100; c=relaxed/simple;
	bh=IcvTUrbIvNOoPPpd9K3Np+W4YNpuoY6nyIadwQJf7os=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=sDtKQz4Y2AYya4qj2oyIC/AjnVM+gcl6MHagfj5WpFEhPOhIdULxBEOV4g7VYkoCnK66btxQ4738kJ6+qGNZPcob1z9P9tmSrFmwfDql/bxGjKpVu/lA65QHaMv6fYDo1c1ewID1jHphhEgxlgM9ubNES45LKWppqnQRQ3NCYI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=JmZ/zCQA; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1758504061;
	bh=Yi6bUqe5/vcuqvz2KYqLsQmo/crbod6X+jkr/5OlqM4=;
	h=From:To:Subject:Date:Message-Id;
	b=JmZ/zCQAVX2+q/TSSNo4kCMLEgUETkdk79bBJJDRzdMjUFhwJuA94zPcUGN1WxQEH
	 rrTa5/bH5z+wcxUdimhI/0jl/2NUzNAHxp4r5LvzSRXkXMpB8Qd0W65PnRi3q4lEnX
	 JiOsQMNoe2+uniedH83MOZup+owQ6BkQ97mtmNf4=
X-QQ-mid: zesmtpgz1t1758504060t1dfe59a4
X-QQ-Originating-IP: 8yTSZt1ezK9BOZQXMQ9fRUQoLbip3wSV0d9Poaekz2E=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Sep 2025 09:20:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14631667019847014216
From: Chaoyi Chen <kernel@airkyi.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Yubing Zhang <yubing.zhang@rock-chips.com>,
	Frank Wang <frank.wang@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Amit Sunil Dhamne <amitsd@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Peter Robinson <pbrobinson@gmail.com>
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v4 3/7] phy: rockchip: phy-rockchip-typec: Add typec_mux/typec_switch support
Date: Mon, 22 Sep 2025 09:20:35 +0800
Message-Id: <20250922012039.323-4-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250922012039.323-1-kernel@airkyi.com>
References: <20250922012039.323-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NQR8mRxMnur9Dz0IxYz/h+G9CrCkGShU72VYcsAFYMIYacwEuI79twhB
	pKCPfVDsICXK/k3GrZzKijwnxxVB310vSxoCqx56nAhNBLGh37QOhZ5khPferubj3qBjDjg
	2oP9EQKQ3AataSMzHQq67pTG5H2KwQALvgNxxtpmVGcS4XFeMcwfYgQml5KIfdQcq1erMvg
	Z8QhP8geKglLOxABHbpKWZESZx1jVZ+5DkTBh6bzoX8u3sSX+pSabTAv+9EFeALm0AKF7cc
	RXMIjrH+Aiz9euRi7NESerMO7EuOsXjXltNfzkwxglcMuTxe0OoLxjo6LjBHwvdgC5Dw9mA
	qiIk1hXD8vGCz4n2KfLkE+thxcqFtLfeDr/7Pn915LhgoVWLK9Qzi4KghKnbwkzfY59/2HB
	LvjdkebPYsQIglNjo96KfqaE04pY2YCBJ3x8JovGhyTRurU3qyynovdM4DalztY/ou2LB3a
	YEf1YbbUcF7UZ5OtsUbmC9vRU2YvfmvJR8vsU90AW8jby38OXrIo9PJE1F52BPlIomhjzTI
	RZqGhz+eHOqupzUj3KEihSkYwNqvY9WAMBUveBsjOXjUoiGDYFExRX0Q3fIFX8CtSNzU0Hi
	TTplkSYXJDi0rVctOGxuHPVWdpsPUmb2lF3WozfkeTWj2soE6+MLK1SmqPzZDWH7EkyOmYm
	YeUaBBE0Fu8QC4fDGuGgd6Bm4V22X7JOTtVo83CRa1WLTLFoXQ4+3EVDB6jtuHWtKTkDwUI
	diZhtZdVxggBDt40ngOgnOWaZQj8Dxk0Ai0v1SoxmIqg9MiGkOquPfagDFOfPtq1YRgTo5C
	LGzcQG7KPejfxJHORtKJaqIMa+Vhsdu73lgR7nz2Vn+MyPBpVCzCqtZzjdflxZElHM3Gc1/
	zGM9R7C/TI7g8EcfMyaYjSbj6ZWnd3Krh5cRMV+8QDvjt1yx+aYkaUbs61lEskvmH+lOvmO
	82rIypOZxfI24SAdwTIwWTLAGNtZKDPpsBBXcrq29r+vghuSezEE+dSDRYocJyutrfqUUfK
	RIem8Nww==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

This patch add support for Type-C Port Controller Manager. Each PHY
will register typec_mux and typec_switch when external Type-C
controller is present. Type-C events are handled by TCPM without
extcon.

The extcon device should still be supported.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---

Changes in v4:
- Remove notify DP HPD state by USB/DP PHY.

(no changes since v3)

Changes in v2:
- Fix compile error when CONFIG_TYPEC is not enabled.
- Notify DP HPD state by USB/DP PHY.

 drivers/phy/rockchip/phy-rockchip-typec.c | 365 +++++++++++++++++++++-
 1 file changed, 349 insertions(+), 16 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
index d9701b6106d5..4a1dfa8d65c7 100644
--- a/drivers/phy/rockchip/phy-rockchip-typec.c
+++ b/drivers/phy/rockchip/phy-rockchip-typec.c
@@ -54,6 +54,8 @@
 
 #include <linux/mfd/syscon.h>
 #include <linux/phy/phy.h>
+#include <linux/usb/typec_dp.h>
+#include <linux/usb/typec_mux.h>
 
 #define CMN_SSM_BANDGAP			(0x21 << 2)
 #define CMN_SSM_BIAS			(0x22 << 2)
@@ -286,12 +288,23 @@
 #define RX_DIAG_SC2C_DELAY		(0x81e1 << 2)
 
 #define PMA_LANE_CFG			(0xc000 << 2)
+#define PMA_LANE3_DP_LANE_SEL(x)	(((x) & 0x3) << 14)
+#define PMA_LANE3_INTERFACE_SEL(x)	(((x) & 0x1) << 12)
+#define PMA_LANE2_DP_LANE_SEL(x)	(((x) & 0x3) << 10)
+#define PMA_LANE2_INTERFACE_SEL(x)	(((x) & 0x1) << 8)
+#define PMA_LANE1_DP_LANE_SEL(x)	(((x) & 0x3) << 6)
+#define PMA_LANE1_INTERFACE_SEL(x)	(((x) & 0x1) << 4)
+#define PMA_LANE0_DP_LANE_SEL(x)	(((x) & 0x3) << 2)
+#define PMA_LANE0_INTERFACE_SEL(x)	(((x) & 0x1) << 0)
 #define PIPE_CMN_CTRL1			(0xc001 << 2)
 #define PIPE_CMN_CTRL2			(0xc002 << 2)
 #define PIPE_COM_LOCK_CFG1		(0xc003 << 2)
 #define PIPE_COM_LOCK_CFG2		(0xc004 << 2)
 #define PIPE_RCV_DET_INH		(0xc005 << 2)
 #define DP_MODE_CTL			(0xc008 << 2)
+#define PHY_DP_POWER_STATE_ACK_MASK	GENMASK(7, 4)
+#define PHY_DP_POWER_STATE_ACK_SHIFT	4
+#define PHY_DP_POWER_STATE_MASK		GENMASK(3, 0)
 #define DP_CLK_CTL			(0xc009 << 2)
 #define STS				(0xc00F << 2)
 #define PHY_ISO_CMN_CTRL		(0xc010 << 2)
@@ -327,8 +340,15 @@
 
 #define DP_MODE_A0			BIT(4)
 #define DP_MODE_A2			BIT(6)
-#define DP_MODE_ENTER_A0		0xc101
-#define DP_MODE_ENTER_A2		0xc104
+
+#define DP_MODE_MASK			0xf
+#define DP_MODE_ENTER_A0		BIT(0)
+#define DP_MODE_ENTER_A2		BIT(2)
+#define DP_MODE_ENTER_A3		BIT(3)
+#define DP_MODE_A0_ACK			BIT(4)
+#define DP_MODE_A2_ACK			BIT(6)
+#define DP_MODE_A3_ACK			BIT(7)
+#define DP_LINK_RESET_DEASSERTED	BIT(8)
 
 #define PHY_MODE_SET_TIMEOUT		100000
 
@@ -340,6 +360,31 @@
 #define MODE_DFP_USB			BIT(1)
 #define MODE_DFP_DP			BIT(2)
 
+enum phy_dp_lane_num {
+	PHY_DP_LANE_0 = 0,
+	PHY_DP_LANE_1,
+	PHY_DP_LANE_2,
+	PHY_DP_LANE_3,
+};
+
+enum phy_pma_if {
+	PMA_IF_PIPE_PCS = 0,
+	PMA_IF_PHY_DP,
+};
+
+enum phy_typec_role {
+	TYPEC_PHY_USB = 0,
+	TYPEC_PHY_DP,
+	TYPEC_PHY_MAX,
+};
+
+enum phy_dp_power_state {
+	PHY_DP_POWER_STATE_A0 = 0,
+	PHY_DP_POWER_STATE_A1,
+	PHY_DP_POWER_STATE_A2,
+	PHY_DP_POWER_STATE_A3,
+};
+
 struct usb3phy_reg {
 	u32 offset;
 	u32 enable_bit;
@@ -372,18 +417,22 @@ struct rockchip_typec_phy {
 	struct device *dev;
 	void __iomem *base;
 	struct extcon_dev *extcon;
+	struct typec_mux_dev *mux;
+	struct typec_switch_dev *sw;
 	struct regmap *grf_regs;
 	struct clk *clk_core;
 	struct clk *clk_ref;
 	struct reset_control *uphy_rst;
 	struct reset_control *pipe_rst;
 	struct reset_control *tcphy_rst;
+	struct phy *phys[TYPEC_PHY_MAX];
 	const struct rockchip_usb3phy_port_cfg *port_cfgs;
 	/* mutex to protect access to individual PHYs */
 	struct mutex lock;
 
 	bool flip;
 	u8 mode;
+	u8 new_mode;
 };
 
 struct phy_reg {
@@ -454,6 +503,99 @@ static const struct rockchip_usb3phy_port_cfg rk3399_usb3phy_port_cfgs[] = {
 	{ /* sentinel */ }
 };
 
+static int tcphy_cfg_usb3_to_usb2_only(struct rockchip_typec_phy *tcphy,
+				       bool value);
+
+static int tcphy_dp_set_power_state(struct rockchip_typec_phy *tcphy,
+				    enum phy_dp_power_state state)
+{
+	u32 ack, reg, sts = BIT(state);
+	int ret;
+
+	/*
+	 * Power state changes must not be requested until after the cmn_ready
+	 * signal has gone active.
+	 */
+	reg = readl(tcphy->base + PMA_CMN_CTRL1);
+	if (!(reg & CMN_READY)) {
+		dev_err(tcphy->dev, "cmn_ready in the inactive state\n");
+		return -EINVAL;
+	}
+
+	reg = readl(tcphy->base + DP_MODE_CTL);
+	reg &= ~PHY_DP_POWER_STATE_MASK;
+	reg |= sts;
+	writel(reg, tcphy->base + DP_MODE_CTL);
+
+	ret = readl_poll_timeout(tcphy->base + DP_MODE_CTL,
+				 ack, (((ack & PHY_DP_POWER_STATE_ACK_MASK) >>
+				 PHY_DP_POWER_STATE_ACK_SHIFT) == sts), 10,
+				 PHY_MODE_SET_TIMEOUT);
+	if (ret < 0) {
+		dev_err(tcphy->dev, "failed to enter power state %d\n", state);
+		return ret;
+	}
+
+	return 0;
+}
+
+/*
+ * For the TypeC PHY, the 4 lanes are mapping to the USB TypeC receptacle pins
+ * as follows:
+ *   -------------------------------------------------------------------
+ *	PHY Lanes/Module Pins			TypeC Receptacle Pins
+ *   -------------------------------------------------------------------
+ *	Lane0 (tx_p/m_ln_0)			TX1+/TX1- (pins A2/A3)
+ *	Lane1 (tx_rx_p/m_ln_1)			RX1+/RX1- (pins B11/B10)
+ *	Lane2 (tx_rx_p/m_ln_2)			RX2+/RX2- (pins A11/A10)
+ *	Lane3 (tx_p/m_ln_3)			TX2+/TX2- (pins B2/B3)
+ *   -------------------------------------------------------------------
+ *
+ * USB and DP lanes mapping to TypeC PHY lanes for each of pin assignment
+ * options (normal connector orientation) described in the VESA DisplayPort
+ * Alt Mode on USB TypeC Standard as follows:
+ *
+ * ----------------------------------------------------------------------
+ *	PHY Lanes	A	B	C	D	E	F
+ * ----------------------------------------------------------------------
+ *	  0	       ML1     SSTX    ML2     SSTX    ML2     SSTX
+ *	  1	       ML3     SSRX    ML3     SSRX    ML3     SSRX
+ *	  2	       ML2     ML1     ML0     ML0     ML0     ML0
+ *	  3	       ML0     ML0     ML1     ML1     ML1     ML1
+ * ----------------------------------------------------------------------
+ */
+static void tcphy_set_lane_mapping(struct rockchip_typec_phy *tcphy, u8 mode)
+{
+	/*
+	 * The PMA_LANE_CFG register is used to select whether a PMA lane
+	 * is mapped for USB or PHY DP. The PMA_LANE_CFG register is
+	 * configured based on a normal connector orientation. Logic in the
+	 * PHY automatically handles the flipped connector case based on the
+	 * setting of orientation of TypeC PHY.
+	 */
+	if (mode == MODE_DFP_DP) {
+		/* This maps to VESA DP Alt Mode pin assignments C and E. */
+		writel(PMA_LANE3_DP_LANE_SEL(PHY_DP_LANE_1) |
+		       PMA_LANE3_INTERFACE_SEL(PMA_IF_PHY_DP) |
+		       PMA_LANE2_DP_LANE_SEL(PHY_DP_LANE_0) |
+		       PMA_LANE2_INTERFACE_SEL(PMA_IF_PHY_DP) |
+		       PMA_LANE1_DP_LANE_SEL(PHY_DP_LANE_3) |
+		       PMA_LANE1_INTERFACE_SEL(PMA_IF_PHY_DP) |
+		       PMA_LANE0_DP_LANE_SEL(PHY_DP_LANE_2) |
+		       PMA_LANE0_INTERFACE_SEL(PMA_IF_PHY_DP),
+		       tcphy->base + PMA_LANE_CFG);
+	} else {
+		/* This maps to VESA DP Alt Mode pin assignments D and F. */
+		writel(PMA_LANE3_DP_LANE_SEL(PHY_DP_LANE_1) |
+		       PMA_LANE3_INTERFACE_SEL(PMA_IF_PHY_DP) |
+		       PMA_LANE2_DP_LANE_SEL(PHY_DP_LANE_0) |
+		       PMA_LANE2_INTERFACE_SEL(PMA_IF_PHY_DP) |
+		       PMA_LANE1_INTERFACE_SEL(PMA_IF_PIPE_PCS) |
+		       PMA_LANE0_INTERFACE_SEL(PMA_IF_PIPE_PCS),
+		       tcphy->base + PMA_LANE_CFG);
+	}
+}
+
 static void tcphy_cfg_24m(struct rockchip_typec_phy *tcphy)
 {
 	u32 i, rdata;
@@ -743,8 +885,10 @@ static int tcphy_phy_init(struct rockchip_typec_phy *tcphy, u8 mode)
 	tcphy_dp_aux_set_flip(tcphy);
 
 	tcphy_cfg_24m(tcphy);
+	tcphy_set_lane_mapping(tcphy, mode);
 
 	if (mode == MODE_DFP_DP) {
+		tcphy_cfg_usb3_to_usb2_only(tcphy, true);
 		tcphy_cfg_dp_pll(tcphy);
 		for (i = 0; i < 4; i++)
 			tcphy_dp_cfg_lane(tcphy, i);
@@ -768,7 +912,10 @@ static int tcphy_phy_init(struct rockchip_typec_phy *tcphy, u8 mode)
 		writel(PIN_ASSIGN_D_F, tcphy->base + PMA_LANE_CFG);
 	}
 
-	writel(DP_MODE_ENTER_A2, tcphy->base + DP_MODE_CTL);
+	val = readl(tcphy->base + DP_MODE_CTL);
+	val &= ~DP_MODE_MASK;
+	val |= DP_MODE_ENTER_A2 | DP_LINK_RESET_DEASSERTED;
+	writel(val, tcphy->base + DP_MODE_CTL);
 
 	reset_control_deassert(tcphy->uphy_rst);
 
@@ -811,8 +958,9 @@ static int tcphy_get_mode(struct rockchip_typec_phy *tcphy)
 	u8 mode;
 	int ret, ufp, dp;
 
+	/* If extcon not exist, try to use tcpm mode */
 	if (!edev)
-		return MODE_DFP_USB;
+		return tcphy->new_mode;
 
 	ufp = extcon_get_state(edev, EXTCON_USB);
 	dp = extcon_get_state(edev, EXTCON_DISP_DP);
@@ -850,6 +998,72 @@ static int tcphy_get_mode(struct rockchip_typec_phy *tcphy)
 	return mode;
 }
 
+#if IS_ENABLED(CONFIG_TYPEC)
+static int tcphy_orien_sw_set(struct typec_switch_dev *sw,
+			      enum typec_orientation orien)
+{
+	struct rockchip_typec_phy *tcphy = typec_switch_get_drvdata(sw);
+
+	mutex_lock(&tcphy->lock);
+
+	if (orien == TYPEC_ORIENTATION_NONE) {
+		tcphy->new_mode = MODE_DISCONNECT;
+		goto unlock_ret;
+	}
+
+	tcphy->flip = (orien == TYPEC_ORIENTATION_REVERSE) ? true : false;
+	tcphy->new_mode = MODE_DFP_USB;
+
+unlock_ret:
+	mutex_unlock(&tcphy->lock);
+	return 0;
+}
+
+static void udphy_orien_switch_unregister(void *data)
+{
+	struct rockchip_typec_phy *tcphy = data;
+
+	typec_switch_unregister(tcphy->sw);
+}
+
+static int tcphy_setup_orien_switch(struct rockchip_typec_phy *tcphy)
+{
+	struct typec_switch_desc sw_desc = { };
+	struct device_node *np;
+	int ret = 0;
+
+	np = of_get_child_by_name(tcphy->dev->of_node, "usb3-port");
+	if (!np)
+		return 0;
+
+	if (!of_property_read_bool(np, "orientation-switch"))
+		goto put_np;
+
+	sw_desc.drvdata = tcphy;
+	sw_desc.fwnode = device_get_named_child_node(tcphy->dev, "usb3-port");
+	sw_desc.set = tcphy_orien_sw_set;
+
+	tcphy->sw = typec_switch_register(tcphy->dev, &sw_desc);
+	if (IS_ERR(tcphy->sw)) {
+		dev_err(tcphy->dev, "Error register typec orientation switch: %ld\n",
+			PTR_ERR(tcphy->sw));
+		ret = PTR_ERR(tcphy->sw);
+		goto put_np;
+	}
+
+	ret = devm_add_action_or_reset(tcphy->dev, udphy_orien_switch_unregister, tcphy);
+
+put_np:
+	of_node_put(np);
+	return ret;
+}
+#else
+static int tcphy_setup_orien_switch(struct rockchip_typec_phy *tcphy)
+{
+	return 0;
+}
+#endif
+
 static int tcphy_cfg_usb3_to_usb2_only(struct rockchip_typec_phy *tcphy,
 				       bool value)
 {
@@ -989,14 +1203,9 @@ static int rockchip_dp_phy_power_on(struct phy *phy)
 
 	tcphy_dp_aux_calibration(tcphy);
 
-	writel(DP_MODE_ENTER_A0, tcphy->base + DP_MODE_CTL);
-
-	ret = readx_poll_timeout(readl, tcphy->base + DP_MODE_CTL,
-				 val, val & DP_MODE_A0, 1000,
-				 PHY_MODE_SET_TIMEOUT);
-	if (ret < 0) {
-		writel(DP_MODE_ENTER_A2, tcphy->base + DP_MODE_CTL);
-		dev_err(tcphy->dev, "failed to wait TCPHY enter A0\n");
+	ret = tcphy_dp_set_power_state(tcphy, PHY_DP_POWER_STATE_A0);
+	if (ret) {
+		dev_err(tcphy->dev, "failed to enter A0 power state\n");
 		goto power_on_finish;
 	}
 
@@ -1013,6 +1222,7 @@ static int rockchip_dp_phy_power_on(struct phy *phy)
 static int rockchip_dp_phy_power_off(struct phy *phy)
 {
 	struct rockchip_typec_phy *tcphy = phy_get_drvdata(phy);
+	int ret;
 
 	mutex_lock(&tcphy->lock);
 
@@ -1021,7 +1231,11 @@ static int rockchip_dp_phy_power_off(struct phy *phy)
 
 	tcphy->mode &= ~MODE_DFP_DP;
 
-	writel(DP_MODE_ENTER_A2, tcphy->base + DP_MODE_CTL);
+	ret = tcphy_dp_set_power_state(tcphy, PHY_DP_POWER_STATE_A2);
+	if (ret) {
+		dev_err(tcphy->dev, "failed to enter A2 power state\n");
+		goto unlock;
+	}
 
 	if (tcphy->mode == MODE_DISCONNECT)
 		tcphy_phy_deinit(tcphy);
@@ -1037,6 +1251,89 @@ static const struct phy_ops rockchip_dp_phy_ops = {
 	.owner		= THIS_MODULE,
 };
 
+#if IS_ENABLED(CONFIG_TYPEC)
+static int tcphy_typec_mux_set(struct typec_mux_dev *mux, struct typec_mux_state *state)
+{
+	struct rockchip_typec_phy *tcphy = typec_mux_get_drvdata(mux);
+	struct typec_displayport_data *data;
+	int hpd = 0;
+
+	mutex_lock(&tcphy->lock);
+
+	switch (state->mode) {
+	case TYPEC_STATE_SAFE:
+		fallthrough;
+	case TYPEC_STATE_USB:
+		tcphy->new_mode = MODE_DFP_USB;
+		phy_set_bus_width(tcphy->phys[TYPEC_PHY_DP], 0);
+		break;
+	case TYPEC_DP_STATE_C:
+	case TYPEC_DP_STATE_E:
+		tcphy->new_mode = MODE_DFP_DP;
+		data = state->data;
+		hpd = !!(data->status & DP_STATUS_HPD_STATE);
+		phy_set_bus_width(tcphy->phys[TYPEC_PHY_DP], hpd ? 4 : 0);
+		break;
+	case TYPEC_DP_STATE_D:
+		tcphy->new_mode = MODE_DFP_DP | MODE_DFP_USB;
+		data = state->data;
+		hpd = !!(data->status & DP_STATUS_HPD_STATE);
+		phy_set_bus_width(tcphy->phys[TYPEC_PHY_DP], hpd ? 2 : 0);
+		break;
+	default:
+		break;
+	}
+
+	mutex_unlock(&tcphy->lock);
+
+	return 0;
+}
+
+static void tcphy_typec_mux_unregister(void *data)
+{
+	struct rockchip_typec_phy *tcphy = data;
+
+	typec_mux_unregister(tcphy->mux);
+}
+
+static int tcphy_setup_typec_mux(struct rockchip_typec_phy *tcphy)
+{
+	struct typec_mux_desc mux_desc = {};
+	struct device_node *np;
+	int ret = 0;
+
+	np = of_get_child_by_name(tcphy->dev->of_node, "dp-port");
+	if (!np)
+		return 0;
+
+	if (!of_property_read_bool(np, "mode-switch"))
+		goto put_np;
+
+	mux_desc.drvdata = tcphy;
+	mux_desc.fwnode = device_get_named_child_node(tcphy->dev, "dp-port");
+	mux_desc.set = tcphy_typec_mux_set;
+
+	tcphy->mux = typec_mux_register(tcphy->dev, &mux_desc);
+	if (IS_ERR(tcphy->mux)) {
+		dev_err(tcphy->dev, "Error register typec mux: %ld\n",
+			PTR_ERR(tcphy->mux));
+		ret = PTR_ERR(tcphy->mux);
+		goto put_np;
+	}
+
+	ret = devm_add_action_or_reset(tcphy->dev, tcphy_typec_mux_unregister, tcphy);
+
+put_np:
+	of_node_put(np);
+	return ret;
+}
+#else
+static int tcphy_setup_typec_mux(struct rockchip_typec_phy *tcphy)
+{
+	return 0;
+}
+#endif
+
 static int tcphy_parse_dt(struct rockchip_typec_phy *tcphy,
 			  struct device *dev)
 {
@@ -1095,6 +1392,25 @@ static void typec_phy_pre_init(struct rockchip_typec_phy *tcphy)
 	tcphy->mode = MODE_DISCONNECT;
 }
 
+static int typec_dp_lane_get(struct rockchip_typec_phy *tcphy)
+{
+	int dp_lanes;
+
+	switch (tcphy->new_mode) {
+	case MODE_DFP_DP:
+		dp_lanes = 4;
+		break;
+	case MODE_DFP_DP | MODE_DFP_USB:
+		dp_lanes = 2;
+		break;
+	default:
+		dp_lanes = 0;
+		break;
+	}
+
+	return dp_lanes;
+}
+
 static int rockchip_typec_phy_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1142,6 +1458,7 @@ static int rockchip_typec_phy_probe(struct platform_device *pdev)
 		return ret;
 
 	tcphy->dev = dev;
+	tcphy->new_mode = MODE_DFP_USB;
 	platform_set_drvdata(pdev, tcphy);
 	mutex_init(&tcphy->lock);
 
@@ -1151,6 +1468,7 @@ static int rockchip_typec_phy_probe(struct platform_device *pdev)
 	if (IS_ERR(tcphy->extcon)) {
 		if (PTR_ERR(tcphy->extcon) == -ENODEV) {
 			tcphy->extcon = NULL;
+			dev_info(dev, "extcon not exist, try to use typec mux\n");
 		} else {
 			if (PTR_ERR(tcphy->extcon) != -EPROBE_DEFER)
 				dev_err(dev, "Invalid or missing extcon\n");
@@ -1158,19 +1476,34 @@ static int rockchip_typec_phy_probe(struct platform_device *pdev)
 		}
 	}
 
+	ret = tcphy_setup_orien_switch(tcphy);
+	if (ret)
+		return ret;
+
+	ret = tcphy_setup_typec_mux(tcphy);
+	if (ret)
+		return ret;
+
 	pm_runtime_enable(dev);
 
 	for_each_available_child_of_node(np, child_np) {
 		struct phy *phy;
 
-		if (of_node_name_eq(child_np, "dp-port"))
+		if (of_node_name_eq(child_np, "dp-port")) {
 			phy = devm_phy_create(dev, child_np,
 					      &rockchip_dp_phy_ops);
-		else if (of_node_name_eq(child_np, "usb3-port"))
+			if (!IS_ERR(phy)) {
+				tcphy->phys[TYPEC_PHY_DP] = phy;
+				phy_set_bus_width(phy, typec_dp_lane_get(tcphy));
+			}
+		} else if (of_node_name_eq(child_np, "usb3-port")) {
 			phy = devm_phy_create(dev, child_np,
 					      &rockchip_usb3_phy_ops);
-		else
+			if (!IS_ERR(phy))
+				tcphy->phys[TYPEC_PHY_USB] = phy;
+		} else {
 			continue;
+		}
 
 		if (IS_ERR(phy)) {
 			dev_err(dev, "failed to create phy: %pOFn\n",
-- 
2.49.0


