Return-Path: <linux-kernel+bounces-581243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B98A75C46
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Mar 2025 23:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 599C2188AFB8
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Mar 2025 21:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1B51DF248;
	Sun, 30 Mar 2025 21:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2uB0ILE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795F51DED54;
	Sun, 30 Mar 2025 21:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743368717; cv=none; b=LNl5/EA+iBo+xeMab1kv65S9rwWgSqLMSPFZ8rM74b3fdzcQ5eHNmavPSNcUBha2vs1t+HeYTE4YTYRPqtBJkGaUrpSmnfSBITUxwFSMiGZiv32mg8vcdOVDGMbg4qgbRQFlyfkglu3OW9IdqgRcBEs8Ijwa0YR0S+erMImHrD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743368717; c=relaxed/simple;
	bh=xXLojWJgXG9MhEZg6m8/8toZF0mJodYEQWBGOri0KIw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cFtLrcyD/rq+c9KrgEJIzHkr2DdRH4rbRlnuZSa/qOXbXdGtaHNiLErzJ6RR/aW58Ao6SKXceA2uWqZg1gNkbzYJijIDnU1poaixOAHeg/9HFK4+pNFeGqYqlYrtGBsikL3aBAfmanYIy+GrNuqfPxm4My9m+IyT7a6Y3RnwUYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2uB0ILE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532F7C4CEDD;
	Sun, 30 Mar 2025 21:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743368717;
	bh=xXLojWJgXG9MhEZg6m8/8toZF0mJodYEQWBGOri0KIw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=I2uB0ILEvyraTRh1gtZ3UnYJSmsXHz6PnvoqFMhvUYuAtzbvFMRrsx06xnDBFBSPS
	 MeL1/jVrwPY/Z+xAdFGEfK1dCOhcRk1hJr5DGS662BnN1fPEbJApDMCkAlLMhEP8pZ
	 96mgE4tT3e6WklcgZyNMCcbgybo/fF/d1xjLbWpBOM/p3KDqL2mHG0xerMdw6xoh5H
	 DZAqQRp/PyZgIqQd80Djm5V8sn40xvmSlYM+9BMubfqed/DDINW/+askled1LbKbpp
	 48+C2F8KGBZcr+b6mX+CQPzn51faWMxeZKqU5eTVNWHOB7yzL84NudoEtzHQLzmdS4
	 6vUVGzPt5XWGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B05380AA7A;
	Sun, 30 Mar 2025 21:05:55 +0000 (UTC)
Subject: Re: [GIT PULL] Introduce try_alloc_pages for 6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250327145159.99799-1-alexei.starovoitov@gmail.com>
References: <20250327145159.99799-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250327145159.99799-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf_try_alloc_pages
X-PR-Tracked-Commit-Id: f90b474a35744b5d43009e4fab232e74a3024cae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa918db707fba507e85217961643281ee8dfb2ed
Message-Id: <174336875371.3547747.4605050908323962008.pr-tracker-bot@kernel.org>
Date: Sun, 30 Mar 2025 21:05:53 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz, bigeasy@linutronix.de, rostedt@goodmis.org, mhocko@suse.com, shakeel.butt@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 27 Mar 2025 10:51:59 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf_try_alloc_pages

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa918db707fba507e85217961643281ee8dfb2ed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

