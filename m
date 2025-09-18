Return-Path: <linux-kernel+bounces-823557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBD9B86D69
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 22:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64F651CC43AF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8744131B81A;
	Thu, 18 Sep 2025 20:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPkWjrvo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF7731B12A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 20:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226125; cv=none; b=gpB0bJeMk6txdeOwJyd/lUxxmYyEtVqnSuRoLKcTDjdva9alNOaDBbuaw5dvEw/bp4wGVuw2WURJHqLmazqoeaRnx3hJ93jOkcWqNZxZOUH9Kla0liWrjykZTr7OZODxEx8oN3rEGIEFcBuCkBIz+qrSNLtsbUzDpd3dfzqs9DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226125; c=relaxed/simple;
	bh=tMsV6oWM2CjVGDVuEwYMj2bcWme2aqNHw1loQMqwTJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8YePB1M/1btCa73pLv75QyaiQT7elp7sPrgvXKaadCxRRvWmQsbz8dyLAIvwOptmBOkrMBmTifF1K1FsGUOnthmkIPsC1u6xlmPFH4Xr5aD+I46ItHNVxK7vFH+KwHmCnTzNafyWnJOsKELwtBOR+FR2txqlzXyba0CzdFKamY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPkWjrvo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B15C4CEFB;
	Thu, 18 Sep 2025 20:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758226124;
	bh=tMsV6oWM2CjVGDVuEwYMj2bcWme2aqNHw1loQMqwTJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JPkWjrvojGXkv4cPINpxX85btxAuaBJi2ORp1V99InC6wj69QkWH844eWH4qH57Bv
	 VsHCym70JgFlA6ad7kjNAnNuUbIAFVyEdAY21FaWfy4pe4PhZwnmxFx5c+QusO085n
	 Zavev77jGLnk4tDRyEXIKYa6w5mEHlmCWN640okSR3d5CUA6Z9sz1mYzF/l3pYqJkq
	 JcrM06oBwcXecSTN8pnHq4peQ/sfVCyVu5osCsNiNBQ2tBPdHvkxVx4LRc1xHAWkMd
	 XIhzWbMgZcXhnTMhZFVm2kV/+4XExuqidK5J7fAvUeyQ+jI0lDGPq6nhY4rXTv1CPp
	 52oi8W/OYvPbw==
Date: Thu, 18 Sep 2025 21:08:40 +0100
From: Will Deacon <will@kernel.org>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	mark.rutland@arm.com, liaochang1@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: probes: Fix incorrect bl/blr address and register
 usage
Message-ID: <aMxmyMRxRRRj9phu@willie-the-truck>
References: <20250918175424.3483164-1-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918175424.3483164-1-jeremy.linton@arm.com>

On Thu, Sep 18, 2025 at 12:54:24PM -0500, Jeremy Linton wrote:
> The pt_regs registers are 64-bit on arm64, and should be u64 when
> manipulated. Correct this so that we aren't truncating the address
> during br/blr sequences.
> 
> Fixes: efb07ac534e2 ("arm64: probes: Add GCS support to bl/blr/ret")
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/kernel/probes/simulate-insn.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/probes/simulate-insn.c b/arch/arm64/kernel/probes/simulate-insn.c
> index 97ed4db75417..89fbeb32107e 100644
> --- a/arch/arm64/kernel/probes/simulate-insn.c
> +++ b/arch/arm64/kernel/probes/simulate-insn.c
> @@ -145,7 +145,7 @@ void __kprobes
>  simulate_br_blr(u32 opcode, long addr, struct pt_regs *regs)
>  {
>  	int xn = (opcode >> 5) & 0x1f;
> -	int b_target = get_x_reg(regs, xn);
> +	u64 b_target = get_x_reg(regs, xn);
>  
>  	if (((opcode >> 21) & 0x3) == 1)
>  		if (update_lr(regs, addr + 4))
> @@ -160,7 +160,7 @@ simulate_ret(u32 opcode, long addr, struct pt_regs *regs)
>  	u64 ret_addr;
>  	int err = 0;
>  	int xn = (opcode >> 5) & 0x1f;
> -	unsigned long r_target = get_x_reg(regs, xn);
> +	u64 r_target = get_x_reg(regs, xn);

This part isn't really doing anything but it's probably worth being
consistent with 'u64' anyway. I'll pick this up, thanks.

Will

