Return-Path: <linux-kernel+bounces-839713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD0ABB238F
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 03:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A391019291ED
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 01:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58397D098;
	Thu,  2 Oct 2025 01:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWinBhTg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6E178F4F;
	Thu,  2 Oct 2025 01:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759367434; cv=none; b=UPWlC3Qu4qYHKX0C3x5rm2l3+LtuTWpP05Qkz53PNVW4cLNPqypPj2c6oPbvphopxC3USgms/KVWAEwkfZOPm1rzJgXtEZyVEZvgQZbULfqU0ka9YDKuEOdh31hM6zBGwPuEq2kZikqflYFt9j7V0NAePb1nF0HEaatGYXcnldw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759367434; c=relaxed/simple;
	bh=yYvgAGMLkQkF6DSmQ97Q6YLP2uC771aG/GEeq2XVi8k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cfOmIsSSwpL+7Jba4I6JTVFXQEBLA9cVjCpDJkDS1JhDEDtut66l1wNHgt/IWacTWctAL2D9YIc5scgn1yOAo7poqrLTFd1bpIuPy7pSM3gZqj63KUNkSguqIRFrWeoojY+oBSjA/J005ThszdSaaa0FMHafjJv5+40t8FCjM/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWinBhTg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F77C4CEFA;
	Thu,  2 Oct 2025 01:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759367433;
	bh=yYvgAGMLkQkF6DSmQ97Q6YLP2uC771aG/GEeq2XVi8k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TWinBhTgMdKjyTiIGPqlpbTJFUia7cdTXVRpZLTSAIgyFs7B+AIdx4Bulx/MDb0gT
	 lF03+oP+G+r+7rod95/cV+28x9oLJiRAhF1ZAOHhqc5IoUI2Ao2NChxOwTqZTzjjJN
	 uNY+EaeO/D2zYyExZ9pHSeMlbrJHgd53D765TaDv7QZPevHMQUEpnnwA1g6thyXQNm
	 fQTwzWbK1APx3CoNdXnSf2YOxE7w3ulmM20xc5fPQH43Irwf8cIW7VGXfkGFuh7f9/
	 +Xv+LWmLGjLQJBqGdN3coVhSbw1Tcp6MwboVt0mQFcen05gw8qsjLYrCKGbEjaJaDO
	 dgt8XoWuYP+3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 517F139EF947;
	Thu,  2 Oct 2025 01:10:27 +0000 (UTC)
Subject: Re: [GIT PULL 3/5] soc: defconfig updates for 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <d6fc7506-9700-4462-9842-d20ee54bea5f@app.fastmail.com>
References: <54b49f7b-9232-44d7-9ae3-ecc1826f17d7@app.fastmail.com> <d6fc7506-9700-4462-9842-d20ee54bea5f@app.fastmail.com>
X-PR-Tracked-List-Id: <soc.lists.linux.dev>
X-PR-Tracked-Message-Id: <d6fc7506-9700-4462-9842-d20ee54bea5f@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-defconfig-6.18
X-PR-Tracked-Commit-Id: 1f76c941c29bffdc97212969115f1fd5f91a4aed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f8912147dba3e9688b290aab0987bc9b0c6bb9a3
Message-Id: <175936742602.2689671.3791407765436153026.pr-tracker-bot@kernel.org>
Date: Thu, 02 Oct 2025 01:10:26 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, soc@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 02 Oct 2025 00:27:14 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-defconfig-6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f8912147dba3e9688b290aab0987bc9b0c6bb9a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

