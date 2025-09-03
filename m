Return-Path: <linux-kernel+bounces-798197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4265DB41A8C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4CEB1BA4D44
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B2C2E8E1F;
	Wed,  3 Sep 2025 09:50:37 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9352E7F1D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 09:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893037; cv=none; b=UONOsTo1dRFBLTh/+euYI5d/PRXtYHScwtK/glqIdCOwVFynLqqqvFbPmr2D3z6AWrxLTEOKYR0W5ba/oXWijscYBTPv4L8mxyAQj4IOm52iX+hklSqksmzL3y5cvyUQJmlk+dv4BSxggr5YoAKAMiy0yDC6LOUayZ0Uv+qHbPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893037; c=relaxed/simple;
	bh=+xGLdZS8GxKbRjXXRRBN0ggZDj+AThjy5s4YY34ECiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HU/gi/AlAzaFUZu8QaQeOrbAqYI6a/luljoXOYi8fl8G4ix2ZvAOuNFwjizUD1AWWBlD8IJxuI5VJkOjMY4FU9ZiUX3UyIzFf5SO8OOEAo5sXvaiwhGFHn+j6rL5ehF7qEzLMrpnG7gBwtoMVtiyoYJegS/+KlLjgN2WPMCBIFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cGy2X3V7Dz9sSC;
	Wed,  3 Sep 2025 11:28:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oT-7cP3vo05a; Wed,  3 Sep 2025 11:28:04 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cGy2X2fQ3z9sRy;
	Wed,  3 Sep 2025 11:28:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4406F8B764;
	Wed,  3 Sep 2025 11:28:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id ogUe_nDKrpw7; Wed,  3 Sep 2025 11:28:04 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id EDDF48B763;
	Wed,  3 Sep 2025 11:28:03 +0200 (CEST)
Message-ID: <77252ee2-4640-45f4-a7cb-76e2d47ed0c4@csgroup.eu>
Date: Wed, 3 Sep 2025 11:28:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/32: Restore clearing of MSR[RI] in
 interrupt_exit_kernel_prepare()
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <e6166d2568386517de96a89e6cb3c7bd67e71eec.1756723048.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <e6166d2568386517de96a89e6cb3c7bd67e71eec.1756723048.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 01/09/2025 à 12:37, Christophe Leroy a écrit :
> Commit 13799748b957 ("powerpc/64: use interrupt restart table to speed
> up return from interrupt") removed the inconditional clearing of MSR[RI]
> when returning from interrupt into kernel. But powerpc/32 doesn't
> implement interrupt restart table hence still need MSR[RI] to be
> cleared.

This is needed but not enough. A synchronisation instruction is needed 
after clearing MSR[RI], otherwise the Instruction Breakpoint still 
triggers on a few instructions passed clearing of RI, allthough the 
LCTRL2[BRKNOMSK] is unset, meaning "Masked mode, breakpoints are 
recognized only when MSR[RI] =1 (reset value)"

We could as a isync() after __hard_EE_RI_disable(), but to minimise the 
impact it will be better to move clearing of MSR[RI] in the low-level 
assembly part of interrupt exit, just before the mtspr to SRR0 and SRR1, 
as was done before commit 6f76a01173cc ("powerpc/syscall: implement 
system call entry/exit logic in C for PPC32")

> 
> Fixes: 13799748b957 ("powerpc/64: use interrupt restart table to speed up return from interrupt")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>   arch/powerpc/kernel/interrupt.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
> index e0c681d0b076..e63bfde13e03 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -443,6 +443,9 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs)
>   
>   		if (unlikely(stack_store))
>   			__hard_EE_RI_disable();
> +#else
> +	} else {
> +		__hard_EE_RI_disable();
>   #endif /* CONFIG_PPC64 */
>   	}
>   


