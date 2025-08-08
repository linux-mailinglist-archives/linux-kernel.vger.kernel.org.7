Return-Path: <linux-kernel+bounces-759695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08942B1E13E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 06:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7591189D5D3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 04:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DF11D514B;
	Fri,  8 Aug 2025 04:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+6IqODI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B5C288CC;
	Fri,  8 Aug 2025 04:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754627449; cv=none; b=p2nG3oAM/sIcqxEHVmmOyIu3BSYQMVoVDJud3YXslIk/jRzJoIL8t710TgbjVJjLu9CYNntQIjhwvTcV25/Idm40BONJejsgV5AYHC1Ht5iTRmKmeN+Jyf+HaEEuQ/nc3ECOHU4Z+BTQ3jlbE5DrtHzP81PxrQr3j8rAgWcWFL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754627449; c=relaxed/simple;
	bh=4ymvK8BInbX4lIIBa433a4zgHJB0+Ap83rZk2BwhMMs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ERCmtMHg+aWczODEDmLsLaUEaZp7TsTMY/AaiYLU3j+80s45/yqh3wqTgzdjz6q8n88aqj4p+1MpNxWKBB3t9ovRNgZjRHYtgz/rF5Uf5+mIGjhuqAWymYsfwGqVtc/d3uUpIoLBTCtxoldNlk4AKMFTN7F2kkQs5KERKlDwzAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+6IqODI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB682C4CEED;
	Fri,  8 Aug 2025 04:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754627449;
	bh=4ymvK8BInbX4lIIBa433a4zgHJB0+Ap83rZk2BwhMMs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=q+6IqODIpJXzMKkBiGmrfDwbEA1v3m+nY87fjSymVVV1RXDtYUgbEPoY5v5kn61wi
	 DklWxeSdEnvjwfw86eHPDRkGZsPeZHQj6xeATVWYIV3g9VHcqePl0wedOsBztNPfQO
	 e/eCszQey3AmOpWk05+j9lYfjXoQJbYvZ8ht/m/6Ad8Zz08ArQmHY5CT1z3d9RVCqi
	 xIYJEGuMPZ2xymwTqQxZi2Bc4yOLuCaxukW49kjN36AOQmdocunnQyuWQaaQ0QpUsY
	 rm93KsjLI7bmAOLCJ49aST5aFNDB/GdjGZvy21YdqbzTT+BvxzDjcCHKbLRBqILeIC
	 YmH1vILbUmVkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 74B19383BF5A;
	Fri,  8 Aug 2025 04:31:03 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250807144345.806381-1-kuba@kernel.org>
References: <20250807144345.806381-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250807144345.806381-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.17-rc1
X-PR-Tracked-Commit-Id: d942fe13f72bec92f6c689fbd74c5ec38228c16a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae633388cae349886f1a3cfb27aa092854b24c1b
Message-Id: <175462746203.4027442.16716797683985916411.pr-tracker-bot@kernel.org>
Date: Fri, 08 Aug 2025 04:31:02 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  7 Aug 2025 07:43:45 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae633388cae349886f1a3cfb27aa092854b24c1b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

