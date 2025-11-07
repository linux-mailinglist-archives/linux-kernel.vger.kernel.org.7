Return-Path: <linux-kernel+bounces-889616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3378EC3E0E8
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 01:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 715713B4228
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 00:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4387308F36;
	Fri,  7 Nov 2025 00:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0bK2xeM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0982FB0A7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 00:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476613; cv=none; b=DzgVHDSf58CD87kb3AExHp0wc1PDdasVRCTe9cQYbnC5PEw+Kj21Jy12LiYh+ru/3skspTe65CMgu4Zh72VVd8pGIIMcFb2pRI+kzU8v3EGk6ivhBDttgT4Gx8mp22DhQ6L5HAB+DyKY8yvYvg+7bLwt9EcLvhRUD8Nl8OG7TkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476613; c=relaxed/simple;
	bh=RriSvM7sxLTV9fBiNQohHybXVqXphRcxLw5gWXqJryI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=M7ALuYhN8ss+bnvgtqw4lFHMR/SFoHW2O+k9UiewpWYroGw7Hdjfv6zjY9tIFOiLzZum8LTIukncxpqX4gwy3e8sPr6H3d/dmAIPUESYNHp2xUz8jh2/r6NLNOshXCNtlVGgZmw4jgXyeeTH5/Ggln3sOZBsVS/ipq/mis6tN5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0bK2xeM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76A9C4CEF7;
	Fri,  7 Nov 2025 00:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762476612;
	bh=RriSvM7sxLTV9fBiNQohHybXVqXphRcxLw5gWXqJryI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=f0bK2xeMucmqxEGEr9Jisx2OPtppxjUpFRudzu7yNjBdGaIwqURtEyeU90GUVWpdG
	 7iOASgr7vDaoEMCT7N8bx43DD/IJcLwEHLu5QOvHtg75jzKZyj7jy8LHkwEkLNp+XN
	 X6g/r2E0ONuUJPXyuWq+BgowCSOLKa/QW5QWAj5xoFa10ReREhMrr1+N0BbQzEKW3b
	 Ovpte/WK7ky0Tllr/1Pqe7ishgKAM78Em0zA9l7bjTlsTGEEE2x4GexAECeM50eER0
	 7WhpHlvRuZFkJWJzdOb3xed9iWh/HVApvqsifySpMTZ6VnoZT8xyTw0ZV2N2cGQiYs
	 7OjWdngyT+wDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF47A39EF974;
	Fri,  7 Nov 2025 00:49:46 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V updates for v6.18-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <50a5b4a5-18ae-6dda-bdbd-db67e112bc1b@kernel.org>
References: <50a5b4a5-18ae-6dda-bdbd-db67e112bc1b@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <50a5b4a5-18ae-6dda-bdbd-db67e112bc1b@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux tags/riscv-for-linus-6.18-rc5
X-PR-Tracked-Commit-Id: 2e448567839c65768486d56612c88cb327d26050
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 225a97d6d45456a7627633da09cb842a43ef1b85
Message-Id: <176247658534.436188.2567112900291866949.pr-tracker-bot@kernel.org>
Date: Fri, 07 Nov 2025 00:49:45 +0000
To: Paul Walmsley <pjw@kernel.org>
Cc: torvalds@linux-foundation.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 6 Nov 2025 15:52:22 -0700 (MST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux tags/riscv-for-linus-6.18-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/225a97d6d45456a7627633da09cb842a43ef1b85

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

