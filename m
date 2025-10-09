Return-Path: <linux-kernel+bounces-846938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59363BC9798
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A9C93C6E45
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFC62EA472;
	Thu,  9 Oct 2025 14:20:41 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4343595C
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760019641; cv=none; b=FWuFN91yo44E3mLt3yd+rvElmilHA5FOHopTEa2IMoOcZcIp1lGhvmKVTABtnNF5i9a4mYSlOhf2RhmrPZKBuW2YYHL3ObRXfmRpDlGMwm9ETdE8nGqnSSg49izP1lMziWmA/AraCKyFg7pOoCvKjJcOOsGFjDEvGANFTvIEYmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760019641; c=relaxed/simple;
	bh=yzjlkoF7YmBsFOPi3aeOV+QA2m6gDUBAYjG5WxFDl80=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OVDeT2waE0sdBvZyYCOVx/ffqXjgAy9HFn/VVT3/d4P26vDQG7/6MsY+jyWTILZCawmkdwXgWcpWKZLngvJu6Bu01uQMnqLZmVHw7iCnqQRIm8MjabQ6WTvYOjZpklZedGAm3lnhrjG8pIjTzE1aO8ep11akAAUX3VnaHkb6dTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cjBBM5Gldz9sSj;
	Thu,  9 Oct 2025 15:51:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cibJcHzYGNup; Thu,  9 Oct 2025 15:51:55 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cjBBL4XM5z9sSY;
	Thu,  9 Oct 2025 15:51:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 880138B76D;
	Thu,  9 Oct 2025 15:51:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id b-ev3yzMf1dF; Thu,  9 Oct 2025 15:51:54 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3D3E58B768;
	Thu,  9 Oct 2025 15:51:54 +0200 (CEST)
Message-ID: <60593288-c747-42c5-b05d-27a81ab46021@csgroup.eu>
Date: Thu, 9 Oct 2025 15:51:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/addnote: Fix overflow on 32-bit builds
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <2025042122-mustard-wrasse-694572@boujee-and-buff>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <2025042122-mustard-wrasse-694572@boujee-and-buff>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 22/04/2025 à 04:31, Ben Collins a écrit :
> The PUT_64[LB]E() macros need to cast the value to unsigned long long
> like the GET_64[LB]E() macros. Caused lots of warnings when compiled
> on 32-bit, and clobbered addresses (36-bit P4080).
> 
> Signed-off-by: Ben Collins <bcollins@kernel.org>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   arch/powerpc/boot/addnote.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/boot/addnote.c b/arch/powerpc/boot/addnote.c
> index 53b3b2621457d..78704927453aa 100644
> --- a/arch/powerpc/boot/addnote.c
> +++ b/arch/powerpc/boot/addnote.c
> @@ -68,8 +68,8 @@ static int e_class = ELFCLASS32;
>   #define PUT_16BE(off, v)(buf[off] = ((v) >> 8) & 0xff, \
>   			 buf[(off) + 1] = (v) & 0xff)
>   #define PUT_32BE(off, v)(PUT_16BE((off), (v) >> 16L), PUT_16BE((off) + 2, (v)))
> -#define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
> -			  PUT_32BE((off) + 4, (v))))
> +#define PUT_64BE(off, v)((PUT_32BE((off), (unsigned long long)(v) >> 32L), \
> +			  PUT_32BE((off) + 4, (unsigned long long)(v))))
>   
>   #define GET_16LE(off)	((buf[off]) + (buf[(off)+1] << 8))
>   #define GET_32LE(off)	(GET_16LE(off) + (GET_16LE((off)+2U) << 16U))
> @@ -78,7 +78,8 @@ static int e_class = ELFCLASS32;
>   #define PUT_16LE(off, v) (buf[off] = (v) & 0xff, \
>   			  buf[(off) + 1] = ((v) >> 8) & 0xff)
>   #define PUT_32LE(off, v) (PUT_16LE((off), (v)), PUT_16LE((off) + 2, (v) >> 16L))
> -#define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v) >> 32L))
> +#define PUT_64LE(off, v) (PUT_32LE((off), (unsigned long long)(v)), \
> +			  PUT_32LE((off) + 4, (unsigned long long)(v) >> 32L))
>   
>   #define GET_16(off)	(e_data == ELFDATA2MSB ? GET_16BE(off) : GET_16LE(off))
>   #define GET_32(off)	(e_data == ELFDATA2MSB ? GET_32BE(off) : GET_32LE(off))


