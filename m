Return-Path: <linux-kernel+bounces-729135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C79B03234
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 18:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5FF13BD087
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 16:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B129281372;
	Sun, 13 Jul 2025 16:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPouQW8i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D359372625;
	Sun, 13 Jul 2025 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752425578; cv=none; b=V6YYtQmHJ8qmnz4DphoDlDRA/9lHA7KrQoXppvZ4FjcSYYDfpyTikObcXjDyCqb+oSpm2WX6EKXjq4QIIc84auaSwwwNdwUJLmeB8ZmPfggrwG/DWnb1PmeRfWCaxuufTz1b8iW7FSIvFl2OAizbdarCaoOLUujp/uRMj84aTcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752425578; c=relaxed/simple;
	bh=bLXcBa8W8XowxfxvCrqgFihZaM3OYSmTXr+Nl5CC8Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HjRwlvZVMpQ8mh8pyR5UIV47x2DYq84XfZtY51lKARcXLkHq//XpOEpIRNyM3wBwvrW8aKG6SUXhzy0remoi0sKPgo4d8ccFsbQtAWUeWdojWBypfBCmAN/SGuHK/VDPtPvbt/RAt6ynjlIQfbRLBI8A+gu5u6SK1mYD7c18/58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPouQW8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2227EC4CEE3;
	Sun, 13 Jul 2025 16:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752425578;
	bh=bLXcBa8W8XowxfxvCrqgFihZaM3OYSmTXr+Nl5CC8Wo=;
	h=From:To:Cc:Subject:Date:From;
	b=CPouQW8iqM/NKBmuAZQkB5Bt+EiMk5m2t1e/ahK+el7qz2/APeM0+LZ17Vki87WxI
	 uPgV858At6pJAqGXICny0ZjWCGgQRJQUHqyxvOGc/flge9u+CsGUPA/07TeAgoNwkM
	 qc1Obl7raaeTW8+/vufm0wdR0zR5AWNGj3Icb1+JiiYeAZabLmHIx+u6Z/IbhH2ANv
	 6Wo92Aymuw1oCEXD8+t4VlFp3ZLPqNSGAB1RirEi4GoadLdClHmBAXbgl/OPc26Nnb
	 2+hhz9JeF7bJY/BzQ21u8aF84XjUxU1/YgFEzSxRtBQKCdSdBJZYpuaWWfyxGplvFz
	 lViNArO+vtSYg==
From: Stephen Boyd <sboyd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v6.16-rc5
Date: Sun, 13 Jul 2025 09:52:54 -0700
Message-ID: <20250713165256.1650456-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to a42b4dcc4f9f309a23e6de5ae57a680b9fd2ea10:

  dt-bindings: clock: mediatek: Add #reset-cells property for MT8188 (2025-06-20 18:17:23 -0700)

----------------------------------------------------------------
Fixes for a few clk drivers and bindings:

 - Add a missing property to the Mediatek MT8188 clk binding to
   keep binding checks happy

 - Avoid an OOB by setting the correct number of parents in
   dispmix_csr_clk_dev_data

 - Allocate clk_hw structs early in probe to avoid an ordering
   issue where clk_parent_data points to an unallocated clk_hw
   when the child clk is registered before the parent clk in the
   SCMI clk driver

----------------------------------------------------------------
Julien Massot (1):
      dt-bindings: clock: mediatek: Add #reset-cells property for MT8188

Sascha Hauer (1):
      clk: scmi: Handle case where child clocks are initialized before their parents

Xiaolei Wang (1):
      clk: imx: Fix an out-of-bounds access in dispmix_csr_clk_dev_data

 .../bindings/clock/mediatek,mt8188-clock.yaml          |  3 +++
 drivers/clk/clk-scmi.c                                 | 18 ++++++++++--------
 drivers/clk/imx/clk-imx95-blk-ctl.c                    | 12 ++++++++----
 3 files changed, 21 insertions(+), 12 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

