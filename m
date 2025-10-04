Return-Path: <linux-kernel+bounces-841920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A682BB8882
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 04:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A77C84F0CBF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 02:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E87213237;
	Sat,  4 Oct 2025 02:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnBWS+/6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364EB211472;
	Sat,  4 Oct 2025 02:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759545691; cv=none; b=m3amMhVNyPCRHsPK1uulQ8dMPPp808kpHVYBDC6nheXwbKcVr4Vev0BHkhLn3n8GzcyAtIhgwTXOmtzwPnfCUmpUjPlRH2aA4NRlDOGH/cZC0a/9yRYuxVR8mPWHyfLjKlsouSM/i4OoPL0EJdLud8ENzspsGcYEwYPd3Jk0b/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759545691; c=relaxed/simple;
	bh=qWUijZ4ZIxPdadWhj/2cc9CErbNcnOPtwUfHLX7HEvQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Dm/teO40LKhHUiJSkQfTzoAXNSFCOwkvl+t/1JAAvukMWbVjF9kr5kKUqc2RQlkn2m+n01r+PcXmaIFcX1ic+uHxQSgdteFAjPi4HRTyjUNnZZgq/s9Pd6/4/gkN1HiPIivZbGycWpETRcnnbp6jvpUUmBKta9B36/xxKk0XDf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnBWS+/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109F7C4CEFA;
	Sat,  4 Oct 2025 02:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759545691;
	bh=qWUijZ4ZIxPdadWhj/2cc9CErbNcnOPtwUfHLX7HEvQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hnBWS+/6B7+nnrJXWujQFxxKvSwgedTWJc/cyyXHy5o9+toNt9M/uGVbg4ljKuCAx
	 MCVID51ZrUaXgaIUkT/PqhMjRXfuxp7ZpxHFaEMutfntXH/ntshZzRVZyR4Gag+cfo
	 kEwxs3zzXbXJz4LdKjyatvhHvZ0xmREMsLS8Dkb6jtlHbhgt04OgRJP0q4Ms2pG+Ao
	 Nrk8HBdVtuoUvwRXrj/cA/iy3bOufN+cKhF7Vi8qyWk/R8saVX52hWcOxxHkarFrTp
	 BYlbwgMQ6ZFFXSrTE/obJwvJvLcovO94s6w0ZlWcVe4fG158Uf9BLyERnw2vf1b/Ps
	 oGn2fVLvQBCPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 68EF839D0CA0;
	Sat,  4 Oct 2025 02:41:23 +0000 (UTC)
Subject: Re: [GIT PULL] soc: build fix for 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <417683c6-434e-4ae3-b361-cdf25e01d943@app.fastmail.com>
References: <417683c6-434e-4ae3-b361-cdf25e01d943@app.fastmail.com>
X-PR-Tracked-List-Id: <soc.lists.linux.dev>
X-PR-Tracked-Message-Id: <417683c6-434e-4ae3-b361-cdf25e01d943@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.18
X-PR-Tracked-Commit-Id: 91f98de42310c70f9a23595b3b20aa305717d955
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d955299b5c468f805d75e0b92e7c1d2392bae921
Message-Id: <175954568204.163446.14020714311512770156.pr-tracker-bot@kernel.org>
Date: Sat, 04 Oct 2025 02:41:22 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, soc@lists.linux.dev, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 03 Oct 2025 00:43:59 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d955299b5c468f805d75e0b92e7c1d2392bae921

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

