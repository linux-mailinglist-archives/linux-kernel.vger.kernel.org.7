Return-Path: <linux-kernel+bounces-859772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B63CBBEE83A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 17:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B58189ADD0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 15:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8499A2EB874;
	Sun, 19 Oct 2025 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r05Uth/g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13C32EB875
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760886351; cv=none; b=fUepkvwlJ5UJ3NZJr3NfR9ABb/ZMbiSzLmmiz+gF42iu38wU/iEbsjTM7FeqDhi6ryKMTzMD9FO/vsMyjcBs1aOFmUWMzpXlqOk5etD2eu3Osv70Wzsb0/b1A+d6ej0CGOhFdZaXdPmTkjnWYNS/tLL07WD8TEaNHj7bdcT1v2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760886351; c=relaxed/simple;
	bh=0pQsmRl20+vOZPkXZkGS/Ws35Z0PFrj+Qa7v3r/Gew8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RM1XryrFNavQ1SV65EyrUwYpndv62YfdQSD6dPyY/FfTaFK7WZXgs7Korfppgtb84C0kfDpVVrXLJPN/FoOYl+TXDZotIycSmEyICgIfmu7UX55mylY2H0nK5l4ZXCQVbFs9veqehtg/PaO5ALxrKkAuU3PWDnNBOZpbdgKJ9qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r05Uth/g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFA7C4AF09;
	Sun, 19 Oct 2025 15:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760886350;
	bh=0pQsmRl20+vOZPkXZkGS/Ws35Z0PFrj+Qa7v3r/Gew8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=r05Uth/gcO4cdQGrPIo/WgV6cXqjr78cWZVq0RwJWN3+PSukgbO1tPAm8UN8gk0At
	 9XwXLVPIFb77PXLvag4g5TZ2iecM9WxZMNsNcwWwbMJW1A/+KZRd16D8nD7T83I/oS
	 fE+UsQmwvXjyPtU1w8out6tNI2rBn2n9LiwFlnbmelnqrdWA7Xr4pnoM6Cw4qYf0jW
	 rhsXw3EUHF+Ck/E+L4++09RGMeaQ5LTHW5qyY2anLG9mPj3PUzUTMFG7DMHSoOyhm/
	 0aETqCmZsC3xji2cbMwgb/jTm358etRjO4f+7nILMdH82IptXamqDJo6sG2pkvt8wv
	 fynGIc3hO+7JQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B1D39FEB71;
	Sun, 19 Oct 2025 15:05:34 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for v6.18-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251019111222.GAaPTHlvJPUC-U56Z0@fat_crate.local>
References: <20251019111222.GAaPTHlvJPUC-U56Z0@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251019111222.GAaPTHlvJPUC-U56Z0@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/perf_urgent_for_v6.18_rc2
X-PR-Tracked-Commit-Id: fa4f4bae893fbce8a3edfff1ab7ece0c01dc1328
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 343b4b44a10f6e383bd829ba130024cfde2a08d4
Message-Id: <176088633283.3293831.102096462991584355.pr-tracker-bot@kernel.org>
Date: Sun, 19 Oct 2025 15:05:32 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 19 Oct 2025 13:12:22 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/perf_urgent_for_v6.18_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/343b4b44a10f6e383bd829ba130024cfde2a08d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

