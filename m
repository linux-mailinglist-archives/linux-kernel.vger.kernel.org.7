Return-Path: <linux-kernel+bounces-859340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B16ABED53E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D3F84ED063
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250CC25A324;
	Sat, 18 Oct 2025 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKp+CCP3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8245A258CE7
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 17:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760808466; cv=none; b=Yp2rF3AqTngnW6oEiQS77ekRc6KrGNcaWWKzOiIarRIboqNUjzYtSEE8RSsCsIzLNA/sEjGPaHbm2KZnfPS478qa9xOEW6U/t0Dq7x6On4ZYhEBX1LMPKChoFHnd96g/aIhDITQR1R4m7ZQqFM+t90r7+6ESiVBN/aJST6lmyZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760808466; c=relaxed/simple;
	bh=DyREwtsEfbX5QW2yfZUTh9ziDj9TmwjobncPYUNGy9o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=REKckvTGhNTNJoIsfwkoRGqqhzg+8W8ShsrEvigZtRE/ngybagxrAS0KlYfmA4P/a33+KtvIr5YURt+7U/y+uYfjvgIznc/qbnTd0oE3w/6A3jciNn65KB+C/qM1wqmVkNDOZm7AqxvKDtWxV3UrJHzOfgXF/qAVnaGv+EzcQEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKp+CCP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2C0C4CEF9;
	Sat, 18 Oct 2025 17:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760808466;
	bh=DyREwtsEfbX5QW2yfZUTh9ziDj9TmwjobncPYUNGy9o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HKp+CCP37g3AbhoawJ2U9xpXlcZDSDXJr6rTZY3DmIGnoDSUuYgtPb0dR2+v+mtvh
	 3ZUSJz2gUDL7jnQZLKapDq+nNY50La1ybGCgGFxxbpmKqlRnTzezWwPvGyeN7ZJVpW
	 BE+rBxtWqLnqidmDmkHna7DRR1Z+LkRPGyRWST00HechwfBJTeQcOEAcYbYEXfFcnb
	 dUarUZYzGtwZkzBYIL/zChf6wb0SpWk0IpL4LUrpDGq4v+hJJBjXRwa16O+FKrbUxO
	 yZnZUnTpset8JsDIvxL4gE8MJsnO2IUOIbPlnF3ky1P00G2MjWDOOKX5g6dpFe319Q
	 /MY7L5TascK+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFE739EFBB7;
	Sat, 18 Oct 2025 17:27:30 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.18-2 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <2de37987-076d-42c5-9597-0ef374f37e08@linux.ibm.com>
References: <2de37987-076d-42c5-9597-0ef374f37e08@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2de37987-076d-42c5-9597-0ef374f37e08@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.18-2
X-PR-Tracked-Commit-Id: 0843ba458439f38efdc14aa359c14ad0127edb01
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e622c4b0e02ca1946a9fadb63f00ef733e8ba28
Message-Id: <176080844931.3050468.146636162209660874.pr-tracker-bot@kernel.org>
Date: Sat, 18 Oct 2025 17:27:29 +0000
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ajd@linux.ibm.com, christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, namcao@linutronix.de, naveen@kernel.org, npiggin@gmail.com, sourabhjain@linux.ibm.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 18 Oct 2025 16:21:56 +0530:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.18-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e622c4b0e02ca1946a9fadb63f00ef733e8ba28

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

