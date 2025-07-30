Return-Path: <linux-kernel+bounces-750045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4132AB15664
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 02:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 562A717A121
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 00:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4474672618;
	Wed, 30 Jul 2025 00:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rI7C6RKv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06F53594F
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 00:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753835036; cv=none; b=PJOaNYQ8ln01mxEB5cpMs0iqQFNGPltCSTp/smd3M8vV/FrfQfU8beJ1TFNdP4qlNnqbnQwuoh93zbnVZ8AIha2qKPww8RGWDwEuO8UsVgZcvz4bQjqrTO7lYmHNFlMb9qWv5wQ75rNPMmhXKwXm7QP51XoQ824ku4d297Nqg5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753835036; c=relaxed/simple;
	bh=XaDiRi1dmBYUi1AHKIUFkhzZvjrGd83hujx4jnCSjSc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WJPnBAKIPgkzSrdxpF6PXIf5wL1ABkBO5NF310MJy0PuOx0JFVkDF9Oi7GKT0Wn4niH1jZzwLqCMPseffBoyluuoCXKruWKLxtagNppBeq69N0MMeNl3n0xWc7iAL96ZCRK88fzVHiKrSSB47D63SHATKhjYnkxL2KhWSrRrJKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rI7C6RKv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80782C4CEEF;
	Wed, 30 Jul 2025 00:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753835036;
	bh=XaDiRi1dmBYUi1AHKIUFkhzZvjrGd83hujx4jnCSjSc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rI7C6RKvBo2mxcxq3jG6klJP121YNCXNv5F4EeVd6Z/9pF7qwObL03FXBvJSHr7S9
	 ttfVBt+NbideRV3W9jMaCSTMC+oGjblCE506OP91UVJTiOdeBmtYkY88T48sxPmJSX
	 gHb5Cd3tqxO4XYpgggIWa+QMao1ApzHPjru42wINV2KVak0J8UoILfx8FOKRvcWyDt
	 UKZLPlC7mhewEngx7LqMmXupC6vGP3QJZNZ7jDzjcQUzRl2EJvCt6dSxoOsGGe7wFF
	 b43E2kTYCrFl3S11caE1ZmwTFBfPkDEUS3yazybBADNDx5VbQNwQsn909IEV0oCkKD
	 6KE+drDyuIzAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC3D383BF5F;
	Wed, 30 Jul 2025 00:24:13 +0000 (UTC)
Subject: Re: [GIT PULL] x86/sev for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250728200416.GAaIfXwC7ZYKF70_Qg@fat_crate.local>
References: <20250728200416.GAaIfXwC7ZYKF70_Qg@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250728200416.GAaIfXwC7ZYKF70_Qg@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_sev_for_v6.17_rc1
X-PR-Tracked-Commit-Id: a7549636f67f973474ebe1ad262acc2aa4d1327d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 14bed9bc81bae64db98349319f367bfc7dab0afd
Message-Id: <175383505255.1700147.14432729147005676916.pr-tracker-bot@kernel.org>
Date: Wed, 30 Jul 2025 00:24:12 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 22:04:16 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_sev_for_v6.17_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/14bed9bc81bae64db98349319f367bfc7dab0afd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

