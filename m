Return-Path: <linux-kernel+bounces-839455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9139BBB1A61
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 21:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538FE2A1212
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 19:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E912D46B6;
	Wed,  1 Oct 2025 19:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLLbww4h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D922749C0
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 19:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759348278; cv=none; b=lctfJVtBstl2DKfZ2aiBF8QxNYdFZxMttrkWB4kLL/m/Jz4pyjbHgqvjF/6+CLByUvxLRoAaKZ4oE9odcqE+nZ0HLYZ+MHMAzxSSUApx+kNujJhW1d1nw7zZ2U+XdyM0MA6Jd1+KMMWRpSkg5Ebg+5zayrneDmmMVmLLjwVp8dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759348278; c=relaxed/simple;
	bh=EQzj00J3kc3WkMFe/I2UGS6ucVBYV/TYv1meQH4EtmU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KL0eq6aQK7a99Vizfr0diMF3mXBk8NMZPC6kejNayQ3udaPIM2MNcvrO1+UEcTd/fe6xL9aUp6w9Xtzl9Pmr1+mtXmStfI3pCoa2MR7pjPFt/Fp33RlR0HTs96d2dJnPOhoxcN4SploKwlQwtMXh0oOtqv5HMVQ9vJzXj9/m6vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLLbww4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455FBC4CEF7;
	Wed,  1 Oct 2025 19:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759348278;
	bh=EQzj00J3kc3WkMFe/I2UGS6ucVBYV/TYv1meQH4EtmU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DLLbww4hcJuqtUplb0Uc4wCr+Q2CrstgBsmi8edUmQbsRgiVnLbn9q1aTPmBRl1l/
	 H+0qUimJGjzZ/fPa39Me8okroNzOHOadsnScNmVfV0yRpDGOk97QaII+r9EFvami2W
	 7ckgkAXva3RqEY+S4kSijDdF8TJW4IrcN4lS6DmkU8cQqpd7Ribpe4KOkuo2dTcXju
	 4Br/WY2xIdfplVBhB1c+H7lYqPoXP3tCOozhURWgAIlADLL5n6mdUYpHqF0pblrD7y
	 ZPeHZXwWyUrpf5WQBQc6uiIdthK8e6E5tExaiAj/fjpYt1EIgkn3UQhvKUR15t6H+4
	 gYJbnJYT/9odw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAECF39D0C3F;
	Wed,  1 Oct 2025 19:51:11 +0000 (UTC)
Subject: Re: [GIT PULL] LEDs for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251001140109.GV8757@google.com>
References: <20251001140109.GV8757@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251001140109.GV8757@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git leds-next-6.18
X-PR-Tracked-Commit-Id: 64826db1e2e177b58dcbc7cf1e1379527be2185a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b386ef6286ace3b7546e641c2243f8d3d4dd3f28
Message-Id: <175934827047.2595637.10505733065694039197.pr-tracker-bot@kernel.org>
Date: Wed, 01 Oct 2025 19:51:10 +0000
To: Lee Jones <lee@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 1 Oct 2025 15:01:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git leds-next-6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b386ef6286ace3b7546e641c2243f8d3d4dd3f28

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

