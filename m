Return-Path: <linux-kernel+bounces-788538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF407B38602
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9607898164D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B898F287271;
	Wed, 27 Aug 2025 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f37GYhCa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C5D286D57
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307594; cv=none; b=J6Jtw5ObCz5W08XyMThQ4l6lBA9FhCiSPsX768hco72ui+gDJeslvVJVATR/K9KT6VrO6RclrixIxpkk83tDVt0mrk2o9w1wdaFnMeaiERQwvRNChMXyvYYMRVhhuJ95qx30gSB8ZbB8LacJIIWY7UA+STKCXvUCYGeqbt2jFjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307594; c=relaxed/simple;
	bh=zmr6H3d9cs36J4DJWS1L0PwW2+Xx6ax3N3qSLvVbT3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CPWzOjlVIBYpf/gpV3SD7GUdSMEga9JIB9OoLw0MCyIB58vwSLjxoSFH9qEQcCUoFFGewbmrt2AHVADVycoSa9LKCE7EDw9q5kIKiFMusr6KlhToD4VKQdd2KS8HijfCUOehoKtJdBxbK2f/r6yLm2bv5Yf7i9ghT1SUSdH8V5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f37GYhCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDAEC4CEF5;
	Wed, 27 Aug 2025 15:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756307593;
	bh=zmr6H3d9cs36J4DJWS1L0PwW2+Xx6ax3N3qSLvVbT3A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=f37GYhCaS57OGblrKqt06t9tRcL3esyi9WsrrXc3dVZxBy00JzW0v5ekLMVAmvtwt
	 gHdIC5vStrKzbqzmHYwXSGtZIp/EtNmmwoA7VabEz3E5fWehkT91PUuOviAvxoATrl
	 lpX4Pv2Hk8t9+j4sluh3tFJqNQcv3SFNL6YUxDBCko/M6fbseJMISqZTrm4BUxYMBy
	 7ZVg/GTNPlLWp5vVRnJ4UwYjKggU2/JRKIjNmnF9QqwuM6CHGXkKMzwPgydgF21M41
	 tkVpHtW8l2Xax633iBBOhYvp3o6QX0i+C6AXo42LK78ehr+rGWzgj3wgeE5c3JKS/R
	 KtlDCTJaTBa5w==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 27 Aug 2025 17:12:42 +0200
Subject: [PATCH v3 11/14] drm/tidss: dispc: Switch VP_REG_GET to using a
 mask
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-drm-tidss-field-api-v3-11-7689b664cc63@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2215; i=mripard@kernel.org;
 h=from:subject:message-id; bh=zmr6H3d9cs36J4DJWS1L0PwW2+Xx6ax3N3qSLvVbT3A=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBnrFdJ3J/pX8qgw3pTsmpm9f+G8t7xnQnV9goP3RjKpz
 Ez4seRCx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZjIQXvGhvbIX4dvL/6+U/mi
 tHEKa4Pv7iC7ngKPrhsb9nw6ezxqxh63uI+Pcr/s+fnRddWpSL6w44wNu6frfpd1eTUzQGh+61q
 xpuTgiw4Gb1Sfn9Kqf2XK9rKktLUw9WrDu50G93//eD7117F/AA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The VP_REG_GET function takes the start and end bits as parameter and
will generate a mask out of them.

This makes it difficult to share the masks between callers, since we now
need two arguments and to keep them consistent.

Let's change VP_REG_GET to take the mask as an argument instead, and let
the caller create the mask. Eventually, this mask will be moved to a
define.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 27ac57d770327707c3b6d8bc97a683e4d770cffa..3d807b129c09f1b78016e9d04fa501ed745e5aad 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -617,13 +617,12 @@ void tidss_disable_oldi(struct tidss_device *tidss, u32 hw_videoport)
 		u32 _reg = dispc_vid_read(_dispc, _hw_plane, _idx);	\
 		FIELD_MODIFY((mask), &_reg, (val));			\
 		dispc_vid_write(_dispc, _hw_plane, _idx, _reg);		\
 	})
 
-#define VP_REG_GET(dispc, vp, idx, start, end)				\
-	((u32)FIELD_GET(GENMASK((start), (end)),			\
-			dispc_vp_read((dispc), (vp), (idx))))
+#define VP_REG_GET(dispc, vp, idx, mask)				\
+	((u32)FIELD_GET((mask), dispc_vp_read((dispc), (vp), (idx))))
 
 #define VP_REG_FLD_MOD(dispc, vp, idx, val, start, end)			\
 	({								\
 		struct dispc_device *_dispc = (dispc);			\
 		u32 _vp = (vp);						\
@@ -1258,16 +1257,17 @@ void dispc_vp_unprepare(struct dispc_device *dispc, u32 hw_videoport)
 	}
 }
 
 bool dispc_vp_go_busy(struct dispc_device *dispc, u32 hw_videoport)
 {
-	return VP_REG_GET(dispc, hw_videoport, DISPC_VP_CONTROL, 5, 5);
+	return VP_REG_GET(dispc, hw_videoport, DISPC_VP_CONTROL,
+			  GENMASK(5, 5));
 }
 
 void dispc_vp_go(struct dispc_device *dispc, u32 hw_videoport)
 {
-	WARN_ON(VP_REG_GET(dispc, hw_videoport, DISPC_VP_CONTROL, 5, 5));
+	WARN_ON(VP_REG_GET(dispc, hw_videoport, DISPC_VP_CONTROL, GENMASK(5, 5)));
 	VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 1, 5, 5);
 }
 
 enum c8_to_c12_mode { C8_TO_C12_REPLICATE, C8_TO_C12_MAX, C8_TO_C12_MIN };
 

-- 
2.50.1


