Return-Path: <linux-kernel+bounces-847437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8AABCAD41
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 22:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 51E524EEB26
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 20:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FC82727F9;
	Thu,  9 Oct 2025 20:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hO+VtWwn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB5F226CFC
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 20:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760042770; cv=none; b=XBiEI0hZcLmuV0q721tLe65Wv/Saguw3irtjClau1riiSfKQA4g2iuiKO+AIYUI2Ff55qci+5Vvj9v5NOOR/EX1aUOHZ4LhbCulDUe6SzGIOZsG02kh+QzwQJRu0fWHiIkUXg0sBEuWiBd4tYuTxGkTWq6RlsWcaQBKyVznITVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760042770; c=relaxed/simple;
	bh=XoN7SQ8xRFE9Yp4i0YftFZnRqVsvgZLeBlQk65puW0A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Y9/f++V15Vnhp9CYOStsRjZLrO1i1jexBGUqUg9PPkNw+FnFiyleEFRMBkqO6mnV/V5iN5kvWSOYq67duX1KDo8z1V1gUZDqyHObIeSd6iuKTnRFBbqKBKXCzF9+2kGcuUPiNLtEyUwWdyKe/YRiCHK7Kb/jAlvhRKupSGgn5KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hO+VtWwn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91495C4CEE7;
	Thu,  9 Oct 2025 20:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760042769;
	bh=XoN7SQ8xRFE9Yp4i0YftFZnRqVsvgZLeBlQk65puW0A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hO+VtWwnkJGffnCXjZMR/1A31xKmMRTrk0ZRvjYpO6SRvDuOsICgXyCpHkZ7BMy9X
	 JSDFAD5aNI+h0tOQg+sJoZLBWtgE3kQRESnVCWI+ABYhhSCUoX6ZYWAjRoFybEEvOu
	 clNyYWh3WSbNLR6r08VYy6mPiFd783/JyH7gSnaqQzs9mCENW4tqt3uSvyGgMMJOHx
	 N//muewcgAZVaE4N32S5x22hL1z0mkkQSbxNTQjDHdWmHHSHZS7Fm0V6bYAMLihdbX
	 8XCxMgvhIyXA4EHf11kR5xHpmapNruWBBNpzLuCAUpKOJUzsMIeJ67/oevK94DhYdT
	 kjInbsy75JuSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEAD3A55FA1;
	Thu,  9 Oct 2025 20:45:58 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Clean up and fixes for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251009114001.30ae38bb@gandalf.local.home>
References: <20251009114001.30ae38bb@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251009114001.30ae38bb@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.18-2
X-PR-Tracked-Commit-Id: 64cf7d058a005c5c31eb8a0b741f35dc12915d18
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5472d60c129f75282d94ae5ad072ee6dfb7c7246
Message-Id: <176004275713.271849.15099329175647561813.pr-tracker-bot@kernel.org>
Date: Thu, 09 Oct 2025 20:45:57 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>, Thorsten Blum <thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 9 Oct 2025 11:40:01 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.18-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5472d60c129f75282d94ae5ad072ee6dfb7c7246

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

