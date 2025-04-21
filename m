Return-Path: <linux-kernel+bounces-612466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8F1A94F5A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 12:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C8E17A41C9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 10:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7391D25D8FE;
	Mon, 21 Apr 2025 10:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iOKW715X"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA5628FF
	for <linux-kernel@vger.kernel.org>; Mon, 21 Apr 2025 10:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745230963; cv=none; b=AxILVTIgE+gacUqQ+SabW+THuHWUH6pJcn1eE3FT/cK2k1Zp1eCZHfIwEZr240SaU3PaJsbqaYDHtxs7yLjgj/cerR8COa6EHluWbYNKv6Ff8H4FhyfTXkxOwwqddtxw1/m+XI+Gjs3LTOF96CcoiZVxrruxJZgu3Dx37QPw2Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745230963; c=relaxed/simple;
	bh=rih4rpXMJKCwsmnDeGmMvrqEGunLuCFieIdL2Q+DoYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pQ2AKg5Rh0QZZASfLZ0npKomKnu/gZyH3jtXpf0yO1auBuI3SGokumKe/Cz2f5IzwbSdBpT8z40H+tOunNqkeKWsiHK/VBvRM1JsmDfR37X1ih01527YMAyQ8aV29bnX715l7+LKC8wMZEw8BJ+SGKpMatEtGKF+Oa/V47SD1eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iOKW715X; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=kHLsn
	OA67P8UEPBP7vp1GAbNbgKuWuw51T3DRXqPdQI=; b=iOKW715XUvpFstRiibRG/
	HC7XUq6hElrdDKqY16jIyGHfy4m8LEr8bWbqamnulgC0F5XSPwnudCSUw1h+Bjow
	zlOCmnde4oinPg3SmhnQWPyNtqAOoh5PbArn2ry2dLAK0dJI2U1gnydblttFDRrg
	YFtKD9xI/9dXNHTEPclc54=
Received: from ProDesk.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBnqdZFHAZoVp1QAQ--.47835S2;
	Mon, 21 Apr 2025 18:22:01 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	derek.foreman@collabora.com,
	daniel@fooishbar.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH] drm/rockchip: vop2: Fix the update of LAYER/PORT select registers when there are multi display output on rk3588/rk3568
Date: Mon, 21 Apr 2025 18:21:54 +0800
Message-ID: <20250421102156.424480-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgBnqdZFHAZoVp1QAQ--.47835S2
X-Coremail-Antispam: 1Uf129KBjvJXoWfGryxCr4fGF45Kw1UWr48JFb_yoWDKr1rpF
	15Za47Wa4kKF4qqw1ktr4DZF1Fkws7AF4xJ3Z7t343CasIyr1qgan09F9ayF1DJr97urWU
	trZ09rZ8CFW7uF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7KsUUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBkBk2XmgGG04YeQABs6

From: Andy Yan <andy.yan@rock-chips.com>

The all video ports of rk3568/rk3588 share the same OVL_LAYER_SEL
and OVL_PORT_SEL registers, and the configuration of these two registers
can be set to take effect when the vsync signal arrives at a certain Video
Port.

If two threads for two display output choose to update these two registers
simultaneously to meet their own plane adjustment requirements(change plane
zpos or switch plane from one crtc to another), then no matter which Video
Port'svsync signal we choose to follow for these two registers, the display
output of the other Video Port will be abnormal.
This is because the configuration of this Video Port does not take
effect at the right time (its configuration should take effect when its
VSYNC signal arrives).

In order to solve this problem, when performing plane migration or
change the zpos of planes, there are two things to be observed and
followed:

1. When a plane is migrated from one VP to another, the configuration of
   the layer can only take effect after the Port mux configuration is
   enabled.

2. When change the zpos of planes, we must ensure that the change for
   the previous VP takes effect before we proceed to change the next VP.
   Otherwise, the new configuration might overwrite the previous one for
   the previous VP, or it could lead to the configuration of the previous
   VP being take effect along with the VSYNC of the new VP.

