Return-Path: <linux-kernel+bounces-860102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B388BEF51C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 06:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF226189102A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37112C0280;
	Mon, 20 Oct 2025 04:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksOg13+z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BCD29D267;
	Mon, 20 Oct 2025 04:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760936180; cv=none; b=k6a3eQ9Kb15AAcwM6gkTziRxjgYel5onGP59vYkleyuij9UPKRDkpSTdvqCjXC7+klGC7aLDbqtG4oEmSR3srvLyJtlFSOE7J8gdJkPemT3Gz/AAl4/b0r76jJR7cv4xVOTz7AqSQBgRJlomvVefZ2UvPF5oiS0+GA6jp2C8Xlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760936180; c=relaxed/simple;
	bh=nrXnqlV7dTZ3tYdmSQOtQfvcxz6jaOoC+0u6XE9jwfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jDTkPQzDf2V2n+iJ9mqN2xg51INxNoCYOXQ2S07JKyZDP7lTluQ6pZ94JfAof/Wum4sDhrYHAvu1rAJQCyYtxxi83hFvGwC57tEi+c+0+arQb80nxUyQEFWrteunjNtN/1LuLdsz3ZtS0F6OZcD5kTAXWkKxR6fi4Bv7ZPCc1YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksOg13+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A0CC4CEF9;
	Mon, 20 Oct 2025 04:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760936179;
	bh=nrXnqlV7dTZ3tYdmSQOtQfvcxz6jaOoC+0u6XE9jwfs=;
	h=From:To:Cc:Subject:Date:From;
	b=ksOg13+zPrC8xxnakzV8VSglMoxWAQWwFCALpTQZjBj0uaOZIuqs5AsDrSQUiLu5x
	 deqimQfqaWCXc0ydoHo0xutavQJactWCZFIOkNG3dmJuEq1ATiLiyWJmqvY3p4ekxS
	 ofr1Tr34OLOxkZBFWSuMQJBhPDa1aPkTMMk2cVDaaXsWtxrXEEPHVv4E/LbiW+0+hJ
	 NKf0S6a3qxhC8E81lhMuVcv6BpRsEU6yCMsggk5MQYpbdHgn5L8x+1OcBvgnzeaWOA
	 wpmzEMM56UTcnailUMcW+r2o8ywQIkRyy+CHlCoZTT/IgDfg1hHI4JXls+exi+HCmA
	 Yk12jphbh2PCQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 4EC1B5FDC3; Mon, 20 Oct 2025 12:56:17 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: Lee Jones <lee@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	linux-sunxi@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH resend] MAINTAINERS: Update Chen-Yu's email address
Date: Mon, 20 Oct 2025 12:56:02 +0800
Message-ID: <20251020045603.2573544-1-wens@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The email forwarder I'm using has run into severe problems with Gmail
lately. Switch over to my kernel.org address for kernel development.

Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
---
(resent to correct dri-devel mailing list address)

This likely needs to go through drm-misc-next following a patch from
Maxime that removed himself from the Allwinner DRM driver entries.

 .mailmap    | 1 +
 MAINTAINERS | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/.mailmap b/.mailmap
index ea92027981fb..1a2a61c02ee7 100644
--- a/.mailmap
+++ b/.mailmap
@@ -173,6 +173,7 @@ Carlos Bilbao <carlos.bilbao@kernel.org> <bilbao@vt.edu>
 Changbin Du <changbin.du@intel.com> <changbin.du@gmail.com>
 Chao Yu <chao@kernel.org> <chao2.yu@samsung.com>
 Chao Yu <chao@kernel.org> <yuchao0@huawei.com>
+Chen-Yu Tsai <wens@kernel.org> <wens@csie.org>
 Chester Lin <chester62515@gmail.com> <clin@suse.com>
 Chris Chiu <chris.chiu@canonical.com> <chiu@endlessm.com>
 Chris Chiu <chris.chiu@canonical.com> <chiu@endlessos.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index 1ce0b7628450..34acf513d7fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2302,7 +2302,7 @@ S:	Maintained
 F:	drivers/clk/sunxi/
 
 ARM/Allwinner sunXi SoC support
-M:	Chen-Yu Tsai <wens@csie.org>
+M:	Chen-Yu Tsai <wens@kernel.org>
 M:	Jernej Skrabec <jernej.skrabec@gmail.com>
 M:	Samuel Holland <samuel@sholland.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
@@ -7641,7 +7641,7 @@ F:	drivers/accel/
 F:	include/drm/drm_accel.h
 
 DRM DRIVER FOR ALLWINNER DE2 AND DE3 ENGINE
-M:	Chen-Yu Tsai <wens@csie.org>
+M:	Chen-Yu Tsai <wens@kernel.org>
 R:	Jernej Skrabec <jernej.skrabec@gmail.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
@@ -8255,7 +8255,7 @@ F:	drivers/gpu/nova-core/
 F:	rust/kernel/drm/
 
 DRM DRIVERS FOR ALLWINNER A10
-M:	Chen-Yu Tsai <wens@csie.org>
+M:	Chen-Yu Tsai <wens@kernel.org>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
@@ -27754,7 +27754,7 @@ F:	drivers/acpi/pmic/intel_pmic_xpower.c
 N:	axp288
 
 X-POWERS MULTIFUNCTION PMIC DEVICE DRIVERS
-M:	Chen-Yu Tsai <wens@csie.org>
+M:	Chen-Yu Tsai <wens@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 N:	axp[128]
-- 
2.47.3


