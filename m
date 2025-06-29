Return-Path: <linux-kernel+bounces-708003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5A3AECAA3
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jun 2025 00:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C309176AE4
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jun 2025 22:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542442222D5;
	Sat, 28 Jun 2025 22:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvC5fYkN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC6B1E412A;
	Sat, 28 Jun 2025 22:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751149971; cv=none; b=YAuY+9AsR46/or4owtQpUx3pfd3M58huvXTCyiDygVvrrn8RGd2bZ5jGDXj2fF7XwaRydDtjRQp0C7+8gt1yHtcoj0sdG/jIreb7Xi8nFd0u2U4t/GFUref2jBfyQml+eV8ITjakzn8bKdrBladZizNpXfqVX2WL6Evf5sAFce0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751149971; c=relaxed/simple;
	bh=fpSMjm2wgb5UEIUUZEQYk9gUF74b3O7NgC6qk/G0jeE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OxNv9WCJUiyj/kLNOKlLxU/p9b9obHPx6k4XtiTuLu+ts7My7Uvw9Od/4plvjvcbeWIBZWTPzccXuN+OWy+vKgWmZEL3w1UCWpvurx9hV4j6lOHwM2P/NcRNBMLlAZm8P9eatGkr1TUvbQd7Ak1TnMOE5EoO1dRR1mUrH7d1rdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvC5fYkN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443CEC4CEEF;
	Sat, 28 Jun 2025 22:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751149971;
	bh=fpSMjm2wgb5UEIUUZEQYk9gUF74b3O7NgC6qk/G0jeE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FvC5fYkNKQFB5TIoydI6UE8kmcsR7YwDtDYFnQh2AEhbfK1KkbYpE5Z+L44p4ORCv
	 qgTsQ3ttF5R/JKSoQETOnPm0t53yGFyoFues8P5HpvhyOSfGUcGdU2aPFWQm7CAzYB
	 SGOuBX/23IcQyH3HQ8lyZZaFB0T7Yrd9mrE6qcr8p0stSlHnZ9Yfp9CGXbFAXQpMWS
	 rSzVPkhZ/mWbYmXTS3unM1f72YddW5Mb6FHp5gxVZ/k3h/z+fgEus1IHbxvbcNbVqz
	 Z7cqGoHNe9Sk1d46TkTadWOFjtvPr74SlnosQLKo40JCsxz2IifkXKmDbFdOnmHmBl
	 defWW/dI4ZyYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E6C38111CE;
	Sat, 28 Jun 2025 22:33:18 +0000 (UTC)
Subject: Re: [PULL REQUEST] i2c-for-6.16-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <aGA8hmxiZJcIIqOI@shikoro>
References: <aGA8hmxiZJcIIqOI@shikoro>
X-PR-Tracked-List-Id: <linux-i2c.vger.kernel.org>
X-PR-Tracked-Message-Id: <aGA8hmxiZJcIIqOI@shikoro>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-6.16-rc4
X-PR-Tracked-Commit-Id: f40213cd93e608ee78b5e25db042c42ec07139fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dfba48a70cb68888efb494c9642502efe73614ed
Message-Id: <175114999690.2300750.7932215321518837504.pr-tracker-bot@kernel.org>
Date: Sat, 28 Jun 2025 22:33:16 +0000
To: Wolfram Sang <wsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 28 Jun 2025 21:03:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-6.16-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dfba48a70cb68888efb494c9642502efe73614ed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

