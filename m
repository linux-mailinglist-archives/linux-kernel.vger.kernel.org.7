Return-Path: <linux-kernel+bounces-755771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A841B1AB98
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 01:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25752180EC6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 23:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDF524A07C;
	Mon,  4 Aug 2025 23:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWUR/4nt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE842264B8
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 23:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754351615; cv=none; b=s4ENmjZOaUYVaRqQBKHyG+EtmOdVIoGUxSTFCGFCcqWunecl+0kEwX3zNhhVCh/T/MFhwG9MPy80TuLIei78q0C8eYzPo8kCe5iZLnsWLMWUj03OrH2NH/OODLQQDsR5TxSgXV0qgFKKCFpuLCKCTu3EaRNACiHx9ow4J0Sdqdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754351615; c=relaxed/simple;
	bh=mYMLftyAT8QXp0pXfjxxCAHPluo5qRTQ7BK2PGulMz4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Kd7NaEF5/kI2CSNklXZSvxpTehcrWDFtIpRX7v67RVjBgsON0GHJ2qBHnSGmKN3G6WhYNPcel5g+6/BnGNiYTg2O4iTv+kGboSQlv7XeOrZdosjHnOkpqGdUomNm2b8xvV9JiVzekXNku1ir5DTKSuur8K6O1tT5sw+FL6Ax62c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWUR/4nt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3050CC4CEE7;
	Mon,  4 Aug 2025 23:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754351615;
	bh=mYMLftyAT8QXp0pXfjxxCAHPluo5qRTQ7BK2PGulMz4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pWUR/4ntzrt6aPvlJU/A+kV02XbL06YkOXCFeip1pO2r5EUlZtBfbYzGW3Vl26ynl
	 Wa0IzrzM7ZWNkusbsSNJVNlOLYwK7ZDxmtoYSGOZe/qUkiCVG8Bq4KA6sUP4YbTP/T
	 /Q8B8q2U2Uks1t470+aHmQhDhHGx0B5z2bESefhFozpEGRD2l1Xbz4H6RJyGN758f1
	 FamAGY2z9pYWhYVce4Wl7KPj7Eg+Xw7B4eXAbYp53m4OGETwPl55g4iuHma3KkZZO3
	 r63AATYAzaZ3Ls3QEzsrjBrBBtxcNP2HfQoYYXENEqx7Y0doVuZc6+DOqZsPushyW4
	 n3VCEhwKkeo3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE189383BF62;
	Mon,  4 Aug 2025 23:53:50 +0000 (UTC)
Subject: Re: [GIT PULL] f2fs for 6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aJEosjoG_mD0OgwK@google.com>
References: <aJEosjoG_mD0OgwK@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aJEosjoG_mD0OgwK@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.17-rc1
X-PR-Tracked-Commit-Id: 078cad8212ce4f4ebbafcc0936475b8215e1ca2a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0974f486f3dde9df1ad979d4ff341dc9c2d545f5
Message-Id: <175435162930.1391353.4549206550965638397.pr-tracker-bot@kernel.org>
Date: Mon, 04 Aug 2025 23:53:49 +0000
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 4 Aug 2025 21:40:02 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0974f486f3dde9df1ad979d4ff341dc9c2d545f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

