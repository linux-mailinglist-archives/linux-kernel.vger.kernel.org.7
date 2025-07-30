Return-Path: <linux-kernel+bounces-750417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3ECB15B18
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB53D3A26F4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C67E298993;
	Wed, 30 Jul 2025 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vmc62PIK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5462989A4
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753865863; cv=none; b=R7rxPst9t7l8UnTyDP0qm92ouW0tm8UXzdu70aLkhn79YhEiDJuJxiI9rTvl6ZU3PI6/TBZKpD+GL6YC0FrFqqG37C34T+jJsHGcjYj7Rj5GlpytGQC5O8TGbwPfT+PXs91F4pjfzJP2gWqo/u1cGnLbOXCn2oeentj9E6JL1Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753865863; c=relaxed/simple;
	bh=y/c4VTmZ0jPiB79L7NuH6C7jeoGGjEz6ZCtnpEsS0wk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OeWQvhfVYiqomGPA3emITmTDFsOYAvzFFRsROR1QpIWrnQtMbDKUPRjb8lGbCL4xxMh0GctPNOjpDCL6tKFzZ/qyhJptVttCdA4SC73xaJ8jxIrHP0TXxewcK1ApNS1r7uNAPIc7z1HrbF2e725D+z5g5c07FTCsbYTwr/RTlpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vmc62PIK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E705C4CEF5;
	Wed, 30 Jul 2025 08:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753865863;
	bh=y/c4VTmZ0jPiB79L7NuH6C7jeoGGjEz6ZCtnpEsS0wk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Vmc62PIKmw6uls7QGZCtw0LLrEQvSk6IzRAfQxfgzw5WXLVQ8HNHBRg3ZjphsChT8
	 MUVGDy1xa/XBwvM5HyS7TlI4ILK+DBxPGGuMNdyRiX6nBe64wYDGpi305AtHsA2UhK
	 Zv8RewpwOSmHiXodNqPBZsa+Zdw7vrC8K5EVg1/BLQwlbO9/K7jsrS0igSzqoy32t7
	 xQ4MeeI92iJ4WSLrE+9xkmKdO68msJ6jPJNb+7I4ls4NSBPNK8FWELo/1wq3BGvxNB
	 mSl6NZ7rD83y22q0Q/VgAjl4isPEgucjkNAl5nWx477pKMKXV87F9lf2d6OX+Twsab
	 XA96KQiTTA8Jw==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 30 Jul 2025 10:57:11 +0200
Subject: [PATCH 11/14] drm/tidss: dispc: Switch VP_REG_GET to using a mask
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-drm-tidss-field-api-v1-11-a71ae8dd2782@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2197; i=mripard@kernel.org;
 h=from:subject:message-id; bh=y/c4VTmZ0jPiB79L7NuH6C7jeoGGjEz6ZCtnpEsS0wk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBmd91JmNXJbZbesO/LgQm5En08Qy6G4k/kv9nyu1ubUW
 R+TvYexYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEykcgFjwzKx53LsrNP2+5Vm
 pBY/mdzL/lDq9iZt1y6jmqxDb9emCT/ePlnJjp0v/T7DhhPMOe2ajA2TulLrZZavDuxl9NC6NOW
 d5WLnByxtLKy1vyymPWDjsgl7FRte612WXCa3umzF21KdHQA=
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
index c22036d2b1dc2115245014d2e0572ac6bffa77ef..743ceca721691b3944d36bdd5e5fb929d19ab82c 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -636,14 +636,13 @@ static void VID_REG_FLD_MOD(struct dispc_device *dispc, u32 hw_plane, u32 idx,
 {
 	dispc_vid_write(dispc, hw_plane, idx,
 			FLD_MOD(dispc_vid_read(dispc, hw_plane, idx), val, mask));
 }
 
-static u32 VP_REG_GET(struct dispc_device *dispc, u32 vp, u32 idx,
-		      u32 start, u32 end)
+static u32 VP_REG_GET(struct dispc_device *dispc, u32 vp, u32 idx, u32 mask)
 {
-	return FIELD_GET(GENMASK(start, end), dispc_vp_read(dispc, vp, idx));
+	return FIELD_GET(mask, dispc_vp_read(dispc, vp, idx));
 }
 
 static void VP_REG_FLD_MOD(struct dispc_device *dispc, u32 vp, u32 idx, u32 val,
 			   u32 start, u32 end)
 {
@@ -1274,16 +1273,17 @@ void dispc_vp_unprepare(struct dispc_device *dispc, u32 hw_videoport)
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


