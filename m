Return-Path: <linux-kernel+bounces-859718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A33BEE66D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 16:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43AB33B2982
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 14:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780592E9741;
	Sun, 19 Oct 2025 14:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=josie.lol header.i=@josie.lol header.b="E9CGrULu"
Received: from mail-108-mta246.mxroute.com (mail-108-mta246.mxroute.com [136.175.108.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B94229CB4D
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760883158; cv=none; b=T0nAc9BuZXJ3Zc8tT47D3Xd5AAU7hoC5FTr326csiv2WBkl6P76CsJSm/wL7fGZUfBMeLSHh/qFkC0RPgZItxFwFsTS2bRe3Q3x2g38HITZO1YaOsJXLDIXI4iF9Lbp69vo9k1R/eZUIAHigiDGFqjZc9NequEbNUNSJaJL0AW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760883158; c=relaxed/simple;
	bh=EGX01b6TK7OfS7IcNWP2f4mwVX7pWI0Pjy4oWLAb674=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QR/YwAOQGMsHayT/ZDSES82P5cHeJXh3rQc1ZxxkrNh3jud8CH7y8ywYVAeuJFR4y1QYWgClFenvq+RwWhVZ3Nb2osjUoxXBGVt2TceFm//d5WEn8GYgbFJMNc6SDd1l+799ZTZ/0j1QYgWM54SaapqzA9VTYmM5H+BvTwiGzmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=josie.lol; spf=pass smtp.mailfrom=josie.lol; dkim=pass (2048-bit key) header.d=josie.lol header.i=@josie.lol header.b=E9CGrULu; arc=none smtp.client-ip=136.175.108.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=josie.lol
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=josie.lol
Received: from filter006.mxroute.com ([140.82.40.27] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta246.mxroute.com (ZoneMTA) with ESMTPSA id 199fccbd41f000c217.007
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sun, 19 Oct 2025 14:07:20 +0000
X-Zone-Loop: bb1e2a7d1b63c83a20ecd86471ec80d718977e9d0c0d
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=josie.lol;
	s=x; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=I5RRsJW7XpZuyNBeXBTBqrOkEelaownoQQBDEYaX6f4=; b=E9CGrU
	Lu0NY226G8P7NHYpq/fZRxuKhXJsooFPsw+Iqc96Aw3hdVyCROh3OYOXKpskEMHrK6p1cuOcni05Y
	b88S0jj6OL1eRvSQddJ1PCIMc9Az36U00MWSl8FdDQm5N6Vt4C4Zr9mhfxTiSJYsn+Fxp/IV38pV5
	8r7O2ZjHSWrUzonOQ/JDSc0gIgbxpCq7P/XClC5VHdLCKWnHusRpqggGKQt9gwApn9V+gzPUF+ZUx
	pLB9QrB65dRu+hnICBw3QxW4vyIXfz0Nb8j8bp6hoAgU6hpBC7b0+Be6BNBwshIOf2wdtGo3pyX1/
	OgmC+bJ6BU5Hj1iz3b7rBD2u0Irg==;
From: Josephine Pfeiffer <hi@josie.lol>
To: pjw@kernel.org
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] riscv: ptdump: use seq_puts() in pt_dump_seq_puts() macro
Date: Sun, 19 Oct 2025 16:07:11 +0200
Message-ID: <20251019140711.63664-1-hi@josie.lol>
In-Reply-To: <2eaeaa69-b2cf-3a3a-0239-2aefcaa836aa@kernel.org>
References: <2eaeaa69-b2cf-3a3a-0239-2aefcaa836aa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: hi@josie.lol

On Sat, 18 Oct 2025, Paul Walmsley wrote:

> Hard to accept that it's a performance issue.  But I think you're right
> that generating a newline should be done with seq_puts().

Fair point. I'll drop that from the commit message.

> A better fix would seem to be to just get rid of pt_dump_seq_puts().  It's
> only used once in arch/riscv.
>
> Taking a broader view, both pt_dump_seq_puts() and pt_dump_seq_printf()
> look completely pointless.  Is there any argument for keeping them?

Good question. I investigated the git history and current usage:

The macros were introduced in commit ae5d1cf358a5 ("arm64: dump: Make the
page table dumping seq_file optional") to support passing NULL for the
seq_file parameter. This is used by ptdump_check_wx() for CONFIG_DEBUG_WX,
where the kernel walks page tables to check for writable+executable pages
without outputting anything to userspace.

All four architectures use this pattern in ptdump_check_wx():

  arch/arm64/mm/ptdump.c:341:         .seq = NULL,
  arch/arm/mm/dump.c:456:             .seq = NULL,
  arch/riscv/mm/ptdump.c:378:         .seq = NULL,
  arch/s390/mm/dump_pagetables.c:197: .seq = NULL,

However, you're right that the utility of these macros varies:

Usage of pt_dump_seq_puts():
- arm64: 1 use
- ARM: 0 uses
- riscv: 1 use
- s390: 3 uses

Note: ARM defines pt_dump_seq_puts() but never uses it - that macro
could be removed entirely.

Usage of pt_dump_seq_printf():
- arm64: 6 uses
- ARM: 7 uses
- riscv: 6 uses
- s390: 5 uses

For RISC-V specifically, I agree the single use of pt_dump_seq_puts()
could be replaced with an inline conditional. For pt_dump_seq_printf(),
the macro does save some repetition (6 uses vs 1 macro definition).

pt_dump_seq_printf() could also be questioned - removing it means 20+
inline conditionals across all architectures. I focused on the minimal
fix, but happy to tackle the larger refactor if preferred.

Would you prefer:

Option A) Remove pt_dump_seq_puts() entirely from riscv and replace the
single use with:
  if (st->seq)
    seq_puts(st->seq, "\n");

Option B) Keep the macro for consistency with other architectures, but
fix the bug

I'm happy to send a v2 with either approach. If Option A, I could also
propose similar cleanups for arm64 (1 use) as a follow-up.

Thanks for the review!

