Return-Path: <linux-kernel+bounces-898507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B09FC556F3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E02B94E2467
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DA82F7ADA;
	Thu, 13 Nov 2025 02:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+We9sjK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C7F29ACD7;
	Thu, 13 Nov 2025 02:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763000785; cv=none; b=Y7UbH5K5Amd7KnNGjJ38x3T+fPc3G6yj4TP+cyv9eyK1yRWmBksyw0pzbJz7IEhOZCarH5FPL5R4VTv28XP7qy+vrBOX14FTbDNpyaZ7RfwS1pItqPXcXdsyUuoauN+2IhFdEAD5Ewr2yI//a0Qppb1fNxIFMmoSorDxR7ZSq78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763000785; c=relaxed/simple;
	bh=bdXfhQgWRb677bqWZDywXWlCLBOEo8qXQTl3xsm9yXU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ONOqCRIyOtfW3uPrAQ6E75LatarDj+F8wWVcCbdaaHpR9/67ae5pMd7KZ3U/+6oiisfgiwSVzPclKF9WnIY6ueScO00kUpHwPG69L0ZCrAarZOi29mEFeFHlnGM0Ky393of2GhXmVNYoc37/NOEP0ajQ68Pp815HCjOxCsRwiO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+We9sjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05320C113D0;
	Thu, 13 Nov 2025 02:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763000785;
	bh=bdXfhQgWRb677bqWZDywXWlCLBOEo8qXQTl3xsm9yXU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=l+We9sjK4eGJUeuYdpYr0vHgVuUXEc9PP7BEnIQRBPEF5FNDazSLHLGka+C+N1b06
	 rqbYNV62LP6vbCP03q3ta4NTywGx/Zv9dRKvT0HgddBA+uLghXxGITxkc6xgNYD8Up
	 3N8FMJfn1qEQcoft2I1nl9jGsHDjhfO0p2K2dNznDG8l71PCOg7deJv7ptb0OfEZji
	 RbcDe1HtzZQWbOTzZfo+uLF72SFCSXAnrSFH0cJ0KRhbpA2mdw8Rk4BqWMLI5ywGcK
	 3eJmrckgaU5Hytp0pncpr4MRaCXnnh83zmuNxbY8ndip1TWHJOeJCqT61pzQwTXP4f
	 gfv1STu6TgL0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0403A40FD1;
	Thu, 13 Nov 2025 02:25:55 +0000 (UTC)
Subject: Re: [PULL] alpha.git
From: pr-tracker-bot@kernel.org
In-Reply-To: <4qsa6oyacdik7neohp67y3vvqu2wczxcuqr4bulxuxksga7zf6@6obnf7yg4ccy>
References: <4qsa6oyacdik7neohp67y3vvqu2wczxcuqr4bulxuxksga7zf6@6obnf7yg4ccy>
X-PR-Tracked-List-Id: <linux-alpha.vger.kernel.org>
X-PR-Tracked-Message-Id: <4qsa6oyacdik7neohp67y3vvqu2wczxcuqr4bulxuxksga7zf6@6obnf7yg4ccy>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git tags/alpha-fixes-v6.18-rc5
X-PR-Tracked-Commit-Id: d58041d2c63e09a1c9083e0e9f4151e487c4e16a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 89ee862a4dd30c3f00e1aedbca5ce0d8bc3c1ddc
Message-Id: <176300075414.287829.7735156543828241632.pr-tracker-bot@kernel.org>
Date: Thu, 13 Nov 2025 02:25:54 +0000
To: Matt Turner <mattst88@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, Magnus Lindholm <linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 12 Nov 2025 15:11:41 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git tags/alpha-fixes-v6.18-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/89ee862a4dd30c3f00e1aedbca5ce0d8bc3c1ddc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

