Return-Path: <linux-kernel+bounces-750156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (unknown [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBF0B157EE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 05:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 286634E33E0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 03:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB011F8725;
	Wed, 30 Jul 2025 03:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kacyo8hE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7BD1FBC92
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753846787; cv=none; b=jmI/i/qCtY7ZT0FUED800NKK4j9kUhSVWKxXnCQ5Dsj5/ZFGnHlGoy6H+Afk9z/jeryCvaG/cSePWGlNu4tRjOJjEds0d6pWH7otvnwxT4GpGnVSVGxleBoTA4ChYDTUvHPeO63Z4YvC5jb+wJU9mSVf/X0LlgImExo4ZwXDuBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753846787; c=relaxed/simple;
	bh=yBAOkMhwVzF4ynTGdjbiFlHcayAZvDkxHwKl3rhwg2M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sYEbC/iBG/Vb8lMGv6l2pv5eE6GHJMt9dhs5+JukfZqoFbP6sFuGYFVYHoRt772KQt8b3IG4pDtt7BQMxXtPM7zTcKK4qkTCaOz6vgYCHVgV/VQnLhA/QRxJ3NCX+VVoIfRceWTYUc7vWows156pg03+MjJ1f1DSoEXMsx8fSik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kacyo8hE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E925C4CEE7;
	Wed, 30 Jul 2025 03:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753846785;
	bh=yBAOkMhwVzF4ynTGdjbiFlHcayAZvDkxHwKl3rhwg2M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kacyo8hE5mw3WFnGGX0m+dkC2G3801ucQ+n+E7qWPt/t1ZGJZSutnjVL7wTqVn6fI
	 GL2SNiNWiFyj2mfMkUX/4cDPQDqodRyuy3rIVNAA8LfwrCRsiH82I/FOhJWDBRRVbQ
	 AnWY+JOTCHOMeIhxbI17K1wirOVEcNlufbyI2mdBIxG7NqY+UUdDNtHjBcsdAVKpk/
	 y5JWx6izBqp7dMuLP1QypHIFgdBSkTNLJsfseSB8ddiuEhMQBZtkCTyTTKvwofOHkh
	 +JmX97JKjyI0IolGBkMqWKcutbp7fxXIvuJXwHzkCO71w6FiH7LvXqGKZxQ46r3hTT
	 bsn96Fk34T48w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF47383BF5F;
	Wed, 30 Jul 2025 03:40:02 +0000 (UTC)
Subject: Re: [GIT PULL] x86/kconfig changes for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <aIh1UCUUn5vcb1Pj@gmail.com>
References: <aIh1UCUUn5vcb1Pj@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aIh1UCUUn5vcb1Pj@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-kconfig-2025-07-29
X-PR-Tracked-Commit-Id: 9df5e79bf1a30b94dc068ab2ed2279e40f430b88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e12ac84acc722f06e8b1be66fbb138c5934aaf54
Message-Id: <175384680132.1749338.11459838764929362844.pr-tracker-bot@kernel.org>
Date: Wed, 30 Jul 2025 03:40:01 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 29 Jul 2025 09:16:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-kconfig-2025-07-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e12ac84acc722f06e8b1be66fbb138c5934aaf54

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

