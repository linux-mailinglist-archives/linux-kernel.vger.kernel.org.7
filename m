Return-Path: <linux-kernel+bounces-837564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DB0BAC9B0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C1D57A71AA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768241B424F;
	Tue, 30 Sep 2025 11:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZczisjP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41DEE555
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 11:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759230074; cv=none; b=aNGtRtOqQ2lNkGTWoBUKTF5c2WqDzmCWYrSoXRjff2ifI6dEAFAGiV+79NYjOKsXMb4TLgscHg21Lx0STEy57u0anXIeCuOPiiI3L1uSmHoB06X134vMCOcdHYtS02eSrU7lj/uQo812TybIOnNhXhp24FqDmz/9TGe0IjMC2I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759230074; c=relaxed/simple;
	bh=NNpca/YuA608VwFWD5syQSnSR7WL3yT9VicGjOlQbus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OL1+VRIrieNMy28Jj4RYZbfc5F5qkvCOKxZBu61Yb8SbEvtV+scO0Ogi4GaoTeiX4klXHBkU61S1ERTEPQ07b1zgG36UM+46DxWwGSCcslDmJxUIL+i8nUG6EfS0R+wv4QSP9yg0Cz4oike3/tgEb9fuoGhoM1Ljf9flG57rfM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZczisjP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093B6C4CEF0;
	Tue, 30 Sep 2025 11:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759230074;
	bh=NNpca/YuA608VwFWD5syQSnSR7WL3yT9VicGjOlQbus=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gZczisjPaJ6ukhHexem/qzlqPVv4YocPy6iaJNBuqaXuL+0xUVzJ2g1QqTg/Awjoc
	 /ov9O0asZrk4HfvOd7rjWniV9GGYjaDU/gKuvA7l4S0M09KDslgJEwvC+lzidBsA9J
	 KsMpK/sbx22r18nJN0hC369sepRIKhDWb92xaUNo7lnDs0r//AFXQKKb1btMpJSpVg
	 WcQme4BE5G4FQTaYpV3FjIuJ3OWx/dk9s2BICSiifHKhi1hPT+JLsyJB9U3vDRPr1f
	 Jmh3kU/NmuDNQIQeMFT3Cj3htKgXL7/CdmNlI6rwjQp7yDAyOppWsS6nVkN3HZrQ85
	 Fz1rjr3qq1itg==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 30 Sep 2025 12:59:39 +0200
Subject: [PATCH v5 24/39] drm/mediatek: Switch to
 drm_atomic_get_new_crtc_state()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250930-drm-no-more-existing-state-v5-24-eeb9e1287907@kernel.org>
References: <20250930-drm-no-more-existing-state-v5-0-eeb9e1287907@kernel.org>
In-Reply-To: <20250930-drm-no-more-existing-state-v5-0-eeb9e1287907@kernel.org>
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
 h=from:subject:message-id; bh=NNpca/YuA608VwFWD5syQSnSR7WL3yT9VicGjOlQbus=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBm3d2j9k69+2mCyWvl4YuGV6wX3zCvNtju8mLL1WZst4
 /5dqs03OqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBE/PsYGx4wT1bSL3+xtuua
 S8xq86wO+xu3b/Z9vtKceX/FDvfOXL/ARQs7Wm7434qUntlU6MW/jLHh7tn4tw1Nxacun/SVvfX
 e64HP07lV7hm9xtZcJa8l87kC2bUeyB390Wm+8rgZY0mw/lIA
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
2.51.0


