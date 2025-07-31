Return-Path: <linux-kernel+bounces-751448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B58B0B169B0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DEDD7B5494
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 00:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49201A3172;
	Thu, 31 Jul 2025 00:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWlBGtRu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81D819AD8C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 00:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753922108; cv=none; b=XnSVqvmIXB93Q99VDUN6/HVEShdf8jdOERZEKUj2/R8kuKwxRdwxSEbuqhswBNRIORzGsosdfgbkOzknMT81xLkGYkNrdp61bNcESmlnilhkE5KoffS6GwOboYVen4CVHUaKKOzbo2VXZFQC2rEydrIdPfvaxIEBZCEfm9xfut0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753922108; c=relaxed/simple;
	bh=V/g81vpq1F3wPru70wItdN4+dPjr6XHTGRSdwY3Va3I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jYUbbZ1qLZ68Y5EBhaKke/LbOHHMX52htv79RBDbO6ucp0lKi0ysFeUauuHdfh0uSGBBx4N4Xy/fNEYDcnUpD91ydmvlCWD+V9mktbM0LCe0I0eu0oyoWPPQggI/SJ6iG8eqLgIV6tFythdA0r9/nP3G3SRhVR7riYN0Q03195E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWlBGtRu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56023C4CEE3;
	Thu, 31 Jul 2025 00:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753922108;
	bh=V/g81vpq1F3wPru70wItdN4+dPjr6XHTGRSdwY3Va3I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tWlBGtRuEsAftX/11YDPMXUYkuzwIhOlzwf3FURNbP5gTIXo3ewATrdAx1ImUadRN
	 wGdg+d/mvpYyBZ4Gre6Hn66bOOS4qgYc7rAbQg03aUN6DL85q9KGBhGKnEliGfDf6r
	 ViIuyQ5j5ZZe3cm3LpYQGMadO52iCfTREL3Ajr5psZXDvfe+Vt0GSJO5WZdWcH5/hH
	 bN8KuGvuJUEZpvxG5MQvlyxlK5dDFCV4wY8X3Z94l28s6MFXJPmZ1XVh0t4Kl6iL2d
	 O3P6Jr5UTx0eSyr0cNFTUnAjh0AJgi0/rKNHxIHXQ+YeOHLn292hSumrvX1mA8OTrx
	 8/CoOGK1OI3/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B89383BF5F;
	Thu, 31 Jul 2025 00:35:25 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Remove or hide some unused tracepoints for 6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250729192922.37db57dc@gandalf.local.home>
References: <20250729192922.37db57dc@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250729192922.37db57dc@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-unused-v6.17
X-PR-Tracked-Commit-Id: c2dbaf0af05193fa69f267c37d1f825c1c3a59ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2be6a7503d32eb1d60b4c9c15547a10d4ec9a934
Message-Id: <175392212431.2556608.3116069199409882985.pr-tracker-bot@kernel.org>
Date: Thu, 31 Jul 2025 00:35:24 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 29 Jul 2025 19:29:22 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-unused-v6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2be6a7503d32eb1d60b4c9c15547a10d4ec9a934

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

