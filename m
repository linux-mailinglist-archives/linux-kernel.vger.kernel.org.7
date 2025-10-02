Return-Path: <linux-kernel+bounces-839711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24894BB2389
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 03:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04C719291A8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 01:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D41A54791;
	Thu,  2 Oct 2025 01:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhBZ+cpl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81A1487BE;
	Thu,  2 Oct 2025 01:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759367430; cv=none; b=DBHabIi9LbraCdUNl79hFHyXRfmmOEREQpFrZig1lFKG60HR6xxsLZ7pc2KKTO5FVskDspHNs/2B6+aQoyU15SuSWBgg4fpG7FHa9q2sZo5GKPHNJza9CWVba+f2xENQHVxu9k+cdZTzBnFy72dhgS1/a6isAEKNU5DSnTAQyLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759367430; c=relaxed/simple;
	bh=pHTUi2pFN5j1Ger1eF5Kb8j6I/je2tT6wP6Bz4h2hxs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Thbhp+m7Cb9DaSIkOdM024cBW1Z2DulNMyW2aYbrkZV04rzT9zgesTxbZE8unEoUqlzZJjXcxPk1n5XBWOg0gijLBqdLOBYNDhFv6/XtdTXKGE09uHyRTFPPQsu3CTCLrXQGDr98AV8gFY47OEyE06Ls4xi9wYb6c/35JW0vG0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhBZ+cpl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F58C4CEF1;
	Thu,  2 Oct 2025 01:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759367430;
	bh=pHTUi2pFN5j1Ger1eF5Kb8j6I/je2tT6wP6Bz4h2hxs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EhBZ+cplaUX6OCUZAjQxBzxjiYS4Lk9miro+kugcVJyXLtffr4biXm1qRmGUmZ3th
	 o8i0E+M+xBLXVV+xzGsgnfx+FT+anwu6Tebm7JfJkjpaz5LBZReubOyZgpjmIkbSzv
	 MSKU4lErA6yvkpu8cDpflQmGTez3+QJIZ4wl25xq9xg98SUGxGyxeDv1tx7biEH4OX
	 +gJ5waqMrvpbvZbcDqhzwEZ/LotoJY9HaUOvhmoA/3PvWzkowMg78bNYl0ylGLBvJo
	 O1r5PRQUO9WZHRfGwOZ8YDuQmZ7oWgQ/a4sy4B1Nx/fn7l31sOcri/xUgrEJ7wnDKC
	 n9f37hwil5kCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 39A0739EE03D;
	Thu,  2 Oct 2025 01:10:24 +0000 (UTC)
Subject: Re: [GIT PULL 1/5] soc: new SoC support for 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <ce4be3de-eae9-4a73-9d85-e47976ef8372@app.fastmail.com>
References: <54b49f7b-9232-44d7-9ae3-ecc1826f17d7@app.fastmail.com> <ce4be3de-eae9-4a73-9d85-e47976ef8372@app.fastmail.com>
X-PR-Tracked-List-Id: <soc.lists.linux.dev>
X-PR-Tracked-Message-Id: <ce4be3de-eae9-4a73-9d85-e47976ef8372@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git soc-newsoc-6.18
X-PR-Tracked-Commit-Id: fee2f45def0379ed140de4db8f998edb1d78e619
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a8253f807760e9c80eada9e5354e1240ccf325f9
Message-Id: <175936742312.2689671.6180621715040570208.pr-tracker-bot@kernel.org>
Date: Thu, 02 Oct 2025 01:10:23 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, soc@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 02 Oct 2025 00:24:18 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git soc-newsoc-6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a8253f807760e9c80eada9e5354e1240ccf325f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

