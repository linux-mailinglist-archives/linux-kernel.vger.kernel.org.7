Return-Path: <linux-kernel+bounces-891616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E2AC4316F
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 18:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9CFC74F25CA
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 17:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362AE261594;
	Sat,  8 Nov 2025 17:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhmyOmJA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0F225BEF1
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762622152; cv=none; b=HKl2kUiIarn3puf/afvZdvewQtaBdLjD1pBDzY2iHjwPQy5Gn7gTg158t+yHiTTS5EFCIC4E002lOE110QZBmJV7YCwZNNqsRpTu6ilxeT/w0a4fr16J0I5GA/UCcfQQye5zd2JfusmMn1prd9hlsy2QAgmraGl7DcyGBz74NCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762622152; c=relaxed/simple;
	bh=OJbVbnfTz71mzCmbLsa5lOYobOgPGPdKsT1326BWtYo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dYcvSPRioN0korAAieAzSbyQ+5Scjbvuqn+uPtJO8l9ZO95TLVhtyLGDhlJZmspvlTPAmRfYlFrPVy9zXkhL1jmM2QdXwFlWmI34NnKyq0NO2tTEXtFToTOFyzf7PoXwi3nH8S8QxCExJEdt5a2mABOjLvNG8pU5r8YfGMx45aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhmyOmJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663F9C113D0;
	Sat,  8 Nov 2025 17:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762622152;
	bh=OJbVbnfTz71mzCmbLsa5lOYobOgPGPdKsT1326BWtYo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MhmyOmJAKf3Jjj7vgSg04kviwu/F7h3KpE5MwpnkwXmd1zkxl/FC4tvHNT8UfC/2Y
	 TJqNKIQuRKKIXBknxAcx6OuaWf5RmB0bF007CssDzxcxKKSmo/3Qy6lXlSd1zsO0QT
	 Ar/pbp35FGm3QMjgp0L+gp+b81iql3crg+1gKiRNFh2Q7BHGe09mwOalWE1C5PWIVr
	 UNrtu6MO2GS22wFXqSu6ARxHx1sEpDFWIsq3GPcJAejb/JOtjKo/Yjne/gVgqf+o9w
	 f2clWoNAqWjpQcRlzrdJ5kycy5f/OUMW/2il6B5couWqRxp4LlhG4xd/wdPNdv4nII
	 OZObbzVFs/cLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C143A40FD5;
	Sat,  8 Nov 2025 17:15:25 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <aQ9DblCt0YOn09Bd@gmail.com>
References: <aQ9DblCt0YOn09Bd@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aQ9DblCt0YOn09Bd@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2025-11-08
X-PR-Tracked-Commit-Id: d23550efc6800841b4d1639784afaebdea946ae0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0d7bee10beeb59b1133bf5a4749b17a4ef3bbb01
Message-Id: <176262212408.1365123.8527797081191854168.pr-tracker-bot@kernel.org>
Date: Sat, 08 Nov 2025 17:15:24 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 8 Nov 2025 14:19:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2025-11-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0d7bee10beeb59b1133bf5a4749b17a4ef3bbb01

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

