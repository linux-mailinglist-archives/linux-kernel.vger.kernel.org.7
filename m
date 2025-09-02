Return-Path: <linux-kernel+bounces-795851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73595B3F8AA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A675D203CFE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D332EB84D;
	Tue,  2 Sep 2025 08:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3MwPS61"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2252EB843
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802032; cv=none; b=deUS4PJrS7yCEem2nZbMkCIJz2Qx17Pnq3hwt+4QP41m9M9RMVUWsjdfUDHRhxLkaZI3P0RpLHib14YyYXeYerjpAyyo5kkzUgmSXAN0ptUIZhaj2CX3YcsBwo0T0oq9AihgqJ3UQ0XhwOzRtQFwF84QEV0V3GkHY2JOY4cXltQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802032; c=relaxed/simple;
	bh=nznIDz/RwyFHB64jOttfdGvwW1sYq0eP//HxxKXRQ1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bhCLjbHN3Tw9Qf0pH28OTI4TfbqxuVg9uEPMmNqobNk5LvPQRnGX0iNPBYQ25++xsW2oJpR6mFBUQS1aUABtAXnArINtpV+R6cPyljHVjQuvMf/OuCYg8nr9i97CdQV5z+PegY8ZnhnJrBNlggLH6krHM/xvH3JmBQgdiSitP6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3MwPS61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132B0C4CEED;
	Tue,  2 Sep 2025 08:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756802032;
	bh=nznIDz/RwyFHB64jOttfdGvwW1sYq0eP//HxxKXRQ1Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=f3MwPS61atv4CneDzwNdPsGDTWICZmy+kSOteSJ4gd9jV0Zt+HnoBVbKsI4pcV4Af
	 TEIpiDCZJZhKPDdFESBOcWux1nz53tz5y5hIF9nDHxw22pz3ydUDgVrwNoHhySXfCL
	 wn9Je/Cv/CsVPWY3FekjcLBOd0CHOXn6CsOWEH/HWpd7suAa2qba51LZZvx8mzTToC
	 22M7GtaGEDWaXBqaONNDun5BsyckydSFiHz/y+9XzbPUKJ11JxP8GtnDbJD+MysY0q
	 5EKRSTAzE+Xl3HTa96YQSQVE3Drx183QpIN9GQH/TB+enFphcjF//QzhAPtq3iAnRG
	 z9fi7nVcV8hvQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 02 Sep 2025 10:32:44 +0200
Subject: [PATCH 16/29] drm/encoder: Create get_current_crtc hook
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-drm-state-readout-v1-16-14ad5315da3f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1801; i=mripard@kernel.org;
 h=from:subject:message-id; bh=nznIDz/RwyFHB64jOttfdGvwW1sYq0eP//HxxKXRQ1Q=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBnbVu8WzHvutvnvcvMtkSs+bgqcvGdK8Lk3Ajtk/7782
 fWRmU1aomMqC4MwJ4OsmCLLE5mw08vbF1c52K/8ATOHlQlkCAMXpwBM5KQPYzXb/eSUrSWhCppq
 MWldXF9LD0zdf+nx9I5zHS+z9mc6u9+NMDp4fNfufq7ldw7tnsk65x1jw1yGrYYnNjBY6s3cpjb
 9pfPDyNLspSuurP96rGLVNQZ2x98Li5QWyChOZDrDxCmrUj39AwA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

In order for drivers to implement drm_connectors atomic_state_readout
hooks, they need to query the hardware and lookup the CRTC to set
drm_connector_state.crtc.

It should be easy enough for drivers that are tightly integrated from
the CRTC to the connectors, but if the driver uses bridges, there's no
coupling between the CRTC and encoder, and the bridge driver.

The only thing the bridge has access to is the encoder, but the
relationship between a CRTC and an encoder isn't a fixed mapping at the
framework level, and thus the bridge can't deduce which CRTC is feeding
its encoder.

Thus, let's create a new hook for encoders to implement to return the
CRTC they are currently connected to.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 include/drm/drm_encoder.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/drm/drm_encoder.h b/include/drm/drm_encoder.h
index 977a9381c8ba943b4d3e021635ea14856df8a17d..7abb5e35ac950c941b56fc311a52789bbc427df6 100644
--- a/include/drm/drm_encoder.h
+++ b/include/drm/drm_encoder.h
@@ -86,10 +86,23 @@ struct drm_encoder_funcs {
 	 * @debugfs_init:
 	 *
 	 * Allows encoders to create encoder-specific debugfs files.
 	 */
 	void (*debugfs_init)(struct drm_encoder *encoder, struct dentry *root);
+
+	/**
+	 * @get_current_crtc:
+	 *
+	 * This optional hook is used during initialization to read out
+	 * the initial state by connectors that support atomic state
+	 * hardware readout.
+	 *
+	 * Returns:
+	 *
+	 * The CRTC currently associated with the encoder if enabled, NULL otherwise.
+	 */
+	struct drm_crtc *(*get_current_crtc)(struct drm_encoder *encoder);
 };
 
 /**
  * struct drm_encoder - central DRM encoder structure
  * @dev: parent DRM device

-- 
2.50.1


