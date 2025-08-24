Return-Path: <linux-kernel+bounces-783791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 526BBB3327B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 22:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BE73207561
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 20:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AD724169F;
	Sun, 24 Aug 2025 20:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="VoxvKQwy"
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823D52253FB
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756065733; cv=none; b=RFIfhNNFwBNAuwGMS7zNHyGhrw1HkDCZbHDahdoxISW6y/zQMwvSAaZs9S1EukAzExlPceeyLj9IV0dMihP0ZXEQEu1PQLJmSsZTplTeCgNEPdtfQahZmJcWVArPe1i3sgJHZcqlv6MfXGhWl8uf70b9LGZZvEyqw/ijwhDvdrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756065733; c=relaxed/simple;
	bh=ogN3u1iHUzdg4+YyyQV10XLc/NeB1D/ucu8uqH3EBpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YwZgGG18MFiglVn+LpChVX6KYn+zIDO1YAYdeHcqEGXJebxlf3QPyELY+3YMToIzQqEBIUCiakTonMSNCVzXzmXvXndteNixgK3WGhH0xxlxCgLrHrmwOq9fM34j38CwLLq6hanNXDbUn86mlq39a/GjQ6f/orjcinjNbr+Qdns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=VoxvKQwy; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id B75ABBDBFE;
	Sun, 24 Aug 2025 23:02:09 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 0D80DBDCE2;
	Sun, 24 Aug 2025 23:02:09 +0300 (EEST)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c2:511b:0:7200:c86a:8976:4786])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 3AF25206834;
	Sun, 24 Aug 2025 23:02:08 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1756065728;
	bh=L8cmdSbbrwbTki+2aHu2sEvZypC6g58bcJ5QkivgUxo=; h=From:To:Subject;
	b=VoxvKQwy5QH0zLE6ws85T/ctBbdNNMffUKP83wlxRBG49+BFZJJDjU6Ktf9kQfds0
	 3kmIHCosoImWb0yWOT/FS2fCl01c2oTCPKdju/h6FLkQ3c6isWASyIzfKuBrG3GAzd
	 +Gd4xLy+uGoJKlfmxhjcg3DpP1N54w0g+1yFv5E9EFskk2vITwJ1xb69sfr50EwljP
	 vYs6QipbcI+mELg5PxXmRO4+0WO082C1DKp3O8hWtavKkhYudbbcu4PNFbfUD8ud6r
	 uxnCIVel/mDvfMF0n/2/n/llS0x27u+aI5CG5bjd8PU1EVcQq5awa+RBVrys09oTDt
	 SUP8aHNhisjlQ==
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
Subject: [PATCH v1 5/5] drm: panel-backlight-quirks: Add Steam Decks
Date: Sun, 24 Aug 2025 22:02:02 +0200
Message-ID: <20250824200202.1744335-6-lkml@antheas.dev>
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
 <175606572872.883350.1205519288154954246@linux3247.grserver.gr>
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
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/gpu/drm/drm_panel_backlight_quirks.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panel_backlight_quirks.c b/drivers/gpu/drm/drm_panel_backlight_quirks.c
index 78c430b07d6a..5c24f4a86519 100644
--- a/drivers/gpu/drm/drm_panel_backlight_quirks.c
+++ b/drivers/gpu/drm/drm_panel_backlight_quirks.c
@@ -73,7 +73,22 @@ static const struct drm_get_panel_backlight_quirk drm_panel_min_backlight_quirks
 		.dmi_match_other.field = DMI_PRODUCT_NAME,
 		.dmi_match_other.value = "ONEXPLAYER F1 EVA-02",
 		.quirk = { .brightness_mask = 3, },
-	}
+	},
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
2.50.1



