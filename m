Return-Path: <linux-kernel+bounces-737286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C067B0AA4E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4B005A1569
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149B02E88AB;
	Fri, 18 Jul 2025 18:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JByAkJtU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F902E8887;
	Fri, 18 Jul 2025 18:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752864583; cv=none; b=kjoCeF4raQ9ZhDtdjf4wFQKwhZeDAIowledK2eUeve55G0W0M0thyOdFNSEnoo5IKi8JAA2WS2nn3WeFJ3Y8ShAEuLPiSzqPldDtzQHIRc2/5r2eHz06HXgockG8RnzHckyBfmEGhBcQd2aSuLzlbIUDDPwy+ADRSqptGq87Cr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752864583; c=relaxed/simple;
	bh=/Xhfz2Rd2tJgiS7j44pYegGzQgIIq/8czxlvF5xr+bE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=L3Zj/OamPql0PpQyT1I42/6zmmsB9+ULnLoXkkj2EdTf8TX1U70OVQ05i0stC/7cT04GECfiT0y940jNZBSea3tpm9AYGG8rmjSbhkE8/uzdWRuO48REonwFo3JaTbXKUS3aIcf2GDBI8Y8vf4KTzpCkf7UOl3qtm1b1jZmExJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JByAkJtU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402CAC4CEED;
	Fri, 18 Jul 2025 18:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752864583;
	bh=/Xhfz2Rd2tJgiS7j44pYegGzQgIIq/8czxlvF5xr+bE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JByAkJtU+b8N2HHU6PUvbFBdy42xev4BNnuL+Z/V0+Swr5bMC2zt7KXYdizDfRunT
	 tBcSE49kjulA9btkc1WlQ4afQMhKrVsYnbKu3B0PJXDXSHolD83L7IyY/nwN/+jUam
	 FhHDjJrJKDNzALZy7VUv6rSFPC4JDUAs/ZWjQV8sea0NL/7e22PV/tk5px0k6jx+GR
	 Dyt45T3my2MykBkSKKtCICwSIDAlaoae8mcUu8l4E4vPq6qBbRhyHt4HkAWXxBvTh8
	 yio1ps7Iext2E08vK04BPxaWqrhicsT75g9btippV5wpNc3GvYZcI6a1VBFoOyWZ/7
	 yb+ltbf1UREkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EEF383BA3C;
	Fri, 18 Jul 2025 18:50:04 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.16-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <87seit7koj.wl-tiwai@suse.de>
References: <87seit7koj.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-sound.vger.kernel.org>
X-PR-Tracked-Message-Id: <87seit7koj.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.16-rc7
X-PR-Tracked-Commit-Id: 348954f9b78e1515777708b6764c88f225457c40
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f0afb7bd4374fdb30da8bf6cd74528bba131bd88
Message-Id: <175286460297.2758519.4936447466544430202.pr-tracker-bot@kernel.org>
Date: Fri, 18 Jul 2025 18:50:02 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 18 Jul 2025 14:22:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.16-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f0afb7bd4374fdb30da8bf6cd74528bba131bd88

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

