Return-Path: <linux-kernel+bounces-795846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9994B3F8A5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744483BF516
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800AB2EAB6B;
	Tue,  2 Sep 2025 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nO1RXdRh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C066D2E62D9
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802019; cv=none; b=ezuo0WvCr8LMnTMeosUEHHO6qWYqCNJ29NL3OTdcB6QCh+r/CYzEjPPmr8kMQ3abWGKFzaqbe4hTfoIkJI8/4Y5nkgkEmwPPimwV12DXWJBpfDvhyvC+NS/GzZ40HEWQsF7N38CjBV8l0+XPU82UTcqCu7rISF7Myez6L7Pqitc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802019; c=relaxed/simple;
	bh=z+A1qZGL7VMjPd92l+hRCbPOUgjuh0UPwrQCvSvdcls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UpR/8fLTx5aA8/wKHEzQn3xQg5p9itknWml7llG3UEI6ciPVk05qiGs/n1M5c9ETwV1W2bcNr6lruXWg9PySBSw66RF+8MhBuEYUPvJXt/YkZgGwHNwff/nqY+OJXo/rDhNJBYvdhs4XMQjbgP+ge6bN5fFQiUXDgJNYdRmVqRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nO1RXdRh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5F6C4CEF7;
	Tue,  2 Sep 2025 08:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756802019;
	bh=z+A1qZGL7VMjPd92l+hRCbPOUgjuh0UPwrQCvSvdcls=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nO1RXdRhou3rnO387KEmD3xYdnkOSUI1KxHjtDMQZkmuaAydK7rjJtCxMp9k6cssv
	 wSIluBfdrN0EVuGd/9huGJgKEe06fqefwjjknEX33ONongTLFs+9Z9vNIqWfLDizO6
	 8sCSZpm5BT9rTxD+7aBJ+fuihXCnxExbwi/46KCnsIAWxMwT38zuaKqgXeNNhFY9AC
	 tiuxNzw+pW+gwU6yvYgYOmaZc8bfCwPbnxUWD6YjyKbz+m/ttX1BU4UBgsDGciLiGQ
	 6VrHR2YnvAhd3QfoWRHvto9OwpgD7SAclsbaxmHWzB+BEwcDhZlPELIZZqZcumEleT
	 56hvMWnPaRY7Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 02 Sep 2025 10:32:39 +0200
Subject: [PATCH 11/29] drm/crtc: Drop no_vblank bit field
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-drm-state-readout-v1-11-14ad5315da3f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1105; i=mripard@kernel.org;
 h=from:subject:message-id; bh=z+A1qZGL7VMjPd92l+hRCbPOUgjuh0UPwrQCvSvdcls=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBnbVu+svxTk6SFz0nA+r7BBWlfdUbXy0B1NfVqcUa3/Z
 NYl92/omMrCIMzJICumyPJEJuz08vbFVQ72K3/AzGFlAhnCwMUpABNZqs9YZ68mH/30i+Wl62cu
 eTz+fO1yEM8E62nTbBMMd8xr91rlraszN/vfhWTn2RJKgukC1XcvMtbX+f/L3P3a7n5N+I5N7DL
 LruV4Xv2w/5+Xy2kjtr1ufX81LtvMXH3yX+tt0498TBmcmowA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The no_vblank field in drm_crtc_state is defined as a bit-field with a
single bit.

This will create a syntax issue with the macros we'll introduce next,
and most other booleans but the *_changed ones in drm_crtc_state do not
use a bit field anyway.

Let's drop it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 include/drm/drm_crtc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index c462bd9b2f7d3ae08e669463717002e5f78122fe..11e3299cfad1572c6e507918c7cceae7a28ba4cf 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -184,11 +184,11 @@ struct drm_crtc_state {
 	 * &drm_crtc_state.no_blank == true is valid and usually used when the
 	 * writeback connector attached to the CRTC has a new job queued. In
 	 * this case the driver will send the VBLANK event on its own when the
 	 * writeback job is complete.
 	 */
-	bool no_vblank : 1;
+	bool no_vblank;
 
 	/**
 	 * @plane_mask: Bitmask of drm_plane_mask(plane) of planes attached to
 	 * this CRTC.
 	 */

-- 
2.50.1


