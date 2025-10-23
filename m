Return-Path: <linux-kernel+bounces-867646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3FDC032EE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 21:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 113064FE61B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2311334D4E6;
	Thu, 23 Oct 2025 19:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUIhoDuK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF481F582E
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 19:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761247818; cv=none; b=flRfmgXrO4Z2xiSX47rXc6RTmkaw26RuylZO4JswVYF96e1E7PPHNFw7DnDrteZMW6oV+6SBBqSZLIMTcnLrpPpBErBWFfHBM23sx15Pmi2pxgrvmm5cIFBJByMEAnArlRqu+TDyixlZmqb6G48bp6kS2UC99ho21SG9ZsyZ45s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761247818; c=relaxed/simple;
	bh=1Y/y50WGOlMTTCe84TsHd3cSHzkic+ceDyTy1PEuEB0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bYKq6jT7nP13MN9GwaVIE72qK5Of8BnVMaaVRdVUCf4XAIvob3gbDnY3WFUx4IV5Mz+OK1LFJMaZ8h00PEYl/IL60v/8CwPucxnHpzdy5qORg0dqKskYOsxTgswmRa7SUPPOg66Vc7e03pU0aWr88i+PEUfRrRnmyoIDmot9PIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUIhoDuK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB458C4CEFD;
	Thu, 23 Oct 2025 19:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761247818;
	bh=1Y/y50WGOlMTTCe84TsHd3cSHzkic+ceDyTy1PEuEB0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MUIhoDuK7B4rZJkHrfifPlenhu6hmntNgG3yzDALEFw6MthvzoT7/o4SEDuz9fh5c
	 RD26LeYyZRct6U3+PchMy556cMcviZKUbOdyzloNZlDn2yIlnB6/gW2ndk88XDpF6H
	 FXmOe4Zbj3uEseEi6JwH+AWG0aqnutlIA/ZzlgIgMiZeQNuIzmb9RZbcEnT/eOE3Yq
	 W/l1soQbw/CovGBFQDIV0cMQniHUD+Lan3Q0baXVEMqKsD9CdH9sL+AGpAHRT+GPnG
	 +3kV9Xkc2rNTjgEHCDyGxDZU/pOoqhDO3r3MT1v/uh9EX89OmtVoUOgl/Pbvn4txzf
	 FupU7reIWqexA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713F6380A959;
	Thu, 23 Oct 2025 19:29:59 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 6.18-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <aPptJe8qXOGO-lGt@arm.com>
References: <aPptJe8qXOGO-lGt@arm.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <aPptJe8qXOGO-lGt@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: b98c94eed4a975e0c80b7e90a649a46967376f58
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 266ee584e55eed108583ab4f45b5de734522502d
Message-Id: <176124779801.3220186.11968346054917749523.pr-tracker-bot@kernel.org>
Date: Thu, 23 Oct 2025 19:29:58 +0000
To: Catalin Marinas <cmarinas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 23 Oct 2025 19:00:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/266ee584e55eed108583ab4f45b5de734522502d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

