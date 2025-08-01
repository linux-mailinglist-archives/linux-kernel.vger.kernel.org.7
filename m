Return-Path: <linux-kernel+bounces-753708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 021CDB186C4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E671AA4C80
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EE028C871;
	Fri,  1 Aug 2025 17:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjIfAREp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB84828C5D2
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 17:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754069704; cv=none; b=rzXtU01nNsYLlE2BKLT9xQEP5jKUhThu3uGfKybK8CkRfQnuXu56g3N9b/ktxt1Z0mb1909d8o+PVkdpMLHB1EKwmOkdiAu9b1BMyev/U46nspEiYmtngis6ivmF8PQfqP9PzyYomII8pOW8JZaUKD7xDysUrThm3wTKD2MKJqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754069704; c=relaxed/simple;
	bh=V4CGb16TDOMILJM9VftY+gn60UfpoWY07IeFhfVrmaY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=K3cK7DM5fFVDmB39Lh+yqDf+O+SsKTkL/HUZ5Vd1Pad64Ej7+ze4p8wI7tuAEgZEfs+hAiTgSeVFqFCI0BBA3d0ePy4KcwqRS3XRrpDRS7b67XDxaRXmBlGEnb+vMYipjLwGed2SjthDVw0LwnCG47h+QC+pAwIaHshSbVoiAxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjIfAREp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BD6C4CEE7;
	Fri,  1 Aug 2025 17:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754069704;
	bh=V4CGb16TDOMILJM9VftY+gn60UfpoWY07IeFhfVrmaY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PjIfAREpxZeKfY2qjDpkVMd9gQM6hpbDStQ2r4hMC5Ed0x+VTW24i62uAUqt5JIBj
	 9GPRsj/nRd5eHxCt/aj8k4srY980LH2+tDuMroN8YaCrto3ryDnaD8zwgVO041cOnw
	 EkyqfVBdLaJ6AbNHZ6lvZF7uAJNkRyFfc2XypIT4eplUhLE20cZDWt72dtej8FeRfk
	 iTzqLe6v5RYKuCNLAPKor//M+paBWCd6YmT4OuQYHWHDzhStnuR5+Zf86pTdfKGNDL
	 JIlMSSY37MzTa0KRllDsXkDGJ+aqUG0250CugDiJ0Lh5ieqm5mTM7BVsHZKaxZ35ib
	 0BsDMZLgYdaLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C44383BF63;
	Fri,  1 Aug 2025 17:35:21 +0000 (UTC)
Subject: Re: [GIT PULL] unwind_deferred: Inclusion for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250731103211.10b42cb5@gandalf.local.home>
References: <20250731103211.10b42cb5@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250731103211.10b42cb5@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-deferred-unwind-v6.17
X-PR-Tracked-Commit-Id: b3b9cb11aa034cfa9eb880bb9bb3d5aaf732e479
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c6439bfaabf25b736154ac5640c677da2c085db4
Message-Id: <175406971985.4015829.4500531992803341564.pr-tracker-bot@kernel.org>
Date: Fri, 01 Aug 2025 17:35:19 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 31 Jul 2025 10:32:11 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-deferred-unwind-v6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c6439bfaabf25b736154ac5640c677da2c085db4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

