Return-Path: <linux-kernel+bounces-825017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF024B8AB87
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 741E03B2588
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B47322744;
	Fri, 19 Sep 2025 17:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ee0socMM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1100322742;
	Fri, 19 Sep 2025 17:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758302117; cv=none; b=QazQ9/BXfPgGEmdoZ7KHrl5LCGrt2sUFg1swciwnIo5M9bczitBsOxC7EShIoXXPAcA5VusV5L8cVDn2yJ0/q7vL46GXsYYAQZY2DH+49mtzBWcMURMz4mD3mupc1qKDSwRkz7BjCpGX9aXVH1cF1z2fkDbHVYiKCQGcpRi21hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758302117; c=relaxed/simple;
	bh=HXG/CmUGTgNOertLWEyVW5762g+ACt+EH60Tpst+e18=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nHvt2QcCOu3KRxRkEVcDBOXAyRi0v/3xs16OR4XkxH8WVG4hbQcnwpQ5eOKo40kH375PsMCC7WvXILEMoAlNlySH+uamj0NkwffnEeO9hMpHrjDd/cAlTi0/8cEvX2K+ecp9KGaEh/1WNUR09xQ+18UGbzlSdzt3PZlP5bZdgzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ee0socMM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BD3C4CEF0;
	Fri, 19 Sep 2025 17:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758302116;
	bh=HXG/CmUGTgNOertLWEyVW5762g+ACt+EH60Tpst+e18=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ee0socMMQn9OihYMsxqrwFwXJTp9iuLz5HjVxEL1aRm6XcOpVeAosro6FrVNeMcap
	 3QqFBQ+jQBHhNH7bVgqIBo9JLYR7WOsU5gYIQnDmi/aNGuu+9VLWfyQAQMRCjvdnY6
	 aerymI9u7n5H/BYEzT3gt7lb1F7bWx9n5ddMOqTKFCK6a34NYSYDhjPhT4mAoRExZi
	 nqjn6XnVOH0Mma9lSKsJcks44mCj7KKBChcthOUaQDr0b3WsWCvhG2YmH8vOMtwt0P
	 X4jlxSqlsAjrq76/43/mKWs/SfwAK7w/XKdSc29TtKFFG/XFUZ7H2I8XZbmK/Grz6k
	 gSuM+w0+6A27w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1E939D0C20;
	Fri, 19 Sep 2025 17:15:16 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v6.17-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250919072154.2509239-1-chenhuacai@loongson.cn>
References: <20250919072154.2509239-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <loongarch.lists.linux.dev>
X-PR-Tracked-Message-Id: <20250919072154.2509239-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.17-2
X-PR-Tracked-Commit-Id: 8dc5245673cf7f33743e5c0d2a4207c0b8df3067
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 39879e3a41061e2fc8313d55bcdbed6f458ae75d
Message-Id: <175830211547.3636420.5775908855255160873.pr-tracker-bot@kernel.org>
Date: Fri, 19 Sep 2025 17:15:15 +0000
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Sep 2025 15:21:54 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.17-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/39879e3a41061e2fc8313d55bcdbed6f458ae75d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

