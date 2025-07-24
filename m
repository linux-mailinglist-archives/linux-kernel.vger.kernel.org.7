Return-Path: <linux-kernel+bounces-744908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCA8B11260
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDC265812CA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F882D9EE1;
	Thu, 24 Jul 2025 20:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PY4mg5v7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E43291C17
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 20:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753388993; cv=none; b=YUhRr+bM5ZBFQRkLh/jtnKgtxZYUJZvHmfituLMksXlOigs4DMfguwNleuECDS4cNOtsP9iPoBzKgsM60mHdk4Atlob+kRWOq2LIFscVO6rIv5bHoQviqx0cD5nJJ7jXPVtdZbYECEhVfEFynrd1VPRF7hdxXQY2J4Qa/l61Zgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753388993; c=relaxed/simple;
	bh=BZpbmUrqv5U1Lw5E78QhNGYMQWS5dqtWVkYTRYBinaU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UAvXb22m3/L6sn8J4ckrtOzgTxLiuG5v13EkbW4rHe9QnevOUyDKDBZGGEytk3FXoyGMg1yCvJ5Mtp5vNuxRu4bTjgtpimxoynS+Ory3Ohu3MlI9EFNxmQPr9x2CtneCZkeefs9qs0C4yCqKaN3fCmbNc1kqJPEYjDbYsA2RAb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PY4mg5v7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64501C4CEED;
	Thu, 24 Jul 2025 20:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753388992;
	bh=BZpbmUrqv5U1Lw5E78QhNGYMQWS5dqtWVkYTRYBinaU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PY4mg5v73VvkCedsRsFwhKvzFW8s37UvJI5cApze9k4JR8ik8IJ5rqaPgsFR2ocDG
	 HYXV64XQjXedHEzOlOO6twfMc9++HgjIQpmK74hKoGeTmM3ByiZ0XiDh81ckE7plJ8
	 rotc2ZO4xj+2RPx9rYwOZaiQU1BP0Y/W1lT3sBHHn+uzpSk1CU0T9a9HMyYeVxC31I
	 yj9dsOKZ2jLVyTOPkObBdZj3tdV3Ub+FxU8O/3W1ncQqQNr8MPTR1tizl6NnjLVvJo
	 ZIGj/Y7HjoqGmwCVSr4usb25hLBEu8hxt1zh09nkPzrq4s+sDsQksDQnUVmwoBUx5W
	 FBLczeD23r1ng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D0D383BF4E;
	Thu, 24 Jul 2025 20:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: merge the two conditions to avoid code
 duplication
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175338901026.2519964.16198621184448578981.git-patchwork-notify@kernel.org>
Date: Thu, 24 Jul 2025 20:30:10 +0000
References: <20250723145837.187089-1-masonzhang.linuxer@gmail.com>
In-Reply-To: <20250723145837.187089-1-masonzhang.linuxer@gmail.com>
To: mason.zhang <masonzhang.linuxer@gmail.com>
Cc: chao@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 23 Jul 2025 22:58:37 +0800 you wrote:
> No functional changes.
> 
> Signed-off-by: mason.zhang <masonzhang.linuxer@gmail.com>
> ---
>  fs/f2fs/gc.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: merge the two conditions to avoid code duplication
    https://git.kernel.org/jaegeuk/f2fs/c/b93bf64e349b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



