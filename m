Return-Path: <linux-kernel+bounces-749959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 543EDB15566
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 00:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FE22560FE1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 22:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7B5288C23;
	Tue, 29 Jul 2025 22:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U86UrVAs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF9F288C09
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 22:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753829131; cv=none; b=rdt0j+8LACT+0d8jj7TpB3rYHQflPC30GPlEkM7rOU3Lh2MEA/r/y5NC+9rEa5ZySnKwDLsXP8azH7oJeAdZo0ZD3x9KFuA61HLmL1G3JAjAbArrXMg1oX40v490N7XYWKRmL4mwR/Y7XcOmNjLq5+RI9TDGbfk9K4VkuU7RuYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753829131; c=relaxed/simple;
	bh=79PlCB01RzGCOLdKc3GzLETKFX9wA75iTUfmAffZBPU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Iv13rthsdM1n6WR/Arj9OwGPd1nvgC0DpkPi2uHOvD5Tt5e+R7OuLxN+tGSyatVGNYmea3e42i9nPCdkQxitk70bLU0Ay62hEUgeaHkdmnISvGWDekGagkfJJ55X81FGygHgxmwyApxtBwwAbDXXWFK6AcEXk9chhxUge7pAo9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U86UrVAs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3055BC4CEEF;
	Tue, 29 Jul 2025 22:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753829131;
	bh=79PlCB01RzGCOLdKc3GzLETKFX9wA75iTUfmAffZBPU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=U86UrVAsm1hJ0Xa9el2T8dGncQFFd4Zc1BBTooAK3Fi8AdFTX84gwwoIU4iqkYb72
	 7yWNpuKJT1ibi4MrpSxruKlkEuWcDASmRyVpyPhCdAisfrzvrgEylHeHzFQ+iwtj/L
	 9NqtVBZsn1uitTXpCmvaZt/EsYQaNK6oC2tviXOnVHqhYebZApgmRqYmAdSKkIq62h
	 Zevwuwy9eiNkId/C3dclGt6jQjE40qnPVJBiXGl6r5bwhlYxFPknx9fnlM1LXRS/qu
	 3mmrU2zTAO5cBmC1mfbJtoQGPG6Ue1meSvLaVrJN+s8/2dgQd2v9aPzo8PZQ5QY87z
	 0FjvrOnw9LlpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70AB9383BF5F;
	Tue, 29 Jul 2025 22:45:48 +0000 (UTC)
Subject: Re: [GIT pull] irq/drivers for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <175365568123.581055.1675064982263600887.tglx@xen13>
References: <175365567943.581055.6806236199247802443.tglx@xen13> <175365568123.581055.1675064982263600887.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <175365568123.581055.1675064982263600887.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-drivers-2025-07-27
X-PR-Tracked-Commit-Id: 2aad477b5b734f52825f7c31780222a5a17c06d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0b29600a304c0c5da17ce1a7fab7cafb0eaf71f5
Message-Id: <175382914695.1670422.16758214033675589322.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 22:45:46 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 00:37:52 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-drivers-2025-07-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0b29600a304c0c5da17ce1a7fab7cafb0eaf71f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

