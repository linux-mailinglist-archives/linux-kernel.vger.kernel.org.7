Return-Path: <linux-kernel+bounces-842382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 758E1BB9A6A
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 19:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E6044E64D0
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 17:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FC81C84A2;
	Sun,  5 Oct 2025 17:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQpS3slG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23A01C5496
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 17:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759686221; cv=none; b=t3B+m+CsEmj0UnDcLl6kHWTbjDeHAve2abDWomOILx6XTIqHWv7zCdhNwVyBuCm/tSwinuaJy8HphI2jpglKTtYqPnVYT9629I78UhofZzWQPuYeBcC03iOU1Wak3VQvdli6vgQfszT4CDp9rm1qWJWqSzmXpHE4SVgUQfvsRX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759686221; c=relaxed/simple;
	bh=aWZDZ7iotHVfhVHIYfbgBzu6kE7HldURSgHwTSzEIqI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XOSxiVgfhF2NIlvHOC1vFCkcQAI+Nz0/JAESFdHtEZoemGFSKnH6n6IAXBcTPwtcOJUp/8Aj3YV+iRuQMse68miExhpwRkxWjgy1yymkDeza7k1l0jDz81XiSf/Ha64xR43UgZ+Y5MSarSuK6YTXgPLr3+HZWJq2xJhSWG/mhlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQpS3slG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0B1C4CEF4;
	Sun,  5 Oct 2025 17:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759686221;
	bh=aWZDZ7iotHVfhVHIYfbgBzu6kE7HldURSgHwTSzEIqI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DQpS3slG7E1OGf3ZaUYfmAOMAG+vJnAgBzdLwPYgvFYLYzpBTKhkhO7VSTnPnKCDY
	 wQCYM8AWJ8V3BYHelq9ZUCm5+pfDigQgFM9CUWmse353X+puCGgnXdbQe3UObJK+Ej
	 jLljw1uJO0bxraOAaZae8H7gKFcNhvIF7jL9FzItAU37RaMJxHSTbUXNeVbJzcSgQ2
	 95QN95ouyx0afqJZM0njRQvyp8xH+ewToBo57ERwa65zokhIGBTQYnzDgQhpi+Hx0g
	 pyRO+Hqzwfrqh4H3O3TR1zQ2MpkAWijQ0fin7Ee6eKgl3C1KA00re6BVgLGmfHBFEm
	 QZ5n0dKCkHN7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCC839D0C1A;
	Sun,  5 Oct 2025 17:43:32 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Updates for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251003122923.0cf11def@gandalf.local.home>
References: <20251003122923.0cf11def@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251003122923.0cf11def@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.18
X-PR-Tracked-Commit-Id: 61e19cd2e5c5235326a13a68df1a2f8ec4eeed7b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 21fbefc5886cc38cf7b57b28c35bd619efbce914
Message-Id: <175968621130.698585.7798375099662096880.pr-tracker-bot@kernel.org>
Date: Sun, 05 Oct 2025 17:43:31 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Elijah Wright <git@elijahs.space>, Fushuai Wang <wangfushuai@baidu.com>, Liao Yuanhong <liaoyuanhong@vivo.com>, Marco Crivellari <marco.crivellari@suse.com>, Michal =?UTF-8?B?S291dG7DvQ==?= <mkoutny@suse.com>, Qianfeng Rong <rongqianfeng@vivo.com>, Sasha Levin <sashal@kernel.org>, Vladimir Riabchun <ferr.lambarginio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 3 Oct 2025 12:29:23 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/21fbefc5886cc38cf7b57b28c35bd619efbce914

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

