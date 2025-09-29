Return-Path: <linux-kernel+bounces-836856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27387BAABD2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 01:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C1D77A6D34
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 23:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EAC265CC8;
	Mon, 29 Sep 2025 23:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DROXk19n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991A3268688;
	Mon, 29 Sep 2025 23:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759188150; cv=none; b=HfwNHNwd+ABDjA18AXTwkQhAA+7SKwza8mf7Np4th4uwTD3RPyuFI5Lyu+dbE3jpp8CgxAq9fuYQQVh1yb9eIko3Gfxt4Spj4uFMMtVuw3rH3YzclplR4zsDmCFba5ZIkSG3dpl94JjuPMUm28ckKgTvZdFpE1dMpRU08zkRoLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759188150; c=relaxed/simple;
	bh=SpbPFV39FuYcxbtXbTF5xckTqRv6K6YlPCxe5rU8wZ0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oM/JNmBFdvckzjIGeXpBLUeb37LATn2+4ZcEgfyejqehMG4/GOO0mJhWwhVsye7ah0WUEiiD5CAu1J3vR/pgBlbZmYqDFU2ZXdF1b5AHC42OQfQXXxIMZTmBCS0v15LFndLVWtFmdIx18SaH31UT0z55LEleRGMf9OcW8dVpQg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DROXk19n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5FFC4CEF4;
	Mon, 29 Sep 2025 23:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759188150;
	bh=SpbPFV39FuYcxbtXbTF5xckTqRv6K6YlPCxe5rU8wZ0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DROXk19nVpPuizCYgf918YU2rYSdLGMQM/X9au4a2yb0QmruzMXW3Vpz3v4RAoSK/
	 NlVJfI46I2TFsWuxFXQ+HA4FA/hORBAblJPEtXRow/r+lyDJqBxxcMwCI0LV7Voxs2
	 +Jp88RIe1pSOWIukd6DDbLbBBvTjtrmK8esayTevKXJN0LRbUHtzGpEtlPA++Anks8
	 9ul0d1XN+nVtZLzS+l2yOYyZjF+czJ80SV9QjD8kqehOLG0HW08DImO7ZO/Kxke6kT
	 rgcNlBMabXPnByKoAfLiVRRAmP7fLO3Sh+GuzlziI6Wl4vSEA9j+o44t1E6a7EL7ga
	 GbKuTQAKzu6cA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3553D39D0C1A;
	Mon, 29 Sep 2025 23:22:25 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 changes for 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250923090549.31521-1-agruenba@redhat.com>
References: <20250923090549.31521-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <gfs2.lists.linux.dev>
X-PR-Tracked-Message-Id: <20250923090549.31521-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-6.18
X-PR-Tracked-Commit-Id: 28c4d9bc0708956c1a736a9e49fee71b65deee81
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a40eb50a9566318a138b3e222fc4fe04e3932cda
Message-Id: <175918814389.1748288.10675457404671007036.pr-tracker-bot@kernel.org>
Date: Mon, 29 Sep 2025 23:22:23 +0000
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 23 Sep 2025 11:05:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a40eb50a9566318a138b3e222fc4fe04e3932cda

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

