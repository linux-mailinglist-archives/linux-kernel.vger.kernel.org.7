Return-Path: <linux-kernel+bounces-870475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 860D5C0AE5C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 18:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D16E3B4DEE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 17:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A359A2EE617;
	Sun, 26 Oct 2025 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GH3s2QDP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C29525DAF0
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 17:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761498052; cv=none; b=kC6vjKvlFbQAxR1AKUHIhuN/mbKJh4B/UMqEmJYeJEbNUNlOiljuN9VMseSldQVHCPX9ho/eABsW6nFIE10Pow28AVKtckUbp7Nfc4anO4/BWJoHkEZO+5WtT9Wax/TBsoC2E3fgyUpfEgHGERJMUpLm2BysTU3zF0digKTT/hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761498052; c=relaxed/simple;
	bh=VbUbT9TR79VaMrItyXL4Uj6uWS7Ug5tW2yg5dLOG19Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=APIkrqX/uZLj2gXBk2H4Ahi33zxs+UjvJubkN8yiLdZp5CZwvCaJRtfxUtKycf72IcvQFp9g8hcs2mJ4fnHxMFIEgynWiEARlf4+f2pDhqc2JwInR7qn9/3SS6LqfkTEURvDGlYTgNzaKjSj9pFHZVwFjxtS5BWdyPnUyhCYEi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GH3s2QDP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A201DC4CEFB;
	Sun, 26 Oct 2025 17:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761498051;
	bh=VbUbT9TR79VaMrItyXL4Uj6uWS7Ug5tW2yg5dLOG19Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GH3s2QDPNiJqn2rh50KXozFc5zdoS8EVBQAJfdQp74ZMlcqH+1e8as9qUKKx190fm
	 1c351s1rVoSOv1ELOLRrEVQ+HC8IFq8ILggUzTdlTs06rlSma7PFjkwNAAYgoHFgQ/
	 ioTJ0Z7iwrtm4DiOiYaRhQeuGjVKV3U+6zAqfK0Ef5cI4x6SEnZgwkDwP528Cj5qhK
	 yUyhV0s/M3lPmKXyJ6wA6CVvrdsZlMQ8SNJQQ1gDrmCWbofOmoQcfmqdX8vyFneSq4
	 DOOudiIqT7Q0C/c2w9S4BtVgXkAjD/u4UzUdVBZRbwtDvl9PVb/zwdmAnigRmvNweP
	 WBF5jTfUPgfsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEF0B380AA7E;
	Sun, 26 Oct 2025 17:00:31 +0000 (UTC)
Subject: Re: [GIT PULL] irq/urgent for v6.18-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251026122535.GAaP4TP1aPktqUyeu4@fat_crate.local>
References: <20251026122535.GAaP4TP1aPktqUyeu4@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251026122535.GAaP4TP1aPktqUyeu4@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.18_rc3
X-PR-Tracked-Commit-Id: ef3330b99c01bda53f2a189b58bed8f6b7397f28
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5fee0dafba0a5223fa1c1f0dd99af71256449d38
Message-Id: <176149803025.292745.9262868478619771273.pr-tracker-bot@kernel.org>
Date: Sun, 26 Oct 2025 17:00:30 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 26 Oct 2025 13:25:35 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.18_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5fee0dafba0a5223fa1c1f0dd99af71256449d38

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

