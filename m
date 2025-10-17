Return-Path: <linux-kernel+bounces-858791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93051BEBD87
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 23:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E6E24F3254
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 21:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B432D3A60;
	Fri, 17 Oct 2025 21:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+WSwXh7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E28A354AEE
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 21:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760737710; cv=none; b=mODQbSq4TyJ0gelWz7AZRPizYx5ary3MUDnEOeYDKsyJNhGVR/0hltG03Kdiy49PTmNgTrgSGINjWeUZCrz0OZSDOeAoyJLDqjW8c3hU7uj6JKb3/VfjV7TjLKHB3wFiR2F9Wl22fOgJ/izmypcs0rPrPfzjtWqEMCqXA9Hw2Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760737710; c=relaxed/simple;
	bh=xd1yFjt8Ov/S9tkR1UjGKlrmvIPjVzyg2KlyTqOt86g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EtFEE9BB5feEIOZQpQ7VklUjQqnygquiY1GT/U9jvaPzumKp5gkCDzGg7WzEiMcHFHS+EH+W2BDL/VecXnM/tsJL6IH/g2UmL1V+MvE53vahS8nY5xFlYFdJKdRJE6Ux5ztpI5DsXyBN+HcClsx1j7EPyvOO8Mib3KGmWN2cfhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+WSwXh7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16432C4CEE7;
	Fri, 17 Oct 2025 21:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760737710;
	bh=xd1yFjt8Ov/S9tkR1UjGKlrmvIPjVzyg2KlyTqOt86g=;
	h=Date:From:To:Cc:Subject:From;
	b=j+WSwXh7xicyFQNvSwq+ywq5v4TQoFCf+V49qgiP8FnWrnJYgruFMflp0SQ9/hiX4
	 EmYol1SE0o/VgCGV6y7aCVXY1p9W+2Sh6JDlQCAFfsZ1LxjnX2jITnkHi3JHn5pCaa
	 DB7Px62p75PICjOyWnAGpyaUm880l0AWZhTQS5qu8+H2Z8x3gFN3KhJ78h+RMoebqi
	 +S0H+E0/4+vtIHWMnC9W+beVV8x7Cf8wM33YmNyCY7HnPIHEv/tUs0UyknulYpw7Lw
	 b5+Z0XAzSCASaJZdwb1QyyJA+bzP1IJLUBd9FxIQE8P/lFL0n8AE1gIRSPKJ4Z++b2
	 qC9sJmNjseH3A==
Date: Fri, 17 Oct 2025 22:48:26 +0100
From: Catalin Marinas <cmarinas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 6.18-rc2
Message-ID: <aPK5qkFphJvpJBkJ@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull a couple of arm64 fixes below. Normally it's Will handling
the fixes this time around but he's fishing on some remote lake away
from the modern world (and internet connection). Thanks.

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to ea0d55ae4b3207c33691a73da3443b1fd379f1d2:

  arm64: debug: always unmask interrupts in el0_softstp() (2025-10-17 18:08:05 +0100)

----------------------------------------------------------------
arm64 fixes:

 - Explicitly encode the XZR register if the value passed to
   write_sysreg_s() is 0. The GIC CDEOI instruction is encoded as a
   system register write with XZR as the source register. However, clang
   does not honour the "Z" register constraint, leading to incorrect
   code generation

 - Ensure the interrupts (DAIF.IF) are unmasked when completing
   single-step of a suspended breakpoint before calling
   exit_to_user_mode(). With pseudo-NMIs, interrupts are (additionally)
   masked at the PMR_EL1 register, handled by local_irq_*()

----------------------------------------------------------------
Ada Couprie Diaz (1):
      arm64: debug: always unmask interrupts in el0_softstp()

Lorenzo Pieralisi (1):
      arm64/sysreg: Fix GIC CDEOI instruction encoding

 arch/arm64/include/asm/sysreg.h  | 11 ++++++++++-
 arch/arm64/kernel/entry-common.c |  8 +++++---
 2 files changed, 15 insertions(+), 4 deletions(-)

-- 
Catalin

