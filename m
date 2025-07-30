Return-Path: <linux-kernel+bounces-750152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C60B157E9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 05:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADECE163D22
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 03:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89F21F1538;
	Wed, 30 Jul 2025 03:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmqxweUB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA861EEA47
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753846778; cv=none; b=NpvBQXxw064m/7Rh+Fs0aPuCJzILOODnCdqzSIq2CkQv+dZW2lIB4MIT7nYKt5pRhpwjkDqpcEhC0RPueZ3BgL5GOS1EqZNsUnvrSL4xM3CndrvRYYAdFdqUYVaoyk3mtHpngXfD8smPTWrIgXaoouf0azshf9wJxEBHfpqTSec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753846778; c=relaxed/simple;
	bh=Af1qfZ8CoqSMifSj9cM+jDWGwVqGyzXWFXc0NKmRudk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=erHJfK6j8DX05LZZJOMDOSuBvX1uYDTBOjdxfKzaug2ZrKvLC6NyPj9UpbPG0phU/kdzyqmaUfOIKugj1ESQld4TCSVvhNERgd3kB9CeoUijE2wFA1dD4JonvlG7NKy3HqIDgiDD2rFKI1KB7bB18iJjaVQTSonmN9M47KfAjks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmqxweUB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552D9C4CEF8;
	Wed, 30 Jul 2025 03:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753846778;
	bh=Af1qfZ8CoqSMifSj9cM+jDWGwVqGyzXWFXc0NKmRudk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WmqxweUBJ4XLkafZUaxV1mF4rUWXddqGE0UFdl6SW2daSbwmIXgwB88Zn/3Vt4RXw
	 zsLp8CO5+0vQmWHn+DBrQCwgtcPj0Q/xfR2TxTst2yy3YDURZwWQP51YfMqp95xfls
	 2Ur/FmMSIfj9fC+qvba0UEoePJzD/nPhW/ujkwkvCFuM4frQyJ2J16Q7NJnRdYa+F0
	 umdiHkgyo0MrCX3LApX3jw/L2nC76Ty7g7OfA/wCiNznDAUvRzZ0CkNkibdaRAu04x
	 CDJsCqB83Um4GWizvzym2Nod+b3CauVDiGb2uSzVGfcDjpIVlB1BvMZXtzCFRmqqYT
	 VL+d3FMJzPHYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF48383BF5F;
	Wed, 30 Jul 2025 03:39:55 +0000 (UTC)
Subject: Re: [GIT PULL] x86/boot updates for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <aIhxJ5-wj2mbJBvm@gmail.com>
References: <aIhxJ5-wj2mbJBvm@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aIhxJ5-wj2mbJBvm@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-2025-07-29
X-PR-Tracked-Commit-Id: 61b57d35396a4b4bcca9944644b24fc6015976b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 56d5e32929ee8e772922242f37cc234c437c89c0
Message-Id: <175384679431.1749338.16094202138243182330.pr-tracker-bot@kernel.org>
Date: Wed, 30 Jul 2025 03:39:54 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 29 Jul 2025 08:58:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-2025-07-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/56d5e32929ee8e772922242f37cc234c437c89c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

