Return-Path: <linux-kernel+bounces-825804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D773B8CD8C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 19:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA53B1714EF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 17:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4B121A436;
	Sat, 20 Sep 2025 17:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtzncfHP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53A91CD15
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758387765; cv=none; b=k7lyLE+gTtk58lMGINdEJziBXTAqCuozQd64kF8aMXhiRSQtgG9FX0xPkLsvHSjNME+kk7DrUjhTbtmcFzrFYzb6o8ztz9syAa6ueoSwg9Y01g6ktDVvdCHnUK1vc83cjXbLXb4U1iZ3BjF+Y8sSoLKyT81G/W44Hj92O3u9Qzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758387765; c=relaxed/simple;
	bh=3KJUQy4EVmxBUBOuzg9LROAYCAEC6cq4mF81+xNKFEU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TyrtB/giP1vyeU1H4lz5cND3lmZ/YNHWmP56Tpd/yVddbAMgqP6y983nzY0AfseA9LNcvkuOy600ETbObbyNiDwRbNjfhmmkUI51sP3VJb4z+OF+Mag6/wxC2dvpQyrq3AEFdtwlh04M/kQDj3WJoHEh+xEc2rXaiZsz1AbKCuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtzncfHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DEAC4CEEB;
	Sat, 20 Sep 2025 17:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758387764;
	bh=3KJUQy4EVmxBUBOuzg9LROAYCAEC6cq4mF81+xNKFEU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jtzncfHPrHtHyMxQNV9K1lIvKUfSmrj3GOywSvriIlQthDww6xmuviZEkTO6aHTP0
	 13vAPe7nNddommdZNbeHDUnhgBxQpT2x8z+Py0dhxsq7vvWapPzRfj4FTn18tqwb3W
	 7LfB+sGAlkP8One7UhbXuaAFXQ/h1OnGOUbc9F4ybxFd/D6Y0KAalvDhYFaZ/3DI3N
	 5p49WqDgI1nOeLNsNUMhkPJu3HbS7RX96T0KJUB5I7GXAP4QWizM10A4QXcYYOj3/C
	 hd1lIEKkBesHGJgFhmNg7Kj8ZTim1GXGWejt0jZ/vU+kvD6r2W1lQEDWT39TGiHzzM
	 2x3DWUe8Tkmiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7112939D0C20;
	Sat, 20 Sep 2025 17:02:44 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <aM5luGlAgWDxXL-7@gmail.com>
References: <aM5luGlAgWDxXL-7@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aM5luGlAgWDxXL-7@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2025-09-20
X-PR-Tracked-Commit-Id: 7f830e126dc357fc086905ce9730140fd4528d66
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b08f56fbbb9ef75c7454487f8d3db80a84deef7
Message-Id: <175838776302.3946504.13939825988341252971.pr-tracker-bot@kernel.org>
Date: Sat, 20 Sep 2025 17:02:43 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 20 Sep 2025 10:28:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2025-09-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b08f56fbbb9ef75c7454487f8d3db80a84deef7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

