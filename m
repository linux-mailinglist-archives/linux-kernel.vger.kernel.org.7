Return-Path: <linux-kernel+bounces-834627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5ECBA5202
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 22:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87798562092
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3336230F93F;
	Fri, 26 Sep 2025 20:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f73ueTNk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD3E30F928
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 20:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758919477; cv=none; b=dTQjCVSzqfcr/PLhsQn9FGta2UvQx0rzcGq9/Jp1kQKbkyfny39Xi/zpw0gE3cBFFFS698wfwFqouAXsRdPZKYVdzHSMXcjEtmxe549WGz5HJfSyqJsjepVmhuSebATAfs6lhKDxhvDFa39eKnOLBP0NpfLrwMKvi6Qbi+uida0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758919477; c=relaxed/simple;
	bh=cfHBlTudGjNBnqSd1MNUOS0qqNKKEfRwNsYSQ1EW50c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TrXSxLcYTE7GjgyW6Jnm/hQzY1QkBoJU2pEoptaCfNtS2aZf3NqZRM0/WUXSUoQz9ftKW/5yWpjUQT7TKju/r8Og0E8VufNbeoUzDij7BGWHKjLUIJjjQ1VzpWUsFJF7HkvIoq/D9idVAEr999b0mB+J3jDEv3AA20P2vG6z8S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f73ueTNk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F071C4CEF7;
	Fri, 26 Sep 2025 20:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758919477;
	bh=cfHBlTudGjNBnqSd1MNUOS0qqNKKEfRwNsYSQ1EW50c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=f73ueTNk124cM1rnsp3itvZzzuaqTpAqRSewHVBFEnynRf7gasixEMcjzi2nZEvwg
	 Hjp2PNu78QncapEvNKQSbpLs5xPImSnPJRaiesWBLqx02BraYnJ4OiGB5ZLQErNOmt
	 V/GbnO1VLpS362Nql2VWe9QQHEiGC8MDGN9EnOcZA5903iUzZMVda52jCn0eBE8PuN
	 xolsxjwwYmiL/IqDuChcowOl6cqvrVOhn+O7l52QXSgOAp2n3OfEOwsLaoUOMhAVec
	 fYWFHHuQ6qE8v4vg5yQq1mu65m2oc9NC3UPiDcEov90EuC8mXqkS5019lDTwah6u/w
	 bPTO07P6bBvGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE4539D0C3F;
	Fri, 26 Sep 2025 20:44:33 +0000 (UTC)
Subject: Re: [GIT PULL] scheduler fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <aNabbF7OMW396Ve_@gmail.com>
References: <aNabbF7OMW396Ve_@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aNabbF7OMW396Ve_@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2025-09-26
X-PR-Tracked-Commit-Id: a3a70caf7906708bf9bbc80018752a6b36543808
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 083fc6d7fa0d974a3663b97c8b0466737a544236
Message-Id: <175891947253.51956.12690898740078426602.pr-tracker-bot@kernel.org>
Date: Fri, 26 Sep 2025 20:44:32 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 15:55:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2025-09-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/083fc6d7fa0d974a3663b97c8b0466737a544236

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

