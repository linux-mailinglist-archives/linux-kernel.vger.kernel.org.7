Return-Path: <linux-kernel+bounces-815871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8E0B56C22
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 22:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DF0F3A9897
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 20:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1F72E62C0;
	Sun, 14 Sep 2025 20:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/tH5sRa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588182E5B1B
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 20:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757881216; cv=none; b=CGOmDG9oNiZQ7ci1Ewdi1wYGlJsYMyeoNRYrIvnlY5/DL76d/X507im4CCYZeJlwxaaiba4GNCrOIVffDZAxNKykkiXiaH9bh9l/Ncbq/t5cvjpyn7N4djLfwLAci8xMl1dutMmJbzh38YNYkxNkjsXzUd6bixu4ISN/L6MTD4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757881216; c=relaxed/simple;
	bh=4ziuSU1rH7IgFa8rh2IJbDCbEcFLquhZGyjQ3CSZY7A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Y4H9DqCMLNoBeM43how+nBMkoUiYHPkmr5+9c2xHmdOL7zS2Gyh5U+W2JjiIom4cax4NoNUstvgShK3AGIxIqsmujf2NtTmn2YXQWCrjMTNuD4k4hX+BN8N1/aCt0fYGKSOy5zf+L1CUQMl7nCWJ/FRRMFTb47m4VMK0U0k1oQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/tH5sRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD3AC4CEF0;
	Sun, 14 Sep 2025 20:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757881216;
	bh=4ziuSU1rH7IgFa8rh2IJbDCbEcFLquhZGyjQ3CSZY7A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=o/tH5sRaO2RkMT4qOYfSKDEhSew6QFiWFrb/wHIcIeO3Ppw8kB5ifXQrX9e+G0L+J
	 jZzumAGDErNz+SxJEdGrc8Q4zB22eJ+eYZdIvBJECS3GdGmfvTnsjd4XwhTX3+Mx8F
	 bhnA8+f788q26/S5YtgB+ZnSqSCsExaFvFOuYrwlz8LpzoVRD30UTPsDodeb0gCXko
	 B0wQTTnzI36G5XfiiiwGGsxZvoHT66bFoSHPjaZ/cKkmSxF1CdxvOUgroXFek4Tfs5
	 5p6gZxel/NBBj0EbuzsvtbKo2h5d5OnSwqaAW2+Ozdkgp5fHFtbmeNdqDr+zsBAwO2
	 eM40ckbHUJ3Lg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 339DC39B167D;
	Sun, 14 Sep 2025 20:20:19 +0000 (UTC)
Subject: Re: [GIT PULL]: Generic phy fixes for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <aMb8B6czM8mgaOZS@vaman>
References: <aMb8B6czM8mgaOZS@vaman>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aMb8B6czM8mgaOZS@vaman>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fix-6.17
X-PR-Tracked-Commit-Id: 6cb8c1f957f674ca20b7d7c96b1f1bb11b83b679
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 79e8447ec66289745d1b38679b16dd6c654ff578
Message-Id: <175788121787.3542944.8650773530932136146.pr-tracker-bot@kernel.org>
Date: Sun, 14 Sep 2025 20:20:17 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 14 Sep 2025 23:01:51 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fix-6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/79e8447ec66289745d1b38679b16dd6c654ff578

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

