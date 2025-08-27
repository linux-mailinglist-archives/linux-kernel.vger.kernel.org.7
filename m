Return-Path: <linux-kernel+bounces-788653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9FBB38805
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D6BE5E6C4E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828922BE7A5;
	Wed, 27 Aug 2025 16:50:36 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4750717B505
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313436; cv=none; b=DutQIacKP7/WDyL1/snVQPHtClTuhidnVf0+DLCelancx3NQU6xs42i3kgrn0JsJFut/bMqahkmFo/v+MopMFOFusyNbOGwMIW/hiayV+R+Ac89EnskZTAtSWlbtu94dFzEMfDlh3yCOMgHkBe77RjFG0BG9pL/AxUJNFUNtkwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313436; c=relaxed/simple;
	bh=Jhss2XGhOjXJdp6KntQvPhz+D9WALHTXn3FEcrC0xo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ktCHHEtPyIMGsuZ2xu0dIWCONlkIn+Q2DFVFGjyRTyYRDLugXzWhtZ9hXcR9cE0VpzNgZbHT0DEgyIgcJYW2HrlL0cd+M6Lybmd+DRkRMyuM92f8M66feWPC9phIcGLLy2qtyyLl4P5r/bW4YLqSPuK6wb8o8KvQAXtfVcJTfdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cBr1R461Fz9sS7;
	Wed, 27 Aug 2025 18:42:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EfL2OmdZ6UBM; Wed, 27 Aug 2025 18:42:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cBr1R2vdFz9sRy;
	Wed, 27 Aug 2025 18:42:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4CF088B764;
	Wed, 27 Aug 2025 18:42:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id wOAkvJCsR2Ku; Wed, 27 Aug 2025 18:42:51 +0200 (CEST)
Received: from [192.168.202.221] (unknown [192.168.202.221])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E5CDE8B763;
	Wed, 27 Aug 2025 18:42:50 +0200 (CEST)
Message-ID: <732ae03a-f0a7-450c-8896-e8a4975a5254@csgroup.eu>
Date: Wed, 27 Aug 2025 18:42:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/powernv: Rename pe_level_printk to pe_printk and
 embed KERN_LEVEL in format
To: Joe Perches <joe@perches.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
References: <df3a7ca31d2002ca447ab062f5b5e32ced9bec85.camel@perches.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <df3a7ca31d2002ca447ab062f5b5e32ced9bec85.camel@perches.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Joe

Le 21/06/2019 à 07:36, Joe Perches a écrit :
> Remove the separate KERN_<LEVEL> from each pe_level_printk and
> instead add the KERN_<LEVEL> to the format.
> 
> pfix in pe_level_printk could also be used uninitialized so
> add a new else and set pfx to the hex value of pe->flags.
> 
> Rename pe_level_printk to pe_printk and update the pe_<level>
> macros.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>   arch/powerpc/platforms/powernv/pci-ioda.c | 14 ++++++++++++--
>   arch/powerpc/platforms/powernv/pci.h      | 11 +++++------
>   2 files changed, 17 insertions(+), 8 deletions(-)

I can't see the added value of this patch, it adds more lines than it 
removes.

Christophe

> 
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 10cc42b9e541..60fc36ae626a 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -50,15 +50,23 @@
>   static const char * const pnv_phb_names[] = { "IODA1", "IODA2", "NPU_NVLINK",
>   					      "NPU_OCAPI" };
>   
> -void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
> -			    const char *fmt, ...)
> +void pe_printk(const struct pnv_ioda_pe *pe, const char *fmt, ...)
>   {
>   	struct va_format vaf;
>   	va_list args;
>   	char pfix[32];
> +	char level[PRINTK_MAX_SINGLE_HEADER_LEN + 1] = "\0";
>   
>   	va_start(args, fmt);
>   
> +	while (printk_get_level(fmt)) {
> +		size_t size = printk_skip_level(fmt) - fmt;
> +
> +		memcpy(level, fmt,  size);
> +		level[size] = '\0';
> +		fmt += size;
> +	}
> +
>   	vaf.fmt = fmt;
>   	vaf.va = &args;
>   
> @@ -74,6 +82,8 @@ void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
>   			(pe->rid & 0xff00) >> 8,
>   			PCI_SLOT(pe->rid), PCI_FUNC(pe->rid));
>   #endif /* CONFIG_PCI_IOV*/
> +	else
> +		sprintf(pfix, "(flags: 0x%lx)", pe->flags);
>   
>   	printk("%spci %s: [PE# %.2x] %pV",
>   	       level, pfix, pe->pe_number, &vaf);
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> index be26ab3d99e0..870b21f55b3f 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -205,15 +205,14 @@ extern unsigned long pnv_pci_ioda2_get_table_size(__u32 page_shift,
>   		__u64 window_size, __u32 levels);
>   extern int pnv_eeh_post_init(void);
>   
> -__printf(3, 4)
> -extern void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
> -			    const char *fmt, ...);
> +__printf(2, 3)
> +extern void pe_printk(const struct pnv_ioda_pe *pe, const char *fmt, ...);
>   #define pe_err(pe, fmt, ...)					\
> -	pe_level_printk(pe, KERN_ERR, fmt, ##__VA_ARGS__)
> +	pe_printk(pe, KERN_ERR fmt, ##__VA_ARGS__)
>   #define pe_warn(pe, fmt, ...)					\
> -	pe_level_printk(pe, KERN_WARNING, fmt, ##__VA_ARGS__)
> +	pe_printk(pe, KERN_WARNING fmt, ##__VA_ARGS__)
>   #define pe_info(pe, fmt, ...)					\
> -	pe_level_printk(pe, KERN_INFO, fmt, ##__VA_ARGS__)
> +	pe_printk(pe, KERN_INFO fmt, ##__VA_ARGS__)
>   
>   /* Nvlink functions */
>   extern void pnv_npu_try_dma_set_bypass(struct pci_dev *gpdev, bool bypass);


