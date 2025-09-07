Return-Path: <linux-kernel+bounces-804721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AD0B47C0C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 17:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB1FF7B0EBF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 15:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04F2280023;
	Sun,  7 Sep 2025 15:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raYtqypm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2D727FD48
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757259142; cv=none; b=SnsRns7tfYA9x8Azg7/LiBeLaNqHPoot9R1tO2vt1joOkN1sDIFOmXwqe1X6gQUyT3dLq8ZlDyJdb7fYInnFJuTOVnkfXJ0OAMp1bKZ4GEEvKUxcRtg2i536a3oPbctIKfJ/3CS/sSqv4FTFyyGTWYTAEwOfTQr0hMTjc2cJVek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757259142; c=relaxed/simple;
	bh=wi50tV0WKtx6EP86EoqBPhHgeYzDfW4IUpPWgst56/I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IlFJsxvMuMQRFWowRBlPzA0PCx3kDy2UNrvvxckq5NHlZCWB6KYqe6fRcYQ1fOo0J/OXpA0k9GhRWx6ciIE5PS7y76WWRIwXSm7AWrRqxFU4YWEgFSfqT9gWvnP38yZn/0APLIr+G/CXZ1kZzvE6GT2rPKxnR2SADm6CDmfdIBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=raYtqypm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30C8C4CEFA;
	Sun,  7 Sep 2025 15:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757259141;
	bh=wi50tV0WKtx6EP86EoqBPhHgeYzDfW4IUpPWgst56/I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=raYtqypmnHtnm/J5sXQMAOu9kiMeu6gClVHMS5VQnU0hUb93Pvu3EP/SbPRw9KJuI
	 TQp1sDNhVwRpdD73xDVPfZcK5PiUjBiokubcCS4VP5AxxuWWbD5WNe1EaX1v4ckjVt
	 skCOimHEftTUD+oZpqAL9naYsyTPv+8E2JFMxTPsjhZIOjFyH2S9vgdlwlxZ6lsK5T
	 Aql66dPvOsxHjQK3HlXKsO0/SEpdFyCrfqGGKngcXyJxV4jTRJQKn7cWQzVSW/m75K
	 85kNA8RlpygvWQbxZEPb0LD9QZgOSkZbdvP2cBVV7XoHWO9eLQgyuF6BxymsO/RxaG
	 NDOiCf6JvA1JA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD1C383BF69;
	Sun,  7 Sep 2025 15:32:26 +0000 (UTC)
Subject: Re: [GIT PULL] locking fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <aL1bjoRQEfRZ4-Gn@gmail.com>
References: <aL1bjoRQEfRZ4-Gn@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aL1bjoRQEfRZ4-Gn@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2025-09-07
X-PR-Tracked-Commit-Id: d9b05321e21e4b218de4ce8a590bf375f58b6346
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7369eb7319d0cb94ad2ea5b5486e276339c595a
Message-Id: <175725914560.3081192.2411213026816251627.pr-tracker-bot@kernel.org>
Date: Sun, 07 Sep 2025 15:32:25 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, Borislav Petkov <bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 7 Sep 2025 12:16:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2025-09-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7369eb7319d0cb94ad2ea5b5486e276339c595a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

