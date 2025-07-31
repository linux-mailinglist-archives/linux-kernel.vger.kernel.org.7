Return-Path: <linux-kernel+bounces-751540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B69DB16AB2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A26BD1AA5946
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 03:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5646523C4F5;
	Thu, 31 Jul 2025 03:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzvGT3Ph"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B061723C4EF
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753931459; cv=none; b=k0ZKe5puImngUxorMO8hRbEEl5CZMqs1lwLwFCqZNHlCaRepEImRcUaYm1oO4HWYXf1iDvLYN6eejXjVmE2Rcn22RKo5siz1N/2OoSKjsDViaKK3kPDy1E8FlP83mSBRyRxZbo4H1ffygv6Q5yABJOrka8QTX+nqvg+0zQ9QnRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753931459; c=relaxed/simple;
	bh=6RxrTGqCY5kf0n8shybxSMp8qcnaSNwtZX+pZVq/O5k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oc4WceetviBPqtlD95WcoGj86apqCJCaPLsenoizTtilbcjwcAZHb5jRi1Gx3ynK1OXFsJXSWrjwYhceHgVkUG0sGVv8lbla67pqQzvDLBVTUAIZAy5R7ITrOe+yRitWnQAj8LyCvqjcdAo3s9IQWwuWob1KawGCpxQPOw00fPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzvGT3Ph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B64C4CEE7;
	Thu, 31 Jul 2025 03:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753931459;
	bh=6RxrTGqCY5kf0n8shybxSMp8qcnaSNwtZX+pZVq/O5k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EzvGT3Ph4DL1WPnJVh/EZqM/5CfQ17cMdPPba/vwVpd8FXsHWS69HImoVqjoNoWOO
	 lfrwoFBr2sqaUYr8ef5gYwVzwyODMLP+2HBnHA4QF1E0Ox97pJhGu8DmKljPmW5DCb
	 DDjTlZxSS/xRo0PVOtbvZLLD/lnmZD1ZH4ggpzX5cwpZuOKQ6L4Zo1fROphGg1lNm2
	 8ku3RQGKyRjfCx3TX/jpp/Oe4fU4rCTy8OHSddcLJS9kpf4VlAD8kvtklkxxACFEVf
	 DCLXsdq4wdNT13A8R4d9GynAGdtooVrsB+kaTVlzuSMTP13pdhoGj9KgR84FRKGRH9
	 QyKhX9nd+O62Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0B5383BF5F;
	Thu, 31 Jul 2025 03:11:16 +0000 (UTC)
Subject: Re: [git pull] drm for 6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzVm80-v6_5nt6kko3nR+aQLZ7R98i419FV8f4-ayQWUw@mail.gmail.com>
References: <CAPM=9tzVm80-v6_5nt6kko3nR+aQLZ7R98i419FV8f4-ayQWUw@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tzVm80-v6_5nt6kko3nR+aQLZ7R98i419FV8f4-ayQWUw@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2025-07-30
X-PR-Tracked-Commit-Id: 711fa2667d8b230ff31f1855d0f25e3263268d8a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 260f6f4fda93c8485c8037865c941b42b9cba5d2
Message-Id: <175393147528.2597948.6255690700279027909.pr-tracker-bot@kernel.org>
Date: Thu, 31 Jul 2025 03:11:15 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Simona Vetter <simona@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 30 Jul 2025 07:05:51 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2025-07-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/260f6f4fda93c8485c8037865c941b42b9cba5d2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

