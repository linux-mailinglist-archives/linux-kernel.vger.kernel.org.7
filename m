Return-Path: <linux-kernel+bounces-788532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF92B385F5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2447636577F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C1A27814C;
	Wed, 27 Aug 2025 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyzWDH9c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D300278761
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307578; cv=none; b=TJEipgLlCenu33SOx/m0qhCHUycJZlbNCdBPw3Vb2fmPA4ZYYAsAUkuPbDNJzf56YgNdXQp249SYmJ9S58ihvjUEFyDe5Fa1aN/5KsldHxzzVPEp+ptCgUAitLE9HKsPZQGlz2940hzJffzDO7rPV5HK6jHVu3Kf3PJO79ksAUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307578; c=relaxed/simple;
	bh=uP7VrIhR0S0n6XikKxh4fvAsgSssIZys68koJDMOXK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nTrHutkPV3TgOfKb7Zj9zBzWQOuwMSd5OflIRIVVB8jy2N0I6bhw0fcRfYgFPjbLKev9xYRMKYkd6FXHPFHZaSLQQY1uXrvYft5WEF6GY5YJe3jlcRhyKOpR8mg7bxqKYLVHYh7+VGtrqz/ZhjeXDnBTSOOe9zJ+bV3mJUNfW1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyzWDH9c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F63C4CEF9;
	Wed, 27 Aug 2025 15:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756307577;
	bh=uP7VrIhR0S0n6XikKxh4fvAsgSssIZys68koJDMOXK0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AyzWDH9c/dRaqFbFLLopAVhe7M6mQrp2SGvgz/5JzPE0+vvjRkRROMTbrp5ap2uxf
	 YIIj15YknVvmT0eWEc/Y5S/zaoih7xoQLWvnynl4OcUNj/r6NUjwrwVMzIdu6rJcWZ
	 coUXJOkl14tIuPjVct6nw5iiD4w2dZVoKC5S60YaAuM0/R8apIxwgSMFBV6/nVK2uu
	 B5hdKyuYUlL8w1e6vNf/i9j1VprDoAEwLOVFizJYARiOfVKr0m+abOL/djtrDOQBCR
	 bHXcmGimLer6y0ZgdHVg82+n4CM/RvqILyJJxdtSq6OVF+Jk+ePbHpQtfAGXmrjZjY
	 5R0unXV5aRH2w==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 27 Aug 2025 17:12:36 +0200
Subject: [PATCH v3 05/14] drm/tidss: dispc: Get rid of FLD_GET
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-drm-tidss-field-api-v3-5-7689b664cc63@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2757; i=mripard@kernel.org;
 h=from:subject:message-id; bh=uP7VrIhR0S0n6XikKxh4fvAsgSssIZys68koJDMOXK0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBnrFVIjzv06nt9vkfTTd+HDJgftjlff5k90F41u2LSa7
 +Xv688udExlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJsF9lrJXqKDB0v3fR7cfW
 G9ra7e/vfbSad/7IEV3GkC+H/s00WvJ23pOapYb1fAa+BfUBBS1bKhgbul9kbD1oJPO6o8Je/9o
 httesJxVW6tS0KdsubNec+2TPX4ZVvzkcL/buZG/5mTjpzbWVAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The FLD_GET function is an equivalent to what FIELD_GET + GENMASK
provide, so let's drop it and switch to the latter.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 43f8078a1effa2b5a09532cb069131dc0cbf3c10..b4ba342ac241a603db447d6c5ae147c981013be2 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -592,27 +592,21 @@ void tidss_disable_oldi(struct tidss_device *tidss, u32 hw_videoport)
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
@@ -620,11 +614,12 @@ void tidss_disable_oldi(struct tidss_device *tidss, u32 hw_videoport)
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
@@ -633,11 +628,12 @@ void tidss_disable_oldi(struct tidss_device *tidss, u32 hw_videoport)
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


