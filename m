Return-Path: <linux-kernel+bounces-891615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA74C4317B
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 18:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D183B97B9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 17:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CEE25B2FE;
	Sat,  8 Nov 2025 17:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1NkWc0J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3871F25A32E
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 17:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762622151; cv=none; b=PydCcod6XvzaAWxuUMFGhcE06IHBelQ3CwKUk/8VP6LYCMdJ67vRfuDBwcX1hfu373drxCuFry7OiSPxTc3CTs0Hny3nzY9xXdMKgrIaxPuMIN3VctX+EPA7NxyyBbdMDxAsicvj5fACtWreWxrZbreZmzjQ7bFCUAShZXMQGI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762622151; c=relaxed/simple;
	bh=too9P/2pHlgLNEdow54zriFUGW20TzbraYbqUw2AABI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dvr3V8rPOnpgBqRCEyr8sGqvQEnm5EuXsMqAFM/qXMiIDKzf9mPWAbEnrW06zX9uzUSxO8bl6e+jZveb3l8v9xahg5YNAJZW29EGYGSQ1eYIpL7niNO/4SmZqloTOoWXQb+X5Ea58F9UgqHzSdT/UpfpKze30uMrtKiQZZLFvcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1NkWc0J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78B6C116D0;
	Sat,  8 Nov 2025 17:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762622150;
	bh=too9P/2pHlgLNEdow54zriFUGW20TzbraYbqUw2AABI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=f1NkWc0J/MxMVt4Fg8wp4EQBm+B5uHWc0OTReyhLPruLLAlKu3Ksd8XlWurPb8QaM
	 PR7WSaWlIHnPWzPA1Tid5tNx7Pb1fdrBa10FxdJrJWEP7kUnUamImYfVWV/sMUdnux
	 2cOyDTb0wXzSlbb5ST7Ne90LJyQCmui4VBKhiv21RK6m9NMDIMe1gSMK62klc6lyBo
	 yurf8pjE6RduWylVH8ypmcWNm9+dqTWbEyynC/09YOqwOboVxx79mSqee5UD5DpXwd
	 xB3rR3WGHxyHqLSsLWsQDbUPsQ0OCt0s+VM0pxlGFiVviSNPsRgb3VMWYcco1v4jX+
	 E7BHFTuwf9TMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE1E3A40FD5;
	Sat,  8 Nov 2025 17:15:23 +0000 (UTC)
Subject: Re: [GIT PULL] scheduler fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <aQ9BsTHEl9jdRtUm@gmail.com>
References: <aQ9BsTHEl9jdRtUm@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aQ9BsTHEl9jdRtUm@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2025-11-08
X-PR-Tracked-Commit-Id: 956dfda6a70885f18c0f8236a461aa2bc4f556ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5c0946029200d93f1239d3f310efa3f075abf79
Message-Id: <176262212259.1365123.10100731159720225259.pr-tracker-bot@kernel.org>
Date: Sat, 08 Nov 2025 17:15:22 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 8 Nov 2025 14:12:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2025-11-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5c0946029200d93f1239d3f310efa3f075abf79

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

