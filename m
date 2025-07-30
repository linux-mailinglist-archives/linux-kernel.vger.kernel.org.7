Return-Path: <linux-kernel+bounces-750154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD049B157EB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 05:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4CFD5A23D4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 03:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CDC1F4607;
	Wed, 30 Jul 2025 03:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GACEY3lJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080691F3B87
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753846782; cv=none; b=f9ma17y2K58zvilpTTiU4aJlC5xjOyLRq5j691NvCPPZnjkmgXcqz5z+AAuwOakZMSbXPUqIzklfHepsYS30OzzqD9y0H1NxnsYM+9aGwsU5TDgD9FDb2Ad0BvChGZeM5FSVCS5StxCKs+TyvMDeoGYXZgKnjLRFR/ZxVET0pa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753846782; c=relaxed/simple;
	bh=juhvNE44K5ERBSgHCS2pkf/dWFGtCq4HvWDEds3Myb0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UBU7X16RjYUC8AR50zL/EIvVdUxYr4TimSt7o54/Clp6iigqQTCNZ0i1zlgdzWOwAtFYagC44S0yhCeChfcojGCYGFzqEg6/45HvzwVA6Hp9+pOa/ENipwACjSgAkztInHVnXii/HInhfVJI8XT2awfJZAio0IsIGtRGScJxayQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GACEY3lJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C790DC4CEF9;
	Wed, 30 Jul 2025 03:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753846781;
	bh=juhvNE44K5ERBSgHCS2pkf/dWFGtCq4HvWDEds3Myb0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GACEY3lJmYYRowfbGu9JabMDep0bb897wb7Eeb8lgwVZByyINt+IQ0MltfW3yORPq
	 Uk/G/emfYgyUNJrYjKbQzfb9mz65WXKbjk0BBsLiL+DGiSpxIy9myWTmo6LeGWHisA
	 QilwibN8eGfCLiOZ4kbj10bH3MpWcM2YUr5XU8FLUxDOEQqufGBcxXwy3slBZoY56n
	 0hZxpwnfBXqBLN1lR6w6olVuBp3xLkWPqmUwxAN7NAMBExOb4EZ1NfDFkjOPhh3o1D
	 CrGx0BX/0g/akLCiqWiVkucqSK+0yx0/pkZ3cszFJBSmFkpT9jOXysFcYvfRlDJMf/
	 3O1O+eRNmlKSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DF4383BF5F;
	Wed, 30 Jul 2025 03:39:59 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cpu update for v6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <aIhyoX_qXX0GLrzR@gmail.com>
References: <aIhyoX_qXX0GLrzR@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aIhyoX_qXX0GLrzR@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-2025-07-29
X-PR-Tracked-Commit-Id: 5bf2f5119b9e957f773a22f226974166b58cff32
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4dd39ddeb68fbb6d068611f2cc647948dc7dfca0
Message-Id: <175384679782.1749338.13379419298005491204.pr-tracker-bot@kernel.org>
Date: Wed, 30 Jul 2025 03:39:57 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave@sr71.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 29 Jul 2025 09:05:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-2025-07-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4dd39ddeb68fbb6d068611f2cc647948dc7dfca0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

