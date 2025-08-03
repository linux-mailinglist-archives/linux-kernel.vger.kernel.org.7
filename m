Return-Path: <linux-kernel+bounces-754547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48118B196C1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 00:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 075833B6A92
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 22:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D8521A447;
	Sun,  3 Aug 2025 22:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dW6Awa25"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BEF218EBA
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 22:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754260364; cv=none; b=Gpnpz2TGz26Ln5MBEWL4iHFsKaHMS9HYc9ow0hukiNoSlTVcdjLjxB0WvChCKHUsTYxoBlYgvuuhp96zE+wZN++evOLmIxPx3sbqZoXjMjj/h2RmSUyHiu7YhWKZogk+CIswFKxCBVu4rutzdLmUAYJgXEetenVACT+T1FuObEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754260364; c=relaxed/simple;
	bh=WQYxaTVNP1yCu9qTKE35jwcJZ04twj9mXcUiH9l8MPg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rp7/jI9w9Z3ffYdacSmtof0Q+HFDIImtKJv51vvfwOFHMsCacDftvs8/k5ZYLUW8I5WqlDIxfb3iHvJedG0ak4tP+1MkoaAOHo8056ln6SlkC7ET4kgY/YAiQYtm7WAhSpJkxDCG3TS6ytruMOOx8RIm7WmZKG1c3ibzBkK1nDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dW6Awa25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1018EC4CEEB;
	Sun,  3 Aug 2025 22:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754260364;
	bh=WQYxaTVNP1yCu9qTKE35jwcJZ04twj9mXcUiH9l8MPg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dW6Awa25YoLLgKngCa/YfSs2w+PtmM/5skSC50JHHJa6dfcs83L0acfLsaIjja0Zs
	 uPqXxilpuosjCaStmwprKx5aowHy5uufIf17bnZRitQlNtWDRNdzuuK4wkjq5oA7JC
	 G8Q+TUTqUUgYbbcnnOPNFDNpMulj6ydK7N6S/IGEcafMFZ9Wk1tDQzVBoS2W5WH0g/
	 a+zumsbQ6LYCQ7yFaX4Y+7PtbCKuZvHUfdo9yJV4T9xUUJseI2zcC8qhF/eyF+0yjY
	 mxXksYgrjL9yrk0DsOFla+gXD/bZTqjjMfeNoINJ787u1Kj1wWstGfpvWKV2H16hPH
	 qOxBcX5NGOfgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD0C383BF56;
	Sun,  3 Aug 2025 22:32:59 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Cleanups for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250803095511.6b59d10b@gandalf.local.home>
References: <20250803095511.6b59d10b@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250803095511.6b59d10b@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.17-2
X-PR-Tracked-Commit-Id: 3ca824369b71d4b441e1fdcdee8e66bcb05510a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3c4a063b1f8ab71352df1421d9668521acb63cd9
Message-Id: <175426037854.556955.8062125246926826673.pr-tracker-bot@kernel.org>
Date: Sun, 03 Aug 2025 22:32:58 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 3 Aug 2025 09:55:11 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.17-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3c4a063b1f8ab71352df1421d9668521acb63cd9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

