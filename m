Return-Path: <linux-kernel+bounces-848635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 663EABCE3BB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A91274013E7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6C82FD7C6;
	Fri, 10 Oct 2025 18:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erymPeW4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB2D2FD1BB;
	Fri, 10 Oct 2025 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760120768; cv=none; b=rZfZpDSZKqTS0M4gZHfgA34b6Z4rqfv05lqTSWcJa7WFM9H4qPcwUc6i9HQf/D5lul+DmyDAate5uAl4wrWh+Mdq4dXtZJKUernbrOT/12ti0/K10uNkv7VRkqa4DUhvrdrJNIiryVTGtEaNXW+wWzCSlT6c5eaOWGnIVm0bmd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760120768; c=relaxed/simple;
	bh=tGLvL5uxf5wlHTMze4sV3GkIVlu9BrEsghDf6r/BgOE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VtCnmzz1liYvLRs0ne9n0kCjvYiMWSOKQhKdFVj2rjk/IzZpYFalky+mWGjdM3Bm6L0Tg9OQA0pTPss1JgDJ+k0vgxNfV+8W6M4odKgV3JHIRFzOOiCFK4KiL5s9nDJiLkcOKXckzP7yqUNYUPRs+ALGLI+cR4rkqjJA7MLgJ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erymPeW4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE77DC113D0;
	Fri, 10 Oct 2025 18:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760120767;
	bh=tGLvL5uxf5wlHTMze4sV3GkIVlu9BrEsghDf6r/BgOE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=erymPeW4B0exApYtqb4FYRGzmsZqZOSMIDnamKgzS1//8/vzI3rlg++DrbAnZlcHq
	 017ID1UsLVAxG78gEUPoV5asRTmGj6D6DDkn7HMu3bputBBJRG61d9XuemY/nboI/S
	 1o1p0UKQopbSZVkF19xwaw3BIDiIVuBjoVFh2z7HNrljoVHnrUTTw+7F0lrbjJ/F1P
	 nwks+UZKYlZ2a8rRNqCYxccvPOy8ml7a0WdOFGeQzRXCZ4Hu1BDnKwoFb3VKByphKb
	 dTpJiDiiWeNNM9z56mv+6fRlVLSiBg/AOIelMoZkJBSruPl4BSJnFRGWwDYCeRHCi0
	 jcw+o2TZO8E9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7123F3809A00;
	Fri, 10 Oct 2025 18:25:56 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <87zf9yan50.wl-tiwai@suse.de>
References: <87zf9yan50.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-sound.vger.kernel.org>
X-PR-Tracked-Message-Id: <87zf9yan50.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.18-rc1
X-PR-Tracked-Commit-Id: ca7a2317993efa26eb2100a1523548f1b3a07af0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fdfa38e95e1229ec2fb2f18540987c97f861d470
Message-Id: <176012075507.1074429.6833303949514440292.pr-tracker-bot@kernel.org>
Date: Fri, 10 Oct 2025 18:25:55 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Oct 2025 15:42:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fdfa38e95e1229ec2fb2f18540987c97f861d470

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

