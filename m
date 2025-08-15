Return-Path: <linux-kernel+bounces-771200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EF9B2840E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E277C162318
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C79D3101D6;
	Fri, 15 Aug 2025 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2Vw1mua"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF583101C8
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276011; cv=none; b=DmYkTDsXaxoSaBRMRkK8hInFBUy4L/DtHohu34Vfa1n/BZW/4BZIWbOpgNzYNoZXxAcl/WcXlzwLT5vQr23MSEpMGS5dgIBA2AZAjVuTmVaPKeqz71cGFH3kiAhqzdSGxlDb5ZPMswFHFdZSmRv9DmriuPu8tgmTfKhraCbvVp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276011; c=relaxed/simple;
	bh=7+LOQoLikyi18MadAlEPOle4980wKp4w/1YuWDRWYmc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lwC/jQ3efk5vsLfQ72LwAPfNO3mzRlZfjf4dDwMGy/Ydjh/NLrzFGUwOPxk7yqCtLug1WwueVs/N1zJID1VZrnor3DMT/SP2j+We/mMQezU0eSydiWX0gA1bHpu+LtB2mvyDgXyiDTlLjuENpTalVCKORgX9cEHA0U3j+JOIwGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2Vw1mua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621E8C4CEEB;
	Fri, 15 Aug 2025 16:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755276011;
	bh=7+LOQoLikyi18MadAlEPOle4980wKp4w/1YuWDRWYmc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j2Vw1muaTRl4q6chHJR0Wukm/m74RlWfEVjGwMQYZgFPn9CtkNie65rdpaIWAC4VO
	 vk8iQ2KCZx+bTK3OZ4sJGbmFdCxD1rOdKNKvr388u1hhRDg/rvZwopVPz27IMb4Rlo
	 Md5o69HCoHhz/pewPwLJF80Y8OviR/kfq+0uTg+8hoqV3GSZ7hbKpO9LVfnvRLfOdn
	 FuBClfXuEoK5McBl1HDPb08xyLlP4tjrohKX6WdEPGRR2ptI6c9ZxqoJmjz3SWAvNN
	 U0DVB6sBJ9TCi6o+w5rSNZZczReNUsXUSAMK1OlBpxf61KAH5Z7uJdvwMnbhU6g4Ld
	 aiLl1jZss2ZtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBB139D0C3D;
	Fri, 15 Aug 2025 16:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: dump more information when
 checkpoint
 was blocked for long time
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175527602223.1161945.8969283986568227588.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 16:40:22 +0000
References: <20250731053405.1127197-1-chao@kernel.org>
In-Reply-To: <20250731053405.1127197-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 31 Jul 2025 13:34:04 +0800 you wrote:
> generic/299 w/ mode=lfs will cause long time latency of checkpoint,
> let's dump more information once we hit case.
> 
> CP merge:
>   - Queued :    0
>   - Issued :    1
>   - Total :    1
>   - Cur time : 9765(ms)
>   - Peak time : 9765(ms)
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: dump more information when checkpoint was blocked for long time
    https://git.kernel.org/jaegeuk/f2fs/c/3fcf228b6494
  - [f2fs-dev,2/2] f2fs: add time stats of checkpoint for debug
    https://git.kernel.org/jaegeuk/f2fs/c/57e74035ad5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



