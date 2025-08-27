Return-Path: <linux-kernel+bounces-788693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70098B388D1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 19:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96F0E1B65DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809E321D59B;
	Wed, 27 Aug 2025 17:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="QVMMw+v2"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9DD4086A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 17:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756316782; cv=none; b=aHl4w290SYPzKjR/0HSFJt9a143mEloPxkePeZlmDivzVhiv17B2gC/A5u+dt0J74nJ84BylvFw5+DbPJ+RYn+hmDXn+pQUwjjAmNcyjlw3qVz36JDGcRgvGxFhLOgZEHi8UpdGPiBAOCe6dw6LEZIBnvAAFhEFcUMU+VOn0nPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756316782; c=relaxed/simple;
	bh=4fnvJSoNZCKE8ebnbM6wcmhny7J8Xe81TmQ4NCUVPp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IvX9bDxqul495w/6ICPSt78WBCPvN03a5kFgJxLMxE0fb/7BZSHDtSj8zqcLnHRC7NquOfdvIXl8cYelN12E2SoOxu+3DcFHkMP8YM0NmMym/EW72Iw1KKB/sl5nnMMQbSZu1PmRvI+znQl7Z6y4OxKL3eWHfOCqapcRb7fnQPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=QVMMw+v2; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 2CF61CB2A8;
	Wed, 27 Aug 2025 20:46:16 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 911CDCB377;
	Wed, 27 Aug 2025 20:46:15 +0300 (EEST)
Received: from antheas-z13 (x5996a855.customers.hiper-net.dk [89.150.168.85])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id B16BF1FDED9;
	Wed, 27 Aug 2025 20:46:14 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1756316775;
	bh=+CWCZESsLBKqUcSTKxc58R3VWf8+qqCt3sJyI8yzS6k=; h=From:To:Subject;
	b=QVMMw+v2No5duZAqtQuBt7Ru5JXRSU2CsJGl19jIleNap74KQf7cEdxrsQUtKI69Z
	 EEZaQ6v8SpCWkJ3SM/BsK6jWdzMdIdPPzx1alY6AQ72cugplZdpOcb2gSYJKInHBW5
	 QuEdhMRsBsYdgcEYZc9v1zo2RZCUc2l3WpWhfOaIJ5VKfGGSV6y448LR1kDCOb/Xzz
	 r6geFXNJDCg2TBxmGnCzzgpdq3m9taXKmdsKicGp3HF/m6wKeECYbnPqyZ4qZZiW6N
	 6OTHrpjyIP6Msi+4AJfudro2CcGk2wSynzuU5n84Kd/yDOUTB6RlSYv2TyN9/KOrJM
	 zOq8U5lecV5KA==
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
Subject: [PATCH v2 1/5] drm: panel-backlight-quirks: Make EDID match optional
Date: Wed, 27 Aug 2025 19:43:56 +0200
Message-ID: <20250827174400.3692549-2-lkml@antheas.dev>
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
 <175631677525.1365160.8366018674483553787@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Currently, having a valid panel_id match is required to use the quirk
system. For certain devices, we know that all SKUs need a certain quirk.
Therefore, allow not specifying ident by only checking for a match
if panel_id is non-zero.

Tested-by: Philip Müller <philm@manjaro.org>
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



