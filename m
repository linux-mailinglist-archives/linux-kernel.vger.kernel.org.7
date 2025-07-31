Return-Path: <linux-kernel+bounces-752462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A99D7B175D2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 19:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C33587A5B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D2B2980DB;
	Thu, 31 Jul 2025 17:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyn2h2kJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4E728E607
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 17:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753984455; cv=none; b=g0PukJGfNduoZmwUMzMZwKE5K5JhPxQdtO64a5BgmrvXCKqAiBFrTGMFSo2LgwZdTfJuq2QkkuJqB91EUWtD3cnPE2heodBRVZ58JNyqtbWLJ8vajQwhd17qM0oQ5fDz1PtzaqKJtt22OniVKOYDDi5PD6srGH+0m57MfqvpvoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753984455; c=relaxed/simple;
	bh=LUXFIDwCk4Q5JcQ2wMwBg2ZA5aGbL01KnpHmo6j+ps8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BUm8niElwKjvvpNCUYPrsEgle6p/GWR4v/qkh3JoShJbub4UO771fKuJhsqv9VgMt9ApN17KMLX5uBFeowf+WmMg3GIHm8qO4NL1rIfx5bO5dYZaJ6DBg7JRHigM2IUcsXvJCvThyk/3I96WQyNYPSzQKrF7ugLXOsivVE3jaEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyn2h2kJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD8FC4CEEF;
	Thu, 31 Jul 2025 17:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753984455;
	bh=LUXFIDwCk4Q5JcQ2wMwBg2ZA5aGbL01KnpHmo6j+ps8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pyn2h2kJ6sY0urM3kyazLKJ1nVW9Ak/z8rVxqmDgBB0BtYw1QfHuxPwashMr2KZiK
	 A+ZTgQtVqEpGc7LPoEscnL4UHkJyGOyQQZpjoc6/AUYUiksbKO5u71gRNA1Xl331WB
	 mrKLdrMzlUjcfJ/GmMYN18IAQXb9+YY31UvYzy4DFOcfrxG48m8ll5s5as9twacQif
	 bh+oycXwfUrcxAbftCz8bfKKUEC/kbo1oiC/Rb7UkwxpD4eF5qaP891VC0WQ4TQXx5
	 /s+DK1Yt7QbzNmgubyoVfPdthFHQe2NoAVZnv9ncPq44cnpuJTq8WLoqhoQLQB49wo
	 9gXN1JOjMdo0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCCF383BF51;
	Thu, 31 Jul 2025 17:54:32 +0000 (UTC)
Subject: Re: [GIT PULL] UBI and UBIFS changes for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <7787490.DFzTOozpa1@nailgun>
References: <7787490.DFzTOozpa1@nailgun>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <7787490.DFzTOozpa1@nailgun>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/ubifs-for-linus-6.17-rc1
X-PR-Tracked-Commit-Id: 99dbb2a1bd661418be33b1ff1462c09b7d2221cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4522ae2def5a8ed155642f947131726e427d2f05
Message-Id: <175398447128.3232013.6131617014280004374.pr-tracker-bot@kernel.org>
Date: Thu, 31 Jul 2025 17:54:31 +0000
To: Richard Weinberger <richard@sigma-star.at>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mtd <linux-mtd@lists.infradead.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 29 Jul 2025 22:10:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/ubifs-for-linus-6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4522ae2def5a8ed155642f947131726e427d2f05

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

