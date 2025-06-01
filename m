Return-Path: <linux-kernel+bounces-669284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A096AC9D95
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jun 2025 04:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68CD43BEB86
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jun 2025 02:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A241BC2A;
	Sun,  1 Jun 2025 02:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTUP+Xsl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A4F2DCBE2;
	Sun,  1 Jun 2025 02:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748745959; cv=none; b=AqwBuHTJjMWtMFEKr6iarIs7m6f0JPgFAOS3kDd2yaM9fqC168PBoPTZ7+8QrULeHoRW9QC3zT5tfEHgt4WQvT9pKEJRkWzyq3Bi8BZo4aS5OdttX0kXnj7yZ6b2xnWzdnMqNEu7T/QSb0fqUff9Gr6f6BCypAUW4Nh5eQDyjPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748745959; c=relaxed/simple;
	bh=zBiuqhh/LJZyz4fb2suDDFeazmxpqx7uWyLWaOTLLE0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lTq76D2u6MUTIHSYmIBbSAmTGNDcLutLRjcn0eTYDNhBFSyuT715y1nOZH6Dv1QUZy1Ltpi8lW9Zbler7WR4a9bRxfEWcUGM6I+kRQyUpV3UStoWNgYoFkHLcIMLUiXTQRradWanv0ePa+EUsxrQXHjXAFIAvEw9fRMCMDDnY3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTUP+Xsl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0D3C4CEE3;
	Sun,  1 Jun 2025 02:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748745959;
	bh=zBiuqhh/LJZyz4fb2suDDFeazmxpqx7uWyLWaOTLLE0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DTUP+XslB52kw9ry9gWkkZyFjb8JB9IDNjbLNF66GY+SPxeuNV1BJswHyMfUrlieU
	 xr9vCUMRIbJJYLL8l24LZp30y2dDaDZI3I+b9Jvkj97z7Rr62k5NYaxKM8/BOQHC3N
	 vKSvX2VASax9bVT+It7oc690tETMs35bUSsI3WhoSf2s+oSF+3k8rHYoQWONdvDHbp
	 aaGj7QE/epHPnbC5OSaeni1HzRnLYampd5Op/42azSq/1g2/zCN5eIL4TN7oHVfUvs
	 hSSre37UXtAScBV1niqiV1TXn0CTa+42jrQd/pXU5tQrmJvnQ9Ml8ZQUrT1Bq3gyZa
	 b3p/Rd6fUGtZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB38F380AAD0;
	Sun,  1 Jun 2025 02:46:33 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev updates for v6.16-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aDs4uwcxU_M4mpVE@carbonx1>
References: <aDs4uwcxU_M4mpVE@carbonx1>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <aDs4uwcxU_M4mpVE@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.16-rc1
X-PR-Tracked-Commit-Id: 05f6e183879d9785a3cdf2f08a498bc31b7a20aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b42966552bb8d3027b66782fc1b53ce570e4d356
Message-Id: <174874599246.296823.858848517798857863.pr-tracker-bot@kernel.org>
Date: Sun, 01 Jun 2025 02:46:32 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 31 May 2025 19:13:31 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b42966552bb8d3027b66782fc1b53ce570e4d356

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

