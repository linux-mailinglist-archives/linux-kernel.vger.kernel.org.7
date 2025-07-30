Return-Path: <linux-kernel+bounces-750419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F479B15B1A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 753EF188EA67
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA478299931;
	Wed, 30 Jul 2025 08:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phBgpn/B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C91293C4E
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753865869; cv=none; b=r60MvKeWhJ2IDbD6KKEKKPfCtQPhd25xq6Nd4VLWP8/QLFhb5i8fExXeIkXLa+zjm70p1NgGtzsFMHLluQhczCGKxAHXvxfd+lAhuIm244e3SaPgeGTK1Fj1Y8oIbq1HBi8ACTIE88r8Uhb8bFhfmNO5/rEoy26VXKZLKMfNNgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753865869; c=relaxed/simple;
	bh=Or3Q43rgPLCeQ0Em2GhlqejtpCoF84H9jnqNFSiNMEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lms9NML0JQ1CnehHrEkLRzjyZ9r5mxsTi58hjGlry2E1qkHMyJQXamtmqospCo+1yl5twUlFg+TCYMj9x8ldJBgLWkvPfbKQ1zGgvft6O7exH/40loWib+0+g7Rd3NLG29ASYdV8QaKnNC50qi1WZq/MlV9PK4uzUeeagtgKmhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phBgpn/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFDFC4CEF9;
	Wed, 30 Jul 2025 08:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753865869;
	bh=Or3Q43rgPLCeQ0Em2GhlqejtpCoF84H9jnqNFSiNMEc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=phBgpn/BCdnYoHpMO+DqzAc+pNJqDTH72SxkLIJefiB35FOMK7m71aHN41OzXln5Y
	 GvHJNlyLUgipFeIMbH6LPHfD+q9uZ8G/+TijJsvx0yZjOcuiN9TyNV7vZIsswRFJRT
	 mL1NNbZbH3ntxJf2rAhSkegBLKqSZ2AK6Oji1Jc613uJqGnRaIWN59w/mm5r5ph8fZ
	 i+KomUjCTeQFZw0DZAjBcD34QxB3M1cJ1GZgnZVU7mY5hR7jLFXZzc5KSIMwcigVku
	 hcSL0z8rMvzy7EfbEuYuySmXgTxc8CDD+rllHyKHXtLPMPRQOzEst7XsTt1scT22pw
	 Aay5340Uc7y2g==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 30 Jul 2025 10:57:13 +0200
Subject: [PATCH 13/14] drm/tidss: dispc: Switch OVR_REG_FLD_MOD to using a
 mask
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-drm-tidss-field-api-v1-13-a71ae8dd2782@kernel.org>
References: <20250730-drm-tidss-field-api-v1-0-a71ae8dd2782@kernel.org>
In-Reply-To: <20250730-drm-tidss-field-api-v1-0-a71ae8dd2782@kernel.org>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3314; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Or3Q43rgPLCeQ0Em2GhlqejtpCoF84H9jnqNFSiNMEc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBmd91J/KOXq/kqce8ywxd363e8FdY8m/rLwZVDNzhDP8
 /9Wtm1Vx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZiITBFjnbb14bniF5KYjVfv
 1p4izBqbJWty+9OLLa72E3d1TDt+ZeJU/pQ/lw50y1268FaB+4mHBmNDs8LbVSnmEql664rYZEO
 lBY+dXfuzzsGAVXpDXbH6ba5M5rCX7PsZN7dd0J9/O0Ld/x0A
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The OVR_REG_FLD_MOD function takes the start and end bits as parameter
and will generate a mask out of them.

This makes it difficult to share the masks between callers, since we now
need two arguments and to keep them consistent.

