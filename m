Return-Path: <linux-kernel+bounces-838164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD285BAE957
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 23:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB36B1945791
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 21:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F1F29992A;
	Tue, 30 Sep 2025 21:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5NjWDs7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAF328DB52
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 21:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759266193; cv=none; b=Ie13a3GqjIzfGvPLhphAkEDPsuH5g8pWC7QlGwA/rEHbG6ltW2sgyvYxW9t/td1C35gR5fRXAdjqsPajl7baQMQF/9Tt3CzHV3XZbSeX6CiPqf5VmbeogeWUhA0Rd/GQGWNl7v9y67+Is7xTjmCJEgYB6teaW5Zc0N9lrwJPHjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759266193; c=relaxed/simple;
	bh=aoNpOyw0eMQCl6Yf2FVPYNZIe1PCQkw3JuMxe8jZ480=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uC/M9rEE3XjOHzOuXcbb/InhgjoeevBxs42B4pRIRc/dGE2d6fLt6eQtMQOHyk+4ikQ0D4suM/4c4t7OVqjUw5cfZ2+2M6wSeU4XosHD82QyQhLAZZZncNhQpyZvGYwwGuWZ8dnq5HD7rrSOnJC3zB79V2hCUZHRqzj/PH6jjUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5NjWDs7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784F7C4CEF7;
	Tue, 30 Sep 2025 21:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759266192;
	bh=aoNpOyw0eMQCl6Yf2FVPYNZIe1PCQkw3JuMxe8jZ480=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=W5NjWDs7tdQ6+9I/5R69vhZ7E+t9QqMoheQByn9e7Dl2qyvJX4dlQAMRqgmzKJFiP
	 5j0eDAwzcfYIzoKJLazvi3SpWMqLoiXY1URyXVJbEI91OficEeAKhX5gBvzUmnNIJB
	 qgFoNLXlN0tqLsg4HCIKrFZGeuy/9rMdVDlr/NLPaq1wSnrh4AFzpKLsZGRPgQIEix
	 oSP8hb/iixs4j8wtiLqHkM1C6a5NfLGcw6dVZCJXvSrFkg5x1aAhUhQeWITEsd1hq3
	 xzSIcPjqmpLsiySs8PX3kE5w+uFFz/kx8wpKDl0p7iCA/Z829yOtQ546hF9cYje0av
	 l0jON6xiz8cMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFF839D0C1A;
	Tue, 30 Sep 2025 21:03:06 +0000 (UTC)
Subject: Re: [GIT PULL] x86/misc for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250926100355.GAaNZlC6-pchBQ5opr@fat_crate.local>
References: <20250926100355.GAaNZlC6-pchBQ5opr@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250926100355.GAaNZlC6-pchBQ5opr@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_misc_for_v6.18_rc1
X-PR-Tracked-Commit-Id: 26178b713f2b3f5bc411ed8316d1635615896111
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 98afd4dd3dd385623e8e7c88394e352b0fbf0c3f
Message-Id: <175926618531.2146267.1568382521826871472.pr-tracker-bot@kernel.org>
Date: Tue, 30 Sep 2025 21:03:05 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 12:03:55 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_misc_for_v6.18_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/98afd4dd3dd385623e8e7c88394e352b0fbf0c3f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

