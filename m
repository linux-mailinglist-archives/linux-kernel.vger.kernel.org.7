Return-Path: <linux-kernel+bounces-760972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C592B1F25C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F245618B6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AB91AF0A4;
	Sat,  9 Aug 2025 05:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdAdFTUH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA32156F3C
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 05:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754718326; cv=none; b=CnADrWO/UwewMJAP3ZpPwc0CL/u8C/pxvIZiECyPdW4ouTZAlK1941m8YiAZg0+k3MkMbeuBIgkwU9712YKlVmTfDKJBdwOr43c0+AyU8tgWKECxgMpgP7yzo+qoGZhlcHkN4CKsHo51XArurbDF+0d7SzCB5HlIErLSxPVU/Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754718326; c=relaxed/simple;
	bh=bwRL3FVlYehbSADV5n4FEz08GnOQ/ZBLGjMwUPJa9hw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Y3ly4AfQvUQr7x8GAOmC1kU0WC1kTc71NUITRELsAtlJKWaPeFCu9su570ZjpJWVn82/HCUcUu6f54bAmCMCqyzkqLmUxdxozkgXda4ffb6+qKVKisu8ovz+PWLKY/QaTkSnmcPTKJ1jHsRitshaWFwFw0s3WWnnySVepK6rmXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdAdFTUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3E1C4CEE7;
	Sat,  9 Aug 2025 05:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754718325;
	bh=bwRL3FVlYehbSADV5n4FEz08GnOQ/ZBLGjMwUPJa9hw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FdAdFTUH5Tn+l6IrNPGoEx4ceVeDpnQWgPW3yHG+JNYi/DdTwoCISG2GQ01vw87a6
	 LP/JrhoSS3KBITPnAqhL7E+RoGUNep4K+i4YSO6qFj19RKirlJK4pxuggV3Mlop08g
	 a38NmXz0XCg+9JzPdXkqa+ORg142VmXBu/glN64F7ecxmXgMMo+sqYo8vrcm15rRxz
	 KaFI4QMUoeMqQKNoOM1UBBhKqb6OSKd8GEFTk0nPGlRSzDC3qO4ntVFiYuVd0jdnYv
	 8UzampD/YQ6WSBpF/L929RBSlrQP8H0gCFQHi/qLv2sy20JzLLM2GQtYtkCSLfV+EN
	 0IuEqadSt91pw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3407D383BF5A;
	Sat,  9 Aug 2025 05:45:40 +0000 (UTC)
Subject: Re: [GIT PULL] Mailbox changes for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY0+oTn999iv=vy1npF1Bi9=GVqWXBh=iOocVoa2MwW5Vg@mail.gmail.com>
References: <CABb+yY0+oTn999iv=vy1npF1Bi9=GVqWXBh=iOocVoa2MwW5Vg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CABb+yY0+oTn999iv=vy1npF1Bi9=GVqWXBh=iOocVoa2MwW5Vg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox.git tags/mailbox-v6.17
X-PR-Tracked-Commit-Id: 5378bdf6a611a32500fccf13d14156f219bb0c85
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b20b8538b310f5458bd7a08b7ff8a76cc3c28d24
Message-Id: <175471833890.387690.7361810232881130726.pr-tracker-bot@kernel.org>
Date: Sat, 09 Aug 2025 05:45:38 +0000
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 8 Aug 2025 11:15:26 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox.git tags/mailbox-v6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b20b8538b310f5458bd7a08b7ff8a76cc3c28d24

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

