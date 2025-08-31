Return-Path: <linux-kernel+bounces-793513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42852B3D47D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 18:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C666B17802F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 16:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935602737F6;
	Sun, 31 Aug 2025 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDSu61VJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F292F270EDF
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756659074; cv=none; b=VK+VWtGdc0n9hVTCrHnOAjWDIyCvKhn6peES20+3KfIRyHN9idh2xGo/BIsIC3yTce+hgZWLADb11y2PpPjNShnaEpOkC0fO0+fYQLIjk5vIYxTuQ3OSICwPNe/nnp/JKGIsqesAecmXt8Sn9Zfzi1auznWterBcfORG9h61pJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756659074; c=relaxed/simple;
	bh=w5yf5ystfnpN36FoySe17mcIPhVfRT58JzSlV3KD6qM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=p3C7bPBU+NGc3MKf1xMJjoaJKEmMZU90vkPCshcVyW2i3lBY/sqtYH4Ril+MhGXgXH/cPI657BenWp00wnzAWiiWx4RqOhCWrfs0XOh9DHpcIrINhXO2lJniWYjPpdADVAPa+IJzHTx63PoGwG3MEXD/VasB+4Gdw2MGeA+Dm6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDSu61VJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B658C4CEF8;
	Sun, 31 Aug 2025 16:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756659073;
	bh=w5yf5ystfnpN36FoySe17mcIPhVfRT58JzSlV3KD6qM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bDSu61VJYb936+jkBLqx1n5x/NqDsv3FfFMg8uH9DJOn0NXxT3x9pv6m03OAqAKgN
	 JC+dDv/OUZM9hCQFAWUYWkKeOryw0knrM6ACvwWFY2cISu2APty1RbAXlx2exgctH2
	 1ZOZ5KyPpnNrnyI7zMlY9N3T2hLwHX/sFZr+pka4a0K/RrItLOpNxPCPSQ0RbDWfgi
	 72pAaGgr3MSIsL39bSg2zySnRJ5CsM6rg3gYG/KFiUntxvWNhgJdAMGykWQ8jQr987
	 sP+1i/dH+4PX3o8xnZSHOKIxoAHfbuRua4Nyda8/SBA1Bh5vJULK6r3pMsyqdrEiRC
	 0+l4H+04J/O6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD6E383BF4E;
	Sun, 31 Aug 2025 16:51:20 +0000 (UTC)
Subject: Re: [GIT PULL] sched/urgent for v6.17-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250831094701.GAaLQaFRBnUhtbH-Tw@fat_crate.local>
References: <20250831094701.GAaLQaFRBnUhtbH-Tw@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250831094701.GAaLQaFRBnUhtbH-Tw@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/sched_urgent_for_v6.17_rc4
X-PR-Tracked-Commit-Id: 52d15521eb75f9b521744db675bee61025d2fa52
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe3ad7a58b581859a1a7c237b670f8bcbf5b253c
Message-Id: <175665907958.2726201.6209086337573227438.pr-tracker-bot@kernel.org>
Date: Sun, 31 Aug 2025 16:51:19 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 31 Aug 2025 11:47:01 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/sched_urgent_for_v6.17_rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe3ad7a58b581859a1a7c237b670f8bcbf5b253c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

