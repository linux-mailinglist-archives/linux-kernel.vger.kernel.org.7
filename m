Return-Path: <linux-kernel+bounces-783788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DEEB33274
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 22:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0718C1899E0A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 20:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858D0225409;
	Sun, 24 Aug 2025 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="k/Gz98ZX"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CD015D3
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 20:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756065731; cv=none; b=BAZl3H7F1JskiTVCFzp2sVU2c5Bjr++mHprSOeOfLCTKXcWtHNpqO1FEGYcDWAJbEb+hmgWQD2BaVGBh/VdWVA28eMPgssKKOoBTGCvecdrVbefTYi25iutNEWZmHboLa5tTRzsJ3tyaO3dsFZkfYDU/GnM4eMsQcY4z0DkqvcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756065731; c=relaxed/simple;
	bh=uA6+t/CYlJzEbaTTNVc9L+HIrYn5JBeHuRHMilb0h9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fJx3o4u3fNwSQKNNgXmtkM1QqIaQcywuVkjiQpCgU9w24GM2PI5iDgRsJFLEkTvR+EOwj/5EAi7knDmbKqm8jnBkXeYlQN+T2r0DhKjfUOdF3QoLYDW/D2HxNCZETbB/B2VtK8U0F3yGc92SAgZlWTYC826Rp968ZxU4cvh4mfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=k/Gz98ZX; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 3AF0AC55A7;
	Sun, 24 Aug 2025 23:02:06 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 57857C54FE;
	Sun, 24 Aug 2025 23:02:05 +0300 (EEST)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c2:511b:0:7200:c86a:8976:4786])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 67C191FC98E;
	Sun, 24 Aug 2025 23:02:04 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1756065725;
	bh=DSIeXh75uwnrGNiDkDClkuCuFP3A7KiUEI4xBy97248=; h=From:To:Subject;
	b=k/Gz98ZXAhZfxv2t0BUdFV0KBVjURQOs0vYrskT78gfoLCm026S3udhlAqcljXSRa
	 gArYB3biOK4G7vu2lcXPQgW60++M9LvvgHRursDNa1xyZfYjkyosecQM73zB/wFnEB
	 9NvGz2VesODHJoySlptm1OH8RR2A7a75R1NgcU7gdOGulHvV28FGAT5YFPwHsSDu+h
	 FzLdCsiWqGwL8pN6kPgucD63fkkngloaab1Ez4tq8nJVkBnocJ8ebjevqphS/rrz7q
	 loflLG8oeOOMGVXOSMdjdZVlSbcm6HMNV7j5O8v1/EfNunTHyCL1H4j3QacJEFh833
	 +V1aKVnJ4sVwQ==
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
Subject: [PATCH v1 0/5] drm: panel-backlight-quirks: Do partial refactor and
 apply OLED fix
Date: Sun, 24 Aug 2025 22:01:57 +0200
Message-ID: <20250824200202.1744335-1-lkml@antheas.dev>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <175606572489.883082.11609924983849574831@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

This is an alternative to [1], since Phil found out there are still invalid
values. I made this series before the one I sent today, and I have to say
I tested it much less. Because I did not think it was very viable to
upstream. I was also not aware of [2] and [3] since they are not in a
public bug tracker such as amddrm and my issue there [4] remains closed.

I lower the cc'd here since this is a draft. But this could have some
viability. Especially since I can stop carrying the dodgy patches from
SteamOS so that the SD OLED has a 0 brightness min.

[1] https://lore.kernel.org/all/20250824085351.454619-2-lkml@antheas.dev/
[2] https://gitlab.manjaro.org/packages/core/linux616/-/blob/master/0001-drm-amd-display-Add-a-quirk-for-the-Zotac-Zone.patch
[3] https://gitlab.manjaro.org/packages/core/linux616/-/blob/master/0004-TEMPORARY-terrible-hack-for-zotac-screen-while-debug.patch
[4] https://gitlab.freedesktop.org/drm/amd/-/issues/3803

Antheas Kapenekakis (5):
  drm: panel-backlight-quirks: Make ident optional
  drm: panel-backlight-quirks: Convert brightness quirk to generic
    structure
  drm: panel-backlight-quirks: Add secondary DMI match
  drm: panel-backlight-quirks: Add brightness mask quirk
  drm: panel-backlight-quirks: Add Steam Decks

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  19 +++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   6 +
 .../link/protocols/link_edp_panel_control.c   |   2 +-
 drivers/gpu/drm/drm_panel_backlight_quirks.c  | 106 +++++++++++++-----
 include/drm/drm_utils.h                       |   8 +-
 5 files changed, 109 insertions(+), 32 deletions(-)


base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
-- 
2.50.1



