Return-Path: <linux-kernel+bounces-837026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D96BAB1BC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBAA519255E6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF19F23D7FC;
	Tue, 30 Sep 2025 02:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBL7Q9yj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A4023CEF9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759200898; cv=none; b=e5z5eAWy1wMJ9t625V2LYy32BT00OxY7sdHCWUnYnzSxzDcgLcILUmoKDZKuPLTQw2UPAY/OywWfLfylS6vWBvckpAM6RSovzrslZyNqwXr8pDwNJ7oBVhLJFKjPNEWyw+JwiIuCGtxjogIoLtz2wCft9F7N9CZAHg3XiAiiIcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759200898; c=relaxed/simple;
	bh=aBszSgASonpZWC82V9x0owSaL1kG0Jo/J08UI3a/8Yo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Lpw3KCsxxjI0v1cyYtKIcR31XFWNK6/b+EgxOO+ATglFAYguWcbuKTD1hjxx5Wxj9j6l0HzSSqyXNo63Aw4E0ck8iZ/iNMS5WEOU44ThwZDaPfSw1jAelXS00GP+J/phrqsUOLbD4Vn0I9pXWh5TwN1Qq3UP9Rcz4/7yazpXhPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBL7Q9yj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B33DC4CEF4;
	Tue, 30 Sep 2025 02:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759200898;
	bh=aBszSgASonpZWC82V9x0owSaL1kG0Jo/J08UI3a/8Yo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WBL7Q9yjMnLmk7lBK8dCo+VC97L0GqRx9jBwre5b8Oub9LF9c1YaS1B/UsDttZhdW
	 dMAp0qdhRdX4gsDeyD9Nx+EiVHzlit/+IHCkpgteNIEanOhSELgA7LhNBEhQrumV/U
	 31Qb6pKpDFL8xxyb6z6s03FavvFLbdHsfP9xMoJoajxFXnnpW2Xe3accUv+t1aHU59
	 NklxQmjdrKIRwvyMX74/uAWEZTnM9xKudY0AQwCn1jcx/ou51bxtl2blMGrYpKeyMn
	 7393WzAlE3FFXA6o5ds91FVE1s66KQq3ATWg7Ma0wH0fLvMQBfmsinEWKKqLVWF3BH
	 zxrg/GH3Vmw4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADECF39D0C1A;
	Tue, 30 Sep 2025 02:54:52 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250926113107.22638-1-jgross@suse.com>
References: <20250926113107.22638-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250926113107.22638-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.18-rc1-tag
X-PR-Tracked-Commit-Id: 9d52b0b41be5b932a0a929c10038f1bb04af4ca5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 30d4efb2f5a515a60fe6b0ca85362cbebea21e2f
Message-Id: <175920089129.1805104.16547639794605921099.pr-tracker-bot@kernel.org>
Date: Tue, 30 Sep 2025 02:54:51 +0000
To: Juergen Gross <jgross@suse.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, sstabellini@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 13:31:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.18-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/30d4efb2f5a515a60fe6b0ca85362cbebea21e2f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

