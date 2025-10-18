Return-Path: <linux-kernel+bounces-859278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CDDBED34A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 18:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76E424E960F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 16:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEE024678D;
	Sat, 18 Oct 2025 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwXqchKv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5C02459D1
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 16:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760803308; cv=none; b=iYuT4cg9xqGA4BcLOaMikI4jJ9jgl3nTUM2RKUiykRr6qsSMGxd+wDmWvTwVeeEIKrCfNOYMubZSYlsBDrF98VPKE+CHyZ9Q7gP2/KZ8ceNvOB++K0sqPChxoSoFB0uwhTpUgDJUuaWZLurYY5pEe8ucUYxYW6A5Rt4c+nlY5H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760803308; c=relaxed/simple;
	bh=u/syW8Wz8ABWTw3mp7UlY9VWdvRASbfj7TUbwfSB4jQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qhrFBYgLpar9Jpu7yvoaoOgy5Y+LHmVFCDdcyVyUziKbwZdtQBOaJMZ6gTFYF6rydb5VyU4xv0+eCEVXUwwGMi7/JQLTOLtIQ94a9C1mH2YxQlVmcV59TkqcyPjnvFu0Bw9lKvl3PIPCzdvRwohN6t+qtgnifDi046f9ZwMSrso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwXqchKv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B270C4CEF8;
	Sat, 18 Oct 2025 16:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760803308;
	bh=u/syW8Wz8ABWTw3mp7UlY9VWdvRASbfj7TUbwfSB4jQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RwXqchKvN++6LJ8SxvtqfDUt+hFjpitkBtY5GiIbpO6ItDvb6LSoI28GhUd1Krkwo
	 OI1qYUwLSa0oT49UHwy+v74fz1VofqxaaBJ9wRSlo3It8XccsfDep5/Mf+3df3ejUJ
	 CWNYPCVstUzz82gtoO9wOSmI1Jx7iVH6X1P0bR/pTShaA1JjQQFhx2VtMHEjVeDxjO
	 wBIj6G+9xxINb2+aKs1v+Q4Nel7y5aHSPeKTbCQMT65TAI7AFznPTLzgTJ8eKeGksD
	 DENxYFIHRv4M5k9hZhuiLaYFj2Mbc9nkjheB6BEwDkQf00WEH8csEqswmoRU4UzJbL
	 Y3BG/0xpGYYvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD8839EFBB7;
	Sat, 18 Oct 2025 16:01:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: mm: Define MAX_POSSIBLE_PHYSMEM_BITS for zsmalloc
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <176080329124.3028979.1869728422063945538.git-patchwork-notify@kernel.org>
Date: Sat, 18 Oct 2025 16:01:31 +0000
References: <20251015233327.3885003-1-samuel.holland@sifive.com>
In-Reply-To: <20251015233327.3885003-1-samuel.holland@sifive.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, apopple@nvidia.com,
 akpm@linux-foundation.org, willy@infradead.org, will@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Paul Walmsley <pjw@kernel.org>:

On Wed, 15 Oct 2025 16:33:24 -0700 you wrote:
> This definition is used by zsmalloc to optimize memory allocation. On
> riscv64, it is the same as MAX_PHYSMEM_BITS from asm/sparsemem.h, but
> that definition depends on CONFIG_SPARSEMEM. The correct definition is
> already provided for riscv32.
> 
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> 
> [...]

Here is the summary with links:
  - riscv: mm: Define MAX_POSSIBLE_PHYSMEM_BITS for zsmalloc
    https://git.kernel.org/riscv/c/5898fc01ff34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



