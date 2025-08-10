Return-Path: <linux-kernel+bounces-761335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B92B1F888
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 07:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A09189AB52
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 05:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3333F1E834B;
	Sun, 10 Aug 2025 05:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiOpjmAV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B2A2E36FF
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 05:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754805497; cv=none; b=uaC68vNHx9g08LDQ9c0Iv7cCYpql32zpu03iiL0Aj9R/keJdA/OOyFunsS7XgonO3u8JNuRwhGcDMSDJPSxPXEq5u9StywDX/MvKKYB/IU/KaNV69vpHzpYTOqCQYRVALj4TXVv9EV3l/OrWU5Qc94cRSIJI6m7IgVfvxmocGZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754805497; c=relaxed/simple;
	bh=bM7QRQRqvMX3vxao/9xxxXgJbhqQW1BIykD3AE7NrCE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pngXc8HPQH6xhyrn7C40P0anqLpn/HOmBDoa7biClOasYY1J+U935knm2W/7T7ZmFd9Aazf+4bIPwHEhZr/MHCP3UXzoY3phqZWJJnVonfi6kYMiFBphCLkk3UZIc7JP82yhbR9EXO70fVBHQcEnw3JJqUaLT0OykXtve++FM+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiOpjmAV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C223C4CEEB;
	Sun, 10 Aug 2025 05:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754805496;
	bh=bM7QRQRqvMX3vxao/9xxxXgJbhqQW1BIykD3AE7NrCE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TiOpjmAVN6+e/sdN+2gt6GRnC+kG6exFFzhsM+gWbyVmnzs45FJp+y5jSE19sDfdC
	 A2Qfn81Y4tfVj+ggkR1cWAiqFdRZ/Hh23J6MlvI32edeFpeeIPAyMu9C2O9CofaeWT
	 /V5HMw8wzl1f4R1HcCXsIrNWCoaOy8rrlNekYGi7PxJvik8VpCQybCBbc2UbSQQwS9
	 93No79iCoxRQ6uQbLd0Hjhku0hKfN0Ma9Zl2DenTCBqbeQ3AgB6y3vxNl66+Q6PgtN
	 lHllAjJRFpY4D1dBdSMTlhc4sDdiHTO5UsqZ3axVbGDcRvgq1+/kDG/pq61dSma2Ux
	 xzKy8OFstcMCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D31383BF5A;
	Sun, 10 Aug 2025 05:58:30 +0000 (UTC)
Subject: Re: [GIT PULL] locking/urgent for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250809180207.GAaJeNHymvt6gaR5nY@fat_crate.local>
References: <20250809180207.GAaJeNHymvt6gaR5nY@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250809180207.GAaJeNHymvt6gaR5nY@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/locking_urgent_for_v6.17_rc1
X-PR-Tracked-Commit-Id: e703b7e247503b8bf87b62c02a4392749b09eca8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e8f6b635fae254252f7f52dd3e79fb68d06c332
Message-Id: <175480550879.677104.10321340532424818089.pr-tracker-bot@kernel.org>
Date: Sun, 10 Aug 2025 05:58:28 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 9 Aug 2025 20:02:07 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/locking_urgent_for_v6.17_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e8f6b635fae254252f7f52dd3e79fb68d06c332

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

