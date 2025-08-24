Return-Path: <linux-kernel+bounces-783790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ADDB33276
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 22:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844B01899C53
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 20:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A2E23BCE7;
	Sun, 24 Aug 2025 20:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="ARrnIt9h"
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F7219C569
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 20:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756065732; cv=none; b=P8Hvw47sZXltPOh0tdsGxrBaEq3zg+zapzlP770SLioW7pHZK7Qz/QVKwYD6xTzGq1aa2A9eLIvdPgP4NJq7lZEqVqSCqNa3X10aJ49iT3pcbaPnnAPEjrcgm+MkLa3u03UzpLD4/rP9A3S6q8nj4Xev4jDzInKZPFgVLHccsx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756065732; c=relaxed/simple;
	bh=QPhKcrVIU2gFSOLUVx1jTDeBJXsmc7KgCkuN3th6ueE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f839996XiQDWuyqCPNYCbAXcv6Etz1pdyYeIMCBoZuKcoS22ZSifn9VOiwmvc8Rchm64ZQBNDX3mYrcYHTIuNm9/dGjdMcG5SbBRQ7OsfaAt+JHFBuyTv423ipCzN3zqYZpJUmLxJcsMyUKKPLAu2Snj7TpHco67B9N3Ld/69do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=ARrnIt9h; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 06454BDCA0;
	Sun, 24 Aug 2025 23:02:08 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 76F7BBDBFE;
	Sun, 24 Aug 2025 23:02:07 +0300 (EEST)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c2:511b:0:7200:c86a:8976:4786])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id A6E3C20682B;
	Sun, 24 Aug 2025 23:02:06 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1756065727;
	bh=x8x3rWwaOCwFrM5cFavMRZMSBhj+ObMSZe7AUPPM9GE=; h=From:To:Subject;
	b=ARrnIt9hVcC9B1c5ZkPY5LxZAW57m1sdqoJoh1U7ySGmtCwU4FBBt76Bcg/S9EZ9L
	 2mbhVvo4J7hrhECTKy5avSW52y9j47drZVzBi8bLBSxbywLXlBISZsmSS+SPo7quLe
	 l3NWhYSmo0ENWZtwsDr0vJOJQfi+nSU3bFzDE6r3kInB+wOXqbVbD+Bs5HTmEL4W8M
	 Q4frl9b5tlaFnc7n3ef7qjnYr/ihNzjWXDW1P0k7mtWxUL6wEl28vBEBehrKQlyonU
	 6nwoRml58QSHqgtSt9iLzyaYO8dgbS6O/uLS5FfT+EDxlx519pGG9rNO9VAYz3rXQi
	 2Mam8GLoGVrew==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:7200:c86a:8976:4786) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	philm@manjaro.org,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v1 3/5] drm: panel-backlight-quirks: Add secondary DMI match
Date: Sun, 24 Aug 2025 22:02:00 +0200
Message-ID: <20250824200202.1744335-4-lkml@antheas.dev>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250824200202.1744335-1-lkml@antheas.dev>
References: <20250824200202.1744335-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <175606572716.883244.17703475591090779465@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Using a single DMI match only allows matching per manufacturer.
Introduce a second optional match to allow matching make/model.
In addition, make DMI optional to allow matching only by EDID.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/gpu/drm/drm_panel_backlight_quirks.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_panel_backlight_quirks.c b/drivers/gpu/drm/drm_panel_backlight_quirks.c
index 702726c20ccc..3d386a96e50e 100644
--- a/drivers/gpu/drm/drm_panel_backlight_quirks.c
+++ b/drivers/gpu/drm/drm_panel_backlight_quirks.c
@@ -8,11 +8,14 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_utils.h>
 
+struct drm_panel_match {
+	enum dmi_field field;
+	const char * const value;
+};
+
 struct drm_get_panel_backlight_quirk {
-	struct {
-		enum dmi_field field;
-		const char * const value;
-	} dmi_match;
+	struct drm_panel_match dmi_match;
+	struct drm_panel_match dmi_match_other;
 	struct drm_edid_ident ident;
 	struct drm_panel_backlight_quirk quirk;
 };
@@ -48,7 +51,13 @@ static bool drm_panel_min_backlight_quirk_matches(
 	const struct drm_get_panel_backlight_quirk *quirk,
 	const struct drm_edid *edid)
 {
-	if (!dmi_match(quirk->dmi_match.field, quirk->dmi_match.value))
+	if (quirk->dmi_match.field &&
+	    !dmi_match(quirk->dmi_match.field, quirk->dmi_match.value))
+		return false;
+
+	if (quirk->dmi_match_other.field &&
+	    !dmi_match(quirk->dmi_match_other.field,
+		       quirk->dmi_match_other.value))
 		return false;
 
 	if (quirk->ident.panel_id && !drm_edid_match(edid, &quirk->ident))
-- 
2.50.1



