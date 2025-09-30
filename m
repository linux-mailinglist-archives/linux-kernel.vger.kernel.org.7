Return-Path: <linux-kernel+bounces-838166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D97F8BAE961
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 23:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7DBA2A0EF2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 21:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9194829C328;
	Tue, 30 Sep 2025 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bw/xg3cb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93CB29BD89
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 21:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759266195; cv=none; b=b2dXL4ZRd7h+WmYKwA5GLP4kFx1L70nmSVeAxAF4BNd8qrhwKwMpAZye5uJXDgFJ3rXzXUFtulNYB5P5ExxrQiO+VRZmXyGYnlgSdM8HSRg5eS+J39acs1c4M2U+7OWpTq1ShlIYGS/IR6cEz7jtCKJb6sB3kiw9/kAGTN+/GiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759266195; c=relaxed/simple;
	bh=pcbYXJJmoY1iTRSrUC7EGLgW/WNxnbuHuj8gX5OwXgc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TVr9RBohwTbM/K+BiXTPOJV8Vy/uzg+gRA10dufFBPUbjscJ1r93QzJTVX8oB5rni4/D8HhEl8RIcDp/Bebk82QFoV0icO2Hn+eUn67KNSx+sCMmE0bHlTyhdW881cgV0FOkIV3CULTfb1dk+R4moaocBDclMCqh8GM9DDX8YzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bw/xg3cb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A25C113CF;
	Tue, 30 Sep 2025 21:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759266195;
	bh=pcbYXJJmoY1iTRSrUC7EGLgW/WNxnbuHuj8gX5OwXgc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Bw/xg3cbCQoV9gyB5xF7j0oaxQURyiqC87vLy6GVYo0E8K4gBxY8nYwockdHDDzBY
	 EIK0zV2A+TlFwFfrWDSmhf7BWcKUHIlpgFCXKSevLOm0H8Ix8BdqfHuqFvyikoZ7aA
	 Q5/pIpCjr+i1jX7VDAAEbSEvQuSJM7bWbVKkyyt9170CfF8Mmby7hujc0t5DHmkk0B
	 R3wKu5A8cvs+QIOzTSK3HIdAXRMzwLVNjFoe1jGn0F3A6eEuKGjUYMQee8C0tADbhU
	 66ljfHaU0GnsYgcpp+M9EKKd5uuSVcZXqdCCVOWmjDq37HsSoF7bwbzKrh8wKMZhNS
	 TIBfKUPBPJWXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C3039D0C1A;
	Tue, 30 Sep 2025 21:03:09 +0000 (UTC)
Subject: Re: [GIT PULL] x86/microcode for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250926100708.GAaNZlzKcAZilZHRZb@fat_crate.local>
References: <20250926100708.GAaNZlzKcAZilZHRZb@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250926100708.GAaNZlzKcAZilZHRZb@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_microcode_for_v6.18_rc1
X-PR-Tracked-Commit-Id: 43181a47263dd9f2bee0afd688a841b09f9b7d12
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bd91417a962db247d41a22720a79e68a509a9353
Message-Id: <175926618836.2146267.14452105178635703962.pr-tracker-bot@kernel.org>
Date: Tue, 30 Sep 2025 21:03:08 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 12:07:08 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_microcode_for_v6.18_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bd91417a962db247d41a22720a79e68a509a9353

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

