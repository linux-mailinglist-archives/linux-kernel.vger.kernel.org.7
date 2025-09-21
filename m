Return-Path: <linux-kernel+bounces-826287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08869B8E169
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 19:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF672188E801
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 17:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6830D25BEE5;
	Sun, 21 Sep 2025 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXQY3s3e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C164D1E1E0B;
	Sun, 21 Sep 2025 17:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758474898; cv=none; b=luzJoanvHONw253Tq4t/nPGaRURuSPspZzMnPG1elC6bTU/emek21+3+WKYRdGgnQ21KvPPcyn1j3PIc8RKZS1G4Yp8ft8cA8LunrNgRHT+GNVX5gvJTDD+jEubdPcyaMtTEog995QqWLxgCHU/9AYXpIxIQv4em5DbibKrr27I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758474898; c=relaxed/simple;
	bh=GmuX0SguOCIJlpj3GiSa35uB4z9R/MZL635/e5N2u1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FhGVAYNurmDMXnWq4Uc7Mb0TB8KvkBi882ptaawnmBKHXHmOn7+x7UmfdbHgFUc+lSz148dktVJxHfAjKwa/iEefR8f65StTil5B322j6tO1SpDPIv5My9vwTIk8UC7y4yf1wPaxzFhUGtbFMuQsMNIq0Li/LFHbUO2qOqUIf4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXQY3s3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C92EC4CEE7;
	Sun, 21 Sep 2025 17:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758474898;
	bh=GmuX0SguOCIJlpj3GiSa35uB4z9R/MZL635/e5N2u1M=;
	h=From:To:Cc:Subject:Date:From;
	b=IXQY3s3eaAQhchWzCIwTz/2chDlvtdSOVmtQL8WYompOvVUPBsxoCmRw1IGAR5Ex6
	 L6hySOyAwqOg83tGTHFQeE1Ob+bHJNyFI6/AAQD1sgnlNlavluBAJ1ZX/jNDnZ3YVT
	 4mygqItqiMaxDR31iEo8IHpGOk+DYvMrNdezLN9ZXTY5ACaBK8zvupUnboY2cd88kU
	 6gPFQFzwcnqE3TD3gk3ctxSn2Ysnl5VBm6MtmntScF+hn8HRC3nCWn5s7j2/vvopM3
	 I49DzUw7lprQ0dOzTN0XHTP+VidV9nAIwxrdKHmeuoD4uojh67R81fgc3FgYBgCPyf
	 MW0rHtyv+MmyQ==
From: Stephen Boyd <sboyd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v6.17-rc6
Date: Sun, 21 Sep 2025 10:14:54 -0700
Message-ID: <20250921171456.1418491-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 764c921bf0c5ff125989a6c039a344ed211ffda9:

  Merge tag 'sunxi-clk-fixes-for-6.17' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into clk-fixes (2025-09-19 21:28:01 -0700)

----------------------------------------------------------------
Fixes to the Allwinner and Renesas clk drivers:

 - Do the math properly in Allwinner's ccu_mp_recalc_rate() so
   clk rates aren't bogus

 - Fix a clock domain regression on Renesas R-Car M1A, R-Car H1,
   and RZ/A1 by registering the domain after the pmdomain bus is
   registered instead of before

----------------------------------------------------------------
Chen-Yu Tsai (1):
      clk: sunxi-ng: mp: Fix dual-divider clock rate readback

Geert Uytterhoeven (1):
      clk: renesas: mstp: Add genpd OF provider at postcore_initcall()

Stephen Boyd (2):
      Merge tag 'renesas-clk-fixes-for-v6.17-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-fixes
      Merge tag 'sunxi-clk-fixes-for-6.17' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into clk-fixes

 drivers/clk/renesas/clk-mstp.c | 20 +++++++++++++++++++-
 drivers/clk/sunxi-ng/ccu_mp.c  |  2 +-
 2 files changed, 20 insertions(+), 2 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

