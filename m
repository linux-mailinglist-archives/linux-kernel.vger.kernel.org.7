Return-Path: <linux-kernel+bounces-744924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2589B11290
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C113516CF55
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629C62749CF;
	Thu, 24 Jul 2025 20:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIgzGMvf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC842E371D;
	Thu, 24 Jul 2025 20:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753390105; cv=none; b=ni3pvk5vLhuEg98QK7KrT0ZElFYVPb7nMBjJgxXuj+hTkF/4vr/zbmn8nTtwAiUTTwLXWU1vx8HYqAONUfX7Ez9zuTvb12SUTH5VjpOyHCe0QDs37J3MbUYY2quZuCID871guMQ3eCeTqaRKSnOQIyvMzLwe74YfeqaKhwcC/40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753390105; c=relaxed/simple;
	bh=u9xpcw4a/you+H+16oHVm0t5GKpLjwCxq499Db9OVZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oTWCvEo5lXSxtZ/BktAqSRMdI4ZxDA3+mFaZBbHZR6D6OI2jR9cAUdxIIPq3Rlpkx4FJmXjMEuYciWV8xf/W3ur2eWxs/emouXiWyfywoh3Cd/SMAZSH9iYAlAu3tQHKJECCt3aLJD2q770Lx9Hi2cek1KwBB+9EjoAmC97bisI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIgzGMvf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A826C4CEF4;
	Thu, 24 Jul 2025 20:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753390105;
	bh=u9xpcw4a/you+H+16oHVm0t5GKpLjwCxq499Db9OVZ0=;
	h=Date:From:To:Cc:Subject:From;
	b=YIgzGMvfEc+lkJ8wrYWgj602zUqjOv6Z2PyOOr7zj6nijfTkbZF8AwVpxaYPraXEl
	 U6oHIMWujPUSsMyRvplQfdalvqHNAX0NSYKQAcBlmsNYXing7cwyt12AFQo4E4h74p
	 psd5zlOYDi1TM7gXRWb8jVyCZd+d/s1C61Palh2+EzTqYnrJChUOfJJhshK2utetgQ
	 18d4BbXaw/I0pcjPOgc5DA92E5WcsyKKs5rNXQde6cdLk+ZRfwpOqEfHvM34LGx6rB
	 0fivqvnZsKoApGCqHsQUizC6k/vK59cIW73An1GFVkJPoLUCIESFgwg6KJDlasiLf0
	 9ev5DGMy3o7GQ==
Date: Thu, 24 Jul 2025 13:48:23 -0700
From: Drew Fustini <fustini@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, Yao Zi <ziyao@disroot.org>
Subject: [GIT PULL] clk: thead: Updates for v6.17, part 2
Message-ID: <aIKcFzsCvvz0PCBW@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Stephen,

I'm sending this followup PR in case there is still time to include it
for your 6.17 PR. Yao Zi refactored mux clk registration which fixes an
orphan mux clk issue which would occur when booting with mainline uboot.

Thanks,
Drew

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fustini/linux.git tags/thead-clk-for-v6.17-p2

for you to fetch changes up to 54edba916e2913b0893b0f6404b73155d48374ea:

  clk: thead: th1520-ap: Describe mux clocks with clk_mux (2025-07-22 15:40:54 -0700)

----------------------------------------------------------------
T-HEAD clock changes for v6.17, part 2

One more improvement for the T-HEAD TH1520 clock controller this cycle:

Yao Zi has fixed an issue where the c910 mux clk could end up as an
orphan in CCF when the bootloader reparents it to the c910-i0 mux clk.
The solution is to refactor the handling of mux clocks by embedding a
clk_mux structure directly in ccu_mux. This allows the mux clocks to be
registered with devm_clk_hw_register() without allocating any new clk_hw
pointer which solves the orphan issue.

This change has been tested in linux-next. The LPi4a still boots okay
without clk_ignore_unused and peripherals like serial, emmc and ethernet
are functional. The file /sys/kernel/debug/clk/c910/clk_possible_parents
now correctly outputs: "c910-i0 cpu-pll1"

Link: https://lore.kernel.org/linux-riscv/20250722080535.60027-2-ziyao@disroot.org/
Signed-off-by: Drew Fustini <fustini@kernel.org>

----------------------------------------------------------------
Michal Wilczynski (1):
      clk: thead: Mark essential bus clocks as CLK_IGNORE_UNUSED

Yao Zi (2):
      clk: thead: th1520-ap: Correctly refer the parent of osc_12m
      clk: thead: th1520-ap: Describe mux clocks with clk_mux

 drivers/clk/thead/clk-th1520-ap.c | 109 +++++++++++++++++---------------------
 1 file changed, 48 insertions(+), 61 deletions(-)

