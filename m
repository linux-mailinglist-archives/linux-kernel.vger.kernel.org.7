Return-Path: <linux-kernel+bounces-837018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB506BAB19B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB6817E180
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5325981724;
	Tue, 30 Sep 2025 02:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOG3b+o8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9903C1F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759200866; cv=none; b=m+16zA6iGf9D95D8hBlLRQVNsTQjb+uzujLZA8KS6u+Uqa55bRxrj0ZUEUhxpzWHppvcO+fvwCJnpJ6FrJfH5fL3tdtqMBRn1YgiA0ve98pLFCB2G1fGnwIIo2Ne36RKpcqZKa4bYIH8iArCYBRyq/CHpuMOV6Z8oLv0jTX312Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759200866; c=relaxed/simple;
	bh=je3gIsAsl9yWB2e7Ll3nCfkjmu8FWFLvgLuURNmUVzU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=l6c1BMGbNoZYo7tPLZBZtuWaK/qbIrZYwuB3BSpX/zHIzRTtahV44kMvVMdoTfBHLMku8F0Mf2k55hiSvxyblN6vh/lOefMagxYNWFeExS+DSzC6wfimrvR09/ow8k5ymQUWfhU69AI1CgqPVwzQSSo3tPS0C6kwaSIaHE4FTCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOG3b+o8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3C1C4CEF4;
	Tue, 30 Sep 2025 02:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759200866;
	bh=je3gIsAsl9yWB2e7Ll3nCfkjmu8FWFLvgLuURNmUVzU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KOG3b+o8oREVCaX33RNp7PegVdjypRS3e4B4AArfLRXcy6kjpa/Kzubvs5rPUSZ/q
	 oRlTtAidDOmA7SD/hxnjKu8P417VOpDBwyHmtc+r5M4ElcrrUTZ/PVpegF2OudYwJJ
	 bl3Bd0fMGO09NB0zxeBymu9O6FujBDYqHF343sjwWNEZJW8wy/g3u7kMKsApyDbLEz
	 bE1hLZwsSmE+f4+DC38duVER/4AB8KxCpq3WjlcQyLHZa7khBFI4ixgFt82bmXqtXJ
	 2N0Vw2AH1lUysfwr1rm1QFCJ3qcsuucSHyVPxA9JAAaT0vs96qZw4t5j6nQ8sCSHNB
	 e9UV/ClnBgEow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FEB39D0C1A;
	Tue, 30 Sep 2025 02:54:21 +0000 (UTC)
Subject: Re: [GIT PULL] m68k updates for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250929091005.2829122-1-geert@linux-m68k.org>
References: <20250929091005.2829122-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-m68k.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250929091005.2829122-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.18-tag1
X-PR-Tracked-Commit-Id: 695f2c0c25f3c844f9dd177d20c1e8afc55df1ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f1004b2f19d7e9add9d707f64d9fcbc50f67921b
Message-Id: <175920085973.1805104.16407289749945630957.pr-tracker-bot@kernel.org>
Date: Tue, 30 Sep 2025 02:54:19 +0000
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Ungerer <gerg@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 11:10:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.18-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f1004b2f19d7e9add9d707f64d9fcbc50f67921b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

