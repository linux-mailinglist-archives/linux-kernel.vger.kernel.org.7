Return-Path: <linux-kernel+bounces-760964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1A3B1F24F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72CEE1AA09AB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63ECC2472BA;
	Sat,  9 Aug 2025 05:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwsSvrP6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13891D618C;
	Sat,  9 Aug 2025 05:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754716760; cv=none; b=S7kgIthdyvsnN2tNLbllqEu+FpR/XICMwBmqOZlhs2G70lPu9XgiPY96vRjRAcBYvzTkk7+bTVrX12OoB86tWG+iIJh3SZX43jnm2ZWLVolshYuPCkYr6YYEi29vYprLZwSgY4HqufuqpPFSLA8ehSjzOe3wXveZQ7qNmame3W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754716760; c=relaxed/simple;
	bh=3ei8Qr/PqDz5ACLnFQhpd6y0dXsESOZmqG0XmKWm0/I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VdBpo1jNSeE+K72RQp1t1SejstRJ0dCZ8whD8zLNgVXIJ9VNcz47O2eCDPqnPNsNPGQt9zLvrztRmDsZnGkX9jc6Vti4en6dbqK7ISj1WGlpOg7wFivJQ88Ov6h1Ay6hmfx0NkMAxRYoUvv9U4yJRS2vwbPS2gUZJF5vWBPW974=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwsSvrP6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E040C4CEE7;
	Sat,  9 Aug 2025 05:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754716760;
	bh=3ei8Qr/PqDz5ACLnFQhpd6y0dXsESOZmqG0XmKWm0/I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cwsSvrP6aV61RIAibbHpjXcZHapDY9tCkoYleb9gvItLzZh2OJ+IOqJ2Io/T1lgKG
	 Ez4OHZ4e8W30X1ZdEF21Rr3G4BQiOZSYVJ3yaO7YyfffB+XYhrJ1bloOXC/B4yVyvI
	 k01P/FDv2xe+mFdZAmbheKUZvjXCWthuaqW4wqLug0KXGMN8SeTE5HjyKQP2ehwRvJ
	 EfZn9Xhx9apVIVcpIzkK3k0/6a5yg/z06+HXKM69BFdiXAG4JHA4nqZ+8Nwv0uL89i
	 K6a8oE2qyShGOal3V2KcWhBVKq5cg4AfVB5/Z9NjlM2rg2jSVYoH1y1qR3FIwv7N0F
	 MkxMJ+L8P/6hA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACDB383BF5A;
	Sat,  9 Aug 2025 05:19:34 +0000 (UTC)
Subject: Re: [GIT PULL] soc: fixes for 6.17, part 1
From: pr-tracker-bot@kernel.org
In-Reply-To: <828e73a2-23ae-442a-8d29-415a87b8ec4a@app.fastmail.com>
References: <828e73a2-23ae-442a-8d29-415a87b8ec4a@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <828e73a2-23ae-442a-8d29-415a87b8ec4a@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.17-1
X-PR-Tracked-Commit-Id: 0c952efa0d7cf5258879406077df33d23cb06d5e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 61d417921c9390ee2fb48c697490b6967c9b2034
Message-Id: <175471677342.380510.16866147607593828957.pr-tracker-bot@kernel.org>
Date: Sat, 09 Aug 2025 05:19:33 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, soc@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 08 Aug 2025 22:53:37 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.17-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/61d417921c9390ee2fb48c697490b6967c9b2034

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

