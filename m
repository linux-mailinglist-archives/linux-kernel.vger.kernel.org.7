Return-Path: <linux-kernel+bounces-790543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E8FB3AA11
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C9A3BAAC7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B8321579F;
	Thu, 28 Aug 2025 18:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6HCu7RU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A0E26D4C3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 18:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756405864; cv=none; b=SKiCGrNlpmShxGevPH7UEyRmfVmGQ8uM7Uw7ZQ0EVVqt8l1NdkP+dYxWAw7DkrvRzqZhap/7bwnlYHubeub6eSiZ46pMBoZxfDdJEvBvHg600+mdDvzV1MyJW+RMMwpy/EaQZn3KjlMgU35M25wUKikZk2i4r0t8q7Wnouj8iFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756405864; c=relaxed/simple;
	bh=3DT9FkuRoHUEi1sHGb+jqZFPjXOmvu0PjCbMl6ZeipA=;
	h=Message-ID:Date:From:To:Cc:Subject; b=PCBrAMSzyb0Jf3dn34fdgCqHbD+5yu0gIkM1QbglV+kEB8lg3XLJCmckVvDSpDMYduC4igdop9u3+LzZxzk+1GNHbUOVIPiYypnV3j8amYLkEGCdJknusuwPfVgegpcVZ2SYXr/A1WmAtgIZ9VpuuSwyVAOwnr7F0FScYWF/hdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6HCu7RU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DD5C4CEEB;
	Thu, 28 Aug 2025 18:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756405864;
	bh=3DT9FkuRoHUEi1sHGb+jqZFPjXOmvu0PjCbMl6ZeipA=;
	h=Date:From:To:Cc:Subject:From;
	b=K6HCu7RUn6cFtWrJJDHVmhBJO95YyOOGNBCualJAlccnyqdB173yOllLGzjQBG4qJ
	 xAZEBb4E+W8ICgXD9aDcr7PtWOtwKIaaJvESYI79Uu04cRTYQYcYZfthPHp8XuiX6P
	 lXWPDVdCZUPqrEYEccDYvX3ZyPmvSw070sgT1ngib7pxwcw7RjeV1lIaNgF7rNEOSk
	 jx2lJsGPlhUG5mqH0NgLqAO2Jv67QBXHC9hYytizTRS7QmktEd+G33Vx3gsAWscgwO
	 dvR7fO0Dq9j2TnZVQhnhzs5yeVXIupof7jYowPJmkHCV7j31+p3GHfIXiJGfTaufQt
	 HDsatiICGgOkQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1urhPB-00000004GrT-157n;
	Thu, 28 Aug 2025 14:31:25 -0400
Message-ID: <20250828182754.733989525@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 28 Aug 2025 14:27:54 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: [for-next][PATCH 0/3] tracing: Trigger a warning on build if a tracepoint is defined but unused
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


Stephen,

I plan on pushing this to my for-next branch, which will add this to the
linux-next tree. When the kconfig option "TRACEPOINT_WARN_ON_UNUSED" is
enabled, it will warn whenever a tracepoint is created but not used. This is
similar to adding a static variable or function and not using it. This means
that an allmodconfig and allyesconfig builds may start having warnings that
will get bisected down to this commit. The bug is not this commit though, but
whatever has created an event but never used it. As tracepoints can take up to
5K of memory, even when not used, this is a waste and should be fixed.

I hope that adding this to linux-next will start the push to clean up these
unused tracepoints that are in the kernel, as well as prevent new ones from
being added. Hopefully by the time the merge window rolls around, most of
these will be cleaned up and this can be merged upstream without triggering
warnings.

I built this against all archs in my tree (26 of them) with a allyesconfig.
Unfortunately, only 10 build successfully with that (they all build
successfully with defconfig and this option with tracing enabled). This
detected 178 unique tracepoints that are defined and not used:

$ grep '^warning:' /work/autotest/cross-unused-traceevnts.log | sort -u |wc -l
178

Among them, 78 tracepoints were created and never referenced.

$ grep '^warning:' /work/autotest/cross-unused-traceevents.log | sort -u |cut -d"'" -f2 |
    while read a ; do if ! git grep -q trace_$a ; then echo $a; fi ; done | wc -l
78

The 100 remaining are likely in strange #ifdef CONFIG combinations where an
allyesconfig defines the tracepoint but doesn't enable the code that uses
them.

Expect even more warnings with different combos of config settings, as this
will warn whenever a tracepoint is defined but not used.

-- Steve

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
unused-tracepoints/for-next

Head SHA1: d492e79ec6892ce1928a4c929ea29c0d5986e117


Steven Rostedt (3):
      sorttable: Move ELF parsing into scripts/elf-parse.[ch]
      tracing: Add a tracepoint verification check at build time
      tracepoint: Do not warn for unused event that is exported

----
 include/asm-generic/vmlinux.lds.h |   1 +
 include/linux/tracepoint.h        |  12 +
 kernel/trace/Kconfig              |  10 +
 scripts/Makefile                  |   6 +
 scripts/Makefile.vmlinux          |   2 +
 scripts/elf-parse.c               | 198 ++++++++++++++++
 scripts/elf-parse.h               | 305 ++++++++++++++++++++++++
 scripts/link-vmlinux.sh           |   4 +
 scripts/sorttable.c               | 477 +++-----------------------------------
 scripts/tracepoint-update.c       | 232 ++++++++++++++++++
 10 files changed, 804 insertions(+), 443 deletions(-)
 create mode 100644 scripts/elf-parse.c
 create mode 100644 scripts/elf-parse.h
 create mode 100644 scripts/tracepoint-update.c

