Return-Path: <linux-kernel+bounces-839714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA40FBB2392
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 03:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3F7018828F8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 01:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3550413A3ED;
	Thu,  2 Oct 2025 01:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cI8RDaRN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9095713635C;
	Thu,  2 Oct 2025 01:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759367435; cv=none; b=fqV69sg22DAI0nlEs+JzKwkOH55QL0YfiNApwpx43shz+1AqgPVZ+AZVcCy5WqcA3WIcA36KCLB0Hyn+jwj+jUYmhiMhemedifswA8Dm3Fr2Sucl3jNlc0B2r86o8Crxq/cyu+laVgSxVpMcdFyb5SdcAOU+5q4dsyAJGIF7VsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759367435; c=relaxed/simple;
	bh=+x0fvBVIGPNSDIdjP3Feex7LOIFLT537dE2aAMtpkrA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ThVjjDa5iy6RxQdzT7/01SgGyAVQpHtF78zoGt8e01mnIPWxscwWFCIACQkQC5t1DNaTP6HthdsPhrIdTyrp2IeeBzPQipXTEHmCKvkb3JxdpQf8gD6s3uk+Kw3n+uA6KE4/mzh/zolCO2GIRVPUi3NRMggjLxcAQeQ+RO1RKMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cI8RDaRN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7428CC4CEFD;
	Thu,  2 Oct 2025 01:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759367435;
	bh=+x0fvBVIGPNSDIdjP3Feex7LOIFLT537dE2aAMtpkrA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cI8RDaRNaIMX/Ez0cD1Q9J6J+uTieduswBztm2bWcnHoWI4JqzdeaWtioD8ou1Fpa
	 zBlr+RKHHI5iXhs93pJe9ZjU0w1+ox7YBwiUoCEiH6AQ7Hqi/Hf/JqU3QKEELdkmiS
	 wZvk1oDPkeo2zomtWg3hwNTkSduXo8S4GCnpygVbupHfdpjX3wirPeqaimDvH5kgq2
	 w6IoEKsaVNf229zDYokX7mxLFIUJ8HOA08wzBrOU4dOqvcluP7bgw6+t2hugPKbosw
	 0SdM0w7dpk95iGUhu5szaEVF8cMTTvpdjCO4piTHKYPdV8S/QF+SJ+/4kMqmj2IuOb
	 tljsj4DP3Aslg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0D43439EF947;
	Thu,  2 Oct 2025 01:10:29 +0000 (UTC)
Subject: Re: [GIT PULL 4/5] soc: driver updates for 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <b94bf376-2653-4726-bc51-9c608f55fff4@app.fastmail.com>
References: <54b49f7b-9232-44d7-9ae3-ecc1826f17d7@app.fastmail.com> <b94bf376-2653-4726-bc51-9c608f55fff4@app.fastmail.com>
X-PR-Tracked-List-Id: <soc.lists.linux.dev>
X-PR-Tracked-Message-Id: <b94bf376-2653-4726-bc51-9c608f55fff4@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-drivers-6.18
X-PR-Tracked-Commit-Id: c4ebd661282df563a0c83acacbc35cfd4d8da541
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 38057e323657695ec8f814aff0cdd1c7e00d3e9b
Message-Id: <175936742769.2689671.1927573859561448403.pr-tracker-bot@kernel.org>
Date: Thu, 02 Oct 2025 01:10:27 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, soc@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 02 Oct 2025 00:27:57 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-drivers-6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/38057e323657695ec8f814aff0cdd1c7e00d3e9b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

