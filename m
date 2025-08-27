Return-Path: <linux-kernel+bounces-788536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E19B38605
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DEF97AEACD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224202765D0;
	Wed, 27 Aug 2025 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxo6kY9s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A6427FD6B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307588; cv=none; b=C47XuedBjR2OSHC78pvWyN9Dqu4mMa6Wx6sGaDovDjBHtJty8A2lXiqBljZAqCfWyY0fkb0yzj3CiquTtyhKaxM2bhpCKMKoX4KtIEN3FDSlisphm/Ov8NrPpYQWWcR5AcbCS1OD4FbnE4rXyeZixk9V5SX16c6Q/SsUxIlEkRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307588; c=relaxed/simple;
	bh=YR/gYRTUbGVsPcXt+qNXfBhGUDKi5WInCy3Qs5bL5Cw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SNmvY22ctuDRgtk0BhBktE4e6Bv5rgydn+FjRsXFt5eUSZtX5TJeZCqm56h3SJ+WfZ/66+JqdHe9m+O5mfX2hVKPU4mbMFKtEeANK25tCfvY0C42Jon6uTX3YEjdHZFs/zT5NpUEGwkAltjSyRees1eekpTN6FByzd14zMoLpEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxo6kY9s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BC9C4CEEB;
	Wed, 27 Aug 2025 15:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756307588;
	bh=YR/gYRTUbGVsPcXt+qNXfBhGUDKi5WInCy3Qs5bL5Cw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nxo6kY9scmEYDx7Cu2pXPuIwgx4qmT1gxiMlpW4N7VpoD9nS3cCKl0bRXjd/DhrJv
	 LRGY0t7zDLssSZwYJczQv0M/LtIv0wQ4MHqolc6aajhI5HVyoUs5jehn59otX0lXah
	 0/PUWD+XOwAsFiOgpC5u7H5p0HDqkVLEC+Jb2iYlTxLDdZ2pZCF4GvSUFlGglxlblW
	 2dYlEH0ZVdrOMoTNVdbdFs7OP7Ma55iuHX0U6Bi5hMI3Vwokt1pXPytwdFtpaNS7WA
	 +fYMzqAWFPw4wFgGpGfVlk2/EVsjdqvTra1PsxZKtsGRqvBkLfqvTTogHMXe30VReA
	 AiKTULFxtXAeA==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 27 Aug 2025 17:12:40 +0200
Subject: [PATCH v3 09/14] drm/tidss: dispc: Switch VID_REG_GET to using a
 mask
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-drm-tidss-field-api-v3-9-7689b664cc63@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2081; i=mripard@kernel.org;
 h=from:subject:message-id; bh=YR/gYRTUbGVsPcXt+qNXfBhGUDKi5WInCy3Qs5bL5Cw=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBnrFdLal9a6+K4JSHEpu7znRGjRrAnNi3cx2bVZzpzJv
 jlCbB1vx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZhI2HbGhtUrF8+tadSt4kos
 uLTHdluCxq7ZZzwNbxodnmep+lyz2kt5w/y9LAfvegvdP3Wq8qvnb8aGZY9Mrs4zlmyI4fn7co/
 8IZvg/oJ1HBafZb9MY/m37p+R5LO7invv7QthZP25fcLtd9UlAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The VID_REG_GET function takes the start and end bits as parameter and
will generate a mask out of them.

This makes it difficult to share the masks between callers, since we now
need two arguments and to keep them consistent.

Let's change VID_REG_GET to take the mask as an argument instead, and
let the caller create the mask. Eventually, this mask will be moved to a
define.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 82b038285acc245f86573a6a854da37248c92407..8e2c8ecb9f18c71cb532f1f5cea2bc00a0262ad3 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -604,13 +604,12 @@ void tidss_disable_oldi(struct tidss_device *tidss, u32 hw_videoport)
 		u32 _reg = dispc_read(_dispc, _idx);			\
 		FIELD_MODIFY((mask), &_reg, (val));			\
 		dispc_write(_dispc, _idx, _reg);			\
 	})
 
-#define VID_REG_GET(dispc, hw_plane, idx, start, end)			\
-	((u32)FIELD_GET(GENMASK((start), (end)),			\
-			dispc_vid_read((dispc), (hw_plane), (idx))))
+#define VID_REG_GET(dispc, hw_plane, idx, mask)				\
+	((u32)FIELD_GET((mask), dispc_vid_read((dispc), (hw_plane), (idx))))
 
 #define VID_REG_FLD_MOD(dispc, hw_plane, idx, val, start, end)		\
 	({								\
 		struct dispc_device *_dispc = (dispc);			\
 		u32 _hw_plane = (hw_plane);				\
@@ -2292,11 +2291,12 @@ void dispc_plane_enable(struct dispc_device *dispc, u32 hw_plane, bool enable)
 	VID_REG_FLD_MOD(dispc, hw_plane, DISPC_VID_ATTRIBUTES, !!enable, 0, 0);
 }
 
 static u32 dispc_vid_get_fifo_size(struct dispc_device *dispc, u32 hw_plane)
 {
-	return VID_REG_GET(dispc, hw_plane, DISPC_VID_BUF_SIZE_STATUS, 15, 0);
+	return VID_REG_GET(dispc, hw_plane, DISPC_VID_BUF_SIZE_STATUS,
+			   GENMASK(15, 0));
 }
 
 static void dispc_vid_set_mflag_threshold(struct dispc_device *dispc,
 					  u32 hw_plane, u32 low, u32 high)
 {

-- 
2.50.1


