Return-Path: <linux-kernel+bounces-750157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4A1B157EC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 05:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98D1C56270E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 03:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAAE1F76A5;
	Wed, 30 Jul 2025 03:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iM8jtypm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383861FBCAE
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753846787; cv=none; b=hL5IXMgNRfLmX8jMFCwa3REe3v83WgOSl84e8hzliKq5VerzG86KORukN8iikgcjX2oMAkrmn6DS1Z4iw5R+AhC/jv6nh7HsAPFC0hJBVx5y/Al5x2Ut1WU60X6qnbDoTUlS3UwFw6lHiHg4ZXGnEOYc6nvQStlkTesoaQw+ez8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753846787; c=relaxed/simple;
	bh=gPSh/itmJSR26ocJi0HRQqMHNTSamWuZqyF+Tpd5kmg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ouvUqxpwlYV6tudNtZZhRGiOtybJugXnDJWuGUaNbpO6h65OnGU3J6dHCPxUbQ01pS8jYzdjRveVAZw5/Q3LRBinKCJM2qKvxMlPNYrAO09ddKTYtvXea1XQJtKu3S+cHT8sKR4Wfx37Gju1Bw4/grRFrpIvGH4KJP54HmJrwiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iM8jtypm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5ACC4CEEB;
	Wed, 30 Jul 2025 03:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753846787;
	bh=gPSh/itmJSR26ocJi0HRQqMHNTSamWuZqyF+Tpd5kmg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iM8jtypm3RMGrIhzZeUqY32WSNNOGVtMhgOv4T0xAr7pu2tGXdcas1NskBxcGBGxg
	 i4023KCo0+4QdcKLf19g6oBuzP0oL52u+okRHWcwkq5lCJaby6PkuTv7EOreihyplW
	 bhS9XaorETva2hsJ4Cj8cxINDP5QsiCP3JoG24LC/uDE3X4Td77mTO6T+q53AkIgbh
	 x/xmSRQkvg0UNvTJYVE/bTFvQEK9hxoKnZa5ctfgMrnZy+9rq/mDygXCswDTrjDHee
	 Q9cYhGrhG9mbNKEDq+e5CXnkrGKG1vk0Fr/d/g2aIGKbHa7ps8e/pz/lQQFUAHg7qJ
	 cbHcj3zRubcfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E82383BF5F;
	Wed, 30 Jul 2025 03:40:04 +0000 (UTC)
Subject: Re: [GIT PULL] x86/platform updates for v6.17: AMD Hardware Feedback
 Interface (HFI) support
From: pr-tracker-bot@kernel.org
In-Reply-To: <aIh3dfKMDmR8pN2B@gmail.com>
References: <aIh3dfKMDmR8pN2B@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aIh3dfKMDmR8pN2B@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-platform-2025-07-29
X-PR-Tracked-Commit-Id: f12682148262aa6deed32c0593c67658573d0600
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 98e8f2c0e0930feee6a2538450c74d9d7de0a9cc
Message-Id: <175384680313.1749338.1808742672391630366.pr-tracker-bot@kernel.org>
Date: Wed, 30 Jul 2025 03:40:03 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 29 Jul 2025 09:25:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-platform-2025-07-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/98e8f2c0e0930feee6a2538450c74d9d7de0a9cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

