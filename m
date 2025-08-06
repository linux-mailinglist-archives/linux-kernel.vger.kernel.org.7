Return-Path: <linux-kernel+bounces-758071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB2CB1CA8A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29A5723978
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756482BF3E2;
	Wed,  6 Aug 2025 17:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ck2OCxI6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79E72BF3CA
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 17:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754500544; cv=none; b=C4vpwO/t/bYRLVBe4AdUxU7YyxDvXCs6jq1t9NtGsJnGrYFWbNUvBoac3lDIDnfZcUeUiytTvx5IIMqMqWKuTuuh4wEmh5i38NMuzpn8IBjJVIX8Xt6R3hD5pY804GpZDEK/QWRj6DofObDHEz6g30DnNZVfYwWcj8GL/Yd6Zu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754500544; c=relaxed/simple;
	bh=0y/Nm6OPi0T0mjCjHKEi+zNnjN7+zHKI3+/zxOa4BNQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NfpGuBLSlEmbXMd/RdJTLtuHATtHUPWGu6PHTTR9P3WDjCAInm++xQtBTG942Zl0SxfC+eepiQS8dEb6eNtq66C6D2HtNnVXuC9pIs/6oz7TNMnA5UdTHnpC0FSFEe47TWwYLmJjKYu/YvYxjOpiNzvN6fb1c8j4nVIQvuKhT0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ck2OCxI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62678C4CEED;
	Wed,  6 Aug 2025 17:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754500544;
	bh=0y/Nm6OPi0T0mjCjHKEi+zNnjN7+zHKI3+/zxOa4BNQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ck2OCxI6BjI9uTatbmETmredUXJrzeLGhnJINfc4ya0VvzRJJjQUflcV5e7y63D8w
	 g2lh8LsP0haKJ1ySItsFihxcczBH5MPZcSsbstTLS4qhArfeVI+sxPgoRaggDSLZla
	 zCc4FD0o5RtRwBYC/V/gBC9pvEVQFHZ+Gs/RKvNPJaY1lzNEEWWdSA9r+IVPDi/i2e
	 cOwf/ymkzEO0HT4tOQKwfAS5/KLNRSctkeyzOVgH6hErzbw4ScOnlhyznOPgIy1PFT
	 zyDofaaBckeaHRXzT9JkMuH4d6wTKE11wfp87Wi49rjyIgmhlfgwfM+m8qfLKm8Kcu
	 nC4MDRjA8R7fA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BA1383BF63;
	Wed,  6 Aug 2025 17:15:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: pi: use 'targets' instead of extra-y in Makefile
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175450055825.2863135.14397675555943058251.git-patchwork-notify@kernel.org>
Date: Wed, 06 Aug 2025 17:15:58 +0000
References: <20250602181023.528550-1-masahiroy@kernel.org>
In-Reply-To: <20250602181023.528550-1-masahiroy@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Alexandre Ghiti <alexghiti@rivosinc.com>:

On Tue,  3 Jun 2025 03:10:18 +0900 you wrote:
> %.pi.o files are built as prerequisites of other objects.
> There is no need to use extra-y, which is planned for deprecation.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/riscv/kernel/pi/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - riscv: pi: use 'targets' instead of extra-y in Makefile
    https://git.kernel.org/riscv/c/cc750fa93b5a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



