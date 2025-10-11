Return-Path: <linux-kernel+bounces-849146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C00DBCF4AA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 13:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B1F764E4C9F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 11:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A6C24168D;
	Sat, 11 Oct 2025 11:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="F0PLnVq7"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9054594A
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 11:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760183193; cv=none; b=LDPRVlqgKoUsZ/Z382KusPPg32jmzdIqakGnHBJ1pQN68uW3EDNFUmBnmhj/zdTGEsdZzLUAwt9OSZ7UPs0pJZrDzRbPFpRQ2Dw7dv8Kmp4Zv7GhzlbsPe3TCbAf+XmEzn5p0007KRKkCfuzP1g4f6jdRjB5wcKKDQlQYC0hXXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760183193; c=relaxed/simple;
	bh=r/vOtY6JBxqJ2YzsBMDXYLm4gIHhHf3gmiTbCEnVxYs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rxJsqRa4Zg7ZjCTkbcFNSgj/FooGWknpTu0YbG27Exb5PWZARHSOd0L5or6bOgaVj5ZApxzRrR1Pn++BqivNaj6MugkSx3L99L+qTu81QKKBZpj13VMD7j3zG4EYdeWrSPhnZz0liuIiy8YPoGG+f1vyL4rtESMh6GNI3ZNhyw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=F0PLnVq7; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 36AD540E019B;
	Sat, 11 Oct 2025 11:46:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8px26liidPul; Sat, 11 Oct 2025 11:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760183173; bh=hIvomjW/q2nb5J7kLPgZAS5kaDG8IJZv6yQvNjc4AAM=;
	h=Date:From:To:Cc:Subject:From;
	b=F0PLnVq73LWOqKKNz5qjnUDTZVT4BWFU8xUrq+1GhZ32ZKwKwI9/cq7ZQ3Fri9Up7
	 CCPq8KsCo+RpJBzc1KWOk0S8JcpDXx92HOLJR9gbpqabKbf+EGIQlx62RkLTle1Lps
	 S8b6QiBCVnRGlGmRAfvmF7o0TnW63iz7/eL8Fr57/GOU/I7bHig+g01Qq6sir1m5EB
	 IiF7sjApBdRi74PnvJ0XfWd0dzmticHNI8kBoBvwj1CKwRSgOxIWH+Tl7BudW2ADgG
	 DHZ9NzwYIrR2br795BKYUizLjKJ5/GH0cIM3dhdtvjXQ6mXRdmpI2eZxrtV42SUkDv
	 jlQHhNZO8Xjysb13bckOL+vxHYkuMJPPlymaEcdwagVD1iVoniY0uW7SU1BKTKcxLK
	 Wd9nH2aIsN1EmuFAgzFhcRYmpN7FehWyr3KtCkT3KWZXvQCQFmISrat7FfPtsscf4Z
	 r9BVkuvaDNvOT5wj+eeiE3T9et2VOMwkH5b2o0z5m0LUiA28LQ3ZVdBBzL4LNNYwGS
	 tNVcclvsEa3oMgfIgd4L+1ffeObunMPzkY/EdsQCRoZ9khQLB9y4o1u+wqya8KwMX5
	 eow39hc4QJNUXt5ptQxrdSsYbc366lwebQ3pdsegsqI/DpAYviBTpR96eQiBEQdIQQ
	 fZW3RtLaCuZRdedweFRX7MMc=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 337E640E00DA;
	Sat, 11 Oct 2025 11:46:10 +0000 (UTC)
Date: Sat, 11 Oct 2025 13:46:09 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cleanups for v6.18-rc1
Message-ID: <20251011114609.GAaOpDgd6_shSYsg1s@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a belated x86/cleanups lineup for v6.18-rc1.

Thx.

---

The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9:

  Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_cleanups_for_v6.18_rc1

for you to fetch changes up to c6c973dbfa5e34b1572bcd1852adcad1b5d08fab:

  x86/asm: Remove code depending on __GCC_ASM_FLAG_OUTPUTS__ (2025-09-08 15:38:06 +0200)

