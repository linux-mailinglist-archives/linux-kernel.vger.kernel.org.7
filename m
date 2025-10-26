Return-Path: <linux-kernel+bounces-870472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8D7C0AE50
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 18:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B4103B3AA6
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 17:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6E3248886;
	Sun, 26 Oct 2025 17:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evz3Imkh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8324920B81B
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761498047; cv=none; b=J6c7BEkacueonW/0BE50BIc0iNVst4mLaIVlA/AffM+/HxHdxuFlvKJ4Sse3f4Oy93/44a8WznPjWT28poaU6I0enqpLBei2EBWDxH5vyYwlMk22Ayep4xQ3tNdhcJYl6pJV5u4OsJ2MnxLKEw5qqpztVy9VwDFAoudxbNw+v3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761498047; c=relaxed/simple;
	bh=Te95kXSn0ZFbUOOoLjAqsngHOmTNcNdxrnYt3aAuWc0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UoXkt0CwFWiYMVbmSfRYP7OGzpD7LwmXJ+BLSjYkiiOqfrVW8LNfHYR09gfHM6tedB6xYlC7NP17xzLafmrKjibZLBTORJVY2tvsGHlYEWeZRfWXcqWNL5yD39ojXZj9muTsXmqB1x1rEzRLDHQekZgAR2sVy4C2nTLyfxC+FLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evz3Imkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F868C4CEE7;
	Sun, 26 Oct 2025 17:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761498047;
	bh=Te95kXSn0ZFbUOOoLjAqsngHOmTNcNdxrnYt3aAuWc0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=evz3Imkh22OjmTWliE7hgd7jiUBKFdMoC7h17M4YBgvj4tWf5uBSsbu4fvAhIjcZV
	 lMuV3OBbbdIoStjk3LpHM5FsNEV38VnPa916cXBtTCvgTC1zktLH3PAIFRy8Q+chOb
	 PmAfh+IBkFXburjjI4PrUONtLFcA4NlsVdh9BtRZRNpOa2NDY1PI55BChKBLwZfZaP
	 NMs3GwLT/nqyi+pq9pT+dOGDDjtKH5UCmOL+XbplqQ1jt6imwrVjnb3nWSUl36GKsh
	 TjpEV3fPm4ZvTA+DPXCPhhnpGgZVSZBxvMxDAIFknQvoexh1si6WGVOTRqz+4h8X6D
	 Sb+w8OyH4MqwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FA3380AA7E;
	Sun, 26 Oct 2025 17:00:27 +0000 (UTC)
Subject: Re: [GIT PULL] timers/urgent for v6.18-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251026113532.GAaP4HhADWuKp1XI16@fat_crate.local>
References: <20251026113532.GAaP4HhADWuKp1XI16@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251026113532.GAaP4HhADWuKp1XI16@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/timers_urgent_for_v6.18_rc3
X-PR-Tracked-Commit-Id: 39a9ed0fb6dac58547afdf9b6cb032d326a3698f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ea5092f5208d1758926ca54941f8a8ad49736b5
Message-Id: <176149802574.292745.710045920336323679.pr-tracker-bot@kernel.org>
Date: Sun, 26 Oct 2025 17:00:25 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 26 Oct 2025 12:35:32 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/timers_urgent_for_v6.18_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ea5092f5208d1758926ca54941f8a8ad49736b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

