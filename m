Return-Path: <linux-kernel+bounces-824847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1F4B8A49B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F691CC0E14
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13EB31986C;
	Fri, 19 Sep 2025 15:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jg9xuOM2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECBF319615;
	Fri, 19 Sep 2025 15:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758295782; cv=none; b=fe0eQ+BM7FO8OwAr+ZBX0viFdchJr5n0IhnpA7dB67PvpuXLp4flUu0FA5ac5S0XjXkLxx5B3t4Y30fdgaGHCt+2RsIbvKSwfzM/d90IvD4JAP2Bx0y2/RB4TKVwGif5UP80aLba522sZMuIzRGly1CuyLNuNXT+/9j8fsluiz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758295782; c=relaxed/simple;
	bh=If45rPLFvnQ5Sqsi+l9yBDupxwaU5qoL7ee6jzs7dNc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZDfaa54gHlo+uyKj6Q9FxSlALysk3Vx0ORXAViurc+UYpBVNoesb5A0Zrn1x3NmqPfsBJ4D/S7+O8Pn8yhOOXj3I0zzKldBxmG+U+fzXpPncPePVZ1SxkxIZ3JxWAdV5DCMck5kxvMi2kkkNAAAK9COaXdpGbp5E5Wg3tcSLaz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jg9xuOM2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02532C4CEF1;
	Fri, 19 Sep 2025 15:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758295782;
	bh=If45rPLFvnQ5Sqsi+l9yBDupxwaU5qoL7ee6jzs7dNc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Jg9xuOM2tWD6HFV9HmJZMOT2wiN44jgyxXLIC/b8q7b6VK6gqWAjr4aEzUPn9vdXS
	 pzuVqHtRv+i9rWnJo8J+plxdo5Xb+teYYfYN1G6RWq4p43VFoGw+wUg3GaflCYd3mz
	 tHcaQfOf333FqNV7I8nDDcM3YCqEJzLaq0RmKy03fHANO9mrw8pyRtyWI+nPi2nWSj
	 0CBx+k+7ODoZFyRf2oSODvkIMD5AX5CeRvAjIciqZA17WH6ZeftSBA7GGq/DuaVG6T
	 B0co9u3pXrblZfP+QdyAAx4g76xG31mVopVfvLNrc7fsI2Uk/gXA3MLeEq4I+OmKF1
	 /qg0D2GjXfI8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE4E39D0C20;
	Fri, 19 Sep 2025 15:29:42 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.17-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <878qiaalnr.wl-tiwai@suse.de>
References: <878qiaalnr.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <878qiaalnr.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.17-rc7
X-PR-Tracked-Commit-Id: d33c3471047fc54966621d19329e6a23ebc8ec50
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8442d5b7bc6338d553040f5b1f7bd43f5ab30e0
Message-Id: <175829578138.3599397.5309836248178532898.pr-tracker-bot@kernel.org>
Date: Fri, 19 Sep 2025 15:29:41 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Sep 2025 10:31:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.17-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8442d5b7bc6338d553040f5b1f7bd43f5ab30e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

