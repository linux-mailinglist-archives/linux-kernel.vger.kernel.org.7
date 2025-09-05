Return-Path: <linux-kernel+bounces-803414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D58B45F8B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FAD81CC5DFC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C8F30E85A;
	Fri,  5 Sep 2025 17:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KysTyEpH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9879B21FF46
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 17:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757091983; cv=none; b=n6FDiqGCRS1fLSk/dfut2LM6wWmEQ7DaeiKuJ4YEjuLkjj1JlHBMpOXUD6ONa7u1kiiOLMZ48PSrqCvqHpGWmgLFxG0TVPX5OB9hFgfFjWVlVXKp4bDsXvF/XGGAJ5E9hqOQwkfcBj3Xrn9zxppbXAHl0eNV/Za3SmFY9mkw6FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757091983; c=relaxed/simple;
	bh=INGC+ajHsIl3FNeM6kwVLgXWfBs7RhWtijR0UOSFhxg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PHnEmI09aqmqACNd+YPjXe8n8Fh0454roA62DT9YM1YbXbZQHjhVozTbLKqogYh5LUkacgpmhT+t7yTRrd3SmjLa/WX3G3YxVDV6ngrLdheYhf8TuEXrVmSQ9PHbHERHsAwLpoDF3EupAntt5KVxE8qfiEwTkjRQaUpn7UT48B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KysTyEpH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C61C4CEF1;
	Fri,  5 Sep 2025 17:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757091983;
	bh=INGC+ajHsIl3FNeM6kwVLgXWfBs7RhWtijR0UOSFhxg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KysTyEpHki7zWpgdQpzezd+bZh2ih2MlN38ZIGUOWNRyLHGvN15DCurIq6s4J8atv
	 pga1ecFQCi6KcBthiTGOWdc3I86C1CSZb6EqPNgP6hRzIrciV2OSnckDVle5harGQY
	 Y9JIENkP58AdFLveMBMxPGS67pBLO+rkxS3lan80jzCrLsYbyRL9ji+45vrFtmgtJl
	 Xpurn9ceov+3Oe0HIlgJj/i4gDnzIqQpePELfVIUMEp+CD+Qtjb2YU+M+Aiw+9PFdC
	 e83wb0lkNVOjSjgAFHV0BFMWfAbqe/vvIFMcsVOZjyNJpSToCeyMrxCuMRm9shZcaX
	 oRo0ILY5VUV+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 343F4383BF69;
	Fri,  5 Sep 2025 17:06:29 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.17-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txcDaRBOKZEWzAcDsdT=APUzcSicYA=-fno+52zGz0bOA@mail.gmail.com>
References: <CAPM=9txcDaRBOKZEWzAcDsdT=APUzcSicYA=-fno+52zGz0bOA@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9txcDaRBOKZEWzAcDsdT=APUzcSicYA=-fno+52zGz0bOA@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-09-05
X-PR-Tracked-Commit-Id: 8b556ddeee8da9420699ce221b6267f395e7d72b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c8ed9b5c02a5ceb3d8244f3862a7e64cf0b5648e
Message-Id: <175709198781.2623294.1625813420546569754.pr-tracker-bot@kernel.org>
Date: Fri, 05 Sep 2025 17:06:27 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 5 Sep 2025 14:12:52 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-09-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c8ed9b5c02a5ceb3d8244f3862a7e64cf0b5648e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

