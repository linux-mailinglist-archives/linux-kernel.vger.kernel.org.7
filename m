Return-Path: <linux-kernel+bounces-777861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC07B2DEA5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BE903B9C07
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CC925FA0E;
	Wed, 20 Aug 2025 14:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoZGx48O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2271426B771
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755698527; cv=none; b=giFiGrDnH72o3CXGphalcHnS5zv8NIgkEKbEdZPsJG+Pl/PKA4DvTfb6R+4A+gsgpomBHqxRsmFo8h/hLCJslI7R1p1cHDJ4j6ps4BmDwuZ9zqaZkvZ5UV7rEoIwpwgLEJLYijZIIRMd5PgPza48ipJ1TXoNbCKXA6USSNiULGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755698527; c=relaxed/simple;
	bh=3aNJgeDFD4sfqRbU+o4cUxCdoyeNnLVOpGO7B7cBEt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ntm6puhjZ3nUzVhBd3pXq8vs9CQO/tNWShdVrjt7F3aOnBxEWPsuDwE+bmKuftgWId5zAWfMz6ep09+bdX4T9CezFavWKwb4hBpjFiB4611f+237A9dRBpDDyRvQNsMtmLIEo5wM5Wd4DxHgGSQv1sgrWQ8coeBXWCS08Fed3HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoZGx48O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6925EC4CEEB;
	Wed, 20 Aug 2025 14:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755698526;
	bh=3aNJgeDFD4sfqRbU+o4cUxCdoyeNnLVOpGO7B7cBEt0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DoZGx48Oky4VkB8bQ8tlNarnaLpz5RJqKIGMxMd59F5qtb+Ci2CCDzNb3ZsItmu6c
	 OSxqawWzYbY1wS4oP1PdA4yb7TknxPx1X4tjcSSseq+CNvb/sQiiFn5pOieDI7lgn0
	 GWUArAQHF7VvdSeKlS6YvWLpoKjY+V73I9c1jHgZL4L0sLpF89KdAHwQAm59w+eb2q
	 BuuXiQE/vTRE+Feskut/jnp8o8YTLfFm318wycd9cGnfohnDMF8HINTuphGvEyIHtd
	 9FFdlOEZ3/oOB9NEauODF4nv06VbWyHLfkG2+/qIOsq8EF4Z+orswVTjUtYdY7yQ3U
	 X1QIfggeI3veA==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 20 Aug 2025 16:01:42 +0200
Subject: [PATCH v2 02/14] drm/tidss: dispc: Convert accessors to macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-drm-tidss-field-api-v2-2-43cab671c648@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5528; i=mripard@kernel.org;
 h=from:subject:message-id; bh=3aNJgeDFD4sfqRbU+o4cUxCdoyeNnLVOpGO7B7cBEt0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBlLr/r7JrH953L2rXlbdGT5e2sBHZX8GRlP1C2T2WdPr
 dHZbWPUMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACayJoqx4UjRh/U9mz1fuX7Y
 K/1PNZmB8Z6/+ld/9WTxs9kv61rqdluUzj/ifNzM3oDfz2Z+5t1QxlpJhZsHLj/7/FWPc9n3iFu
 T0tec7b5w4sV8vdqlssdCn1zesOnJ54nX09z/hk3zbbV+cqsJAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The dispc driver uses upper-cased, inlined, functions to provide
macro-like accessors to the dispc registers.

This is confusing, since upper-case is usually used by macros, and that
pattern will create gcc errors later on in this series.

Let's switch to macros to make it more consistent, and prevent those
errors down the line.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 122 +++++++++++++++++++-----------------
 1 file changed, 66 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 8ec06412cffa71512cead9725bb43440258eb1ec..10fbc99621c149f4e119ef4a45867c369ca5df0b 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -607,76 +607,86 @@ void tidss_disable_oldi(struct tidss_device *tidss, u32 hw_videoport)
 /*
  * TRM gives bitfields as start:end, where start is the higher bit
  * number. For example 7:0
  */
 
-static u32 FLD_MASK(u32 start, u32 end)
-{
-	return ((1 << (start - end + 1)) - 1) << end;
-}
+#define FLD_MASK(start, end)						\
+	({								\
+		int _end_inner = (end);					\
+		u32 _mask = ((1 << ((start) - _end_inner + 1)) - 1) << _end_inner; \
+		_mask;							\
+	})
 
-static u32 FLD_VAL(u32 val, u32 start, u32 end)
-{
-	return (val << end) & FLD_MASK(start, end);
-}
+#define FLD_VAL(val, start, end)					\
+	({								\
+		int _end_inner = (end);					\
+		u32 _new_val = ((val) << _end_inner) & FLD_MASK((start), _end_inner); \
+		_new_val;						\
+	})
 
-static u32 FLD_GET(u32 val, u32 start, u32 end)
-{
-	return (val & FLD_MASK(start, end)) >> end;
-}
+#define FLD_GET(val, start, end)					\
+	({								\
+		int _end = (end);					\
+		u32 _ret_val = ((val) & FLD_MASK((start), _end)) >> _end; \
+		_ret_val;						\
+	})
 