Let's change OVR_REG_FLD_MOD to take the mask as an argument instead,
and let the caller create the mask. Eventually, this mask will be moved
to a define.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index ba843248749d98f08a2393bc54f92f26bba4223d..088a454271d45aef4ae264c78c627c24d0ef0347 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -649,14 +649,14 @@ static void VP_REG_FLD_MOD(struct dispc_device *dispc, u32 vp, u32 idx, u32 val,
 	dispc_vp_write(dispc, vp, idx,
 		       FLD_MOD(dispc_vp_read(dispc, vp, idx), val, mask));
 }
 
 static void OVR_REG_FLD_MOD(struct dispc_device *dispc, u32 ovr, u32 idx,
-			    u32 val, u32 start, u32 end)
+			    u32 val, u32 mask)
 {
 	dispc_ovr_write(dispc, ovr, idx,
-			FLD_MOD(dispc_ovr_read(dispc, ovr, idx), val, GENMASK(start, end)));
+			FLD_MOD(dispc_ovr_read(dispc, ovr, idx), val, mask));
 }
 
 static dispc_irq_t dispc_vp_irq_from_raw(u32 stat, u32 hw_videoport)
 {
 	dispc_irq_t vp_stat = 0;
@@ -1484,29 +1484,29 @@ static void dispc_am65x_ovr_set_plane(struct dispc_device *dispc,
 				      u32 x, u32 y, u32 layer)
 {
 	u32 hw_id = dispc->feat->vid_info[hw_plane].hw_id;
 
 	OVR_REG_FLD_MOD(dispc, hw_videoport, DISPC_OVR_ATTRIBUTES(layer),
-			hw_id, 4, 1);
-	OVR_REG_FLD_MOD(dispc, hw_videoport, DISPC_OVR_ATTRIBUTES(layer),
-			x, 17, 6);
-	OVR_REG_FLD_MOD(dispc, hw_videoport, DISPC_OVR_ATTRIBUTES(layer),
-			y, 30, 19);
+			hw_id, GENMASK(4, 1));
+	OVR_REG_FLD_MOD(dispc, hw_videoport, DISPC_OVR_ATTRIBUTES(layer), x,
+			GENMASK(17, 6));
+	OVR_REG_FLD_MOD(dispc, hw_videoport, DISPC_OVR_ATTRIBUTES(layer), y,
+			GENMASK(30, 19));
 }
 
 static void dispc_j721e_ovr_set_plane(struct dispc_device *dispc,
 				      u32 hw_plane, u32 hw_videoport,
 				      u32 x, u32 y, u32 layer)
 {
 	u32 hw_id = dispc->feat->vid_info[hw_plane].hw_id;
 
 	OVR_REG_FLD_MOD(dispc, hw_videoport, DISPC_OVR_ATTRIBUTES(layer),
-			hw_id, 4, 1);
-	OVR_REG_FLD_MOD(dispc, hw_videoport, DISPC_OVR_ATTRIBUTES2(layer),
-			x, 13, 0);
-	OVR_REG_FLD_MOD(dispc, hw_videoport, DISPC_OVR_ATTRIBUTES2(layer),
-			y, 29, 16);
+			hw_id, GENMASK(4, 1));
+	OVR_REG_FLD_MOD(dispc, hw_videoport, DISPC_OVR_ATTRIBUTES2(layer), x,
+			GENMASK(13, 0));
+	OVR_REG_FLD_MOD(dispc, hw_videoport, DISPC_OVR_ATTRIBUTES2(layer), y,
+			GENMASK(29, 16));
 }
 
 void dispc_ovr_set_plane(struct dispc_device *dispc, u32 hw_plane,
 			 u32 hw_videoport, u32 x, u32 y, u32 layer)
 {
@@ -1537,11 +1537,11 @@ void dispc_ovr_enable_layer(struct dispc_device *dispc,
 {
 	if (dispc->feat->subrev == DISPC_K2G)
 		return;
 
 	OVR_REG_FLD_MOD(dispc, hw_videoport, DISPC_OVR_ATTRIBUTES(layer),
-			!!enable, 0, 0);
+			!!enable, GENMASK(0, 0));
 }
 
 /* CSC */
 enum csc_ctm {
 	CSC_RR, CSC_RG, CSC_RB,

-- 
2.50.1


