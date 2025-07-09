Return-Path: <linux-kernel+bounces-724484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C50AFF37B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 080B25C1237
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDCD2475CD;
	Wed,  9 Jul 2025 21:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="C+sVnVTW"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E92B24728C
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 21:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752094908; cv=none; b=ilLtHl5faRdnVjXqQAb/mNDKOau65P8qUH7Hge8cdli+6lrqCuz+REIy9Ki/gRZVYJuAEysHjnfO601n6OyT11uiUDptTYnhIMnRJYozYvB+zJsCS+j76SS2ZGlhRbDXuKan4cE0ZQXr4bntiRtt3MeH7JQgVyQIhBnMaBGIAzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752094908; c=relaxed/simple;
	bh=D8TzrcIjbemRr2OziedwcPlGRxQQvGN6+6+xghPiZ2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QHMPb3WNZhIlo2eLa/mnly8etBE1phoZaO2aSmc/WlAiUDBQeJNY61/4CY1bQp4AyRmiOydkmz5aHdQAzfAXTaigIeWKG8PQIyCA5r5wF2BNM4e66cP+qls/Fxfv3FSqcObxR/59+KUk0wedr439sXgay5G+uRotKNF00Uc6n4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=C+sVnVTW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752094905;
	bh=D8TzrcIjbemRr2OziedwcPlGRxQQvGN6+6+xghPiZ2I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C+sVnVTW5fWfSKlo+cQRNfNSRi8oSpH2x25GzqbX4pr11Zw9KZx0IiztSEJJpKUFH
	 ODHA38/sMtG5sIDQ5CYvd9LwAHqcrNZMkw05JFFMrMHerwgAN7SfUwWNWttx8J519s
	 ofY6m8fDAwo8gs/lUfkWDNNJcDfk+FuZi0cXL402MZfVlXzom7dpGjLXls1WnUqgtP
	 DRLuKF0MRZR7aB2lnT0KZD4FpEhVgSv0JKqZ/aSZNv9D1TihvGFSxsWczaJF1cekhA
	 yf+OkWkqeFSnnaH5QRdVgRbWFBZsDpxUcz7jmdOpe7ZFUXL657ed4c0Cx1QnVcN4+a
	 m5hfqGx6b3Fdg==
Received: from localhost (unknown [212.93.144.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 4439B17E0657;
	Wed,  9 Jul 2025 23:01:45 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 10 Jul 2025 00:01:16 +0300
Subject: [PATCH v2 5/6] drm/rockchip: dw_hdmi_qp: Provide ref clock rate in
 dw_hdmi_qp_plat_data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-rk3588-hdmi-cec-v2-5-f5884be34bc1@collabora.com>
References: <20250710-rk3588-hdmi-cec-v2-0-f5884be34bc1@collabora.com>
In-Reply-To: <20250710-rk3588-hdmi-cec-v2-0-f5884be34bc1@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

In order to support correct initialization of the timer base in the HDMI
QP IP block, setup platform data to include the required reference clock
rate.

While at it, ensure plat_data is zero-initialized in
dw_hdmi_qp_rockchip_bind().

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index 39b46327afd8e4753d96962fad66792d22b33402..5280383febe25cf579c306ec1642557600595e58 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -431,14 +431,15 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 				    void *data)
 {
 	struct platform_device *pdev = to_platform_device(dev);
+	struct dw_hdmi_qp_plat_data plat_data = {};
 	const struct rockchip_hdmi_qp_cfg *cfg;
-	struct dw_hdmi_qp_plat_data plat_data;
 	struct drm_device *drm = data;
 	struct drm_connector *connector;
 	struct drm_encoder *encoder;
 	struct rockchip_hdmi_qp *hdmi;
 	struct resource *res;
 	struct clk_bulk_data *clks;
+	struct clk *ref_clk;
 	int ret, irq, i;
 
 	if (!pdev->dev.of_node)
@@ -508,6 +509,14 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 	if (ret < 0)
 		return dev_err_probe(hdmi->dev, ret, "Failed to get clocks\n");
 
+	ref_clk = clk_get(hdmi->dev, "ref");
+	if (IS_ERR(ref_clk))
+		return dev_err_probe(hdmi->dev, PTR_ERR(ref_clk),
+				     "Failed to get ref clock\n");
+
+	plat_data.ref_clk_rate = clk_get_rate(ref_clk);
+	clk_put(ref_clk);
+
 	hdmi->enable_gpio = devm_gpiod_get_optional(hdmi->dev, "enable",
 						    GPIOD_OUT_HIGH);
 	if (IS_ERR(hdmi->enable_gpio))

-- 
2.50.0


