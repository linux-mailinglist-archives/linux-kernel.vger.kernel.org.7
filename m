Return-Path: <linux-kernel+bounces-835992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F158BA8881
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55EDB3ACD41
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3A8283CB5;
	Mon, 29 Sep 2025 09:10:15 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1A228151E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137015; cv=none; b=Eaqq02xiegKYgnYV4QAZ/uGPvEMDPaB05j+sLv2p5uBNznE7h9S7Yv8BJYihatBmTdgLdfRQmk62jn+m8g5xGCVOLLBudfWjQfUP/q0EJJ2z+r00FdcfBXH1boFUoqZekp55Rak3yzzaTK1ZY+4DkVneuYROIPwLoar6xdt2NDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137015; c=relaxed/simple;
	bh=eRT4sePqGMjO293LBZ1UcOBkqyPLeh1KdH7YxNdBeSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IfvTwMIfGjJmsTRfExq/8mjM6aMeM+RwognloV6PiiNScKjKzLgvgXNn0KdGhUfMurJoavemBdPUh14WO2EBLMJ7q0/X+nogUw/wghuZain1LsMp9n5YnlivfeiOmJEZhsX34N/FbH0deJ2swCKnyDHXhbajrneWS2RgEGv6qZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEECFC4CEF4;
	Mon, 29 Sep 2025 09:10:13 +0000 (UTC)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] m68k updates for v6.18
Date: Mon, 29 Sep 2025 11:10:05 +0200
Message-ID: <20250929091005.2829122-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi Linus,

The following changes since commit f83ec76bf285bea5727f478a68b894f5543ca76e:

  Linux 6.17-rc6 (2025-09-14 14:21:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.18-tag1

for you to fetch changes up to 695f2c0c25f3c844f9dd177d20c1e8afc55df1ac:

  m68k: defconfig: Update defconfigs for v6.17-rc1 (2025-09-15 14:30:21 +0200)

----------------------------------------------------------------
m68k updates for v6.18

  - Fix whitespace in Zorro name macros,
  - Fix find_*_bit() signatures,
  - Defconfig updates.

Thanks for pulling!

----------------------------------------------------------------
Dishank Jogi (1):
      zorro: Remove extra whitespace in macro definitions

Geert Uytterhoeven (2):
      m68k: bitops: Fix find_*_bit() signatures
      m68k: defconfig: Update defconfigs for v6.17-rc1

 arch/m68k/configs/amiga_defconfig    |  9 +++------
 arch/m68k/configs/apollo_defconfig   |  9 +++------
 arch/m68k/configs/atari_defconfig    |  9 +++------
 arch/m68k/configs/bvme6000_defconfig |  9 +++------
 arch/m68k/configs/hp300_defconfig    |  9 +++------
 arch/m68k/configs/mac_defconfig      |  9 +++------
 arch/m68k/configs/multi_defconfig    |  9 +++------
 arch/m68k/configs/mvme147_defconfig  |  9 +++------
 arch/m68k/configs/mvme16x_defconfig  |  9 +++------
 arch/m68k/configs/q40_defconfig      |  9 +++------
 arch/m68k/configs/sun3_defconfig     |  9 +++------
 arch/m68k/configs/sun3x_defconfig    |  9 +++------
 arch/m68k/include/asm/bitops.h       | 25 ++++++++++++++-----------
 drivers/zorro/names.c                | 12 ++++++------
 14 files changed, 56 insertions(+), 89 deletions(-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

