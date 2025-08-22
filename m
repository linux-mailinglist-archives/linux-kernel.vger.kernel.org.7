Return-Path: <linux-kernel+bounces-782117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB31EB31B51
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CAE6188E00B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7C330AAAE;
	Fri, 22 Aug 2025 14:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExVPncOw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D91305E2B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 14:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872306; cv=none; b=avDTvM8S5CBg7X7cOYFTzlsXIZvf2rheynAQzZOWzA0X8G8RLS397N8MH5w5RhO85iMDa26JNyo77hZxG4DvvEYSD3kn2tdxryUL1P5NZkw5XGBDv2Ry0xpWYhJWYPh+85N0FJHItCri+80XfNFpUMSBijXslHZAiu0ekjeFDzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872306; c=relaxed/simple;
	bh=51H1/jHD1FhvKptbLUJ+brGLjZRcIz43JeCgl1rlEeQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qj5IfxEkNXIf7fcCIINUH1aLkh33tPHgbLKtuFI0PRZTLScZN7i7IDhK9I8WoSMIZJrxb877lbizCwXfH73GW56vkXWJI8n0b25v9Sv24irBTB7j6oJC1vNDcGlWcnx4x+UI2VQbpO6uq82oG9bXZ6Qh0Zs/Kmi71LQ8YpugFvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExVPncOw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD717C4CEED;
	Fri, 22 Aug 2025 14:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755872305;
	bh=51H1/jHD1FhvKptbLUJ+brGLjZRcIz43JeCgl1rlEeQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ExVPncOwhxOl3C8OmTjywTbB9OyfoO3Zx0auZcR7jFgIKSpWZMaLpzhNqKG+DX7q/
	 +KRJ70Oo2dcE0fwzlfDepei8m+IUtdBcJf+LeXfhZOEA6LmmDTP0PaG/JfoSGukZfe
	 IWAQyBN6oyhaeFqoCPYKXiRwQMpFTDPZ3TUUgxn/PGtOGf1CTi080ZiCxvOetY8z8H
	 u3lCxOvH1BR9e17s5/PqeDUcCJOFJnuWS09aTo4xoDRBjehe+SiQa9xWHTxyOuz7jf
	 +Q1hXpkMYv08Hf1HHHTFupDA6Mrbp8h9hTrgC6oEpOck4lAniDLwzDqt2459plbHeF
	 qyX6Pu+02S2ig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB8FB383BF6A;
	Fri, 22 Aug 2025 14:18:35 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.17-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250822053120.31771-1-jgross@suse.com>
References: <20250822053120.31771-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250822053120.31771-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.17-rc3-tag
X-PR-Tracked-Commit-Id: efdaa61d73a1deb066ccc3b4d56257cc63ab5be9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b3d80535e213ad6584577b0f20d9d49ccf233206
Message-Id: <175587231445.1847242.18002459943633296858.pr-tracker-bot@kernel.org>
Date: Fri, 22 Aug 2025 14:18:34 +0000
To: Juergen Gross <jgross@suse.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, sstabellini@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Aug 2025 07:31:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.17-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b3d80535e213ad6584577b0f20d9d49ccf233206

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

