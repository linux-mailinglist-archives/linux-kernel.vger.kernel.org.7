Return-Path: <linux-kernel+bounces-838172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 629A1BAE972
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 23:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188763C89B6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 21:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240152C029E;
	Tue, 30 Sep 2025 21:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdRHFj73"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629A92C0287
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 21:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759266205; cv=none; b=LBi25jwFDrs5pyNXeyHZ9GuMxDd2S4gP5F3UjvKA7JyzUoj7b+erTSkZowPzMOtaKDpffRqe4YfxevsHyNV3XIuj/G7AyJS6NKvwGWh0IiKU0C6vNXeNqZkSOtDMgkdMkzmi8ezvo3gkznxw3sFX96q0xT/0AUNDhKMeCbCNFwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759266205; c=relaxed/simple;
	bh=wzok/7o37z+TiXcVxduyiYWfyCqWTJG2YjkDyXDgD44=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GTQgTSD2xtE9fmZiMj9iipOplh+YIZn8kiKOd3xJQciGIC7ZZrimgf1iLSuAA9r34e+hjQoObWnE57e6e4td2OQM2aM/aPauz8/9HZ4vvw8r86tgaTMBMHkhKALruoHo91XCB+DGqWZgJSoi3jhiAw+gWlAX16xBwBlwWQStF4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdRHFj73; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3EDC4CEF7;
	Tue, 30 Sep 2025 21:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759266205;
	bh=wzok/7o37z+TiXcVxduyiYWfyCqWTJG2YjkDyXDgD44=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XdRHFj732LlJrpmeRCv2zMChRcDQ1+gTKjg8a5ZjNofPu62GrDn90kTVbg07L45uP
	 4pNoshoO8sykcC1aAiVzrIxDumfn2Sfmr7bQgfqb5jWTt7Rn+52x2hDEauoAMFE1QS
	 Lzct2+GGKr88y7uv3aVtiHGT827JsZr9Pg64xnD15jIyrR6d5AlKuVmT93S3D9k61r
	 9XtuyO1jbx5Lt22sQvZg74XGy0yP8HEgIIOfaEuWcwZ5cIjJ2BCWVqDV8RjOrFKDtg
	 zklv044MAirq7D+nDw2+MVogsIVIlrnL6JzdWfl1WxfAF9kGjbnz35e4q398yyXKgN
	 40qwkwODxFx/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D2D39D0C1A;
	Tue, 30 Sep 2025 21:03:19 +0000 (UTC)
Subject: Re: [GIT PULL] Scheduler updates for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <aNagfRAEhfbLelo9@gmail.com>
References: <aNagfRAEhfbLelo9@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aNagfRAEhfbLelo9@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2025-09-26
X-PR-Tracked-Commit-Id: 45b7f780739a3145aeef24d2dfa02517a6c82ed6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6c7340a7a8d2b6ecad1ad108f6daa73ba1dc082f
Message-Id: <175926619789.2146267.16076367394561667004.pr-tracker-bot@kernel.org>
Date: Tue, 30 Sep 2025 21:03:17 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Tejun Heo <tj@kernel.org>, Valentin Schneider <vschneid@redhat.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 16:17:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2025-09-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6c7340a7a8d2b6ecad1ad108f6daa73ba1dc082f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

