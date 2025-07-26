Return-Path: <linux-kernel+bounces-746856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 166A3B12C11
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 21:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4142E1C21895
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 19:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7734628A1DA;
	Sat, 26 Jul 2025 19:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T86YaLhy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CAE1D54E3;
	Sat, 26 Jul 2025 19:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753558562; cv=none; b=JwFmJyEsIlYSDkYhGFH92K1UX6MPnYUQxjwt1mDdbFQn+hAmMn/KJhZvQLLUMjWEZ7aRiqazrZR97r1LeQ+F23jK8uaAJKAZMxjFqLurBJ+9zFjFtIcyjZzq7tWzpW1/+vgExzEIT7cqIZkskL+Rrur5BrdkYeegjCUQOQWWPSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753558562; c=relaxed/simple;
	bh=1FIDiWT3v6DdJW5SqSY1kxLF7ggpkFphI5xImFWm+kA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kzovzyC/jMJzLeBL/xTo118n1TKFeosJ/ZrETdfa1TGu6HUOXOda8yg9F3LdiW2Arc7zYjbolH44dhU4iFAxEJLJuNo1ma+RkYjg3A0xpQjjUNKzEgVy5sgWRpHxU2TObYZ7LVo/gGRLk0muveBfF8Q19M+AVXXk/Ky0D0QyLZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T86YaLhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21571C4CEED;
	Sat, 26 Jul 2025 19:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753558562;
	bh=1FIDiWT3v6DdJW5SqSY1kxLF7ggpkFphI5xImFWm+kA=;
	h=From:To:Cc:Subject:Date:From;
	b=T86YaLhydD8GrvC6mWwuvXbIIDq54gYHJNEDP5e3OeXUeIcnrSxOOZ1CdBBdjDnGB
	 xm0xlWnqSfa9ipRuxhBEYwW7v2xtYuarTQJ/KolL9Pgk9suG+Qj6SxqlcZR+sAMGfZ
	 zx6lgoXIBDCVWO/CsPza54K9OG6VZ6Xz48+Pakudkr+b4bn4OVDPDaD67lmr5YQI60
	 Mjs+0qCcyvtScNE9BPQJQE9GJEnlbagIpBp7yxlFp8BtSkhNtlGCMgPOEnNO973M68
	 idxkCb3YFa9V0RqaX7lUx+DXpNLD2rAhWuS0MBvsS6tDgzc3ToEl1f2aS5fut+fEba
	 je+F9eYzVICLw==
From: Stephen Boyd <sboyd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v6.16-rc7
Date: Sat, 26 Jul 2025 12:35:58 -0700
Message-ID: <20250726193600.1549708-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit a42b4dcc4f9f309a23e6de5ae57a680b9fd2ea10:

  dt-bindings: clock: mediatek: Add #reset-cells property for MT8188 (2025-06-20 18:17:23 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to e4b2a0c2b9be6d10b0e50a7485fe9f569a6f2436:

  Merge tag 'sunxi-clk-fixes-for-6.16' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into clk-fixes (2025-07-21 10:17:51 -0700)

----------------------------------------------------------------
A few Allwinner clk driver fixes:

 - Mark Allwinner A523 MBUS clock as critical to avoid system
   stalls
 - Fix names of CSI related clocks on Allwinner V3s. This
   includes changes to the driver, DT bindings and DT files.
 - Fix parents of TCON clock on Allwinner V3s

----------------------------------------------------------------
Chen-Yu Tsai (1):
      clk: sunxi-ng: a523: Mark MBUS clock as critical

Paul Kocialkowski (3):
      clk: sunxi-ng: v3s: Fix CSI SCLK clock name
      clk: sunxi-ng: v3s: Fix CSI1 MCLK clock name
      clk: sunxi-ng: v3s: Fix TCON clock parents

Stephen Boyd (1):
      Merge tag 'sunxi-clk-fixes-for-6.16' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into clk-fixes

 .../devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml |  2 +-
 .../devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml |  2 +-
 .../bindings/media/allwinner,sun6i-a31-mipi-csi2.yaml      |  2 +-
 arch/arm/boot/dts/allwinner/sun8i-v3s.dtsi                 |  2 +-
 drivers/clk/sunxi-ng/ccu-sun55i-a523.c                     |  3 ++-
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c                       | 14 +++++++-------
 include/dt-bindings/clock/sun8i-v3s-ccu.h                  |  2 +-
 7 files changed, 14 insertions(+), 13 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

