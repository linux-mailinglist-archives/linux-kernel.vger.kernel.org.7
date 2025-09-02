Return-Path: <linux-kernel+bounces-797303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15365B40E9F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD83D1B283B6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083882E8B6D;
	Tue,  2 Sep 2025 20:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEaAHdK3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629FA2E88B2;
	Tue,  2 Sep 2025 20:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756845760; cv=none; b=kJ9gWDH6JYU0XrPitps7McCFrTmEMu/AjzD6q+CN273W61k2sJizG4fkoJPciV9V56FrZZ83FdWfvxGs7t2lIL4rDoWf1p/Hir6DHaKQ8rime2bIu2cHoLLwXjKGTNd2ahOgrBJtwjHBHKEC0hxH+H41JQG/Cx1ay6S4pt+hpf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756845760; c=relaxed/simple;
	bh=zucjBploaPGcnua1dO4WuewunYBQkTen9myrR38kunc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=noMBW3WIIV5P5EUDK4UINzpixj8B4P2+I0fXcfty6P00SjQDIB0WerW1teHPv0En8Lzuw3TVcIrVmwU3Tw9ulYw08Q8q1S3uqPuPyVj/eBjYucjOi1fkfqXgRdnqw10+k9HGUfIVmoySx+Tq+wa+YgzLLyJjHyGTdRWyQw493dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEaAHdK3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F101C4CEED;
	Tue,  2 Sep 2025 20:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756845760;
	bh=zucjBploaPGcnua1dO4WuewunYBQkTen9myrR38kunc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fEaAHdK37Ct1G6WM57ozHUM5iCRq6BtmU/k7SgZMd8E4p+pNU1Q5I2qTnif82KTIt
	 5ctycZLODbd1etCKeFGWTHOJwXnat9YqZs12LGkf6CNCho7mHWMNQEmyrf317JIUMz
	 UtdV+Nc7HmACs/O2V3ZaN9n+lbO8ofvgsjiSpFxhH+567/AAQbPLaZbvSywU7AJ9JC
	 +53cLAWRxv+wBFhyKPX7bhsxrgKwGzBQnpS7y3WB7bjj9dlu38ahDcWzYf7ZTWXS4L
	 1eidDAb/+ubhbPD7sJZFGvew1sKWbUVm9t8QHvQuGLuRYe/JKumTJbUBYTythKLnSw
	 WIIpJm+ANtRwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0D8383BF64;
	Tue,  2 Sep 2025 20:42:46 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.17-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <87frd59om8.wl-tiwai@suse.de>
References: <87frd59om8.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87frd59om8.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.17-rc5
X-PR-Tracked-Commit-Id: bcd6659d4911c528381531472a0cefbd4003e29e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e6b9dce0aeeb91dfc0974ab87f02454e24566182
Message-Id: <175684576559.430647.5565117352084936824.pr-tracker-bot@kernel.org>
Date: Tue, 02 Sep 2025 20:42:45 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 02 Sep 2025 11:42:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.17-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e6b9dce0aeeb91dfc0974ab87f02454e24566182

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

