Return-Path: <linux-kernel+bounces-844727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D5869BC29AA
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 22:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 777C4350A9E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 20:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E3123D7EA;
	Tue,  7 Oct 2025 20:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmYf1xIX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14121221F1F
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 20:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759867663; cv=none; b=R+YVfM5WMaCXircm8Ja2GNCYFblFhEmI5fBhtHPj6gLhhLIBhnqGXImjjZEMuY4Sz0TAiO1iPiwSDQurDP8jJXVt23ZUb1fBHj95ixIB4Tlyg+1xQ/Mc9IwGmaP074/98DwSM3VZqMeI0UczUbcozZ4FCnWIad3WES7+hkHDXog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759867663; c=relaxed/simple;
	bh=gd6LEcIXb4dKbzrKHC6SuSK/RTp3ujTrLrXX5yXpSSo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=o79QN85rBbMdytC/l3By8tVK5IF7dziWjbSfO0V0tl7J2dbQzsnJs5Ra7FL2sKyEqgwLJYLp27QINqzV3wtPHD9wCMxN4suTaJjHdL6Zxa6Ym+MJlH998Vh90+NtQudGulRku0gq25rY4LVS3w5crFKrSkzzyVkAjVGTEcAEP1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmYf1xIX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8EA5C4CEF1;
	Tue,  7 Oct 2025 20:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759867662;
	bh=gd6LEcIXb4dKbzrKHC6SuSK/RTp3ujTrLrXX5yXpSSo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AmYf1xIXUH9MQ8PmbjLmsFkmOdy+eJlLDn+16j2nVlIFxf6K60PDlT7UhB3fosNBv
	 Ethae14tPI8t2pUsWWuSWrTdFVxWJBjCzmrFMeDgVRfvQxBgOj7+SWmierj3RlzGaO
	 1f83goYpSdmliRqJBZ2ei+B4cZoPJWu4UrrvobjELLJvg8uM4emht4whC3iGzduaRB
	 E3hGA92H1KcRXffMkaO8SzCvxQaGI/9+TmwKDp3o4VMbw3m/QXadW1A5pvCtx1JpbX
	 SDiBN2rTAfVwP2CmcDzhlHUccIGyjfHu42QVU+0TNgBu4lfNGfHTF6vOQFxbE8DWsj
	 BXR9dDF6MbEYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DA539FEB75;
	Tue,  7 Oct 2025 20:07:33 +0000 (UTC)
Subject: Re: [GIT PULL] hardening fixes for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <202510070829.3F80E18@keescook>
References: <202510070829.3F80E18@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202510070829.3F80E18@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-fix1-v6.18-rc1
X-PR-Tracked-Commit-Id: b157dd228cf0ee24b2414712abd82bd3a8d5b009
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a8cdf51cda30f7461a98af821e8a28c5cb5f8878
Message-Id: <175986765173.2764520.3653443049301182888.pr-tracker-bot@kernel.org>
Date: Tue, 07 Oct 2025 20:07:31 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Carlos Llamas <cmllamas@google.com>, Kees Cook <kees@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Nathan Chancellor <nathan@kernel.org>, Vegard Nossum <vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 7 Oct 2025 08:31:05 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-fix1-v6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a8cdf51cda30f7461a98af821e8a28c5cb5f8878

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

