Return-Path: <linux-kernel+bounces-849263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D209BCFAEE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 20:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F99440670E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 18:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB13283FE4;
	Sat, 11 Oct 2025 18:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJ0A6MQL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BA9283CB8
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 18:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760207964; cv=none; b=TwtfF6tsCwBkwUt+ER/4y0S861y7zLtr5oWRYg9tLrIM6WBRONFyGC4WnJJCy/s6/VbvfAFhqmVUKxcNbn4y4qY/C0r275r6YYxIfoAhVRcCOncAediFXGnWRbQflQydrNyxkF5Rz53mWGHupGy+YFs6bvrm3qYZgI4vHi9Yevo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760207964; c=relaxed/simple;
	bh=LIr4aKfH5OwlPSpIHNNf6+D28rB/g1zR3r8acmEGvdA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ihMtKg5DXGc02ECbihDNNE+BZVylV4dZB+BG0TAOtuLcS/A1ymNd3yVOoZD5Rl0TNNtxywYsnglItIIttH/RpJWJ08Zh3rs20aIxRkzf7jEft1VF25/kjDxkgCfJ+c1hCDHHnWrd+ZUu2ynzbkQBWfwdpMtNoL0Xe4msjeDhJJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJ0A6MQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C94C4CEF4;
	Sat, 11 Oct 2025 18:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760207964;
	bh=LIr4aKfH5OwlPSpIHNNf6+D28rB/g1zR3r8acmEGvdA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qJ0A6MQL5rfotu0AwGJC9BRS70Jtsth0yaGpZCrVdCQICBrAkV5+t48TJmIjwxoFL
	 3bn8h7QFV5KHpkKiwhm0p3am3d8HFVnZ0tati0MBdFjkMoCEDFEHo0UQ1i04VTQW33
	 BqlcLUf/EKehssmexH8eWYtg7ZC+XJSZ7JvwxM3+SxAwwsJhXD0bqKaM6bX0Ize4Ay
	 4vawLcu7AxzyASoKVQb8qDar/mjCabd2lsxkZRq5MSj9mfn6jOYLPCKPulwmvRW4El
	 bHl/jha9/5aVNTOaS652bRhPAl/2/Tsok2l0F335O3nO35gDGBLd7mn6mP/1kYsXjg
	 BI3w3e0nUVSIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEF373809A18;
	Sat, 11 Oct 2025 18:39:12 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cleanups for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251011114609.GAaOpDgd6_shSYsg1s@fat_crate.local>
References: <20251011114609.GAaOpDgd6_shSYsg1s@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251011114609.GAaOpDgd6_shSYsg1s@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_cleanups_for_v6.18_rc1
X-PR-Tracked-Commit-Id: c6c973dbfa5e34b1572bcd1852adcad1b5d08fab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f0a7504530c24f55daec7d2364d933bb1a1fa68
Message-Id: <176020795143.1422231.4754607382722174682.pr-tracker-bot@kernel.org>
Date: Sat, 11 Oct 2025 18:39:11 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 11 Oct 2025 13:46:09 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_cleanups_for_v6.18_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f0a7504530c24f55daec7d2364d933bb1a1fa68

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

