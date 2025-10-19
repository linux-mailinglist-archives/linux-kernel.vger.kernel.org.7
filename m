Return-Path: <linux-kernel+bounces-859773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7903BBEE840
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 17:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A93454EBC84
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 15:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF6E2EBBAA;
	Sun, 19 Oct 2025 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYK1xLKl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347232EBB9C
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760886352; cv=none; b=I++1vqd/CXQZEeXCn925qqvEVsUuL8aNG//qej3/sScisUc63euxp9DjHByQ6pWQUVNxM33XkaRQnVJi+XecvOj9mKKrsY4W2k0CPy+2GKI2wEc511qoBPiashBigfcZRCP5ZTd7C3vIh7T7bHfHYnO9ZFwBedEM+B9HBzbliEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760886352; c=relaxed/simple;
	bh=olntVCM9P6S6Z+un2GrXUHb8Qa5rjCeYc3/GR0XqPYo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=b3titOrqvDSkrEvJruvRCoD4TUt3kfBQmqBx1nMaxLCUxyDA8iUzQSQ2lm78g2TP9ai0a/SI7mvGcVI1gHX8sbKG/AgfKLnGEFChN9FfdJUg+6rFc7+xUGoxpg/0XalUGI35jLcBhnjeZHzZ/Iss2B6P/NIAkUfDeFPgindTTYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYK1xLKl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BBEC4CEE7;
	Sun, 19 Oct 2025 15:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760886352;
	bh=olntVCM9P6S6Z+un2GrXUHb8Qa5rjCeYc3/GR0XqPYo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IYK1xLKlOWmVELK5MFIkhh/ozKaxa0S1JKR0tRY0Q+NZigMV1g285ntPgbTrF2NIv
	 v2TQAYNOv2vS9oADrHVXa14MN7Mv81YBHAQgIgntrP73Wec/KMXKfx7HC/nmSdvRXG
	 eZpP2PxZwczyBNojRm+evbTef4oRTrys1jIBZ4bvyomJXEMCMmWc8TiigyMQfxB4Ch
	 il2FbwiuXMFu2C3F0ly2Jj2ItyMz6mly4EbJXL8EvaCWypinI0ahrkqhMGQWW9iNsZ
	 N9BUaWljp498XkAXpKiv9KGBZWyZ3495Npt6ce51n45LQHkn4S4WXzqXH/enN3VbrF
	 1zpk1Bf0q2Waw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACA439FEB71;
	Sun, 19 Oct 2025 15:05:35 +0000 (UTC)
Subject: Re: [GIT PULL] sched/urgent for v6.18-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251019112726.GAaPTLHvdbKaUyBbMr@fat_crate.local>
References: <20251019112726.GAaPTLHvdbKaUyBbMr@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251019112726.GAaPTLHvdbKaUyBbMr@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/sched_urgent_for_v6.18_rc2
X-PR-Tracked-Commit-Id: 17e3e88ed0b6318fde0d1c14df1a804711cab1b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d9043c79ba68a089f95bb4344ab0232c3585f9f1
Message-Id: <176088633458.3293831.13162478294579164891.pr-tracker-bot@kernel.org>
Date: Sun, 19 Oct 2025 15:05:34 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 19 Oct 2025 13:27:26 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/sched_urgent_for_v6.18_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d9043c79ba68a089f95bb4344ab0232c3585f9f1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

