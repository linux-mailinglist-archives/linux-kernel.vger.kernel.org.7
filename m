Return-Path: <linux-kernel+bounces-838173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDC6BAE978
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 23:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4C407AB625
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 21:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338082C0F64;
	Tue, 30 Sep 2025 21:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mddp14ga"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAD32C08C8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 21:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759266207; cv=none; b=N9O7NYg8qTCDvfrqQk2V1DpXHISW4n20+UIFdMMoGNbGflsnea2JlE7HWJA8Jd0HHDuY7/yCaC8CRLaSHweWZ+zkBA6K4vEHS7tNsM7Vpa7Wg7e+SIbHMrwm45wNMo0Ft2rClBwaf0EOSruZmkmJ1ubHvjWLnxptZ20/DTwFpPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759266207; c=relaxed/simple;
	bh=xpyqz06eeWouOMQvhuN7IymGa+ZNeccZyWDENIj3i94=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WVmE1YtNzFGZrU2g7WPIgnamxD56RHSU248BUHC73zwZvnD11R2OSuc4vlnloR00OyjfXWX28R0WCFJS2DFCDWEXnL2++wSQylOctGgU8C+wP1TI7KJTh1/oxSRVSbKkR/beEP/k7Hwdgayi0pQao4h61m0j7zJZcNnHeWQBtBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mddp14ga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC41BC4CEF0;
	Tue, 30 Sep 2025 21:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759266207;
	bh=xpyqz06eeWouOMQvhuN7IymGa+ZNeccZyWDENIj3i94=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Mddp14gaipj5yxetIrLzbe81QlHNNJxEd6A4ZzkTU0LdCon/ee1otnQTJ5EmSfPp5
	 fSQv+F73FwjiXX6KwtYVokadFH4bwo87C1jBRw/PRwyUEkrQqY2XseJz1+iZwS0+KC
	 202V/HbwmRh5srJPIjxNLP5bp2nb7nDLliU9FNJLKW/OX/mLqL2zGkx2pWZE0eBaZN
	 PvOx8zmBLwSCr/SyMiYF2Ex9moGAYnQCgCKhEmIxvCIo0QnO1FgI/M69SRmNXmhJjZ
	 tI62uOIobRQ17NFjINtg13pRKZ3buriw06kEQSRE+EblVWXSjhahclC5nGiY3U8jMi
	 PW3qsb43/zwSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E1639D0C1A;
	Tue, 30 Sep 2025 21:03:21 +0000 (UTC)
Subject: Re: [GIT PULL] locking changes for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <aNanBZ9VbIO2CO9x@gmail.com>
References: <aNanBZ9VbIO2CO9x@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aNanBZ9VbIO2CO9x@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2025-09-26
X-PR-Tracked-Commit-Id: 17d9f8eaa87d40a2ff66598875a43363e37a909b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 88b489385bfe3713497a63c0dcf4dd7852cf4568
Message-Id: <175926619973.2146267.7616366740159199718.pr-tracker-bot@kernel.org>
Date: Tue, 30 Sep 2025 21:03:19 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Borislav Petkov <bp@alien8.de>, Uros Bizjak <ubizjak@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Gary Guo <gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 16:45:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2025-09-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/88b489385bfe3713497a63c0dcf4dd7852cf4568

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

