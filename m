Return-Path: <linux-kernel+bounces-860100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F81DBEF510
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 06:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 354301895AC3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A102C0266;
	Mon, 20 Oct 2025 04:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUPJaQtU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C051E9919;
	Mon, 20 Oct 2025 04:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760936052; cv=none; b=HwLe3EdFFcS1oFkuwbSKIplZZ2liwHJltCp8ouqHbzjEa775BfbKCXvcEzPNql/i//2DObQ2QpoZFBrcmAKcdogOTJ2QDjIqH3KBJrw6cnbPe15kVhNFQhf+TJRyrOZW9gSr9nCRsiwAmHDEFhEu7PhkNKIXbh/g1RYztwANRKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760936052; c=relaxed/simple;
	bh=rQCfnU4y+Ys/8EJZN1Gwn/4+w69oR2ZqZEduSGJk0xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LK8Z3coWS+5R76Oxss8LK82JTqbyFWyAViNwE/4AA6tw0D4rYo/4LhbcnNozXlpHZrGyA4ekNiDwFgq9PUjVcnXWtwtoiln0NeT639d/Rb355YObysoFAmnOqQIB0YkF34YN/wEYa0RWBhp1GBShDoVWAeo539sJc63PavQgq4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUPJaQtU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996F8C4CEF9;
	Mon, 20 Oct 2025 04:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760936051;
	bh=rQCfnU4y+Ys/8EJZN1Gwn/4+w69oR2ZqZEduSGJk0xQ=;
	h=From:To:Cc:Subject:Date:From;
	b=IUPJaQtUaPSbtanPTgHj1Itiw9rm+IYwpzLnLJnx9IyqzXI2CN2XvQvPh90RhHeV4
	 jQm7kauBT69LGdZq5nAL917ZszzAW2PUlzGJpTDPCnGW//mX4zPw7qGlvLWDnhXDH9
	 +CBjbPStxohPDAh1f71VC5H9/GvkFihm5aMgMyYy7UDVCZos8J7kuZiaPOgugQNTzp
	 GUZ8XTJsElpe5QCs4X9Oqhrki3s5P0PFnUKyCxpE3hT/Mss8m9LXUcEHts4vxytib7
	 ifdUcqSlgWVRW1hsqZtzty1IbuzknsdpG3M0gU0OVVMVPu4oPPdzMdsTefFCKicpkZ
	 D+hUCZ2iNx6XQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 2B37B5FDC3; Mon, 20 Oct 2025 12:54:09 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: Chen-Yu Tsai <wens@kernel.org>, Lee Jones <lee@kernel.org>,
	Maxime Ripard <mripard@kernel.org>, linux-sunxi@lists.linux.dev,
	dri-devel@wens.tw, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update Chen-Yu's email address
Date: Mon, 20 Oct 2025 12:53:37 +0800
Message-ID: <20251020045340.2572507-1-wens@kernel.org>
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


