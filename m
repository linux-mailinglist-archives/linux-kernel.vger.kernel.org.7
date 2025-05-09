Return-Path: <linux-kernel+bounces-642358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF60BAB1DAC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 22:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65A861884F90
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 20:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B0125EFBD;
	Fri,  9 May 2025 20:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUxtQ+La"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1158C25EFAA
	for <linux-kernel@vger.kernel.org>; Fri,  9 May 2025 20:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746821186; cv=none; b=h0bjgnbqWzVZ9+FrHMwqCFfZ84o+tQMotolzL0Jb4r0XOW/+Q9gbfZf9O7wdLrezNeAIEQDLUvzLPSJQ4FRPTts3mWjZpOyXo+tGV8AY8BCZS818Wc1YDi67WOS8sdDz21aO0Tlv7GcXdaYh3cZEWb7y9ksFhJUssD4rihzwCJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746821186; c=relaxed/simple;
	bh=7czinXDnCEWVWxNwkXht/YYDypJNm4GoG0nc7ZRa6A0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lcspl5HU0y6Bo8XjnuxcOwMmsJgdZ8yh3pgdTpAuZsZ1juzLVZRC0/0RZLreEx/3UejC9aHKfHRLilFMxOlePaQKVvzcDs++vpoH+BGbN9xUsufbnmjcpf1EiaCesUqkOq3ca9CR0FGU0LxWx2QrprYrqsGTdrKqvC6s9JzdSIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUxtQ+La; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A8AC4CEE4;
	Fri,  9 May 2025 20:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746821185;
	bh=7czinXDnCEWVWxNwkXht/YYDypJNm4GoG0nc7ZRa6A0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tUxtQ+LakGbpTHi0q+mG4WVdS49q7WHfbDIybQSB9Y5OkdYI5kHB3PX/psy2zMfdJ
	 /kPoCj5gGGAdwYZOZOHxfG9LTHpAvLo5NEEmUApPgJgUCZd1fBajr+dK+lpnmS6GQl
	 y8gLXwPL2ttsAXeNq5BkjXF0M+2cqglgCctVU6t6NZNGIrU20Cs8ruHOReMH4+aXSI
	 o9aAZ+ym+U3PEWRB1W1CuJLLpkHKMOF62UxcEBETCv0rXocK2ouiYDaEwrdXDpoJHZ
	 Zhqq+6SoWODzFj4qAprWRLm2ZfcDjpEGa9NennWwnEmfsLriwG5L1kkepF/WhWON9P
	 3rF7i/py8q3Vw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C7D39D61FF;
	Fri,  9 May 2025 20:07:05 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 6.15-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <aB42GJfIypFqk9aC@arm.com>
References: <aB42GJfIypFqk9aC@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aB42GJfIypFqk9aC@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 363cd2b81cfdf706bbfc9ec78db000c9b1ecc552
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50358c251eae19a2b2fc54b6944e362ef2fefff0
Message-Id: <174682122390.3766575.2205153632850936764.pr-tracker-bot@kernel.org>
Date: Fri, 09 May 2025 20:07:03 +0000
To: Catalin Marinas <cmarinas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 9 May 2025 18:06:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50358c251eae19a2b2fc54b6944e362ef2fefff0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

