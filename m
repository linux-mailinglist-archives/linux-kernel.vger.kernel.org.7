Return-Path: <linux-kernel+bounces-870473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC888C0AE53
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 18:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E4A54E84F9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 17:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01212DF14A;
	Sun, 26 Oct 2025 17:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfCMkM7G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA0D289367
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 17:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761498049; cv=none; b=OCAQgG0dUexsezVWYgjPqdh0V+fnwdpTl+Cl4Glq6KCES97kworCmIWicveoct7EAPTlup6qf7nLEsJIQqAVCIAmetsqQ2hN5cGP10rKrIr3XHRmMpBpPv6bEA7dIq8DhO51Mfho45MDWbedZeAwsHQloGDEkLPcxAwjUWKCWd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761498049; c=relaxed/simple;
	bh=gJqrNmozYF6Q2nZdDQYD0eiKrolCkQl+8Zk8o/YR7zk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CfT/tLrnOQu8rGAWxOH9KAGIB8QMA/5VwEnGkZQnsR2mZdtl4TY6llnKUUmaAz7LNYxLYmHIUwDL0+jwdQZQj28g6gslrth+iZRcs1taKk7CV2jIeCJEd51Xm8p0jmG3pOHwUpBWWRK0rFtdqpQGN2zmqIJcO19FiBXZZXII8uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfCMkM7G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50B0C4CEE7;
	Sun, 26 Oct 2025 17:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761498048;
	bh=gJqrNmozYF6Q2nZdDQYD0eiKrolCkQl+8Zk8o/YR7zk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DfCMkM7GiLxNA+TByt8TDMiW2yqReFzTOIep15bAupAXvU5MOZSZ7MNtAt+Yj1/KJ
	 Z4qNR/YGqONdymwGzgfihUa/Re8cwgnax1aajQoXjY6AgOF2kzWvHax2oYY9bkCJQl
	 hSm4AOe7HTiVKtx9gi+GVzP+QhdWVMColx24sF8ovM+g1Z4q9CiYuw+V2AO55KVZ9w
	 xhtoXNgG3rENLGFo2nWyzK/4UwPk/ZijnHJeQhYyEtQU2dAkpWNUYyDFzgVUwFy17i
	 RZS4QG4spxybTS5gKDAAL8DOkhpu6Kc4nEFSHFe18YCv6dj3VS8bUl4ZQwlpt4LWQS
	 4kvyxAF5pQmyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCAF380AA7E;
	Sun, 26 Oct 2025 17:00:28 +0000 (UTC)
Subject: Re: [GIT PULL] sched/urgent for v6.18-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251026114925.GAaP4KxfT1-DpmVBpp@fat_crate.local>
References: <20251026114925.GAaP4KxfT1-DpmVBpp@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251026114925.GAaP4KxfT1-DpmVBpp@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/sched_urgent_for_v6.18_rc3
X-PR-Tracked-Commit-Id: 0e4a169d1a2b630c607416d9e3739d80e176ed67
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1bc9743b6452cb5a4d09944bd3d6e33b074bb22d
Message-Id: <176149802725.292745.5190691869437496205.pr-tracker-bot@kernel.org>
Date: Sun, 26 Oct 2025 17:00:27 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 26 Oct 2025 12:49:25 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/sched_urgent_for_v6.18_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1bc9743b6452cb5a4d09944bd3d6e33b074bb22d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

