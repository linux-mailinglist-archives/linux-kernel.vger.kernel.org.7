Return-Path: <linux-kernel+bounces-804720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA20B47C0B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 17:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 546143C1D2E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 15:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B5C27A919;
	Sun,  7 Sep 2025 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmKSFUc+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7201F53A7
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757259140; cv=none; b=YEZzg1EtykrzrUdwCVQ+Zow33CbrdBlmr+BYaFdKlpBXJy1RKTjlcEqycyqsYs4hBeXHLkWX3xQWMh+yz23gkdS5Y6hEiMyn/DHV/6QaHNAXUyjJ7phHONeiDYXxKFI7+Ytgkwq7LEM0IHJCxSqSESxX+RJ7JGtR1bMbOmL+o+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757259140; c=relaxed/simple;
	bh=B0h1FblSKS+rLi8esEG+EQQoZ9tR98HvceRJjIrjAes=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kXr6+5vcUdOPlzLvZopmg2tWXRkBPDbrdjKURqFCy4GAog416vt3j3PT+3g2CJg8JwuQEMca4Qde4YjNAyoVY1KyMLoMU77TrBzty6qtD6tQdjqalbKu89z6K6MzYg+kYsVUa51KvpwVX6vVJkC6cZ8MyzP4vQpDnC+/jDp64gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmKSFUc+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512CAC4CEF0;
	Sun,  7 Sep 2025 15:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757259140;
	bh=B0h1FblSKS+rLi8esEG+EQQoZ9tR98HvceRJjIrjAes=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XmKSFUc+sfyBepNKFIRTl6Q+V2G8aiAgFtXKydP3e4QtQBON/Y6Ft97Tm8/I0FU40
	 Gqzr5WPEMCUrRyUZx9YlvucJlHkVyXWQxe4opMV8bv5bn/iVHXGLRdGM1B5oc4+izZ
	 XH3LpBSEYtcLKAxEkYQtYKhiZ/cPYLEnKqDCwkexuMVqOU4DCTglmlECYq8GiYPoZA
	 wL+bqS8Z042LaJxIt6eQecHe5KaVnhNvYzaMX/Tox9WWP4cYwC5HGQWWb4E33Cz7qM
	 Ap+mDIqqCCQ87Tpzu62Tqynv+EXQ1/qsKSaOTVZwygbCJ+aRQt9u2wS0sv/6+akcSM
	 9IfZijzZ4T9og==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D30383BF69;
	Sun,  7 Sep 2025 15:32:25 +0000 (UTC)
Subject: Re: [GIT PULL] perf events fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <aL1ZdR3wSzsHSngc@gmail.com>
References: <aL1ZdR3wSzsHSngc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aL1ZdR3wSzsHSngc@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2025-09-07
X-PR-Tracked-Commit-Id: 18dbcbfabfffc4a5d3ea10290c5ad27f22b0d240
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a8a34a56a07eb5f0b9c41b1f1e6909e372122cd
Message-Id: <175725914393.3081192.2306399986411673033.pr-tracker-bot@kernel.org>
Date: Sun, 07 Sep 2025 15:32:23 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kan Liang <kan.liang@linux.intel.com>, Borislav Petkov <bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 7 Sep 2025 12:07:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2025-09-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a8a34a56a07eb5f0b9c41b1f1e6909e372122cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

