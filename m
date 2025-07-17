Return-Path: <linux-kernel+bounces-734489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 891C9B08261
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 03:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9BDE7B2791
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 01:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B367E1E9B31;
	Thu, 17 Jul 2025 01:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUdP0p1L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAF71DC9B5;
	Thu, 17 Jul 2025 01:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752715797; cv=none; b=PxL2IV5zUod4YNr0RLBUJ4YBDN7bmkcZDqKzWQQCQkkBoJF5e9CZ1M0PHlokPwVhS4mTlbg/6RxQlK0/W4Nnrl5qKPoe5UFFcbpwic3Oq1GphVfe+T3rs94kCuxTABJcOJ+rtY86V8YM5DE2kNHDYMxpg7jB9l6dC0j2gvALjNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752715797; c=relaxed/simple;
	bh=CDZJpixjt/dVifw+toCvtL45xMQpY9RXuOW6iUPvOfM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VF7yyECwcORBMxgJM3LTIv0GORO1Bn7t2EEeYmdQ9w3ma0kPXOPlsqN4Fk6Bfc7eUIRvsf4hJyj8HEneeJFEardKyfqpeX/qQ7HBbcgbN9chmO1gLRdKh2TGtLd0/OxqoHMNdaYklnXQTUvLpNsDfjRxmwwZWvDvh0eUdllGT/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUdP0p1L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FF7C4CEE7;
	Thu, 17 Jul 2025 01:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752715796;
	bh=CDZJpixjt/dVifw+toCvtL45xMQpY9RXuOW6iUPvOfM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eUdP0p1LKfhBHinJrcoI0Tkoogogsl/3olXBiFYzG9vkdb2AgsdSnuJp3QL5yY6Ux
	 2nJCJw9dKOySnNVKR27Qq0NjBmCI/jAdEBUfylFp0xDV40kOfkZrZKmaKTeXFh7jYu
	 qgdng8Qn5MxG2vaxjSsCynN53s6QCgsS+05sZ+AF2lTirE/8aqg6ypOcST71eFPc8m
	 lVvR5vRHffKysX8tPtXF//JQiMuW0pDtr3q2qO0hTJ6fqrQTeQJ7xD7KC/4E9ENG9X
	 gBCknR4NC80UY1tvAXMQsPvsyInTbWjzWNXRvg1j0s9135AAcNssfyUf+0bbVkU0rg
	 Gtg2gDpT52d6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADDB383BA38;
	Thu, 17 Jul 2025 01:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V3 0/2] net/mlx5e: Add support for PCIe
 congestion
 events
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175271581674.1388574.10952693075417805401.git-patchwork-notify@kernel.org>
Date: Thu, 17 Jul 2025 01:30:16 +0000
References: <1752589821-145787-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1752589821-145787-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, corbet@lwn.net, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, dtatulea@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Jul 2025 17:30:19 +0300 you wrote:
> Hi,
> 
> This is V3. Find V2 here:
> https://lore.kernel.org/all/1752130292-22249-1-git-send-email-tariqt@nvidia.com/
> 
> Find detailed feature description by Dragos below [1].
> 
> [...]

Here is the summary with links:
  - [net-next,V3,1/2] net/mlx5e: Create/destroy PCIe Congestion Event object
    https://git.kernel.org/netdev/net-next/c/ab2b0d4d6394
  - [net-next,V3,2/2] net/mlx5e: Add device PCIe congestion ethtool stats
    https://git.kernel.org/netdev/net-next/c/8890ee6dcf6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



