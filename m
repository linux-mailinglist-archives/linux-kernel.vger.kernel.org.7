Return-Path: <linux-kernel+bounces-815715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D57AB56A4A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 17:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA9377AEA4C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5DF2D9ED8;
	Sun, 14 Sep 2025 15:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlB/Jzmu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D542D9EF3
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 15:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757864598; cv=none; b=CwIp1T1eYJejcDZdiQBWuOKqvI/3L32lvKzW+Mf6VfOGN01gN24rvJUDj73yugipEhgM6zqFTQMv8DDdDdeso44cvB+2Xj4+k0i/XX1+1Omd1gArGuJv/fNPNZAdJi55Vqa+e36YieSUR1b/RrDf9dpYcmmDOMtwAsoiugRn8xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757864598; c=relaxed/simple;
	bh=xJyCs5GHrf6GD2etKdgA65xXOVaKhhsyDyP064okJ0c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=izSz4kZjtidmHrMHojFC+N+lXr+V83MyaB3rx4IZBZi4Bdy965ZuI5zDyc8NK8bdmLNiMHvHqkw6XB7qV68u0zKmkJXW3ffjhlsGBBL0Q2fCOzecAvrBVKuqFd720aft3ktF8VpBxZF/SZ2SQkv76ZF0zZhkDv6SiT9lC7Xtqq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlB/Jzmu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E36C4CEF0;
	Sun, 14 Sep 2025 15:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757864597;
	bh=xJyCs5GHrf6GD2etKdgA65xXOVaKhhsyDyP064okJ0c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PlB/JzmuedhaYtM8gtU2hMsXgzhq0RVISRc5DaBOduvBSUBR19WgF4x667iN+/Sb0
	 1I+Us7rOvMcw6HyiJAGAAPJC7Z/y3kSsdmCTSXkDuW3WSXhyDiZIjcb0FDh9MG7Hed
	 i6gecUhUQMje/ccOdadnwBeF3GLIwt/5rCUK/hXA8Sh/oSK+8kQmCtcyc5jTvf5L8b
	 m/SCvUabqJ4jSDWvzKAANB6imZhIKGT8AxEubxiIWVFBYqqL8IcG+53NVJCjWJRK3A
	 qZaXT7cag6Qiu3iQkDzQTXGToSSaTJDKKErxx6X3qYA2Ky64V2ypo/TejUzGaQPi8e
	 uJVFSEifEhmmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD4139B167D;
	Sun, 14 Sep 2025 15:43:20 +0000 (UTC)
Subject: Re: [GIT PULL] timer subsystem fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <aMaMIUc95ZNXEtbN@gmail.com>
References: <aMaMIUc95ZNXEtbN@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aMaMIUc95ZNXEtbN@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2025-09-14
X-PR-Tracked-Commit-Id: e895f8e29119c8c966ea794af9e9100b10becb88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8378c891726df0ec78dfcd94160c9b1b428e9f4d
Message-Id: <175786459932.3496327.738575804015223007.pr-tracker-bot@kernel.org>
Date: Sun, 14 Sep 2025 15:43:19 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 14 Sep 2025 11:34:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2025-09-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8378c891726df0ec78dfcd94160c9b1b428e9f4d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

