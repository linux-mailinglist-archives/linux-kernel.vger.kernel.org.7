Return-Path: <linux-kernel+bounces-758065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B337B1CA7E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EBB418C49A0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F362BE65F;
	Wed,  6 Aug 2025 17:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t31k0AV6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BF12BE656
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 17:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754500534; cv=none; b=Mpo/67CjncFVbat2H/nBQb/zSpyvjbgzpXeVAPbKnSn70QS1TdgNurBpasSZK1Sha5BU9f3D+bnz3QT4f61BN9U1x+n6stEYY/Q0QWA84NPyFByPxFeZaX8VJVHqweysExs4gK0EbV95FZvo8xZAxGnVCcJYTRJDHVm5RTafQNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754500534; c=relaxed/simple;
	bh=IVFK/0+QswRCqr43cqboAMU1vdd5dlKlFrp+LiKHVbY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BuqCefYgd5zGqKmJiVPRMi81TKZdMzhHeSkX80OhHaorKowXmnN0Vtu8Nb+XfpaHgBHCEIp7oxkgJEbXhWzjpHijKB4iGgHnXoTtahKmhoSen2vNvKwIYNEe08yi7Ni4MAXejZpXvzv0q8yi9vY0/MxtBqbhc3dqyRfjedrs9do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t31k0AV6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282A9C4CEE7;
	Wed,  6 Aug 2025 17:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754500534;
	bh=IVFK/0+QswRCqr43cqboAMU1vdd5dlKlFrp+LiKHVbY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t31k0AV6h5azCfKdcMbgVVKopp/He+LRtaAyhqnYYW3uYZGcXWw71ouUeqxNQksBS
	 2e/2+GKtQpA2FoQA3j09St+PvQT2XpUag2nwfJNQcjRmt0N6DU3ajGlirwJn/iF3KK
	 D7UWJfxUBts86WOVRVTnVfdWPPNhkwmOa05UlgCPA5/OIjmFKqQL7lu+W5/OD+EvTh
	 A2Dn4+LffAcrCRmtWqZUWZhuZHPRSL/fVDE3JhAVOUKAYcc9B3gD7k2YwN7qDhtrJG
	 AvyNDh6tvdonGbBTnFh0/cr76gj28vWxn55EwFFpU53zC5di4Fpkv1Ba/a2oG2gfBx
	 3j8Pr9aJi/oOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C90383BF63;
	Wed,  6 Aug 2025 17:15:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/1] introduce ioremap_wc()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175450054774.2863135.12249630773089785493.git-patchwork-notify@kernel.org>
Date: Wed, 06 Aug 2025 17:15:47 +0000
References: <20250722091504.45974-1-cuiyunhui@bytedance.com>
In-Reply-To: <20250722091504.45974-1-cuiyunhui@bytedance.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 akpm@linux-foundation.org, catalin.marinas@arm.com,
 anshuman.khandual@arm.com, kas@kernel.org, ryan.roberts@arm.com,
 samuel.holland@sifive.com, namcao@linutronix.de, willy@infradead.org,
 abrestic@rivosinc.com, yongxuan.wang@sifive.com, apopple@nvidia.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Alexandre Ghiti <alexghiti@rivosinc.com>:

On Tue, 22 Jul 2025 17:15:03 +0800 you wrote:
> Compared with IO attributes, NC attributes can improve performance,
> specifically in these aspects: Relaxed Order, Gathering, Supports Read
> Speculation, Supports Unaligned Access.
> 
> When I replied to this patch (https://lore.kernel.org/all/CAEEQ3wmVPrZ6s8msM8RgcyZePGhXM1ikYMc5wW2n8q3Bf90EVw@mail.gmail.com/),
> I found the author's email address was invalid. So, based on this patch,
> I made slight modifications and resubmitted it.
> 
> [...]

Here is the summary with links:
  - [1/1] riscv: introduce ioremap_wc()
    https://git.kernel.org/riscv/c/5ec6b493183c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



