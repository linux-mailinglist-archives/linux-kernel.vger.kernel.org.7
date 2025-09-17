Return-Path: <linux-kernel+bounces-821050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A48A7B803E6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B48481898544
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52422DECA3;
	Wed, 17 Sep 2025 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHrPCZzz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E212258A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120439; cv=none; b=VaM0sbioDLFKyqwGK0w/RsgX7EvFv4Ri72OrFPXauGwecFIznx11nrBy59yX8IPVkgS+mNg32NOPhPF+yJDctYnbjTnUp1zHfcCg+COgckqmS7zGZNFzlFViquHgWR+S7fenoynO42Buz6ISJjgVKHJNspeW/I3zLGIcFb27WQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120439; c=relaxed/simple;
	bh=Egw7h0VZpXs5tgL5vzoN8ns5makVBNBrNokzbdRQY4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gep5o9lwJS1eUM/igc75R3ByLh1usDEOeww/FPo8KiMRnmyX35ugvCtlQ0lJBWouibOJM8o524g/pqQoZEvvjwVPu3L2br9O0n8StBS5SHeGxTFFJ0IPtHzzGvfVG52YlyceyfEYBlSirC2KeixIfjegLZjAP9ZbofahgYosM90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHrPCZzz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42EB0C4CEE7;
	Wed, 17 Sep 2025 14:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758120438;
	bh=Egw7h0VZpXs5tgL5vzoN8ns5makVBNBrNokzbdRQY4s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XHrPCZzzo4arxdGq2Fjy72nPVL5xfvPaaqzN0GM9XCFPS1XF1q/qPng6ipmZIFOXJ
	 qNfT/cKGzPPPGE/NXlHiFE6b/mUjjxASkcxTlHnQeUT5IQcnIB4RueZfvr01JyxWWK
	 VNoPF7NzikQOPb5nZ6Dblo5DM206u92qFoXCNbWsglcNoaZ1RGoKygiQ1VsHzpNV0i
	 01qvOcC06Y7N31oJKQ21RgjGVFZALorgLPYYPQ4s7alX//rbzMfJgAOdROCSPDngxY
	 WxpdMd5vAA2kqSb5T4KNDU5XDy1z+8nVotsZO29Fh8k7UZp1x9zRijbtdZOKMF/mQD
	 aFE2J54GQrRgA==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 17 Sep 2025 16:46:05 +0200
Subject: [PATCH v4 24/39] drm/mediatek: Switch to
 drm_atomic_get_new_crtc_state()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-drm-no-more-existing-state-v4-24-5d4b9889c3c8@kernel.org>
References: <20250917-drm-no-more-existing-state-v4-0-5d4b9889c3c8@kernel.org>
In-Reply-To: <20250917-drm-no-more-existing-state-v4-0-5d4b9889c3c8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1747; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Egw7h0VZpXs5tgL5vzoN8ns5makVBNBrNokzbdRQY4s=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBmnTq5MkZn7k78+Vt3t7aGQw5atncFrLylzJu0812dsP
 o3FR3Jhx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZiIUgJjfalmUdL11omP80Pv
 3BeNZ/Nd9Cfn96FJk3Pny8lGZRrxPZv76P5jNgXpTZPXWJw3UbfbzljF/Lnw6oo153p5NKznqxV
 E7D4yK8jF482d2QVLFxpc3nXj8DybVS0FaZp7bVcui5UMKeMDAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The mediatek atomic_check implementation uses the deprecated
drm_atomic_get_existing_crtc_state() helper.

This hook is called as part of the global atomic_check, thus before the
states are swapped. The existing state thus points to the new state, and
we can use drm_atomic_get_new_crtc_state() instead.

Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
To: Matthias Brugger <matthias.bgg@gmail.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/gpu/drm/mediatek/mtk_plane.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_plane.c b/drivers/gpu/drm/mediatek/mtk_plane.c
index cbc4f37da8ba81ff9c8b3b58f66363837ffc21ec..d4486a63a6e01f02b6777522440dee8e39d51bf1 100644
--- a/drivers/gpu/drm/mediatek/mtk_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_plane.c
@@ -120,11 +120,12 @@ static int mtk_plane_atomic_async_check(struct drm_plane *plane,
 	ret = mtk_crtc_plane_check(new_plane_state->crtc, plane,
 				   to_mtk_plane_state(new_plane_state));
 	if (ret)
 		return ret;
 
-	crtc_state = drm_atomic_get_existing_crtc_state(state, new_plane_state->crtc);
+	crtc_state = drm_atomic_get_new_crtc_state(state,
+						   new_plane_state->crtc);
 
 	return drm_atomic_helper_check_plane_state(plane->state, crtc_state,
 						   DRM_PLANE_NO_SCALING,
 						   DRM_PLANE_NO_SCALING,
 						   true, true);

-- 
2.50.1


