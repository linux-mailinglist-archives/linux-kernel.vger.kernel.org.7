Return-Path: <linux-kernel+bounces-838271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF06BAED8B
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 02:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17C5F2A03B0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 00:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F171D54E3;
	Wed,  1 Oct 2025 00:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2pWkzBk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E8E1C84DC
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 00:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759276960; cv=none; b=JaffH9CXljzYD8mh62MbHIP8EdEwCIHwYBu/dcmJ0Rqs4ZgyB93qWjthAL8f1n5nbNI5lIfXQIJ+V1qa9ZBpp0yguZOyzDFd7zwPx1Wm3Zs8zdvpkdGwsePZCcsEsig9idnXDISsNZKVcmckY0E4qidM4Nyd4/FESq6kxlqsQFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759276960; c=relaxed/simple;
	bh=zBxm9dTGEC87pwvulLkK/85NAEb904rso4YfJ//y0tM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=I6oV9w2c2YFSyAxoIB2K4JAEru9jgnacXXViF60606S6gHilXTAW4jisJybA9rmfIxFp6bVkUzSBaFlyTfp7FCumH9BbhEUyUqdV4284hygKlPaeZtVunZWJxLMjlzMzdWV1xd5GfvQ6FpvMJrfVqORe77DvFkRNYZI3O1jymOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2pWkzBk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED9EC4CEF0;
	Wed,  1 Oct 2025 00:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759276960;
	bh=zBxm9dTGEC87pwvulLkK/85NAEb904rso4YfJ//y0tM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=a2pWkzBkaYY1SqLm4XTjeKy+5aSwLBsiKwpb9poPWDO5nE32NzrY6WjfuPeRriUSD
	 JqpzKJEVQQlkf241Z4zkZeDqjRQ1kpmPomSKehVnFykbuulQo0rBfQorMSjCU8/Jyi
	 3+aKKhOrtlNQLe7tJ4hMsXHYxTcyTzgxueIHdsosRPEJIo3m5/EtwhkJklOFMmJjzg
	 nfoa5XA5UUH2N8curFQe88esBTH2hiH2ra9Ngcpa5OV8vyk28zhlNuo3pbI3aMR/Gm
	 4Upby1ggwV4vPf4alicesxJOE8nazNdBbbVCvxFKnodHxN7YHtWOimFX2ocTRVmax+
	 mFGVjsKqsyHKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B7139D0C1A;
	Wed,  1 Oct 2025 00:02:34 +0000 (UTC)
Subject: Re: [GIT pull] timers/core for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <175913808853.495041.3476262549602040220.tglx@xen13>
References: <175913807599.495041.10251515322736195577.tglx@xen13> <175913808853.495041.3476262549602040220.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <175913808853.495041.3476262549602040220.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2025-09-29
X-PR-Tracked-Commit-Id: 391253b25f078d2fe5657a1dedd360396d186407
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5448d46b3995c0b477f6bb04f313af3d57665c4
Message-Id: <175927695315.2242674.16473420591460886236.pr-tracker-bot@kernel.org>
Date: Wed, 01 Oct 2025 00:02:33 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 11:29:08 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2025-09-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5448d46b3995c0b477f6bb04f313af3d57665c4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

