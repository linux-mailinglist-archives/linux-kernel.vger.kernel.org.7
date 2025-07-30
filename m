Return-Path: <linux-kernel+bounces-750155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 802AFB157ED
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 05:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0CAA5A20C6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 03:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8C11F4E4F;
	Wed, 30 Jul 2025 03:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHQdIKKN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACAD1DED42
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753846784; cv=none; b=R9EmgTQWTgzQSa03qifTQfZJyXeLJLdaiWwApMI1AyGN4UUqGnRQKisGXYSK4pR+LUCsjQx0keImDEXfcMYWXaKWN+BpbnmE1dTciHmURnuPNmRW/EOu6UV27aOteYPosLkiVfkXGUK4oaKxI1YMmYieACXREwcRm0iVmEBJMXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753846784; c=relaxed/simple;
	bh=5UWcuRtvchs+nWZqOYJ3gSV7IUnsTujwWq9xkPxzy64=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=E7IqUXVOJEi80LQyzxNJr6JwK0MvQpxqWNRQQo3404som1Jun/oCGR/1iE32jpNJlWUmtIoFAq/ByRluHeQWbzsDwjeJe0knNLmxmytR40weinqpB4bLDcDyDHuvuM30NFMtRiOBHr4A66Qnjq0Y4uo/2LM4FZ5bnH1W3TCQL78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHQdIKKN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE45C4CEE7;
	Wed, 30 Jul 2025 03:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753846783;
	bh=5UWcuRtvchs+nWZqOYJ3gSV7IUnsTujwWq9xkPxzy64=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lHQdIKKNrKyXjVlpyilodoknXFnbinF78xcP6SFlHmI8xzZJ7e3ZLWYtQ1567Hss5
	 SST8b7khslM9jamMkfAVnLbx3A1xCKaRAFi2FcC8QBSZOnO6bsUg0iduSrVg7HSi/O
	 cMoLv13m29H6KcKSQCVFVqY3w0goUMGhX5Qpe5q2bT5vnIVGaZuAnQYB1gVdtUKvaY
	 a3QuGcyD77LkfGtW1LberdIJavbwq5CL2B3oLdHh5+XB3PDPOswr/80y5+10hvNXJy
	 tjRtgpO1GmNi0IH5nD2bubj3MlLoyTmNL4dltSCpw90soDdlKTTAFRJaDhgpK5gAfI
	 i2Xjl/ACty8yA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD28383BF5F;
	Wed, 30 Jul 2025 03:40:00 +0000 (UTC)
Subject: Re: [GIT PULL] x86/fpu updates for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <aIh0TvRcSPfV0ULC@gmail.com>
References: <aIh0TvRcSPfV0ULC@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aIh0TvRcSPfV0ULC@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-2025-07-29
X-PR-Tracked-Commit-Id: 1cec9ac2d071cfd2da562241aab0ef701355762a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0c23929f358c949f6254c46883afc2bba415d36e
Message-Id: <175384679957.1749338.2752359055463191785.pr-tracker-bot@kernel.org>
Date: Wed, 30 Jul 2025 03:39:59 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, "Chang S. Bae" <chang.seok.bae@intel.com>, Oleg Nesterov <oleg@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 29 Jul 2025 09:12:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-2025-07-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0c23929f358c949f6254c46883afc2bba415d36e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

