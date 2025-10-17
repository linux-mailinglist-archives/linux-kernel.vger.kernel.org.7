Return-Path: <linux-kernel+bounces-858308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F715BEA72F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8322A740D6C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A571832E144;
	Fri, 17 Oct 2025 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VP8YC721"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F9032E13E;
	Fri, 17 Oct 2025 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715076; cv=none; b=I36Y1W6xSZGrrGRwzzoKYjTf7+G7bmvOQEAUiIBh3BFjh9Bsch9H0PM7f0bawJLePX64ynFHYCxWtyi38lQJ7AoJMUjq1ffZTu8gqGXL9Dz+TpiPKGdiz8HgTZbR8vCBmfoToNlf7shE7pFatCDcSSzvDoq6Jf/9X75gqN/6ezk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715076; c=relaxed/simple;
	bh=LTkDNHaQ/jmxgU5fMe/ssd+JUgAQiQs37x3P5Ma5Tk0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ILl7BMvkzkKElCGyiHpCLJ28KgsOTo88MoSx3HtENvJOMl/to6m1OD92XNAIXVrxbzUyUmjnky/vXZW28q1PZhVFjGni3407/Qac4d4TteeJODIpoU3xj1leVhP0XMdFjvg7471MWDqVd905iD5Is6ITQ9m3cK/lv634qf8bUjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VP8YC721; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F175C113D0;
	Fri, 17 Oct 2025 15:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760715075;
	bh=LTkDNHaQ/jmxgU5fMe/ssd+JUgAQiQs37x3P5Ma5Tk0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VP8YC721CkGCGCtWvU2GJThiwfdNUM8+YnZcPVC0+1jQFQVPr4Hbc+vhTQK3FQKYF
	 +K7Kmib2YyfrgX1T9zzpnu95g24Uhi2XGJb8rPZJiXYtEg4+DjXvL6c2jP7pn4B7L8
	 Fb7/3+5Lu3qcV+kEhX9Ad5oZp43Mlz9eh+nAyTt10pjEVHpQzSbgzoPHILVh2kPtjJ
	 mo9aLP0ptL9Vmb3JBRoJNzPBoTQxHiTD9rCa9068gGohDh1wYBtQE52Pxdou+M1lEi
	 YZGmYCsvoBbGjMb95NRTaB3DSPooGVtunmxjoQsDYK2bsS2R2cxJGtgQ1j3tSfQuFx
	 80/KfuXbUqjfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 728B439EF97A;
	Fri, 17 Oct 2025 15:31:00 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.18-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <87a51p60fz.wl-tiwai@suse.de>
References: <87a51p60fz.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87a51p60fz.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.18-rc2
X-PR-Tracked-Commit-Id: 2a786348004b34c5f61235d51c40c1c718b1f8f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1422424187a548c24825645410fb7f691c2df47f
Message-Id: <176071505898.2669052.2302185451530632194.pr-tracker-bot@kernel.org>
Date: Fri, 17 Oct 2025 15:30:58 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 Oct 2025 16:57:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.18-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1422424187a548c24825645410fb7f691c2df47f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

