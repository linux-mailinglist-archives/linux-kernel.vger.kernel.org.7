Return-Path: <linux-kernel+bounces-840716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECE0BB5107
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 22:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72E419C7F6F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 20:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D72A28850E;
	Thu,  2 Oct 2025 20:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLbi3D50"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54DA7263B
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 20:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759435234; cv=none; b=s5XbERK45AIla5/NiclBQxAbA2FM8+IaTPQXfj15UlJPDLxVAhKN0TOBkUIGhybtvDqHq4zRQkS4EchPi2pPm/IQawoo+gYXdhvOvYtPO8U99BYy6EcRb3vyix1ZDE9k+Q0XKxeYOWClMrjsAhLqHNr5pF8mxeLkl52coi59VXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759435234; c=relaxed/simple;
	bh=+Y5IIrpmo8Fop2P4afHswp2lIG67bi2gEJ1E3lktmkY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kHeI/jQBfcykQ6k4mBLUAfqg8llECo38DCtQvo9vXEkVHxuKbv+rCE62R3OouQNqt2AIncDquHN5s1l6CJ072XeaITVaXN82AATTWm/PBt6qNIZwQCgfPghBQM7VzFf5cw6HtzdmpkuiyMjJ2j1RcKYpabtc6p5HT6EYbLZ0W08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLbi3D50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C35C4CEFC;
	Thu,  2 Oct 2025 20:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759435233;
	bh=+Y5IIrpmo8Fop2P4afHswp2lIG67bi2gEJ1E3lktmkY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QLbi3D50KkFIdW52bhk1Fiv3BjUWj3vO6y0I2r4oR+RLOAkTuCpNKaFxgvf0OxHao
	 ZaLmaRVR+6Wb+pXNl1btidcQJo0JqmXwOKl6liX7pcruIbZkoufxWyjlj87OJkPiQX
	 cHGT+mDJBHzHUvjQoeE+I3CPtnGEzp6JjCDYEL/O7QhuJwgw+6JieOuZYSDQuGs1aL
	 PUGb46AQhZxI25dL9NZ1gMCamRHypPW8u88RxwASAXyMVtIGNUgf4aqbLpbwkA3Fu1
	 /TGBgikHG7rn/eOJT+9O3JhT8e2p4U1D7utDxWRcC+R5gJ8YH3dBy1ntqP59D3TqYw
	 ACSmwcXBmlD3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id DFD9539D0C1B;
	Thu,  2 Oct 2025 20:00:26 +0000 (UTC)
Subject: Re: [git pull] drm for 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzYUBfz+YmifRDgdBsuTL=FpBxQVfxu23it48kGRzJNPQ@mail.gmail.com>
References: <CAPM=9tzYUBfz+YmifRDgdBsuTL=FpBxQVfxu23it48kGRzJNPQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzYUBfz+YmifRDgdBsuTL=FpBxQVfxu23it48kGRzJNPQ@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2025-10-01
X-PR-Tracked-Commit-Id: b2ec5ca9d5c2c019e2316f7ba447596d1dcd8fde
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 58809f614e0e3f4e12b489bddf680bfeb31c0a20
Message-Id: <175943522561.3413181.16158883363310747898.pr-tracker-bot@kernel.org>
Date: Thu, 02 Oct 2025 20:00:25 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 1 Oct 2025 14:06:07 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2025-10-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/58809f614e0e3f4e12b489bddf680bfeb31c0a20

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

