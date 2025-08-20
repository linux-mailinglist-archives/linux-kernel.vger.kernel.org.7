Return-Path: <linux-kernel+bounces-778177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9350B2E238
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0C01C809C4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8693277B7;
	Wed, 20 Aug 2025 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L82BWB+3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACD0326D78;
	Wed, 20 Aug 2025 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755706991; cv=none; b=YFvyoGbTvVBghUOl8NaNGg5sNM+WpbEXrOzhWhS4Ftz/dzWJiUISYPrG0c877/0/wcRE2JUlUGgv868DqdwBw5JlnPUg9cDYlvE4ppji5MgmiujzlI7bEbHLAthr2Cmj8TMU86+xtzlIFLFpf1flNU7jM5ZiC9VvWVH2qJaLf68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755706991; c=relaxed/simple;
	bh=I18cqUGx7Hdm9LGLBpdG8guD9EJ88DA1sUAC0K19mog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2R3Oa3aZ6JYdmNn9l2jYnJYoTyn/hPy1ItcVpV9YCceu5OuQ54/STp6JeTx+rCHyauDdd0kQ3p5qjU7dqzKSi/mjii4PuEXUuxK0YpZEuxJLdI509YKIwN5Gb1DMxNPhfNBcjAK281lZhXDxQ86xj43S8QzKQJgxFHJwK5Ct3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L82BWB+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BE4C4CEE7;
	Wed, 20 Aug 2025 16:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755706989;
	bh=I18cqUGx7Hdm9LGLBpdG8guD9EJ88DA1sUAC0K19mog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L82BWB+3EmQFCpuEB7JgXu8iyQqyZTs29OYY5Gip+zdbMM8ls86doHd4p9o/4Tbsh
	 FmFy1RLQOceL+wp13UkDnwUCfen0Pj/j/NzWtnexJ6ukfDOo8JdUye/TB48fp9aZac
	 JKysFgprnNK6SkDmQaXKOOWGOg4/Cu5OduDnsT0kbVMXVkbTyhLzclMimDaiLXolAU
	 6OUZigQ3TQQawW2USdUokcKOZQ6xlBzNzCYaI7CmP/zG/V2B+ZFuQoQT1T+CP9lnnD
	 1CSIxd/Bm/6N+GyCM07hCRIMyB5RRiJm4zBjZvZrdNqCuU5n6Nf3FS3Ou3CdsnhT96
	 rco3i/kpGnRFQ==
Date: Wed, 20 Aug 2025 09:23:04 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	clang-built-linux <llvm@lists.linux.dev>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Ben Copeland <benjamin.copeland@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: next-20250819: sdhci-cadence.c error variable 'hrs37_mode' is
 uninitialized when used here [-Werror,-Wuninitialized]
Message-ID: <20250820162304.GD3805667@ax162>
References: <CA+G9fYtS9nDqC7g-B4285gmxDNRkYQixyPYMuzgDg5-sy2FumQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtS9nDqC7g-B4285gmxDNRkYQixyPYMuzgDg5-sy2FumQ@mail.gmail.com>

Hi Naresh,

On Wed, Aug 20, 2025 at 06:43:51PM +0530, Naresh Kamboju wrote:
> The following build warnings / errors noticed with arm64 defconfig
> and x86 allyesconfig with clang-20 and clang-nightly toolchains.
> 
> Regression Analysis:
> - New regression? yes
> - Reproducibility? yes
> 
> Build regression: next-20250819 sdhci-cadence.c error variable
> 'hrs37_mode' is uninitialized when used here [-Werror,-Wuninitialized]
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> ## Build log
> drivers/mmc/host/sdhci-cadence.c:297:9: error: variable 'hrs37_mode'
> is uninitialized when used here [-Werror,-Wuninitialized]
>   297 |         writel(hrs37_mode, hrs37_reg);
>       |                ^~~~~~~~~~
> drivers/mmc/host/sdhci-cadence.c:291:16: note: initialize the variable
> 'hrs37_mode' to silence this warning
>   291 |         u32 hrs37_mode;
>       |                       ^
>       |                        = 0

Thanks for the report. I sent a fix for this yesterday:

https://lore.kernel.org/20250819-mmc-sdhci-cadence-fix-uninit-hrs37_mode-v1-1-94aa2d0c438a@kernel.org/

Cheers,
Nathan

