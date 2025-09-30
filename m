Return-Path: <linux-kernel+bounces-838165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB39BAE95A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 23:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FF513C8909
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 21:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA3128DEE9;
	Tue, 30 Sep 2025 21:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+CXPAX0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0D129A301
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 21:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759266194; cv=none; b=QwjFhb8SbJTVRyYB9yzvpO2v1uFf23+AAt+lPl+g7DlYGHNfNFEwe37TRdAdtygYS6IHbMqizAc5FuzOWcUSJBBwZedsyaWcmfF3J1X4IPHAhymtvQ6+otKXR15eP239759h8+OtxW2mG+x7FNmADfFa5kcS3nS4jCTUVvpCkpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759266194; c=relaxed/simple;
	bh=YG2+zypRu5+LlJnq4qdtfsmp//J9QgelElsu4ZYHxF0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sDO/buIHOYh6mBlXBN/Rgip3RY56SBx0+ZLXHSC4fb6ZVMhS4pImcCCDSgM4Lxac15b+EshEaDfjtsqBKq6FH/n5AGD/jOx6koc0n63inLN7Fz/XBKGhR6Cf1hT8x3+GDIX+yRVW2bu2kiZAEnPRyaTJ1dSRwkoUM/MblVSDMcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+CXPAX0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1D5C4CEF0;
	Tue, 30 Sep 2025 21:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759266194;
	bh=YG2+zypRu5+LlJnq4qdtfsmp//J9QgelElsu4ZYHxF0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=A+CXPAX0ShDpcvdez5v2c+640qhz5n2g16mpbX+cBwz32DuHGmGy7M41xCy+sBWVR
	 BzNG6Aq7CVmRmQ+dVvWVaypMA5cLoaphK/GRFw1SNCV6LXmZWOT7OUmmiWMXMkOHgi
	 0yAjaQRJVukhS3aS4CJgrLslE37s1FBVrmSmYzhvuKjwzeTXBI4p4VjBh4dw3OENGG
	 4jKTYd7qe9f+7FQhkVoplnohMb9eUBTQtqxnfqQJF8ubkj6ZNHDnFkYG8wA1HtYFaF
	 yYokipazzEvTW2Tl3eDiJmShC4idN+PvF2kh0Dw2q7odXcmn+nJHArMtnucvtOhUq4
	 wYBayxcY+Mjaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2847E39D0C1A;
	Tue, 30 Sep 2025 21:03:08 +0000 (UTC)
Subject: Re: [GIT PULL] x86/asm for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250926100534.GAaNZlbuntdGwY0wN4@fat_crate.local>
References: <20250926100534.GAaNZlbuntdGwY0wN4@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250926100534.GAaNZlbuntdGwY0wN4@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_asm_for_v6.18_rc1
X-PR-Tracked-Commit-Id: ac9c408ed19d535289ca59200dd6a44a6a2d6036
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 45d96dd2c62899ff8a3f07e3b8109656062b457a
Message-Id: <175926618693.2146267.9806015231983541926.pr-tracker-bot@kernel.org>
Date: Tue, 30 Sep 2025 21:03:06 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 12:05:34 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_asm_for_v6.18_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/45d96dd2c62899ff8a3f07e3b8109656062b457a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

