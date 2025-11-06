Return-Path: <linux-kernel+bounces-889323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD49C3D485
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 20:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B72C03AABA5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 19:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7757333C52F;
	Thu,  6 Nov 2025 19:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ingrHSmF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D523A335579
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 19:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762458780; cv=none; b=FzW12uKr4KJXtbWMmSDkXp4PSIQ7SoCLkwHuidV1XH5Uq2HQOnbPsHEWo8cbKdP1J+TzwIZDhHcEXbz3g6UEWOBJJwRgrA70asjdOVI0TSLRXmDC08DmXQpx8KQfnP8UBgSyC2lX82xJEoElmQSXC524OlmNUS3kwvzeyhPx/0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762458780; c=relaxed/simple;
	bh=LEc3qfdVdjVz9IyqB3XMgs/uQh5RA+S5fjbzAhxa+jk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GnRpd4h2FDzilgqFU+tgf9YGs+w8JdctW/JAuerYK9ot6pAvsYN/OF9PTS4gYCiQTWTPU2m7PPRHCwseBTNaXDplAjqfzAI9kDy52jXk5WiFv/zp1GJDFoAvTPlRV1PuIFWAxuBfjfJFfAfEf+68x2wz83ZD2AVJaQOoG2UB+pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ingrHSmF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FFB1C4CEFB;
	Thu,  6 Nov 2025 19:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762458779;
	bh=LEc3qfdVdjVz9IyqB3XMgs/uQh5RA+S5fjbzAhxa+jk=;
	h=Date:From:To:Cc:Subject:From;
	b=ingrHSmFCfnLGCJI0m+JfxoEglCoxY386305dk7k6tCkI5LfpEbQ1I1JzOESTs7Ba
	 4Ql+Kpt/V+k1E11LRsGb8Ov2TEN/5CrmkjEO3vrudmSqzu1rLAPbykdj9JvxuPSVLp
	 fe8RkM0mFGzgav9C1Ni71KXI4jtRLeRvrhsYbbzBrGgqfARJjxwSO+5+UOznBXdAcn
	 tZmfy/h9a1v3X3yiMUekn25paF+xUpCEVNR5iJMBM6G1h7Ree18PaaDhAMa8CExGcY
	 ZrWjMNqbEHQ42E/spaBVPgAdBg6NKhLF5lQ6quBAoiyOUIGZKqWLwRfIUO6GNwXdTk
	 WlZJhpW3vWG3g==
Date: Thu, 6 Nov 2025 11:52:58 -0800
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Subject: [GIT PULL] hardening fixes for v6.18-rc5
Message-ID: <202511061151.CB031555D@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these hardening fixes for v6.18-rc5. This is a work-around
for a (now fixed) corner case in the arm32 build with Clang KCFI
enabled.

Thanks!

-Kees

The following changes since commit 211ddde0823f1442e4ad052a2f30f050145ccada:

  Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.18-rc5

for you to fetch changes up to c57f5fee54dfc83ee1d7f70f7beb9410b8466e9e:

  libeth: xdp: Disable generic kCFI pass for libeth_xdp_tx_xmit_bulk() (2025-10-29 20:04:55 -0700)

----------------------------------------------------------------
hardening fixes for v6.18-rc5

- Introduce __nocfi_generic for arm32 Clang (Nathan Chancellor)

----------------------------------------------------------------
Nathan Chancellor (3):
      compiler_types: Introduce __nocfi_generic
      ARM: Select ARCH_USES_CFI_GENERIC_LLVM_PASS
      libeth: xdp: Disable generic kCFI pass for libeth_xdp_tx_xmit_bulk()

 arch/Kconfig                   | 7 +++++++
 arch/arm/Kconfig               | 2 ++
 include/linux/compiler_types.h | 6 ++++++
 include/net/libeth/xdp.h       | 2 +-
 4 files changed, 16 insertions(+), 1 deletion(-)

-- 
Kees Cook

