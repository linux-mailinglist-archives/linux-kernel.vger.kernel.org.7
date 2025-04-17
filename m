Return-Path: <linux-kernel+bounces-609753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C3FA92B3F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 20:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A68BC1880192
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 18:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74B725A640;
	Thu, 17 Apr 2025 18:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJWLYcig"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF3E259489;
	Thu, 17 Apr 2025 18:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744916202; cv=none; b=dh5ehLkPVdfnkYvpxogxT45lLsibsTANbPEUCxp9jJ9q0KnXrNM0STfqnCu2MIhcI9jqKoBuVTmJyp4Yv1RJBJohbnEXTpZnw6mxzfyGiIcwzxn68LjzNWlPZtXkmDbTWaPZBCmyAJ++2LtbSrVHNTBirol0jrDIvxYRdljvjig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744916202; c=relaxed/simple;
	bh=m/buiRNBct8EcbaaXt3pRxAwTZbWgz5v2c8LsFp42vQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Hjodr6Nvb7ggM5WJHLqxOZPY+62NeRyrpGIq1Fb/PxA2LGBfpqMFGIfVu+24S50rO8nETZAPFzc6ACZDyOozb5ebErOsxoXz+Fogzz6UA7MZMLSAw2EKQVymdAusIvFBxOghg8/iE2DudvP6jeUjjj6dxbLLN9jfSEm7GIfErgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJWLYcig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A64AC4CEEF;
	Thu, 17 Apr 2025 18:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744916202;
	bh=m/buiRNBct8EcbaaXt3pRxAwTZbWgz5v2c8LsFp42vQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EJWLYciggfaIQ85/fxqWAgvL8liIbRlFQX4bm9GVqjV6x97cCJMduWbFeiivxFjeZ
	 mSXg5mt0oOuOmbnELxROQff34gwJt+DBjHrCZLE+eWtfsHZ4GFAWcProLd1mH1vPoi
	 N6QwsVDr3u4QCR2eEsdtjD0VKyqC/GmZXd5jsxmM94JxSoQ44eeQH8Ow2fuQShXBs5
	 aeLIfeZVq8VZ8c8u0X+j7Tao/xqoO2MTbom9zl7xIrpjvb5DjOgf7H3AiUGCc8XKxC
	 aAzp82SGFTi+QDcdtJjfx53uYUBWpfNfi+MmGxqD6QSuDMRScDiv45MeZUQFceKO0u
	 rIgdAdO5zN18w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7148B380AAEB;
	Thu, 17 Apr 2025 18:57:21 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.15-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <87sem7ujfk.wl-tiwai@suse.de>
References: <87sem7ujfk.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87sem7ujfk.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.15-rc3
X-PR-Tracked-Commit-Id: 7338856257fc6ee0a06dddf1f0888f3cfc95dc60
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8176e776cb52d7f9747994941f25ffa89d2a40a6
Message-Id: <174491624009.4184086.2413868708793585651.pr-tracker-bot@kernel.org>
Date: Thu, 17 Apr 2025 18:57:20 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 17 Apr 2025 13:16:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.15-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8176e776cb52d7f9747994941f25ffa89d2a40a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

