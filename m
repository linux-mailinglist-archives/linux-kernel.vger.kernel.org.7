Return-Path: <linux-kernel+bounces-845863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CC8BC6558
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 20:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668113A586D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 18:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19112BDC27;
	Wed,  8 Oct 2025 18:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iC4KJXjx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094C219755B
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 18:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759949333; cv=none; b=BC+k2Z2r05aNvYweCoA76XFcQE/cIqzP8r5nMUBJM94RGIscoeeOvfl5gZWDCaEXWBrMclGX8gb9zVBX2HLOsjoUyzIRr5CG96DwRSrkhNInWzWvVYOWy54k/qk4D1JvxwRcdtQSRbpIZ1fPxZCxl40NmnShGHxuJrCIoNfHYo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759949333; c=relaxed/simple;
	bh=a6Xq9Ys2MHx5xqZIWq7gXyze8tFCk3/TTnm5Ky9G5xA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=l8A2183QZabEpKAWvepTWqMfKDuRfpRUAitRgS+Rt2BmY0eFONz2qxI+3c8UOcrzPshQtSvrTx+I5kkxcQ4p+NGYzPTfp860y1ROup3cTzDFtqA0cTADmh9JxM5yvTL6uAtJpXkFEgeqhIxwftGr9fv49SIvlo2LqfR/s4pGXtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iC4KJXjx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE407C4CEE7;
	Wed,  8 Oct 2025 18:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759949332;
	bh=a6Xq9Ys2MHx5xqZIWq7gXyze8tFCk3/TTnm5Ky9G5xA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iC4KJXjxCyIubWntJvpVH015eKM958jf3v3j1MbRny92tn66x0diUCcBCkWFpF3UM
	 5JPt+GzoZ3krejJeGFdufkULTFZor5PW0S8pMRzp8crINDaS/0tUO72yxbgr9xdtcR
	 4IHSBY79L0wVCu0Gzl9+ZawZniFB2EotYenTYhR5D0uN2c9/HBIrVPTbyoFI3tZn17
	 FmvvaYd4M4v/DUXKMGgrMSMFUrckFdf8zhFs13rSDA6Gy9On2FiHKoDbFvUsoDajT/
	 NKH+44RBFwHEOoK3+ZU3TUYSr4es+ujx/z8+OQHuvSMlIDlJpXCSR5JloXfDJbdnQy
	 WhvCcuQzFlKDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF573A4100B;
	Wed,  8 Oct 2025 18:48:42 +0000 (UTC)
Subject: Re: [GIT PULL] Mailbox changes for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY3nxSwcHs5YwWkmFq=DXoAwqGXdud7673kM32V2+Le1+w@mail.gmail.com>
References: <CABb+yY3nxSwcHs5YwWkmFq=DXoAwqGXdud7673kM32V2+Le1+w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <CABb+yY3nxSwcHs5YwWkmFq=DXoAwqGXdud7673kM32V2+Le1+w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox.git tags/mailbox-v6.18
X-PR-Tracked-Commit-Id: 3f39f56520374cf56872644acf9afcc618a4b674
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd5a0afbdf8033dc83786315d63f8b325bdba2fd
Message-Id: <175994932118.3563654.4461558328162731929.pr-tracker-bot@kernel.org>
Date: Wed, 08 Oct 2025 18:48:41 +0000
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 8 Oct 2025 11:58:57 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox.git tags/mailbox-v6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd5a0afbdf8033dc83786315d63f8b325bdba2fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

