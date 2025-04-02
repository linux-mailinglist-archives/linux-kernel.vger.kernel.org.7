Return-Path: <linux-kernel+bounces-584318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39909A785FC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 03:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDDD81890BA9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 01:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CF4B67F;
	Wed,  2 Apr 2025 01:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1R91jfK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599DA17D2;
	Wed,  2 Apr 2025 01:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743555691; cv=none; b=Zobp4FXxU3A3B1R10LMuf7emQbgX/VgkLmrQAbKBMxbMUs3BqOFYli96+lWRH6lQtJzCdHkEomM5lJU39LL0sjr35TAmUJaWLDtN/3vQCQD/hYnziZ8sFsnKwbHW/kwV/7xnV0ZegCJ3Ux/UL1mXJjA6sAQjYkws80Oq5Nyazyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743555691; c=relaxed/simple;
	bh=TCwbdRaZ0QaArcJDO6JpFiFW83dmOg6oX6x+OZoeEnE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=b8mT1gZ31GI1W+DJQ75Nh4J/lBh9Rzc0aHKWmpUbROXYv2hafvFfhbwUF1vNXujg2Lz1CbgzuHxxKs60yveLEMlb+ENHmP5Qpoa3htSj8RJvnZNsMQgH9zcRI20jy/7wEB1mxA3jfbCI3Dg4e/EFRLecKLQPZ5/m1RUDFpeSsfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1R91jfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F55C4CEE4;
	Wed,  2 Apr 2025 01:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743555691;
	bh=TCwbdRaZ0QaArcJDO6JpFiFW83dmOg6oX6x+OZoeEnE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=j1R91jfKH4/RLZzexVYpCUtn9KHswVo7k53nw8g31lF2QHaSIzoo1qR4VJ/Wc6zUl
	 zOaMcd8XRFUA15JOkqLrp1/4BpClJncKC4cYsWnYDrcCBKJQIYWSJxOj5P8Kds4gtL
	 SFB33oj4t5SgtemDxK2/AOAFl7jt7v2a4C0z/oxkG+WAzCa2GHGqqwX6rLtfUjAzJr
	 Fnic4f4jYCqdad1xLR+/7UCdenPqmxC4H3+OOiy6uss8mUVbPe1vvUfEzuBINbfFzV
	 xrUzYd/0o7bQbv4Tw9D13EBQK0xMZnPe3Rz0c1a1Fnd+W6iZc56fbxNi+W3WD02nOn
	 xR5IXmQRNBwgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 361D0380AAFA;
	Wed,  2 Apr 2025 01:02:09 +0000 (UTC)
Subject: Re: [PULL REQUEST] i2c-for-6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z-gHSYOhavbE5h1v@shikoro>
References: <Z-gHSYOhavbE5h1v@shikoro>
X-PR-Tracked-List-Id: <linux-i2c.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z-gHSYOhavbE5h1v@shikoro>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-6.15-rc1
X-PR-Tracked-Commit-Id: 31396626eaf0be0e8edc87b801fcd205016e42d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 28a1b05678f4e88de90b0987b06e13c454ad9bd6
Message-Id: <174355572771.978371.6496006213263702993.pr-tracker-bot@kernel.org>
Date: Wed, 02 Apr 2025 01:02:07 +0000
To: Wolfram Sang <wsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 29 Mar 2025 15:44:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-6.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/28a1b05678f4e88de90b0987b06e13c454ad9bd6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

