Return-Path: <linux-kernel+bounces-721953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A75AFCFED
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9005517F2AC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248872E2654;
	Tue,  8 Jul 2025 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcF3agZi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827E32E0B58;
	Tue,  8 Jul 2025 15:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990367; cv=none; b=qcGPh7eUL1M+zbzd3KcsSNFRdh/eb1POgySmqz5X/DCgeyzdQ2RGxm6qFnEXl+aLtIDTHjIsdfXreOZDl7DzwzSRahxxGf4FSJgs4FeNKf6/7enHqUL2UfXjwQ+R4iSzeEMnW5nCVB1qs+a23nmV3isofVlxZ4otkeieMes2VXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990367; c=relaxed/simple;
	bh=N34lnhiqy8ABKGsgqRX4jg55+TzDKW985TYW2VHj+Vc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Zdy3N32TMOX0nWb3oBKgG6SCQxMVOCwupgwWl78Yoe7lyHeDOqrl/U4tjprDiOlQkImsm2cGJsgVZkIEA77qh97FNz4dcXN7Dgc+qM8ZSyj8TzorURoJ3r85atCA5XZ2FItn8bNyvw1KRnyWKfqNcv9+m77XBy19yU6N0UK34YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcF3agZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA18C4CEED;
	Tue,  8 Jul 2025 15:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751990367;
	bh=N34lnhiqy8ABKGsgqRX4jg55+TzDKW985TYW2VHj+Vc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rcF3agZiPSCTONKUdD3oMAgub6sXfpo8ZCqi5yjyT5gmdQZB1Qxyka7qxhDYSVuY8
	 CIgHpuXFH0Wy2aSTlAjOcQ04j1JwBKMtfj46Gd7Mrs+whd1bZ2G+hZofQX9zay+JlB
	 p2oPsMbduMsjZXiqjhnocFC2q9zBuWdNRk1i2iM+6XveJHBmvDjhQFL+U385qr4hxb
	 Jhgl29fWmZBrjn3mLk9G1I7DnlAEaoVTw9t2R0LzhqKSst3OZPFA4iHa7M83uaBVjs
	 lYh4JY2Ix7L2Bwelo7RyuduEq1y8PwOtnHHb3xz5z7U0EpLR/hrFM/cH4ebGdvRy5Z
	 eyqraqBGnx4XA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7125D380DBEE;
	Tue,  8 Jul 2025 15:59:51 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.16-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <871pqq3j4z.wl-tiwai@suse.de>
References: <871pqq3j4z.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <871pqq3j4z.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.16-rc6
X-PR-Tracked-Commit-Id: d78f76457d70d30e80b5d2e067d45de7a0505fc0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d006330be3f782ff3fb7c3ed51e617e01f29a465
Message-Id: <175199038994.4117500.2166913626285404590.pr-tracker-bot@kernel.org>
Date: Tue, 08 Jul 2025 15:59:49 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 08 Jul 2025 15:30:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.16-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d006330be3f782ff3fb7c3ed51e617e01f29a465

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

