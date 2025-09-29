Return-Path: <linux-kernel+bounces-836834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAF3BAAAFE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 00:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D11787A433F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 22:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2BE1EA7D2;
	Mon, 29 Sep 2025 22:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzLyu33Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A4B158DAC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 22:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759185027; cv=none; b=K8clFHvLSXP09lJ3Ws63j29fPdga//sJChlloh7UeSTpCAeDawBMvu80qOALWXtD6/LUjRQmA34/oRGM4426sGAuEFtD0BVr17tHsHcMJQIMau7QOOZur6lbXejQqyEvluOBx/01Ae88ENoiufscDA8lurCMuOXCI3VNWq927fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759185027; c=relaxed/simple;
	bh=yKPgLINx6rQbQbu2rBfYvO4HKLsgtmUQUDYDyamD624=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YbujVIulWcU5/WYtMaypHpjoDuF6c8TyChRnH1iBlVKQ7TA8ZqFesyvtduZ2mwaRVqS8BfI/xARcTf92cbPBXcN0SdMmVTw24TS/hTMo2Yet6pJ/3JnSC8wHhyXdc+QQLQ8TmWL38mWzMH3grBD0WKuXMT/rHrcY1KTzvI9aYik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzLyu33Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C4AC4CEF4;
	Mon, 29 Sep 2025 22:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759185026;
	bh=yKPgLINx6rQbQbu2rBfYvO4HKLsgtmUQUDYDyamD624=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GzLyu33ZQkDQYV5tlnTGp1sB4o7Yp25+j4vZNGAxHUJapiXOZtl3p13xFDTzUmQ0O
	 haSn93VvH5iREzOlZqKJOcesqeI0lNLLpVz9neREIhy4Iq2PYVc1WibUDUPbjS3c8x
	 h3GjZgoqXY1XfSiBfaHbGHtMyrN7mc+pWTwqkPiQzFDZEH0DN04RIsAuiF9Vhyu2cJ
	 0c+Gi2zMwNoQamvNvV+ZL23daFLHu1bB/GrHAt8vZPBBreTnYNrfmxTvNMaatUMySn
	 wUMn1G3/Y2irwpeLCRUkV7vdo0c2Mx07lUDzlSQLdOvjfkESIbxtP+7nQU1Jufmo2C
	 sflmkIsNs3UBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B0439D0C1A;
	Mon, 29 Sep 2025 22:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid migrating empty section
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175918502025.1733438.16761795407237847575.git-patchwork-notify@kernel.org>
Date: Mon, 29 Sep 2025 22:30:20 +0000
References: <20250901020416.2172182-1-chao@kernel.org>
In-Reply-To: <20250901020416.2172182-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, daehojeong@google.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  1 Sep 2025 10:04:15 +0800 you wrote:
> It reports a bug from device w/ zufs:
> 
> F2FS-fs (dm-64): Inconsistent segment (173822) type [1, 0] in SSA and SIT
> F2FS-fs (dm-64): Stopped filesystem due to reason: 4
> 
> Thread A				Thread B
> - f2fs_expand_inode_data
>  - f2fs_allocate_pinning_section
>   - f2fs_gc_range
>    - do_garbage_collect w/ segno #x
> 					- writepage
> 					 - f2fs_allocate_data_block
> 					  - new_curseg
> 					   - allocate segno #x
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to avoid migrating empty section
    https://git.kernel.org/jaegeuk/f2fs/c/d625a2b08c08

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



