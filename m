Return-Path: <linux-kernel+bounces-878473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F46C20C11
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 438484F1CFD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7CB280339;
	Thu, 30 Oct 2025 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uc/uCxaL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E1B184
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761835719; cv=none; b=IjXzxXx0c2hDAhtXjVppOSJWRhlCeJ38vxibVaUihASQpQbpwzs6H8w5WLfqodnIM/lBUW0i/nMAMFnj1iLb0WHT0gyRuy/hY9SHgxzqpMNjupnbGQRLMAHFtPzmIXua1Otve+f2EnZNc+4/2PowVqDlGv7lwzJwusMGngqbhbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761835719; c=relaxed/simple;
	bh=3vowx96YOzVelswYWJ5+Sm7l2nM8OpWtXSk81n0c6GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNKyEtEovb9tCVh3AaorS/ocRkVgiHuS8aF0mjPDfHoxMCZ7ze/2WbPR0GvPu3B9jkFdNZkkuyD08fIb18uW/LW7wWbsyj06w7C2rPLjBxjJImksJBoL0caPtbi0U5ZoOw408RN9ZyxA4V8SQLKLRGspm+yLg1y+RbQWf10sbiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uc/uCxaL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80093C4CEF8;
	Thu, 30 Oct 2025 14:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761835719;
	bh=3vowx96YOzVelswYWJ5+Sm7l2nM8OpWtXSk81n0c6GM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uc/uCxaLOeJcIdSvuMhrWDdXXKMFOIxhe446YwqNUbSDsX8xbaxgm4B/ZFQxNPsFR
	 yEhtW1SzturSwVKEMhy19HOtH2TAKnS4X0vWcX1WDwdhkbmD8Zl4liW+euc2O28KAf
	 cf5jz7So3r07dp/I0nNNJh/Bi66WTSfwXT5OkQ4nuqp5EZEnSJ2QRCjg0rRKcYMl1C
	 /EEfmLzvaBEFqPMi+BnFcfWd84gRQ4TnlnKhUDGYbOyPkwFLoQBHb9rWZrQTlCxC2a
	 Coy76vZYv4qH7pI6/HcN2kTQY/MHGyYcQUz+wViDJS579N1LmMVf6sGM0uzM+SQULf
	 a9FL3xakqE8QA==
Date: Thu, 30 Oct 2025 14:48:34 +0000
From: Will Deacon <will@kernel.org>
To: shechenglong <shechenglong@xfusion.com>
Cc: mark.rutland@arm.com, catalin.marinas@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stone.xulei@xfusion.com, chenjialong@xfusion.com,
	yuxiating@xfusion.com
Subject: Re: [PATCH v2 1/2] cpu:Remove the print when the
 CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY Kconfig option is disabled.
Message-ID: <aQN6wlpzSx9kbGqI@willie-the-truck>
References: <20250918064907.1832-1-shechenglong@xfusion.com>
 <20251029034554.1839-1-shechenglong@xfusion.com>
 <20251029034554.1839-2-shechenglong@xfusion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029034554.1839-2-shechenglong@xfusion.com>

On Wed, Oct 29, 2025 at 11:45:53AM +0800, shechenglong wrote:
> Following the pattern established with other Spectre mitigations,
> do not prints a message when the CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY
> Kconfig option is disabled.
> 
> Link: https://patchwork.kernel.org/project/linux-arm-kernel/patch/20250918064907.1832-1-shechenglong@xfusion.com/
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: shechenglong <shechenglong@xfusion.com>
> ---
>  arch/arm64/kernel/proton-pack.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
> index f9a32dfde006..d833b7c1bba8 100644
> --- a/arch/arm64/kernel/proton-pack.c
> +++ b/arch/arm64/kernel/proton-pack.c
> @@ -1042,8 +1042,6 @@ void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
> 
>         if (arm64_get_spectre_v2_state() == SPECTRE_VULNERABLE) {
>                 /* No point mitigating Spectre-BHB alone. */
> -       } else if (!IS_ENABLED(CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY)) {
> -               pr_info_once("spectre-bhb mitigation disabled by compile time option\n");
>         } else if (cpu_mitigations_off() || __nospectre_bhb) {
>                 pr_info_once("spectre-bhb mitigation disabled by command line option\n");
>         } else if (supports_ecbhb(SCOPE_LOCAL_CPU)) {

I'm not able to apply this -- I think you've somehow converted some tabs
to spaces in the whitespace.

Please can you fix that and send a v3?

Will

