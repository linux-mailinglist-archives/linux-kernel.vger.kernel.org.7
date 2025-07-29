Return-Path: <linux-kernel+bounces-749961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9057B15569
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 00:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6740418A75FD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 22:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB192285CAF;
	Tue, 29 Jul 2025 22:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIHT6uJA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEEE22A4F4
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 22:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753829140; cv=none; b=DvQnvTXHI0wgALpCMRzKmSicgR7Na+hvRJWqdiGL8ll90UJiLTWiHTjpL9W599iCMzC5oOHSMlWCsXKqcamtLONEI+hK7rEjePcWNrEBb3KFY1z+f9fOZ01Ly2+JWJU7SjCwBv8/gEuuCDl0vIl01xUf/TwMWRQlHKN0Tow9dkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753829140; c=relaxed/simple;
	bh=HAVZ4afC3HQN1YC6LWWOlBIRJ9Kcc8lXN5bemgMyqxM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ETfiUPMC11x+7tzfQ57i3XqtujbEoeLxXG7c3sD0fSyt+rC8skfxlf8F3JbTqExmMsrjeEqTUTiMI0rwqXak4975N4N1AG1Uf+ZSUwF878Zra50VjmoViPmtpQ2LiHdEb2viKE60KSjI5U7CKJGJQd4AfP8NlZjcQD2Xt69unlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIHT6uJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80866C4CEEF;
	Tue, 29 Jul 2025 22:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753829138;
	bh=HAVZ4afC3HQN1YC6LWWOlBIRJ9Kcc8lXN5bemgMyqxM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CIHT6uJA8/GvJkluiJrI5UkouXCMbASLcXdVXff1LT/YKJtvj8/gXeh5mEb0Cbu99
	 XCU0Ywav7X5nFXyw0MD9KbodY0dM6HJMHCfS/Cp7BW1cprEPJbaYsqeCGcr1xFW/KT
	 LNCIU9qobJsuY8QuEeHQ09o4pT6t6sYo2iQsXQOHEv6zBmQPrp3/+mYMKuwQMWLsv3
	 Ra6sMwxq1k3zhNWWE/YYzcjk6w3rpr3RWq9eTUfZmbYWNSdZ4xxXO69OePeZZI95A6
	 f0LJ5ftgqjPzfvPPC7z6z/Ej0UZlUbF9HP99VZ49gM3HVjPLXb1KkJNdUC75p72OFc
	 OUIY7z5ZUNDEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACDF383BF5F;
	Tue, 29 Jul 2025 22:45:55 +0000 (UTC)
Subject: Re: [GIT pull] timers/vdso for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: 
 <175377875763.620102.5832465811647184511.tglx@xen13.tec.linutronix.de>
References: 
 <175377875455.620102.9417697212609201411.tglx@xen13.tec.linutronix.de>
 <175377875763.620102.5832465811647184511.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: 
 <175377875763.620102.5832465811647184511.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-vdso-2025-07-29
X-PR-Tracked-Commit-Id: 437079605c26dc7c98586580a8c01b5f7f746a79
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a0482e3446cea426bf16571e0000423ed5b25af0
Message-Id: <175382915450.1670422.5393386747411143429.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 22:45:54 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 29 Jul 2025 10:46:08 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-vdso-2025-07-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a0482e3446cea426bf16571e0000423ed5b25af0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

