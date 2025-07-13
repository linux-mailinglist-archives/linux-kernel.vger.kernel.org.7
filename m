Return-Path: <linux-kernel+bounces-729155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3478AB03298
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 20:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86CBD177917
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 18:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A772868B5;
	Sun, 13 Jul 2025 18:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="di86VL8t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13973285CB2
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 18:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752430190; cv=none; b=K933gDbdTQwGX2hF8WKMXLcCMYBVSXzHaejOrPriIMgTNxeyUbBZXNVzyFEl9S7N5oKy37z1pwqNRffM7O5IpN8/hMEB/0uYT2uXEnuKyNzNQl5mvWIxKgYWwFBGJlcjTMJOiENDeVhn6A7zKxyj+ANamdMTmAgEnP4wVEyfOEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752430190; c=relaxed/simple;
	bh=iX00zbBtqCg9P6FTMMLMEON8DvRu3uEvif/c0LmRKoo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fvkSdQIm0EMkANhyQwkeAbl84y/Z0OBuMfvLg3jhiy3PLBp10dpNqaIguYWdAcPk32lEwCvJ9DPofzFicHLQl08Z+EOCqr8Oe5Re/6NIYqkUpDfDHRbm15DUOlQUzzB4cvt/V0lajipAngJU9Nyyatz7PGBskkeHoYHxYYG2mCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=di86VL8t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52A5C4CEF4;
	Sun, 13 Jul 2025 18:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752430189;
	bh=iX00zbBtqCg9P6FTMMLMEON8DvRu3uEvif/c0LmRKoo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=di86VL8tRSxg8IWe5QSvY4saWBWsoX7Gd//ygszmGTe/xQmoQTESvlW8+CcEp4k0r
	 531uos/5BB9ZTeJ2SYXr0Q97HnF/K/esV8ntiJxPz4ARxcMDMEK160Z+X2HnxdxToq
	 7y7oK4S7jujl0J9GBR9ODK+unfQDhvimvrzXf25iy3JJha3cTF8vNKa4rcRUPBNd8V
	 Hm3flz3y1xvnvArCSE+fZ8Jyq/xIbDa813PfJSuES8Lcmo54XZ7HnaRuBkhJBawyKT
	 aPwuHtAcTdRcbk9dcmq8ciDj2zCnKKdwl8eEiSFNXHTdIptuC2uRLjwteXHbNBZSU3
	 4s6l+IF1u5xRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71857383B279;
	Sun, 13 Jul 2025 18:10:12 +0000 (UTC)
Subject: Re: [GIT PULL] irq/urgent for v6.16-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250713101214.GAaHOGfkN6wjED7LW-@fat_crate.local>
References: <20250713101214.GAaHOGfkN6wjED7LW-@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250713101214.GAaHOGfkN6wjED7LW-@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.16_rc6
X-PR-Tracked-Commit-Id: a8b289f0f2dcbadd8c207ad8f33cf7ba2b4eb088
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 41998eeb29a187d66eec7699741cc278ce53d65b
Message-Id: <175243021212.2830616.12386162958430288255.pr-tracker-bot@kernel.org>
Date: Sun, 13 Jul 2025 18:10:12 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 13 Jul 2025 12:12:14 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.16_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/41998eeb29a187d66eec7699741cc278ce53d65b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

