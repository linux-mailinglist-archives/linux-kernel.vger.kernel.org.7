Return-Path: <linux-kernel+bounces-842130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F3EBB90E7
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 20:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3AD7189FD90
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 18:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094DF28507B;
	Sat,  4 Oct 2025 18:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqXMIF9S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FB83D3B3
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759602011; cv=none; b=rJQj1EQbNTaurg+k75E58Ts7aCRwCooaoTl/IzoqGBIJcUTSWPBKzhCC3fjJwVWy0sC37mKdgbtfn7ZcLWFm23yYXCXEly6JuzyUnMTSku+H22WIq597o0C+yADKN2Q6RHccMKwvJTM4i6JGIUCV3G5s89uGBtS0ais5GRE2QFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759602011; c=relaxed/simple;
	bh=LWyOYfxw3MwQ9nGvrV02gHWS8s0vVhG1UTs23PxZ990=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IwxbRtKWW61KLWXQf/WglER/4DnX0Epd/8M8Vqe4rqJNlRQY8Spqx1LSVAXEz5RT1cr8dJyf/2BKe6bs2JXD5ibU77eZDGR/z8BAjjlthvq8faOjxRsJP5fkJCAsBr6vtOWUJ1RV0HbpLvKKlpka9rV/1+VQULUCPJx1+FUXMi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqXMIF9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE35C4CEF1;
	Sat,  4 Oct 2025 18:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759602011;
	bh=LWyOYfxw3MwQ9nGvrV02gHWS8s0vVhG1UTs23PxZ990=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VqXMIF9SnMgW/wj3N4Pl/8shePA2hCDrJLnnkUOkVsOcw9nLfesQd0w5eZScA+z69
	 /wQ+E3aNwjlsjXUjNmNOg6OtgscAGY9t+xEnXHsth6DrMKtRpF3Vzi/83myA69Bfk/
	 ReZ1x1wIsT+pAoxOwkJWrMn1CDjA1pDz3o+mavg1gvmhT94Z9ELq+FrnESUT7is2D7
	 EdB04M2ZiN84/JY9R1srbUthYXnvNQXrEABsUNL97HVJTkkipWdEgek25PcKo5rok6
	 XtpycsvtxICl0c+UU4r/l+4o7I4EyMac2ZtnglpsrR1YS1aJPFsbikEWNs56i9C91f
	 CzM/8SFvTUUHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC69D39D0C1A;
	Sat,  4 Oct 2025 18:20:02 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V updates for the v6.18 merge window (part two)
From: pr-tracker-bot@kernel.org
In-Reply-To: <9a4eb234-b19c-8051-472b-4bd793a9e252@kernel.org>
References: <9a4eb234-b19c-8051-472b-4bd793a9e252@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <9a4eb234-b19c-8051-472b-4bd793a9e252@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux tags/riscv-for-linus-6.18-mw2
X-PR-Tracked-Commit-Id: 68247d45c045bb7dda923cf2c8d0937ce0e16394
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 86bcf7be1e26f2d7277df90857d93ce0ebc11370
Message-Id: <175960200167.404121.1670961737666843192.pr-tracker-bot@kernel.org>
Date: Sat, 04 Oct 2025 18:20:01 +0000
To: Paul Walmsley <pjw@kernel.org>
Cc: torvalds@linux-foundation.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 3 Oct 2025 01:19:20 -0600 (MDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux tags/riscv-for-linus-6.18-mw2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/86bcf7be1e26f2d7277df90857d93ce0ebc11370

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

