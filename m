Return-Path: <linux-kernel+bounces-704202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92678AE9ABD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 12:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC40B1C413D7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 10:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB5721D584;
	Thu, 26 Jun 2025 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2GmHgjn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1821D21CA0E
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750932312; cv=none; b=kRw4ZAMv/eJDtXUf0r6toDkvX6HTL/7n2w4/pokRH+QlQcqnG0LdS+9urCoVc2SuNr1RdjD3GRNGAmv+pxDUeMMqkAEIY9KFQ387HIqgS/VD8kOpfWZJ9PLis6gblGLjz3hnJ43604g9kGF+/ER6Jf/vNR0lSLYBW9/N+/75ysQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750932312; c=relaxed/simple;
	bh=3k4h3hHEk7NoxoOrxbmYWfStsX8RNDzQCxVAQ8vhmp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DSsIGJb44Pbf/+hc55v4nciZH72Kf7aNPa6a8OzrqpmM/Pd98n1qTFF+PCFvAy26jMCid+fvP/ggDZJTxO16rWYeFnLvTT/2N1qbuhzgC77XsrmUBlPg+7/nfZLnqO2kN64E8nQ4QVq5fi/POb54OV3yxNHogRlfpId0vpkcEwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2GmHgjn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A81C4CEEF;
	Thu, 26 Jun 2025 10:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750932311;
	bh=3k4h3hHEk7NoxoOrxbmYWfStsX8RNDzQCxVAQ8vhmp4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l2GmHgjnAsJeXxSAfGAU6kLeVg9VNE7t4zaaxjBpQh7L4YbnwXYPSCXXCtuhCPba6
	 i7ys+XBB/zN4hpe+Q/4O47xHVsC0viNL2iPaVMOM4H76x5vFaKQnWUWKgxEaVWTEye
	 dP0CdnIzCs4GJBROUdYqJAJkQPWJFZRfkdfTEcP2Lzc5KyJbKPigYqzys+wrhOcGog
	 qAFDN0bSR+ryZ51U11qMrSoPdcqgNyLGhHswT8LO+vHq0E4DpyaCudc6nx9oTtJJnA
	 xa68nMlIaJPZN0GUFPNdM3OLb4hP7KTQRpMBwW4gMs08SvPKG5jgdKjzJUyIOw7eS0
	 xxHn3pX+U5AzQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 26 Jun 2025 12:04:59 +0200
Subject: [PATCH v2 1/5] drm/mipi-dsi: Add dev_is_mipi_dsi function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-drm-panel-simple-fixes-v2-1-5afcaa608bdc@kernel.org>
References: <20250626-drm-panel-simple-fixes-v2-0-5afcaa608bdc@kernel.org>
In-Reply-To: <20250626-drm-panel-simple-fixes-v2-0-5afcaa608bdc@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Anusha Srivatsa <asrivats@redhat.com>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2020; i=mripard@kernel.org;
 h=from:subject:message-id; bh=3k4h3hHEk7NoxoOrxbmYWfStsX8RNDzQCxVAQ8vhmp4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBmx0gHZ6o8/Je6+fHa2yrtogwvnrhzKfL07aUf7iY9/z
 s5e+/vhj46pLAzCnAyyYoosT2TCTi9vX1zlYL/yB8wcViaQIQxcnAIwkfIQxvqMTReXn9SQ8LAW
 3MhdWLXFVvT+WgbP5Adqlz/v/9tZ+vFSeIsLT+T3lCaHSmXLx0VruBgbOnb4f/KvznzL//gVz97
 2yRkvfh0LuiwqL8K57UKNg1azSVK4klSNurbwlycNUtz334QDAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

This will be especially useful for generic panels (like panel-simple)
which can take different code path depending on if they are MIPI-DSI
devices or platform devices.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 3 ++-
 include/drm/drm_mipi_dsi.h     | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index e5184a0c24651756ee0b1eb27d94083d63eb35a7..21fd647f8ce1a6a862e2f8fb5320e701f26f614f 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -89,16 +89,17 @@ static const struct dev_pm_ops mipi_dsi_device_pm_ops = {
 	.thaw = pm_generic_thaw,
 	.poweroff = pm_generic_poweroff,
 	.restore = pm_generic_restore,
 };
 
-static const struct bus_type mipi_dsi_bus_type = {
+const struct bus_type mipi_dsi_bus_type = {
 	.name = "mipi-dsi",
 	.match = mipi_dsi_device_match,
 	.uevent = mipi_dsi_uevent,
 	.pm = &mipi_dsi_device_pm_ops,
 };
+EXPORT_SYMBOL_GPL(mipi_dsi_bus_type);
 
 /**
  * of_find_mipi_dsi_device_by_node() - find the MIPI DSI device matching a
  *    device tree node
  * @np: device tree node
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index b37860f4a895c25ef8ba1c5b3f44827ef53aa100..6d2c08e8110151a97620389197f1ef79c058329d 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -221,10 +221,13 @@ struct mipi_dsi_multi_context {
 
 #define MIPI_DSI_MODULE_PREFIX "mipi-dsi:"
 
 #define to_mipi_dsi_device(__dev)	container_of_const(__dev, struct mipi_dsi_device, dev)
 
+extern const struct bus_type mipi_dsi_bus_type;
+#define dev_is_mipi_dsi(dev)	((dev)->bus == &mipi_dsi_bus_type)
+
 /**
  * mipi_dsi_pixel_format_to_bpp - obtain the number of bits per pixel for any
  *                                given pixel format defined by the MIPI DSI
  *                                specification
  * @fmt: MIPI DSI pixel format

-- 
2.49.0


