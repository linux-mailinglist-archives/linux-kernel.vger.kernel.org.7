Return-Path: <linux-kernel+bounces-729156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D879B03299
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 20:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32941897F5D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 18:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB7D287245;
	Sun, 13 Jul 2025 18:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SebuF9hr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711D5285CA5
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 18:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752430190; cv=none; b=J4i7thaF2G8s0pxBrqCutE+m/bF8qhMC5yHyPdTauuqlAAwQ/n55IHIsvh4ybHuf3jy/4M4ojXVNnrDKj8IeVPM6wsQYvEXhgVMACo/jOzmAJFGGGn1RLWn/12JyNFRldyh995w0IGNvlJAZGsAtNzEmoIfRt0w0ReVDkCh7g6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752430190; c=relaxed/simple;
	bh=iX00zbBtqCg9P6FTMMLMEON8DvRu3uEvif/c0LmRKoo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GW5GUbGBjAnXLMzWE8uP+ZQScwVrcE1QFqYyoDodDYMUgN/O0mxfBK1Km5EcT/m8FzXHroSboAZ0CvSXuZc1KJhKlKnIrqioIVhuI45GV85NNWrEGZYVLJxxtb1Qlntbj2NZo2rwhKGNi3mUUkht58uREaG9p8Dop5Mra6EoT88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SebuF9hr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E519EC4CEE3;
	Sun, 13 Jul 2025 18:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752430189;
	bh=iX00zbBtqCg9P6FTMMLMEON8DvRu3uEvif/c0LmRKoo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SebuF9hrZutmcAxJ0NAOtlGXUfP9kdHH3KS61x3wHvo2VbiZ/UpRUMCNd9pC57HQb
	 +SjxIr870JcEhT673eVA+AshWPdU1Yt0tkmX8WrXy8eGj9eMJvdOBWk4Gmxrre9qC4
	 P/ke/GyqErsMZ4BSgqJ5Cd8cSIRte2rZmVSQrPHxzkRY69bjCD9SO0bpIcJ6wPJnss
	 7FeT3QrMaowTvZ73bZmkMCcrLoNLQXmCYc4gEsUQIgaOTM6DG2Vcf6w7LB8cS2l/14
	 MyZaIrrxMtNImuQXNwrfATH0i54rjh7Fk5/1ynDR2Mnm1XcJUe/ACLScvMVKHbF3jH
	 yMVCAnRTGJIgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70A9B383B276;
	Sun, 13 Jul 2025 18:10:12 +0000 (UTC)
Subject: Re: [GIT PULL] irq/urgent for v6.16-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250713101214.GAaHOGfkN6wjED7LW-@fat_crate.local>
References: <20250713101214.GAaHOGfkN6wjED7LW-@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250713101214.GAaHOGfkN6wjED7LW-@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.16_rc6
X-PR-Tracked-Commit-Id: a8b289f0f2dcbadd8c207ad8f33cf7ba2b4eb088
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 41998eeb29a187d66eec7699741cc278ce53d65b
Message-Id: <175243021100.2829992.4622458171371410959.pr-tracker-bot@kernel.org>
Date: Sun, 13 Jul 2025 18:10:11 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 13 Jul 2025 12:12:14 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.16_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/41998eeb29a187d66eec7699741cc278ce53d65b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

