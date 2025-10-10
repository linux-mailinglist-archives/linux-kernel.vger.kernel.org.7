Return-Path: <linux-kernel+bounces-848794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B997BCE950
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 23:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AF7AD352AE7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 21:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2B22701C0;
	Fri, 10 Oct 2025 21:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyKd20DV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61E62727F9
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 21:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760130578; cv=none; b=WXn2Z8vGxi/anNjaR02DYlc7wBovG/TUfn/c5v3v79iK49VbQTybdTTdLbVBA/Zp+7ehiUWRpdWRTRYdBbqyVRotiUucAvIY149Rovqc+BbpjncphAROcoirywl7cJyylfSHb0YegEGO+/ZK8bdXbWVRWq4+0xehNoRE3xqAH+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760130578; c=relaxed/simple;
	bh=rcE19wNb8lc48A8On3yvSeYXRVxlo+xjt3Suhfju3bs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ACRjRqoivNHak+hailJS1X5U3d6wUjwaGpGrvMxOp66AiCVCDKUQKkSnt8AvAK3adPVD+OIYYTv/7D9gPO6m2NFaO01LVtJAVX71YpzrL82tZUxGhOMuzCKf0mJ1Cx8EcGwYWprPyaFr+k1fdnVXXsny3HUkWY/ryb2SdgRQ68M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyKd20DV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97421C4CEF1;
	Fri, 10 Oct 2025 21:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760130578;
	bh=rcE19wNb8lc48A8On3yvSeYXRVxlo+xjt3Suhfju3bs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZyKd20DVh3GYDyG0Nwe3Ufpb/bBYYoPnwTNuTsBskAKfO9X0Mlrhtf6LxntHp+tsQ
	 8WJqbiu2T5xcJ0r7gsCRDRpGFzRqChV84RNfAXXSPU2OJP9TMwNYPqXc0XMCaEfdyc
	 ds/U0ZUdP0bXNT3A3I7Bp/IF4l/gUfJNor/Hh9EOeOg9ABSdnk950cQZaN4njU2ZaL
	 ce+oqVnLVDlnAuB0ppHvb1yoDAqUrb0koeP15uhDlYMWDh9PXQXrOMaKPxRGsaPSUl
	 B53+fumIEap/mzkIgNQ7nejIJW78JGIzddz4GRooAlC8981svwKEFdWKD63UWjG4W7
	 LOvgo8qWwfuTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D783809A07;
	Fri, 10 Oct 2025 21:09:27 +0000 (UTC)
Subject: Re: [git pull] drm next fixes for 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twb3XAAbMGo9QeQd8mMcGfz2WL6pocaHHEaQfGiAkSKWQ@mail.gmail.com>
References: <CAPM=9twb3XAAbMGo9QeQd8mMcGfz2WL6pocaHHEaQfGiAkSKWQ@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9twb3XAAbMGo9QeQd8mMcGfz2WL6pocaHHEaQfGiAkSKWQ@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2025-10-11-1
X-PR-Tracked-Commit-Id: c4b6ddcf01f63a710c24a128d134d3fa51978d6c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 284fc30e66e602a5df58393860f67477d6a79339
Message-Id: <176013056572.1128757.18157070587858393918.pr-tracker-bot@kernel.org>
Date: Fri, 10 Oct 2025 21:09:25 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 11 Oct 2025 06:16:19 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2025-10-11-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/284fc30e66e602a5df58393860f67477d6a79339

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

