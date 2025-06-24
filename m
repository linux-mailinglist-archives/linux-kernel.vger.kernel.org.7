Return-Path: <linux-kernel+bounces-699340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 587D5AE58BC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 02:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C23617B1D45
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 00:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91F7229B2A;
	Tue, 24 Jun 2025 00:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiqjhOvf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DD9224893
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 00:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750725635; cv=none; b=G/dZILP6GAIndYcmTB/yhA4fqS6lVGmmDbqvuaEBnywg2wgfkhspxux0qo7J7v4DmHd8LMslCCtOO6waSWFXRxe26FzTJE9mwP7cXiA1HPF5o4vQES1pGvMCvwkKSue31ioFE9/jc60461rZVgHHwvQ7nfVXY+zyhHAHCf2qUBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750725635; c=relaxed/simple;
	bh=1QaGdT1B3rkESvxrLYFCDis8gtHomEyLyKP9dJD4WTc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M5AGv/QBKTEcA0U1vTknY/pPF3ThGYFJ2QE8SL2CdDSepSCrplcq+5f3ZXJKo1S+nTSlYr+ymcy8DgTeN7pRzNrTOKnbBptPyfza7XWI4lbUtNSwozRX9+m0lS+4vW3uBBQ3CFEc/vCvWGgfpYY++/FLxy8AjA9Z5JX7klRQZB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiqjhOvf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A8BC4CEEF;
	Tue, 24 Jun 2025 00:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750725634;
	bh=1QaGdT1B3rkESvxrLYFCDis8gtHomEyLyKP9dJD4WTc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SiqjhOvfP/t9KHGcnRs/HkQukfOxDwgi3xvScwaH9kDQQEtXY/cVAlLwSZr0irtUJ
	 9F2JoSZMSoxNCvNq6jTq2piUP+JZJRdk8Wp5glKrQNah054f9mHBt8J75aj4MyMKF7
	 Ibx5+JOn/Hn60uzg8o+rVVLCpoJfflYEBJ4aTLuKhcU2FfU/i5FkoJZV013wSjiDFO
	 rOCMZk2a+Gnhyn2O7bBjXAQl7D+b42uLpr8+LvTZG9MWiBXDwkFlf2DcZv7g/xxIKW
	 iehPqJCW420ZPvcDTkOieqoUZDm3+ymbTgKNeA8S8qOcpcDYQS/xOZA8IAFZEBdFrd
	 O7//jb24whb6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF4A39FEB7D;
	Tue, 24 Jun 2025 00:41:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: compress: change the first parameter
 of page_array_{alloc, free} to sbi
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175072566148.3346761.3757288798816544278.git-patchwork-notify@kernel.org>
Date: Tue, 24 Jun 2025 00:41:01 +0000
References: <1749779445-29125-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1749779445-29125-1-git-send-email-zhiguo.niu@unisoc.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, ke.wang@unisoc.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 baocong.liu@unisoc.com, Hao_hao.Wang@unisoc.com

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 13 Jun 2025 09:50:44 +0800 you wrote:
> No logic changes, just cleanup and prepare for fixing the UAF issue
> in f2fs_free_dic.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Signed-off-by: Baocong Liu <baocong.liu@unisoc.com>
> ---
>  fs/f2fs/compress.c | 40 ++++++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: compress: change the first parameter of page_array_{alloc, free} to sbi
    https://git.kernel.org/jaegeuk/f2fs/c/8e2a9b656474
  - [f2fs-dev,2/2] f2fs: compress: fix UAF of f2fs_inode_info in f2fs_free_dic
    https://git.kernel.org/jaegeuk/f2fs/c/39868685c2a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