----------------------------------------------------------------
- Simplify inline asm flag output operands now that the minimum compiler
  version supports the =@ccCOND syntax

- Remove a bunch of AS_* Kconfig symbols which detect assembler support for
  various instruction mnemonics now that the minimum assembler version
  supports them all

- The usual cleanups all over the place

----------------------------------------------------------------
Lukas Bulwahn (1):
      x86/kconfig: Drop unused and needless config X86_64_SMP

Thomas Huth (1):
      x86/mtrr: Remove license boilerplate text with bad FSF address

Uros Bizjak (8):
      crypto: x86 - Remove CONFIG_AS_GFNI
      crypto: X86 - Remove CONFIG_AS_VAES
      crypto: x86 - Remove CONFIG_AS_VPCLMULQDQ
      x86/kconfig: Remove CONFIG_AS_AVX512
      x86/idle: Use MONITORX and MWAITX mnemonics in <asm/mwait.h>
      x86/asm: Use RDPKRU and WRPKRU mnemonics in <asm/special_insns.h>
      x86/sgx: Use ENCLS mnemonic in <kernel/cpu/sgx/encls.h>
      x86/asm: Remove code depending on __GCC_ASM_FLAG_OUTPUTS__

Xin Li (Intel) (1):
      x86/entry/fred: Push __KERNEL_CS directly

 arch/x86/Kconfig                         |  4 ----
 arch/x86/Kconfig.assembler               | 20 --------------------
 arch/x86/boot/bitops.h                   |  2 +-
 arch/x86/boot/boot.h                     |  8 ++++----
 arch/x86/boot/string.c                   |  4 ++--
 arch/x86/crypto/Kconfig                  |  2 +-
 arch/x86/crypto/Makefile                 |  6 ++----
 arch/x86/crypto/aes-ctr-avx-x86_64.S     |  2 --
 arch/x86/crypto/aes-xts-avx-x86_64.S     |  2 --
 arch/x86/crypto/aesni-intel_glue.c       | 22 +++-------------------
 arch/x86/crypto/aria-aesni-avx-asm_64.S  | 10 ----------
 arch/x86/crypto/aria-aesni-avx2-asm_64.S | 10 +---------
 arch/x86/crypto/aria_aesni_avx2_glue.c   |  4 +---
 arch/x86/crypto/aria_aesni_avx_glue.c    |  4 +---
 arch/x86/entry/entry_64_fred.S           |  3 +--
 arch/x86/include/asm/archrandom.h        |  6 ++----
 arch/x86/include/asm/asm.h               | 12 ------------
 arch/x86/include/asm/bitops.h            | 18 ++++++------------
 arch/x86/include/asm/cmpxchg.h           | 12 ++++--------
 arch/x86/include/asm/cmpxchg_32.h        |  6 ++----
 arch/x86/include/asm/cmpxchg_64.h        |  3 +--
 arch/x86/include/asm/mtrr.h              | 15 +--------------
 arch/x86/include/asm/mwait.h             |  8 ++------
 arch/x86/include/asm/percpu.h            | 12 ++++--------
 arch/x86/include/asm/rmwcc.h             | 26 ++------------------------
 arch/x86/include/asm/sev.h               |  3 +--
 arch/x86/include/asm/signal.h            |  3 +--
 arch/x86/include/asm/special_insns.h     | 10 +++-------
 arch/x86/include/asm/uaccess.h           |  7 +++----
 arch/x86/kernel/cpu/mtrr/cleanup.c       | 15 +--------------
 arch/x86/kernel/cpu/mtrr/mtrr.c          | 15 +--------------
 arch/x86/kernel/cpu/sgx/encls.h          |  6 +++---
 tools/arch/x86/include/asm/asm.h         | 12 ------------
 tools/perf/bench/find-bit-bench.c        |  2 +-
 34 files changed, 55 insertions(+), 239 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

