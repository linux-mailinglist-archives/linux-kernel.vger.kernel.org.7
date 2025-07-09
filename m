Return-Path: <linux-kernel+bounces-724261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63808AFF09B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4DBD487D4C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D73242D66;
	Wed,  9 Jul 2025 18:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3vClbvh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71C124290D
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084601; cv=none; b=LGBPOtQHH2KPWChzQf9M7KJEjQiv+kwKYenKqD6clwrFGLQr1jEeijC+k+DrFSdXTY3JtxOFAhKqPEYHDXx0QOkdyq7O/c+qWl6FglDgoYgifywJcWCgaWRdwt/8hf2Shqwu1vDKXvzilb6SsssGak8nwjaZshvZIDQpEmw8KSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084601; c=relaxed/simple;
	bh=mJ9WqK/8icfLcC6c9p9BYfG6hXc4QbryyxexJn6MkSE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KHGPLlUxrtFmETXPBe4mTDhtH0M/eCEmOZjF/hq6qJOgcppZ+Y5S1u3YsLQHJoUMnjPl6SXGOB3MJUwkubHDu8G0WdjR8sNm6p/0Q+9506O8FUCPVr7H8PLTKkW3P5lWFQ5l0x5dcDRpGl/k+hCRcTnjUDDDhZfTkMIU3hWiY6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3vClbvh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3514CC4CEF6;
	Wed,  9 Jul 2025 18:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752084601;
	bh=mJ9WqK/8icfLcC6c9p9BYfG6hXc4QbryyxexJn6MkSE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U3vClbvhUGqY0+2ckhZ6lW5x4MJHJyEqcmcOLc8AMjhWAtgnUskAeo30Ro1L/cGMX
	 mEfcOoE48coM8UTLkuQVSeVC/aN0YEp51qC5i84fwMhHvzfXkFopk6pm1oQ//OJOeO
	 +QDIMIqnRhI3yC5Kvw4jbFICVBwkrCRgoFo/jCt54zjyOjAXZywBpxAQUUXubLuN7k
	 aPcbqH9xDJZURdJDt3CAzAS8a5KnRR/Pf8LGEWCw32dTDBYcyG2IF8rKSiPd3m48gc
	 584NRZNmrMTBZHa4lO4ASTMkX+XQdjqUg7vENmelpIMf/GIw0nhwTgep6gyWpa44hM
	 dYarRjvAJTYAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB000380DBEE;
	Wed,  9 Jul 2025 18:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: doc: fix wrong quota mount option
 description
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175208462350.806926.12405140086120666669.git-patchwork-notify@kernel.org>
Date: Wed, 09 Jul 2025 18:10:23 +0000
References: <20250702064925.1002176-1-chao@kernel.org>
In-Reply-To: <20250702064925.1002176-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed,  2 Jul 2025 14:49:25 +0800 you wrote:
> We should use "{usr,grp,prj}jquota=" to disable journaled quota,
> rather than using off{usr,grp,prj}jquota.
> 
> Fixes: 4b2414d04e99 ("f2fs: support journalled quota")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  Documentation/filesystems/f2fs.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: doc: fix wrong quota mount option description
    https://git.kernel.org/jaegeuk/f2fs/c/81b6ecca2f15

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



