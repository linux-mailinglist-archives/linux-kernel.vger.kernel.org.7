Return-Path: <linux-kernel+bounces-842380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 146A0BB9A61
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 19:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7DDF4E33F9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 17:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EBF1AA1D2;
	Sun,  5 Oct 2025 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjOXwlwe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77FA1A08AF
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 17:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759686217; cv=none; b=naeozf5i4m4C1n/GP75mwWo9kfcEGdDlXLRzm6boOIe/yJD5/vMNRTB40kJifNDnCAWKRp6fKKIYJjWAmEjpIPNxA/2ecLqUp5PXgSKHfCMsx3rWgIU2UTHlD++L3Q2rB9qtyQhwSV4RCjCJPlGWxYKjSC5AWtMdHXuWXShVdcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759686217; c=relaxed/simple;
	bh=+E1AO35650eQSjVJj/SF21gzXFcHrBe7ZSV7HtY2wzs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BfP1naeoDGLZxucE1EuDAhOcTOPfgxtlhjrQubOmIIi+LDLQmTBhgv0gwVEHpNHZbK98N9wwVAsbSPl4zGls0m0C+rAZEUhCn/4j0E1L6oyPKr9bm0j0pE2HZtn1qoTw2CnGP8kvrWsu26a5n2eNSXZIBsYNrSAKj5qfGFYvYXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjOXwlwe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B268DC4CEF4;
	Sun,  5 Oct 2025 17:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759686216;
	bh=+E1AO35650eQSjVJj/SF21gzXFcHrBe7ZSV7HtY2wzs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LjOXwlwean8+xhwMcjQql9h/cvlcR5T6iW8/6EP5Px21Sbt/cb9Xbv4mF5JdMQ/5i
	 0rYkModaNHAX6yUcrKANRQYBsZTKpVM+y4jg6rI8BRN2jkHNLVajPKiR+VzEVmhqdE
	 reZxqs7YCrof/W4cmWiuu9S0olbVCzA/Be/x+r2JFqcLIf1rQgJEyeAu58IewzMD6M
	 7Je1+407GJQHh9dMbtdR5/gncI8GTXCYgAesKKHAJVIBHbLXItdC0flshBBKLJ9mYZ
	 lFWCQ9n/JNcT/LYwg2/cY7lPewFga8ldFmTso6TlFaJqNSxYnDohxoqEs/l9TfwGpz
	 21z1L90vUEscg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D1339D0C1A;
	Sun,  5 Oct 2025 17:43:28 +0000 (UTC)
Subject: Re: [GIT PULL] probes: Fixes for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251002232624.0cab764496b996a63a4cea4c@kernel.org>
References: <20251002232624.0cab764496b996a63a4cea4c@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251002232624.0cab764496b996a63a4cea4c@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.17
X-PR-Tracked-Commit-Id: 9cf9aa7b0acfde7545c1a1d912576e9bab28dc6f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2cd14dff1660f80e81ad914317872686ebcdccc0
Message-Id: <175968620687.698585.8661785308526014879.pr-tracker-bot@kernel.org>
Date: Sun, 05 Oct 2025 17:43:26 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Yuan Chen <chenyuan@kylinos.cn>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 2 Oct 2025 23:26:24 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2cd14dff1660f80e81ad914317872686ebcdccc0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

