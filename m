Return-Path: <linux-kernel+bounces-729157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA146B0329A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 20:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E52177C10
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 18:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC832882A8;
	Sun, 13 Jul 2025 18:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKYoH5T8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0B42853EA
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 18:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752430191; cv=none; b=tBk8cncHMNn7dYA4KSQLVSPuh8GTdW9PREhtakLMachGjwmOvTJB52iSxkZ+v2hFuLEJHcZG+SZYwGNuOuALU2RjMh0wYalcJJHBRCeJoy2j7ior/Yd0B/RFHBJPjiq91oiqNo07YqR+iLvo07NwVlK3LPiNhFKqqawukZ455m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752430191; c=relaxed/simple;
	bh=V9sRWOVkIWYTkDOYlkFw2WVw0f4edpTiePn+NrcZn3o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nCjHoLbtdkc/SRTxaruq1a4BRtxTFZ3y+uITEQbP3sniJYI9Yv2Nq22nNl3PqcbxMWIR6JW9kkis5UqTPl5OVUFz28OJu61aeC7lUFR1ekorCe/VUQs2MjXSL9tzK1ba5yM+MP1uqLw8IMxrBTennv0c76SUNx7izoofibEuH08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKYoH5T8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FD5C4CEE3;
	Sun, 13 Jul 2025 18:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752430191;
	bh=V9sRWOVkIWYTkDOYlkFw2WVw0f4edpTiePn+NrcZn3o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FKYoH5T8N8gvbGXepzeINsZm/66yN/WLTTSoVIubsQaOBQJjsWkOtjqUkE5/9AiSx
	 m4yvnpqt1usUs4DUXcd3+tvUH07TwBYbhyA0IXjgv0/LYXbqYLLk4Aovm27E8lgYQy
	 F/rtBcCRztmXtYIEafpWO/Mmh4XxV5KHQ/XQo5+FF14A2h+6PXvPQZbPgFqYlWs3UL
	 HvOsw1zvBz49D8YuJPsYiOCDDg8aV1hpwZWlPQmmcZnr6z+Fdv/rMWWug1EpdcxHoh
	 tYz0Z+ccUF8mZUSfg8GZa523AB0cSx2U0i5CxV2BdbpbHq0z9pIYNP3Iurq2TfGrDm
	 rmvkYRZi9gqNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC9E383B276;
	Sun, 13 Jul 2025 18:10:13 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.16-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250713102551.GAaHOJr6ue89FBosE1@fat_crate.local>
References: <20250713102551.GAaHOJr6ue89FBosE1@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250713102551.GAaHOJr6ue89FBosE1@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.16_rc6
X-PR-Tracked-Commit-Id: cb73e53f7c0700285d743e7afbe37cba9f7df8f3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d5d62298b8b5017d6677af28e021f7ad13f7a62
Message-Id: <175243021250.2829992.9470027530882533397.pr-tracker-bot@kernel.org>
Date: Sun, 13 Jul 2025 18:10:12 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 13 Jul 2025 12:25:51 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.16_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d5d62298b8b5017d6677af28e021f7ad13f7a62

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

