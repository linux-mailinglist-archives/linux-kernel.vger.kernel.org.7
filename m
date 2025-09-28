Return-Path: <linux-kernel+bounces-835513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED26BA7566
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 19:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D32741895086
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 17:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E41235C1E;
	Sun, 28 Sep 2025 17:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1VunCp/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EA322FE0E
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759080700; cv=none; b=TFnnGT9A4Z1AFGhDfqS7Och4oML815dp8rDlve59MN6HbRjOpg+K16IwGBlkLBJDTFUsJGmFjvvZDTnSbqi5uTeOMouAo7lHWHCXrv0x3nCaI97S3BXFdsq913EP2i90mfUNzUDFz/Q3GavJNZfqYcyqFRxWDRhIoLNGBq1DrTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759080700; c=relaxed/simple;
	bh=SxLM9p2/B/raK247XNa/cVUkuOoE3JhbPkiEdZAPjYI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MVbEoFqHA3tebBwUNuvthFGKZ0ZYAdveQCI+C8R4+OO2Qbt+NdoNdpajaMikBMDNyhRiPmyPyKKrcMmxhJk6AK79l4xnXhXmpKttIb0w4irwyKecZTa6Fu1jXJQ8ai7JO487g8V+kdtYa8t3U3TW6dk4QDS8z+aZ6yN3naSzHuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1VunCp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB98C4CEF0;
	Sun, 28 Sep 2025 17:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759080699;
	bh=SxLM9p2/B/raK247XNa/cVUkuOoE3JhbPkiEdZAPjYI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=i1VunCp/kA17mPJ/T1AoI6mbUpIPfCwRKj49V7Qq3HhiVUu8ZhOFh67drIsu9JrLD
	 RKYOrdKh4JNEbUutcC+xuwraxT2k/gnBDJbjm+pifQdIXx+rW64gfdcZXZdXjTY9iG
	 fhpqnjxPAc05pehc5RPu3QH1UO0Hr2XKz5BbFoAX16QuGOdEWhF7EWjqcdkkAjbq2f
	 pfdW0KZPVZcCD+3L7U7prZTpy38aM2IHfx2jCSRFX2N0KWhVXYsGGtFDq7m7MCeLeP
	 ZAFx47BjqozhcGdeoU1db+1AFf9I2KS8XFj82z+9Gx9Lp7iBHKSXzE8nxpoeQER5LC
	 49xV5TGwNj6hw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEB139D0C1A;
	Sun, 28 Sep 2025 17:31:34 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fixes for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250928084641.7f90db4f@batman.local.home>
References: <20250928084641.7f90db4f@batman.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250928084641.7f90db4f@batman.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.17-rc7
X-PR-Tracked-Commit-Id: 0db0934e7f9bb624ed98a665890dbe249f65b8fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f9736633f8ca0224d6dd0cf6826044b7b5f9737
Message-Id: <175908069345.569924.2359043964024937198.pr-tracker-bot@kernel.org>
Date: Sun, 28 Sep 2025 17:31:33 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, Wang Liang <wangliang74@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 28 Sep 2025 08:46:41 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.17-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f9736633f8ca0224d6dd0cf6826044b7b5f9737

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

