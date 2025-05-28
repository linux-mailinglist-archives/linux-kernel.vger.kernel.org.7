Return-Path: <linux-kernel+bounces-664811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC31AC60B0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 06:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594401BA26B3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 04:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1784220A5F2;
	Wed, 28 May 2025 04:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bim/hrJK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC7D209F38
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 04:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748405927; cv=none; b=TTr/jSw3tAuEpuRgAzFqfboT63wYitNBB+G/2sJasZevnKkGLGdhBaiHBOMjy1m98G2JcDwwh4XuJNI7nAF0fN8OhwWjRGD2VYcd5pqcC2Emur9Hbow+gizmCDM5+Eif5hAqXVJ2OQR8fbgFkki8MoFrWrJpVnpTUhwrYkqubv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748405927; c=relaxed/simple;
	bh=rOEf9wetGpXI8OyttZOSLgE7pGHY4/gfocQ0mm1SbY4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=klT6RNn0Ucd8oktsQPWsN8tCQwcZp5/vn393yfM6fVyRAUiFMVrNn+GN9QO3oSFdDaHkROxeA7NG72DWCUnrj3vr/cPKdrC+ACTUWsuSCGvTcCgRuyPQQuKaSFPWl4RiRIG/80SUaQc1cUWUiIO0/bEjF6nhA4BXxOcA4lD/Gic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bim/hrJK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5891AC4CEEF;
	Wed, 28 May 2025 04:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748405927;
	bh=rOEf9wetGpXI8OyttZOSLgE7pGHY4/gfocQ0mm1SbY4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bim/hrJKngU3EWVdX3VpsHSge/e5Qix1YRl064CslbqBumCFfGwVRhpVqxA8NsPM+
	 Erg88OdfGqpjQDfMsJPHL3+f32VCWyzdvfjVWSWYUsCc/NIVCIoN+fEMu5Oz8q+LLB
	 DaAwcB3abCg9NwW6s2ZgNe+ZgPCNa4NNUGSbUyPFd+y1osvoZdO08EmIxD65h9aIgz
	 sbrGp9+pKoR3dIGQMmUL+UUgEUjt/1f5zxEEwAruJ9W04nt8aVgxWBqvpRP800zjPZ
	 x05mAybjrPJkh84vRd8NGg5HKBQJLX+gvxvDgmPSwmUPJRa7YeGDqhYqC1Em34kMZN
	 WhuWaoTAlUeSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC5A3822D1A;
	Wed, 28 May 2025 04:19:22 +0000 (UTC)
Subject: Re: [GIT PULL] workqueue: Changes for v6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <aDYPYnzk3zsrCFYn@slm.duckdns.org>
References: <aDYPYnzk3zsrCFYn@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aDYPYnzk3zsrCFYn@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.16
X-PR-Tracked-Commit-Id: 23227e71b69af95e421e263302d13f426c548155
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91ad250cbe57855362c99642a454294e8d314c7d
Message-Id: <174840596140.1893196.17646957687094435481.pr-tracker-bot@kernel.org>
Date: Wed, 28 May 2025 04:19:21 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 27 May 2025 09:15:46 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91ad250cbe57855362c99642a454294e8d314c7d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

