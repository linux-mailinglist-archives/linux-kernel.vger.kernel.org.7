Return-Path: <linux-kernel+bounces-750150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6B5B157E6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 05:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 641BB562189
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 03:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126651E7C27;
	Wed, 30 Jul 2025 03:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrfakAzW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B031E5B90
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753846773; cv=none; b=qxR/WuRBZUbY6WUSApqJa5uNo7P6W/wFR7tuLJCidGCzfCMYIpLzBilCB2CJ5MLza/PE4W4SWahqQVATktdErzcHy4aZiTw+3zNb/55qd6fYfrxt2RexzbBANQL8A8qV2gUBQc1HgOi41CxCykuadKPP4loCDM+/X/Z5POqXePs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753846773; c=relaxed/simple;
	bh=mmDc4aeAv6aT3MVYtMthcM/SHrPAWv0icfnl5JSv9To=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Vi5SGHQaKECqfrjwjMYVV4mZr/0Dwi1BxhhLEbpeEiRtZoE8QBDGzJYAKU3gh2z0fG6vmB7AEiksr050fzUkASenAiCw2vX5fxKRZoN5WcLEfGPzM7lr96mujzHOByv2G3xmOK7OK9Mbx5J4ulIgnUf5QJXJKzmoAzs+7dQ4YNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrfakAzW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46AD8C4CEEB;
	Wed, 30 Jul 2025 03:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753846773;
	bh=mmDc4aeAv6aT3MVYtMthcM/SHrPAWv0icfnl5JSv9To=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lrfakAzWXSvWVciBv1H1rB0d0ciaz/qjSnd7IL2Bs7+T6QggyCRGXQHX7QsDoZkIx
	 wMkWYadZRiUPIFK7rWy51pkgU1JDj+wZo1wI6/7UMB1mSWX6vh6jiRzWQD8aK5W7J7
	 BeSp+Vne6IMFiwuYpmX6i6R0Ny2ExrDGpVx+vLm0cFiBV2OncXIbM9bUuH5YO9160B
	 xmHEpzzLAcHofKu4JU58AV3XS6QNjine3UFouHzGGs/9Cjk5QAroQYB88Ip8dkr6nW
	 34ky4aMP0T4rXg0AU4GlqSo4j3rXrxg9qb9DaJPVeZgaqrPUl1MSMTx3zRp461y5Q8
	 KVdFwDaah/K/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD2D383BF5F;
	Wed, 30 Jul 2025 03:39:50 +0000 (UTC)
Subject: Re: [GIT PULL] m68k updates for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250728093437.223500-1-geert@linux-m68k.org>
References: <20250728093437.223500-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250728093437.223500-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.17-tag1
X-PR-Tracked-Commit-Id: c8995932db2bad6fa093ac64dbaf7a3e8870eafa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3bb38c52719baa7f9cdbf200016ed481b4498290
Message-Id: <175384678931.1749338.18378664367679266457.pr-tracker-bot@kernel.org>
Date: Wed, 30 Jul 2025 03:39:49 +0000
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Ungerer <gerg@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 11:34:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.17-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3bb38c52719baa7f9cdbf200016ed481b4498290

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

