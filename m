Return-Path: <linux-kernel+bounces-844705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2BABC28C8
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 21:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E33004F236D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 19:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D39D23AB88;
	Tue,  7 Oct 2025 19:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkJeEvw6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D451239E67
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 19:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759866386; cv=none; b=MDHatkoozoWTWYU9fSlk+VswHuZjCL4hI5sxVRPjJn/PVGMdkcIvzpa5fqmzDN1qn0CMx4ogn5QgYcfkQy66AtsYngvzowqELY9qUMRPW4am3zXkdQQvk0yuqr8bbSFjqk9AhkWfowq8+VliyXcvpZh3gWHChmwiF1CFUSydOSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759866386; c=relaxed/simple;
	bh=H9iMv8DP4rCfDg5wQ+Bud9X60bewZvgLeNlqUBM86gI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NsjevnC1fuRtKw/cRcc4+iXiNSjkZzUDUcoyXgHnbU4B+3WAwSQi7EEGuBNc3G9JwNzCVBoP+6iq3Y7SUeOliDS8ejpvJL3xDiSaTyecGpwOEmz0vM+vTG9CE2fRoF0D2voTWTAGh4+uN+11+zmumrTI40eph3rcIAuuH/rGZWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkJeEvw6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C880C4CEFE;
	Tue,  7 Oct 2025 19:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759866386;
	bh=H9iMv8DP4rCfDg5wQ+Bud9X60bewZvgLeNlqUBM86gI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FkJeEvw6CU+mmQWOn4KdWjSrRR60yjHU/Y0RKE9kU5QSv5gMldsPrGzF3FavSd6OV
	 w74WfYXKA7EqGtlfzCgHKPQF8KLQZoJfU53m3pVBlmnLWWT95NrHIBtNGzxbPjkMPd
	 RdFRdldSxprLF4E1vEXM4XARllLbXwSgfIrsOp2p6jjZ/Ea11FDK5wzI1EmikVTtyz
	 JqQpDaniXeOUBMIL4mpj5uQHORRm//A0IUa68EU+SzIUouSQr/bXHHOrtTiz6FFtpW
	 SAbnuqkgXat6wLRVGRR5ND1bivUxBad3F5rbwKiHFHu+9IgTko60zvJ7f8dVv2DcE7
	 ZnQBv6AxXlmLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE2039FEB73;
	Tue,  7 Oct 2025 19:46:16 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc/IIO driver fixes for 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aOUQ-nATuR-NzHLE@kroah.com>
References: <aOUQ-nATuR-NzHLE@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aOUQ-nATuR-NzHLE@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.18-rc1-2
X-PR-Tracked-Commit-Id: 10df039834f84a297c72ec962c0f9b7c8c5ca31a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fdb8d00af919d2403a9e40261cf3f78f0fd75212
Message-Id: <175986637535.2756271.16175317082501645607.pr-tracker-bot@kernel.org>
Date: Tue, 07 Oct 2025 19:46:15 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 7 Oct 2025 15:09:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.18-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fdb8d00af919d2403a9e40261cf3f78f0fd75212

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

