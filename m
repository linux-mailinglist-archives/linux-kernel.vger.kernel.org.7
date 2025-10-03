Return-Path: <linux-kernel+bounces-841777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C04BB835C
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 23:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52DB33C7B97
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 21:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB702765CF;
	Fri,  3 Oct 2025 21:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEjA+uub"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8879B2749E0
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 21:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759527199; cv=none; b=TcOKt+uA3JnyXQSlyhTW2C9bhfQ6rTvWBFklwxgurBKCJSLbSXgxnW2iQejjwdDNlNk4AqfwyjMUPyrmlst05XpxqcJP0+TYzsX67RORvO0dCC2p6EtMuPQo2HjHB2t1bTpqU5iiPVeM6LppXZwkt+WwsHU3fy1aCO5mKDUNJco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759527199; c=relaxed/simple;
	bh=xzump1bCCpRUVCzjRNjr/64g7PZlRY2B/W6KaZ69M28=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NWo19duJyTD+x2CoitqJ2guBRttSG2tmPaHFZqX6P2rLzY/wGL0zayLnsxKRCMfB1iYhXNtU3ISJtMDNscsLuILX5zSB/Xi2DuDCkwSnaScomOnK2EcKXmq3rdbceYRdIyQvM19ueCkHHA22dymUSw2v9ZohBC8WyeYwW5QJwDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEjA+uub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2A9C4CEF5;
	Fri,  3 Oct 2025 21:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759527199;
	bh=xzump1bCCpRUVCzjRNjr/64g7PZlRY2B/W6KaZ69M28=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NEjA+uubk0TrqgiYfcq40Kcrr3Sm/KX7eCis9iZCBkROkP2501YK3SMoggjRBMD+3
	 regXC4vsqd6yKFvVwPaat60UAEsEEnCcSd1aJvmMckeoJwOAHQRgxzpa3ZxDTM8DwS
	 x3RWr6wvXsyXkO5onbisqw3hg6I2waUdVQZk2c44/pj/U2pVAtgPVhBostN/NEtZ6M
	 +tBe780NoeWJrovFrDa/X1ZAxavjMqu9OUXDrNruzn3dXkceKLADLONZf0VaMOhlCM
	 Xrhb0dvGm18CNQOnirPtyJA4ITtryFk7r4MijeFSAXmmX6GD+jmLWPlwBUg0cx8e4c
	 Ti5alZndnyFig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB05239D0C1A;
	Fri,  3 Oct 2025 21:33:11 +0000 (UTC)
Subject: Re: [GIT PULL] exfat update for 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAKYAXd8XfKPTdDMbHKkyQN1FTGLmgKkMTkUiSOuHE=FjB=G==w@mail.gmail.com>
References: <CAKYAXd8XfKPTdDMbHKkyQN1FTGLmgKkMTkUiSOuHE=FjB=G==w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAKYAXd8XfKPTdDMbHKkyQN1FTGLmgKkMTkUiSOuHE=FjB=G==w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-6.18-rc1
X-PR-Tracked-Commit-Id: d01579d590f72d2d91405b708e96f6169f24775a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f0712c203862b00139b34fcbb1710b479af2b101
Message-Id: <175952719052.86168.10673304499751908856.pr-tracker-bot@kernel.org>
Date: Fri, 03 Oct 2025 21:33:10 +0000
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sungjong Seo <sj1557.seo@samsung.com>, "Yuezhang.Mo" <Yuezhang.Mo@sony.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 3 Oct 2025 21:18:04 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f0712c203862b00139b34fcbb1710b479af2b101

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

