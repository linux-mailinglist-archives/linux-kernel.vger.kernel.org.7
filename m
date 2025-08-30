Return-Path: <linux-kernel+bounces-792956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F3FB3CADC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 14:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8C225E03BF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 12:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F211D279DC4;
	Sat, 30 Aug 2025 12:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvHL3ojE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592A5238171
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 12:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756558556; cv=none; b=WNnnfiFXBIvo8fv4dp652Eh6LJmqNdm1oYkqODxEAY3k8KqOXxyYLb3871WVcu/rGILgGtQSSPfyB4wK1E1MOysd7SGC9hiWXVkopVanrriiOALoEX4xcyWonmXpPH5tcZxDzrlWl+TKgjm9Mb6AcQd7zu8B3tMxde4RnQwqRpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756558556; c=relaxed/simple;
	bh=uP51najkfs7vJzJ0QsafPgpRZW4SWTRyZVZeQrPAzpI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nFNQcy6zi6dRcICp1XkCAXoqRPh8D5BiHXGXMs0hJjim2almJN+ESW43w+2OC/XvV10g8mzbINY+t2A6aS0eBLt5RALRUTUrInJL3II5wk00yzllv+ewOm/V0/LpOqgsbVMOLyWb2XRWHll4/zsX+CQymrsiJGgIZ+vQpjSFW64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvHL3ojE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F249CC4CEF4;
	Sat, 30 Aug 2025 12:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756558555;
	bh=uP51najkfs7vJzJ0QsafPgpRZW4SWTRyZVZeQrPAzpI=;
	h=Date:From:To:Cc:Subject:From;
	b=RvHL3ojEBrITnNcKWqBd0DYDCz2MusIAQLkyW9AtSu4sBqU2fFhXxXxnciv3AIn0j
	 mDHaGvOtCCsiSuESXkzPhr7TDvfSE0+3yJVgSKINaZ/RVLQE0700eRM++x4K3pzPlh
	 koyMwhtklcFaEtYH9hUvzVicuaq5NJW1EZ2QqnnlB1g5xnhwcFQ4xLOUEgYspFs/iP
	 BDX2kNzC8VHOoHSeJKX9id6SSrI9LB/pqVubSTb3vGhmQWslcqQbCpFfyzmfegJ8vB
	 HB8QJlbMkxD9PggzNdrRiM25uWHrSjaF/g9OeJH3TX9UuK6TJmq32ngeBYOeu28Cr8
	 NQMGgSU+ixpqQ==
Date: Sat, 30 Aug 2025 13:55:52 +0100
From: Catalin Marinas <cmarinas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 6.17-rc4
Message-ID: <aLL02Fi-gazNRa1G@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull a couple of small arm64 fixes below (for -rc4 if there's
still time, otherwise -rc5 is fine as well). Thanks.

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to d82aa5d3501b25bfb7bc2a24a68ad0a83b2ad10b:

  kselftest/arm64: Don't open code SVE_PT_SIZE() in fp-ptrace (2025-08-30 11:31:11 +0100)

----------------------------------------------------------------
Two arm64 fixes:

- CFI failure due to kpti_ng_pgd_alloc() signature mismatch

- Underallocation bug in the SVE ptrace kselftest

----------------------------------------------------------------
Kees Cook (1):
      arm64: mm: Fix CFI failure due to kpti_ng_pgd_alloc function signature

Mark Brown (1):
      kselftest/arm64: Don't open code SVE_PT_SIZE() in fp-ptrace

 arch/arm64/include/asm/mmu.h                 | 7 +++++++
 arch/arm64/kernel/cpufeature.c               | 5 +++--
 arch/arm64/mm/mmu.c                          | 7 -------
 tools/testing/selftests/arm64/fp/fp-ptrace.c | 5 ++---
 4 files changed, 12 insertions(+), 12 deletions(-)

-- 
Catalin

