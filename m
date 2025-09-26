Return-Path: <linux-kernel+bounces-834626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E14BA5205
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 22:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD1F4C25A4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99AA30F55B;
	Fri, 26 Sep 2025 20:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltraj29d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E25730F53D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 20:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758919476; cv=none; b=Fw5Y0H6nGL9MQ50/MgtnIub5z5renrqiB//GeGcGmFHciUKX0EbBhZfsZ45YCie5/lgtEjgPr6YEV//ybjgBM2uez/gLbyO7yuqinFqovmU3n73/ZfAYz/vcO8IE4vgNrcvCoQC5awt/ZTyr7QLBIZwVKTFSnAnZ/zvlpPvbChM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758919476; c=relaxed/simple;
	bh=HRQsGZRU8TCfzQzxuqBzUjNhbXyaOUFYEMKVD9PLbfc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nZp3YWTX+LJ4wQJ65p8bg9HnLbCj8p2xJRy4L8uLCryZGYc0pytlxI1W+bPUPzD3L58k/fjhz+hUcXSlOfFPxA3dxxZaGFOvShtucUQKrO5g9OAgEdKahJdAQrQUDE2bR5rSCe4Ef9YUUVrQ9lpxHEtisFuCfZtc7QGzKxsbgps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltraj29d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E736CC4CEF8;
	Fri, 26 Sep 2025 20:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758919476;
	bh=HRQsGZRU8TCfzQzxuqBzUjNhbXyaOUFYEMKVD9PLbfc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ltraj29dRImtV6YNaoy82ThW+A/VZxjhrqWnS+lvHjD2r70Ii2No91jv8AA+PR8qn
	 4QlxSubzy/wfP4vlKUaYuA4jxeejLnO6b99GM6XeuI83MAdDwvDWTL/aKt8Rle3CLZ
	 9u97rsnec0QY3o9f1A0Bk4zQXx9roI/fz/vTC8wmzS/xHzdk9qszRA9Ux+EKTFKMbw
	 QEDrQXskR3wu0In6BWgiEOrJM+jaz9nF2QhCq46zwLoOR32/xc+rgJy1WkzcBhbIJ/
	 Gf9D5ba3W17wKMI4PthTBlsN9HJwYRKddt9cU4Xpzsc6X7qsNYBe4z4RcRCfhtZ4/+
	 J7iLIXvUDeLvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C4139D0C3F;
	Fri, 26 Sep 2025 20:44:32 +0000 (UTC)
Subject: Re: [GIT PULL] locking fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <aNaZSyaGxaEnKArg@gmail.com>
References: <aNaZSyaGxaEnKArg@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aNaZSyaGxaEnKArg@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2025-09-26
X-PR-Tracked-Commit-Id: 4ec3c15462b9f44562f45723a92e2807746ba7d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2cea0ed9796381b142f46bd8de97bb6b54b1df61
Message-Id: <175891947103.51956.5965301596433035194.pr-tracker-bot@kernel.org>
Date: Fri, 26 Sep 2025 20:44:31 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, Borislav Petkov <bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 15:46:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2025-09-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2cea0ed9796381b142f46bd8de97bb6b54b1df61

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

