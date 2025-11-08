Return-Path: <linux-kernel+bounces-891214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FD6C42298
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 01:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983AA1897193
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 00:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3BF284880;
	Sat,  8 Nov 2025 00:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zOJ7E3h5"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4697523AB9D;
	Sat,  8 Nov 2025 00:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762562849; cv=none; b=JXPful7+K9ImMWN/ff+j4p5CiqwIlgoCL56Dq0XCRmwolHGL/rZAd/nRRR7QJy4DgyqEbRuEt2dmJg3228EMbY64JbbWGRzf5CzYM/lQRntAL528X1V/VTvDqxsR0MCaS6xWDhGv9EkoUUdBux13tjz5amUMWjKWaoy3KgtBwtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762562849; c=relaxed/simple;
	bh=59C/XuMe5Ge8/qSzc4ZMGAKYZDM7lDOXBBVpw2eaPSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qUNzyJCDj7dw1fwIzeItrGYGVIaQbC77S3v+V6oBSt3QqdFdMICQW1DASO8ASVigYHlssLtF4bOS+sPKyZshhEgLG3J41+egmSthiSljAxMvPc/iX3hSPQUQK488CSmgnyjBSRhXK67HI24KVC62zQA1OM/4Nw4ouRqUOIajVnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zOJ7E3h5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=YhkT2ytpSMxixxpMPcBDjR5/ns0X9Sii3powHA75mKY=; b=zOJ7E3h5zUdzZHI132+HBGHClb
	PPaRBgBE/Ik30NrEGow4L3XeW1/3qAzCHpbgs3zxgqQHf3eRmJ3PZCZQSNAq9s0Gdu/aKjosNbGjE
	26fiJoO9u703uM0OdVej41p72Of87TW6J0SAT2PREFsA+8w9dPKJXdStJ++7UhHko425ISJHcxwXO
	yuwLx+NNqepoMpwC1jLyEdJO2mixNatanIFB9KZyN3zXYSVsN9Q27gjZYfAYGNo/zocoKwWYx1VpM
	w4/Kux8t24mf4rPWRqr5AWWowbphy5y4G2Zw3bgeKouO/DPHJeUCriJvp5ecK7rnzw9Clg9a6g8Yj
	ANUHMzKA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHX70-00000001n0i-2IMc;
	Sat, 08 Nov 2025 00:47:26 +0000
Message-ID: <7d03b0d2-8dd8-4cda-8a0d-7a065029e6f5@infradead.org>
Date: Fri, 7 Nov 2025 16:47:25 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] x86/apic: Update kernel-doc to avoid warnings
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20251106101416.1924707-1-andriy.shevchenko@linux.intel.com>
 <20251106101416.1924707-3-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251106101416.1924707-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/6/25 2:12 AM, Andy Shevchenko wrote:
> Validator is not happy about some of the kernel-doc descriptions:
> 
> Warning: arch/x86/kernel/apic/apic.c:245 No description found for return value of 'lapic_get_maxlvt'
> Warning: arch/x86/kernel/apic/apic.c:2145 function parameter 'error_code' not described in 'spurious_interrupt'
> 
> Update them accordingly.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  arch/x86/kernel/apic/apic.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index 680d305589a3..4675d1a07fc9 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -241,6 +241,8 @@ u64 native_apic_icr_read(void)
>  
>  /**
>   * lapic_get_maxlvt - get the maximum number of local vector table entries
> + *
> + * Return: the maximum number of local vector table entries
>   */
>  int lapic_get_maxlvt(void)
>  {
> @@ -2136,7 +2138,7 @@ static noinline void handle_spurious_interrupt(u8 vector)
>  /**
>   * spurious_interrupt - Catch all for interrupts raised on unused vectors
>   * @regs:	Pointer to pt_regs on stack
> - * @vector:	The vector number
> + * @error_code:	The vector number
>   *
>   * This is invoked from ASM entry code to catch all interrupts which
>   * trigger on an entry which is routed to the common_spurious idtentry

-- 
~Randy

