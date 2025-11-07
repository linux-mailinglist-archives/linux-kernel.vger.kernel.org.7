Return-Path: <linux-kernel+bounces-891128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDEFC41E75
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 23:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C53074E845E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 22:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186CB3054C7;
	Fri,  7 Nov 2025 22:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjgqxTS/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731EA2E6CDE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 22:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762556239; cv=none; b=gzERWC14i5b9RkKHzcpehJ7IVvpT9HYgKsJjDk6J2+eBL7M/SiYSt6kBSX7jAnNCZAKQoox/Ad5ScyqkyWIJ6NkDl9e4C3Mp1/3SYNTqBEFfJ4jAJLpXlhwZtcpaVlMaa/ZEwrWJ2C1ljctjHN1EcKfG9R+vLRKRANBzu65lNl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762556239; c=relaxed/simple;
	bh=QiWpK66BtccNnuurPeLD8mbkDu/D6l+ThPoZpGRxry0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PkS8J+LgTqrFvmWg/ERG0L69nkFiN2ZCD13+ixyfv0+LR0oaCQOv2upnE+nVanXfMiNfRUgdhIBou18L+VY+HhY4zOpMGK+04G7vOP4v4OlIstz8LC7qSXeSeLp/otJ0LWgy2wRvv8mUvhv8h9fYKGkT2dYBaLFORKMxljNrLks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjgqxTS/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52413C19421;
	Fri,  7 Nov 2025 22:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762556239;
	bh=QiWpK66BtccNnuurPeLD8mbkDu/D6l+ThPoZpGRxry0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KjgqxTS/lbinLY/83TgHjcPy62Z98hKCiJqiper3tMlyFxJ9GHxocqP9x8ivyJr5O
	 LHh7HLoxclRIZjM5H67Wxv400YkvjkUuQenj2PvXZ6zPmdRneyumiqP72gQGJc2lr+
	 835Mjxfn6xy/765PfdupsN41Olt4mZdOglL3EYvSgt3hHXlqN5cRX9HzdGLcBI8xcT
	 I9NcupuWr0cX5vKGw0lw3ALlcxVdXwN6fzI1YNqholiMuAgsgb6wYhRDdl59AeJhHk
	 a2uLIKxAClz84JBtQ6evdedjbUF4UtQFHUbOjQLsKJ8Yy4aMMH6aSBraopzPRPS5pQ
	 MKnawifjNBZJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE4483A40FC8;
	Fri,  7 Nov 2025 22:56:52 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.18-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tx60Q0o7v1hK-GJ_iKs7J0dVgQENM44T=gM_KWZXoA4YA@mail.gmail.com>
References: <CAPM=9tx60Q0o7v1hK-GJ_iKs7J0dVgQENM44T=gM_KWZXoA4YA@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tx60Q0o7v1hK-GJ_iKs7J0dVgQENM44T=gM_KWZXoA4YA@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-11-08
X-PR-Tracked-Commit-Id: d439acbbfb9a982f152c5f806b4592431a80c4fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e811c33b1f137be26a20444b79db8cbc1fca1c89
Message-Id: <176255621119.1183149.9411551911217772637.pr-tracker-bot@kernel.org>
Date: Fri, 07 Nov 2025 22:56:51 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Simona Vetter <simona@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 8 Nov 2025 08:08:39 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-11-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e811c33b1f137be26a20444b79db8cbc1fca1c89

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

