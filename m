Return-Path: <linux-kernel+bounces-848975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F584BCEF0F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 05:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2A674234BC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 03:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A530122538F;
	Sat, 11 Oct 2025 03:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="LhdgNJ2N"
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76336E55A;
	Sat, 11 Oct 2025 03:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760153611; cv=none; b=Y6VpVCZnPNscabYqR3B7Rw1IMgbKh2K3kXrEQrW1ucDgv1a7F2vwzhck4qAduJc3jBQs8CnUU4XgjEyVd2dX2g+6xU12KmAWAK7QpKF445Q4sUi9r9DccIFCYUYQfVurySu7lmIUCJCk0t7PFOXENvg5VGQ+pOmiETcYFQZKTiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760153611; c=relaxed/simple;
	bh=WhoCYBzuQ8KOTw4lMUBZlSLW3NzP/t47v7nPCfmoye4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=p119qhdMjpAJ3Bn8JJklx3V/JNlpt7UOkg19LyC1qSRzaF2W1aiTYe0EhypgGTioDhlKWH9F8ofq1pKRkXGuUjABuSxjr541L6VHMJtHaSqJAY5Y3ezUJIBOwoCuNJ4Lg3Hh+6D073/R1XLVM6+n0c1MeIWcx0IlQCvu4WhpaF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=LhdgNJ2N; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1760153574;
	bh=YdlX41/2enmD0M5x78xDqi3bClQArpPpOY28U+5Oabo=;
	h=From:To:Subject:Date:Message-Id;
	b=LhdgNJ2NSAZ27XMeeECSEvUI8hWQQLHhB6eQhCVJA+GbrZAztPcB2w7e/WMIfPl+W
	 GoLRYKE56sXIUVv7sjgkr4x425kshk6zPKzbquDXnEz1WJvEvGBpPoCgsqMMQWmU52
	 COe2lFEu8FzBP8yvufYYfuv4x2EuttFB6DI3iifU=
X-QQ-mid: zesmtpgz4t1760153573t547fd96b
X-QQ-Originating-IP: eCzoS67QqvuRETMCqEyeE/pqsfoy664J/tsIgsLcka4=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 11 Oct 2025 11:32:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15894258866989329515
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
Subject: [PATCH v5 3/8] phy: rockchip: phy-rockchip-typec: Add typec_mux/typec_switch support
Date: Sat, 11 Oct 2025 11:32:28 +0800
Message-Id: <20251011033233.97-4-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251011033233.97-1-kernel@airkyi.com>
References: <20251011033233.97-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NRLj+a+1JRyJWjqKgNeIXvvaXlcToJAYuHApbh78UOkJkMNmdV1PDk/n
	16+6WcbRlAJDrmui0bVXPMvheyQVNAAxnKESuVidv7LOUWdgETER3XeMgCaln948z+yUgrG
	z9XFa9DLPo9X5wqbZK0czcHifLVjPwiZgQ2562Yb5sCvTP4RXgvPGC+EnqD2w4E8qL03vHx
	X9CCHegBpjcdJPs1873X19LLNrGPQxS3Bov46lH7M3w4z8smue53bPj3FImbBcufAVCU6iM
	TOlGWg0bPdBC9ecQEMKtzLlSvvpTerzlHEoGyDpjkAxknkmjO8JG+CDyacqTo+XXTc1Indn
	WncTrbPcJ/c0C10/nctCBj6pOXbdc6prk3/MZROsjDz+YfBb7SwVnQBekDvLFY0xayflysd
	fSUGRxAvWgS8yO6k37Nz5w4KKqV93M4M7AAF+VEesK4gsTgpq6SnE/5AcggE6SWK8Bs8o55
	CyAyLn65CEEckTIP/QkjIbM2PxuLXb2P+m+QKy5Rpb++ABlNCrxiW06pSVYGIsKeI46mMKk
	omwL+P52zrBIqWw676kG+5c7aQ1QYr0N+e5SG5C8z9wiS8sO7w6Clyto7l8NUGc1ub191zh
	BS9WIcOglWarMOQ3nf0QmNov1x8cBiEBMRgy4Gzf+2S/0cO+AOKs5BB6Uc+cOPcLfBb8KI2
	GUSwXHmTpfwGHKDBRsbkcMLnzo4rbzNy1AHcVxLrGUsE2Bc7I9VdJjBZQS/YV5j1j2zLUjq
	5OSZ1I+u2dqI2+5JBPfvVPA2VGTwxPiCp/bnPQRK5HKk1l54vx2SZhqKv+hb1famIQa9L82
	e5zal3MGMLTwnfsuqV5XhEPuQgzutZtpOUdUzartrYrkl8gIwE1/bISF/E68PnTOB6GwMKy
	WvxD9qxMMVnNe6J1DTTbtv6oZNnfdYZeuPZuE4e7epHJP5Iix+plOGt0H+ndoVE2GVtooYz
	t8ewRySviT/PqYaqD2VGSIcdHpoYBUhFm+sH38FIag9P9zy/wVL2GklBr0jfa4+0HVnQ=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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

(no changes since v5)

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


