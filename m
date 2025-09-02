Return-Path: <linux-kernel+bounces-795865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03395B3F8BD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9131A17C9B5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DD72ECD1C;
	Tue,  2 Sep 2025 08:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fa4BbAHc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CB42ED159
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802064; cv=none; b=IenzNTRbtL+LU21rPPBV7zNCgzUc0rnFECA+oRkEJQSJ4YvxwkOdYRrCpDHSY32WrfU2tGtycmXBnBzRDS1ukKimJ4EeDHvwn0eYvERkHeLHbb2m+XHIWbFoa9WZK59T+fArSg7wCgffkcYnIMzgEguk+rH4rsiP/wNko8eCfZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802064; c=relaxed/simple;
	bh=FvKa2ivxLz16/Yiu4P4OHeqOpBeH6KT8gxfkcoGM39Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BxDdBY0vaiLMifKhec+AURZ2JPaEl0UK60GAkt6Yj4FK2VZBg8ho1EJEWWWS5QP6/pAjqgQCz+TiOd1GfEFk0F9h/9Wvd/aqvF9EgWVx9+7mvYN5Zj0FUrF/jDJv1zMygVdDKx0JbudAnBL6CBMjnAF/g9R2lrdYaS/k4OPgiHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fa4BbAHc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9E3C4CEED;
	Tue,  2 Sep 2025 08:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756802064;
	bh=FvKa2ivxLz16/Yiu4P4OHeqOpBeH6KT8gxfkcoGM39Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fa4BbAHcAfqsB65EzfHlHcC9YA57k8CtW/wMR65eOZJWfw41hdUlwqHDly5AnsJUb
	 3Fx0yJfA/iXVzAFfkUmt26myliq4hY3ZHtRODstWJ2hjOj5EsE8BScPkloTLCJyS1/
	 x533o1FK2MAhQJHm9OuvDFeMRSgdLuufeoIwpqKJAP7Gqy/MAmSKNuquzQzAmvn66m
	 uJ3k5rtafRxYhLOUXF6WUavGs3Mc/JTlt9coganSM4nx/IUufN+SPBnFVpqX79fK8z
	 h7f7clNPYYDp33Go0SlM+5LfGxf70G3VMlwSWd0/4AG1EHi2fMBxsBtZYqYn3SulUx
	 KRUQ/4G+Y3qdw==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 02 Sep 2025 10:32:56 +0200
Subject: [PATCH 28/29] drm/tidss: encoder: implement get_current_crtc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-drm-state-readout-v1-28-14ad5315da3f@kernel.org>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
In-Reply-To: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2462; i=mripard@kernel.org;
 h=from:subject:message-id; bh=FvKa2ivxLz16/Yiu4P4OHeqOpBeH6KT8gxfkcoGM39Q=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBnbVh9ssz+uW2+0puRIyeYIORuRVR9lwnKu1QQmnbxxz
 05DbX9Ix1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZiIdg9jwwSLk5bLDsz7yh3+
 4Zy29sUlAnPcOD7FXXV/8NEuUj3X4WdFY6PGLYXJuVMjNudxheTfYqyzdrggq+jcqLBtxfoPDpx
 lml/qdhkFfxfo2rvi69XHTBMUxa+m39uo84lx1YnDc63e9TsDAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The tidss driver doesn't really care implement anything with encoders,
it just relies on simple encoders, bridges and drm_bridge_connector.

In order to figure out the CRTC -> connector association from the
hardware state, we do need encoder support though, through the
get_current_crtc callback.

Since the tidss encoders are always connected to a single CRTC, we don't
really need to read the hardware state though, we can simply return the
one we know we are always connected to.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_encoder.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_encoder.c b/drivers/gpu/drm/tidss/tidss_encoder.c
index 81a04f7677701b0b1bee204ac9fc5835ac373950..2cb12ab48a48cec453defcb261915e4663806289 100644
--- a/drivers/gpu/drm/tidss/tidss_encoder.c
+++ b/drivers/gpu/drm/tidss/tidss_encoder.c
@@ -79,10 +79,29 @@ static const struct drm_bridge_funcs tidss_bridge_funcs = {
 	.atomic_reset			= drm_atomic_helper_bridge_reset,
 	.atomic_duplicate_state		= drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state		= drm_atomic_helper_bridge_destroy_state,
 };
 
+static struct drm_crtc *tidss_encoder_get_current_crtc(struct drm_encoder *encoder)
+{
+	struct drm_crtc *crtc;
+
+	WARN_ON(hweight32(encoder->possible_crtcs) > 1);
+
+	drm_for_each_crtc(crtc, encoder->dev) {
+		if (encoder->possible_crtcs == (1 << drm_crtc_index(crtc)))
+		    return crtc;
+	}
+
+	return NULL;
+}
+
+static const struct drm_encoder_funcs tidss_encoder_funcs = {
+	.get_current_crtc = tidss_encoder_get_current_crtc,
+	.destroy = drm_encoder_cleanup,
+};
+
 int tidss_encoder_create(struct tidss_device *tidss,
 			 struct drm_bridge *next_bridge,
 			 u32 encoder_type, u32 possible_crtcs)
 {
 	struct tidss_encoder *t_enc;
@@ -93,12 +112,13 @@ int tidss_encoder_create(struct tidss_device *tidss,
 	t_enc = devm_drm_bridge_alloc(tidss->dev, struct tidss_encoder,
 				      bridge, &tidss_bridge_funcs);
 	if (IS_ERR(t_enc))
 		return PTR_ERR(t_enc);
 
-	ret = drm_simple_encoder_init(&tidss->ddev, &t_enc->encoder,
-				      encoder_type);
+	ret = drm_encoder_init(&tidss->ddev, &t_enc->encoder,
+			       &tidss_encoder_funcs,
+			       encoder_type, NULL);
 	if (ret)
 		return ret;
 
 	t_enc->tidss = tidss;
 	t_enc->next_bridge = next_bridge;

-- 
2.50.1


