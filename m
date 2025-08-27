Return-Path: <linux-kernel+bounces-788698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B25B1B388DA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 19:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3C345E86E4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDE02D9487;
	Wed, 27 Aug 2025 17:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="H7MrhF69"
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939012D7DE8
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 17:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756316790; cv=none; b=PQokhTAgy7Zn5KkZSXQoqgA3HXcefKSoBEk8Ed3ptJnhUTJYKA6JlEFemmifm0OwS9Pv5MftumSufTltZA8DFzwps/R+4GXukDfeHPcaDjthk/1dGp6rckwQUdtPCgfH6qelpVbXr3v8iMaQX2vFfUt/Z5vSU90QwulS560O03s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756316790; c=relaxed/simple;
	bh=VCRgaXkIsqEb0X+N2N800a5NQOvKOFGZ3FOcy1tKctM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aRxPOidwXk6TSnp+ls2ZSgGSeo6xZnqV5+S6ML6i9ygFM9ddn5gk5g5P8JgHd2JKeEyRiCortp/BTUgTeFugb+ocUuvE6TEX0/CusAzwaQFssSQTYEablJ90OjudP0EW2JErMCwLt3hPrNlZP00j96J0+ikWu1iRXkRC4l336rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=H7MrhF69; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id D2CCF49367;
	Wed, 27 Aug 2025 20:46:19 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 102294936C;
	Wed, 27 Aug 2025 20:46:19 +0300 (EEST)
Received: from antheas-z13 (x5996a855.customers.hiper-net.dk [89.150.168.85])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 1FC141FDEA8;
	Wed, 27 Aug 2025 20:46:18 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1756316778;
	bh=ISfp3kQz5F8NvozgxSjB9Oij0MVFzpiUsAcxlVWnpG4=; h=From:To:Subject;
	b=H7MrhF6937KuzgwZwR6bOzHDepZVt4vA+hNmsiwgtvG8dUGmhseJbC9NZe4han9gf
	 OnD4onVQM/+wdcs9zOS3vTYP4uA8ffqMKHrJU9/oUx289K+f6w9jIz/0VS7Xhm8S3H
	 l7cQ5nXkHB2lS5+T7ZciBBMgHSkHYYIjdFV/QsWAuuR/h/pCmToknRgZaYrr61Lu8b
	 qgH9dY0ajCzrQPiFP4DmspYQSkpJCXZqF2rkaemHyIpL9cPBmmz+44ebitiUV3DatJ
	 6qvk0V4FU1bxElSpvRzN9HHNwJz1zLisZAOgK8KEVJrhsQNz0u2IklZ78bYKAK6SIT
	 FNFs2Kic63bZA==
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
Subject: [PATCH v2 5/5] drm: panel-backlight-quirks: Add Steam Deck brightness
 quirk
Date: Wed, 27 Aug 2025 19:44:00 +0200
Message-ID: <20250827174400.3692549-6-lkml@antheas.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250827174400.3692549-1-lkml@antheas.dev>
References: <20250827174400.3692549-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <175631677861.1365508.2422182497171344248@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On the SteamOS kernel, Valve universally makes minimum brightness 0
for all devices. SteamOS is (was?) meant for the Steam Deck, so
enabling it universally is reasonable. However, it causes issues in
certain devices. Therefore, introduce it just for the Steam Deck here.

SteamOS kernel does not have a public mirror, but this replaces commit
806dd74bb225 ("amd/drm: override backlight min value from 12 -> 0")
in the latest, as of this writing, SteamOS kernel (6.11.11-valve24).
See unofficial mirror reconstructed from sources below.

Link: https://gitlab.com/evlaV/linux-integration/-/commit/806dd74bb225
Reviewed-by: Robert Beckett <bob.beckett@collabora.com>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/gpu/drm/drm_panel_backlight_quirks.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_backlight_quirks.c b/drivers/gpu/drm/drm_panel_backlight_quirks.c
index 2bdbd5583d32..69d38c248a0a 100644
--- a/drivers/gpu/drm/drm_panel_backlight_quirks.c
+++ b/drivers/gpu/drm/drm_panel_backlight_quirks.c
@@ -81,6 +81,21 @@ static const struct drm_get_panel_backlight_quirk drm_panel_min_backlight_quirks
 		.dmi_match_other.value = "ONEXPLAYER F1 EVA-02",
 		.quirk = { .brightness_mask = 3, },
 	},
+	/* Steam Deck models */
+	{
+		.dmi_match.field = DMI_SYS_VENDOR,
+		.dmi_match.value = "Valve",
+		.dmi_match_other.field = DMI_PRODUCT_NAME,
+		.dmi_match_other.value = "Jupiter",
+		.quirk = { .min_brightness = 1, },
+	},
+	{
+		.dmi_match.field = DMI_SYS_VENDOR,
+		.dmi_match.value = "Valve",
+		.dmi_match_other.field = DMI_PRODUCT_NAME,
+		.dmi_match_other.value = "Galileo",
+		.quirk = { .min_brightness = 1, },
+	},
 };
 
 static bool drm_panel_min_backlight_quirk_matches(
-- 
2.51.0