This issue only occurs in scenarios where multi-display output is enabled.

Fixes: c5996e4ab109 ("drm/rockchip: vop2: Make overlay layer select register configuration take effect by vsync")
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 25 ++----
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h | 33 ++++++++
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 89 ++++++++++++++++++--
 3 files changed, 122 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index d0f5fea15e21f..91d64bbf5c558 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -146,25 +146,6 @@ static void vop2_unlock(struct vop2 *vop2)
 	mutex_unlock(&vop2->vop2_lock);
 }
 
-/*
- * Note:
- * The write mask function is documented but missing on rk3566/8, writes
- * to these bits have no effect. For newer soc(rk3588 and following) the
- * write mask is needed for register writes.
- *
- * GLB_CFG_DONE_EN has no write mask bit.
- *
- */
-static void vop2_cfg_done(struct vop2_video_port *vp)
-{
-	struct vop2 *vop2 = vp->vop2;
-	u32 val = RK3568_REG_CFG_DONE__GLB_CFG_DONE_EN;
-
-	val |= BIT(vp->id) | (BIT(vp->id) << 16);
-
-	regmap_set_bits(vop2->map, RK3568_REG_CFG_DONE, val);
-}
-
 static void vop2_win_disable(struct vop2_win *win)
 {
 	vop2_win_write(win, VOP2_WIN_ENABLE, 0);
@@ -854,6 +835,11 @@ static void vop2_enable(struct vop2 *vop2)
 	if (vop2->version == VOP_VERSION_RK3588)
 		rk3588_vop2_power_domain_enable_all(vop2);
 
+	if (vop2->version <= VOP_VERSION_RK3588) {
+		vop2->old_layer_sel = vop2_readl(vop2, RK3568_OVL_LAYER_SEL);
+		vop2->old_port_sel = vop2_readl(vop2, RK3568_OVL_PORT_SEL);
+	}
+
 	vop2_writel(vop2, RK3568_REG_CFG_DONE, RK3568_REG_CFG_DONE__GLB_CFG_DONE_EN);
 
 	/*
@@ -2724,6 +2710,7 @@ static int vop2_bind(struct device *dev, struct device *master, void *data)
 		return dev_err_probe(drm->dev, vop2->irq, "cannot find irq for vop2\n");
 
 	mutex_init(&vop2->vop2_lock);
+	mutex_init(&vop2->ovl_lock);
 
 	ret = devm_request_irq(dev, vop2->irq, vop2_isr, IRQF_SHARED, dev_name(dev), vop2);
 	if (ret)
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
index fc3ecb9fcd957..fa5c56f16047e 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
@@ -334,6 +334,19 @@ struct vop2 {
 	/* optional internal rgb encoder */
 	struct rockchip_rgb *rgb;
 
+	/*
+	 * Used to record layer selection configuration on rk356x/rk3588
+	 * as register RK3568_OVL_LAYER_SEL and RK3568_OVL_PORT_SEL are
+	 * shared for all the Video Ports.
+	 */
+	u32 old_layer_sel;
+	u32 old_port_sel;
+	/*
+	 * Ensure that the updates to these two registers(RKK3568_OVL_LAYER_SEL/RK3568_OVL_PORT_SEL)
+	 * take effect in sequence.
+	 */
+	struct mutex ovl_lock;
+
 	/* must be put at the end of the struct */
 	struct vop2_win win[];
 };
@@ -727,6 +740,7 @@ enum dst_factor_mode {
 #define RK3588_OVL_PORT_SEL__CLUSTER2			GENMASK(21, 20)
 #define RK3568_OVL_PORT_SEL__CLUSTER1			GENMASK(19, 18)
 #define RK3568_OVL_PORT_SEL__CLUSTER0			GENMASK(17, 16)
+#define RK3588_OVL_PORT_SET__PORT3_MUX			GENMASK(15, 12)
 #define RK3568_OVL_PORT_SET__PORT2_MUX			GENMASK(11, 8)
 #define RK3568_OVL_PORT_SET__PORT1_MUX			GENMASK(7, 4)
 #define RK3568_OVL_PORT_SET__PORT0_MUX			GENMASK(3, 0)
@@ -831,4 +845,23 @@ static inline struct vop2_win *to_vop2_win(struct drm_plane *p)
 	return container_of(p, struct vop2_win, base);
 }
 
