Return-Path: <linux-kernel+bounces-843935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2970BC0A06
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 10:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B15188955D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 08:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE9A2D3A7B;
	Tue,  7 Oct 2025 08:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6kWQCzM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1DB2D29C8
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759825704; cv=none; b=hgAp3xze8TWCRyI2QzMv0ZNggaX3qqMUHKTYSm+80vZ+CvRmsv1mx5HgfeVbpNg02jRGtzhbS6xH8z/L4oC3k0QMJ9f8dGyQBpjDPoDFx7qb8Ajx6/b/vqVUKu8MGbgKkv5dqnElg3isPMn9qZtxNUptvHMEnVVBcjx58c3PrVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759825704; c=relaxed/simple;
	bh=dZrWSKDVJTUF8PZreRMgpH0Ay9pg+KwWgz8bJzg8JDo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Asqg6wTIlsv2tJ2T7ZKYv9xyOw+qjJuSJS18U38r0lfw5b8n1pVlOHNWUAy2Gy+doOnD6wzvtY+4rbCDhFN1r08qbVOkLtWgtPXWcttXSkT9nctz92JJot3V4yTGwJNxGDyACqJGSamKN4dhv7ED8KrKc8XUF7KdrBBgodfuNpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6kWQCzM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBCAC4CEF7;
	Tue,  7 Oct 2025 08:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759825703;
	bh=dZrWSKDVJTUF8PZreRMgpH0Ay9pg+KwWgz8bJzg8JDo=;
	h=Date:From:To:Cc:Subject:From;
	b=B6kWQCzMPODkdoH2WlQgK6Bo4vtW6CgLSB8KXpdluYGPIu8kKPzCDG0jNAf+Boe55
	 Ebs7vqyYdQu8aFqB86dknrLtEVwBOwI1RIMwIkYRxK7y6vd3G/3Bdn/55sqmHROUSE
	 U4XEUJ64mTrDMPvVYSSR3R02bWkeXIRXjDr6eiMGdpBDvq6THr5Y0k283VL/uyc5Nq
	 Ur/LkH5KM73NjjaNdD4COabHgn/t7dNIXhtU1icv/KYSEOalTsdPnBfgeLrDOzfxke
	 pM497brksJjQcBXwp7AFX0RclM2g+ePz81/LqmriniFegE+RIgyp5a8KiBbvIVhLvB
	 QQy8QB2ym0NEg==
Date: Tue, 7 Oct 2025 09:28:18 +0100
From: Will Deacon <will@kernel.org>
To: torvalds@linux-foundation.org
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc1
Message-ID: <aOTPIiF3aO-YroaE@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these arm64 fixes for -rc1 that address issues either found
or introduced during this merge window. The only one that isn't strictly
a fix is the kpti cleanup, as I ended up queuing it late due to some
inter-branch dependencies and wanted to give it some more time in -next.

Summary in the tag.

Cheers,

Will

--->8

The following changes since commit ea0b39168d3a2313eabd145fb3440c946ccff4d1:

  arm64: cpufeature: Remove duplicate asm/mmu.h header (2025-09-24 16:44:44 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to f620d66af3165838bfa845dcf9f5f9b4089bf508:

  arm64: mte: Do not flag the zero page as PG_mte_tagged (2025-10-03 15:27:34 +0100)

----------------------------------------------------------------
arm64 fixes for -rc1

- Preserve old 'tt_core' UAPI for Hisilicon L3C PMU driver.

- Ensure linear alias of kprobes instruction page is not writable.

- Fix kernel stack unwinding from BPF.

- Fix build warnings from the Fujitsu uncore PMU documentation.

- Fix hang with deferred 'struct page' initialisation and MTE.

- Consolidate KPTI page-table re-writing code.

----------------------------------------------------------------
Catalin Marinas (1):
      arm64: mte: Do not flag the zero page as PG_mte_tagged

Feng Yang (1):
      tracing: Fix the bug where bpf_get_stackid returns -EFAULT on the ARM64

Gopi Krishna Menon (1):
      docs: perf: Fujitsu: Fix htmldocs build warnings and errors

Kevin Brodsky (1):
      arm64: mm: Move KPTI helpers to mmu.c

Yang Shi (1):
      arm64: kprobes: call set_memory_rox() for kprobe page

Yicong Yang (1):
      drivers/perf: hisi: Add tt_core_deprecated for compatibility

 .../admin-guide/perf/fujitsu_uncore_pmu.rst        |   7 +-
 Documentation/admin-guide/perf/hisi-pmu.rst        |   4 +
 arch/arm64/include/asm/ftrace.h                    |   1 +
 arch/arm64/include/asm/mmu.h                       |   7 +-
 arch/arm64/kernel/cpufeature.c                     | 108 ++-------------------
 arch/arm64/kernel/mte.c                            |   2 +-
 arch/arm64/kernel/probes/kprobes.c                 |  12 +++
 arch/arm64/mm/mmu.c                                |  98 +++++++++++++++++--
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c       |  33 ++++++-
 9 files changed, 154 insertions(+), 118 deletions(-)

