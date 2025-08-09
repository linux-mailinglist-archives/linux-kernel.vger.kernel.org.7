Return-Path: <linux-kernel+bounces-760967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAD3B1F254
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E198586FC1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A0B279DAE;
	Sat,  9 Aug 2025 05:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQv03v33"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46A32798F3;
	Sat,  9 Aug 2025 05:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754716784; cv=none; b=dNhA6SZamysr/GmrPDVP4SRIp22EYNKaTLg2Zthx5wCkqik/n6mWSEOfIxiWbacc0K1bUPAAWpo98/ELMuTUL6tZYpQp4/qXt8dBkrPvH/oOWtmlJUEESYgl4CeW9D7g7YR1DqckbdYAMUWyScT7qEv1Z5UefTd7HiwK62vyd3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754716784; c=relaxed/simple;
	bh=VzBAsWRSTwzfFy/+Yxei2w8AhNorArP7LLskldpKag4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ruchP+wWRczlERRuagqm6CBJrKyJS7tVsfCH55pEjdkfBgz6/X94J6+BS2DOetG89qrKkbaF1N/28gi60pFAYFsR7SwOc70u2Zw6Wrzq3+wqr2HYUQYDGx2llvNYbfj/oHbLAb2sE/Fkfa1gN646mnU5PA6yEnA+yJTWHqfYvzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQv03v33; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9076BC4CEE7;
	Sat,  9 Aug 2025 05:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754716784;
	bh=VzBAsWRSTwzfFy/+Yxei2w8AhNorArP7LLskldpKag4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EQv03v33auK3vNP7LDYN5Wf5x5jSa/iC1gEcKYg2gfgP8BR0dHVioKaojOmP3TJMO
	 PHou7xuMBb7aDSBuAuN2oJ020jYaJmGwhotLm5L6TfjLf7CUcMCdO2xdTTbxFeyGwt
	 rPv/48wLd67DyNoq+WbH4h6mykNqZ1PJoeTcJLlu74nOCLDty9usRJuArW0d9mIO/0
	 LvkR+fhy56JZUu4gnVkYCmyntXXwK+ZEA2805EQm9pY06v5UY/APUYcAttCjiciD8K
	 9I5Y4JupEV/LuwmkaFVi7FETKcztFCMW0tvFX0Yxy9jayDZIS5XBvDC4ALdAMvA4Ph
	 i6Ynwv8CbLi7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACE8383BF5A;
	Sat,  9 Aug 2025 05:19:58 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <87cy96yu42.wl-tiwai@suse.de>
References: <87cy96yu42.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87cy96yu42.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.17-rc1
X-PR-Tracked-Commit-Id: e8e4f3c242cc26de9d69bd8b3a678d1e50980abe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c93913c70809898aa5e450e4aad0b99750d9f082
Message-Id: <175471679757.380510.7603276198610793432.pr-tracker-bot@kernel.org>
Date: Sat, 09 Aug 2025 05:19:57 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 08 Aug 2025 12:40:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c93913c70809898aa5e450e4aad0b99750d9f082

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

