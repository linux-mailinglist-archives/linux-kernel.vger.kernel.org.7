Return-Path: <linux-kernel+bounces-788529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF59B385E9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E501B64E6A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07FC2765CD;
	Wed, 27 Aug 2025 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEOrzaeR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0861C276027
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307570; cv=none; b=iyBcqiMk5TdxBiTzKqCKh398g0q4KMZ8wU9BRT5NGfQtMu/2jqX7kBncLLjOm+Ne7rLF4woTq591w7yBTPvkO/7HhqZLWtLGWB6lxlsVwLDLGtjK9ZD2Z7rN9wcEdY+cawWZpeQYpFP1awgZxcMgSDUjcJsqSW+vciSjnxYcf5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307570; c=relaxed/simple;
	bh=CScdAF88DJpHJzjNw1q6hQx+PlMuLPDsFTEZ17iufnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LgVa1X9F1zQmuiAoWBkSBvuqa+lul0hvHfEMwiHy8uRmHl7R5ofBtMjfKaaaq1ws9UtmV5bCQWeSdWhmdGlCwhvjCA/x2U/fTTy8a1+drkkFMKEeFLOrz/tY4noLWEbejvNJJRhbEJTgjARS1ijEXwI5BMKFpQauYfIi7PXJasQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEOrzaeR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F85C4CEEB;
	Wed, 27 Aug 2025 15:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756307569;
	bh=CScdAF88DJpHJzjNw1q6hQx+PlMuLPDsFTEZ17iufnQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TEOrzaeRl5nxx4lQVWJmj2cB+JTvQ16ig6E0LRLeevFI1NjBu/PuHAIRE/Nv7qQ6E
	 Z/j6HEbpBxCAL59fm1Z6Xf1RfsAvkyEZnvRfneIDGmJAHtZbYIJnuJeykBretXDGBL
	 zEVYGx2G6ieITfdlITM4nf9nen9jaI7GPs1nRW3d0X+g5t+APn7FUKVaHyZobXoouA
	 nEeqCXPM9++IaaXViR77xtn45RKU2b+Je1mxxlLzYWs2kjOtVVw51xa53A8GGIAxU/
	 HnorzV4pI43LxuJMH3W9F7mDrbbQEpb9R9RnY9uZYcXCvcT4RYdKmoM+NQPcZS6xNY
	 vQR97GiGpUPRw==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 27 Aug 2025 17:12:33 +0200
Subject: [PATCH v3 02/14] drm/tidss: dispc: Convert accessors to macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-drm-tidss-field-api-v3-2-7689b664cc63@kernel.org>
References: <20250827-drm-tidss-field-api-v3-0-7689b664cc63@kernel.org>
In-Reply-To: <20250827-drm-tidss-field-api-v3-0-7689b664cc63@kernel.org>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5528; i=mripard@kernel.org;
 h=from:subject:message-id; bh=CScdAF88DJpHJzjNw1q6hQx+PlMuLPDsFTEZ17iufnQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBnrFZLT7q1gvy1SbNi0d6KIdfmD6C8X+eoMCl+cbtzqN
 UnERGxRx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZhIyXXGhmUu/H57tm6eLX46
 8KfqxI/fvD6/V6g+X7Blk2qycs+kFBeedcvO3+st2eDx0qt+7gcjdcaGN9xHFs/w0zrzyancSF+
 g5mufWUfhk669k/SfxmVHJvuFWL06ldXxZv/3Rx9TvIQ7PrIDAA==
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
index 71031c3ad60e5a2c99a9a0981c85d246a1a42dc6..6231e1aa07fdfa4ea1265b8239e561972dbba8f3 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -592,76 +592,86 @@ void tidss_disable_oldi(struct tidss_device *tidss, u32 hw_videoport)
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


