Return-Path: <linux-kernel+bounces-772498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1464B29367
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 16:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4538048876E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 14:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6335929C32B;
	Sun, 17 Aug 2025 14:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTgmzJR+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69D229B790
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755439289; cv=none; b=Zlo8jWHcGXc9oC5X4fCb0N3JJ/otEcFlz8aMzEUrg6IB2MeJXxsF/Uco5uMtlpfztTijnSAEKfEtRdFH+KlR5P/OIwf7jzhZOX8pedkPiKkPyUhiMzGn70Fpv8jV1ThQMKdsHAQnfBVzNCY42vxqrxvnSqU9XxjYTaKNv1c9q2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755439289; c=relaxed/simple;
	bh=yqZeLpWwDOeuEWDapOmml9ffOitGgq9dVHDFFmcLcd8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oGOgOVz6x18+Vpnfai01X4u7WQvnPGjXoPcjHiqz5+rDC/HStDu34BByrOPsGPECXUMbf7WsTSZa2nKDZutKjj2vBpHb5ob0Lix5jvucj9n9pcHt2CrM+f3PI8wXi/DNgn6uBF8wjv0rCFB3TVsbfCuY6CU0nKWZ4ONl5RRb7rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTgmzJR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A12C19421;
	Sun, 17 Aug 2025 14:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755439289;
	bh=yqZeLpWwDOeuEWDapOmml9ffOitGgq9dVHDFFmcLcd8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gTgmzJR+Yr8Bo3keu7EOq3a7OGjHK3uezj3005Zu/54h8h0wFg1Ru61M2L9/UPbQ/
	 XgWagA8Kq0z8UDfYpnhfZUxaf+mzkP9E6drQRPCx6gKyeUj9+NMjTAdtiujKBc2pmn
	 Cc70pdEMmF4ffmN+PRj39VxJl8Beg4bOR9loEnwEACnMf85+ic+qbrZRu0udCt+ZQe
	 XZzXkyrjU98aRtW4FOoJV6E+gYqmHmlAM+g/ESEYHvRX9rJc4LDnE4IJWRBggeTyxJ
	 FaQm5Nfx6ysXAmug/rLnv73h6QNJ9+0cieS7dPAPlTr/LS1SSPSvN7n2zPKL/0nCx9
	 5szqEQ64KoF+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BDC39D0C3C;
	Sun, 17 Aug 2025 14:01:41 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.17-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250817085712.GAaKGZaP83Bp4ghNT7@fat_crate.local>
References: <20250817085712.GAaKGZaP83Bp4ghNT7@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250817085712.GAaKGZaP83Bp4ghNT7@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.17_rc2
X-PR-Tracked-Commit-Id: ed6c4b657bca3b39f7b11cba1405931aeb490f3d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d561baae505bab6b3f133e10dc48e27e4505cbe
Message-Id: <175543930000.1709731.7081373832145602464.pr-tracker-bot@kernel.org>
Date: Sun, 17 Aug 2025 14:01:40 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 17 Aug 2025 10:57:12 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.17_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d561baae505bab6b3f133e10dc48e27e4505cbe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

