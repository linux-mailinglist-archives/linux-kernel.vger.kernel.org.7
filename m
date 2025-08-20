Return-Path: <linux-kernel+bounces-777864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68669B2DEAA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C7D3A68FA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A842727E3;
	Wed, 20 Aug 2025 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYtB5ErV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEFE2701BD
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755698535; cv=none; b=EVayUJtmhD37h1FzpJVk4Ih5VwVMIaOEuhNnLY/yosst8P9DDfJJ3mV3QnDPIifaBHGZVhA7HY+V/KFJvCqja53Rng1ST0Ann4naPs2mGXiIR+kvrEjQ9qXHrEzsWOeUSEuyzNNk9G7eAcTD0I27mIKYRBYM5onFdze9Qew8daA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755698535; c=relaxed/simple;
	bh=xyR3hzCpzN87ckPVufv/z6ICYQymJ/j3pasff2hbc8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dRq6rCTRONISONeE554B/weIaepCqmzMYbd1lZGXmUm2LRxjolhJZZJteNDvNPLuiPD+NnFybOyKqw66QSjbtAKgAxPTRPuvbTJNlQexiMc+zzzhlNHJtz6iuGQRk45ToCtcQliFRVWUkaNcbPKWG6Nj3DkzoqiT6b42DZ+zMTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYtB5ErV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33792C116B1;
	Wed, 20 Aug 2025 14:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755698535;
	bh=xyR3hzCpzN87ckPVufv/z6ICYQymJ/j3pasff2hbc8k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TYtB5ErV4fvxUwUxFJdJId2zr4XBuc+JrtK7H0dcbG87jLZxnFqhn08D2PbKm5hgx
	 poglS74XNq2VihtZYxWkjH6S+BG8wcOLhnIOWIninDGSDjJwMuwHDNhcK0LwcV/5JG
	 hTFRir9avfl5Dl4FykZkCHiKPnvbw4u0MBLW+EAjhOtAbhE3P8gCKBi4HZ6N4ISdaH
	 b4efDa0Zev8Ve7okv9Mpr9t1ZyMbmy8DTGPTOJHDn4vfF9+TskvHezE/YUb91oqfex
	 poais4zzx/orSdloDy1f+C/uSPTE0Im3m49T48t4yK5My4ocoL7uw8mvM3cpihre3F
	 q2EaLGxnStl4w==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 20 Aug 2025 16:01:45 +0200
Subject: [PATCH v2 05/14] drm/tidss: dispc: Get rid of FLD_GET
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-drm-tidss-field-api-v2-5-43cab671c648@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2757; i=mripard@kernel.org;
 h=from:subject:message-id; bh=xyR3hzCpzN87ckPVufv/z6ICYQymJ/j3pasff2hbc8k=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBlLrwZO3H+oSXbpEQGj9O627Ck3Vs7TSvW5zeYyUe7JH
 W9Gps98HVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAi97gZ612lrjjfNqp/cH67
 y+opQnvFXvcoPZ6z9lxA3ceTDycz8voYstlNj4/oT/jxe2H9TFnhNYwN1222Bb3fqLXYdKK5T5i
 LeUnGbEWZH0/LYpJfC2nPaWDZHuqz/DGrkdtfoQ2XzldJvy8GAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The FLD_GET function is an equivalent to what FIELD_GET + GENMASK
provide, so let's drop it and switch to the latter.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index f0568ae3e7bebf481bb5f6d0603dae4b6e6a0729..50d5eda0670e6e090d05af6a2c05e5b88f28c322 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -607,27 +607,21 @@ void tidss_disable_oldi(struct tidss_device *tidss, u32 hw_videoport)
 /*
  * TRM gives bitfields as start:end, where start is the higher bit
  * number. For example 7:0
  */
 
-#define FLD_GET(val, start, end)					\
-	({								\
-		int _end = (end);					\
-		u32 _ret_val = ((val) & GENMASK((start), _end)) >> _end; \
-		_ret_val;						\
-	})
-
 #define FLD_MOD(orig, val, start, end)					\
 	({								\
 		int _start = (start), _end = (end);			\
 		u32 _masked_val = (orig) & ~GENMASK(_start, _end);	\
 		u32 _new_val = _masked_val | FIELD_PREP(GENMASK(_start, _end), (val)); \
 		_new_val;						\
 	})
 
 #define REG_GET(dispc, idx, start, end)					\
-	((u32)FLD_GET(dispc_read((dispc), (idx)), (start), (end)))
+	((u32)FIELD_GET(GENMASK((start), (end)),			\
+			dispc_read((dispc), (idx))))
 
 #define REG_FLD_MOD(dispc, idx, val, start, end)			\
 	({								\
 		struct dispc_device *_dispc = (dispc);			\
 		u32 _idx = (idx);					\
@@ -635,11 +629,12 @@ void tidss_disable_oldi(struct tidss_device *tidss, u32 hw_videoport)
 		u32 _new = FLD_MOD(_curr, (val), (start), (end));	\
 		dispc_write(_dispc, _idx, _new);			\
 	})
 
 #define VID_REG_GET(dispc, hw_plane, idx, start, end)			\
-	((u32)FLD_GET(dispc_vid_read((dispc), (hw_plane), (idx)), (start), (end)))
+	((u32)FIELD_GET(GENMASK((start), (end)),			\
+			dispc_vid_read((dispc), (hw_plane), (idx))))
 
 #define VID_REG_FLD_MOD(dispc, hw_plane, idx, val, start, end)		\
 	({								\
 		struct dispc_device *_dispc = (dispc);			\
 		u32 _hw_plane = (hw_plane);				\
@@ -648,11 +643,12 @@ void tidss_disable_oldi(struct tidss_device *tidss, u32 hw_videoport)
 		u32 _new = FLD_MOD(_curr, (val), (start), (end));	\
 		dispc_vid_write(_dispc, _hw_plane, _idx, _new);		\
 	})
 
 #define VP_REG_GET(dispc, vp, idx, start, end)				\
-	((u32)FLD_GET(dispc_vp_read((dispc), (vp), (idx)), (start), (end)))
+	((u32)FIELD_GET(GENMASK((start), (end)),			\
+			dispc_vp_read((dispc), (vp), (idx))))
 
 #define VP_REG_FLD_MOD(dispc, vp, idx, val, start, end)			\
 	({								\
 		struct dispc_device *_dispc = (dispc);			\
 		u32 _vp = (vp);						\

-- 
2.50.1


