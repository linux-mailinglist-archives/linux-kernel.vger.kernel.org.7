Return-Path: <linux-kernel+bounces-743143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74509B0FB24
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48180962A6B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3CB230D1E;
	Wed, 23 Jul 2025 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="od3iwsHp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDBC22DA06
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753300341; cv=none; b=nnu6RaXJ97YQ9sYQttKntIZ41H6h8gYnWcyj+tkiDKN+eRjRkSpdobD3QVmNW5S37E3UrPS16drR3gGLZZ229TIpPv35+BKY2mjWQa9sojJd/NqYykhdfdcLiMxc1Vc+G6RZIJ/yQu0F03MlND/tNSgEVj19PPurf0/2yI037CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753300341; c=relaxed/simple;
	bh=wSry9wIBmMM+WEZGyt/JTXLqvzqisIvFdJo7e7ew+hk=;
	h=Message-ID:Date:From:To:Cc:Subject; b=duBHUCyAHk1G9cIiqunmHK41bWcvKdquEaDSvDYQTg1KWqVRfFun/VvjgzYtG8ObjB9F5pnLFxbpJCH5VOZPdMfCOA8og+fXEM1veUH10Te8lZBEcebArQzfu8Bq3Rgx+NG7vXThSVb1AugFCbL36xBqQ1Q0mhOtn4ZJty1UkyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=od3iwsHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7467CC4CEE7;
	Wed, 23 Jul 2025 19:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753300340;
	bh=wSry9wIBmMM+WEZGyt/JTXLqvzqisIvFdJo7e7ew+hk=;
	h=Date:From:To:Cc:Subject:From;
	b=od3iwsHp43GdjwZVrb6u50FvMLsbGTXmLCF8fhZ0kiHEpyuZbwN7TBqKRApkswVK7
	 7dAxB5/W+v49NOBdFFR+GPJHvavvLloXGjbJM/oBBxAQescY9Tk8fN1kRTR6e3nq71
	 68TVt5N8HahW7+6hi99N7JdTiUpIbtWHSAqBSW7hamuC4i9PrKd+UQS0N+J5y1mycB
	 uO1mQMvAjnZmeeeCNCPc+l6D7YLVlfrsfdczGT8Qq4/iGMDEd8xVUcaweUz1AFhl+O
	 0eTh0faQwMPxsO7j/d/zdgoJPR2y0JB317hig1J4xPghJ9/hjM6k0s76tdYq7Rngqu
	 WX1Kmuh0/VjZg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uefVl-00000000Qtl-44T1;
	Wed, 23 Jul 2025 15:52:21 -0400
Message-ID: <20250723195208.164959427@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 23 Jul 2025 15:52:08 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/3] ftrace: Updates for v6.17
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ftrace/for-next

Head SHA1: 4d6d0a6263babf7c43faa55de4fa3c6637dec624


Steven Rostedt (3):
      fgraph: Keep track of when fgraph_ops are registered or not
      ftrace: Make DYNAMIC_FTRACE always enabled for architectures that support it
      tracing: Remove redundant config HAVE_FTRACE_MCOUNT_RECORD

----
 Documentation/trace/ftrace-design.rst | 12 ++++--------
 arch/arm/Kconfig                      |  1 -
 arch/arm64/Kconfig                    |  1 -
 arch/csky/Kconfig                     |  1 -
 arch/loongarch/Kconfig                |  1 -
 arch/microblaze/Kconfig               |  1 -
 arch/mips/Kconfig                     |  1 -
 arch/parisc/Kconfig                   |  1 -
 arch/powerpc/Kconfig                  |  1 -
 arch/riscv/Kconfig                    |  1 -
 arch/s390/Kconfig                     |  1 -
 arch/sh/Kconfig                       |  1 -
 arch/sparc/Kconfig                    |  1 -
 arch/x86/Kconfig                      |  1 -
 include/asm-generic/vmlinux.lds.h     |  2 +-
 include/linux/ftrace.h                |  2 +-
 include/linux/kernel.h                |  6 +++---
 include/linux/module.h                |  2 +-
 kernel/module/main.c                  |  2 +-
 kernel/trace/Kconfig                  | 20 +++++---------------
 kernel/trace/fgraph.c                 | 16 +++++++++++++---
 kernel/trace/ftrace.c                 |  4 ----
 scripts/recordmcount.pl               |  2 +-
 23 files changed, 30 insertions(+), 51 deletions(-)