+/*
+ * Note:
+ * The write mask function is documented but missing on rk3566/8, writes
+ * to these bits have no effect. For newer soc(rk3588 and following) the
+ * write mask is needed for register writes.
+ *
+ * GLB_CFG_DONE_EN has no write mask bit.
+ *
+ */
+static inline void vop2_cfg_done(struct vop2_video_port *vp)
+{
+	struct vop2 *vop2 = vp->vop2;
+	u32 val = RK3568_REG_CFG_DONE__GLB_CFG_DONE_EN;
+
+	val |= BIT(vp->id) | (BIT(vp->id) << 16);
+
+	regmap_set_bits(vop2->map, RK3568_REG_CFG_DONE, val);
+}
+
 #endif /* _ROCKCHIP_DRM_VOP2_H */
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
index 32c4ed6857395..45c5e39878133 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -2052,12 +2052,55 @@ static void vop2_setup_alpha(struct vop2_video_port *vp)
 	}
 }
 
+static u32 rk3568_vop2_read_port_mux(struct vop2 *vop2)
+{
+	return vop2_readl(vop2, RK3568_OVL_PORT_SEL);
+}
+
+static void rk3568_vop2_wait_for_port_mux_done(struct vop2 *vop2)
+{
+	u32 port_mux_sel;
+	int ret;
+
+	/*
+	 * Spin until the previous port_mux figuration is done.
+	 */
+	ret = readx_poll_timeout_atomic(rk3568_vop2_read_port_mux, vop2, port_mux_sel,
+					port_mux_sel == vop2->old_port_sel, 0, 50 * 1000);
+	if (ret)
+		DRM_DEV_ERROR(vop2->dev, "wait port_mux done timeout: 0x%x--0x%x\n",
+			      port_mux_sel, vop2->old_port_sel);
+}
+
+static u32 rk3568_vop2_read_layer_cfg(struct vop2 *vop2)
+{
+	return vop2_readl(vop2, RK3568_OVL_LAYER_SEL);
+}
+
+static void rk3568_vop2_wait_for_layer_cfg_done(struct vop2 *vop2, u32 cfg)
+{
+	u32 atv_layer_cfg;
+	int ret;
+
+	/*
+	 * Spin until the previous layer configuration is done.
+	 */
+	ret = readx_poll_timeout_atomic(rk3568_vop2_read_layer_cfg, vop2, atv_layer_cfg,
+					atv_layer_cfg == cfg, 0, 50 * 1000);
+	if (ret)
+		DRM_DEV_ERROR(vop2->dev, "wait layer cfg done timeout: 0x%x--0x%x\n",
+			      atv_layer_cfg, cfg);
+}
+
 static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
 {
 	struct vop2 *vop2 = vp->vop2;
 	struct drm_plane *plane;
 	u32 layer_sel = 0;
 	u32 port_sel;
+	u32 old_layer_sel = 0;
+	u32 atv_layer_sel = 0;
+	u32 old_port_sel = 0;
 	u8 layer_id;
 	u8 old_layer_id;
 	u8 layer_sel_id;
@@ -2069,19 +2112,18 @@ static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
 	struct vop2_video_port *vp2 = &vop2->vps[2];
 	struct rockchip_crtc_state *vcstate = to_rockchip_crtc_state(vp->crtc.state);
 
+	mutex_lock(&vop2->ovl_lock);
 	ovl_ctrl = vop2_readl(vop2, RK3568_OVL_CTRL);
 	ovl_ctrl &= ~RK3568_OVL_CTRL__LAYERSEL_REGDONE_IMD;
 	ovl_ctrl &= ~RK3568_OVL_CTRL__LAYERSEL_REGDONE_SEL;
-	ovl_ctrl |= FIELD_PREP(RK3568_OVL_CTRL__LAYERSEL_REGDONE_SEL, vp->id);
 
 	if (vcstate->yuv_overlay)
 		ovl_ctrl |= RK3568_OVL_CTRL__YUV_MODE(vp->id);
 	else
 		ovl_ctrl &= ~RK3568_OVL_CTRL__YUV_MODE(vp->id);
 
-	vop2_writel(vop2, RK3568_OVL_CTRL, ovl_ctrl);
-
-	port_sel = vop2_readl(vop2, RK3568_OVL_PORT_SEL);
+	old_port_sel = vop2->old_port_sel;
+	port_sel = old_port_sel;
 	port_sel &= RK3568_OVL_PORT_SEL__SEL_PORT;
 
 	if (vp0->nlayers)
@@ -2102,7 +2144,13 @@ static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
 	else
 		port_sel |= FIELD_PREP(RK3568_OVL_PORT_SET__PORT2_MUX, 8);
 
-	layer_sel = vop2_readl(vop2, RK3568_OVL_LAYER_SEL);
+	/* Fixed value for rk3588 */
+	if (vop2->version == VOP_VERSION_RK3588)
+		port_sel |= FIELD_PREP(RK3588_OVL_PORT_SET__PORT3_MUX, 7);
+
+	atv_layer_sel = vop2_readl(vop2, RK3568_OVL_LAYER_SEL);
+	old_layer_sel = vop2->old_layer_sel;
+	layer_sel = old_layer_sel;
 
 	ofs = 0;
 	for (i = 0; i < vp->id; i++)
@@ -2186,8 +2234,37 @@ static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
 			     old_win->data->layer_sel_id[vp->id]);
 	}
 
