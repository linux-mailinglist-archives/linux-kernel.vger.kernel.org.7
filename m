Return-Path: <linux-kernel+bounces-854265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D41BDDF27
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13CD93ACEBA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A5431BCA9;
	Wed, 15 Oct 2025 10:20:06 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6245531B13F
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760523606; cv=none; b=en7RlsH7MwQtRWhHNIJZQ3YnPY0GDycpHnP+k338htPNQqVLAvUWjtARB4FdrQ32YPc7GaYG+Cnx/5psdUPGgutb9Su7+E6c16SeKpcZOt/V1+ihoX06mrFTHSwFaoiIlf35wEtZGWpHpXePbWLcuEAyS+wVEvEMUHFPqhXe/pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760523606; c=relaxed/simple;
	bh=ISEbrP1ojIqPwiqSlr6CNOXhZqjPLw+oSkAoRzZK7Fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U+yH6o43uNyKJUnPcrAisumP5ZlVz6XocNkwo6l1LTAZq7rc+lbTQvIaasjNc28Tk3K1/L8XkQeA8tYH+PXqu09YL6SoOCzmgqV0ud/0aIJJq095fjw6KUbvkWSkqiyqkP+FpKmZEiw5c/y6hjorWMDhg+xdsCqsc2z9u8uqi4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cmmbB2SqLz9sRy;
	Wed, 15 Oct 2025 11:52:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hHclDKs4a-fH; Wed, 15 Oct 2025 11:52:22 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cmmbB1cLxz9sRk;
	Wed, 15 Oct 2025 11:52:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 11C7C8B768;
	Wed, 15 Oct 2025 11:52:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id IgMRS4_jinip; Wed, 15 Oct 2025 11:52:22 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 863738B763;
	Wed, 15 Oct 2025 11:52:21 +0200 (CEST)
Message-ID: <963c1cbf-0d81-487a-8c79-15de46c2865d@csgroup.eu>
Date: Wed, 15 Oct 2025 11:52:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc: kgdb: Remove OUTBUFMAX constant
To: =?UTF-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mikisabate@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com
References: <20250915141808.146695-1-mikisabate@gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250915141808.146695-1-mikisabate@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 15/09/2025 à 16:18, Miquel Sabaté Solà a écrit :
> [Vous ne recevez pas souvent de courriers de mikisabate@gmail.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> This constant was introduced in commit 17ce452f7ea3 ("kgdb, powerpc:
> arch specific powerpc kgdb support"), but it is no longer used anywhere
> in the source tree.
> 
> Signed-off-by: Miquel Sabaté Solà <mikisabate@gmail.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   arch/powerpc/include/asm/kgdb.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/kgdb.h b/arch/powerpc/include/asm/kgdb.h
> index 715c18b75334..4c0afde87e97 100644
> --- a/arch/powerpc/include/asm/kgdb.h
> +++ b/arch/powerpc/include/asm/kgdb.h
> @@ -25,7 +25,6 @@
> 
>   #define BREAK_INSTR_SIZE       4
>   #define BUFMAX                 ((NUMREGBYTES * 2) + 512)
> -#define OUTBUFMAX              ((NUMREGBYTES * 2) + 512)
> 
>   #define BREAK_INSTR            0x7d821008      /* twge r2, r2 */
> 
> --
> 2.51.0
> 


