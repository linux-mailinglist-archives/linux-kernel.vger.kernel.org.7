Return-Path: <linux-kernel+bounces-748687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 766E3B144C7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 01:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F22A77AE4A5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 23:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AA624DD18;
	Mon, 28 Jul 2025 23:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4TJW2XC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CAF24DFF3
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 23:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753745997; cv=none; b=DQjr6PzSS+b59HsIBu4FVA3XA4Gm0t1d15d4nSiqUK/ncJDdTDQ5IIVbq+rBcOspPb9gI7vE0JvuSWuyo6YzQNCQuo0WGP2NGnA+x99PlU1s7KJdYapZGIVQCdu6lZUH6h6qfqmnUMqr8ICsBxZdNh5MPyjehTw2AmlXiAVAbE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753745997; c=relaxed/simple;
	bh=QMnkIaz0iXZsmhCIeosTXR1G8DaDTmolWiccwcRi0VA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Q4I9zjcnet9ozmI1opj1vs7VhWDzXpzoP/D3R21yp1a5DTPdaGziRaxbtvapcxIznUZwTK7N8ryaEAR0M1GyQ9kdMzcRLCOky3M1mrVuBNWh4x9CQ0+AYdNsYBfk9I+cGjHrwfAvmeri3DI83c0FcExsCAQlLlP/zzoSmpwBsMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4TJW2XC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D339CC4CEF6;
	Mon, 28 Jul 2025 23:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753745996;
	bh=QMnkIaz0iXZsmhCIeosTXR1G8DaDTmolWiccwcRi0VA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Q4TJW2XC4CF15hX0HGmKVIyVkl/tZRrEWTwIZ02S7589+61svFtjRnmnMAvgvyEkP
	 1Ot4DEYiRRK2nyRu8DUmE/Rmf+00DndH6t45pe6nm0nCsxuttHoba8vv+DwKScCpIx
	 H7lJhqj/jqf3sWAabFqVPSWk90Dabjj+P1ZvmExSWdHFj0CB+CHmbqRj/Lq2HimHMW
	 dCLOAJKIq4cFZVcpuQrirxIVc1gFSBcO3qomBp3b3Em1AfmgrUOgVrH7Kguxb4q66s
	 uQF1Z1qVRNfiITM+Fa+KXryGGd64k1u8jYsVragJgr0DYR4tTr0JICUVfNw+6HLWFQ
	 vLOOSyfvSTCog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id A2888383BF60;
	Mon, 28 Jul 2025 23:40:14 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aIblpKzSWEEYwQ06@debian>
References: <aIblpKzSWEEYwQ06@debian>
X-PR-Tracked-List-Id: <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <aIblpKzSWEEYwQ06@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.17-rc1
X-PR-Tracked-Commit-Id: df0ce6cefa453d2236381645e529a27ef2f0a573
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 76a9701325d39d8602695b19c49a9d0828c897ca
Message-Id: <175374601352.885311.5248850551297933254.pr-tracker-bot@kernel.org>
Date: Mon, 28 Jul 2025 23:40:13 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>, Bo Liu <liubo03@inspur.com>, Hongbo Li <lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 10:51:16 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/76a9701325d39d8602695b19c49a9d0828c897ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