+	vop2->old_layer_sel = layer_sel;
+	vop2->old_port_sel = port_sel;
+	/*
+	 * As the RK3568_OVL_LAYER_SEL and RK3568_OVL_PORT_SEL are shared by all Video Ports,
+	 * and the configuration take effect by one Video Port's vsync.
+	 * When performing layer migration or change the zpos of layers, there are two things
+	 * to be observed and followed:
+	 * 1. When a layer is migrated from one VP to another, the configuration of the layer
+	 *    can only take effect after the Port mux configuration is enabled.
+	 *
+	 * 2. When we change the zpos of layers, we must ensure that the change for the previous
+	 *    VP takes effect before we proceed to change the next VP. Otherwise, the new
+	 *    configuration might overwrite the previous one for the previous VP, or it could
+	 *    lead to the configuration of the previous VP being take effect along with the VSYNC
+	 *    of the new VP.
+	 */
+	if (layer_sel != old_layer_sel || port_sel != old_port_sel)
+		ovl_ctrl |= FIELD_PREP(RK3568_OVL_CTRL__LAYERSEL_REGDONE_SEL, vp->id);
+	vop2_writel(vop2, RK3568_OVL_CTRL, ovl_ctrl);
+
+	if (port_sel != old_port_sel) {
+		vop2_writel(vop2, RK3568_OVL_PORT_SEL, port_sel);
+		vop2_cfg_done(vp);
+		rk3568_vop2_wait_for_port_mux_done(vop2);
+	}
+
+	if (layer_sel != old_layer_sel && atv_layer_sel != old_layer_sel)
+		rk3568_vop2_wait_for_layer_cfg_done(vop2, vop2->old_layer_sel);
+
 	vop2_writel(vop2, RK3568_OVL_LAYER_SEL, layer_sel);
-	vop2_writel(vop2, RK3568_OVL_PORT_SEL, port_sel);
+	mutex_unlock(&vop2->ovl_lock);
 }
 
 static void rk3568_vop2_setup_dly_for_windows(struct vop2_video_port *vp)
-- 
2.43.0


