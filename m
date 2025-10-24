Return-Path: <linux-kernel+bounces-869096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A63C06F09
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FA6E501EBC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5D332548D;
	Fri, 24 Oct 2025 15:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="i39qhKqz"
Received: from relay13.grserver.gr (relay13.grserver.gr [178.156.171.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB622D94A8;
	Fri, 24 Oct 2025 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.156.171.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761319328; cv=none; b=OlAF2fR/wSDb4ipjVc+DDGYGINfqQsPCv65hahcD3kFsxk8Si05TZ8s8UfpPK97xCTseQ9byQb/kEyeP9xDhl3FnFJVD8/G8pRmfcDlibbJPTz+xEsCwE9mdV01XYOKw97srYOwG/N0FT7hUC8iPz5m5svjhw2sFBS4iuI2EY5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761319328; c=relaxed/simple;
	bh=n+SbHga5ia3gKeK3j+i35OyQjj3ugyicaDWhX6StU8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LskNiArAf2opi3m/qd19e7GLnSn0SuW7KWWwQtOJ6nkVqUpyK5KDKIEJvlMuM80FR+5p4sKjF/spggAfoF+gYaevXXdWgIsOPeeJcTbmBl/ENwQMt8pEkg9Bv/AJpsQ8GZueHQ9HlPcWg9hbnZy531BN045JdPvp+kaObi18n0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=i39qhKqz; arc=none smtp.client-ip=178.156.171.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay13 (localhost [127.0.0.1])
	by relay13.grserver.gr (Proxmox) with ESMTP id 3EFCE5E681;
	Fri, 24 Oct 2025 18:21:58 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay13.grserver.gr (Proxmox) with ESMTPS id 248575E672;
	Fri, 24 Oct 2025 18:21:56 +0300 (EEST)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c2:511b:0:8d8a:5967:d692:ea4e])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id CE7E31FD894;
	Fri, 24 Oct 2025 18:21:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1761319315;
	bh=pfGMDfUmZV6asO0wJ+O/PWLq8q1d5Rkx+DwIVdVCa/4=; h=From:To:Subject;
	b=i39qhKqzo9Xe+IuKI2dC1EPOT/osV17zvohXQgWNSESKAAZWslQPzWoXEC+ccLs9K
	 sKDfVicjhjC8E7ab0kAeZwt7fmhL1JvKJgD0K3hM3ojYXeQhkYLkXUXHJGbiiWP3Ak
	 rXbuPBS0pv14boH11EFs4GlxA4ICWVC6uZre2R2WWJ+eRzuP/4gKwX5oC+v7ouNv3Y
	 jYs037oWKAqDtNQvmS59A7INEf89U1Tu2vJAAkzB0XinuN+OEjrwT+UGltdKBkKBLQ
	 N4gMNkWCdoHlA5klScfex7VVA6CPQRYBVKjdThW44qo3Juht5nP5wzbjHJ+/t8nejI
	 jPakxd7YssRtw==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:8d8a:5967:d692:ea4e) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: Alex Deucher <alexander.deucher@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v1 0/3] platform/x86/amd: Add S0ix support to the Xbox Ally
Date: Fri, 24 Oct 2025 17:21:49 +0200
Message-ID: <20251024152152.3981721-1-lkml@antheas.dev>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <176131931531.2356012.12308341767640511320@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

The Xbox Ally features a Van Gogh SoC that on the Steam Deck uses S3.
Therefore, kernel support for S0ix was previously absent. Introduce
this support in three patches:

1) Add Van Gogh to AMD PMC driver
2) Enable spurious_8042 quirk, as it is common in those generations
3) Adjust the Van Gogh init logic to avoid powering down the rlc
   and tweak post init

This allows the Xbox Ally to properly enter and exit S0ix suspend.
Perhaps it also allows the Steam Deck to use s2idle without crashing,
note it is not currently possible [1].

Currently, around 1/10 times the SoC misses the PMC hint and does not
enter S0ix, so perhaps 1 or 3 need tweaking further. It wakes up always,
however.

@Alex: I tweaked the text on patch 3 a bit. You can resend it separately
after the issue with 1/10 failures is fixed.

[1]: https://github.com/evlaV/linux-integration/commit/5ab73e9069017aa1b5351f91513ba540ce5905fb

Alex Deucher (1):
  drm/amdgpu: only send the SMU RLC notification on S3

Antheas Kapenekakis (2):
  platform/x86/amd/pmc: Add support for Van Gogh SoC
  platform/x86/amd/pmc: Add spurious_8042 to Xbox Ally

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       | 8 +++++---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        | 6 ++++++
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 3 +++
 drivers/platform/x86/amd/pmc/pmc-quirks.c        | 8 ++++++++
 drivers/platform/x86/amd/pmc/pmc.c               | 3 +++
 drivers/platform/x86/amd/pmc/pmc.h               | 1 +
 6 files changed, 26 insertions(+), 3 deletions(-)


base-commit: 6fab32bb6508abbb8b7b1c5498e44f0c32320ed5
-- 
2.51.0



