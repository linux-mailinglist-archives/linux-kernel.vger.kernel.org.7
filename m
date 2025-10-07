Return-Path: <linux-kernel+bounces-844445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FADBC1EF3
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 17:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009813B50AF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 15:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBA62E2659;
	Tue,  7 Oct 2025 15:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcgv92Z8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DB72E1F11
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759851066; cv=none; b=j84mQvnvN5D5h3Qm5hpdtuZJyw8b/rqz3zHVJwZfqOrPMdEneDMks7lWO+I9DxJmEX8TLWMrohfdrHeEP30K4XexDQR7KWn2xrWQIInsN258NH4GJwiIE5k6OYI+UtQODMRiuA3NUiCBHNnDfhmRhdVFE8Rpwn+6qS6lg7sEScA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759851066; c=relaxed/simple;
	bh=XH9KCZTjVAtd4n7o//WUhBX2MUokT9AxCyaNBf/tMuI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mSI0SM4TOglF24T9U5Wta8j+OkxxtyN+5vFpXLRlBbf982YdGb+rb4i4YqfPCvlmVXfJs6+1Cjaka9yPtLPNzbOv98Wn2DzJwMSA/YoCpERZIrD+i8QILWbeqaJsIoG+Bc7062J4f68LzVTzk6MPI/9hzV3FYQbwea8Mdrwq8ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcgv92Z8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA728C4CEF1;
	Tue,  7 Oct 2025 15:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759851065;
	bh=XH9KCZTjVAtd4n7o//WUhBX2MUokT9AxCyaNBf/tMuI=;
	h=Date:From:To:Cc:Subject:From;
	b=bcgv92Z8dVJTgPcAfMSvj1k7VOU7yfz6TXPNT9v4zACkwq4Bkr+EZ63G2w69E3pkk
	 BjWYH818XjempbIoAaKH7YnLQyRU5Kslrn9punrxyOEVluuE6wgbx5rCPPXHkOyh5t
	 +ZvTDJqas/ppQ9QbImXvYRMFQ8WTyvtTxzTrHitnnXcfu+xDhSvMubZ+LHj3wtsmuO
	 M50GJLLL6LJjnuMo+hESu8yHWd+LZaJKV/d6QABr6TTg/DZblkAG+ZFP0yY6PxQWqY
	 1uX4frhpepgv2nB/wyECTg9UyAr9EREN85UN3dzG/uzUzxuPp4Khv48/L/5NsO9TKQ
	 1ctTTp9xZpBRQ==
Date: Tue, 7 Oct 2025 08:31:05 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Carlos Llamas <cmllamas@google.com>,
	Kees Cook <kees@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Vegard Nossum <vegard.nossum@oracle.com>
Subject: [GIT PULL] hardening fixes for v6.18-rc1
Message-ID: <202510070829.3F80E18@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these two hardening fixes for v6.18-rc1. After this, I'm
expecting 1 more CONFIG_CFI_CLANG -> CONFIG_CFI "passing in the night"
fix once the x86/core PR lands:
https://lore.kernel.org/lkml/20251003221030.GA1162775@ax162/

Thanks!

-Kees

The following changes since commit fd94619c43360eb44d28bd3ef326a4f85c600a07:

  Merge tag 'zonefs-6.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs (2025-10-05 20:45:49 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-fix1-v6.18-rc1

for you to fetch changes up to b157dd228cf0ee24b2414712abd82bd3a8d5b009:

  tools headers: kcfi: rename missed CONFIG_CFI_CLANG (2025-10-07 08:21:33 -0700)

----------------------------------------------------------------
hardening fixes for v6.18-rc1

- tools headers: rename missed CONFIG_CFI_CLANG in merge (Carlos Llamas)

- kconfig: Avoid prompting for transitional symbols

----------------------------------------------------------------
Carlos Llamas (1):
      tools headers: kcfi: rename missed CONFIG_CFI_CLANG

Kees Cook (1):
      kconfig: Avoid prompting for transitional symbols

 scripts/kconfig/symbol.c                           | 15 +++++++++-
 scripts/kconfig/tests/transitional/Kconfig         | 32 ++++++++++++++++++++++
 scripts/kconfig/tests/transitional/expected_config |  3 ++
 scripts/kconfig/tests/transitional/initial_config  |  4 +++
 scripts/kconfig/tests/transitional/__init__.py     |  7 +++++
 scripts/kconfig/tests/transitional/expected_stdout |  1 +
 tools/include/linux/cfi_types.h                    |  2 +-
 7 files changed, 62 insertions(+), 2 deletions(-)
 create mode 100644 scripts/kconfig/tests/transitional/expected_stdout

-- 
Kees Cook

