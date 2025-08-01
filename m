Return-Path: <linux-kernel+bounces-753707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE148B186C3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70098A874A1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D21A244665;
	Fri,  1 Aug 2025 17:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IC/YdeOX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF32B1C3C18
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 17:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754069702; cv=none; b=X2X6zNuW4xrvPEbbhmSWYk90y0D5JYyHV0mzcA3JXyjogd1b7p3odOOWuevqjSkMZLG7HDVmIzO1NPjYk9h8MBlwYk/SEJgoDvNkSnvlwnSQHKOF3i4cbFbePhZJfCtvwvHqhnV/bBMppWQmFyaNRAftLg0Pd94Lxk/cxyzcfCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754069702; c=relaxed/simple;
	bh=qkeoCHgHpqUstTjuObt9Z2sbaSOPcYeWU//AWm0jLsQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XzawCIOjEWg3M5PYVSOUogwLqLloMLft+2SB300jgZuNC/h1p5tCRvrhgQIQakT10l9ka5tFZ9/4FdlniRELAhSp20VRfUDzsNZzeBf5BIvwjY3Q1gFFnd3Y/JuDiF9ArPfO9fVzq7liBC16CzcU2oWLPkxo9xw4kI+KHr+Zf+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IC/YdeOX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9797C4CEE7;
	Fri,  1 Aug 2025 17:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754069702;
	bh=qkeoCHgHpqUstTjuObt9Z2sbaSOPcYeWU//AWm0jLsQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IC/YdeOXEU9IsWrXVG6fs1z2Wdeyf6QmF7cm1U5CoUk+5paKnN9dqNSGFLyFCLVzy
	 lBpxpvn9aRdiimE9XFZTtgnNDdiECvWxTJbBVzkCkRSskqW6ep/PX32vCWpVk8C3j9
	 lUWW3LomfkmEzCoi/Z1TSjH0TKaTr5ITq0xmKdbIi9pOuiQv/uCBPPhRPL2D7DQelb
	 xN5SfazZUWKeven12FHALXJI+lfzF5KEcSCHsD2Rxi/bh5Qh+vqm3UQtlaoTJwaBMX
	 bY0iUWubkX+PqI1ZerkiK9luIxJBknTMSjZMyfxQrmNRUHIYpnxXOl25tfO35YIk1F
	 glD8r/b3UISPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341AC383BF63;
	Fri,  1 Aug 2025 17:35:19 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Updates for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250731101717.6c340b66@gandalf.local.home>
References: <20250731101717.6c340b66@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250731101717.6c340b66@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.17
X-PR-Tracked-Commit-Id: 623526ba8984cafdffa0eba7ee424f2e40c8a219
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d6f38c12396397e48092ad9e8a4d7be4de51b942
Message-Id: <175406971775.4015829.8447100812285833987.pr-tracker-bot@kernel.org>
Date: Fri, 01 Aug 2025 17:35:17 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Nam Cao <namcao@linutronix.de>, Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Yury Norov <yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 31 Jul 2025 10:17:17 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d6f38c12396397e48092ad9e8a4d7be4de51b942

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

