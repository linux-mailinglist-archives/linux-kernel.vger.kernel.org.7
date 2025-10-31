Return-Path: <linux-kernel+bounces-880436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B49C25BE2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E300E4FAAA4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF292FFDC9;
	Fri, 31 Oct 2025 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfxxNe/e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6349A2C11C8;
	Fri, 31 Oct 2025 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761922209; cv=none; b=bGtTDbrTf4sFFcnj/OwIH/ytlGJ6NTyxGbRzX6tBYcCWzY/OTNxBqymQ0KKuoKbkkBzTYl03wp0KLY8xi/JqLvF/55igfbCETRC0tUzDp0VJOLpSwTrXPG4TjkvdikniNmeLcd/lqGLjmrSrqyTPyreYJz4Nlp0OHi+JYFKYTOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761922209; c=relaxed/simple;
	bh=jTZ4L8GNpSocJFzGyTPRCub9CfnO4vK7FUNOodgRK4U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Wj1nXwAqm3REE32cGCmIhRl/P5hYqYAaD6k1jmnTnC7dbN+YbE+KsrDJwi+piM/K11jDBFAWOt06nthBNUvWb7hJOX8RuFGfzs3v4SNH3We8+9w+cJn7aPSEs9YMeGMmKDTJkVA6SQKCYEpZC91Q9nZlQu6eebgenE/zsPqE1B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfxxNe/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDD9C4CEE7;
	Fri, 31 Oct 2025 14:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761922207;
	bh=jTZ4L8GNpSocJFzGyTPRCub9CfnO4vK7FUNOodgRK4U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BfxxNe/ezdMiBkPWssV6FCoPSDb0dmGFQi8Fjg4UAm3vMZQZZc4pSenX8f3X9YqMs
	 f5JV5RHSF+OyUiLNfB2WjzfJwzlr1wBudV9MXYsaMbPH0LBlbrvgSpFHYfUS/lpfqx
	 ILhHplD0w9PHW1B0EgcFMMF+Z5Bi41nF27Isaa8pPU+TU1A7Za+NXhdTBzmHpwd7M9
	 1jvYQO413EmQnzi3MBHblFqXFGidfCfybxqci+MR2Xf7XsiBG2yEMzB9D3gLrwuOQX
	 86WfkpJyT28HNA/SHSTTd4DjzFTfb73yQbLgN7FKmSts1VDaEwiQKHZ7lKE6js8JPT
	 tIov9nZ9RaE2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E033A82560;
	Fri, 31 Oct 2025 14:49:45 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.18-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <87frazjn6g.wl-tiwai@suse.de>
References: <87frazjn6g.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-sound.vger.kernel.org>
X-PR-Tracked-Message-Id: <87frazjn6g.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.18-rc4
X-PR-Tracked-Commit-Id: 390db60f8e2bd21fae544917eb3a8618265c058c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 58fdd8484c05a19942690008304228ad784771e9
Message-Id: <176192218379.504982.6109738291823477747.pr-tracker-bot@kernel.org>
Date: Fri, 31 Oct 2025 14:49:43 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 31 Oct 2025 13:00:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.18-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/58fdd8484c05a19942690008304228ad784771e9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

