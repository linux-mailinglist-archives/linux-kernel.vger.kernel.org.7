Return-Path: <linux-kernel+bounces-793512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64521B3D47C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 18:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEFD23B9FCE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 16:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4602727FA;
	Sun, 31 Aug 2025 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhzskdNk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398E82629F
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756659072; cv=none; b=SqZrejX2YqIA4ApDc8JwV95NVBWfG8bgujvXfv7lzR28yAPSUOOtnSUERuQrFuYZfVS1SRmlhyPtCMXEVQ1k5Uvtk//sE5ZQls0XutLZ6zB6mzQeezFxE8kz7DOxQanT9DYH5K93oA4Fy2T7C2U4H4Ry0IsuewQXOJIhcS7GRww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756659072; c=relaxed/simple;
	bh=AlyIRDPMolk6H6nK7Y5Ce962jWeZl/aTpOU/zKnjoaY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kn/oICwLcCfS0kHVMEUYigUTUp0lQuS3OdxpN57wxSDOg9JAW2XUs6n9OGs5MFyjQ+tUnsUP6HtqU2J6M5ls/fpNKvDS3qEoqYDG5duirERS6notW8x3R4bQp/BluB+HtVdGQaIphY3MQ1e6x0RMerNDPZbPvnb/0l6j4fti7KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhzskdNk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160ABC4CEF4;
	Sun, 31 Aug 2025 16:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756659072;
	bh=AlyIRDPMolk6H6nK7Y5Ce962jWeZl/aTpOU/zKnjoaY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UhzskdNkaOmh32lBd+gpDWNp17jaIAMFHGqTtPHHt24IxLqnNFYWcCbURI+6RRf/R
	 Q7jO5i2jmJqsQyPd4GXk4Pn88nt3B6SE2PIBFTOA4QwhfbSpKqRkSuRK6RL8imtrIY
	 PeJ6P0aZUwDn0W1jGtDfkg3Knw0VhAHBKQvHIi/ZcAXZc4XDaHkpnlLmiQ54gTj3UE
	 HZUzJG7bbGzpm/3vcKCC+lz4R44k7Gz5jXt15yT2b0wDWcVKts39+vbYORqiwtmeKA
	 ++gv9EeV0uBXOcMqz3C7j6FMnqfBBIB5hnxrbITmbp4X88dfRcy9QWduNngpvT3GPv
	 YXw1xWxgWkYxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D59383BF4E;
	Sun, 31 Aug 2025 16:51:19 +0000 (UTC)
Subject: Re: [GIT PULL] irq/urgent for v6.17-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250831093118.GAaLQWZnsa4UZdyxFs@fat_crate.local>
References: <20250831093118.GAaLQWZnsa4UZdyxFs@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250831093118.GAaLQWZnsa4UZdyxFs@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.17_rc4
X-PR-Tracked-Commit-Id: 35c23871be0072738ccc7ca00354c791711e5640
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c9e4e96185f45f410b3d0b09c9273c7da5a5c660
Message-Id: <175665907808.2726201.5031252855399099474.pr-tracker-bot@kernel.org>
Date: Sun, 31 Aug 2025 16:51:18 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 31 Aug 2025 11:31:18 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.17_rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c9e4e96185f45f410b3d0b09c9273c7da5a5c660

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

