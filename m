Return-Path: <linux-kernel+bounces-780093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42462B2FD90
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60604A03BCB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3ED92EDD41;
	Thu, 21 Aug 2025 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDeCkhL/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5751D8E01;
	Thu, 21 Aug 2025 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755787816; cv=none; b=UAEKheYBGPBpFgUDBxc8djDfhPiRiRameroZGwzX2QNu0oMYP1e9r8mTg9HqDe0u8OvoSnP024yJNzQ6vpx04gIbuDil21CmdSyMrCBiYUlfuxMmKbn8QBzy3iSPvenZkVF0G2kOEFFFNHt/ZsvNUOPcwKb8cV6JlJwHJqvjN/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755787816; c=relaxed/simple;
	bh=LUNHhOeProkO+2w/4nY2nMhxYqrg5esMB9L9HARyL00=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ngs5xtO72mHJmdRZNkM/2s0xtsq3QgcTPix7jTIP7uI+DVrHMuBBtbxmGApHSn3ziNOEKfgs0yw+rCcmvq+lBYV5OVgCKp/ohZ2wi3tpHQHl324OAYuPffKSOtmTA955sfnL1xTn4Ew2NM+HBQIiU29ZZYf6fs5moc5Ju3AlROY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDeCkhL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8C9C4CEEB;
	Thu, 21 Aug 2025 14:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755787816;
	bh=LUNHhOeProkO+2w/4nY2nMhxYqrg5esMB9L9HARyL00=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aDeCkhL/xC8rJ3n2yCjGNMJP9e/4Q5h6XS0EqaZn1UCaO0xybMy8FdEISHrdHKOd7
	 PsmnfjcW9kRbw2nTy4lWXqlJAyUX6OWhkSrK8kR7c0Mi3Tjvd+X3EvVfIGl1bsP97V
	 dwIGMQwpNRKNskxPAr79fMWFuonZdh8owQ9+KRi7dFCaVTomqtbfCTybA9m/NmusR/
	 oLAG/V/Y+Hc0LEj2pap/QfMhGa3fgW/f7fVAYgImde3nCOvKts8qqzjpP6vsRwU5YI
	 Hm3cJc/4araTmC2BVW5aVnja9vK4o8gQ3jag/YCx2PQ/cS1vbpsZGO/8jZadlRRjz5
	 +EqcNozKmwaVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71089383BF5B;
	Thu, 21 Aug 2025 14:50:26 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v6.17-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250821122410.1144154-1-chenhuacai@loongson.cn>
References: <20250821122410.1144154-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250821122410.1144154-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.17-1
X-PR-Tracked-Commit-Id: 538c06e3964a8e94b645686cc58ccc4a06fa6330
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c656b1efde6ce86a6c810d27a5f925e938d568d
Message-Id: <175578782513.1072218.4196681357493888705.pr-tracker-bot@kernel.org>
Date: Thu, 21 Aug 2025 14:50:25 +0000
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Aug 2025 20:24:10 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.17-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c656b1efde6ce86a6c810d27a5f925e938d568d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

