Return-Path: <linux-kernel+bounces-761337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E06B1F88A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 07:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B20E3B743E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 05:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B781F4606;
	Sun, 10 Aug 2025 05:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqMw9/LX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517981F4176
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 05:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754805500; cv=none; b=rKIkSPKedQ8QK0bGvvE2/YF7R6/ryAA69fJHCGBePQul3Jp1Qj94fQCztaW9XiWfG718kctInod5dTIAQ7rAOevAvXZb9LnRY8XxPQr4im3BWCg/39BoEUQi7SaGhlydXcgz9tvaLAjbDedzA/2ZqOqyCr4TNh/pqR/h9yrKjco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754805500; c=relaxed/simple;
	bh=n6WOmTx5PcT+dfCfbQYJXnkIIiFDF8+oiGquo/9Qni0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SRPyTeoazwyIyhlU8EEEL+RSVCk8QUxhAQL+LNyhzlSLSn67kmQMLRBFBuG1SO8+SLKfDJPMMdb4Wo48HG501KSKBKpN43sHO3DxehGdoh1DSoKKmrmCzI0gSK7lrQmY+XNIFZ+9giWFTvLd/89lM2qqStOGPu9dmB5ch+B4Ad8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqMw9/LX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E3DC4CEEB;
	Sun, 10 Aug 2025 05:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754805500;
	bh=n6WOmTx5PcT+dfCfbQYJXnkIIiFDF8+oiGquo/9Qni0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gqMw9/LXSmOdGSVrpOrRoL6ixdDB89LsPpgzHd1evN0Q/gJh3BEBy8XhxG2f/qU0c
	 vCiUabZ+zdETZnf2B6D64zuo4eQSrmlXoE1rNki+rvjWBiUKnT4oEFtmM3P29p/q2y
	 +Fj5rSzxOGcxrTQBmptjoTSTD7EaaNvsR48gNSfEavIoTdm9vEIAxij4ZB7T0QvbJr
	 4mKodpVeQUSTt98nqAhpvnJMAyEyEj9+SwND2Ee7hZ87M6EIGpPODn3+6wc15R1GEl
	 HIG0VvWL3edBjg8akN62QBhFuuKDh+MTpHmd+Dhb545DNBSdOjYS8fGEzXIRTFU12Y
	 vg/DH8whrvD5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B61383BF5A;
	Sun, 10 Aug 2025 05:58:34 +0000 (UTC)
Subject: Re: [GIT PULL] irq/urgent for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250809182238.GAaJeR7vm8fTw4FPEr@fat_crate.local>
References: <20250809182238.GAaJeR7vm8fTw4FPEr@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250809182238.GAaJeR7vm8fTw4FPEr@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.17_rc1
X-PR-Tracked-Commit-Id: 9f7488f24c7571d349d938061e0ede7a39b65d6b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7d2fed1f3ce46f7b161e33626b2cffedfa21767f
Message-Id: <175480551276.677104.7332229974651204797.pr-tracker-bot@kernel.org>
Date: Sun, 10 Aug 2025 05:58:32 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 9 Aug 2025 20:22:38 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.17_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7d2fed1f3ce46f7b161e33626b2cffedfa21767f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

