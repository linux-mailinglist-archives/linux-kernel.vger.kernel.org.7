Return-Path: <linux-kernel+bounces-884525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D85C305E6
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFCEC3AB079
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B5C313264;
	Tue,  4 Nov 2025 09:50:06 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0F42C326F;
	Tue,  4 Nov 2025 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762249806; cv=none; b=TM2gCwdjjwKRlf4HnV6gUNNfsBbHl96yNHcb+Ie9G/Y5gfDDvF4ZieLY5LxNxtIudwRUiGRLlkzIizbpnwjMb7qhjAKS3ZpF3d4y4nrzCdMKRoPchHTdwo8NfwDtfkK3OpiN2XeHT+zXdwlVRpXIwFboGPqtRj6zTzkD621K63E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762249806; c=relaxed/simple;
	bh=vyHwJGBhRSyQwZHkZYnHvPVgA9ILWyEAtbOzLQcFNEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f/f52nKrr6dg50JrRf/4wvz7BCuwFAJ/k5sjaeTg/qu6F8m/JL6nLWpI1mdgjeLVYbgsytqU2BfFikh33rl28I4Zx/uRgW9Ak4gTeP1EAsDzqLYpRzgQejVYYodQy4MQAtX1IoflEpWiMjxqVCjGZP9id8pnPYUkr3OMxzQC7qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4d13FH6vZyz9sVR;
	Tue,  4 Nov 2025 10:34:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id laIYIGViDX2r; Tue,  4 Nov 2025 10:34:27 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4d13FH69Hjz9sVP;
	Tue,  4 Nov 2025 10:34:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id BFF658B76C;
	Tue,  4 Nov 2025 10:34:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 9X6PeMXL02Sz; Tue,  4 Nov 2025 10:34:27 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 13B0A8B763;
	Tue,  4 Nov 2025 10:34:27 +0100 (CET)
Message-ID: <3115e03a-1995-46f4-a902-47ba3cb99901@csgroup.eu>
Date: Tue, 4 Nov 2025 10:34:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/cputable: Use pointer from memcpy() call for
 assignment in set_cur_cpu_spec()
To: Markus Elfring <Markus.Elfring@web.de>, linuxppc-dev@lists.ozlabs.org,
 Dmitry Vyukov <dvyukov@google.com>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Miaoqian Lin <linmq006@gmail.com>
References: <6c61cf90-5811-4450-b649-7a2c84584ee9@web.de>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <6c61cf90-5811-4450-b649-7a2c84584ee9@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 30/10/2025 à 21:15, Markus Elfring a écrit :
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 30 Oct 2025 21:10:11 +0100
> 
> A pointer was assigned to a variable. The same pointer was used for
> the destination parameter of a memcpy() call.
> This function is documented in the way that the same value is returned.
> Thus convert two separate statements into a direct variable assignment for
> the return value from a memory copy action.

I can't see the added value of this change. For me it degrades 
readability. Many places in cputable.c have that t = PTRRELOC(t) 
pattern, I can't see why that one should be changed while other ones remain.

Can you elaborate why this change is desirable ?

Thanks
Christophe

> 
> The source code was transformed by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   arch/powerpc/kernel/cputable.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
> index 6f6801da9dc1..a69ea88b780f 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -34,12 +34,11 @@ void __init set_cur_cpu_spec(struct cpu_spec *s)
>   {
>   	struct cpu_spec *t = &the_cpu_spec;
>   
> -	t = PTRRELOC(t);
>   	/*
>   	 * use memcpy() instead of *t = *s so that GCC replaces it
>   	 * by __memcpy() when KASAN is active
>   	 */
> -	memcpy(t, s, sizeof(*t));
> +	t = memcpy(PTRRELOC(t), s, sizeof(*t));
>   
>   	*PTRRELOC(&cur_cpu_spec) = &the_cpu_spec;
>   }


