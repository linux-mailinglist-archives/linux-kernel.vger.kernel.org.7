Return-Path: <linux-kernel+bounces-724254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C018AFF08B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E2B178500
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DF3239E83;
	Wed,  9 Jul 2025 18:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzPlKGvC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB5223959D
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084590; cv=none; b=jH3iWiFY10y+7UjrZVVDfi538s/Yy3Oin3glMaqi/qclNzbC7QVJouysg3Uc3QEvFQPQoI1Wm4INJZy0NY8WAiaB/zHbHbyoJAVnkYOjMEhZB/jJDX+Jf2vocxm6HFFJH2uegcgLLRpfspVgsbpjjNsHZfDpo8DB+PwtbUVeIgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084590; c=relaxed/simple;
	bh=qtyAN7Bob3SIVjNlHPMQVn0lrcTTxnFfB41foDJISKk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m22qeaMlHkgaop1IiqiRq5kWPEXKbMk3DhBBIvM7EEvNpu1noiULy/F96TBY+pND1vYEypYs/7xsC5lJp7/1e10fqkORQ/Xpx8/bUqMDUpgUIXLKawftrQMiA/6EsZc/+NTf1AUywBL+U+PnQCTQS6J95TzS3m8HsAymlIsXP2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzPlKGvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1238C4CEF0;
	Wed,  9 Jul 2025 18:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752084589;
	bh=qtyAN7Bob3SIVjNlHPMQVn0lrcTTxnFfB41foDJISKk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CzPlKGvCIxHIs1GY12sNYFpmu0W2sAiDAfwDSTV20sSj5o6eRjeH0zL3NoBTdmILE
	 x5jTKbSLy8pUdGEdFcfd76TTfxkX8BoqPDFOJC6XUKgQcSXY0UJ7yoc6t/3Sr9cQ5a
	 i8ZXNiDZSMAAGqcCZl/rRmWwRQ9/qUzeoiTWkxk0ArCz94s+OKnJbcT5RNMQ59OvwG
	 zd2Z/JU3ix6U/c//vM0FWuqa5NXSi8nG7qD6BU1mQd5GpTm4cjfVKxRnX0+mi+EfJB
	 5R4V9OyWz72ztt/X+MhOhFpQxi42s9IpssHOhCOhj2XpyXwuULxEDHNZrLzvFZtrjF
	 jj10qg0BWF5Tw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71B56380DBEE;
	Wed,  9 Jul 2025 18:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v5 1/2] f2fs: convert F2FS_I_SB to sbi in
 f2fs_setattr()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175208461224.806926.6216509429033190385.git-patchwork-notify@kernel.org>
Date: Wed, 09 Jul 2025 18:10:12 +0000
References: <20250630095454.3912441-1-wangzijie1@honor.com>
In-Reply-To: <20250630095454.3912441-1-wangzijie1@honor.com>
To: wangzijie <wangzijie1@honor.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, feng.han@honor.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 30 Jun 2025 17:54:53 +0800 you wrote:
> Introduce sbi in f2fs_setattr() and convert F2FS_I_SB to it. No logic
> change, just cleanup and prepare to get CAP_BLKS_PER_SEC(sbi).
> 
> Signed-off-by: wangzijie <wangzijie1@honor.com>
> ---
>  fs/f2fs/file.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Here is the summary with links:
  - [f2fs-dev,v5,1/2] f2fs: convert F2FS_I_SB to sbi in f2fs_setattr()
    https://git.kernel.org/jaegeuk/f2fs/c/90c5ce37adf0
  - [f2fs-dev,v5,2/2] f2fs: don't allow unaligned truncation to smaller/equal size on pinned file
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



