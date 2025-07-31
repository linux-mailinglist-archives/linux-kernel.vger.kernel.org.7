Return-Path: <linux-kernel+bounces-751447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFA3B169AE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2D381AA5117
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 00:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A17919F115;
	Thu, 31 Jul 2025 00:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0qIsiJl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCA17263A
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 00:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753922106; cv=none; b=AUtQbq0iibOOF6bOyKwW0IwBoT+Xm7fl7Cp8iE3ijd/WnW3FHspJ/q7iOHtsq3gn0mWaaAm6B1TIMtwt6saTGbeXN4EtKCe4t5aND/sZ5RI/qnjKzGoDw5Ujd65HCQ5WUzOeew7csxA0VPJ0hDoS15FmOMeZTpaDaHHIc9LgdPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753922106; c=relaxed/simple;
	bh=V8F0gs44D1YgzmkxpjZnuW/mVZb523X2rz2RhLvc+YY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SjWO2thp4vMfa3rsHecs+C4mvy7GKknsw9hEzvTm2oJ+1axW/NLEiZeJWzM1Y5iKjk3k8mdq/HYMHwE4UwezbaTs4QRyUgIkds4q6GjPKnylcR6SOIvnAEKWbl0Jwss1VhqNJWwXJsxRee5EahywMImksdcE4J/rNfemkBS2bPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0qIsiJl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D54BC4CEF7;
	Thu, 31 Jul 2025 00:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753922106;
	bh=V8F0gs44D1YgzmkxpjZnuW/mVZb523X2rz2RhLvc+YY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=e0qIsiJlJu+WFQVZITkJITxevUNO2M3c/pffuCsM4n1MKw1ZKfvd2BBit9VJoao2C
	 OhbWq7UbhtYI3rAFlgSVDhhJ3T+WjIjIdRWGF14NaggiPFmoOwGuNSj30heko/MTN/
	 uav58tcbmDPkDSu7w6f77NPTX6z9DACyxEOFsWwQBkpPSgSOkEga0bACoCe+qs8YPq
	 H3RYVY8Nno7ZAbW+JMyhCEfn0e99q9mLOkRLQCIfmuEq2LnizD4HnFh4DtneA0fcwv
	 /jE8uw6scj5fLjr1YWp4/8aa1f2u/dY78VpdnBQVPBk61dzYvxIa80pE1JD12uvWk3
	 ZuUe2P08kHfBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BFD2E383BF5F;
	Thu, 31 Jul 2025 00:35:23 +0000 (UTC)
Subject: Re: [GIT PULL] runtime verification: Updates for 6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250729174332.3acd1a86@gandalf.local.home>
References: <20250729174332.3acd1a86@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250729174332.3acd1a86@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-rv-6.17
X-PR-Tracked-Commit-Id: 614384533dfe99293a7ff1bce3d4389adadbb759
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ff261e725d7376c12e745fdbe8a33cd6dbd5a83
Message-Id: <175392212262.2556608.1843795227615162301.pr-tracker-bot@kernel.org>
Date: Thu, 31 Jul 2025 00:35:22 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Gabriele Monaco <gmonaco@redhat.com>, Nam Cao <namcao@linutronix.de>, John Kacur <jkacur@redhat.com>, Tomas Glozar <tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 29 Jul 2025 17:43:32 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-rv-6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ff261e725d7376c12e745fdbe8a33cd6dbd5a83

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

