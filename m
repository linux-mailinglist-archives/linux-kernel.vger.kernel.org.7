Return-Path: <linux-kernel+bounces-728728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B143B02C54
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 20:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C69FCA406F1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 18:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6618D289349;
	Sat, 12 Jul 2025 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgOuigec"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53C070823
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752344093; cv=none; b=PtLJcl0KZbe9TRZ6LkK4OtV+WI+LlEewM8gjPLtfFFWh2l95+wAvkPkLHJoXjS0G7rMfavp+33RpDCjdu51GvKLKkCFYPrkEw+t0jCLaWBuxAWY+oFwg8U/bEbyDwtIkfihVm7KHtpxcG2ufupuUTCVGaWPChFRsuqXjDSaYG/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752344093; c=relaxed/simple;
	bh=kdFAdGwoMszgWNtgiLDa//5zXP77tT6O0euO7TMeLh4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SJ7sbfRY7z9V+IKiEmd/X1uqTrfSQ4iD9z4ZZCxbjH9Ukr1PL8PHahpurg0FS9P5AeAT8lpVDsixYKQIwjtJKUZQNZGuXm3ans50z606OKleQdjGKqNX2fQ3UagkcVutMrj9AYBnQFGlcKQiEo/Ps1fIFN38VyXVmsoVIcr3oyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgOuigec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C30FC4CEEF;
	Sat, 12 Jul 2025 18:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752344093;
	bh=kdFAdGwoMszgWNtgiLDa//5zXP77tT6O0euO7TMeLh4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KgOuigeco2c+rDrZdzdEIEKQeH5WB+H4g6QR0JVmKtwP13k7Ry5WwYFwhN53ScbF8
	 ILFMr0ob2b8+ZP/zB00Bqiejs9sdwc4KBXM+fzZwwF/xbTMmIKtOvm43oFIKvUZeVv
	 IalU2xH12YkbKP3+dtCZRRVq5/sIhiHqFuA1+d3jbdBGU2v72IoleGykce+XUOixO7
	 QAIBGdyXo3DAbBs1wuAdKducu7jJSiEWnE307NoBzA1Y8JDEnhUlD1faRV0sWzB6pW
	 xh5Dz86WjAJWQOWMLmcsv7PrrDk0pUl+yPP3g8CVNEdB4NJM53HcT+rG2kkzGx7s7y
	 4uWAjZaI7WxFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71124383B276;
	Sat, 12 Jul 2025 18:15:16 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.16-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <aHKCLQaEYGPRR6mN@debian>
References: <aHKCLQaEYGPRR6mN@debian>
X-PR-Tracked-List-Id: <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <aHKCLQaEYGPRR6mN@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.16-rc6-fixes
X-PR-Tracked-Commit-Id: b44686c8391b427fb1c85a31c35077e6947c6d90
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b428e1cfcc4c5f063bb8b367beb71ee06470d4b
Message-Id: <175234411505.2616006.3550691267364268376.pr-tracker-bot@kernel.org>
Date: Sat, 12 Jul 2025 18:15:15 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>, Hongbo Li <lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 12 Jul 2025 23:41:33 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.16-rc6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b428e1cfcc4c5f063bb8b367beb71ee06470d4b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

