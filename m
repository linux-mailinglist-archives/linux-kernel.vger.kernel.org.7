Return-Path: <linux-kernel+bounces-783787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A147B33275
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 22:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1464176042
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 20:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A95227586;
	Sun, 24 Aug 2025 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="DS/GzDCB"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D3614AD2D
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 20:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756065731; cv=none; b=Qp9AXDoUYnNXVcxEpj/Ta0SLaK2G+ypObSjo+XlFl5EH1K1mk/1XACOgs48+E9chK7BalQUDkttATDaIxgyuo5/IJgbNuH++LcoSaMPZdHGU72LX0gq9gHFrP8RqKiZ77tzNLJsrheApBKDSUuY26zRMRvt6gQ3ujE7tJn6yvfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756065731; c=relaxed/simple;
	bh=COPZsh0etGC+lf+GyTOwTCqkEmJpPgHOhcScXUQB/p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XbWosD07LFFHZV0txdZC3wl2YjUoyErq40Qvf8LXtrhl/9L9v3cDGS3q1RvBu3DnxGwbsFcyF/soPUafqw9CV9dLEK/3bXW8y8Ailrwd+fZROiU/wHnn7tcNe4Qv/DEQYpQee4DJo0f+5y4ZSpUkPGT9oyz/9C6yHs2snFOuoOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=DS/GzDCB; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 4F975C5598;
	Sun, 24 Aug 2025 23:02:06 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id E2284C559A;
	Sun, 24 Aug 2025 23:02:05 +0300 (EEST)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c2:511b:0:7200:c86a:8976:4786])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 29E73206823;
	Sun, 24 Aug 2025 23:02:05 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1756065725;
	bh=BX16U7qvlMv2h4EJEHJNpyCG3RBhwjH7TgrJ12Feu/g=; h=From:To:Subject;
	b=DS/GzDCB4JOoYcbiSo1T1xA0yKrihcp7CKV9M5R7aCCFoJX2c3877NVMAXg9sF1ew
	 rvcUuZfClPPPeT4rjZHpPGJUukp7k41h+XR9OpFqcPGFczuWK0EHfmdK8CqseaTYIy
	 r0bLZNzXKhDLNGH1nnf2XY7SJ0y5sySs64s1feTENxocOhWT7p0Mn7WKOn2Hze0zgw
	 2xNqjBIecn51YtWUs4/SUlTODUZGdkogx6QrVsBpM/uIX1KKmNOHbGMvDduirmAGhH
	 6ByB+o+lw35DCfzKqwX64BDMk4A6vpdQW8BEKfLKZcXgK6I6np55u09HO3LddqEJFK
	 k/DJAh9oCcXLg==
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
Subject: [PATCH v1 1/5] drm: panel-backlight-quirks: Make ident optional
Date: Sun, 24 Aug 2025 22:01:58 +0200
Message-ID: <20250824200202.1744335-2-lkml@antheas.dev>
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
 <175606572562.883131.12699924690113578642@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Currently, having a valid panel_id match is required to use the quirk
system. For certain devices, we know that all SKUs need a certain quirk.
Therefore, allow not specifying ident by only checking for a match
if panel_id is non-zero.

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
2.50.1



