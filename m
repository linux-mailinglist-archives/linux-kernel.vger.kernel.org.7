Return-Path: <linux-kernel+bounces-662064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA31AC3510
	for <lists+linux-kernel@lfdr.de>; Sun, 25 May 2025 16:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44CF917468E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 May 2025 14:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE86F1F4CB1;
	Sun, 25 May 2025 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vN4uDnFr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ED21F463C;
	Sun, 25 May 2025 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748182208; cv=none; b=bquXzeHBlsgulSNPdylDctWxn4JZgpnf8rDrQXAviDSQ4TOS79F0zFcGJGbtV3BWFFgVY3O9rEh8bIrInqaTWFqpxrVkAvdSXUvX7nSoKVBeaa6sTGBV/9nuC/zHuwBXAlo46fvvXs3QH9LiC+wkQagxM3BOYANfZe3UGpmE5ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748182208; c=relaxed/simple;
	bh=A6JdPCfNNVlTjf/P13KKpdY6Inlbxpzb7Cr/udIBNo0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J1/p1tyler8muWALK/fqrgAHKe2aOkUpv/6gQrSuQWqaFACEsdP90HRwgG9DEYTcxoU9KUkKU6GjZC+r5RK2vpwuPqVmA03kLE7TkcjLLPpqmWwh2YRHIQBcBQLLmGkWFHL1hG9MBqRoRDSgEGBSTNBRnZj2kxYJ40+aOAGM15M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vN4uDnFr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4655C4CEEB;
	Sun, 25 May 2025 14:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748182207;
	bh=A6JdPCfNNVlTjf/P13KKpdY6Inlbxpzb7Cr/udIBNo0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vN4uDnFrV7GalNuQPqYVkTyO6K0xXbESzKRs6dWz01h7J8KgqTgkpzmIuVSe4ZerQ
	 zsrTmq7wiursx9lRuOpUoZ6zeYXyvt4PKSiZYif+VW2b8W6E7S5oofv7lvOnK9FhK4
	 oKust9/4uYoRwO17VzkEq+uSWsKUeZNUFRhtIbTSmVBxLCTdglTulKbZJWEzfmFfip
	 HiSiFeR5+CWjNWQ6IT9vW3E+GUPK4R+7Djla7OqfkqCSdSVCiVlAXxRCaFxAGse/Ve
	 VYnZvQASU40N0HSkVvJL8Hz2ndIEsmGhGTwZ7sOEb9hv3QsqnrqfFGadf6dwCPPYkM
	 c/L8ufpQzfdKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEF6380AAFA;
	Sun, 25 May 2025 14:10:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next] octeontx2-af: NPC: Clear Unicast rule on nixlf detach
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174818224274.4147910.3733595468697864340.git-patchwork-notify@kernel.org>
Date: Sun, 25 May 2025 14:10:42 +0000
References: <20250520060952.1080092-1-hkelam@marvell.com>
In-Reply-To: <20250520060952.1080092-1-hkelam@marvell.com>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 20 May 2025 11:39:52 +0530 you wrote:
> The AF driver assigns reserved MCAM entries (for unicast, broadcast,
> etc.) based on the NIXLF number. When a NIXLF is detached, these entries
> are disabled.
> 
> For example,
> 
>          PF           NIXLF
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-af: NPC: Clear Unicast rule on nixlf detach
    https://git.kernel.org/netdev/net-next/c/bb91f7547f79

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



