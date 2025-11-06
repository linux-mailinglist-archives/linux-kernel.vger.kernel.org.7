Return-Path: <linux-kernel+bounces-889381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B518EC3D6E5
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 21:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584121884100
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 20:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83062FC00F;
	Thu,  6 Nov 2025 20:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnKfGb34"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D9730146F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 20:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762462444; cv=none; b=KUFzdMP6TA6kghOeIA9VvRaJdBTc1SVvuuU9SNtqW6tkuT4GSNkgO8CwBDh2V40xb5uoVWCBELZCpA7b6Q0u3rHGbCLO9MQZ0Mz/LA1lvgMNRd6pQSNC9q1Rx9LJ7vjCY+KHrwQ0+hF/D1PGIeajtq93QJFPr1kbG+mwmv9G4HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762462444; c=relaxed/simple;
	bh=Th9NNwjl5klZp29pkiiVOO9ZyiDTyOqX4UaHUw/ehaQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WV/NX7j9Q8ijufkGLdFp+wuRRdO34DLhIJX69WO1f0/rj5bropvuwDEcIBgMuobeGu11KmcEWCZ3rnYwfHVJu/NU92o7BGujIojGJmvzxBJ3kbAE+icWqEiscqcAxE2UuyiUvTL49DIMBTWdQQksRkgn2PExxrKoT43JTr6di8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnKfGb34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2544C116C6;
	Thu,  6 Nov 2025 20:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762462443;
	bh=Th9NNwjl5klZp29pkiiVOO9ZyiDTyOqX4UaHUw/ehaQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UnKfGb34BLZ9FCGovNiY+iZiFE8+CLG86TuJPH8Xuzj3zpV6t53B0xDCBf4KCHuNj
	 2aYIH+P1RCSjwZl29uBpKk2PHyyYBHpOY9SqVus7F31K0Z4oUhqnA86fvQk1e888Ht
	 IopodTK5TxDbzphZOw1wEN+2YNG/QFFzG95+WJAK+Vf0XrLq+JqXujoesNW3X+uVAX
	 OqY8aHZFonEdGbfz82f9WWPbsp7Lu6A6ybiaHJk9bCabgdAxdpbUqqovg9u3UiLy9/
	 SBC1SIjypBVxVqISpTI+1rGL+hXNHxRdNQIExrLvKfwhyWrsLdqj1M74o2HProw6pY
	 OikzXgiZE7SCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE17739EF96A;
	Thu,  6 Nov 2025 20:53:37 +0000 (UTC)
Subject: Re: [GIT PULL] hardening fixes for v6.18-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <202511061151.CB031555D@keescook>
References: <202511061151.CB031555D@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202511061151.CB031555D@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.18-rc5
X-PR-Tracked-Commit-Id: c57f5fee54dfc83ee1d7f70f7beb9410b8466e9e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c90841db3524657204c096fd47283817cfdbd2f9
Message-Id: <176246241636.354628.1329199034118137899.pr-tracker-bot@kernel.org>
Date: Thu, 06 Nov 2025 20:53:36 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 6 Nov 2025 11:52:58 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.18-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c90841db3524657204c096fd47283817cfdbd2f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

