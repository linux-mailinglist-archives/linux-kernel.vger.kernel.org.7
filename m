Return-Path: <linux-kernel+bounces-881459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B83C9C28407
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 18:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB1DC4EC7FF
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 17:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C6E2FB621;
	Sat,  1 Nov 2025 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cepqgz9x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDE32C0286
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762018934; cv=none; b=oOdw/s/NTrJZi6a9hRJylHUPp0KWuCry0K24bRZ7953ROaavloL2XMqiJc6YFyk/5EAorQKsLhzktE/PRikztRWoCpzdhUBnke1FBE5W9b5ywCTGdtMEZ8WpaOyVTOAKcT4HLI4UUptQjnYvqVHHrxp/G4iwpyNVjk7E4wUPhCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762018934; c=relaxed/simple;
	bh=oAHWrcNCz9PHPn663tS+yG0TB3rHVDiRaRGGFIxrVhg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=vBH8OACN7h8rR5CtzpDznUkA4e26gg8vkfYTtaPwR1o+x6ruejU7f1g6KJ6sqfzaY00xj21fnfMl8RzL99CCyyCDWCTgv94/zXZfupxLO6uL96EnG5dfZxIw9+rOXP1V5UfBfR6oJ23zgG4JWtITXxPFILKmT+OL1RWKxX6e/0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cepqgz9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE80C4CEFB;
	Sat,  1 Nov 2025 17:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762018933;
	bh=oAHWrcNCz9PHPn663tS+yG0TB3rHVDiRaRGGFIxrVhg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cepqgz9xXXtSdl5SNOy4vr72n+BipYIaE0x8bBnkl7JalN27MYmkl4Tn0fNRZFpbX
	 RZZIerx/HFO/sGePm70vou254wpR/sX9kdR7ALTdbUaAcvrbf4DqAfJEQvVCCdihzD
	 5UWY0LQrAUi8gLnWXnICt3u3NGQcHMgymEjusX8eaZnCTNAUKw5wx6S4YXLWRWbCyO
	 PO7E5mBGuDVjoCh8xXFL05fg+q/s6Zitumwds+5hLu7cASotKMkRz8KVlCMA1UVuSZ
	 4MOLYpozJ9uhGKHprCKXrJxSZyJo/Ol6qIN97XWmxk0aFFQ2SmGaHLSYPeGlXp1kcB
	 xElHsK6YsgCGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD303809A1B;
	Sat,  1 Nov 2025 17:41:50 +0000 (UTC)
Subject: Re: [GIT PULL] objtool fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <aQWx2XlYJY-pnVLj@gmail.com>
References: <aQWx2XlYJY-pnVLj@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aQWx2XlYJY-pnVLj@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2025-11-01
X-PR-Tracked-Commit-Id: c44b4b9eeb71f5b0b617abf6fd66d1ef0aab6200
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 74131a0f1b9efc1364871a04b704e54309861668
Message-Id: <176201890928.850663.6832094923698248800.pr-tracker-bot@kernel.org>
Date: Sat, 01 Nov 2025 17:41:49 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 1 Nov 2025 08:08:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2025-11-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/74131a0f1b9efc1364871a04b704e54309861668

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

