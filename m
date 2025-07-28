Return-Path: <linux-kernel+bounces-748405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0036B140BC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62E6718C24BC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D269A275860;
	Mon, 28 Jul 2025 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+OcY9Uv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CFE27511E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753721405; cv=none; b=nGL90HcOj/kzxxHNnLw1BuegEl+SFovY/+W1LDmqOkLm7r/SwHt+O49IAqWxMPk+W80YdEYqaZof2ktJurZ10KxL/U7c5vCQL7UVw4Ek0Dw5X7JKLyV1ONNaqulaTP3gFtX/jQOYDQmHi3zjGhgheY5W46xLGjr0upgPlo+yTgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753721405; c=relaxed/simple;
	bh=6EutzAVCHjHqKzoHzzGWXqSwBrav/UZGNTmp19cEhVo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZcdxegFr6mGZFWXsP/k0nrkZ2xuIPajeDimmVv1e+2IkyU0QMTW1zfIzL2doH/nq4VcDr1yoZgXoh8XVjis7rEOSy2qlJG9w+MlGvnUHENtHqMQI7rYjT1PJbzgv0BGOeAIplufzRHYVpGSOCcm8/cVOadJikRZfo41/9hxaiwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+OcY9Uv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF9DC4AF09;
	Mon, 28 Jul 2025 16:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753721405;
	bh=6EutzAVCHjHqKzoHzzGWXqSwBrav/UZGNTmp19cEhVo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p+OcY9UvEwd8M1LAOuUhc81Ji3EhbsDoorZ5j/Evmj7hFZDTfY9GXrWehtftycZCG
	 MzzLSq94WSKsSDwjfyL4mhJBLOnWP7aOBdhGhwaCX1xymo4NCGIB7sESWOqeQR6/xV
	 o0XyGu3x1+OLrjW5KJH4CTuHux/lq77e7VOINTHwcFQ/9yL//xRfwaJz3Seeox7c3H
	 oFspvpxhjXBk94L7lRCyM3sGbB4zQDBnoEDyxYE8G9eOD9dL3rxIGqLVhJ3YB52sYN
	 rSWuvkpXiIip+V/AS8o6d9f2+4vqgzTxQwGktUcGYGCMY2cuh55fxWQDuP6YnhxnEv
	 UqPD2Urd52edw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1F15383BF5F;
	Mon, 28 Jul 2025 16:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs: fix to update upper_p in
 __get_secs_required() correctly
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175372142174.776676.8052673774005577055.git-patchwork-notify@kernel.org>
Date: Mon, 28 Jul 2025 16:50:21 +0000
References: <20250724080144.3689181-1-chao@kernel.org>
In-Reply-To: <20250724080144.3689181-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, daehojeong@google.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 24 Jul 2025 16:01:42 +0800 you wrote:
> Commit 1acd73edbbfe ("f2fs: fix to account dirty data in __get_secs_required()")
> missed to calculate upper_p w/ data_secs, fix it.
> 
> Fixes: 1acd73edbbfe ("f2fs: fix to account dirty data in __get_secs_required()")
> Cc: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/3] f2fs: fix to update upper_p in __get_secs_required() correctly
    https://git.kernel.org/jaegeuk/f2fs/c/6840faddb656
  - [f2fs-dev,2/3] f2fs: fix to calculate dirty data during has_not_enough_free_secs()
    https://git.kernel.org/jaegeuk/f2fs/c/e194e140ab7d
  - [f2fs-dev,3/3] f2fs: fix to trigger foreground gc during f2fs_map_blocks() in lfs mode
    https://git.kernel.org/jaegeuk/f2fs/c/1005a3ca28e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



