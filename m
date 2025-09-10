Return-Path: <linux-kernel+bounces-810902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B94B52149
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 21:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EECE1C861DC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC5F2D8DD9;
	Wed, 10 Sep 2025 19:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWNDCqrJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB5A272E7B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 19:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757533354; cv=none; b=S6r5uY40Hc6Am/kh186D8ws4OxEkFSmXulFTm/cVYR1+MREcPuFVbiXUWtQstgQBEJQwJ5bxZMA68fu81ltTrIrSgd/fmb2Y34DVGDrOt14qsD09w6eehvFAioWLav2R+C6sCNLKwnu4OcWtEyli60Zn6+qYuTQm1dgZhu9eRhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757533354; c=relaxed/simple;
	bh=U9uiYWzA7lvJTbGljXQI0WJ5v77yEF20j/zspzqlFdY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EGIzaXkN1OO5K3HJU3CZl2pCqv4dEbQbxZlCRgJmj/pXatd7ojNqv0ScfLYwDQrcbPV2i0G7ANEMVg0130tn0HOwA/X6VZn8RXfcfBm1WsCE1l+82/BRh4C3OHSAOIYlDORkrRjdV5hz80IBCNPhZmUl6ZuoJc9g8rqg1B5aXgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWNDCqrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A50BC4CEEB;
	Wed, 10 Sep 2025 19:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757533354;
	bh=U9uiYWzA7lvJTbGljXQI0WJ5v77yEF20j/zspzqlFdY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aWNDCqrJ/g5XAc8P6LPtS4+SUMUPiakflumDZuZieuOvUzvb9WcrYQZV86gKZIc03
	 1jEz4G0EsHpg3R4CAdfOCVGkVUhYPQ3V10uQfMkK8ocRq2ucy+UqwzHaeuX3cpZY7j
	 bbQ0qTHex2bfapibWH9LaDcQiNYO00Lf8sxYxMEqLghrONKWT79jeS5PPlWzSb2xy7
	 OEgRq3O/0tHiIRoDA9RuAPAQzt9WqlB5fZRJtiv1vzc7UWkfqpFz0Ox6hRJleMtMF9
	 V+GiB2Jw9DIEN3Ekv2UmVj+RDJwmxU8KMS1J7VD3Sfj2eXZTZqMly2tTEsBxPeQl/n
	 XqdlJ94+kFfhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711ED383BF69;
	Wed, 10 Sep 2025 19:42:38 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fixes for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250909162155.76756fe3@gandalf.local.home>
References: <20250909162155.76756fe3@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250909162155.76756fe3@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.17-rc4
X-PR-Tracked-Commit-Id: cd4453c5e983cf1fd5757e9acb915adb1e4602b6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b5d4661c7ee7937d062a00bd336761a237870b4
Message-Id: <175753335700.1546567.17589273178996517005.pr-tracker-bot@kernel.org>
Date: Wed, 10 Sep 2025 19:42:37 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Guenter Roeck <linux@roeck-us.net>, Luo Gengkun <luogengkun@huaweicloud.com>, Pu Lehui <pulehui@huawei.com>, Qianfeng Rong <rongqianfeng@vivo.com>, Vladimir Riabchun <ferr.lambarginio@gmail.com>, Wang Liang <wangliang74@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 9 Sep 2025 16:21:55 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.17-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b5d4661c7ee7937d062a00bd336761a237870b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

