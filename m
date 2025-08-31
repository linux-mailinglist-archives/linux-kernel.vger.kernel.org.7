Return-Path: <linux-kernel+bounces-793514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72262B3D47E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 18:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6548A3B6646
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 16:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5134270EC3;
	Sun, 31 Aug 2025 16:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GS+wWg9P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3143E270EC1
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 16:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756659077; cv=none; b=Vn71pSdPETQHlXtDgbdM6MRv0BoklRkZM+tVWQIJTNDqvqlOP1NwRBUqvUqc6jG1xZDjLG1iH05Kv+KLTr86kwWI8GIQU4qLa29EjRR3T1mTDHjKorSWqEwARimAxrBxs2nxZJ+g3WjR5cEBFbwxkinuLngdCVgxtzYMUo6Vkek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756659077; c=relaxed/simple;
	bh=TwwvuXoVuc/mTqKuc3EGF30gHDGCfs721ub1xJHjVp0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uGxe7ei1ye9Mr0wgOBm7a8fv2TWlSDx05/FdnNUaQbpOP/faVww86yECqb34BIenK/YnscdxAB3L0jYaU1yEY5G4wZweHUZsu4vD/YEvbWv/51ggw74feNULQpiHpYkCuN4S14sdcJJBHZH8TY75AooQoz2E22ntvMQ2FvQar1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GS+wWg9P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC8DC4CEED;
	Sun, 31 Aug 2025 16:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756659075;
	bh=TwwvuXoVuc/mTqKuc3EGF30gHDGCfs721ub1xJHjVp0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GS+wWg9PHyooM89dYMmm/lCFNmjEJqttPhN/LixHQdyfom74Gt7w/7n1TqJ0dufdv
	 Zw52BtpWIbEPKCIBtdcmO4x3YFxaZNyIiHB/3TONU8jHmZ0BQLF7ECKTRRo4CrPvj7
	 Ewjd/P0ZhBstxt6Xoq5uaLH5VGMbU8WHZB0Fuc4k3TXMqFdnzqTypNVfRHXi4Z6y/W
	 Y5ESZh54gN13KQ9MHr63owbz2ZYRuu7glgvZVPZsYaIP5ifeFhEZ1DvrGxSAkbCem/
	 P270zkCuIL6uyZoTQGts0i4qkkR6LRKT0wUgitoCCdtkrIWYijQhlWn3sbMlHtvir5
	 7oPF2Ya0c1xyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BAE383BF4E;
	Sun, 31 Aug 2025 16:51:22 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.17-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250831101418.GAaLQgepm-XMwE4n7x@fat_crate.local>
References: <20250831101418.GAaLQgepm-XMwE4n7x@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250831101418.GAaLQgepm-XMwE4n7x@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.17_rc4
X-PR-Tracked-Commit-Id: 8b3641dfb6f902407495c63b9b64482b32319b66
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c3b3264e5858813632031ba58bcd6e1eeb3b214
Message-Id: <175665908108.2726201.17330306284357790720.pr-tracker-bot@kernel.org>
Date: Sun, 31 Aug 2025 16:51:21 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 31 Aug 2025 12:14:18 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.17_rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c3b3264e5858813632031ba58bcd6e1eeb3b214

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

