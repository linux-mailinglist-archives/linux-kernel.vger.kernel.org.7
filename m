Return-Path: <linux-kernel+bounces-761338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2FCB1F88B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 07:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B54C17B56C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 05:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389FD1E834B;
	Sun, 10 Aug 2025 05:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaE2wFZB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFEB1F5433
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 05:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754805502; cv=none; b=JjOYx9cO2OrrOAWKC9qlbTlmggyZjm7r8I/IU5PDArNFkrJgFeJwD3//WZ5f/3BRDXgRq8QBYeCYPJSo0+6A1mM7at9S4fYUB8/CAfz/eq3/Gmm65ked+8g2Fpa4xduXALc/IvQ1tHEGTo6unvrALBy5ybb+pzWF+vw3gIxLKF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754805502; c=relaxed/simple;
	bh=rCWpyGmTQpGRw81HZ4E5oJAdbyBnwPl7DSv2tUoDWsI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LPvn8UQ1d4Sdb55DskH19TCeUdPe0ii8yM/TtYQBaQ6d/EpDcWKrQ8ugEclTAQguoi5wKiRPrd8dA84HXdCdf96bsVhzO6hkY+DonlT/EDI+81UHcRwMP6WvGv2HoFqTMGBoKTE2W49TcE1jhxyJb1iz6VFZijEC+QtP3/ucWsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaE2wFZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD2AC4CEEB;
	Sun, 10 Aug 2025 05:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754805502;
	bh=rCWpyGmTQpGRw81HZ4E5oJAdbyBnwPl7DSv2tUoDWsI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NaE2wFZBsRMEbugOIrOE/zcSdWTMitacQVKDmxZUR/0MXeVYrurFMjl7SYbkRTzsv
	 VYN5q1tlgTJIMDloq5tiOELrSD6YFvbphZwefF1Scyf+K64SQr8f6bIsbMZzFjXD6L
	 ur2AWc28nHGX3DvbIN9AJb59yBwD1Au1ye4iRvte0UZ03vcI+zHh4FGG525dBuDmBz
	 6fIm21ziXw0wVGjIz442y2vQIcR95zlbqWM/OQIqBg1YotTW7sXetm4zwi6fQZJD6h
	 HlSV/VmqFhZLBBgi/Vb53mthgqnzF58fMuts5ZavA5mht7i5OeGXmpenxKyZBNGqs0
	 78k2ZqfOknRCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A07383BF5A;
	Sun, 10 Aug 2025 05:58:36 +0000 (UTC)
Subject: Re: [GIT PULL] smp/urgent for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250809185839.GAaJeaX7TVfVJHa2Oe@fat_crate.local>
References: <20250809185839.GAaJeaX7TVfVJHa2Oe@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250809185839.GAaJeaX7TVfVJHa2Oe@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/smp_urgent_for_v6.17_rc1
X-PR-Tracked-Commit-Id: da274853fe7dbc7124e2dd84dad802be52a09321
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b96ddbc5c88791260ab202e835425dfddbdd60d9
Message-Id: <175480551480.677104.13177986870429792802.pr-tracker-bot@kernel.org>
Date: Sun, 10 Aug 2025 05:58:34 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 9 Aug 2025 20:58:39 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/smp_urgent_for_v6.17_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b96ddbc5c88791260ab202e835425dfddbdd60d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

