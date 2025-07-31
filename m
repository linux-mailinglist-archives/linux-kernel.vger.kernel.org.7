Return-Path: <linux-kernel+bounces-751444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C1DB169AB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B56621996
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 00:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABDA1519B9;
	Thu, 31 Jul 2025 00:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9SJ7C/s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AFB13DBA0
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 00:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753922100; cv=none; b=k3/zepPmVNSS7e/rQjtI9GxiL2lg9XIDLqWNGQbSjbIjEkaYBDn/B23gckckg0qY6eYNE0Tb9Mm6b3Np2F//5rvvylKY2RG/VjP/aEHYxd6xB5iF7PJy0Dp7M2Qa9EJXHmAhvTp+u6gCKGFef9fwMUTE4sVgdg1a3UVAbrBOjos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753922100; c=relaxed/simple;
	bh=U/71eNTet9SIkSQRZV3++qGxDX/gawScexZGW9rxJu4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JHdFaTDgWHp7kJZ6Z8Ww2dTf771ReLLvjquKM9dzd7L55fWLzL3gXBjg4Pfypv+tXkafN7c6ZqQsRNCi6gGLCeM/kNNWdIiQLRcLcaX1AAPPbvDO0QODlsUYZv4UMOOPm/melRWaY7wAJi2clmmQgedVVssPLVyjmC87gWFPEc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9SJ7C/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CD5C4CEE3;
	Thu, 31 Jul 2025 00:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753922099;
	bh=U/71eNTet9SIkSQRZV3++qGxDX/gawScexZGW9rxJu4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Y9SJ7C/sJokP9Ax5VlYG9uMLn5GqJB7MjGAFAmiIHNDa6qs6pS7IE97yIGUPT5pL+
	 HX1W1tTUWfieDobx8V1Dpqa6UuLnxOOgaSS9xNI+WXyyHRc/gzpuGH4JCMQM4RSwoV
	 qBbJXQasxQiAxlsYPbLd3RRtSVQU9UzuZGBGo3wYKpvgAgz2NFdFv0dmIoYrYK/z9/
	 RIjvtSlBEIA4gHDCEUh/jXptgxhBR4zDcKsqT4rBYgs7CSIkltuF5DKx7vjp97frtP
	 KCutEdHVa64sd/LMR9pRQkLXdghy4JQMEXrZLyiMRoWjeBypSeYi2TOYGZKqPUMGF2
	 WidCxvzYbgQzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD6C383BF5F;
	Thu, 31 Jul 2025 00:35:16 +0000 (UTC)
Subject: Re: [GIT PULL] bootconfig: Updates for v6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250730001421.dd070b79c120e9f6e9bd6b27@kernel.org>
References: <20250730001421.dd070b79c120e9f6e9bd6b27@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250730001421.dd070b79c120e9f6e9bd6b27@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git bootconfig-v6.16-2
X-PR-Tracked-Commit-Id: 6ed5e20466c79e3b3350bae39f678f73cf564b4e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9bfdba946f30d5cbf2257932a53682c0ad1aeb37
Message-Id: <175392211543.2556608.3577388882637956275.pr-tracker-bot@kernel.org>
Date: Thu, 31 Jul 2025 00:35:15 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ben Hutchings <benh@debian.org>, Bhaskar Chowdhury <unixbhaskar@gmail.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 30 Jul 2025 00:14:21 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git bootconfig-v6.16-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9bfdba946f30d5cbf2257932a53682c0ad1aeb37

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

