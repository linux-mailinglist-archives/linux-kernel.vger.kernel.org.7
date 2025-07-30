Return-Path: <linux-kernel+bounces-750149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1E7B157E5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 05:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1EF718C0412
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 03:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593711E51FA;
	Wed, 30 Jul 2025 03:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnAdv5zv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD3E1BD035
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753846771; cv=none; b=pvfvon1k8yWZIhDzQF+7DBp6OaqAR55UwBz0nthfA1NvggI6z6rA+kWKPOu8uGqoY5Qmuh/ukURUKFPg2K8sqEvyJ3UyMx8nYIxq6H9ApOJuT68CnmbN+RUY1SwgEJeoljYNIFuvahCRJyhceGMx07SCVBA2nG1U7Ada7qtigqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753846771; c=relaxed/simple;
	bh=G125Y5PmaFiLzTFUY39M25EhzDSrNTx3wnmkN3GmjRs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BHP9XWCSkrlMXWkX5JC27QCRLafGR9WIdpI5nGredagug5C/X1vpQMrwhwYwNdRwgi6dlEC8FTMqGt3e24C+HmUK0RHfUt17uEPQBEW/+rOtab2OsxQCDN+gWg1hs4k+bUzDh2kjXhZ/1zWgiZGHo6S0/R9kn0TuXlCBwf3thtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnAdv5zv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3DBC4CEE7;
	Wed, 30 Jul 2025 03:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753846771;
	bh=G125Y5PmaFiLzTFUY39M25EhzDSrNTx3wnmkN3GmjRs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GnAdv5zvwLAJFSXwvZ4u/25jaT9B9Afa+3Xjb7H7mLjX6JglOGVJ/fGVwSpJfpIdB
	 jYPeKCUSEmyrRGzNza9mYyvu+bwUEkKRFWSpywDsUDtkGkAV+U4jjMzwgnF/9nnPtE
	 SyhES+v3TSQyNbhzEEBM1LT87J9JF65nf2IZcz500lEHlHXVbSk9R0eZqVIDRcZeaZ
	 oEaaObjqkkhI/dCkW5v8Nu+x1MnO9pdQ+4X7+vVmILlnmLCqyDiqSOQT1sqAMQPYN+
	 D29JGhKmTrOisaCMDAAvj6QjVUfBGXaBqUsuGsBwcGY+328EO0KBuEc+ihTFMHxiOa
	 XFZ28spzMBLnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACE3383BF5F;
	Wed, 30 Jul 2025 03:39:48 +0000 (UTC)
Subject: Re: [GIT PULL] Scheduler updates for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <aIcdTI3e04W_RdM_@gmail.com>
References: <aIcdTI3e04W_RdM_@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aIcdTI3e04W_RdM_@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2025-07-28
X-PR-Tracked-Commit-Id: 1b5f1454091e9e9fb5c944b3161acf4ec0894d0d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf76f23aa1c178e9115eba17f699fa726aed669b
Message-Id: <175384678748.1749338.1418715514404221547.pr-tracker-bot@kernel.org>
Date: Wed, 30 Jul 2025 03:39:47 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Tejun Heo <tj@kernel.org>, Valentin Schneider <vschneid@redhat.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 08:48:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2025-07-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf76f23aa1c178e9115eba17f699fa726aed669b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

