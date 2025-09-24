Return-Path: <linux-kernel+bounces-831296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 782F6B9C4C7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A222C1BC2FC5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D21280CD5;
	Wed, 24 Sep 2025 21:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nqc4PNqE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB50224B14;
	Wed, 24 Sep 2025 21:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758750430; cv=none; b=RtiDRVCikF+Yy8D3Z2ZBvVTibGvghqJ569qJ5LeKGWtpA734THWo7jLHZts6g2NP/iQ0LRHx0nKmuENps217ffevp2I3aQTjl1pAe0nmB30MZJC1paV2u4fLeo4ju9E0RPRgdS1MKxoGfojizupyKGu3BLWd3/SQp65A/zO+6co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758750430; c=relaxed/simple;
	bh=ANND0iRENRaFSgE/hRDoAWTStBO6vYY2JgBulVQWiNY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aSwHThLfTIpSVuhSHV8WbM8ZfxpgOQIXpG7Hxfx9LB09tH1zWG7CXyjWZqOGUCnzvsHwxsf2zvpXebYNDPY9P2t5zFKrORm+x79yJhq2EFmOCabt0i1DVxOEBfEl4+HKlJpBfnjJWEjFG/M1Z19hkR4CNqL+NvTK4CK4BwzJ8f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nqc4PNqE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAEBDC4CEE7;
	Wed, 24 Sep 2025 21:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758750429;
	bh=ANND0iRENRaFSgE/hRDoAWTStBO6vYY2JgBulVQWiNY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Nqc4PNqE6f/vBciuFeJBZkWPKGHKeTbRWqdfvotuXnfU32lKURFDzO0chk4DW7Xta
	 gL6vvLdE2kZ4O+bxXgMWDPIJSpRDWBW8topiNqc4iIb6f2vhiA3mG9sMEQlWpR+71n
	 lTuVk63mF64yHFxawcyEsYGQxnNwCqEXSHKSE6d+Fsl8oggdAnzVp9Y1jjV7kj/SR2
	 kSQDh7lmGZU+IdzrLX4cHDJJ6SyQ1A9WDKIYic4gh/IKkyLlcpC4yIh7beGkYUxbOK
	 kaYACZh0lvQRUVlWTpL9AKr7hCTIehADa/SpRljtVo5jXOneSYHAVrEVGnjyM8yO1m
	 LBxztGerNt3Fg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EF539D0C20;
	Wed, 24 Sep 2025 21:47:07 +0000 (UTC)
Subject: Re: [GIT PULL] soc: fixes for 6.17, part 3
From: pr-tracker-bot@kernel.org
In-Reply-To: <6565e739-19d5-465a-9fb5-d918bcb24b56@app.fastmail.com>
References: <6565e739-19d5-465a-9fb5-d918bcb24b56@app.fastmail.com>
X-PR-Tracked-List-Id: <soc.lists.linux.dev>
X-PR-Tracked-Message-Id: <6565e739-19d5-465a-9fb5-d918bcb24b56@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.17-3
X-PR-Tracked-Commit-Id: 13923775d5b0b47656e800bec7baf50a20474aaf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea78c190810ecd2c9dfb6d22b52fc670a38e8836
Message-Id: <175875042603.2710061.11952077850560903706.pr-tracker-bot@kernel.org>
Date: Wed, 24 Sep 2025 21:47:06 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, soc@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 24 Sep 2025 23:08:56 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.17-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea78c190810ecd2c9dfb6d22b52fc670a38e8836

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

