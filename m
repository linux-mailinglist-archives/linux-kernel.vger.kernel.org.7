Return-Path: <linux-kernel+bounces-896268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 065F2C4FFF9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCAA3189A651
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AC12EBDD0;
	Tue, 11 Nov 2025 22:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gu5GZk2s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8F22D130B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 22:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762901441; cv=none; b=CeftExzBlsAffi1z8arR1aAmu5Zb5AE4M9MIgxnuvutl+lciju0yvwXwJqoL7pWXCn/yoxnSgBeOgwhZvtUu5hi0FDAM7gnW0Rph3TmwmrX89wczAvV/xF6x9jenwUZ2INYd+xG+kGogBd8e5kVeO9XE1wtMxTFjo1V4ru2K7ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762901441; c=relaxed/simple;
	bh=aRhgIOpemWJXGYEkieS9N5M2153rOKFOn0HPq3DvZYg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XFezoe8Aw4BPo1iQPuh757R2gKH7qJypKI2YqxlRBBXOT5Qc9rtH6pavWzJb0myTV4ryl77Ia4Y7gAu5ZFSyFRbgLmpNl2E9BAka5S0G3oSfXcJCirJiDZTHk678ItH9IJu95efErnQmaiCUR5xOB1PupvF6plp9VitgskZWiJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gu5GZk2s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA77C19425;
	Tue, 11 Nov 2025 22:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762901440;
	bh=aRhgIOpemWJXGYEkieS9N5M2153rOKFOn0HPq3DvZYg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gu5GZk2sdFoujBrlMh92KOXCBbvEy5Tf3IWjECLW2jTblHitx357XoGzIIdNWW3Fo
	 Gw/C4USFhzkubdyK2toU/DWXq/5VTRPiXSnb9ZNDAV/fh5XMXLW4UvG4eYo/2qbxj8
	 Kg/eJCw7aZAI6+zFQveH3piuyntqnBflEUe2vbmtLH4wWV28BWGKLudaU79zLBzjbg
	 eiioUOZgeoZXB3X/PNkuZTHRa2Nf/UsGT5AZJwN9VNSD7cfp2zPm09nGwGgWoJJP7s
	 veCfB1Tze+bhcKI96SI0zht8R1Lc0+ZdtcCF8MwzyJn++ToH5nfni6ffugsKAXzWgV
	 uWzhe1Eliwkwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC8F380DBCD;
	Tue, 11 Nov 2025 22:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/4] f2fs: clean up w/ bio_add_folio_nofail()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <176290141074.3596344.11323424525560613552.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 22:50:10 +0000
References: <20251014062704.1734984-1-chao@kernel.org>
In-Reply-To: <20251014062704.1734984-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 14 Oct 2025 14:27:01 +0800 you wrote:
> In add_bio_entry(), adding a page to newly allocated bio should never fail,
> let's use bio_add_folio_nofail() instead of bio_add_page() & unnecessary
> error handling for cleanup.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/data.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [f2fs-dev,1/4] f2fs: clean up w/ bio_add_folio_nofail()
    https://git.kernel.org/jaegeuk/f2fs/c/6862f6948aa3
  - [f2fs-dev,2/4] f2fs: convert add_ipu_page() to use folio
    https://git.kernel.org/jaegeuk/f2fs/c/22de407ee7fd
  - [f2fs-dev,3/4] f2fs: use f2fs_filemap_get_folio() instead of f2fs_pagecache_get_page()
    https://git.kernel.org/jaegeuk/f2fs/c/10005e36127b
  - [f2fs-dev,4/4] f2fs: use f2fs_filemap_get_folio() to support fault injection
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



