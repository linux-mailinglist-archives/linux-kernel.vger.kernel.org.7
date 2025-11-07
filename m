Return-Path: <linux-kernel+bounces-890747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8CFC40D42
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 17:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28C994F6088
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 16:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F7B2571D7;
	Fri,  7 Nov 2025 16:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAPnwUEW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924F02459DD
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 16:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532123; cv=none; b=RooFup5vGxmakt/S6sEihE1nxCRiYsdxj4how4qNJKCPE/FLLjUeIIjCmw0pszK937ckioE/RDapiOnS/WnQowmXZeO0s8ZZqlAlXdoCrVh6EOPVgsdi9L+O/kWkeuUX3FdsQFO1AYbyXUlW2Rgj3iCjzVYBDjag5XYxHXsYsyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532123; c=relaxed/simple;
	bh=ys8dgtD3RUaBzNc5Xsrp8F5DAsv+9q2O+B6OqqyIe/E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=k5T77B8Zwrpd+I7srdpk1crjM/5COwJv4t/dW3oREbge9D1hidu5O+5x0QI3klwCDOtbpXlBEk4gGit5Zd6pgfsVkmtBOMdIKtYX14Ry/YLeTGQxRhk4ClS5glx1lwtVE2x2hFRhnOcixhwEtmMkEJ4pXyrzEwgrflPoB1IZlgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAPnwUEW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1ADC4CEF7;
	Fri,  7 Nov 2025 16:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762532123;
	bh=ys8dgtD3RUaBzNc5Xsrp8F5DAsv+9q2O+B6OqqyIe/E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FAPnwUEWsXLlO+5OVlMo47VATplsbZZuXzApsP5Ncrc9fbQXYKjwbcSogadHY8elh
	 8V02lSvli1iVfq4xgS3WQExa7wTiQMdIaCuEyplmhkgCXElCMW1KpHD3uiwYY7IOqn
	 8Moz5+2atqkYKsEJYPDu40A+Kh4n4eCHHztbNNQbDEd74K4BLBCVoPua5u5Vi+iA8+
	 Dw7Ib3NLq647V2sQxgVfmr7FS1B8KliViQJWFv6fBvoiCohygHPbCOGzQFQ71LUNnM
	 aAVbZf1N8QR/FRPeDHkSE+SlgzF/LGyJ6n8CpflCG8TCZ9W+pD0osFalLNcvvu62iN
	 ZLWgczWmuQ5YA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB13439F1DED;
	Fri,  7 Nov 2025 16:14:56 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: A few minor fixes for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251107082444.45c4536d@gandalf.local.home>
References: <20251107082444.45c4536d@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251107082444.45c4536d@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.18-rc4
X-PR-Tracked-Commit-Id: 53afec2c8fb2a562222948cb1c2aac48598578c9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b95a50001f1fbcae6b7fe211a02f37a04dd9a4b
Message-Id: <176253209553.1082484.16063175408614996604.pr-tracker-bot@kernel.org>
Date: Fri, 07 Nov 2025 16:14:55 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Tomas Glozar <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Zhang Chujun <zhangchujun@cmss.chinamobile.com>, Zilin Guan <zilin@seu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 7 Nov 2025 08:24:44 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.18-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b95a50001f1fbcae6b7fe211a02f37a04dd9a4b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

