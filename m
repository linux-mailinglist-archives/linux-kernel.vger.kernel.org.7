Return-Path: <linux-kernel+bounces-777873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E1CB2DEBD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 661EE5E0D24
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691A5265606;
	Wed, 20 Aug 2025 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwJiw6Pn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BC031E115
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755698556; cv=none; b=BG+bS5uJpu9Qr/7/D+DaZbiccdy0B3RBYQEl6H2It+enjpK7P0ObMytYPQujp9rmx+nTZVaftnu0cg7RdCK8kgqZZLhoT9eI3J6PbsvnT4JIgIWh1nJ5HtbvZOhTL03DGNkQ4fOR8Zjiit25fubKvqxOcauElKR4zuCSDLG+FnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755698556; c=relaxed/simple;
	bh=s2llZ0k+yYexhA4HqHlu5vUMb5GbEApSzgjjYzPkoHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GN/Gd5prUFw121oE8BXBT3eCqwkJrhE6iYMmqzdoAu429/Bm8vu/R35bhnqQrWrxvAJEw45x3T6nW++URBt7y58hAzce9vod+zyIgXfRL0Ax+O+FJjjfKIDhLcnMEqrlHnefLR+2/xkHOvNzSxcT7s2O9trfyCyFLWc32Yy1EVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwJiw6Pn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A880C116B1;
	Wed, 20 Aug 2025 14:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755698556;
	bh=s2llZ0k+yYexhA4HqHlu5vUMb5GbEApSzgjjYzPkoHQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pwJiw6Pns/UXg1TBsc42AYgtcJ9Xatj5vqaukipq2fqO75PKrRH2ikEiN78ORKusW
	 2W2JPSB5n6CJthc6EHUyOyHo+/pdz1rNSkKTpcBeAMpjzaQj/a4t4tLwNXcBB2WrMj
	 bba4BWlffUtJyVACmYvQ8aof/BqBG3yuyoxNEYJbAo/1Cnx/JEgADjpLmpC/oNpcR/
	 UNMH4tuGTL/8WnSKQQcCx1SbkAe8w+w79ztydDSF9yQZj2bILb2w+uv68Ww8lgAOI9
	 nxsGjREHrWRhCKGI9LDYJkX26149AEkZ9zgksuzvS6DG4Kxc1wuzaUq2Ndv2yuFzjH
	 Zynj19z7bg37Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 20 Aug 2025 16:01:53 +0200
Subject: [PATCH v2 13/14] drm/tidss: dispc: Switch OVR_REG_FLD_MOD to using
 a mask
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-drm-tidss-field-api-v2-13-43cab671c648@kernel.org>
References: <20250820-drm-tidss-field-api-v2-0-43cab671c648@kernel.org>
In-Reply-To: <20250820-drm-tidss-field-api-v2-0-43cab671c648@kernel.org>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3457; i=mripard@kernel.org;
 h=from:subject:message-id; bh=s2llZ0k+yYexhA4HqHlu5vUMb5GbEApSzgjjYzPkoHQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBlLr4bksKTnPg05JSo4OcL9vmPOkWMM51VmBV8V/+ryn
 vPmxZNhHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiBi8Ya3i5Hm75E71ZpZQv
 6MfWYF8tSYboTz4sgTsC7JXP3Fh99XF78Bke2WIVn33NnAlaDb9zGOsMfB70LFis27fTd+melXm
 WJ1/x6tfaF+seyT7H++zh3fbg6t0C95gZHZzKhFT/TnxfxAoA
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
index c5cad1ddcccfbf1d0b6fb53773bb3aff428ef493..99d3a84a5b40e1e791300199d6b3da9a12d11f80 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -645,17 +645,17 @@ void tidss_disable_oldi(struct tidss_device *tidss, u32 hw_videoport)
 		u32 _reg = dispc_vp_read(_dispc, _vp, _idx);		\
 		FIELD_MODIFY((mask), &_reg, (val));			\
 		dispc_vp_write(_dispc, _vp, _idx, _reg);		\
 	})
 
-#define OVR_REG_FLD_MOD(dispc, ovr, idx, val, start, end)		\
+#define OVR_REG_FLD_MOD(dispc, ovr, idx, val, mask)			\
 	({								\
 		struct dispc_device *_dispc = (dispc);			\
 		u32 _ovr = (ovr);					\
 		u32 _idx = (idx);					\
 		u32 _reg = dispc_ovr_read(_dispc, _ovr, _idx);		\
-		FIELD_MODIFY(GENMASK((start), (end)), &_reg, (val));	\
+		FIELD_MODIFY((mask), &_reg, (val));			\
 		dispc_ovr_write(_dispc, _ovr, _idx, _reg);		\
 	})
 
 static dispc_irq_t dispc_vp_irq_from_raw(u32 stat, u32 hw_videoport)
 {
@@ -1483,29 +1483,29 @@ static void dispc_am65x_ovr_set_plane(struct dispc_device *dispc,
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
@@ -1536,11 +1536,11 @@ void dispc_ovr_enable_layer(struct dispc_device *dispc,
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


