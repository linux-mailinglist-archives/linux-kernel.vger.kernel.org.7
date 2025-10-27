Return-Path: <linux-kernel+bounces-872504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A06C11567
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E9A61A25BDC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4FF3254AC;
	Mon, 27 Oct 2025 20:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYCau8sW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DBF31D72E
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 20:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761595990; cv=none; b=dVys2efuYaqgT/W/a47oW6bZZmmX5TnbAhjkgGYUxwK+x6l2YYqPgJl8qa/jdP3xC7ofZwavgPJ4Fbtqf+PXSctlgROjo4HBTB6SpM3vD/eZ9svTF8m+kQU+Ix319tJ5+B74AkkmD2ilXcBtxIuamoqPNHNUPRhxnHlWmyAYdaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761595990; c=relaxed/simple;
	bh=8kO6bfrvYWFjH1sLDqs+Sn9M6TIE/kNEqnjYR7TtBa4=;
	h=Message-ID:Date:From:To:Cc:Subject; b=bb4awb3SnHIO6uhYENwXsc/CJO73CxINxkISoO8MH+6D2/fe2XAySHVwFeTwfwigCgg//YI7Ey8ZLWgqawgkLgfT6xQCWmxP+t0n0p5bp9WSWq8aLK9dJfV2S9/nj+/dd1+6Fi+rM+TQaR0u+EKUVfsv5lrmOjkj2DC3K5dt7UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYCau8sW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF8EC4CEFD;
	Mon, 27 Oct 2025 20:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761595989;
	bh=8kO6bfrvYWFjH1sLDqs+Sn9M6TIE/kNEqnjYR7TtBa4=;
	h=Date:From:To:Cc:Subject:From;
	b=bYCau8sWik0eAkwpdHytgyyDPGi0wZkFeEFncnqQog/eIrE3u8LtLcecoaJ9Vrt1z
	 1Csd23ZUcLfwBCAqltRJ2NTwqhCQosdRADB9usjblLY57I88V13r81uurwLrnuFc4i
	 Fm7TPHPR5EqrCFFRUdAheEr9+m1re4RrnI6XbYadGvUUt5Wryt70mnsHOoGdOVEtF7
	 A8o5/liuPLRmTLo2r/Q24RPvluQ+GaBKL+c5dwh0fVcaZiDPhrGfNsOi/MtUh0580Y
	 GsVmDJZWlvbY0MTeVry84EiPoipvKzlL5PkUZBkHVKCWnJo77RXG7NV0ggqhsZE00I
	 D5vkCGOP+FsHA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vDTb8-00000004Pm4-0NR3;
	Mon, 27 Oct 2025 16:13:46 -0400
Message-ID: <20251027201325.076180660@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 27 Oct 2025 16:13:25 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/5] tracing: Detect unused tracepoints for v6.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
unused-tracepoints/for-next

Head SHA1: 01ecf7af00b86daf7ac441b9f94d4873d2b8fc74


Steven Rostedt (5):
      sorttable: Move ELF parsing into scripts/elf-parse.[ch]
      tracing: Add a tracepoint verification check at build time
      tracepoint: Do not warn for unused event that is exported
      tracing: Allow tracepoint-update.c to work with modules
      tracing: Add warnings for unused tracepoints for modules

----
 Makefile                          |  21 ++
 include/asm-generic/vmlinux.lds.h |   1 +
 include/linux/tracepoint.h        |  13 ++
 scripts/Makefile                  |   6 +
 scripts/Makefile.modfinal         |   5 +
 scripts/elf-parse.c               | 198 ++++++++++++++++
 scripts/elf-parse.h               | 305 ++++++++++++++++++++++++
 scripts/link-vmlinux.sh           |   7 +
 scripts/sorttable.c               | 477 +++-----------------------------------
 scripts/tracepoint-update.c       | 261 +++++++++++++++++++++
 10 files changed, 851 insertions(+), 443 deletions(-)
 create mode 100644 scripts/elf-parse.c
 create mode 100644 scripts/elf-parse.h
 create mode 100644 scripts/tracepoint-update.c

