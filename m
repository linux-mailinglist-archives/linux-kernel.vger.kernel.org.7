Return-Path: <linux-kernel+bounces-687003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D339DAD9ED7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jun 2025 20:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8ECF3B5956
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jun 2025 18:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AB219F42D;
	Sat, 14 Jun 2025 18:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evv4wWK1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE7D2E6D36;
	Sat, 14 Jun 2025 18:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749924620; cv=none; b=tHGRCwgsw35LYEw4viLzjCxI+DDyLNwEcrdAOFSdPZKjRc7smFS1S4AMpSX96BKvVrTob6fKjOkTZjClRi/86ZHmnw+bEWftWHDuT/CK9CumYhaNuJWNAswHuGrJrnphEGxnP2CMVBYrTnX/9huL4JYetDmyas/9YQ3Mu8K7vV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749924620; c=relaxed/simple;
	bh=IE8/Uli/qsBI9dvp1hGsfJ9TZoJWuUmzTTFmGM2UdtI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AU08jPWy6u3AxI0G8Pdf6wOElvmQU106BAYUiJ9ealIUOCodeiWSBiT4fyPtFbfRd/J0q7/QagKDar1JVFgZxyqz3cahi8Wce3bWvxfsc6pwYuF036Kf/mMM3RR479FkpNDocjrPTGuwXlsB1zZupck9hWQDqLHPTkW4sqgKmlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evv4wWK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6037FC4CEEB;
	Sat, 14 Jun 2025 18:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749924620;
	bh=IE8/Uli/qsBI9dvp1hGsfJ9TZoJWuUmzTTFmGM2UdtI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=evv4wWK1xuHbPt6pet7e0wsxvXKQABhaxABq8/sOsaXwv6a8cbUwWXJ2QTl1gN6dr
	 OCtP2DSTP5ee77s1w6mcueh7mz4lfz20QEx5boYhay7gPKi3BjF1oxeljMk/VjrixT
	 ilGCWXTvyHA+LmMq8XjPObF/NdYsLwbC2GPYJgbUTFMumJED6wtRSdwLsdcPcPN0e9
	 9/OK2lZ4wPpCsxXUxuAEJLyRBeMgTdVgDPPIjWJ9nw222WA2x4xg8L5fd37xkzRz0a
	 g30O3P53pAnQz2449SvwfyjGXf+5G8/g36nNw0Z+INgkqemutOB1E2bP9kh70SRf1p
	 g+Yn2RgOSuoSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0B8380AAD0;
	Sat, 14 Jun 2025 18:10:50 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 6.16-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250613215955.17731b1cd27ad5230f0962ca@linux-foundation.org>
References: <20250613215955.17731b1cd27ad5230f0962ca@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20250613215955.17731b1cd27ad5230f0962ca@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2025-06-13-21-56
X-PR-Tracked-Commit-Id: bb666b7c27073b986b75699e51a7102910f58060
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 27b9989b87119da2f33f2c0fcbb8984ab4ebdf1a
Message-Id: <174992464963.1140315.16929489980925009784.pr-tracker-bot@kernel.org>
Date: Sat, 14 Jun 2025 18:10:49 +0000
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, mm-commits@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Jun 2025 21:59:55 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2025-06-13-21-56

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/27b9989b87119da2f33f2c0fcbb8984ab4ebdf1a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

