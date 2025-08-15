Return-Path: <linux-kernel+bounces-770987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D39B28145
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A66E1D01BD9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D12C1C8626;
	Fri, 15 Aug 2025 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGcAL+qD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034F21C2335;
	Fri, 15 Aug 2025 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755266782; cv=none; b=Ea1TwtpIiYtv2FPtzNEH1tFaIkrlv7OUB+Ufz7kYQ8NCpwgt+VF624C3WxmPP/XP3SThE6xd7Qf1SgbvqisqvnIW3nLceocsCnK0O8wkrOuRx5F4R1e6684BsTDCIAwPTzD+IpHseHV9gJ3hJqtbB8EkEHdynQy179W5Nc9ADmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755266782; c=relaxed/simple;
	bh=SWG5fuCUd4FQn6lMq7/iFi2vad4V17OrN/Q5gJq7nOo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WoLhXgnD1qi+mbCg+zU3pXV/nGHzyL9spYEeJgKTyP9IMHOjl800WQ4xVUrgGuzrcnBwpwnHfhZgQbaoLM0krslH6MVKci+kbNWYlZsaOIAS+E0ipIZRLOXtZAtGslyhEJf6gNQaYQtjS/WOJ7qMA6bb4YOeWqsJ2CqlM2FbtFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGcAL+qD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D55C4CEEB;
	Fri, 15 Aug 2025 14:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755266781;
	bh=SWG5fuCUd4FQn6lMq7/iFi2vad4V17OrN/Q5gJq7nOo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EGcAL+qD/J/8vzxRg3sL5G6SDn7H4JPVJ8i+J/1hymmfxIXoSYfPFXC9clofDN0NT
	 6WM9zFTdZ5Q9KEc6/jqdU7SVFo1x2+3itc+6XpD6Z8PTiDLBPVSfM5ghL1wjkn8dmb
	 deinutwxCJb+mEsNHxx3dmZ+aspgn6cJ96LxBQLL8z7oujEjOMoUVOwGHrWB65hAJD
	 yS3i4uImaB84aq+NhJU2KWQ/Lx0nOh70UOJVv5tqxV8+FXPTwzeVgb5gX5mSoC9gNr
	 R8X3z0siKo2/8jLMWg75VSUlCA/mZRbL2u+CLHfOMUhAQQCIdz3lt1GduhGndaien0
	 OUvc1vVPZ5b4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BBA39D0C3D;
	Fri, 15 Aug 2025 14:06:34 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.17-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <877bz4ubb2.wl-tiwai@suse.de>
References: <877bz4ubb2.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <877bz4ubb2.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.17-rc2
X-PR-Tracked-Commit-Id: c345102d1feed3de8aa9b9ec7d18b3fbba62deb7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d084337a32fde0ffa59d5f70d07a54987911ba1
Message-Id: <175526679271.1083334.17623011348927011784.pr-tracker-bot@kernel.org>
Date: Fri, 15 Aug 2025 14:06:32 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Aug 2025 12:30:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.17-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d084337a32fde0ffa59d5f70d07a54987911ba1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

