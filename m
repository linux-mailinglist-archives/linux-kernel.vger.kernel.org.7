Return-Path: <linux-kernel+bounces-744705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EB8B11003
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F2893B59A8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85862EB5DA;
	Thu, 24 Jul 2025 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYTB0RmW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6901E9B22;
	Thu, 24 Jul 2025 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753376198; cv=none; b=U8h3kIlj5Ms0oJs7uf/x0u4CPZn9WzOzktlDhNNSYpP7NpoHytSIe4t4EtVcT7NH5IJBGDS8NYuNovQgL/SrSur7Xy0ACFDjRUlKsr9FnDhRWtZirBoR/HTWvJDzocr2fDujBK4nYrM5G/xQqMT8nd5npirPUlZj3MHo+4EYmNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753376198; c=relaxed/simple;
	bh=uLW5S92XBiNDpIN90dBetMK3CHeFkycvRdbjeYTfcc4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=H03vEL3KRIwUUjW1CtPN5r/+jqrEdcDExEhu582B7TCJcl+1aAVfxSpuYB3HN7j0E4IUsSaN4PjK7pjeQxoTitHnZz/2Zqnkflc4cAhNzKpT70yzHkuLn+hW+ZU3RwF+Y0YAKxXbGq9CST009RjRk5IsjY56AMik1yS570BL8Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYTB0RmW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCB3C4CEF6;
	Thu, 24 Jul 2025 16:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753376197;
	bh=uLW5S92XBiNDpIN90dBetMK3CHeFkycvRdbjeYTfcc4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AYTB0RmW04oFFsWg5vXYqvtPPIwfrJKS4i4X/OIA28FPmSOgJffiOBB6Lr+y7RSM4
	 KD9D6P1gR5a6eg7xaHE5tK13kS+ts7qoYwhn27OT4ixe/6clQu0dY1kwc8wVDRXmj9
	 tYJnXVjk6/kts0mDlKUZu1AlGNIJEslE5fteU1r7oLZ+o4DP2ZgQQ1AyIYF7ixHSvf
	 eg4EGX7A00bNVyvvGqrQGEdqqiBl/lTf63b17HlgaCpFBos9N/sSYLtcLe7susKqR/
	 /SvMAGWlU3OO7HY05jic4zhtUyZMkO5MYgKw4s9KiF7IuX/Dyd3HgSEUWWmCdBqWVB
	 OqzlR/yBkGePg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 12161383BF4E;
	Thu, 24 Jul 2025 16:56:57 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <87seilkb2s.wl-tiwai@suse.de>
References: <87seilkb2s.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87seilkb2s.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.16
X-PR-Tracked-Commit-Id: 0d57ed922b9a9b0d36c90a992e076d850b779be5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd9c17322a6cc56d57b5d2b0b84393ab76a55c80
Message-Id: <175337621581.2464257.17053832898786487892.pr-tracker-bot@kernel.org>
Date: Thu, 24 Jul 2025 16:56:55 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 24 Jul 2025 14:49:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd9c17322a6cc56d57b5d2b0b84393ab76a55c80

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

