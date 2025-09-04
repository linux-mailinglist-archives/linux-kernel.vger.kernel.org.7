Return-Path: <linux-kernel+bounces-801414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BCFB444C8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D445A6A17
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC3031E102;
	Thu,  4 Sep 2025 17:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="PV+m0Gva"
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCEF3115B1
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008242; cv=none; b=h0foyZbXU0q2Ondba4jkt9q/KBU7E9PfGU+b8hnqbk7Nf1YTsTmRky1KDgT/SsFqCdQcDCOMplQ14LsAG2s7wggzCkG+L0V0OcX1xWEhQgTi7w5o5ez61JhRNclEWp2zJffd1KpXOKruqw736rZATSmPTBM5dC9J0yy5U6uDscc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008242; c=relaxed/simple;
	bh=/9zFELPNR6DoAl4jEWXR5u7Zn5MBmoxFSkVPxpXIARQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JMamc/bi8ecRD/Dcwr2vmHTH0NUs/F6EopgbLGN9yjgRY9j06faYZS37kz2MfU6KHE+aRou6TXNIDvPruCERxrSJ9NKgeR0uFLL0CbvR4saI9/UVKm4fGWYFEU7gIpIabZumnR4kFk8GEU2Z8re3HNWHv81ZZCyBoktE9AmZmik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=PV+m0Gva; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id 8D3CA47BC1;
	Thu,  4 Sep 2025 20:50:31 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id C7E0347A47;
	Thu,  4 Sep 2025 20:50:30 +0300 (EEST)
Received: from antheas-z13 (unknown [37.96.55.21])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 21B3B1FD0CA;
	Thu,  4 Sep 2025 20:50:29 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1757008230;
	bh=l26dr8uR62AnAhhwkHYMNUtqPhxn0Klhdmu7OKXxRBg=; h=From:To:Subject;
	b=PV+m0Gva4z8eHfoTYx04FQXRHnLgijsckdnSL0C982pqC3Q6l6Oer8NxOsCWYsiof
	 PqQ567CYH6Oyx1QMzpYKlEhK3d6Ip77uKEK+xiaK4VjSvmVERKpS60tRV8+j1fpQQf
	 /C7oxvaz5hRXOG0Xkw858IjHb8qJx5BqMQd54ZTGXkdI0i1qCOnmsLCO8QhSZ1dqJM
	 Av/p+H9uPy/9c6WOD2EW+AxcnO5Vz6ZC7hyyxVAUZdMhz7tI5Z1bs0iniSVGLPBAoC
	 FsJeJb1ZgeFc3LXf/jwl9jKVSw94LIy4X+BkIHN7UUBbxwP25+uyejQezGWJTHwXGD
	 58nqmOIsuTX4w==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 37.96.55.21) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	philm@manjaro.org,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v1 00/10] drm: panel-orientation-quirks: Add various handheld
 quirks
Date: Thu,  4 Sep 2025 19:50:15 +0200
Message-ID: <20250904175025.3249650-1-lkml@antheas.dev>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <175700823033.2008993.11033886265544383630@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Adds a bunch of handheld orientation quirks that collected in the Bazzite
kernel. I made sure they are alphabetically sorted. In addition, to keep
the series short, I grouped variants of the same device together.

Antheas Kapenekakis (10):
  drm: panel-orientation-quirks: Add AOKZOE A1 Pro
  drm: panel-orientation-quirks: add additional ID for Ayaneo 2021
  drm: panel-orientation-quirks: Add Ayaneo 3
  drm: panel-orientation-quirks: Add OneXPlayer X1 variants
  drm: panel-orientation-quirks: Add OneXPlayer X1 Mini variants
  drm: panel-orientation-quirks: Add OneXPlayer F1 variants
  drm: panel-orientation-quirks: Add OneXPlayer G1 variants
  drm: panel-orientation-quirks: Add GPD Win Max (2021)
  drm: panel-orientation-quirks: Add GPD Pocket 4
  drm: panel-orientation-quirks: Add Zeenix Lite and Pro

 .../gpu/drm/drm_panel_orientation_quirks.c    | 108 ++++++++++++++++++
 1 file changed, 108 insertions(+)


base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
-- 
2.51.0



