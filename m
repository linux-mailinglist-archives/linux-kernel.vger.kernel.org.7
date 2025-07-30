Return-Path: <linux-kernel+bounces-750151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A06D0B157E8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 05:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B73E5562221
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 03:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5385B15AF6;
	Wed, 30 Jul 2025 03:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLrg5gUH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6001E5B90
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753846776; cv=none; b=MtEYYvSholq3ddFXfEAOGPBeW8hSbNLF2YzpGmlsXIOgaZ4BUIMpRD7tVZLzSCME8u62VJNSVhMzD2lik5faysrWS3AQulResX7d70gu1W1QURnBh1vLWVeTfB2vqm0pwEM6l7PTnzMQI/ekyhsfNAcY1fCIVQO8/sBPSADx2Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753846776; c=relaxed/simple;
	bh=k5X8CHEOlXY/8TTfmisKIionZ2auzaPgyupeypplfF8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sMBKp1NhdmhILWmaPQcZwyY0SQRJbjCjKMdcGjAIIwoVff4Xke+ziq+ATBOV4dMuMI+mT+aCXmBc7eZ5LrwAkb0RFQg55I3dzLiZBeDK/oxS1XmD5pn8OfhRAiElLVAcxy/lXUeLp5kUqA/Xxclfs00SAl3hfnf96Jh7e5uME8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLrg5gUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC40C4CEEB;
	Wed, 30 Jul 2025 03:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753846776;
	bh=k5X8CHEOlXY/8TTfmisKIionZ2auzaPgyupeypplfF8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fLrg5gUHBUCK/GzOyiSrFiv/jp54mRLcuk78gb7hCXvgjTy731Vjn2+tc0QyvOJAI
	 j0Jafkz+OU9Oeceyh9CRP6DOypHPthMenCXKYrZcE4WOnUAHVOtM7Z87C8i6/hrTjV
	 Rkha8brz7ldJa9IxDQCgKpwZu+jHtlEUqdN+mnYIyxJGkEvqti5h82TTkxtnOuR+Fa
	 pLfXbzOsgrD9xttT2G/cyf0NZOYp/O9k44TQ9wc8bGdctklXkTcdgK2pXBTtvGQO3P
	 YlTUYDj4224UaO/H+0wMz+ABF5te/MCJDg+2g9jyzoZQkbRVNrYpP11usRNtImMLQC
	 UJXVSsobVlnoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD22383BF5F;
	Wed, 30 Jul 2025 03:39:53 +0000 (UTC)
Subject: Re: [GIT PULL] locking changes for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <aIhvlNUoN5KyPzg6@gmail.com>
References: <aIhvlNUoN5KyPzg6@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aIhvlNUoN5KyPzg6@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2025-07-29
X-PR-Tracked-Commit-Id: ba28549bad8ab2b09264ebc8c2ca24af3537ee52
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 72b8944f147e151e845d976e7f48beff38967499
Message-Id: <175384679250.1749338.13858138467998407247.pr-tracker-bot@kernel.org>
Date: Wed, 30 Jul 2025 03:39:52 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Borislav Petkov <bp@alien8.de>, Uros Bizjak <ubizjak@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 29 Jul 2025 08:52:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2025-07-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/72b8944f147e151e845d976e7f48beff38967499

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

