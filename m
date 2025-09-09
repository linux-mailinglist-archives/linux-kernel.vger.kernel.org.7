Return-Path: <linux-kernel+bounces-807999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C20BEB4ABED
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E014E1B217D5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338AE32142C;
	Tue,  9 Sep 2025 11:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmodOF5C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA79320386
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 11:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417337; cv=none; b=Mq+vZ244R6O2+B+OjPedByg0h87UNcWki16qDtZbmrhbaP3uC/6bmiKe+NdsTyUjiwIE932QCiw2Y37GU+s7KWoekYo4yAOfKMqKoOoElSv6aCQC63X48PD/SvHbCsiSaprnAm4zs7QknUgc76XysZWAjLOdt3UGfqkBYN8iku0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417337; c=relaxed/simple;
	bh=Egw7h0VZpXs5tgL5vzoN8ns5makVBNBrNokzbdRQY4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HN0sbP9yZ38BBBY0sXub/zcYEybDrc8o65ffXj2dtr30JKS/fhcDSCAXG6rlNNQp/rALhUQQ1TmY8oBc1gUel4lMSBeyAC+oE5lTdv7V8Ncbm/FMSCi9O6l9gPncH2XN3n0dVoNWhuHDnBktx2aS8cswd2p46OXKEv4eQcbETkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmodOF5C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8ECCC4CEF7;
	Tue,  9 Sep 2025 11:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757417337;
	bh=Egw7h0VZpXs5tgL5vzoN8ns5makVBNBrNokzbdRQY4s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dmodOF5CRBsUowJYyvBF7Rl5d0dMoS4w9lQosU6NaAmAnlUkAPLqP7CTgn+R1IkQm
	 Y4jH4wDOD/q97SKkqakLlH5lgCZt70GqyHm0A0XRH6mC0zbIcChzR7rdNZxH+Qy7Ky
	 HZ6ZfUvLg7rG3CSR2+AaX+R0dH+vNCWPC6IWMti+62S+46xVrCafM2Ou1Sjb2m6FGk
	 LBc9j0/mVT2OWzCca0YS6FuLtOAFlEL/UV+invbrWccRwAO7boygmZ2fwT06ClsZug
	 QxYxA5Pfx/W1TfNav+xCyobizXYfMtSMYMvVEbKF8zCsl70KwtXad3VipKEUb3z+vC
	 IeH1qSVLT8eWw==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 09 Sep 2025 13:27:43 +0200
Subject: [PATCH v3 24/39] drm/mediatek: Switch to
 drm_atomic_get_new_crtc_state()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250909-drm-no-more-existing-state-v3-24-1c7a7d960c33@kernel.org>
References: <20250909-drm-no-more-existing-state-v3-0-1c7a7d960c33@kernel.org>
In-Reply-To: <20250909-drm-no-more-existing-state-v3-0-1c7a7d960c33@kernel.org>
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
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBkH+HUqU3i/bM45HMOb3/izYaNgp5Mx61n3h3Z/GhPld
 v2673m1YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAExEL4Sx4YLQmvt+bz9w9Zoc
 Svwvd28OQ1Jv4as9/6ebrtaoiIn6df3Mh7tTlLhzdHmLFobM3j3nNGPDqtWnn7t5rHzM1fKb94B
 A9Ql7gWuGd7+6ebnXBz86P3P+rtdOf07w+U9Id9kkU8zrlOUMAA==
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


