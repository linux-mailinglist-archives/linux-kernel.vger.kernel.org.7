Return-Path: <linux-kernel+bounces-746357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67526B125B8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776D1188BB70
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C9525A352;
	Fri, 25 Jul 2025 20:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXHRBHFS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB3723F421
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753476050; cv=none; b=XYv53X0cQ6jjp72aeUoUxspW8qGPQPRwh4GDK4hQ6iwUH8KIIuOWWPl0LzMG8ik1naEDlWhZUrpUTuepBSlJH08Ncx/3TQlS6bbg2Z93mUbc7izi58KRKyKXs1gmWERq/Nw/jj1STXPt4BDHQudfnF9C7Nmo699Aelz2w4whLWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753476050; c=relaxed/simple;
	bh=4ZyJMM3NsGdOvy5p2SRm2Vl9kymKPsHut7W9aDuZrlQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=L0+Nrdux1Zi25iVhfBJIhfocZ6Ga9Udn0wjUuAQMOf8ZbSviVkUj1UqMZoKJELzYmFvmG7WA4pG83gsWJXKbekqyKlQvPR7SSCwwocW2PvNG2YJKdumfQxwVnXYbHa9MlJrUj+C7SSWnbL2ZpAw9wY6OyBgbi1Zi1Rqdnf0CuhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXHRBHFS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B928C4CEE7;
	Fri, 25 Jul 2025 20:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753476050;
	bh=4ZyJMM3NsGdOvy5p2SRm2Vl9kymKPsHut7W9aDuZrlQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WXHRBHFSdHvprnITozVMz70DJaYF4P7xQI1NECB1CtN1oLsu5QOZPC3dqZkMml4Tj
	 YDzxlvlOaiNlQwRskxcmVX+DW02MRmT0p3TyR51EpUzlOM4DVFm0P618GMlp5alB/p
	 /xSSNOw5Y/4nWGL+SxYoCFJgUPeaKup/X7p9KrUJy0a1md485oWTDz+Y5vMTg70ieo
	 nblIR2WFT0v7x7s2irJBtHpkzTGe3QSXv2JvlkUWg9UZ+MTNgMH5wTPBorlQle9m/Z
	 4+v/sHBs6uZb9Vgucrvj1bbOGg5cc7Nzn1eQFqQ0N0/WijYpuPWEfhOonzPnR8Mwlv
	 E02HOxPkdTIeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2EB383BF5B;
	Fri, 25 Jul 2025 20:41:08 +0000 (UTC)
Subject: Re: [git pull] drm fixes (part two) for 6.16-rc8/final
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tx6TmT-qQO+MDV5GXCbUbTASh2Ly=eLMJb5+rB6MyJWVA@mail.gmail.com>
References: <CAPM=9tx6TmT-qQO+MDV5GXCbUbTASh2Ly=eLMJb5+rB6MyJWVA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tx6TmT-qQO+MDV5GXCbUbTASh2Ly=eLMJb5+rB6MyJWVA@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-07-26
X-PR-Tracked-Commit-Id: 14e8f8e74dc137ff9f1dfb2781784ceb19497ee5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5f33ebd2018ced2600b3fad2f8e2052498eb4072
Message-Id: <175347606759.3262906.14193704908675661072.pr-tracker-bot@kernel.org>
Date: Fri, 25 Jul 2025 20:41:07 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Simona Vetter <simona@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 26 Jul 2025 06:32:20 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-07-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5f33ebd2018ced2600b3fad2f8e2052498eb4072

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

