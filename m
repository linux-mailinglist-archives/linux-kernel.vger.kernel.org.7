Return-Path: <linux-kernel+bounces-840762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A28DBB5393
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 22:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366D919E7DFC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 20:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACE22C028E;
	Thu,  2 Oct 2025 20:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2F6ycf5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A103A299A9E
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 20:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759438216; cv=none; b=ZOfIilsFAOO4BGbYo7CYU3RjqvErNUHrN1TvolIcv1xfYkVDLGL78Pu6pL16jj8tvZbR1IPyXGAj5ayM/fO4oToxYDykF9g+uRRTvqmNcO3vAB35RJY3XJKs8D/SofNNWMCMQ1I58o/j5kTEYf73XlDeuYKNq+O8ACPDHtVmH1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759438216; c=relaxed/simple;
	bh=dWaLZLlgwysF2Co+urXzVTdaa8JC6sE5XfuYvZ5vCFc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bgiDey6TndYjTFNufc2OHsqDysVOca6Z4CTuSopAiv6e/1zH1Egrn6oVheTyiqJopGzHBQiW+Nx6qJCeQStEtafNHFPbn94eXhYoK67ImIadWyfEAUKqfBKcg++GJ+zgaEu0/di1yp8MG0hwNXyhSL8tgOLlBPRWjBF31LhsczM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2F6ycf5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34831C4CEF9;
	Thu,  2 Oct 2025 20:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759438215;
	bh=dWaLZLlgwysF2Co+urXzVTdaa8JC6sE5XfuYvZ5vCFc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k2F6ycf5C41WDi8otHClr720iKpFJ/6r6F181Cg1YbRjlpUWaP73XQj85TiIw3sMD
	 KrXOm4w0swxtpbaDmxffdFxZUNd+JZo8pwiq9qsMxlh+40suZf8h207wn+aEQYFhyx
	 oehWuUb1K/fNR75T8f3PHYjdqlbF2lbNixSNWyMME8MhGxCN5syD8nNQk/w99Okiz0
	 OTliSiHvt3/IgiMiS6a07wVeLzKTWZKUA598kY2hPCFGJ/aQbRHzduWyT/Q2iyW/fq
	 Sx63ZeW3v1dK/7QCvx3Ooq4pr+WdDJCugE6Kgw+YdX0ySMr7dJ8GYF8nTFNeMu/Tbj
	 +dfO6jAZCm7Ww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 344FF39D0C1A;
	Thu,  2 Oct 2025 20:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: add missing dput() when printing the
 donation list
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175943820701.3449937.17994967060851018856.git-patchwork-notify@kernel.org>
Date: Thu, 02 Oct 2025 20:50:07 +0000
References: <20251002015645.3588322-1-jaegeuk@kernel.org>
In-Reply-To: <20251002015645.3588322-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu,  2 Oct 2025 01:56:45 +0000 you wrote:
> We missed to call dput() on the grabbed dentry.
> 
> Fixes: f1a49c1b112b ("f2fs: show the list of donation files")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/sysfs.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [f2fs-dev] f2fs: add missing dput() when printing the donation list
    https://git.kernel.org/jaegeuk/f2fs/c/e34b65fd0c7f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



