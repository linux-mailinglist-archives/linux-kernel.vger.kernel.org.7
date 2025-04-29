Return-Path: <linux-kernel+bounces-624049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CED4A9FE40
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 02:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D9F5A295F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 00:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894E313B298;
	Tue, 29 Apr 2025 00:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4UflE2f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EE170813;
	Tue, 29 Apr 2025 00:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745886594; cv=none; b=HUlFcg/EugfCy+ygUkzmiufOUTiTCSHinNnxcKsueoUoQ2N7PoQZEO4ZbtNqiO6tHlIhs5VInJBCnaN8LhwXqnXkjgEsRtx3Q6gnsmJh4CqqW8MJ9hW4ugnNeizNDNndFwihtalornsjRBDg1/gzJdDPSiqSKT0PQNNs9SzOMxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745886594; c=relaxed/simple;
	bh=7G/4+ZwdVW80/JR5jYpDnZg/3pGTGzhq2K2RoaLu6oM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ao3xWSq+Rz1WJ5Iv1fTXmdfw0fR+xxl3Y5qwYFO/yXUYopHFB+tLiFs6RStvPxU1CadcoQog9hyjLYDYyl0AobGYbMi+d+RIBgFLKbeMpW8lnSmAyHl8217K79BuOVbUeGkAx/zzg9gG6WYu9Xi5Eo1D9TeST2HI+5kmopbmxFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4UflE2f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51EE8C4CEE4;
	Tue, 29 Apr 2025 00:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745886593;
	bh=7G/4+ZwdVW80/JR5jYpDnZg/3pGTGzhq2K2RoaLu6oM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V4UflE2fEEpiEutggcEPJLCbQHNpKIsOnDYbdfBgPQ4HyGsT08ZbsOcZBmwU2ct5g
	 V2+7Um3LnJsL8Yqu7LTgIUPd5n+AKTpyAlG9e4ajkm8hbp9KF4g7n10azRowJHxhY6
	 UgpZryUq6C7xXKH4qhbs1hjQZJBuuQyc08LQ/WogClxqVXLbhGY563dK0cVq1/mgHG
	 UO7aDyeZ7D0xVEiG4SHkQH9BvsEPNAaiYeGWak998xFVHIxqCBt8mgSlMMYz8jzVbc
	 ZfXrbKI7WtEZbaqKPei1+qA6uSBH9CuoXgyUivloagCV1Q4qShFTfzqsazYxgt+bC0
	 m/bJEh8aMyLmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CCA3822D4A;
	Tue, 29 Apr 2025 00:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tools/Makefile: Add ynl target
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174588663199.1088650.11736024159812631657.git-patchwork-notify@kernel.org>
Date: Tue, 29 Apr 2025 00:30:31 +0000
References: <20250423204647.190784-1-jdamato@fastly.com>
In-Reply-To: <20250423204647.190784-1-jdamato@fastly.com>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, donald.hunter@gmail.com,
 liujianfeng1994@gmail.com, kwilczynski@kernel.org, haoluo@google.com,
 tj@kernel.org, bhelgaas@google.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Apr 2025 20:46:44 +0000 you wrote:
> Add targets to build, clean, and install ynl headers, libynl.a, and
> python tooling.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  tools/Makefile | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> [...]

Here is the summary with links:
  - tools/Makefile: Add ynl target
    https://git.kernel.org/netdev/net-next/c/a427e7f99b71

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



