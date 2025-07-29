Return-Path: <linux-kernel+bounces-749957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 440CFB15564
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 00:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD69560F28
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 22:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1B470813;
	Tue, 29 Jul 2025 22:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qw3kXlhV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50764283C9D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 22:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753829127; cv=none; b=a+jUYmmmDqQHRa+KjBW6CALMGi/+bHRYIKt1r+YGxAooXummRROgJYBi8aJvCqlaW60ESZDrEhZRYtUeVATOCNk07MU4zCjpFcObwOsHA5zlQULEzUjQq+IoqvlissGBSqbC01fhgA8Av+vvQb0cdECILoABuy9+agNH9/i65Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753829127; c=relaxed/simple;
	bh=zZY6InEHLHXtwlUk0MuuX5wcEPQAhRTbG24PDysLBEU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cZIDArpl0zMpKX+xo2iTmgqOUxkIvRNcdixyQTUqBlShcc0yYs65cQ0mhYQJtPeaHiZhKYcO4Dp8/OAqwsHdVtFqxsaYVywFz9w9Osz9a86XiRe+pdT5c8L7+zY0x2x3OSYlC4tI+pfxHIad/TrW88VLtupeMizhJy7PqkgjpP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qw3kXlhV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33241C4CEEF;
	Tue, 29 Jul 2025 22:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753829127;
	bh=zZY6InEHLHXtwlUk0MuuX5wcEPQAhRTbG24PDysLBEU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qw3kXlhVzZd/7ZfxaFJnSIE8xHjX/AavaNUHkNsmN4JrXp6l50klsz7FgY+22lRsF
	 gZRYTWXdKx5oRz7Y2PtoVKNfj4yE2MitPW75Us88T34KzFyz7VJDkXGmhBvokoISPJ
	 sjH7PgLITKGRG9S4g0nN4Iu/+ifn4H0wWWHDc2hBx5Goo15KgXIxeOw0gTonywzW8w
	 7GD4tz87I/2QjOupsrC9WfBrGLIKZ2tBgcNU6edCb3pZhd54tj/PiCMssQSYV5zS90
	 cGuEcgMegsflqUyzsNsNSxNscx94BqXZVyySd+eJshtVbadnhMrtXcA/AGjIsCiJv5
	 +ILCHYX6Q69Hw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC3E383BF5F;
	Tue, 29 Jul 2025 22:45:44 +0000 (UTC)
Subject: Re: [GIT pull] timers/core for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <175365569020.581055.14574926495650428382.tglx@xen13>
References: <175365567943.581055.6806236199247802443.tglx@xen13> <175365569020.581055.14574926495650428382.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <175365569020.581055.14574926495650428382.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2025-07-27
X-PR-Tracked-Commit-Id: bfa788dc2ddaea7d7930f63a5c7c8f3668a3f2c5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d614399b281abf3980cc9b340a5066e9f4020b5d
Message-Id: <175382914330.1670422.4124708924860760269.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 22:45:43 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 00:38:02 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2025-07-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d614399b281abf3980cc9b340a5066e9f4020b5d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

