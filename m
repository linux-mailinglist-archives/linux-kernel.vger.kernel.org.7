Return-Path: <linux-kernel+bounces-858305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A19B0BEA2E2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F37375A1A94
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E641433711F;
	Fri, 17 Oct 2025 15:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oS0r83PG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8031946C8
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715046; cv=none; b=eTbIPBEaqPTYbHCIu3XQ7Zh0H4Xsf7L7Um7BJDl75YJXTbr5ydN9m5Ca0p7VUULTVCa/M2qqJAe3+EAGvKDGmvFTG5kmCNRDCqawZrXbSIw/W7jGpqO7p36UqTiqFHcDTW45Ox2TMfYaunIVJfWN9GV7cnWJ/DZc8aGyFwJ8Eg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715046; c=relaxed/simple;
	bh=4/Efo52pUqgliVCdTmMb32ALCL+VU1GtLvRS0tzhQx0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=h5iLadPpMm5T3nGJWWkuvaoYcYPDZk/5nh6OWxdBxnrzrnHVF4DyXQ9FZ9Ty5umo3tBTlyO5jbowX3UBSRMDuxPIsskIRMs5htVQr6KA+RMuLUJtKIJvzFhW5KSNpPJXtyBqzhP70JDkaGJBHbcPjRcuQuhfvkZUWKQ+w8lWtlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oS0r83PG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96EDC4CEE7;
	Fri, 17 Oct 2025 15:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760715045;
	bh=4/Efo52pUqgliVCdTmMb32ALCL+VU1GtLvRS0tzhQx0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oS0r83PGSuWgJV1LXR1ZdK9J/YmCVJD7KPozmwXVXD1i65intFzzZ3XZpbG+rGd3B
	 WylazXP7ud3e6MLueJ/z92SJICNxUkgdFo76MMLUws6ef9tP4E31WxTPEaSRUKCGCD
	 wVm+zZRX+3EZKeXJ4HpR29ix4pHoELKLhP99ge3xx0vrW/1yK5mYfSpXXceNLDDAm4
	 FHxJfHOwbmZ0qLc+1O7IF2JGzL8CvGABhxAxGfYrewi8xb/4aOdPX/V95OlLt/H72Y
	 xcDUtERMJoDP4TgHBuJMuPH8nDTu5/uhCjnUnznBceM57CFobyNllgv13UjJ0wm5TR
	 dhpk3mnFQtBxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFDD39EF978;
	Fri, 17 Oct 2025 15:30:30 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.18-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9ty=C+PAgZD44Y_LkUuKkRtLFGffjX9rZX8=fkP0s-8zSg@mail.gmail.com>
References: <CAPM=9ty=C+PAgZD44Y_LkUuKkRtLFGffjX9rZX8=fkP0s-8zSg@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9ty=C+PAgZD44Y_LkUuKkRtLFGffjX9rZX8=fkP0s-8zSg@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-10-17
X-PR-Tracked-Commit-Id: 62cab426d0e340cd38893227c279705cc9e8416a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e96687c6d3b7814e6516dfa732946d3f40142819
Message-Id: <176071502928.2669258.8216523114880112616.pr-tracker-bot@kernel.org>
Date: Fri, 17 Oct 2025 15:30:29 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 Oct 2025 16:14:43 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-10-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e96687c6d3b7814e6516dfa732946d3f40142819

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

