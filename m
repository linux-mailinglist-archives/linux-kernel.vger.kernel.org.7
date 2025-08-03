Return-Path: <linux-kernel+bounces-754545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A19D6B196BE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 00:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49F267A8971
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 22:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC881F2371;
	Sun,  3 Aug 2025 22:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVXNDXB8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D06A1C68F
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 22:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754260360; cv=none; b=qprK9NqmZBY89d0XZrfVGNKXWxr54Ho6UvkDTM3mXfqEtAxZ0801pTQ0ifx2c/3Hy91GMJK+cMwbC5jhYgmbbcQpmc3myeQQ+xGcQm2i1qTmfmGTfjuUhrfY8RgLhSVotqn49tfRjEU9gj16Va+L8KxkKSuUtmoq8Dvn5l1/nqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754260360; c=relaxed/simple;
	bh=f95Xi2YW6xYYBZA5ZINGymvkhUgWfbZtaaDPtbledTs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GpZ1USWkeA0UaYDkmzr4I5brBX5T0Ru/H7VjITtm794130WA6hDOlKmZynHJ8ejyyro8+2NQrhvxsRDUKFZ+IoZFyYyR1XoKDpgcYeYIf1WQ4gSw/tKpptmMpR1Imr+HntaAR47VqJ+22SjzFAbKlzktQCKZk5wuHzQR2zopZcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVXNDXB8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD47C4CEEB;
	Sun,  3 Aug 2025 22:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754260360;
	bh=f95Xi2YW6xYYBZA5ZINGymvkhUgWfbZtaaDPtbledTs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WVXNDXB8QsVT2EnRM1dlW6AFMn1eTQnC1jyt7KSvWB4XMfzbM2J3hF7WTqbUsTlP8
	 Mm9jw7GIUVeMWIedsmFoqTgWaFdtimIEgcqj6wg2OwT234v5/cq3apr3KvZC3BTvUt
	 F8pVF/9pjee49ATSmJQ21hIz2N0dbBex9zAUq6eXrHiEa1hME3VajordyQF93ntuWp
	 NCwxc7sn6YFMnfom5w+TjoiSXNSyJ9PVAAXvEkFmWAG3qPiabA/lzfTgtnjSkzgHlR
	 hL6Y01PtOrpKd32AIGVaWzT0hw580qUVslqnn+RdCreoI0coDwcU6WUWeaXx4DPiDQ
	 tGF48mFkNKjtQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFF5383BF56;
	Sun,  3 Aug 2025 22:32:55 +0000 (UTC)
Subject: Re: [GIT PULL] I3C changes for 6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250802232654918f2886@mail.local>
References: <20250802232654918f2886@mail.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250802232654918f2886@mail.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.17
X-PR-Tracked-Commit-Id: 3b661ca549b9e5bb11d0bc97ada6110aac3282d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 546b0ad6a87297a4268bc336aea57173008428e8
Message-Id: <175426037442.556955.13177622747467554544.pr-tracker-bot@kernel.org>
Date: Sun, 03 Aug 2025 22:32:54 +0000
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 3 Aug 2025 01:26:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/546b0ad6a87297a4268bc336aea57173008428e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

