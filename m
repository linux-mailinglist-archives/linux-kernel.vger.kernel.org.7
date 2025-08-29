Return-Path: <linux-kernel+bounces-792163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D741CB3C0F7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 043533A223A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E1C33436A;
	Fri, 29 Aug 2025 16:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NX6JbhMw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C4F334393
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485570; cv=none; b=ImkjmOMUBLrrVs4FoumFsj+lrnZ4sa4DyYxnwS7TLhAGghfs28izkueCsvfMtnpV/a5mjWuUb477WJ3jxQwK9k89b2XvOob8J1WNR/AXCYu1Qn0pCJt4i81u98qOju4GagJkNcGh4f733VqVzuXzw8KLOyF1/Es/ao80AcDX+90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485570; c=relaxed/simple;
	bh=XIGv7VamxU9MjgUfmS+z3CQ1G2wAf/0j3V5pZ7uaqis=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OcBETCm/cDu6sAc+F8FsfMNe2g/BPtDVPKu5J6wc7sa57Gm9ni32i7X4MNJlf5MsiOTOEtY6Z+t2Pt1/Koq3VRLG6k39uy6wXCmm90kOr0cGcfSHdp5WA7Opn78CiWWYz0Nga9YCkn7o1wzgkDiFRR2e5ePRyBKenE/+yjPk1Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NX6JbhMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E40C4CEF0;
	Fri, 29 Aug 2025 16:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756485570;
	bh=XIGv7VamxU9MjgUfmS+z3CQ1G2wAf/0j3V5pZ7uaqis=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NX6JbhMwEiNrUXl7YKp8WGBKb+1Ijdb0f+ew4cpZVFSbtRw/cOTvnI66zePP2TWS4
	 8UtDPggxXItKMZfnF5KxjQXtcchiZApMZo4ifeggfV1S1Vczyv2ZEqPB0reic6LstO
	 ofS6YRvBCPVNJKP9eRGZG3wO8lUcCkhnldHVm3rY07L/wd3LuSLzxCyYRri9kvME9s
	 XHvYnpC2kIAOtQVlH9yuXn5daLj6y0lah7cjenNOY7kh+gv2d6nJQhGCdm+aYyewmG
	 1hyh5XmrLbgV9O5QQnBApQVdEwatzDAEDGmjvpHXNcaurWvsvzQcjsA7hDNFWZ/aYn
	 0GXSUVQTFoiJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 354C2383BF75;
	Fri, 29 Aug 2025 16:39:38 +0000 (UTC)
Subject: Re: [GIT PULL] memblock fixes for v6.17-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <aK_qmw51CJz_Tz36@kernel.org>
References: <aK_qmw51CJz_Tz36@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aK_qmw51CJz_Tz36@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2025-08-28
X-PR-Tracked-Commit-Id: b3dcc9d1d806fb1e175f85978713eef868531da4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b9f3b013b33e73c6f8f2bbdc6b3fd87745b40af
Message-Id: <175648557686.2275621.12830998468782656220.pr-tracker-bot@kernel.org>
Date: Fri, 29 Aug 2025 16:39:36 +0000
To: Mike Rapoport <rppt@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 28 Aug 2025 08:35:23 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2025-08-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b9f3b013b33e73c6f8f2bbdc6b3fd87745b40af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

