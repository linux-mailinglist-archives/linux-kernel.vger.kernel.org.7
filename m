Return-Path: <linux-kernel+bounces-727923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F56B0217F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA981886E80
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807F82E92A2;
	Fri, 11 Jul 2025 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiF+dqKP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C463C30
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250662; cv=none; b=fusSKeXzWuCRm1L0Du5yL6B6V54iqZp+uGvmKQKhapAam/is3UVTYRtFQmEXFp8g/XhTaBghat5ghngYcFrmxxdslUK2StsrROpTmGEXvMbTMdawT+sdIUMRLFioHjI1mEASAxwnGYrlckqqVqgGohvD2N4ml8JNEtG4nsVoLoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250662; c=relaxed/simple;
	bh=ssqviJJdlPK7ukKCK3lJrf33765uDPISKy8fhWLffIw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pwB5mi4MDz6nrEz8p6cv31FJp5EyQDNLktMfAWvswatl4XBKN2SrPnvEruGfy6muKGczuCF1aUcwGoIg1PhoHt8+aL+BivCMdkpsz2JQcT377pkWP9oY7L6T77HMHfHGJhHDRjw0Xdf4i0rRiashGYbav9lLoaBr/RUpAS0CLO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiF+dqKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6951AC4CEF5;
	Fri, 11 Jul 2025 16:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752250661;
	bh=ssqviJJdlPK7ukKCK3lJrf33765uDPISKy8fhWLffIw=;
	h=From:To:Cc:Subject:Date:From;
	b=eiF+dqKP7uTJo85RpjhX5/oQPZga4hD5I7fma2cgcqbTU0HxJoqoYrnxfHkOC94PZ
	 Gk4Ani1QThRE2Rgj/TLMVJxEfFlPA7Sp4bjSAaMe5dEcj03BleXV+O9q7/xnsYKN+N
	 Zs3U8Cih95EC7L0OizuMgW8goCQsfRmYKtHygnmaPF/wA9EP490zZbHYhqyQDUxcrZ
	 hMq9A6WbI87ilE6wgzPSxfgYe1dXQkOfb8gClSst0/W2drrfpxVBeA1p9B68MgMJlU
	 HQuoILHlbR9fYGwgwsxR/yvh99YzalWIgylv1r8nRkTu/B8sq6fAkPwtrbbAvHHg2G
	 xyBICNRWmEgVw==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH 00/10] arm64: Replace TLB invalidation preprocessor macros with C functions
Date: Fri, 11 Jul 2025 17:17:22 +0100
Message-Id: <20250711161732.384-1-will@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

I cooked this series following a complaint from Linus back in March
about our range-based TLB invalidation macro after we fixed an
over-invalidation bug thanks to incorrect handling of its arguments:

  https://lore.kernel.org/all/CAHk-=wgiX0q0WCL+SFwVCYtG7JR3=2Rshse-5J3AO2Y4AgT7Jw@mail.gmail.com/

Once I started trying to rework the range macro into a C function, I
spotted a few other opportunities for cleanup and so I've ended up with
this series.

Testing and feedback welcome.

Cheers,

Will

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>

--->8

Will Deacon (10):
  arm64: mm: Introduce a C wrapper for by-level TLB invalidation helpers
  arm64: mm: Introduce a C wrapper for by-range TLB invalidation helpers
  arm64: mm: Implicitly invalidate user ASID based on TLBI operation
  arm64: mm: Remove unused 'tlbi_user' argument from
    __flush_tlb_range_op()
  arm64: mm: Re-implement the __tlbi_level macro in C
  arm64: mm: Simplify __TLBI_RANGE_NUM() macro
  arm64: mm: Push __TLBI_VADDR() into __tlbi_level()
  arm64: mm: Inline __TLBI_VADDR_RANGE() into __tlbi_range()
  arm64: mm: Simplify __flush_tlb_range_limit_excess()
  arm64: mm: Re-implement the __flush_tlb_range_op macro in C

 arch/arm64/include/asm/tlbflush.h | 230 ++++++++++++++++++------------
 arch/arm64/kernel/sys_compat.c    |   2 +-
 arch/arm64/kvm/hyp/nvhe/mm.c      |   2 +-
 arch/arm64/kvm/hyp/pgtable.c      |   4 +-
 4 files changed, 140 insertions(+), 98 deletions(-)

-- 
2.50.0.727.gbf7dc18ff4-goog


