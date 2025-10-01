Return-Path: <linux-kernel+bounces-838270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB00BBAED88
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 02:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2AD17ACFDC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 00:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DD919E97F;
	Wed,  1 Oct 2025 00:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idp7El2p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A37E16FF37
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 00:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759276959; cv=none; b=sL9HjS8HkgDV/s/Oifid+4KnUezND7cCdTLHRw78yKQT5N8Ho5jDLYMrl1jWbyf/gcqu4JF5EHLvGYpKzXhQu6KBpnEUOJtMkBXDuuK75QbgQqMlsBtBMPFKX+OR2X3iDKyJ9gMK+ARJJToEYOo/De4SDLUzGdYlma9n/upiNcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759276959; c=relaxed/simple;
	bh=P0qHKR7GczT+86RW0Hi7Jsy9IUO9xOt7WzTYHO9lG7g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=A6mRwDT+NVcPKuCJIPyWF1sGdDGHaaLngiuXHeY0cFrpLWwW45tflvy/3IE3ggKXzRNCkVDFtd0wPgQFj+QGXMN1AXDNfaPoy2SD0ZanZTap4Zx8mWjNNKDeFRk9dC1aSbhxCo+DLwvdAsw7vxRH7sSFnk3Ddxm+AseQBeH6+4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idp7El2p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C073CC4CEF0;
	Wed,  1 Oct 2025 00:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759276958;
	bh=P0qHKR7GczT+86RW0Hi7Jsy9IUO9xOt7WzTYHO9lG7g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=idp7El2p5q/+UHI5ykwKYhE7oiEQteP58e3JAjueuU0dS6qp8uGF4p9JAEisrZmGp
	 mdYNH3AK61vV/m44E02KWVJwYp2v+Ww5+iPDw3rAbc58FD3o41HPi0L6kJwOKXz1Rb
	 oFf6K7KvAmO/2tgnzH1HYDJzQZ5a+hahl897Unq5375zgwhVDWAlWuB1QadS0QJoey
	 dbiEbRoNjwtqWyyc9nn5osz2ScLw7kLXBBvOgqFOMZj6LPh9San7mhi7WpANFnU5Iy
	 H/+JkrPKBcoU/nvhYFXs9wmodd5ZumKxpobbaGxQnpquYj7wNVn7kr8RNPiq6WmWCB
	 gOkvVst70e29g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD6539D0C1A;
	Wed,  1 Oct 2025 00:02:32 +0000 (UTC)
Subject: Re: [GIT pull] irq/core for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <175913807957.495041.15537657456860100631.tglx@xen13>
References: <175913807599.495041.10251515322736195577.tglx@xen13> <175913807957.495041.15537657456860100631.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <175913807957.495041.15537657456860100631.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2025-09-29
X-PR-Tracked-Commit-Id: 3253cb49cbad4772389d6ef55be75db1f97da910
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b2074c77d25f453247163300d5638adfab4e4fa
Message-Id: <175927695141.2242674.3894297056674971688.pr-tracker-bot@kernel.org>
Date: Wed, 01 Oct 2025 00:02:31 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 11:28:58 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2025-09-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b2074c77d25f453247163300d5638adfab4e4fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

