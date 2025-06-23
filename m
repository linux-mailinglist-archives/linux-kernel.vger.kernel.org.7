Return-Path: <linux-kernel+bounces-699059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CEAAE4D4D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 21:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D50217D207
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 19:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC862D4B66;
	Mon, 23 Jun 2025 19:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNjMMaRx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E962F2D4B44;
	Mon, 23 Jun 2025 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750705786; cv=none; b=Z+8D84KY5JiKmlF4WXs/k6JzBE6j6hqNt8Y/hJQ/WUGcuCpeqQErGNVMDsQlJrrUSpP2zQ71DG2gQuFk3q6939R6HcaTHe/tO5SW+QzGUMairGC/JCl8/H2gf3+8oHVaEvjOaYNOYg1QVF7gL4XvM8BqVFN0xGDb3W7DF/XREjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750705786; c=relaxed/simple;
	bh=KKroE/GRs8M+TWNcBZ9YNCi6qsFXm/QLwQjmNfOmqEY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ows7waJAdpiqFSabBUn9Ex2TtAEJ6YG2AJprFvUOnm+tzL12Ma+Yx+XuS+WwBICnbmDAFvnK3ucEXezYoBUL0HWhDqrtPnVAJO+ymrg8FVhHT+MUOp7lw/LZGUFadfRRg2X4H6ca29RguJop3Hxo0qRk+2jjx2ez/T8jfmAlzA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNjMMaRx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60061C4CEEA;
	Mon, 23 Jun 2025 19:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750705782;
	bh=KKroE/GRs8M+TWNcBZ9YNCi6qsFXm/QLwQjmNfOmqEY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XNjMMaRx5X0BBMu0mygKtfjrDzV20r0p4copZ1zSNyPRh4kVnzaeQ2VBPh+2pkAZD
	 nCuVIbJHt6XNHKt61AS3Cnur6h4adENvpFwAAxZ6cdQmn+ukYVk6zS0PMOZdShowM5
	 BeLTkBzj//bR2rZMevTCoRvXO/PzDU1LZ9dYu8B/SFMIORyIKBpK2CkpUEiexOWx3o
	 zEgKZVKXmOY6Itmr0WSQLF7vEWVxRBUy45XOw+54MutWzmExd5tfLLmtm5WqgviBQo
	 iLGsris8Ow8gqcOj5nHrUbfFluUA4o2QQIRVi2CUn/ECyiu+iGpm15y4JFBHgdm619
	 lAyQslGiaMn2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE17338111DD;
	Mon, 23 Jun 2025 19:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH ethtool] ethtool: hibmcge: fix wrong register address in
 pretty print of ethtool -d command
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175070580950.3268784.4508213657235129774.git-patchwork-notify@kernel.org>
Date: Mon, 23 Jun 2025 19:10:09 +0000
References: <20250616131840.812638-1-shaojijie@huawei.com>
In-Reply-To: <20250616131840.812638-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: mkubecek@suse.cz, shenjian15@huawei.com, liuyonglong@huawei.com,
 chenhao418@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to ethtool/ethtool.git (master)
by Michal Kubecek <mkubecek@suse.cz>:

On Mon, 16 Jun 2025 21:18:40 +0800 you wrote:
> The addresses of mac_addr_h and mac_addr_l are wrong,
> they need to be swapped.
> 
> Fixes: d89f6ee9c12a ("hibmcge: add support dump registers for hibmcge driver")
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  hibmcge.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [ethtool] ethtool: hibmcge: fix wrong register address in pretty print of ethtool -d command
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=196c3609ad9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



