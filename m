Return-Path: <linux-kernel+bounces-891226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F3EC4230B
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 02:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 380AD425EC3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 01:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20A22D23A8;
	Sat,  8 Nov 2025 01:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="av5z72X9"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED092BD00C;
	Sat,  8 Nov 2025 01:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762563908; cv=none; b=urEWXXcNBF+Nx3+vo34vkVCzXqV+p5+3y8icnoZMH6IQsYDyJ9/7OgCTI1ErjLH4Rfvi99XICVR8b46mF1uVu4p7Nfn0P7mEHg51bOR3CxiXASGxoLqPhoydiveK/bQ9X8mPTk6JZjJscxD6UZx4K9p5Xi1g5AzTUVG0/6DnhPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762563908; c=relaxed/simple;
	bh=rcaF2LorUPpcp1UoClh6v6q1v5E8XD+OGpP+/qhTLDc=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=L4vPNU9/k0zqCrsVQk8a55JBe4jprHXzkMXU1umhYrCcmcwIncnL3W2+ANfVrDDHVXMm+3YEfQZpCL0mc+ArEyap4+R99JOz2t08rCvPIQvnV8jAIysRYC3VV5v6LxdDth72YlGNYIKEuVUO7oKQYTxKAFtxRF5FkcQr1xvfvGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=av5z72X9; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251108010504euoutp02a1e8506f2ff46898975bf6ef7f8cbe3a~14ohO5j2E3059730597euoutp02B;
	Sat,  8 Nov 2025 01:05:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251108010504euoutp02a1e8506f2ff46898975bf6ef7f8cbe3a~14ohO5j2E3059730597euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1762563904;
	bh=sLkroN0kK8vOgsvUZLol3ymYXaJvmpdlu3H4vNZDB3s=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=av5z72X9vmTVJIgfjcDYU+G0AaynjZtJ4mCte9ed7AUmAdsK7KAF7xkAGAF92Ub7H
	 KZiTH+M137p34eEhMZknG/ck9WNu0c+8bRbAC72Bndo1XHMTRsw4t+BnQ5zIK56ZqZ
	 2NPrKnV6bKroX+seOmnySYaUNIxjvQ0+f7EGYcC8=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251108010503eucas1p1be26568a176a11990d8d89487531803d~14ogR-4ZD2620826208eucas1p1B;
	Sat,  8 Nov 2025 01:05:03 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251108010501eusmtip2aea0981d662f58554103fd4806fde1fb~14oe4RNVP2515425154eusmtip2b;
	Sat,  8 Nov 2025 01:05:01 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Sat, 08 Nov 2025 02:04:41 +0100
Subject: [PATCH RFC 07/13] drm: bridge: inno_hdmi: Add .disable platform
 operation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-jh7110-clean-send-v1-7-06bf43bb76b1@samsung.com>
In-Reply-To: <20251108-jh7110-clean-send-v1-0-06bf43bb76b1@samsung.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>,  Conor Dooley
	<conor@kernel.org>, Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
	<krzk+dt@kernel.org>,  Emil Renner Berthing <kernel@esmil.dk>,  Hal Feng
	<hal.feng@starfivetech.com>,  Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Xingyu
	Wu <xingyu.wu@starfivetech.com>, Vinod Koul <vkoul@kernel.org>,  Kishon
	Vijay Abraham I <kishon@kernel.org>,  Andrzej Hajda
	<andrzej.hajda@intel.com>,  Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,  Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,  Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,  David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,  Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,  Lee Jones <lee@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,  Paul Walmsley
	<paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>,  Marek Szyprowski
	<m.szyprowski@samsung.com>, Icenowy Zheng <uwu@icenowy.me>,  Maud Spierings
	<maudspierings@gocontroll.com>, Andy Yan <andyshrk@163.com>,  Heiko Stuebner
	<heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-phy@lists.infradead.org, 
	dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20251108010503eucas1p1be26568a176a11990d8d89487531803d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251108010503eucas1p1be26568a176a11990d8d89487531803d
X-EPHeader: CA
X-CMS-RootMailID: 20251108010503eucas1p1be26568a176a11990d8d89487531803d
References: <20251108-jh7110-clean-send-v1-0-06bf43bb76b1@samsung.com>
	<CGME20251108010503eucas1p1be26568a176a11990d8d89487531803d@eucas1p1.samsung.com>

The Innosilicon HDMI driver supports platform-specific behavior through
the `inno_hdmi_plat_ops`. While it provides an `.enable` hook for
platform-specific power up sequences (like enabling PHYs), it lacks a
corresponding hook for power down.

This patch adds a new `.disable` op to the `inno_hdmi_plat_ops` struct
and calls it at the beginning of `inno_hdmi_bridge_atomic_disable()`.

This allows platform specific drivers, such as the StarFive JH7110,
to implement their own power down sequence (e.g., calling
phy_power_off() and clk_disable_unprepare()).

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/gpu/drm/bridge/inno-hdmi.c | 4 ++++
 include/drm/bridge/inno_hdmi.h     | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/inno-hdmi.c
index 9a2370ed2f208caf3dafb4a4d8884516d489263c..37ed7169bfce755cc5bddca16c78d4f112ea33e6 100644
--- a/drivers/gpu/drm/bridge/inno-hdmi.c
+++ b/drivers/gpu/drm/bridge/inno-hdmi.c
@@ -887,6 +887,10 @@ static void inno_hdmi_bridge_atomic_disable(struct drm_bridge *bridge,
 					    struct drm_atomic_state *state)
 {
 	struct inno_hdmi *hdmi = bridge_to_inno_hdmi(bridge);
+	const struct inno_hdmi_plat_ops *plat_ops = hdmi->plat_data->ops;
+
+	if (plat_ops && plat_ops->disable)
+		plat_ops->disable(hdmi->dev);
 
 	inno_hdmi_standby(hdmi);
 }
diff --git a/include/drm/bridge/inno_hdmi.h b/include/drm/bridge/inno_hdmi.h
index 019680622324197e046a1c606ec25aabe95537b4..ca554c525fd6bf63a4a8b9721e967bc473492f0a 100644
--- a/include/drm/bridge/inno_hdmi.h
+++ b/include/drm/bridge/inno_hdmi.h
@@ -16,6 +16,7 @@ struct inno_hdmi_i2c;
 
 struct inno_hdmi_plat_ops {
 	void (*enable)(struct device *pdev, struct drm_display_mode *mode);
+	void (*disable)(struct device *pdev);
 };
 
 struct inno_hdmi_phy_config {

-- 
2.34.1


