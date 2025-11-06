Return-Path: <linux-kernel+bounces-887657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D81C38D11
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 03:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45C524F4DA6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 02:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5296C2405E3;
	Thu,  6 Nov 2025 02:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="QWIMM8WM"
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A265F226D14;
	Thu,  6 Nov 2025 02:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762394905; cv=none; b=pA05hDhMenXGSdsWaPXgC6uj0lGBgqm4KLy1paJgyDOvS1WC0qyRU8ZqwSY9vWIlAjDX6icoJBbVfyw8dfVV8WaBxn6fvjfTrJGvrb5VLGuevjOlgNrH4EVsY82KXdWw5XQ9VBdgF9sUz/OHiwKMyE+a2moKzleOESMV9DbN80Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762394905; c=relaxed/simple;
	bh=qaIb7TGVuqIcpeKgfA6nBAfe+2E4Q/GvG4+uDHXtQC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=i3so5sO+orPNyNjtHRNxDsDNIxzK32KuBBCAYCOkhQfEF+ArJrFi++euafldjS4R8Ugk84gc7xz8I9e90ETdbFvhkIk8zVcBuNmJjK6Eo+ZPkB6+cMGYaR11YoJVIznBdbTHOQIYtnyLZL2ShBwvNwWMhIWlhcl/Ko+ADcLHhuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=QWIMM8WM; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1762394838;
	bh=J2Dfi8ObLWDtR4Ds26hqQWc9pn2P2eSkWbDnDzh2tek=;
	h=From:To:Subject:Date:Message-Id;
	b=QWIMM8WMLgmM1GHI2ekmPYFThz45q9VZVmq8Tu/S+w+MjnJDs2JJKQrU8Tvupgr+7
	 6bt1dw2uq68DQKZfSlWhkS2WbEyYGaocSqjGAQh9Qh3AkTrKWPk7JkscrPROkLZZBh
	 jd+i5m3MBZx1lu4jT570uTwKfyaptIFTt8vWguiU=
X-QQ-mid: esmtpgz15t1762394836t5c25a9a9
X-QQ-Originating-IP: MNgHLaivXKIqdVXO1uJSHb8Co2TeOFaAisJDtLBd4mA=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Nov 2025 10:07:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4187062248744172939
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
	Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: [PATCH 9/9] drm/rockchip: vop: Add support for rk3506
Date: Thu,  6 Nov 2025 10:06:32 +0800
Message-Id: <20251106020632.92-10-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251106020632.92-1-kernel@airkyi.com>
References: <20251106020632.92-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NmjM7tI9iA2tclLMxUkABYeywUVgWiGT5d+cHlw3fxtG6M+TkmOC9emn
	G69z+CUpiKxYB9BKG/DFScyQE8b3X/uNE/2uorCMt64eUnZNggaXcdE9RuEeU3SfX8t+v20
	/q+3fZrScWbp1gKT11rm3JOBwHio8wzuHhUfUwMYMD6iG9MZ8ZKHtbs5ICB2MGAe+CS2Vvj
	dwaeHOvdFxEaLWbkG+xakq2cj23rc6wSmXy8VUzYgZ14Q3ZtCTpzTXbU6hhXhgFaNu0qkSq
	FNpIHtG+Mg2Hqu/M9vzIECGuk7PRduFdD5CqWKcXRJiHFPuBCapxh+4Z6DBzS4zSzEY+Cz1
	FglCY6+XjFVkElG39Gge9aFcs2DGcybzjYCgF/ILu2/6GjB0wSgU36djHPFVmRWJ1hYM+fb
	CL1p7036Z1zP7Eg25C/yKBU/SuriIzTU671fbKpttmolJPmS8Uo6mIGwfLRHGr9md+qOYmf
	C0lUYJe8YIMitmlB0NdRSspNnALLMDBA415mN2KPhnO7/afL5Y1Xp+U0ddxwC4wLZG5f6bz
	MHJfVutBlHwYywJq58B357JHw/IiWLqxtMTuyno5fUyGPMP6cNTW26wCG//ay/utfZCW2ol
	0VrOfDUCE6yPVTbckosU+0wmajJwHPYPWOAue4S7modGzpKwj9AkVZNxNPS64BwgRHECVbk
	uYV+rZ6TqXdpJNQ1PICVVh7cZL1J/Xh6EmHtKLt7sT/iwZqRLNWMB14wetJ73MXxJ+iQxui
	oBj/yBhOmMqgFDjG6dDqXP/Tp23vnT5uXAUrpaElIdNzpSoodAT1ylCJxPy5m6VRvuajNWW
	uz0qXWVOgpz1pdzAS/9rvmRebi32ZvaNTvLnGzh4iKK30GIYDQvagnLtQwN7hDHIcwmBk1X
	uPtunjxzZoNxnWQZcEIkmO9p4irwsrLwa1aBXbd8lVCPQrLAG2iL33RJFiyTheugHKlPzr7
	UVnxHqGNJ1FawHFzZdcaizdxn6zp+6kryDTJDU9sgKQKi8uA5uiPVIdYWmI+tUM7Wzc1r97
	PACVtKgHNmY52td5yLJ1MXIO00/Z+CtxrgpTMcqA==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

The VOP on rk3506:
- Support 2 lane MIPI DSI interface, 1.5Gbps/lane.
- Support RGB interface.
- Max output resolution is 1280x1280@60fps.
- WIN1 layer support RGB888/ARGB8888/RGB565.
- Support Gamma LUT.
- ...

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 57 +++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_vop_reg.h | 14 +++++
 2 files changed, 71 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index d1f788763318..6b654b682a94 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -1179,6 +1179,61 @@ static const struct vop_data rk3328_vop = {
 	.max_output = { 4096, 2160 },
 };
 
