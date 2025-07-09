Return-Path: <linux-kernel+bounces-723976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75CDAFED4C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7971D5A48DF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4102E5B21;
	Wed,  9 Jul 2025 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+EkCEXW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E5C2D1914
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073733; cv=none; b=E7sDL5jXfUk76V4wkVhLoH9m7h5Je6eCsH/+IW03yxdrtxRNHeT+9j3nBnmWORThvS4+PIo/qPS76SPUylESH76HNIFC37bCixwtw1FjjME0yamloVo98NkMg0Rl3AkQEOtP/JPbwkR5mIs+hcfpHLFW3nrE+a2exVJIu2dlQa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073733; c=relaxed/simple;
	bh=aOlbZkcI7oF3SOFwCQeZdFEAK3mOIpqRgWAeM2Pwt3w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=a8a90yAbmwOTtmWhRq5RPM6ho/VLZlp73GTot49MU6rXl34/YIui5fZCz1FfSCn+GTzRoB/CdjP1jsCvfLpwYx6AiQtTRMzQDF8Z+pnmncnEU9HmjRK2cL/i7U9YzcNyYDBoCRQ7fSrxhkJ1D4pK0FvPGh/wnlijLTdoB0kM0ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+EkCEXW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC08C4CEEF;
	Wed,  9 Jul 2025 15:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752073733;
	bh=aOlbZkcI7oF3SOFwCQeZdFEAK3mOIpqRgWAeM2Pwt3w=;
	h=Date:From:To:Cc:Subject:From;
	b=h+EkCEXW/Wib9SN4ISibuhk+/zMJh+JOmyHCKL+Oiy7izNmKXIcIJra7EA8P1hVBL
	 IeAOCgavQHrySGhQmnUIWNY7ghn+GXwzqyy4eB/yy0ZUnRXZl161quP/6scunZC0O7
	 WHfvEC2Gwqd9oM/ffORMUB/aEoVw4N42Ox/FVETTtsIY2KKruLbn0r2t2SajfnsMF9
	 okc/s9eTYBf8gzvFC2XY0J/+97Wu1K6SDkOAHHxdj5jhYMq+QejJYm1wW3JR/GLRPC
	 CqNmqjN0+GX2aR1ItathXL8WJBq0k1zjbEAcrKPGs9gS49VNwhoQVqWQqDVJJmkHVc
	 voI3zkp0gP7Sg==
Date: Wed, 9 Jul 2025 16:08:48 +0100
From: Will Deacon <will@kernel.org>
To: torvalds@linux-foundation.org
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc6
Message-ID: <aG6GAKc8EV0cERsn@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these arm64 fixes for -rc6. We've had a steady trickle of
relatively minor fixes since -rc3 but they're all self-contained 6.16
material and confined to the arch code.

There's the usual summary in the tag.

Cheers,

Will

--->8

The following changes since commit 39dfc971e42d886e7df01371cd1bef505076d84c:

  arm64/ptrace: Fix stack-out-of-bounds read in regs_get_kernel_stack_nth() (2025-06-12 17:28:18 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 9dd1757493416310a5e71146a08bc228869f8dae:

  arm64/mm: Drop wrong writes into TCR2_EL1 (2025-07-04 16:46:04 +0100)

----------------------------------------------------------------
arm64 fixes for -rc6

- Fix bogus KASAN splat on EFI runtime stack

- Select JUMP_LABEL unconditionally to avoid boot failure with pKVM
  and the legacy implementation of static keys

- Avoid touching GCS registers when 'arm64.nogcs' has been passed on the
  command-line

- Move a 'cpumask_t' off the stack in smp_send_stop()

- Don't advertise SME-related hwcaps to userspace when ID_AA64PFR1_EL1
  indicates that SME is not implemented

- Always check the VMA when handling an Overlay fault

- Avoid corrupting TCR2_EL1 during boot

----------------------------------------------------------------
Anshuman Khandual (1):
      arm64/mm: Drop wrong writes into TCR2_EL1

Arnd Bergmann (1):
      arm64: move smp_send_stop() cpu mask off stack

Breno Leitao (1):
      arm64: efi: Fix KASAN false positive for EFI runtime stack

Kevin Brodsky (1):
      arm64: poe: Handle spurious Overlay faults

Marc Zyngier (1):
      arm64: Unconditionally select CONFIG_JUMP_LABEL

Mark Brown (2):
      arm64/gcs: Don't try to access GCS registers if arm64.nogcs is enabled
      arm64: Filter out SME hwcaps when FEAT_SME isn't implemented

 arch/arm64/Kconfig                 |  1 +
 arch/arm64/include/asm/el2_setup.h | 19 +++++--------
 arch/arm64/kernel/Makefile         |  3 +-
 arch/arm64/kernel/cpufeature.c     | 57 +++++++++++++++++++++-----------------
 arch/arm64/kernel/efi.c            | 11 ++++++--
 arch/arm64/kernel/process.c        |  5 ++++
 arch/arm64/kernel/smp.c            |  2 +-
 arch/arm64/mm/fault.c              | 30 ++++++++++++++------
 arch/arm64/mm/proc.S               |  1 -
 9 files changed, 76 insertions(+), 53 deletions(-)

