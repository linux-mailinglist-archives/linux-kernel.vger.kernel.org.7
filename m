Return-Path: <linux-kernel+bounces-838275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5CCBAED97
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 02:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8201194527A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 00:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9836C2253EB;
	Wed,  1 Oct 2025 00:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLX8Yorn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04154221710
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 00:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759276967; cv=none; b=CdfCFGI/lvdDl3HOQZ6n4mF8tRMhF/h+frmJ3D+H5HDH3ukLUFReUPflPPqXZ0OwjU+8amEjW1HHBK60/50cnA0HrrA9CPZ2xk3K/mOnKS4+W+wI52Mne35wNPmfYT/jnQeh9ozW3rnVuzwX/5D5bqTw8WPmfArMxejkZsc/SCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759276967; c=relaxed/simple;
	bh=6a3v/9NAUv+elnem2TOJoS+tuOLJfk7sPznVJmkh6uU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LwbOo4UL/FE/3e1htsvtUL1/zhrpKIHCioKoURaaOQXBZ/2GPxP/pcF16rQ/F2qY0RhgHRL+dx8tckfFhLtLeSpYURJ7H0MCp/cQMjqByNF3H0FFhh53wTBMYzdAnqb68l/zmTMEb1kKjxQKj58YrHSwKGzd4wEctiVNAayznH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLX8Yorn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AAE1C113D0;
	Wed,  1 Oct 2025 00:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759276966;
	bh=6a3v/9NAUv+elnem2TOJoS+tuOLJfk7sPznVJmkh6uU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iLX8YornC2xnRePiAldT2EPYXBvK5QtJ5wqxTDM2esSmTNjMygUemdjXZAvwOgP70
	 LMLnVaQYsD6N/saWYa/idOHVwiXJvcoV9V26T0bclq+xyavgNsGs0Bt17CBuYbRzF5
	 EAU8HfXIEl+pHETKNKDrVe/OLjfJwQ9td2PWcOX2luw4+lFB1q35hBam+H03Ucck/V
	 Es7fxZX1hWiANCV+CxPR1WHDMPMcSEgSpzC1qWI9B8cY6n5/PqoA1LKJY27kr2lX8x
	 +0+7Kj/+eV1YKIY6TIXgdqN1X7xel1L10u6JWNpwdNitUr7wMmDkR5FXFKQXuFk56F
	 7vNJe5+vMJtPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC4639D0C1A;
	Wed,  1 Oct 2025 00:02:40 +0000 (UTC)
Subject: Re: [GIT pull] timers/clocksource for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <175913808666.495041.8647163849236838852.tglx@xen13>
References: <175913807599.495041.10251515322736195577.tglx@xen13> <175913808666.495041.8647163849236838852.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <175913808666.495041.8647163849236838852.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-clocksource-2025-09-29
X-PR-Tracked-Commit-Id: 749b61c2d6a91c81732860f22925ae9884de95fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70de5572a82b3d510df31d2c572c15cd53a00870
Message-Id: <175927695941.2242674.17156018105263098099.pr-tracker-bot@kernel.org>
Date: Wed, 01 Oct 2025 00:02:39 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 11:29:06 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-clocksource-2025-09-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70de5572a82b3d510df31d2c572c15cd53a00870

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

