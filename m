Return-Path: <linux-kernel+bounces-739701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A031B0C9DE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5D051AA2FE1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06E42E2F0D;
	Mon, 21 Jul 2025 17:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BUtEsEU1"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9609A2E1C55
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 17:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753119562; cv=none; b=dtrD4b7tujDcmKiDaGGUXIdxW3wZRKqa1Vt1YyVQ0dDbrsE3L2sG6tGI2tnQtHA+wqfiogCD+WbSgJhFiDhhluiv7CA+7esMBZ5oZaR27W9GwRIejMFsLxvT9j+FVSvcbUvmfEiczO0nn/CUwWC+Sr4uHubscJC6o9F48NSzlNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753119562; c=relaxed/simple;
	bh=FDxPF4OT2bcKXd+eUAvhu2FvLoFP0u3RBFHt6nkW8Q0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=prF4LjgwvOir78G1SwpGTDZXdbEGrtDhNxt0gMLaB0QU5w5Q9lsdhSV8FkFSG7fdrJHvlrYIs32gBpst1/Tr8/FtUOGJRVQ5RkmEv8YIItIYS/zRHao9aODeBFEY26bLxHgz8P7GnfHk5uBHfyPS+9+gg2fCawgmHD+NWJA8oyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BUtEsEU1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753119558;
	bh=FDxPF4OT2bcKXd+eUAvhu2FvLoFP0u3RBFHt6nkW8Q0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BUtEsEU1O/71WkTafKm74yVOPcszS9eeyMS6tKeZYgfHzO1y8AnY8WoQFGtRi9Cp+
	 Uyf/DYYJmSx3eUC1E8MNYrsqiAXUXb0hddQ2T2c6ygy3hLewHC5M856xhJmJrWM4/Q
	 eWpN/3Ojg/sYagdecKE9yBR3Pue7SKOvI1qKYcmzSBY4Q4kg2G/yJ7nixfGhyrp5wt
	 ej5JNj7cHR3vST640/KUX/xGl3m3h/vxZzUJl1eNry8wBtPyRcGI1g+rXfTdP7lcp1
	 s+YUumTqonDcNjiXUxqqiCa2PPMwcDYe3Mamr1gpxJhu+AJw96oU3pfZD4rcP/t97s
	 bmgYOFivgctDw==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 89AB817E14A9;
	Mon, 21 Jul 2025 19:39:18 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Mon, 21 Jul 2025 20:39:07 +0300
Subject: [PATCH 4/5] drm/rockchip: dw_hdmi_qp: Use bit macros for RK3576
 regs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-rk3588-10bpc-v1-4-e95a4abcf482@collabora.com>
References: <20250721-rk3588-10bpc-v1-0-e95a4abcf482@collabora.com>
In-Reply-To: <20250721-rk3588-10bpc-v1-0-e95a4abcf482@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

For consistency and improved readability, redefine a few RK3576 specific
register configurations by relying on GENMASK() and unshifted values for
color depth and output format.  Those are not used at the moment, but
will be needed soon to support the related features.

While at it, drop a few other defines which are unlikely to be ever
required.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index b2dd29347338d58640387adb2b455cc1558d4272..578ff5eb87f1e27b9bb9a6a299347b24b45381bb 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -38,21 +38,16 @@
 #define RK3576_HDMI_HDCP14_MEM_EN	BIT(15)
 
 #define RK3576_VO0_GRF_SOC_CON8		0x0020
-#define RK3576_COLOR_FORMAT_MASK	(0xf << 4)
-#define RK3576_COLOR_DEPTH_MASK		(0xf << 8)
-#define RK3576_RGB			(0 << 4)
-#define RK3576_YUV422			(0x1 << 4)
-#define RK3576_YUV444			(0x2 << 4)
-#define RK3576_YUV420			(0x3 << 4)
-#define RK3576_8BPC			(0x0 << 8)
-#define RK3576_10BPC			(0x6 << 8)
+#define RK3576_COLOR_DEPTH_MASK		GENMASK(11, 8)
+#define RK3576_8BPC			0x0
+#define RK3576_10BPC			0x6
+#define RK3576_COLOR_FORMAT_MASK	GENMASK(7, 4)
+#define RK3576_RGB			0x9
+#define RK3576_YUV422			0x1
+#define RK3576_YUV444			0x2
+#define RK3576_YUV420			0x3
 #define RK3576_CECIN_MASK		BIT(3)
 
-#define RK3576_VO0_GRF_SOC_CON12	0x0030
-#define RK3576_GRF_OSDA_DLYN		(0xf << 12)
-#define RK3576_GRF_OSDA_DIV		(0x7f << 1)
-#define RK3576_GRF_OSDA_DLY_EN		BIT(0)
-
 #define RK3576_VO0_GRF_SOC_CON14	0x0038
 #define RK3576_I2S_SEL_MASK		BIT(0)
 #define RK3576_SPDIF_SEL_MASK		BIT(1)

-- 
2.50.0


