Return-Path: <linux-kernel+bounces-752909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5A7B17C3E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 06:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D9BE5A66F4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 04:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E641E3DFE;
	Fri,  1 Aug 2025 04:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlpkL48Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F66C1D95A3
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 04:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754023890; cv=none; b=YxoQHil78Y5uW/As6x3wqWgG6gbU7OD+xKSL4g2kRrfdMjEdnze79YPqOhWBcxSCd10n+Ntnt/02bu+s4T8vOeepOlz2DrU2lo3A2/T9ODfH2CsgErzN+jZl53lHc2ba2hZYp7lj+gsVWKxi7KTL3tTMHD3aVi893BPnNWOF+Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754023890; c=relaxed/simple;
	bh=BRymtlzuxn/nDTRBdiswM96a4s9V1L5n3BdsG8BqbN4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UI0IB4w33vaTw/ZMbxOXRyGJ0WiGJnoMJMgIa3sDoCxaRswNEGcmkDJXeSlD1yFvlLXd6l+fYKJqsVvX3jWdoEevP+o0zwxtewaidnKzOR4ZwzDi0wrTNanf3Pd0LxdLcqMUSqC89wwh62MtGX5Qeby5gY9P/nDE6laCd1nZBXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlpkL48Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5A4C4CEEB;
	Fri,  1 Aug 2025 04:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754023890;
	bh=BRymtlzuxn/nDTRBdiswM96a4s9V1L5n3BdsG8BqbN4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AlpkL48Z8Qzfe7AZMrSIMpLYnCMON9pqdu7czC+5LuceV7XO0x1I74tykOmYD2Cow
	 55IjyblBhW8PJjEL10IfrkB7kfrfoeJ1+VrSKC7n2+Zz7+0F/j1p2SsUXD8tOHHBn2
	 VFflPuBz/lgO40JK+nCtlHOSsvTlcnDAFHxh9sauoOgdInb1enR/JrJLKqIiT32JlA
	 FwKu7qCgVTUg5dcsVPEcXlrsaFRtzTR5/BxxUQa6FItxt4kNmlaYdBVdCgBHwlteO9
	 G7WQ7yf2vezypIrfkCht2OrfKmW40T0lKhA1LJRVtU+IH4Y5FQZNP2zcjOefSq6Uxr
	 SAV8G8+G6XSMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id A130D383BF52;
	Fri,  1 Aug 2025 04:51:46 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twBSSdGXPYQMTz9yWqKg=8RNpAXui4Uf=BvB60mUiZqfw@mail.gmail.com>
References: <CAPM=9twBSSdGXPYQMTz9yWqKg=8RNpAXui4Uf=BvB60mUiZqfw@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9twBSSdGXPYQMTz9yWqKg=8RNpAXui4Uf=BvB60mUiZqfw@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2025-08-01
X-PR-Tracked-Commit-Id: 6531a2cf07ef156956840853692755cc7e1621b7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 89748acdf226fd1a8775ff6fa2703f8412b286c8
Message-Id: <175402390531.3433303.7044614939045683231.pr-tracker-bot@kernel.org>
Date: Fri, 01 Aug 2025 04:51:45 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 1 Aug 2025 09:05:07 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2025-08-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/89748acdf226fd1a8775ff6fa2703f8412b286c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

