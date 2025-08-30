Return-Path: <linux-kernel+bounces-793099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE40B3CE6F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 19:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B90C1B223F8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 17:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFC22D6E54;
	Sat, 30 Aug 2025 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdHiQ8mF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EFD253F13
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756576563; cv=none; b=oXJ+R5hhDvSu8dzOUR1KOZqzSpnBzK3B/PGvVEQP5AA0SBWFhB9WIRdxOdPFjOWZb5bfBjcRUiAZLEhgkz0bhrgq2Ga7S168qkF8X+epw51FrJzXfCLheCjHDN0MFzwqnoU9HEgTXG7fkI7Sdd9ZalpWQ/ungQnXeUQ+JqldP40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756576563; c=relaxed/simple;
	bh=/wWIpt/RhNt0zzikItWj4BYvAVYQxfg2lBw64Bxe2p0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZoLoiJ0247yLtB8MENE8L+Y1n1SnvKOWRmelSFQdkrdmPYKJEJTafZjCuzPfCUQn5ioTja7HreZtUGBpSsLzr+KQRJZtJD0RS4p+uB0Q215xN5YFmR3bapOQOc68KmBCPzsxgYLy1w4Cn71r1kA3wIE/xFrF2yFcipLdUy8sRZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdHiQ8mF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B795C4CEEB;
	Sat, 30 Aug 2025 17:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756576563;
	bh=/wWIpt/RhNt0zzikItWj4BYvAVYQxfg2lBw64Bxe2p0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sdHiQ8mFjCk8RmFCh5J7Zg0XqJOu5bOtrIyThgmmYmLhCOlM41n5uxyKM0wBPNRX/
	 pwXMYxYeLTMkyO88oMbgguPQgbzZlJXnmYvP7N1GEL5CyFIM/pPP5lzGX4euLpqkF3
	 aJVmTa3q5mrfIk8OeIQ48CHFSY4M6jbswlpMwiNEo/inbtAN1es7ZnCzqDFR+VhIS/
	 k9K9xcRqmdHN5EZ6w76xUumUmXf/dzQ15571WGvKfKAmxHDutFEqz1MPTq7FYgBrOI
	 /zOqPblVDLhvqyMnrtR3s3Zdc7VsrEEtjshQVW9sd3xFHF5cOES9CHtjAmhA7Npa2j
	 IaOExDF5yriTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEFCA383BF75;
	Sat, 30 Aug 2025 17:56:10 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 6.17-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <aLL02Fi-gazNRa1G@arm.com>
References: <aLL02Fi-gazNRa1G@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aLL02Fi-gazNRa1G@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: d82aa5d3501b25bfb7bc2a24a68ad0a83b2ad10b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c8bc81a52d5a2ac2e4b257ae123677cf94112755
Message-Id: <175657656917.2548612.428091907590415108.pr-tracker-bot@kernel.org>
Date: Sat, 30 Aug 2025 17:56:09 +0000
To: Catalin Marinas <cmarinas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 30 Aug 2025 13:55:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c8bc81a52d5a2ac2e4b257ae123677cf94112755

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

