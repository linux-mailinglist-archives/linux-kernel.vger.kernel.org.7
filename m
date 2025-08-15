Return-Path: <linux-kernel+bounces-770023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CACB27601
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22D5FAC13FE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11C52D0C76;
	Fri, 15 Aug 2025 02:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdXRviDB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC802BD59B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 02:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225013; cv=none; b=NvqSnBF9u75K1C0ZqiOVkAi2CYHwuaXPwz0TfFCdLoBvNnG44b285eFfoi5wx9pUNf7X6pC4o04TZBp3q2wYr58XX05psb/NY8sBtDeRupYfJmu1IZuFYMUcVSc0hXuLA68VFsJhzVGEfYgfiK1EoXuTyOC6Es9pTErCzBKYJbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225013; c=relaxed/simple;
	bh=9u+/ZHnCUBmQVlDfnLK7/sO3WW4JAJ3tVoZ9sRspGrQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kZTqgsZy+HMahmwQ/Lgbr9BDn8CAMmNOG5shcL3Bz/8DFluBMmF4L5mLvgpts1i1ExXb2ND1UCG2WdngJnCsEXaHxWZ/Qk2+dB9OoZCGvhoe1Csu4i6S0qVHikk27dMML5+caSdwzjprcNp5XOwdZgEYtOCudagSf/has2guENM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdXRviDB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FFAC4CEF1;
	Fri, 15 Aug 2025 02:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755225013;
	bh=9u+/ZHnCUBmQVlDfnLK7/sO3WW4JAJ3tVoZ9sRspGrQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bdXRviDBMEPwZZee7fpxsxioem3Nb3EITy+hBtVhxpC/qZ0gjpJseryTF2xg8E/6T
	 lJ+hiGv4/kGU22TCOyRtT3AOAP0veEfsaXNMhB+VsnVwd2WTwqOySs7w/OrGft8Kho
	 O778fXep30W/sRcGFA3NhNBGDcxcCcDyd0ZaZVmkC3UjId/eyA7HeJDCOFx/a9Rvie
	 NWo/8VZjNsfBJFEgY/k71SsMoK+3w56PBg2amdzuuaQk/i8cCKgsqApDAJLK5SUeja
	 CtrJ/2CPiabjVxCz1tih2670REdNKtOATGDW2FvhoKHWpO3W495bU4IuEqjghEE8Od
	 6O3dQRiTQ/TaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5C68339D0C3C;
	Fri, 15 Aug 2025 02:30:25 +0000 (UTC)
Subject: Re: [GIT PULL] firewire fixes for v6.17-rc1 kernel
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250815020521.GA349651@workstation.local>
References: <20250815020521.GA349651@workstation.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250815020521.GA349651@workstation.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.17-rc1
X-PR-Tracked-Commit-Id: 0342273e14c25971f2916de2b598db2e9cfeec15
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d7ee5bdce7892643409dea7266c34977e651b479
Message-Id: <175522502416.525585.2808615866304715071.pr-tracker-bot@kernel.org>
Date: Fri, 15 Aug 2025 02:30:24 +0000
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net, edmund.raile@protonmail.com, apais@linux.microsoft.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Aug 2025 11:05:21 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d7ee5bdce7892643409dea7266c34977e651b479

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

