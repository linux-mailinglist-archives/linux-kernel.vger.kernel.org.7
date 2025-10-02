Return-Path: <linux-kernel+bounces-840715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7B7BB5101
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 22:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1D9A4E41EE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 20:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4FE2550A3;
	Thu,  2 Oct 2025 20:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1nROgw5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2292155A4E;
	Thu,  2 Oct 2025 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759435230; cv=none; b=f8OS4Q3lZg9xs2d4dL293Zxpz7WvO0m4RkOJQXia+mRiOFxpiFSxbKFlR2uFotaPxjyeRaYcRO2aFYDb8zezY+0wp7GDeCtjPGpi8WNDzi50ISZw/pCCedO86JIEfgPGQjOkWomjq40/IxM9qkmB9n9zA/kzZkAWrYyAxV8J/DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759435230; c=relaxed/simple;
	bh=Ri1nL1GEuYsN9wyatnejvyCsDDm4PlEhnqhuiPuuR3Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Lyo1OcirRjaclQ1BNIYWe16iIdUxu/7woMepWKqSwCh/PUBOZXgph9veLhwmKaeqCWy58uRxbk5CiSSKhKaHLrxTiSHqPWyxxR4kuPF/pr372rcXIKxjSuwBnu/i7ZS6mTLGNOrI3PzRmJAbRWeb/XGBLDQvqf5XgP9hmNSQ7Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1nROgw5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F21DC4CEF5;
	Thu,  2 Oct 2025 20:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759435230;
	bh=Ri1nL1GEuYsN9wyatnejvyCsDDm4PlEhnqhuiPuuR3Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=T1nROgw56c2pbgMrV+me4n7EMLi2PeD0QX9o5sm09gXutR24SawZmdIt9RwgXUfyU
	 ajjQp3nK+9ZlqNO6Gfx89MVLBHPKPZQZxBZsUEjBx3XnG5CFsnWQ/We3V32Vcz0sr8
	 pqMfEJ7gF6zPbHrtDvHc1oT1Tj4v80qMmqOKe/YBMxnA8dLPzDlc+KV2g2TqX2go2s
	 ZjlC41Htf7WLVBzY7Kq0lW3iS7cNIMSkMClrNDWd6wuvKNoNVHBpx0dEEdb2HVj5MK
	 cfaC4jVMIuEngCIWjGUBEUWT1dcKKdSbjfY7gF3lbSEFkmqvIfq7DsC4GzkpWQD0RF
	 RR9vPa6RAqUgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1AA39D0C1B;
	Thu,  2 Oct 2025 20:00:23 +0000 (UTC)
Subject: Re: [GIT PULL] sound updates for 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <874iskktxs.wl-tiwai@suse.de>
References: <874iskktxs.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <874iskktxs.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.18-rc1
X-PR-Tracked-Commit-Id: f65dc3b1ab145c9b8b36301256d703c1dd153f71
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 05a54fa773284d1a7923cdfdd8f0c8dabb98bd26
Message-Id: <175943522230.3413181.248560542601875644.pr-tracker-bot@kernel.org>
Date: Thu, 02 Oct 2025 20:00:22 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 30 Sep 2025 14:26:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/05a54fa773284d1a7923cdfdd8f0c8dabb98bd26

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

