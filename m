Return-Path: <linux-kernel+bounces-738381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCF6B0B7B2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 20:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 175503A6540
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 18:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE6E21D018;
	Sun, 20 Jul 2025 18:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZnhAx6C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4B31459FA
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 18:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753036682; cv=none; b=pgfzVY5QMfcNrU4ZOhvrO0EVEFLRuwhukGu5wJv7LZ1t+Xc6XvXQf0Orx+sYOmRHkAzxXYUDKRUJVzDsCNlRueInZaVyxNfMQKFmQ4qWZ0Y2P13Im28cJxUKo5Jb/iOpidysmkZJ6IkwooZFYjUc1DCsjNdQr0ddp6tt8eW95iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753036682; c=relaxed/simple;
	bh=sR70szoRfynxaqEtE0ijU6LSiOUjUtnSk6qFdZG1w7I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=euqrHAe4XEuiY0uXFGPgVi6VroVNpIS+yIAl7wfLqmiyrtaXmHQmd4vZ8Ac7hGMhIOPPf1z5r1qlxabpnZUyDASwk/R6CsK50hRr3G7CPfnZZ2VktI1DwL1b1aT3kwMMMEA2i3MuaL6Fw9oBKIj1rCZpGBpQjd6apj1J9Map+LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZnhAx6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FAA4C4CEE7;
	Sun, 20 Jul 2025 18:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753036681;
	bh=sR70szoRfynxaqEtE0ijU6LSiOUjUtnSk6qFdZG1w7I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bZnhAx6CW/3mOS1QEcGfdOjobMxdlYkKKtJe3Jn8VY9aUcFj+7qTDKAuwqQ9ojR1d
	 /i0NPMVr+XHeevK3nOiDa+inCZLBjuAloGf7hjVWahP8g18YBZKyutIdG5b372fqX4
	 E9TXVVDpE8gL5k85MTdqTs9wPR3gHSgNGjeG9NOBIkZgTyPKh777pXb2WwW2RKNL8X
	 nwE7aAFbUmAfUhEY/vB+F9mc2GaSckuLbwGni24808J9UGmgxvksckmopR8DEtNMPN
	 KVP/2m/DSPV+R8bXLDS5vJtc1VsGrSfrGYlfgpJGcy7eM2nV2ZIxJ/LVoEqd+71/vQ
	 s8zqOJ9l0ix5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0B9383BF51;
	Sun, 20 Jul 2025 18:38:21 +0000 (UTC)
Subject: Re: [GIT pull] locking/urgent for v6.16-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <175301303546.263023.1426155806374119244.tglx@xen13>
References: <175301303546.263023.1426155806374119244.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <175301303546.263023.1426155806374119244.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2025-07-20
X-PR-Tracked-Commit-Id: d0a48dc4df5c986bf8c3caf4d8fc15c480273052
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92329d578d60fe944e30da287ee28f5c154a5802
Message-Id: <175303670029.3266248.6580854387988228628.pr-tracker-bot@kernel.org>
Date: Sun, 20 Jul 2025 18:38:20 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 20 Jul 2025 14:04:57 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2025-07-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92329d578d60fe944e30da287ee28f5c154a5802

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

