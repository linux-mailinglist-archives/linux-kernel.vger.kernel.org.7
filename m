Return-Path: <linux-kernel+bounces-881471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A493C2844F
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 18:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02D1C1A20BF6
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 17:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB6F286D7D;
	Sat,  1 Nov 2025 17:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yj/SHFeM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9364E27B354
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 17:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762019593; cv=none; b=K9TZ02MXw8LKzcrTTweRuNdPAxk+GtigURloTmIHO3CbORkjGJff7Tnn8fXxMWIxuC2orWTziOAeUeiY2+9pV3Vhn0EC5gPEPjVaSOsTC3uiTit6GLD3JoBFipFTQ3O/mJqxGBFgTrMZUDXieT2za1OSdjc28fLh6rCzDmlC2s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762019593; c=relaxed/simple;
	bh=NZClzHyiv3XiAjBkmrrcXrrVJ5t5IFQjQhKOHTGgltg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aOwsMXRRijq0x7zGXznuLuakCus9p+5EywjbsPdN/4ruG1bYvBHjiIsGTRlXvoPj35LURum3UIWVRWogiy2gR89IpDs5MOv4PBziib+JP2Gbl4ZxA+Y5Pte+bY/hGNcGXGJXEEenYRaGjUst0CXtuIy5RD9MJOFx09ObDgwe/tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yj/SHFeM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A48C4CEFB;
	Sat,  1 Nov 2025 17:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762019593;
	bh=NZClzHyiv3XiAjBkmrrcXrrVJ5t5IFQjQhKOHTGgltg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Yj/SHFeMX2pjXFMJ/uMa6nzkDbWLmiC49GtUI20tQA1C5IUp08cAfjstKjzVicyST
	 ZFuUnDiAPMrl58mwCjwzYjve62D2dJx/tFjnuOVWGkp6qUDkpSKChYrWCBXYCkVqT7
	 +uVXsn52df8s9pq0X8T95d7VY9qeW1G/bfH8j4a37y4fsafGrDYmn5/m7nTyrmOufO
	 zF86KXd/ZjcWGzH/j5rJaghogQ0XjID7ugGdJGn2ubLJxl7jVBVJsd9Klp+SWJQluC
	 Sv2fGF08HfBv8jEftDN7iW+/rjGX4fbAlp9zO6IQBEtMEWBBLGsucuZ/Lmv6UFoVJ7
	 TEbRCjc5aIjow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B083809A1B;
	Sat,  1 Nov 2025 17:52:50 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.18-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <3a91deb5123e4918a27d974dc0085011@kernel.org>
References: <3a91deb5123e4918a27d974dc0085011@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <3a91deb5123e4918a27d974dc0085011@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.18-rc3
X-PR-Tracked-Commit-Id: 47a0925ee4bd2689f0aef4dbd67dd46442fe1ca2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bfeeb4a1bdf5d255ea885f16be80968d1f31281b
Message-Id: <176201956880.853286.3089841961926755052.pr-tracker-bot@kernel.org>
Date: Sat, 01 Nov 2025 17:52:48 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 01 Nov 2025 12:29:53 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.18-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bfeeb4a1bdf5d255ea885f16be80968d1f31281b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

