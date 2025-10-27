Return-Path: <linux-kernel+bounces-872305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FA1C0FDE7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBCCA4FA2F7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C642D6E64;
	Mon, 27 Oct 2025 18:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvOfvztv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D9C1E502;
	Mon, 27 Oct 2025 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588735; cv=none; b=Y3uhbHO1zvyXlISLEePsO+fvcEtqXUm1y/LdATcynygD2VrylhMWaznrsFy8rF0svyyU3AHzDE9uHMIil5qYC6u67jj1+i/l1GFdtYPA+hbwq1prIB2/HRRXKH4mMVa7h7lDbhJtg3rYuSQflnPp0rizr9SuXmbD7IfZvSEebgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588735; c=relaxed/simple;
	bh=vLstSCUk1o+6ywkGzzcIFbH8XsDfRUe8i7evrUJc+2w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fOa91CWlXWkYxWPQzAQN++NXWszR7gkjnh8WO67eJ+TsVhoox8NALS9y2aw0AXP2vWJ3ZoQseoGhPgWac+0heFL41i241XtNnml7LWzp3LrG2UJJSPYsMLw2OoKDIjOt6X5WN7JHe/27W5owkkBI/8fX+fbe+hsr0LaDIrA+utY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvOfvztv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42210C113D0;
	Mon, 27 Oct 2025 18:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761588735;
	bh=vLstSCUk1o+6ywkGzzcIFbH8XsDfRUe8i7evrUJc+2w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bvOfvztvnKLeCbmZSJMKMQDdBVH1IAo7qCFyFY51BAFqrZqLkVMRKWXHWRzZRGrfa
	 XcCBJcbtGUVYZSDs56PEQJ4kXcLbtTSaAidgq3nU7uhNQy5gu5zYcO3OrwaLDzd5pT
	 aj3HEqw7YlEg799FKBCdXc/mnsP8OyewMNY9yaHpVU2bJnK/IBcsjG+0yeejjAfzPv
	 FHLojbrkCwCeTxXxKa+vXQ6PchK6ce5ubMYye1KbNnODbTyooXA3anX1Vt0qnRHkT/
	 8goaSv3ktlPApwQjRdDHWsrr/TwT6Qv21gDAnzl8nspNpgTHAdKpFnlS6x2kq+22WC
	 ibRsh0zXtij8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0D739D0C1D;
	Mon, 27 Oct 2025 18:11:54 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Fixes for v6.18-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <36450bebbc782be498d762fcbcd99451@kernel.org>
References: <36450bebbc782be498d762fcbcd99451@kernel.org>
X-PR-Tracked-List-Id: <sched-ext.lists.linux.dev>
X-PR-Tracked-Message-Id: <36450bebbc782be498d762fcbcd99451@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-6.18-rc3-fixes
X-PR-Tracked-Commit-Id: a3c4a0a42e61aad1056a3d33fd603c1ae66d4288
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd57572253bc356330dbe5b233c2e1d8426c66fd
Message-Id: <176158871335.1476308.10182501536965113186.pr-tracker-bot@kernel.org>
Date: Mon, 27 Oct 2025 18:11:53 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 27 Oct 2025 06:51:28 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-6.18-rc3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd57572253bc356330dbe5b233c2e1d8426c66fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

