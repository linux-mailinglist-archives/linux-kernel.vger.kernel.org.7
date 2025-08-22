Return-Path: <linux-kernel+bounces-782024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89100B31A0B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BAAB6422C1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D796313530;
	Fri, 22 Aug 2025 13:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHf1Kz+7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC438302740;
	Fri, 22 Aug 2025 13:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869792; cv=none; b=hg8vobAokRQndQoLhU8RhoPn0p0wCwNmGQb+MBwgvG7J/fU4pr6y8Drpqsj5v8NS938/FAl68AKRU6VANlatGG5nd5Mwrk6KwPTr+5Z/Bskb6zod+tblXK3a50LE+8GKUeCYBNAMYcm5e1Q1v6xPMZnsz0JWfd3nDMj4Vl6tNIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869792; c=relaxed/simple;
	bh=2aXaRlCM0dYCbBOA3ceuHsdzfzROl3sJ3cjHu2v8CXs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kZv/UO1K1wmtVOrSNf3Q8hDCWNRjgKQU93F7j8uRDbiZBcN25kH2/dDGQOsZC0xtKUzvtrgFlWXEB4yhEuW/l+/H3eYyz7ybatbD52Jb91ZllVC2M5qHYYzcU4swbI+WbdyfEnZu8TThZjp7VIMhbsAcfUw3TruCsXqV85too/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHf1Kz+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67F7C4CEED;
	Fri, 22 Aug 2025 13:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755869792;
	bh=2aXaRlCM0dYCbBOA3ceuHsdzfzROl3sJ3cjHu2v8CXs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jHf1Kz+7s9XDvbc7NuRm36Se32JeZZYZytFl6Sp2erKLO3Cglmsx53cOpe5ra8tBe
	 041p7lp0tjR3XEkLVxBTHGQ6FErl38sr1Y1cYq2198HxlFagihQ5hIlok3VzsiSwLG
	 NsQgQZZrRTQq1VjfVURmEmuHRpcB5/dnthsXV5p8Ez2de3cfvUOQ1aoY0e+MiI/JSP
	 HCFSfyHAfSAXNOGmxqNJizWMNR29mIfayhbSEr+68C0MVn19/P7ovIm2tw1FrGKZJv
	 Xtx0jPkIj5XDgbEQ/+peqtxCGz3UZVmJKM8K0Of6FqlbBQqc2TuZ9Mare+L/6r283q
	 WP6PGqNO2xqkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF44383BF6A;
	Fri, 22 Aug 2025 13:36:42 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.17-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <87ms7r4p6l.wl-tiwai@suse.de>
References: <87ms7r4p6l.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-sound.vger.kernel.org>
X-PR-Tracked-Message-Id: <87ms7r4p6l.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.17-rc3
X-PR-Tracked-Commit-Id: 8410fe81093ff231e964891e215b624dabb734b0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f28ad47b6692241bf85db82beaf24783b926a4d5
Message-Id: <175586980145.1831455.9579191611292810909.pr-tracker-bot@kernel.org>
Date: Fri, 22 Aug 2025 13:36:41 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Aug 2025 12:37:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.17-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f28ad47b6692241bf85db82beaf24783b926a4d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

