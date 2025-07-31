Return-Path: <linux-kernel+bounces-752513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E45B17676
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 21:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FBAA1C222DF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 19:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFBC25A642;
	Thu, 31 Jul 2025 19:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoEF0xt+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB0D2580FF
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 19:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753988839; cv=none; b=esyp7D+/YEFZA9AzpHmj2VjTK2LCDleSATED5ogU77ILsbLRxkiX14yGjTNGL04Ad1h+g/gZ5SGnU91Y0IVv50qYfPNAY1rhbppR/7kfT8AjfeY1BIrnGc9LaQvJ4/vNqoYg8YBOPW8GvzUrXH36Var48B+ZcRPS3bqNQW7s1+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753988839; c=relaxed/simple;
	bh=V/dIZXtt011ontZR2WskwsDeUCuL0qUhkfQPVoEB/QU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aekTin0boyEcmiAVTEPB/u0JuXFhyCxBbbcQqIhrCqkwBnhiwXxTbxEKAcB3ma+qKQpfD32XPcwUYmf6ePbUIzZqfBm5VtJVPA+Ch/7/F/VJ2VZBwto6pwC67hVBlmK+QbiBn3ga+Zp/r+w/DpoZxbaPVSZqrK0Kfv/Rr6QA47Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoEF0xt+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B45C4CEFB;
	Thu, 31 Jul 2025 19:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753988839;
	bh=V/dIZXtt011ontZR2WskwsDeUCuL0qUhkfQPVoEB/QU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BoEF0xt+cEr6i/ii4fnrCXigIY9zM8IPbfKBb24GTh+V30LtTcNR4VJZ70vr/2JbM
	 u7DVMAdyGqefIVYS5AGh0g2hy5uMBngnASKcIols4jq0fL9ZE4IsJlagiLo2vYVKs3
	 brvy+Q4SEQcKzbYOCEwSnkrsOYrnNFRgD6nnjROkdrUvSq9YPjA8oqKiSpdPE26oob
	 mWbv2rQvAP6Cu90BU+6FhWZojlSuKTk02oCgUN8mOmV0Bb7JkQnMJUazbD8gvcACf0
	 xZxmEucz5wLpkny0+W4fgFed3g9P0cyI/jKjQDvKFKdfKoKZqgBasOBpoHX7KGWTRN
	 rZab8LFN14vaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BA8383BF51;
	Thu, 31 Jul 2025 19:07:36 +0000 (UTC)
Subject: Re: [GIT PULL] LEDs for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250730151013.GC6782@google.com>
References: <20250730151013.GC6782@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250730151013.GC6782@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git tags/leds-next-6.17
X-PR-Tracked-Commit-Id: 4903924ac7ef31fbbe48b3261b1bc86ce6cd7e97
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 831462ff3ec61fd2e6726b534a351a1a722bf2ab
Message-Id: <175398885477.3259326.9792544345858300262.pr-tracker-bot@kernel.org>
Date: Thu, 31 Jul 2025 19:07:34 +0000
To: Lee Jones <lee@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 30 Jul 2025 16:10:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git tags/leds-next-6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/831462ff3ec61fd2e6726b534a351a1a722bf2ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

