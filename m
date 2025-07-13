Return-Path: <linux-kernel+bounces-729154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7282B03297
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 20:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFEBC188737C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 18:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80498285419;
	Sun, 13 Jul 2025 18:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRb/izNn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E121D4C9F
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 18:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752430189; cv=none; b=IrCJRSAJm20AFarlDuC9FrJH54vG/IZf1qbt27OisWpmhVLScFqX23wubboEoSvgWZkzm1gNYV7ln3ZZ1xpanID/sb/zVph6jMBx96RkFM1B/hTwSDfG2mKlfpjpeaOc324NJkrebA53bX3Xjp67BCudp5M/whV7FV5WQl+UqfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752430189; c=relaxed/simple;
	bh=qenY/+0Opmmk1H02KsnZF0juQ40WdDyEQEHTmYBTUPE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jdwnDjW5AsP26DeAZEByNXhzqRUjIrmN3VlY7jOSU2/7U4k+njVcSnut9/D49jL+zvPSxd1aMTUQd8IarlljEJIkFvW3xNxgjBHVIq5PwF6/SD/99ptTeeg1bqNTPve5UkUg6X4paCc9jOken7pN9+UUJ3CPFDi//KdMuXNR2Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRb/izNn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6751FC4CEE3;
	Sun, 13 Jul 2025 18:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752430188;
	bh=qenY/+0Opmmk1H02KsnZF0juQ40WdDyEQEHTmYBTUPE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uRb/izNnY1gdTk/2DFdllBpAcLAj3sAlOwSVsoL618PD2jx50487REBKr3VWJ+TWY
	 SPaa+vNhIzjDepn1VM6x7T6TebItHiNSizaJ/JkAlNHvCRSdXF6UiDV1qCUnYjwC1s
	 U5UE186Kry3tT2KlADvsHdVLzh96r9915Bikfd6ytPKW7OWacsd/V4jO/wnGKAzEZf
	 r8zUk0ECLJf+QoPxbBOg5OgXTKvZsWsCBighOc2lho1vKlYU6TzNL1QiW5YG6n6Alz
	 OUJYyppo/PWpwJKtyYhRqXG2jYb3q4GF7eho9mBo3ajgd1G24cd3NQT2c50lL707Qx
	 4acJ+Mbtuf/rQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD9D383B276;
	Sun, 13 Jul 2025 18:10:10 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for v6.16-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250713100831.GAaHOFn2t9qPFNlkf0@fat_crate.local>
References: <20250713100831.GAaHOFn2t9qPFNlkf0@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250713100831.GAaHOFn2t9qPFNlkf0@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/perf_urgent_for_v6.16_rc6
X-PR-Tracked-Commit-Id: 3da6bb419750f3ad834786d6ba7c9d5d062c770b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a197b757690ecdd60601bbc977b66bf38f2297d
Message-Id: <175243020960.2829992.767172179183593329.pr-tracker-bot@kernel.org>
Date: Sun, 13 Jul 2025 18:10:09 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 13 Jul 2025 12:08:31 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/perf_urgent_for_v6.16_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a197b757690ecdd60601bbc977b66bf38f2297d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

