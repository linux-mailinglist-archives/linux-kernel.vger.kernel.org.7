Return-Path: <linux-kernel+bounces-815304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D258B56264
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 19:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0B2169DDE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 17:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0504F212557;
	Sat, 13 Sep 2025 17:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tex6OuFW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F3F20E704
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757785808; cv=none; b=UZ0UGiEWb61V+uTRi6GD6H2eFSZVNNd667LAb/vkTZP4HUt7v8N5Sx1PM6mYZLSn0aQiZWWFjyYvs9r5xrGPfzgw7BgotMh10h5VvXo3h3oPYH3ZTTVMrZWc9JS34eQ1UORvgoaW7V+uq9h+pfrq3pGl6ZlAiCBAvqy4Gnep7Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757785808; c=relaxed/simple;
	bh=45dVBOufjuKLN4bSGLbcL0nAKXFytLEvHqsdwx28Sj0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Z+QKlMR+7UD4Jx8wFd+RU2c3qWQxXxULVWs7fWj7UWqVdj72vTxuITmVEnC9RoksPEzQ4q8obX9PpFceoKRb5Z03qxsbd+r2Sq4h6i/w3PYYYmsv3FLuYA28QoUOlcbQeSu/pubiJKs1rKEF3oh6C2EatjFQeLiLTPqbAZ4QYLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tex6OuFW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB55EC4CEEB;
	Sat, 13 Sep 2025 17:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757785807;
	bh=45dVBOufjuKLN4bSGLbcL0nAKXFytLEvHqsdwx28Sj0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tex6OuFWV2m/p8wTNZFfRxahDiQ9nuGC7lyUtNtqgdggCBgERUmN4pgoBhyBFLI+U
	 xPI22e/SLf9smuvZLEVP/N+FnKVJwbo8NDr13K2i42RazuUYUPLQkM9qiC/+g2usWw
	 TkUkgVOTgHViQFuC1aOe/p+PSjORdxXQEPfty58M3Hh13ItCSh1q8qFsBKwGfCmLBN
	 FJ5nwCFRQdaJyBKQAwAnWsDjFGTNjrPVfGaJrYt4xzZ4U9mw9o8WbMfT1Pm9JGxwwW
	 3gD3OsC+kA3uY11gBSgyotztsUNNdsHwV+loGkUFURO+wV3ObrsOicIWMZ2ni1agmN
	 tKq0x23Kthp7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D76383BF4E;
	Sat, 13 Sep 2025 17:50:11 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.17-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <9b157e1eae10b302d050b76d9483f548@kernel.org>
References: <9b157e1eae10b302d050b76d9483f548@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <9b157e1eae10b302d050b76d9483f548@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.17-rc5
X-PR-Tracked-Commit-Id: c05d0b32eebadc8be6e53196e99c64cf2bed1d99
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 395d68e5dd63745a424b1b3bdee095b500c7cf83
Message-Id: <175778580986.3289187.16258053234506398561.pr-tracker-bot@kernel.org>
Date: Sat, 13 Sep 2025 17:50:09 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 13 Sep 2025 13:25:19 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.17-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/395d68e5dd63745a424b1b3bdee095b500c7cf83

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

