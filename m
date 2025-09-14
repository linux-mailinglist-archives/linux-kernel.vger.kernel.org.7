Return-Path: <linux-kernel+bounces-815870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB32B56C21
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 22:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E273A7514
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 20:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9391B288C2D;
	Sun, 14 Sep 2025 20:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVz4iAOd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC9D1DED42
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 20:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757881215; cv=none; b=dRMul20VnVYMeNaSNQy3cClj1zpNvIGYV5c9eqzBZW6CESQpg9COkrkOv/C2kFy3T8IhCkhSN2A9ELXkGKVAXefNCUOS0u/Kr92p2tZ039Uc8rJSO0oOYSrA4exbKgcHm81IGCyWDwT6/kyTQDLw3Zj2vaAgsIYm/opjg6y1Aow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757881215; c=relaxed/simple;
	bh=FB+dmMs3Xp4caKsX7zjGfDq1tfeUHDJkEMhYdF9bg+A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Rd1jKxq+ujD5VSOft8kf18OBsLtmKAaLOPuQXDWQ6gidCQgIxAcqmJMC+eERQWbXg7SsI5LwYaDGLPtwR61PTfMtUrliqFhUE+5ZODyDBbeAKRRvOPfP+vH4YtsJYPJGBugda5aibHJuBBcMALaKpa3tESZ8AciT0vaG3nyxbVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVz4iAOd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF521C4CEF0;
	Sun, 14 Sep 2025 20:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757881214;
	bh=FB+dmMs3Xp4caKsX7zjGfDq1tfeUHDJkEMhYdF9bg+A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HVz4iAOdvNcCAjcgt2xu29ZcJqi0CZeXpyWrTvvTFjhrFC7mzrBgn5ViV6sV/TA1i
	 kJhl29Ajq4Z/pU7NUA3hhtEsOeW5UBf36q0NCPVNjDWTXkSejxJQxLf8DgxpWGKQyW
	 qGQI6NgfN4J36OZjQqinTYOCRQnpe8hg8UGtWQkv4tAeBUvtZ4FKyxk0fZyzwwwKcv
	 oOvOaZQ/cik1zVP7BUaQJg6yWDYeGtawis0sH6fToGX5OveZH/OoWCMHxKTxgHJiW6
	 NYUlEKaSmhi19sIO65EtY+/TeQXmuDlf1Z6cOlSchsbp9EJLUBREouXDjKslabUeBm
	 YFxm1mMeNbHBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF8739B167D;
	Sun, 14 Sep 2025 20:20:17 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine fixes for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <aMb7h_VKd-2jMK56@vaman>
References: <aMb7h_VKd-2jMK56@vaman>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aMb7h_VKd-2jMK56@vaman>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-6.17
X-PR-Tracked-Commit-Id: aa2e1e4563d3ab689ffa86ca1412ecbf9fd3b308
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0676181a87540fa2aabc8920dc30bca5071b8f1a
Message-Id: <175788121623.3542944.2710461948191398045.pr-tracker-bot@kernel.org>
Date: Sun, 14 Sep 2025 20:20:16 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 14 Sep 2025 22:59:43 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0676181a87540fa2aabc8920dc30bca5071b8f1a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

