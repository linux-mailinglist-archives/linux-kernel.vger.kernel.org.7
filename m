Return-Path: <linux-kernel+bounces-834622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E19BA51ED
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 22:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04CBC742A25
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F69728642C;
	Fri, 26 Sep 2025 20:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLxWj8bV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF9C28689A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 20:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758919469; cv=none; b=c4SghogOz3fkI/GDnSwsuQf1nse5nBiRfjLNrTESTLfjpuEQPBqZRJgNmPn5dtjgXbvvOCJvVrgWMdHUmCbeZX47ZEl0APOkvUCnls9V9THVfqOLXH6KEOq9EjUOMxtBA12y7a8Bgo5CM+hPRlVotgxge24CcbcY58VXYXF+q5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758919469; c=relaxed/simple;
	bh=yMXCYBu2uR9Wdd5R1KiWjC7koriOwDZK4xIgrlEkXoU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UATWd1V0WaKSwq2a95hZapCVxwdRUG14p1LvxFRU6Yv4D75SDkjPoS86pZvrCYrVQ5sRie5IWARAOiwNxoBi9vJIhRNpqL+zjAasNGDDyrLmu2O1Z+Ar4tV9jh+/cW5TnWy7AFA/wTncOETBEalJQmt/ZMfQ8JUy70SgxrxjEhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLxWj8bV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF26C4CEF4;
	Fri, 26 Sep 2025 20:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758919469;
	bh=yMXCYBu2uR9Wdd5R1KiWjC7koriOwDZK4xIgrlEkXoU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eLxWj8bVOfhhQpMNgGE6qBOaWlO7uDsT+AwFe2DY2gXlLu7TT9cgjk+vpwV6/iGLH
	 LpDCDkrzrNGgOyJizV5obM1LrGhguTD49MYJoeAvlNVUZsChqpvisU+hMSMHJu6c1S
	 gOE3xE5pTM1QJ17vzcnvCnziKAAmS6lvQZGLmQoKYcxgOcrqP0GPX09oFNJa3d4hlL
	 vHGsY/q0h4usS5NHablNA8z2GxRI4/2FjDtpuvhJmEJ22L14mBYQeYHL6srzosu2Rg
	 lglrKY95x+4jQTXYzTps+Vhjd8pZAaF/hyYcmV1J5y0ZH3xLyJCEW5MZJ+PP7B2H57
	 e5nwrF2KImR9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E1139D0C3F;
	Fri, 26 Sep 2025 20:44:26 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.17-rc8/final
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyfHf9jLv36vvc9=sRt0OWk-jTVq8n8uRJvu2O5a9X5bg@mail.gmail.com>
References: <CAPM=9tyfHf9jLv36vvc9=sRt0OWk-jTVq8n8uRJvu2O5a9X5bg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tyfHf9jLv36vvc9=sRt0OWk-jTVq8n8uRJvu2O5a9X5bg@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-09-26
X-PR-Tracked-Commit-Id: ec73e5984e01bfdf92234eaf5a2c3e54aa67f2aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3170244bc5cfe2a93d105aa57ff7e04ab19f78fc
Message-Id: <175891946472.51956.6955163847374952399.pr-tracker-bot@kernel.org>
Date: Fri, 26 Sep 2025 20:44:24 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 14:22:14 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-09-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3170244bc5cfe2a93d105aa57ff7e04ab19f78fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