+static const struct vop_common rk3506_common = {
+	.standby = VOP_REG_SYNC(RK3506_SYS_CTRL2, 0x1, 1),
+	.out_mode = VOP_REG(RK3506_DSP_CTRL2, 0xf, 16),
+	.dsp_blank = VOP_REG(RK3506_DSP_CTRL2, 0x1, 14),
+	.dither_down_en = VOP_REG(RK3506_DSP_CTRL2, 0x1, 8),
+	.dither_down_sel = VOP_REG(RK3506_DSP_CTRL2, 0x1, 7),
+	.dither_down_mode = VOP_REG(RK3506_DSP_CTRL2, 0x1, 6),
+	.dsp_lut_en = VOP_REG(RK3506_DSP_CTRL2, 0x1, 5),
+	.dither_up = VOP_REG(RK3506_DSP_CTRL2, 0x1, 2),
+	.cfg_done = VOP_REG_SYNC(RK3506_REG_CFG_DONE, 0x1, 0),
+};
+
+static const struct vop_output rk3506_output = {
+	.rgb_en = VOP_REG(RK3506_DSP_CTRL0, 0x1, 0),
+	.rgb_pin_pol = VOP_REG(RK3506_DSP_CTRL0, 0x7, 2),
+	.mipi_en = VOP_REG(RK3506_DSP_CTRL0, 0x1, 24),
+	.mipi_dclk_pol = VOP_REG(RK3506_DSP_CTRL0, 0x1, 25),
+	.mipi_pin_pol = VOP_REG(RK3506_DSP_CTRL0, 0x7, 26),
+};
+
+static const struct vop_win_phy rk3506_win1_data = {
+	.data_formats = formats_win_lite,
+	.nformats = ARRAY_SIZE(formats_win_lite),
+	.format_modifiers = format_modifiers_win_lite,
+	.enable = VOP_REG(RK3506_WIN1_CTRL0, 0x1, 0),
+	.format = VOP_REG(RK3506_WIN1_CTRL0, 0x7, 4),
+	.rb_swap = VOP_REG(RK3506_WIN1_CTRL0, 0x1, 12),
+	.channel = VOP_REG(RK3506_WIN1_CTRL1, 0xf, 8),
+	.yrgb_vir = VOP_REG(RK3506_WIN1_VIR, 0x1fff, 0),
+	.yrgb_mst = VOP_REG(RK3506_WIN1_MST, 0xffffffff, 0),
+	.dsp_info = VOP_REG(RK3506_WIN1_DSP_INFO, 0xffffffff, 0),
+	.dsp_st = VOP_REG(RK3506_WIN1_DSP_ST, 0xffffffff, 0),
+	.alpha_en = VOP_REG(RK3506_WIN1_ALPHA_CTRL, 0x1, 0),
+	.alpha_mode = VOP_REG(RK3506_WIN1_ALPHA_CTRL, 0x1, 1),
+	.alpha_pre_mul = VOP_REG(RK3506_WIN1_ALPHA_CTRL, 0x1, 2),
+};
+
+static const struct vop_win_data rk3506_vop_win_data[] = {
+	{ .base = 0x00, .phy = &rk3506_win1_data,
+	  .type = DRM_PLANE_TYPE_PRIMARY },
+};
+
+static const struct vop_data rk3506_vop = {
+	.version = VOP_VERSION(2, 0xe),
+	.feature = VOP_FEATURE_INTERNAL_RGB,
+	.intr = &px30_intr,
+	.common = &rk3506_common,
+	.modeset = &px30_modeset,
+	.output = &rk3506_output,
+	.win = rk3506_vop_win_data,
+	.win_size = ARRAY_SIZE(rk3506_vop_win_data),
+	.lut_size = 256,
+	.max_output = { 1280, 1280 },
+};
+
 static const struct vop_common rv1126_common = {
 	.standby = VOP_REG_SYNC(PX30_SYS_CTRL2, 0x1, 1),
 	.out_mode = VOP_REG(PX30_DSP_CTRL2, 0xf, 16),
@@ -1259,6 +1314,8 @@ static const struct of_device_id vop_driver_dt_match[] = {
 	  .data = &rk3228_vop },
 	{ .compatible = "rockchip,rk3328-vop",
 	  .data = &rk3328_vop },
+	{ .compatible = "rockchip,rk3506-vop",
+	  .data = &rk3506_vop },
 	{ .compatible = "rockchip,rv1126-vop",
 	  .data = &rv1126_vop },
 	{},
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.h b/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
index addf8ca085f6..7805533e88bc 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
@@ -1033,4 +1033,18 @@
 #define RK3066_DSP_LUT_ADDR		0x800
 /* rk3066 register definition end */
 
+/* rk3506 register definition */
+#define RK3506_REG_CFG_DONE		0x00
+#define RK3506_SYS_CTRL2		0x18
+#define RK3506_DSP_CTRL0		0x20
+#define RK3506_DSP_CTRL2		0x28
+#define RK3506_WIN1_CTRL0		0x90
+#define RK3506_WIN1_CTRL1		0x94
+#define RK3506_WIN1_VIR			0x98
+#define RK3506_WIN1_MST			0xa0
+#define RK3506_WIN1_DSP_INFO		0xa4
+#define RK3506_WIN1_DSP_ST		0xa8
+#define RK3506_WIN1_ALPHA_CTRL		0xbc
+/* rk3506 register definition end */
+
 #endif /* _ROCKCHIP_VOP_REG_H */
-- 
2.51.1


