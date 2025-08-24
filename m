Return-Path: <linux-kernel+bounces-783661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6632DB33059
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 16:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5CE189D206
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 14:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5952DE71A;
	Sun, 24 Aug 2025 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKrFk+Xi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4527B2DE6FB
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756045150; cv=none; b=MePbgs6LzzG2d+PEz4GUleW8uFWE82L+AI6eds7F9pEdIDM1+h7PoWfh5HhSkqszwa/kRukFtAPyLQzbfcaQWjBKP82LEmp+iRpYESo5ciVTafFBa9wcUBiYSbCeA/LU7/7gMHBHb4TpTCVH69FjcrJK1ycGfZ8Jjl4CjpHzCNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756045150; c=relaxed/simple;
	bh=5s+iTcjp7GmjqWZPaIZmcaY7/suY3rsHqjoQfymm8gM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pLl+fxvDzm7jYcyP+miZ18jjyNn95iWd9pK+/+KUOH9qJYsnisMcMrIhjQ+l9d5T/WFiQYUwUbyKAw741Kj1J2Hxu/69x/ATm5r3gQPSCh7/U3zTLfEJ/0nWoVIoBBKO1UG7i13F3qcE+wzpiWo/5AkgwI/4La1Y3GW/kxPDqsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKrFk+Xi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCAB1C4CEEB;
	Sun, 24 Aug 2025 14:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756045149;
	bh=5s+iTcjp7GmjqWZPaIZmcaY7/suY3rsHqjoQfymm8gM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UKrFk+XiiaDinnkk81JksD0Du7ok4hUo/yYLIYLk5rWJTqhc8ZnsNnKnQC5fl86f7
	 uJUmuAK1H3W3HncYZAr5TRVvSw+cfo/2C5yE0TmLPyA9uEigh++HPs01yAxJug/dFV
	 1T1wsf7LvlDGzu0f/N0JyOEg4pZJFMqBYAiPX+47+IBmrVq71VVmbC21/YQ+aSHnyH
	 3XGNVbNKruUVDVUl4MMHZUASM8jEyK9/kiCYZNN5znPjWu+OA+Jlqh0b0CdT9nMeix
	 d77Xbj0vlMAk32VgX/9//z9wW7PiOTDxpUz8m0DxRMQgWoodNBD2MTJ5wYTEyjHXpN
	 dvAaKYHL0f1rQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C2C383BF69;
	Sun, 24 Aug 2025 14:19:19 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for v6.17-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250824100158.GAaKrjFoDe38nh-ZWl@fat_crate.local>
References: <20250824100158.GAaKrjFoDe38nh-ZWl@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250824100158.GAaKrjFoDe38nh-ZWl@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/perf_urgent_for_v6.17_rc3
X-PR-Tracked-Commit-Id: b64fdd422a85025b5e91ead794db9d3ef970e369
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69fd6b99b8f85eaa5d784e4840e982ca59c04250
Message-Id: <175604515806.2399738.10410756778775250689.pr-tracker-bot@kernel.org>
Date: Sun, 24 Aug 2025 14:19:18 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 24 Aug 2025 12:01:58 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/perf_urgent_for_v6.17_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69fd6b99b8f85eaa5d784e4840e982ca59c04250

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

