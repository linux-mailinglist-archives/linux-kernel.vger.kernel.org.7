Return-Path: <linux-kernel+bounces-838943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9946BB079B
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB3403AC956
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894222F069A;
	Wed,  1 Oct 2025 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="fr3pPx7n"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACC12EFDBD
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759324981; cv=none; b=tJ8OLP5Pbj4EiibcXDGFqjeE43OeZtxQfFb6tMY23u8MIr5O9NaX3nCqeNOSE1P2LnlOXJ1MMZ5E9/BIZkS0r/jVCd3L0WpZrBThDzHmnvyx3DbAtGzjEDSphO0+nL0GhsgwQLHHfjhAujLtSzLcw1UshzqPPCSnHh2KEoVxEDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759324981; c=relaxed/simple;
	bh=Znweb1HJoGGEwx8AA6UGeSIlc4xbcTQrPSmXMO4sVVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vgx1A7WFXkpc9bg70HY6s4W43EcZWI6/FDF/I9+eHj/kDbnViH1kSmUiDu5+ByJE1pdSyVqlCgK2JiUuolAhDZSghEKSxfO+VxDqiynB5Bcj2NE/nDFw/P02ZVwQ5P94yzdYWyDLp2ewhiMIH9Ywcieib5EGb9YISWBmf/+keBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=fr3pPx7n; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 98403F04;
	Wed,  1 Oct 2025 15:21:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1759324883;
	bh=Znweb1HJoGGEwx8AA6UGeSIlc4xbcTQrPSmXMO4sVVA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fr3pPx7n00TKc+v1Gzf+o/FmtEXps8XasGTuIqsPR37i5sm7EDwGEPSzLA26SnUmA
	 O/1DRez+Lito4Ykyfjj3vrVH31S8I+sXS8HCilhK3f81iR25dxLitynBfr5/gLtOJi
	 oxwoQnIM69juGFEar2uAA4kD9wsyB8x1uxUZUmbM=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 01 Oct 2025 16:22:18 +0300
Subject: [PATCH v6 06/11] drm/fourcc: Add DRM_FORMAT_XVUY2101010
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-xilinx-formats-v6-6-014b076b542a@ideasonboard.com>
References: <20251001-xilinx-formats-v6-0-014b076b542a@ideasonboard.com>
In-Reply-To: <20251001-xilinx-formats-v6-0-014b076b542a@ideasonboard.com>
To: Vishal Sagar <vishal.sagar@amd.com>, 
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Pekka Paalanen <ppaalanen@gmail.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2347;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=Znweb1HJoGGEwx8AA6UGeSIlc4xbcTQrPSmXMO4sVVA=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBo3SsiyYdd6sliaoQLMFuUTsahr168oIvlm+MsD
 LL759QMIaWJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaN0rIgAKCRD6PaqMvJYe
 9aH1D/sF2x/sxjXDnp8utLup5dIWse86fJWEBBy0cqzAc5azp9ajD7BMC0KetWFtzMv4Akjoqid
 fUUhqp2IoVhN9TMnijW/dXyYBxJveE5fL16LJN3gijbhtN7vFx67386o76VpPZROuCS1dQNoOvC
 cDJxVEZD84A2vZXB7JskDRX8CXZw5nsHQ/is5JzU22xyngaKTYgojHb2nOn4SDUbgG3kT7NKVwC
 mWo1J8pux1nRoybgBpJ2Q5RUqY+68plFLqfbF/4bn6ZMwwAE+BFpul/tEh0aw1EGizRQUhetjIX
 M1QWoZu+1msUAPN1a3TKsBFO3uOVxTkMzYdFeVgTunLqtiouNyHD93ytzwxbf/YSkyATbc1uaY5
 p+GbHJ0q0LV+ob8GpeG18bphCvB5Swut9PUPfnVVJhugoYLkL9/eusk6gnyBUnc8XPXTXHx0w+a
 9X+iMp7H0Ww9LeAGf9PWyqGsUwqHr09fLa7zQzWAGLv+hJ5hrLPz7KlBjRGOuDXhsdz1QtxpRHb
 Uwc0z8AYEgILl5Cql0/o2kvmvaz93swcZBs/pSauZLkP1CxnJ3i+nLRy9bLCEJsMOoaAkNfkGXD
 kcLDOa6MmNOPGcSga1i7ft+cvjeZE/iNpQH8N0lj1MXAqq2sK3KVJMvjoRVXtHfSyHqjL1WxUbc
 GdrUIAyp7+dvKkA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add XVUY2101010, a 10 bits per component YCbCr format in a 32 bit
container.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Vishal Sagar <vishal.sagar@amd.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/drm_fourcc.c  | 1 +
 include/uapi/drm/drm_fourcc.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index ab643dedd6d4..a736df2de3fc 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -288,6 +288,7 @@ const struct drm_format_info *__drm_format_info(u32 format)
 		{ .format = DRM_FORMAT_VYUY,		.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
 		{ .format = DRM_FORMAT_XYUV8888,	.depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1, .is_yuv = true },
 		{ .format = DRM_FORMAT_VUY888,          .depth = 0,  .num_planes = 1, .cpp = { 3, 0, 0 }, .hsub = 1, .vsub = 1, .is_yuv = true },
+		{ .format = DRM_FORMAT_XVUY2101010,     .depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1, .is_yuv = true },
 		{ .format = DRM_FORMAT_AYUV,		.depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true, .is_yuv = true },
 		{ .format = DRM_FORMAT_Y210,            .depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
 		{ .format = DRM_FORMAT_Y212,            .depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 8ac36a74ceb1..24386bee34e2 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -264,6 +264,7 @@ extern "C" {
 #define DRM_FORMAT_XVUY8888	fourcc_code('X', 'V', 'U', 'Y') /* [31:0] X:Cr:Cb:Y 8:8:8:8 little endian */
 #define DRM_FORMAT_VUY888	fourcc_code('V', 'U', '2', '4') /* [23:0] Cr:Cb:Y 8:8:8 little endian */
 #define DRM_FORMAT_VUY101010	fourcc_code('V', 'U', '3', '0') /* Y followed by U then V, 10:10:10. Non-linear modifier only */
+#define DRM_FORMAT_XVUY2101010	fourcc_code('X', 'Y', '3', '0') /* [31:0] x:Cr:Cb:Y 2:10:10:10 little endian */
 
 /*
  * packed Y2xx indicate for each component, xx valid data occupy msb

-- 
2.43.0


