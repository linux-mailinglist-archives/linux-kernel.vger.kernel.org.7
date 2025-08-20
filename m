Return-Path: <linux-kernel+bounces-777862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3F3B2DEB3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03E95A17A9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC18926E6E3;
	Wed, 20 Aug 2025 14:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxd2C/zb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B98261593
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755698530; cv=none; b=IeDWaSNCJy0xhUN9QSEty90xetIROkwmHWg2Ctdy+n6UWSL5R+p39nUrlnaJsM3LYp+lfcjPbLmaSwvM8GcAWyYMl2sXKsswz0/fwtLVcNnJ7+/g3njpenE7fIxLpsEg6m8sI+gp+aguFxfQyqgDeN5vgWE/XwZgEFCq27NcYko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755698530; c=relaxed/simple;
	bh=IIsNedq+iyblpRYlMXmp6+zZ9khsNh/7IwMpr1pIVrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dpVVlaVC/4nG/HYDaNv+dOU/LQq7JMM7JIXjMulbuhvMKwMzobZtQpu8hocmrHht/Egt76ayk26cAnfHitVcEdrosI4TxJmesan1FiPnfBuVjrgrv6FnnqZmTLeWcvpFIE/zG1Qpnd+LK1HIlxR2PAv7NV03bDseXnS0DJszZ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxd2C/zb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE46C4CEE7;
	Wed, 20 Aug 2025 14:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755698529;
	bh=IIsNedq+iyblpRYlMXmp6+zZ9khsNh/7IwMpr1pIVrc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oxd2C/zbpQbbcuqDiyV0Owp8XvGtgKTQJr+SZu6qgOV2YH3sQi2uAx/y/LR+YTDPS
	 tJ9bff8uMeTfdVXzeQYGwOEs8ptbI0ADL2lX6sbpVRT4l2RI2CX6QzI5tOA45pqB6E
	 doBWzjrG4uvhGs0sYnDHWFMwjI5AYR6+2SCvTAfnTGYIZwibtWlXZAYPz0ogZaMJVZ
	 Cya2A6XMCkkdvIZKJor4OoqwmhYTrecRw185ZgL/N9h1teEbFJtzSIM8pHIldpwrXy
	 OSH/PfYRUtaO8tqh8siJyr/K4CluEIfwdUK0sUFybLe9i+ORpSe2s7yIKHgL+NGuO4
	 At9vHJwHw9zLw==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 20 Aug 2025 16:01:43 +0200
Subject: [PATCH v2 03/14] drm/tidss: dispc: Switch to GENMASK instead of
 FLD_MASK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-drm-tidss-field-api-v2-3-43cab671c648@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1844; i=mripard@kernel.org;
 h=from:subject:message-id; bh=IIsNedq+iyblpRYlMXmp6+zZ9khsNh/7IwMpr1pIVrc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBlLrwY83fSQv9ujNnwWy7OqrjkLq405mw1ZdywqShG/f
 t5lYnRjx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZjI1TmMteL88+ZWrbkb+fxt
 6DU7JpUNScpBXazBqamxNkuv2fEtk95jGbGPfd4jhspcvu6TQu9fMlazS5vceGxtOU200s59ucn
 hsl+vQor0jqetW6pcusjUv3Spr/XdnK3qadKZ+4Wz2J88XgsA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The dispc FLD_MASK function is an exact equivalent of the GENMASK macro.
Let's convert the dispc driver to the latter.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 10fbc99621c149f4e119ef4a45867c369ca5df0b..929c9e3ac1174df68937afd86f13bda4e3a66394 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -607,35 +607,28 @@ void tidss_disable_oldi(struct tidss_device *tidss, u32 hw_videoport)
 /*
  * TRM gives bitfields as start:end, where start is the higher bit
  * number. For example 7:0
  */
 
-#define FLD_MASK(start, end)						\
-	({								\
-		int _end_inner = (end);					\
-		u32 _mask = ((1 << ((start) - _end_inner + 1)) - 1) << _end_inner; \
-		_mask;							\
-	})
-
 #define FLD_VAL(val, start, end)					\
 	({								\
 		int _end_inner = (end);					\
-		u32 _new_val = ((val) << _end_inner) & FLD_MASK((start), _end_inner); \
+		u32 _new_val = ((val) << _end_inner) & GENMASK((start), _end_inner); \
 		_new_val;						\
 	})
 
 #define FLD_GET(val, start, end)					\
 	({								\
 		int _end = (end);					\
-		u32 _ret_val = ((val) & FLD_MASK((start), _end)) >> _end; \
+		u32 _ret_val = ((val) & GENMASK((start), _end)) >> _end; \
 		_ret_val;						\
 	})
 
 #define FLD_MOD(orig, val, start, end)					\
 	({								\
 		int _start = (start), _end = (end);			\
-		u32 _masked_val = (orig) & ~FLD_MASK(_start, _end);	\
+		u32 _masked_val = (orig) & ~GENMASK(_start, _end);	\
 		u32 _new_val = _masked_val | FLD_VAL((val), _start, _end); \
 		_new_val;						\
 	})
 
 #define REG_GET(dispc, idx, start, end)					\

-- 
2.50.1


