Return-Path: <linux-kernel+bounces-867523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 669DBC02D42
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C57434FAC65
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57EC34E750;
	Thu, 23 Oct 2025 18:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNRRfqE9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DDA348447
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761242409; cv=none; b=D0Vvx4TbPdh3WohQGVHPwzR3QiNx6XwuYypfFqZ2tYM5XZRpSAg/ZLV69XmhX3FFjEFd0BgbGVtbsAzTFwMm5FbP7q/j2WQgLg8/9EObxSGcdxI3ESFgib+Dtr+yFGr2aFM7SZ1S7m1rSESb+AgmT0VL2v+yrwuXB8mvQJdFr3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761242409; c=relaxed/simple;
	bh=84VtKb1TSjLg18NIXnUM3uCUfAjfiOvjdEwx7+IUEhI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Lk04GhYQ+dZbBaPFNG7+tZSruV6x3VR+C6JS8vst1hYHTsc6GqDK5Cg/3RcJkk5DF1dqZsRLF7QSap107UNDAJAs+QctzV6XB6sJ3OHmPs73gymWGyLMxlaeqoOgdU/4c0Yb6LxTJYwoccnet97OOkaNicRXu3ERFO4YuxPf5rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNRRfqE9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B45C4CEE7;
	Thu, 23 Oct 2025 18:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761242408;
	bh=84VtKb1TSjLg18NIXnUM3uCUfAjfiOvjdEwx7+IUEhI=;
	h=Date:From:To:Cc:Subject:From;
	b=pNRRfqE9vZF6Zkqdh0sTtu/EUHt/te9QKnVz3VxV1Bjs+ZiDIDB3GO0hydkJsTelo
	 j7q+FMh/I119oGHgfYTKQWk1dvSzCWR85sMZ9LR9oisivHyR0+UC7Pn/oNrgdCOrt8
	 i3INCeoLdW+QdogcD50zZfXxbLjfIgSsYt9VZIDsvSAt2WekG4GJluBqGpj1q0tKff
	 J8yi6KPrI0ybss3bqadR3aA/O5Z2P+TVnb3kdSVU+hO1mITVxnRGRXJ3Wv+a8mVxRj
	 Fq1U7LlNI3nH9Hh7ENHw1JD8jL2fZCAcR9v81t5+em4CoRYOc83HBVWPUbR4yv+ZOg
	 EAfZBJd2lwRrg==
Date: Thu, 23 Oct 2025 19:00:05 +0100
From: Catalin Marinas <cmarinas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 6.18-rc3
Message-ID: <aPptJe8qXOGO-lGt@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit ea0d55ae4b3207c33691a73da3443b1fd379f1d2:

  arm64: debug: always unmask interrupts in el0_softstp() (2025-10-17 18:08:05 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to b98c94eed4a975e0c80b7e90a649a46967376f58:

  arm64: mte: Do not warn if the page is already tagged in copy_highpage() (2025-10-23 17:34:58 +0100)

----------------------------------------------------------------
arm64 fixes:

 - Do not make a clean PTE dirty in pte_mkwrite()

   The Arm architecture, for backwards compatibility reasons (ARMv8.0
   before in-hardware dirty bit management - DBM), uses the PTE_RDONLY
   bit to mean !dirty while the PTE_WRITE bit means DBM enabled. The
   arm64 pte_mkwrite() simply clears the PTE_RDONLY bit and this
   inadvertently makes the PTE pte_hw_dirty(). Most places making a PTE
   writable also invoke pte_mkdirty() but do_swap_page() does not and we
   end up with dirty, freshly swapped in, writeable pages.

 - Do not warn if the destination page is already MTE-tagged in
   copy_highpage()

   In the majority of the cases, a destination page copied into is
   freshly allocated without the PG_mte_tagged flag set. However, the
   folio migration may be restarted if __folio_migrate_mapping() failed,
   triggering the benign WARN_ON_ONCE().

----------------------------------------------------------------
Catalin Marinas (1):
      arm64: mte: Do not warn if the page is already tagged in copy_highpage()

Huang Ying (1):
      arm64, mm: avoid always making PTE dirty in pte_mkwrite()

 arch/arm64/include/asm/pgtable.h |  3 ++-
 arch/arm64/mm/copypage.c         | 11 ++++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

-- 
Catalin

