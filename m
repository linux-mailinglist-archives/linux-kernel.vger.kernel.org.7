Return-Path: <linux-kernel+bounces-803742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DCFB46485
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 22:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F94EA0253F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 20:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E0E29B8F8;
	Fri,  5 Sep 2025 20:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttdoIzGD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A378E281351
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 20:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757103448; cv=none; b=KkuxSY/wF1JRKj78aJM2KJRXKqufrhno5SlXkusQSJZIt3cNVv2GuSUB75W38st47+tdMtmqB+Aop5D7QXuLIXDg0MH+oQvfY3+W8PHqPYpExYNN4bZLY0ZglN5/WlN3o125Fzw9IFD15svFaldbh6Im+zuIsy2JXqWXUBetFTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757103448; c=relaxed/simple;
	bh=riI43D9lO1MLv2qm7PX19Iq7jYpv/aKJ8u0QsSqJpps=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uwgbMO/kO1Q4GbtNXpMCrVnwDYqf/vfTE8tu4Dwn756XInNIQQsAve0RbOLKXf/sIKWfgkPV73m1f/DsJ7PMcgng+GcjIhUEnPgke7wlsXhDNBnXHpSQtsDDXPspC9CZunknX/JSBa9WhvuD8/5hCmUwNz0On2wVSnlNVCMIzQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttdoIzGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1A5C4CEF8;
	Fri,  5 Sep 2025 20:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757103448;
	bh=riI43D9lO1MLv2qm7PX19Iq7jYpv/aKJ8u0QsSqJpps=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ttdoIzGDNxvhxeoy+O6UA5XhzDH+8T1EcwQ2RW/qWySEGEkF3vDe3Kn5LBij2VUPO
	 JpaZp1bgW/5bVdTrkhp787ZC0TAu3ewb2YHHhU0i33Exx/CmcoZYKzNBeqWDPJRONw
	 AwVeOjAoRFF3l2HMtPeOxGb6pRCYThOjDptVyAWXrf9cf1c0Zt3yfY+PDwqo/AKLFa
	 E2jSOROYQnmnNIb2A/XO/tF5FrcqQID6qNFhT808rXmVLBHAE+SA5yQ9Zc67PLYSie
	 7eGMaJZe4q8wzSeUGotrHXLqjSmlsYzVoyBQQgiP3cF4OSiGwapMXXbvRhWaE+giI5
	 Mciq83XBnql6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEE6383BF69;
	Fri,  5 Sep 2025 20:17:33 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 6.17-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <aLsffo3bIIH4hYSQ@arm.com>
References: <aLsffo3bIIH4hYSQ@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aLsffo3bIIH4hYSQ@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: a7ed7b9d0ebb038db9963d574da0311cab0b666a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e5d5d23319565a7e48232707c3fe30bd4eb638cd
Message-Id: <175710345262.2676293.12334008211790244742.pr-tracker-bot@kernel.org>
Date: Fri, 05 Sep 2025 20:17:32 +0000
To: Catalin Marinas <cmarinas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 5 Sep 2025 18:35:58 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e5d5d23319565a7e48232707c3fe30bd4eb638cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

