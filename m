Return-Path: <linux-kernel+bounces-788694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7739B388D4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 19:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD4F5E648C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A222877DB;
	Wed, 27 Aug 2025 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="oj+3JzMb"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6766A86250
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756316783; cv=none; b=fADfFoodd8V5NjR6KritYf2H3SYTxH4UtDy0JBCX2YlBpxaUCcm7m56J77Rmyb37vHmhrFL0+BgrRrJ7s2nP9bSP46DV+VmBw3sOC+bJ1rPUtWBC+SBLRdisGtaDicNVAoXSOd+NK+kzuQmEQwRUZYGeXyzqMdLouVn46i4XoOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756316783; c=relaxed/simple;
	bh=tQ7Q7krV68eAl0BMLspuny9O3rb5+KPF3OyCm86L2Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FbVe0TS2KcV5nO+rt9Yx+rVRDZEikNemuBCSwmWPWBCtSnUjzvBYExjfd6bei4vHTUqQJyZzsrzQSWkezICYbEUAzq5W3kCF2/kXKa24PN3xZl69RJhcagpfgV26P+m0bJ6lIg+K7DGbE54IYKvzB+hGVaJ6Xbswwo1DtfkodQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=oj+3JzMb; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id AEE20CB378;
	Wed, 27 Aug 2025 20:46:17 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 460A0CB2CC;
	Wed, 27 Aug 2025 20:46:17 +0300 (EEST)
Received: from antheas-z13 (x5996a855.customers.hiper-net.dk [89.150.168.85])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 789431FDD78;
	Wed, 27 Aug 2025 20:46:16 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1756316777;
	bh=yVVP5U6vbQTVp3zuFXYmRcn0/+e2aWydPzr35ns96fg=; h=From:To:Subject;
	b=oj+3JzMbDXAWO2xAJ8gPnIld73sDfIb3xbCegQjTTHpEUEtrXLrw7X1Iuq1ddcRBX
	 vkWGzS2Cke1Fmifgc35DLylw4jagteeRe/803BsqjG4lOl22DdzWPOnvuoFb1Jg5Mr
	 NXCSu4jb3ZFfdo4IbVH56FmqpO1xR77jhnEXgP/0TLYZodA6pVtfUn6CtOmnrFT1mL
	 vHDbgiyJpP89JcrbSZkb2v2lxoJzWqS10Mwgo4jAlfDWpIkkQ+DqfhY2cevgEIKdG6
	 LE4aYyl9W30Hx+pgeoU+9loBDZ8hUHqKSUC6I1ySxCqrYbsSY/xBYAF4vtQKm+hnan
	 c+Qf15r/nxIFA==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 89.150.168.85) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	philm@manjaro.org,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Robert Beckett <bob.beckett@collabora.com>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v2 3/5] drm: panel-backlight-quirks: Add secondary DMI match
Date: Wed, 27 Aug 2025 19:43:58 +0200
Message-ID: <20250827174400.3692549-4-lkml@antheas.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250827174400.3692549-1-lkml@antheas.dev>
References: <20250827174400.3692549-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <175631677698.1365389.4728967696287001458@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Using a single DMI match only allows matching per manufacturer.
Introduce a second optional match to allow matching make/model.
In addition, make DMI optional to allow matching only by EDID.

Tested-by: Philip Müller <philm@manjaro.org>
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
2.51.0



