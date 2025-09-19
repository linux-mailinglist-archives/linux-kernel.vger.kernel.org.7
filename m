Return-Path: <linux-kernel+bounces-825344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89422B8B9EB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 01:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C9EB1CC2A9E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 23:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90892D2485;
	Fri, 19 Sep 2025 23:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fF087Zcj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D77B2AD24;
	Fri, 19 Sep 2025 23:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758323664; cv=none; b=ulN6YK7Q4dVq83XWCQXkZKMKQlaUlHU8Uhbdocsd5G+vqLRvWrN7/uHYBytCKWC5QlX26EYHmVewGKY8CaWmI909Bf7CdAz5Q4893QxbMOcLTq5lgvgfdTiG69RgmvHAJuEM+dmAKNkQ/JS8/SLn9HEcoQh2abOPeJ+mLrNfOQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758323664; c=relaxed/simple;
	bh=itTTgSsa5I+ezL0P267yKOOOztqAf7Bx/7T/s6IKDPY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mV0fkUd+CIx8n9wWlh4TADnQ9cpPkK6qOFyCl9/wVh1kIO4JanMgAx7XDajctxLj7zMlzrMe+t55NfEVYEKK5jy8qEaCEarYt0C85nNzQ1RShD64gtSbcJIALwHnNEGDSEL0buAEW77WQORlJqPbXgwYCl8JGc6WhHwf+pQT2GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fF087Zcj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED243C4CEF0;
	Fri, 19 Sep 2025 23:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758323664;
	bh=itTTgSsa5I+ezL0P267yKOOOztqAf7Bx/7T/s6IKDPY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fF087Zcjxf9aQW58KAVVpmvXnrA9hZDa3LF/XZQhDupDqZWQQPhG7eG1YuucR/UCA
	 9DmSATG1OuZen/lsRuOQlppSjruTAvgeQpM7vmXYiDQLrGZxuJZ3VwogGGzqyp1Hhq
	 6sllEeTU3vp68P/NPqbOYl2zVCjYZPkEsDOwulzUeEg3bJwm1bzs1NSvmLXd0GT8mE
	 cjxOqU4eaCshe/pn1iJXvWK1AqYkuKZAQfMINJmeRqp7P8BfgHtwx1lKNcfJwuOwR5
	 yXyYE2Abu/tSMOzsVVxr22oXS7Xcvxkcp9JR71jzCxQKOHzsBg+S/3g1Km/0vS1tRe
	 7E2v3GhQiwfLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E8A39D0C20;
	Fri, 19 Sep 2025 23:14:24 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.17-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <kx4extvxjpt5z6gwvqdl5a7aqvscnjtrphyok3iiswgcm3dptg@n2tmevnllyx7>
References: <kx4extvxjpt5z6gwvqdl5a7aqvscnjtrphyok3iiswgcm3dptg@n2tmevnllyx7>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <kx4extvxjpt5z6gwvqdl5a7aqvscnjtrphyok3iiswgcm3dptg@n2tmevnllyx7>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.17-rc6
X-PR-Tracked-Commit-Id: 1e56310b40fd2e7e0b9493da9ff488af145bdd0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 497b9a7b8df955fffd612d0d4aaf315b03556b10
Message-Id: <175832366307.3732828.16837656304588472965.pr-tracker-bot@kernel.org>
Date: Fri, 19 Sep 2025 23:14:23 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Sep 2025 16:29:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.17-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/497b9a7b8df955fffd612d0d4aaf315b03556b10

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

