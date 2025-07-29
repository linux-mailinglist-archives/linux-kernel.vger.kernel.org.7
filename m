Return-Path: <linux-kernel+bounces-749963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F9EB1556A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 00:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6F518A7738
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 22:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C2E292B5C;
	Tue, 29 Jul 2025 22:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSUgOiro"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B54A28C87D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 22:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753829143; cv=none; b=tvYkx9zGGS5kVoWSGNjJiaUTSNcKAdVWl/Mo/yXRK/TcdfJLsRS7qaPFL8tvvGCpDZNzEg1zMXEQ7h/YK6MNLW/V6wvMWkT5PPvufx+OADr67KHo/g7v0hgl06/acU2LgmttNUXP4R62Kj4+htdc8TDUmA/6f3bghMHDwNl5z8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753829143; c=relaxed/simple;
	bh=f5p4amVoVlhJ+TaOlfsmYWqFcmkd3qQQVLFsh8foHJY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WRWfKPjVZOjRJRxeRd8BxtBFkSY21CtP96/P804eTeg9JBsdNglCSvTUBadItSv1wap5kDq8RXoayQECl//HSNS6ieGBUm2xocBUWrX0e230m1dtE1pvUyz3b0zJVUnKKCP7CXHOOX+9VvEen4Iaan2/ciSS57JLth9UeXD+rWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSUgOiro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7EEC4CEF7;
	Tue, 29 Jul 2025 22:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753829142;
	bh=f5p4amVoVlhJ+TaOlfsmYWqFcmkd3qQQVLFsh8foHJY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aSUgOiro9Caf50AMnmHw3i72Qjae/DduhicWVgCTkZNGPjsDTNauK6zNE87dbxMFM
	 LtFFipZ6iLfyoKJQFsU/BQ+6/xWytcoCYublmXXWAX38cmegiIBfPhaKpwKcq2fnnp
	 EDMs/6L2vV51SBipK8Lfzgi2DV3u6UjiGy5xZnn90P5nJkys7nrXCwjEw60aK1qvLn
	 O/4sj/vcMLUseTDmHpBZhtNwDdIYeD4z8Fimi9h/98xZyrATYgFOi08cz64O3BpKYx
	 qY4/Qw/KN8FU61prh/diSZsFquxAtPE4LwsCLtfdIW+hcXBG4mdum/n7auPlBH/wuL
	 KmjMzfdImYtJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B7A383BF5F;
	Tue, 29 Jul 2025 22:45:59 +0000 (UTC)
Subject: Re: [GIT pull] core/entry for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: 
 <175377875455.620102.9417697212609201411.tglx@xen13.tec.linutronix.de>
References: 
 <175377875455.620102.9417697212609201411.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: 
 <175377875455.620102.9417697212609201411.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-entry-2025-07-29
X-PR-Tracked-Commit-Id: 5173ac2dc8c09361bdb7787c70a25b5b4d61b454
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 78bb43e51b94828b333ab296eabf893d5b439fc2
Message-Id: <175382915805.1670422.16867954889669501785.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 22:45:58 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 29 Jul 2025 10:46:05 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-entry-2025-07-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/78bb43e51b94828b333ab296eabf893d5b439fc2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

