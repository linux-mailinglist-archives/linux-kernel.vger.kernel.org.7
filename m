Return-Path: <linux-kernel+bounces-858441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CFABEAB26
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B30AB359818
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EA728466F;
	Fri, 17 Oct 2025 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lach.pw header.i=@lach.pw header.b="BZAmcj42";
	dkim=permerror (0-bit key) header.d=lach.pw header.i=@lach.pw header.b="7tnaCM6o"
Received: from mail.0la.ch (mail.0la.ch [78.47.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7257E29AB00
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718487; cv=none; b=gPuzjwKuQdv2DNh7PPbbc4EP7cXMpJnCMazk5yR18HSf+pINWtt35EPbBrZM0TOZcd5jTkMtSE+gs8kMIm8ws9hRSSgLdgAcEXHE85QqiMOi/+1Pt8UTDqchL09PjOXBCyaIVFKCfeS1wp5Q0YvsbLbOJUGKsmO40ekZ+aAxCJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718487; c=relaxed/simple;
	bh=J8nATLSpNDCuuYPy8nc9Jh3EjXH/HS2salyTmzYCVU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kq/tG6NwXBevmHart9GwxWyI9EwJXrz5y5dfZ2l8pROqNi1A804NTwVmNWgYLAxpPYvAQUL4J25nBS9xOqxGgsAKsmOMZ/rs3eJCA8odBr80K6ecAdrCT5KBAxv/upVDK4A2nWFQVr3OpDArRWqUEZbMBrfHM/GdcbP9e6W2GwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lach.pw; spf=pass smtp.mailfrom=lach.pw; dkim=pass (2048-bit key) header.d=lach.pw header.i=@lach.pw header.b=BZAmcj42; dkim=permerror (0-bit key) header.d=lach.pw header.i=@lach.pw header.b=7tnaCM6o; arc=none smtp.client-ip=78.47.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lach.pw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lach.pw
DKIM-Signature: v=1; a=rsa-sha256; s=202502r; d=lach.pw; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1760718482; bh=G0cUjhPXLsNiRSzg25M5MDh
	tPLRayvef22yIVqM4pgw=; b=BZAmcj42Tx4KgCUm7gwuhiu23+4lWTXljxM1DgM5pw0lUo1shr
	bjUuMdS5qphyFhTX5yv4heg1KbfxDnAgaGg6W50ALBuvtS4/E81Fu0LFYmWpvJbIDrkHf0qvRtl
	KkJUq52WvtFp9HXDG8u/WGM06P1yavQjyalNZvqWlTvxGgXmRRhzgqlDINnCE5UciHKIwGDbifc
	EEt4U5tF9R/vrZsPCeCYb+xfw8Bj02isOXPJzUwCPXuAFLuXklN7o9MN7S8RjAolzlQsEzktJ+g
	q5fCLpajAB67CwXhXY1UdOpf2xFONTp3as+dBGn2ZRD2RuaXuAJkCWHfCVZMNO1Cjdg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202502e; d=lach.pw; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1760718482; bh=G0cUjhPXLsNiRSzg25M5MDh
	tPLRayvef22yIVqM4pgw=; b=7tnaCM6oVQtil/Mg0gF5n7TynT9nM1uOFUikgWxSpjww/vsIHr
	ux0+oXF2ALeUBjyvUXnwNF3JkdiE+mzUdsDA==;
From: Yaroslav Bolyukin <iam@lach.pw>
To: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Wayne Lin <Wayne.Lin@amd.com>,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Yaroslav Bolyukin <iam@lach.pw>
Subject: [PATCH v5 2/7] drm/edid: prepare for VESA vendor-specific data block extension
Date: Fri, 17 Oct 2025 18:27:31 +0200
Message-ID: <20251017162736.45368-3-iam@lach.pw>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017162736.45368-1-iam@lach.pw>
References: <20251017162736.45368-1-iam@lach.pw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current VESA vendor-specific block parsing expects real block size to be
the same as the defined struct size, use real offsets in conditionals
instead to add struct fields in future commits.

Signed-off-by: Yaroslav Bolyukin <iam@lach.pw>
---
 drivers/gpu/drm/drm_edid.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 4fcde52291ce..725ae5f9d160 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6541,7 +6541,7 @@ static void drm_parse_vesa_specific_block(struct drm_connector *connector,
 	if (oui(vesa->oui[0], vesa->oui[1], vesa->oui[2]) != VESA_IEEE_OUI)
 		return;
 
-	if (sizeof(*vesa) != sizeof(*block) + block->num_bytes) {
+	if (block->num_bytes < 5) {
 		drm_dbg_kms(connector->dev,
 			    "[CONNECTOR:%d:%s] Unexpected VESA vendor block size\n",
 			    connector->base.id, connector->name);
@@ -6564,24 +6564,20 @@ static void drm_parse_vesa_specific_block(struct drm_connector *connector,
 		break;
 	}
 
-	if (!info->mso_stream_count) {
-		info->mso_pixel_overlap = 0;
-		return;
-	}
-
-	info->mso_pixel_overlap = FIELD_GET(DISPLAYID_VESA_MSO_OVERLAP, vesa->mso);
-	if (info->mso_pixel_overlap > 8) {
+	if (info->mso_stream_count) {
+		info->mso_pixel_overlap = FIELD_GET(DISPLAYID_VESA_MSO_OVERLAP, vesa->mso);
+		if (info->mso_pixel_overlap > 8) {
+			drm_dbg_kms(connector->dev,
+				    "[CONNECTOR:%d:%s] Reserved MSO pixel overlap value %u\n",
+				    connector->base.id, connector->name,
+				    info->mso_pixel_overlap);
+			info->mso_pixel_overlap = 8;
+		}
 		drm_dbg_kms(connector->dev,
-			    "[CONNECTOR:%d:%s] Reserved MSO pixel overlap value %u\n",
+			    "[CONNECTOR:%d:%s] MSO stream count %u, pixel overlap %u\n",
 			    connector->base.id, connector->name,
-			    info->mso_pixel_overlap);
-		info->mso_pixel_overlap = 8;
+			    info->mso_stream_count, info->mso_pixel_overlap);
 	}
-
-	drm_dbg_kms(connector->dev,
-		    "[CONNECTOR:%d:%s] MSO stream count %u, pixel overlap %u\n",
-		    connector->base.id, connector->name,
-		    info->mso_stream_count, info->mso_pixel_overlap);
 }
 
 static void drm_update_vesa_specific_block(struct drm_connector *connector,
-- 
2.51.0