-static u32 FLD_MOD(u32 orig, u32 val, u32 start, u32 end)
-{
-	return (orig & ~FLD_MASK(start, end)) | FLD_VAL(val, start, end);
-}
+#define FLD_MOD(orig, val, start, end)					\
+	({								\
+		int _start = (start), _end = (end);			\
+		u32 _masked_val = (orig) & ~FLD_MASK(_start, _end);	\
+		u32 _new_val = _masked_val | FLD_VAL((val), _start, _end); \
+		_new_val;						\
+	})
 
-static u32 REG_GET(struct dispc_device *dispc, u32 idx, u32 start, u32 end)
-{
-	return FLD_GET(dispc_read(dispc, idx), start, end);
-}
+#define REG_GET(dispc, idx, start, end)					\
+	((u32)FLD_GET(dispc_read((dispc), (idx)), (start), (end)))
 
-static void REG_FLD_MOD(struct dispc_device *dispc, u32 idx, u32 val,
-			u32 start, u32 end)
-{
-	dispc_write(dispc, idx, FLD_MOD(dispc_read(dispc, idx), val,
-					start, end));
-}
+#define REG_FLD_MOD(dispc, idx, val, start, end)			\
+	({								\
+		struct dispc_device *_dispc = (dispc);			\
+		u32 _idx = (idx);					\
+		u32 _curr = dispc_read(_dispc, _idx);			\
+		u32 _new = FLD_MOD(_curr, (val), (start), (end));	\
+		dispc_write(_dispc, _idx, _new);			\
+	})
 
-static u32 VID_REG_GET(struct dispc_device *dispc, u32 hw_plane, u32 idx,
-		       u32 start, u32 end)
-{
-	return FLD_GET(dispc_vid_read(dispc, hw_plane, idx), start, end);
-}
+#define VID_REG_GET(dispc, hw_plane, idx, start, end)			\
+	((u32)FLD_GET(dispc_vid_read((dispc), (hw_plane), (idx)), (start), (end)))
 
-static void VID_REG_FLD_MOD(struct dispc_device *dispc, u32 hw_plane, u32 idx,
-			    u32 val, u32 start, u32 end)
-{
-	dispc_vid_write(dispc, hw_plane, idx,
-			FLD_MOD(dispc_vid_read(dispc, hw_plane, idx),
-				val, start, end));
-}
+#define VID_REG_FLD_MOD(dispc, hw_plane, idx, val, start, end)		\
+	({								\
+		struct dispc_device *_dispc = (dispc);			\
+		u32 _hw_plane = (hw_plane);				\
+		u32 _idx = (idx);					\
+		u32 _curr = dispc_vid_read(_dispc, _hw_plane, _idx);	\
+		u32 _new = FLD_MOD(_curr, (val), (start), (end));	\
+		dispc_vid_write(_dispc, _hw_plane, _idx, _new);		\
+	})
 
-static u32 VP_REG_GET(struct dispc_device *dispc, u32 vp, u32 idx,
-		      u32 start, u32 end)
-{
-	return FLD_GET(dispc_vp_read(dispc, vp, idx), start, end);
-}
+#define VP_REG_GET(dispc, vp, idx, start, end)				\
+	((u32)FLD_GET(dispc_vp_read((dispc), (vp), (idx)), (start), (end)))
 
-static void VP_REG_FLD_MOD(struct dispc_device *dispc, u32 vp, u32 idx, u32 val,
-			   u32 start, u32 end)
-{
-	dispc_vp_write(dispc, vp, idx, FLD_MOD(dispc_vp_read(dispc, vp, idx),
-					       val, start, end));
-}
+#define VP_REG_FLD_MOD(dispc, vp, idx, val, start, end)			\
+	({								\
+		struct dispc_device *_dispc = (dispc);			\
+		u32 _vp = (vp);						\
+		u32 _idx = (idx);					\
+		u32 _curr = dispc_vp_read(_dispc, _vp, _idx);		\
+		u32 _new = FLD_MOD(_curr, (val), (start), (end));	\
+		dispc_vp_write(_dispc, _vp, _idx, _new);		\
+	})
 
-static void OVR_REG_FLD_MOD(struct dispc_device *dispc, u32 ovr, u32 idx,
-			    u32 val, u32 start, u32 end)
-{
-	dispc_ovr_write(dispc, ovr, idx,
-			FLD_MOD(dispc_ovr_read(dispc, ovr, idx),
-				val, start, end));
-}
+#define OVR_REG_FLD_MOD(dispc, ovr, idx, val, start, end)		\
+	({								\
+		struct dispc_device *_dispc = (dispc);			\
+		u32 _ovr = (ovr);						\
+		u32 _idx = (idx);					\
+		u32 _curr = dispc_ovr_read(_dispc, _ovr, _idx);		\
+		u32 _new = FLD_MOD(_curr, (val), (start), (end));	\
+		dispc_ovr_write(_dispc, _ovr, _idx, _new);		\
+	})
 
 static dispc_irq_t dispc_vp_irq_from_raw(u32 stat, u32 hw_videoport)
 {
 	dispc_irq_t vp_stat = 0;
 

-- 
2.50.1


