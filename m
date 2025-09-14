Return-Path: <linux-kernel+bounces-815716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0CBB56A4B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 17:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18967189B4C1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F7F2DCBF4;
	Sun, 14 Sep 2025 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9fKdPU/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1D42DC346
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757864599; cv=none; b=qwyyoF5kZfkZfrMAAEM+yOldO+ruf944JiGGSr2w7hnIgiVb/o6zOfIQRCqCcBEJc2yT0E1HOP2qbc0HMSxfroJGl2CmcLCEzT9Gtk/lwIQEOhGTAuP12vDkRVfBoNOSxs+F9xBCJOof7bXOvCH2A2pOWJrvVT0mD+4/rcWJyak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757864599; c=relaxed/simple;
	bh=cWDlbvOR8jjLVrZF7BbrRnSA0nL45gpNjaxVHVBvSQM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Dyhn7jlJH7YiuVKNDZDFxjMLVz/m8+jAN6+EGQ5Ya3nMOcgL1rqvVh3LuOkVc5RdhHba4S2/X2NWG6czVA/CNjZYyEVwzun/hzpDDmmsYAWpzSiGBVMo3iGw/EuA31Xw951XctQ5m/n2rHNoV/J9BonG3gLr2Jjp8ChLTtbqkrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9fKdPU/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347B7C4CEF1;
	Sun, 14 Sep 2025 15:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757864599;
	bh=cWDlbvOR8jjLVrZF7BbrRnSA0nL45gpNjaxVHVBvSQM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=T9fKdPU/MNYr72GcbiG650RF0YC7iGopvHK3lwJ5tPP7lFIxHZcstlmNGE5b0NgU/
	 PvKvzHVwS441tH8WAK/+DOclqV/Bvuntvo3/qG3PBIAAsEsFfeJ61i61HIDsPuKRq4
	 MX4BwxHNrvx/hdyPCDVD6Blek7b2e6bhTkFAqDXgOtRzo5HPFJz2GQpBDBHT68JuCH
	 SSQrL69a86QAvsON1EfYvLr+bNykLiBsu+jq/yc3liwc56OfM2YQTh6+NZ+6iMeLwe
	 zoS+Z9Uj5+jnW9iSDQr1wCd3uR9NGtQ0ijP4ssxE+Akz2bYnqEWBMD+QRdlG1VfP5f
	 YxzS7n5uq6ibw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B1E39B167D;
	Sun, 14 Sep 2025 15:43:22 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <aMaOdgwWqzN8_UWU@gmail.com>
References: <aMaOdgwWqzN8_UWU@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aMaOdgwWqzN8_UWU@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2025-09-14
X-PR-Tracked-Commit-Id: d2e1b84c5141ff2ad465279acfc3cf943c960b78
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df86f912b45c20e236060321c85fe35437e9325d
Message-Id: <175786460085.3496327.9340175421178332271.pr-tracker-bot@kernel.org>
Date: Sun, 14 Sep 2025 15:43:20 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 14 Sep 2025 11:44:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2025-09-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df86f912b45c20e236060321c85fe35437e9325d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

