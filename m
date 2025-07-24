Return-Path: <linux-kernel+bounces-744946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B058B112DA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9301891511
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996BB2E9EA6;
	Thu, 24 Jul 2025 21:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIHUfffS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BA9217F31;
	Thu, 24 Jul 2025 21:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753391489; cv=none; b=rfAqrarM43CoLiVnY8HGmq0vsllipvsYXU/P4+8+0ILU3LHHBrCpM2TfuReHW6qWqvvs+eHENseq7SNqezI/GYAqTkpMZVlYSMYTKR69J2GrKwHWdlxbrDWybzQFzW0mFvMi5mSdBHgzEhzNnGBqQVskAHSv065ZfBAhI06dJ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753391489; c=relaxed/simple;
	bh=FcG103BTDIRwcd06zh7pGj3Lo6KRz/c3RYa3jUnalm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BA/BwKQ0QVmYHdJO1c9DNrUxKBsK12x9hqvHBEzW0M7n6aI7w21D83MFVZ8hOfN3X3GEWKGtipO5WvNUYfL0xsjXJHrpVoG9XkeYJMzSwhG+9z3UjlbGYOD3+VIwBAUBOFBSRu70bmwm5lk4QYQxTcna1sJBCYD8I636D4PBieU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIHUfffS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4CAC4CEED;
	Thu, 24 Jul 2025 21:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753391488;
	bh=FcG103BTDIRwcd06zh7pGj3Lo6KRz/c3RYa3jUnalm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eIHUfffSFpfVhsn6XRx65By98JfdoAUdY2+BouZju7v/aUex4CSumVwnDH4c6jpJE
	 cysKnX8kzBv5ElkWh17v14zihdGntSyu/beSFCRhOMwgt45NdkUTx938++Wi5V6APC
	 fTnrSTAfIVbo537nEvGtZ/BESvUJEHrM0efEQACTIHH0q/Lo73iMmj2hQ/+njYrIN5
	 VkvejTZG4W9aJnT5JIgqLIse4PzNIQKFDcE+TqR9aKxEvsXNg7XZaA/+tKBRu/pGle
	 /UPvNUyib+xVvyjpdHnpwKHFDn3ZQByrzwzO1ShsqJAX7uEItoPlfioN4BEyCoGaiP
	 foUgYouTCj/lw==
Date: Thu, 24 Jul 2025 14:11:27 -0700
From: Drew Fustini <fustini@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, Yao Zi <ziyao@disroot.org>
Subject: Re: [GIT PULL] clk: thead: Updates for v6.17, part 2
Message-ID: <aIKhf41ky1gzdOIV@x1>
References: <aIKcFzsCvvz0PCBW@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIKcFzsCvvz0PCBW@x1>

On Thu, Jul 24, 2025 at 01:48:23PM -0700, Drew Fustini wrote:
> Hi Stephen,
> 
> I'm sending this followup PR in case there is still time to include it
> for your 6.17 PR. Yao Zi refactored mux clk registration which fixes an
> orphan mux clk issue which would occur when booting with mainline uboot.
[snip]
> Michal Wilczynski (1):
>       clk: thead: Mark essential bus clocks as CLK_IGNORE_UNUSED
> 
> Yao Zi (2):
>       clk: thead: th1520-ap: Correctly refer the parent of osc_12m
>       clk: thead: th1520-ap: Describe mux clocks with clk_mux
> 
>  drivers/clk/thead/clk-th1520-ap.c | 109 +++++++++++++++++---------------------
>  1 file changed, 48 insertions(+), 61 deletions(-)

My apologies, I failed to just send the delta between thead-clk-for-v6.17 and
thead-clk-for-v6.17-p2.

The following is the correct text of the pull request. Hopefull this is
acceptable?

Thanks,
Drew

--
The following changes since commit d274c77ffa202b70ad01d579f33b73b4de123375:

  clk: thead: th1520-ap: Correctly refer the parent of osc_12m (2025-07-13 12:46:58 -0700)

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
Yao Zi (1):
      clk: thead: th1520-ap: Describe mux clocks with clk_mux

 drivers/clk/thead/clk-th1520-ap.c | 95 +++++++++++++++------------------------
 1 file changed, 37 insertions(+), 58 deletions(-)


