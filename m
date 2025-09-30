Return-Path: <linux-kernel+bounces-836911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC90BAAD99
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 03:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40F1F1922DED
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 01:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28061F03D9;
	Tue, 30 Sep 2025 01:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORf4Pob3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077051A0711
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 01:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759194806; cv=none; b=s3wpV37mixWd51w+50+SvSVesOQber4guGtdG/MAScHqmsbunQMbdhUwexMaHVlHahOI2DtrFb6S6C1WusIw8A/VStWJjTHm/8zyCaJmkg8C1yiXTMRiWxpLEWXmDemcnOXDQiQBHR1zYi/4ZXI1hM1GPWCulKruDtsWYVTgFxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759194806; c=relaxed/simple;
	bh=eBCxCOnqmTgIUmYGCa7sBazMkPDGIL85zjP3cyrjPHM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SVQslhfusmW71QPiBz7FE0zDwZ1QKGDa2Sq+crJsPT6hWYglYleUyPuvRjfJwG8QPTH84v7b/2BRZ3eunBfWLXJUu9Bh4KP9ZTXq67YT2dR3Oxe0ZXWB2aPvDASiEyO62nrVRKw0tosClmxEyTwKQllEANHTWfnNnSAyPSt6lTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORf4Pob3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E76C4CEF4;
	Tue, 30 Sep 2025 01:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759194805;
	bh=eBCxCOnqmTgIUmYGCa7sBazMkPDGIL85zjP3cyrjPHM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ORf4Pob3eX8siaseRJACdSuYd+nGmhxOAReQ992SAb8ZwDG8LiiiMAMWNymYTR8G4
	 C3VySi/DefPdMlI3nAm8ktHlwr+wsTc/8YgduUpzQomfPGOSBla7y7j/ITqK2J+34t
	 DwhAGcky4nM0isdgASbM6BZo9sJGP6ZBSXmW/K9BlcSizloF4EgCPFybcmbWh3/EiX
	 H5NbuMg10MSYumS7sVU9w+XZ8y5nZRfsMzXdxzfL7yH0E37iVOO4RBbjgadf3H2RyS
	 c01Rmf0rNS8OrJR7R3WMx+sF4G9r6WdFTglOJFdjeccLlDpdLUAQb7pJ0OsYbyyJEa
	 BUWGhyxjdY3qg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C9B39D0C1A;
	Tue, 30 Sep 2025 01:13:20 +0000 (UTC)
Subject: Re: [GIT PULL] hardening updates for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <202509291213.E313986EE@keescook>
References: <202509291213.E313986EE@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202509291213.E313986EE@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.18-rc1
X-PR-Tracked-Commit-Id: c8a935a31bc787db52296944890f300ba9479088
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5ba183bdeeeedd5f5b683c02561072848258496
Message-Id: <175919479885.1773917.3848952476503433055.pr-tracker-bot@kernel.org>
Date: Tue, 30 Sep 2025 01:13:18 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, Christopher Fore <csfore@posteo.net>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Junjie Cao <junjie.cao@intel.com>, Kees Cook <kees@kernel.org>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Linus Walleij <linus.walleij@linaro.org>, Nathan Chancellor <nathan@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Vegard Nossum <vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 12:15:50 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5ba183bdeeeedd5f5b683c02561072848258496

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

