Return-Path: <linux-kernel+bounces-760968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2CBB1F255
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D947728536
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6246127A10D;
	Sat,  9 Aug 2025 05:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ne5c5+Xr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81C1279DD0
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 05:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754716786; cv=none; b=BjMfPRh8E6HWxJRuFGpfrib9MTx/MatA7TAdtkyCz3bhB45LY+Cd8kMIcIWr9h6IgUTSUzESk95euOf4V4cueRJHWArId8amDUgDTUdn8mRMQGjNdgywmsfBR1CXh0ctsSqDM4GF4cIs1S7woZTxiiMWFdz/kLpTO1TWOOp4YU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754716786; c=relaxed/simple;
	bh=ZoxLJex1NapztESzEjU/HBpfMPwjmAab6zhJh2X/hag=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EuALwJjlHrsxX4tVF1wMu5IgVH+iw6G7jCpdloGRV2hNSVUaUig8iVhU9Jv1YpwRrnQKUON9CXQnPfmDV01rhL80hGVwMfarMYpUzLXseNlKHZl42VFngA74/rq0d9VikMQU2UFhNhsYpcpylsEzCzINKD0Jp3tGTlPq6DTeEtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ne5c5+Xr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C23CC4CEE7;
	Sat,  9 Aug 2025 05:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754716786;
	bh=ZoxLJex1NapztESzEjU/HBpfMPwjmAab6zhJh2X/hag=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ne5c5+Xr0JVS52FdHBXVoQ0q6qUfy6vG01xxiF3GR7creQoXWmXVAM3Wllcg8Wtxh
	 GATDJ7PNWIkF9wrCCyA61R87LwtZ4ASqfsacUML37ZpRvTqhWq1jYwvV7cIxsXp6UX
	 zclgnFALspt1qx5XS0asBBX5yPHUO3opGtoP3Vwmn7Ym3hKPIMQq6uI9azr5jEWSDL
	 Nrut7roNyHx1AvwA+nZxmTtVGRu379iJXaYPNoxjJ0Wg0n/IzpzFFzY2gobgWPeUqO
	 ylRYI6J5SWVm24X1klt++ApT25C5DQ2OUTlP9+32z9Df8dz2dYrRbfkGXkDw2n5AUh
	 4EUcpvwIOp6Nw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE1D383BF5A;
	Sat,  9 Aug 2025 05:20:00 +0000 (UTC)
Subject: Re: [PULL 0/2] xtensa updates for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250808114240.2720491-1-jcmvbkbc@gmail.com>
References: <20250808114240.2720491-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250808114240.2720491-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20250808
X-PR-Tracked-Commit-Id: 44a4ef59d5506c6dc7599d876a3a1014697ec480
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 09aae3ecf8f10c60e2ba43ee97f4d6364d8dd2fe
Message-Id: <175471679958.380510.9479724947010657581.pr-tracker-bot@kernel.org>
Date: Sat, 09 Aug 2025 05:19:59 +0000
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  8 Aug 2025 04:42:40 -0700:

> https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20250808

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/09aae3ecf8f10c60e2ba43ee97f4d6364d8dd2fe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

