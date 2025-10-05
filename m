Return-Path: <linux-kernel+bounces-842381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F1ABB9A64
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 19:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B690A3B944A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 17:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4161C1AAA;
	Sun,  5 Oct 2025 17:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADiBnawS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D3C1B87F0
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 17:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759686219; cv=none; b=eZP+bqEdqJKfG9xZBMqw4CX15PVIEW5bIxWTRkDrrxG7p6k9pnxTNcXnglXth8UFKuVqEySWss2qXKpe2jRyL3T+0zfHs06j5hbWjrGjSklS8DG62/dyfGuxV8MZizRnfxr5qWQEa71+SqIluPGnNKuDcWvbXCTHzfkk57CMxFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759686219; c=relaxed/simple;
	bh=cFE2o0x+VQcGt7DG2+ymoPnxt7B718w4GeltYErUv0c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aA4Jb2M7I7Kpn1X3WK3pxPl7+csOr6E/E6NvwPXFWyhAB+dJ3Uhw5Ps7zset8rCX4qF8Fft2hZBNYcz0qpebArOGPPDxz1Adt/WL80o88VBRl2uVHIrgPcC8XTme0/bAozwqTFZbslkyCPTrRBULNWWjry2t0ma15dK9BNTV9Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADiBnawS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38785C4CEF4;
	Sun,  5 Oct 2025 17:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759686219;
	bh=cFE2o0x+VQcGt7DG2+ymoPnxt7B718w4GeltYErUv0c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ADiBnawSD3TBi8n0gjXTjgLxilJlpYYawq1zzNExo2i2f22cx+9KsKGZoHjcCX47D
	 arBL1+gaTIqg+EBOPWJK5wUq4zIkB1xqmeTxi5HlWZFv+rjuk6vYmj2WKrOVqtBCWT
	 yhm6X41CncaqwGyepf7H1eHtPY+oxRozJSp9uVs2YTz5TAQOtoD7H44i22mvdKUBQc
	 PT2xUIPrTtty6sa3szIZfBhbF9J0sHo/yhrPJ/FaSH9qCeGMISPDvEcBmPaLnZeY2+
	 Ixb/lAJG0AGEK2VliVyqwGLGDg5OWcO9Bnxkdcyg36UlDgVYqZVnYZx6u9f33JGCzv
	 p++cxs/SyhOlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE8B39D0C1A;
	Sun,  5 Oct 2025 17:43:30 +0000 (UTC)
Subject: Re: [GIT PULL] tracing/tools: Update for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251003104739.3d09e60e@gandalf.local.home>
References: <20251003104739.3d09e60e@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251003104739.3d09e60e@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-tools-v6.18
X-PR-Tracked-Commit-Id: 05b7e10687c69e0c28e62b9a74ce78b3e7463806
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d9f24f8e60798c066ead61f77e67ee6a5a204514
Message-Id: <175968620934.698585.13718677167695967011.pr-tracker-bot@kernel.org>
Date: Sun, 05 Oct 2025 17:43:29 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Tomas Glozar <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 3 Oct 2025 10:47:39 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-tools-v6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d9f24f8e60798c066ead61f77e67ee6a5a204514

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

