Return-Path: <linux-kernel+bounces-824783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D4AB8A24E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12D231896863
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2309F315D32;
	Fri, 19 Sep 2025 14:58:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9133C3148DA
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293924; cv=none; b=ElUleGHLqIjJxOOHDOUsC9gYVFC8r7UrsfXN4m9GYHxGDlh5MirIdziQDqc83aTtZMGxLz5Kx+lGw4qUsXACHpwjf+38BWMOgvg1iD4/MT/NrPCWl7hA3fmeZ1nISTORXQM4ApZ2I+rxRTm8xAo6crTnDfKTVrqqNktYodiIeO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293924; c=relaxed/simple;
	bh=vA6XcEti6DqfDUZWTc5KMAOfeNvRfQno9KMQQvtrQVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GKBWssawEi1H6kRibRw9XvF0UBjOiupn0eTaFv/geoU5naLnl3F+kVCKN62kqBt7mqsRYpcPBS3ak77jFrDwM1vW1aB0aqsW9939dk5SU41kawDxD4xHnygWDLGoJDM/5457Y2g/ZZMzyA3368lIH+vWDAiPJvuzIQfDe7D1icc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCE9C169C;
	Fri, 19 Sep 2025 07:58:33 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F00DA3F673;
	Fri, 19 Sep 2025 07:58:40 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	James Morse <james.morse@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] Workarounds and optimizations for Neoverse-V3AE
Date: Fri, 19 Sep 2025 15:58:27 +0100
Message-ID: <20250919145832.4035534-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

I know it's late in the cycle, but I thought I'd try my luck at sneaking this
in.

Neoverse-V3AE has a different MIDR value to Neoverse-V3, but qualifies for the
same workarounds and optimizations ("SSBS not fully self-synchronizing" and
BBML2_NOABORT) so this just adds Neoverse-V3AE wherever Neoverse-V3 appears.
Details in the commits.

The last patch adds Neoverse-3VAE to the BBML2_NOABORT allow list. That will
conflict with the patch you have already queued to add AmpereOne, and with the
patch you said you would do to remove X4. But this is a one-liner so trivial to
resolve.

Applies on v6.17-rc5.

Thanks,
Ryan


Mark Rutland (2):
  arm64: cputype: Add Neoverse-V3AE definitions
  arm64: errata: Apply workarounds for Neoverse-V3AE

Ryan Roberts (1):
  arm64: cpufeature: add Neoverse-V3AE to BBML2 allow list

 Documentation/arch/arm64/silicon-errata.rst | 2 ++
 arch/arm64/Kconfig                          | 1 +
 arch/arm64/include/asm/cputype.h            | 2 ++
 arch/arm64/kernel/cpu_errata.c              | 1 +
 arch/arm64/kernel/cpufeature.c              | 1 +
 5 files changed, 7 insertions(+)

--
2.43.0


