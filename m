Return-Path: <linux-kernel+bounces-721920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7C8AFCF7B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 518CD1C20265
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6832E336F;
	Tue,  8 Jul 2025 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pc3DNh+l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B762E266F;
	Tue,  8 Jul 2025 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989192; cv=none; b=nDr43yMOHE6ZtAlSt9AYB5dnWQs8i1YjbcEYQ55r02Ono5VlxTY2J/cL1ohfDO0cp4xJCQfvfw6mRZffJw9kQz4dTsPHC+6x5n2krXULauQnhWqi1js7Tf0cqWIkkZuCKhfj5DHXpsxnUMsvBvVGCf5uCfCUm1oN8JBIrdXhAes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989192; c=relaxed/simple;
	bh=2dVWBRbn7gB2Ip/RlIdkUkZz/Rfmr06mo3cGo1b4rww=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p5+9Mqhj8BLwRPfN31eU8qcRk3M7BBeYJSvmq52pYxTjSt6tEqmKD+1GcHJlck5CZ7Z8EKO+A/GaVh2aRI5SFdITWWINJ72AzPu1lNEJ1UcivPx0/Vk57N6tD61EzKrxYYhU0NMzwr7iowl0yq4nnmCEyT66UuxT+wdxyLVrDE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pc3DNh+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D58C113CF;
	Tue,  8 Jul 2025 15:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751989192;
	bh=2dVWBRbn7gB2Ip/RlIdkUkZz/Rfmr06mo3cGo1b4rww=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Pc3DNh+l1RpFaZlYhTszhX8cCsz1wthZhDWmuPo+ecfsby6b5ViLgOPTP49pfSLf2
	 yaxaHFu5zySYk2NBkcq5YVmZLB0xieNPYwks7MxbJSoSO6ychhjvtRvpMprL+pksox
	 B0U9UwFTOMF1IUoxapjFos8GW/xqW6rM/kteQf81UhoqbBspO1kLy2OL5MKHcV5F7P
	 z5drLw7+5TpbO84YD3kmTAftUFVeTNUyHs+uQ1v6eDgf9HcqFSIBC9HKESOBK1kuHO
	 WxK2iTvVdCDIykMvq8nG36uT0Eq37LD4JCb2KV3Qo/p6+vTDxnMkSjEmP34mTEOOup
	 eD9pD934dD3JA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF23380DBEE;
	Tue,  8 Jul 2025 15:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: Use of_reserved_mem_region_to_resource{_byname}()
 for
 "memory-region"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175198921449.4109948.4233904328306529560.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 15:40:14 +0000
References: <20250703183459.2074381-1-robh@kernel.org>
In-Reply-To: <20250703183459.2074381-1-robh@kernel.org>
To: Rob Herring (Arm) <robh@kernel.org>
Cc: lorenzo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, nbd@nbd.name,
 sean.wang@mediatek.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, elder@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Jul 2025 13:34:57 -0500 you wrote:
> Use the newly added of_reserved_mem_region_to_resource{_byname}()
> functions to handle "memory-region" properties.
> 
> The error handling is a bit different for mtk_wed_mcu_load_firmware().
> A failed match of the "memory-region-names" would skip the entry, but
> then other errors in the lookup and retrieval of the address would not
> skip the entry. However, that distinction is not really important.
> Either the region is available and usable or it is not. So now, errors
> from of_reserved_mem_region_to_resource() are ignored so the region is
> simply skipped.
> 
> [...]

Here is the summary with links:
  - net: Use of_reserved_mem_region_to_resource{_byname}() for "memory-region"
    https://git.kernel.org/netdev/net-next/c/e27dba1951ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



