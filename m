Return-Path: <linux-kernel+bounces-791950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51244B3BE9C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B6805855D9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5033218B5;
	Fri, 29 Aug 2025 14:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="RwjKHf0a"
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5875E31B11B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756479477; cv=none; b=ZKkxgclSr/4zV5kEE4KTvs6tsAobXSRraLV2SJQ/lE3CsZX675SEFpkiFbDTahEvK1phhPHBc0Eag2WSyyCXlhPULjfQHp8bhE4nFD5Jvur9CHgnh10m/RW7JPHoO/BLrmylKJMtXGBWgyT8H3KEJl9IsvK+ypPazik4q0KtW+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756479477; c=relaxed/simple;
	bh=oggK3NZUbCtod6VJUSJ8r9D7f/geDAhMAaRxzY5CLTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tf79Rc31E2XQ8v9uFGbO9epG4uSen/lFnih2i8QRGJ753IBtCV9EXajBu8XixRdLOGhhNaHIYmJzWA74dfB2p7NY7nL4/Xi0f2V0P01yHvWLQEPdzfbvsXuQIl4BwwPeZgQOucBI5Vr0Z+nRIM4yzx076NCkSzFnAYqYBeZxZW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=RwjKHf0a; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 28971BDC09;
	Fri, 29 Aug 2025 17:57:47 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id B3F40BDD1C;
	Fri, 29 Aug 2025 17:57:46 +0300 (EEST)
Received: from antheas-z13 (x5996a855.customers.hiper-net.dk [89.150.168.85])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id D45922018C9;
	Fri, 29 Aug 2025 17:57:45 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1756479466;
	bh=eOvCjbVtCDcSD69NmTG6S1mGz0BcfYQbAOIOCu/qG44=; h=From:To:Subject;
	b=RwjKHf0ai59wInqx1PTslD8P1TSwCyzKVaD1dXPwGd2vFUEnADOl5gKdIdyXfXKg2
	 eCp6yoAy/T7L4CFNc8CVTC65cJr/SIHyPn4pK9Q0dheyH+yMbLKOn42IlAcstbhSqz
	 JLPNnTe5kYHPvDC/io1NsvZbXl/a2fZc+rjSZsDTUXCe9Fxq7vXo/GHYpGGcgKfi0x
	 lz2t9ouuAixOmCbTHelYAkFLTx5huOM1ZZEQgJ2Ut8SH2tGxpGRZoTrxk7ggv8u8xe
	 OnQmAn8omfJfXFp1RSlU2TBKu1YcFWDme6DWjaCWuG5R1R0vXCW/yLP3/2yjDAuTQX
	 1IuPui2MRfVsw==
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
Subject: [PATCH v3 1/6] drm: panel-backlight-quirks: Make EDID match optional
Date: Fri, 29 Aug 2025 16:55:36 +0200
Message-ID: <20250829145541.512671-2-lkml@antheas.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829145541.512671-1-lkml@antheas.dev>
References: <20250829145541.512671-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <175647946639.277952.14470684280693686509@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Currently, having a valid panel_id match is required to use the quirk
system. For certain devices, we know that all SKUs need a certain quirk.
Therefore, allow not specifying ident by only checking for a match
if panel_id is non-zero.

Tested-by: Philip Müller <philm@manjaro.org>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/gpu/drm/drm_panel_backlight_quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panel_backlight_quirks.c b/drivers/gpu/drm/drm_panel_backlight_quirks.c
index 598f812b7cb3..b38b33e26ea5 100644
--- a/drivers/gpu/drm/drm_panel_backlight_quirks.c
+++ b/drivers/gpu/drm/drm_panel_backlight_quirks.c
@@ -50,7 +50,7 @@ static bool drm_panel_min_backlight_quirk_matches(const struct drm_panel_min_bac
 	if (!dmi_match(quirk->dmi_match.field, quirk->dmi_match.value))
 		return false;
 
-	if (!drm_edid_match(edid, &quirk->ident))
+	if (quirk->ident.panel_id && !drm_edid_match(edid, &quirk->ident))
 		return false;
 
 	return true;
-- 
2.51.0



