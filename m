Return-Path: <linux-kernel+bounces-796004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7211DB3FAB4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0340189757E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346BF2EB874;
	Tue,  2 Sep 2025 09:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ptut55Q6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912912E6100
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756805787; cv=none; b=jwHdcEFpNu4lOeC627xHj2UdZmFYVwEzRKcaoExGTRtq4aNiHkcX4v9NeCAhUg4sEJlGqj6WJEexsNgZSduimwBkNySvmq0ITDFHpHEc460qTyc0GoXnL9THWStG8Xbcim55M277+9omjGWTsqV/QJYHmhRisDxYva2t7ZvryMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756805787; c=relaxed/simple;
	bh=dJ5/w3DQC09hYzOBeDzO8vdUGntb8FaUU2kiZKDKCVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LvwkInax0Hyu6cYfR4qt/2uUNUV1ZxnG/LpTSzb8ipZki5MLJn56hRo17c1QB1XTUazdyPDjAQ5CCm6YVNG5+eUPoC8RweBvg1I5oyT5gcKnnDY0oDBXkpFCw+yqr2CFgx11HeKBeLRK4mm1hAY7e2G0xruRkACItY1242B8vIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ptut55Q6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF964C4CEF7;
	Tue,  2 Sep 2025 09:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756805787;
	bh=dJ5/w3DQC09hYzOBeDzO8vdUGntb8FaUU2kiZKDKCVM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ptut55Q6FQRD0KiWtAAulpB+iqoj+euwo/uyCtSCn32ZlIzl68uIcFXioqP9EoI0w
	 xYiQN3TWmXpSfrYd0nXqA/O1V7Kw6YU5eCs5lOKsuDsnFhZI1LAGnWjUfhxpcpe8Wp
	 tR0CPcT2g2imKiYTrQkd+splpYq93PcXDRMwAYBKZV3avpDFBAuZf7u+WxQBMw5RV3
	 HleuMEBTbLVvDDnSga3t4I2/ANt/U/sQ8EXvAYxk4MOPjzDdY/pTxNfKsEplPjr9N0
	 Oxx4W8LskKB75Jm23ESZ/27Q5b04rsPOA3vVnucoxWFqCESS2hol56II8JSW3vWd+O
	 GkaI2qg3OUBHg==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 02 Sep 2025 11:35:22 +0200
Subject: [PATCH v2 23/37] drm/mediatek: Switch to
 drm_atomic_get_new_crtc_state()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-drm-no-more-existing-state-v2-23-de98fc5f6d66@kernel.org>
References: <20250902-drm-no-more-existing-state-v2-0-de98fc5f6d66@kernel.org>
In-Reply-To: <20250902-drm-no-more-existing-state-v2-0-de98fc5f6d66@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1687; i=mripard@kernel.org;
 h=from:subject:message-id; bh=dJ5/w3DQC09hYzOBeDzO8vdUGntb8FaUU2kiZKDKCVM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBnbdoVKv38Uv7fq7gnjdS9u6BcnNFUU9sifbJroPH3mZ
 guR3aUnOqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBE1r5hrJVzv5f2Ojh2nkud
 ppLS/c+un+VW32rYHHnp50PWVzov5UpD7jBM+f8heX7N+u4pZq9iVzLW10XXrzxvX/g+bcFzpzk
 OQo9c1CdV1F8QvJN0Q+TEpNl+v2yDDixcrRr1T9PBpeDFhKxTAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The mediatek atomic_check implementation uses the deprecated
drm_atomic_get_existing_crtc_state() helper.

This hook is called as part of the global atomic_check, thus before the
states are swapped. The existing state thus points to the new state, and
we can use drm_atomic_get_new_crtc_state() instead.

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


