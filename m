Return-Path: <linux-kernel+bounces-760973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0431EB1F25D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BBF47B0187
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A708F14D70E;
	Sat,  9 Aug 2025 05:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBe1WlWt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E42275AFA
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 05:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754718328; cv=none; b=MT+A7hK/SNBx+VQKR+5Tq5ZdN2+0v64ThjF6rXncRQ93EuYq+W3ZCg1dQUCpeeqU7d+T1G9oJfMfduIGvMBIwyOBnqz0diWMOuvpIqbCv07IMj0q4okm8Nxh+M9rc4QNjMj+5j/mEtGekyiEFb59nxCijCwVamznSjOu+g9VulI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754718328; c=relaxed/simple;
	bh=YbsUvVNSocOcxKUL3elwbU8FMrXqDiCgaH86KXDHoVo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kYAkc0PXxLe5HMKVHMn7sjRu3boXJfqHDVjTJblmN4BwWj5dP4H/4ZKYgxvWce9LZuINLNIMcamB3fh0/4fPIIL18boCci2wpb9XEF5ZZ9qj98PiN80kN1Y1RmqfQg0p0EiWnCbUKfnPu5ALzURemJGpRsKub5121xkQBJ8ckxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBe1WlWt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00E8C4CEF4;
	Sat,  9 Aug 2025 05:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754718327;
	bh=YbsUvVNSocOcxKUL3elwbU8FMrXqDiCgaH86KXDHoVo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hBe1WlWtNgch3oVJIzQJFGGAxL8hE73krwuJLiQwXiA8CN231+Bd0YJX9OeSNGmpY
	 xChJ9Uxf3a8q2nczRSLy0caQYb5bb/ZUrzNqzYN0RDba5F3GW56v+HZxQky4UJY9GK
	 Y7vmgu9SpjTdWNaUlWYxYEZ8ZbuqDOQJM8SXZlKkqW20Er7GCfSTvEAIe/la20Spjs
	 VbjLyDiOoM03CiLAaTksgaW9WrrR22hyYITwRmGTpVuLGatcH9ZADtcuDLs5sTQ3Q/
	 OnNqcpj9yuny5gK7vi/yw9EGbcPQdEU/F9CxaLJxcciy23i3FLI1n5G9xUaU5fnMi3
	 GfPXwpNCAr4ig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A66383BF5A;
	Sat,  9 Aug 2025 05:45:42 +0000 (UTC)
Subject: Re: [GIT PULL] regmap fixes for v6.17-merge-window
From: pr-tracker-bot@kernel.org
In-Reply-To: <ab85dca88a780d53a88965c6700d08bf.broonie@kernel.org>
References: <ab85dca88a780d53a88965c6700d08bf.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ab85dca88a780d53a88965c6700d08bf.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.17-merge-window
X-PR-Tracked-Commit-Id: 76b6e14aa7b081337d118a82397d919b5e072bb4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 21a1f198273806a20ef0c3c89721617c7dd76ece
Message-Id: <175471834082.387690.10290815989585551739.pr-tracker-bot@kernel.org>
Date: Sat, 09 Aug 2025 05:45:40 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 08 Aug 2025 18:01:50 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.17-merge-window

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/21a1f198273806a20ef0c3c89721617c7dd76ece

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

