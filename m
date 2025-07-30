Return-Path: <linux-kernel+bounces-750158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E54B157EA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 05:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59AB71892A0E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 03:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BEF1FBEBD;
	Wed, 30 Jul 2025 03:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vd2HHbIX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29040201276
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753846789; cv=none; b=bTZDhrzUILOjtql8Ipa/HavAigmCcE946xdmyaCiksYUkbpeDFueEComksKMHNTvlxPu1dZCVtqharveteGGGoFBD1oS7i7mSR7SBqypkjDbofHqDaYfqrZDND7AoAfYSaxNGxk0ByPpWVqZ9XIPhuLGfaymGJIWYXXKan9nTC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753846789; c=relaxed/simple;
	bh=Lgmo1+CGQX4gXmlpgvxlKHV/6i+kdUYiGaxJQcUCDG0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=s7ucEseuR62PWWFwjt0iqp4sT8hDTOo4U4UCXjRKZ9QzHmPat67QksXP0n0VZ0DNug/cCBl4gTt/VBOrUpTkIFdNY0Lkkir4t+dTGuA9hbclHXx1rpJkslOlb+la6zExLgmAcAgkIemYOmk2StHicmrZqEAQWPv0SN378gC97pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vd2HHbIX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC8FC4CEE7;
	Wed, 30 Jul 2025 03:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753846789;
	bh=Lgmo1+CGQX4gXmlpgvxlKHV/6i+kdUYiGaxJQcUCDG0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Vd2HHbIX2HCv9KtJDeXp1MFG3MAa1/YLMd3dgVSymq1Qb4MnV5bRVsh/+0Xmua4Xg
	 Sg1hR4SN4JxPpqkpglZa409/Kt6CaZ5dmnP5QhEUmRIg7BkeV89rxr/BdAR1v8G2c0
	 J4dvl3bzo9dlF3H2hIzmuTg5dsn4mp7V+0TLO5bmPJl5lHJH77zeCENjyKohRdX3s7
	 4fDvj/ek7S4Mt/oaBeI9OjUerQvVrVW7ypN28v5gdB2IZkLGcc/qQxjkNA5ZVTMgr7
	 7bX3FY/jroJuJPQU4iOjfJveEL/6R9/SalStFamyMLnIOZQdkBNAbSL569h1lQPCWb
	 984OQrIZm6pOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E90383BF5F;
	Wed, 30 Jul 2025 03:40:06 +0000 (UTC)
Subject: Re: [GIT PULL] uml 6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250729100457.14550-3-johannes@sipsolutions.net>
References: <20250729100457.14550-3-johannes@sipsolutions.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250729100457.14550-3-johannes@sipsolutions.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linux-6.17-rc1
X-PR-Tracked-Commit-Id: fc9ed2f6589dc2c11f05883e5c323be5f39fd241
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: beb6c8326eb4e7006c4aa16b0fee3e303d42e685
Message-Id: <175384680492.1749338.7260404881755511172.pr-tracker-bot@kernel.org>
Date: Wed, 30 Jul 2025 03:40:04 +0000
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 29 Jul 2025 12:02:03 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linux-6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/beb6c8326eb4e7006c4aa16b0fee3e303d42e685

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

