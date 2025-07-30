Return-Path: <linux-kernel+bounces-750228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D795EB158E1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BC8618A3F8E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 06:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562A71EB5DB;
	Wed, 30 Jul 2025 06:20:37 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1B1199BC;
	Wed, 30 Jul 2025 06:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753856437; cv=none; b=TIHHEO6rY0shMClJyNfGfBw53HwNeNrR+spFr3/P/Oig5xzzuChKByj+efw4e7NUKVgj13YiqFi8cg+7pQHGIQZzE30GzpkclPF3lWRx64Sujx5JeCdFgGKahos6/foqAqKOuId+xpaIgxGju6WHPevTUweH8NvRzmu/JBkUFpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753856437; c=relaxed/simple;
	bh=S7CAjnZjE32GwdUMDWr85Ucd5ajujDBrqwJRjBmnrDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m3z0kGzZ2OKs4wlbV1eHS0sO76HTpOGmiWlQSfGpy6PA5Ma1YRXRXGbs3RjYrDMLMWQvXvH3SIhqQ+NS6mbDCgEn9y1IEPVrgB3zhVYy+9S8pzogofWCUpvLPUJXhs34IGRoKG4Ph0YXO+gY+XlQ5j8LjNsGOnjf4oK4w8Fbts8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bsMNp07k8z9sWd;
	Wed, 30 Jul 2025 08:14:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w5y7WMXPOvjy; Wed, 30 Jul 2025 08:14:01 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bsMNn674Yz9sWb;
	Wed, 30 Jul 2025 08:14:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C64558B76C;
	Wed, 30 Jul 2025 08:14:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 8syPEqNjGyEp; Wed, 30 Jul 2025 08:14:01 +0200 (CEST)
Received: from [10.25.207.160] (unknown [10.25.207.160])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 9EAEE8B763;
	Wed, 30 Jul 2025 08:14:01 +0200 (CEST)
Message-ID: <62aa5231-ed31-43e2-84b7-d6b6ec86e78d@csgroup.eu>
Date: Wed, 30 Jul 2025 08:14:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/xmon: replace sizeof calculations with ARRAY_SIZE
 macro
To: Ruben Wauters <rubenru09@aol.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <20250719225225.2132-2-rubenru09.ref@aol.com>
 <20250719225225.2132-2-rubenru09@aol.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250719225225.2132-2-rubenru09@aol.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 20/07/2025 à 00:43, Ruben Wauters a écrit :
> [Vous ne recevez pas souvent de courriers de rubenru09@aol.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> The calculations for operand/opcode/macro numbers are done in an
> identical manner to the already existing ARRAY_SIZE macro in
> linux/array_size.h
> 
> This patch replaces the sizeof calculations with the macro to make the
> code cleaner and more immediately obvious what it is doing.
> 
> Signed-off-by: Ruben Wauters <rubenru09@aol.com>
> ---
>   arch/powerpc/xmon/ppc-opc.c | 16 ++++++----------

This file is mostly taken from binutils, refer commit 08d96e0b127e 
("powerpc/xmon: Apply binutils changes to upgrade disassembly").

I think your change should be done in binutils then backported to the 
kernel. The more we diverge from binutils the worse it is.

Christophe


>   1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/xmon/ppc-opc.c b/arch/powerpc/xmon/ppc-opc.c
> index 0774d711453e..de9b4236728c 100644
> --- a/arch/powerpc/xmon/ppc-opc.c
> +++ b/arch/powerpc/xmon/ppc-opc.c
> @@ -954,8 +954,7 @@ const struct powerpc_operand powerpc_operands[] =
>     { 0xff, 11, NULL, NULL, PPC_OPERAND_SIGNOPT },
>   };
> 
> -const unsigned int num_powerpc_operands = (sizeof (powerpc_operands)
> -                                          / sizeof (powerpc_operands[0]));
> +const unsigned int num_powerpc_operands = ARRAY_SIZE(powerpc_operands);
> 
>   /* The functions used to insert and extract complicated operands.  */
> 
> @@ -6968,9 +6967,8 @@ const struct powerpc_opcode powerpc_opcodes[] = {
>   {"fcfidu.",    XRC(63,974,1),  XRA_MASK, POWER7|PPCA2, PPCVLE,         {FRT, FRB}},
>   };
> 
> -const int powerpc_num_opcodes =
> -  sizeof (powerpc_opcodes) / sizeof (powerpc_opcodes[0]);
> -
> +const int powerpc_num_opcodes = ARRAY_SIZE(powerpc_opcodes);
> +
>   /* The VLE opcode table.
> 
>      The format of this opcode table is the same as the main opcode table.  */
> @@ -7207,9 +7205,8 @@ const struct powerpc_opcode vle_opcodes[] = {
>   {"se_bl",      BD8(58,0,1),    BD8_MASK,       PPCVLE, 0,              {B8}},
>   };
> 
> -const int vle_num_opcodes =
> -  sizeof (vle_opcodes) / sizeof (vle_opcodes[0]);
> -
> +const int vle_num_opcodes = ARRAY_SIZE(vle_opcodes);
> +
>   /* The macro table.  This is only used by the assembler.  */
> 
>   /* The expressions of the form (-x ! 31) & (x | 31) have the value 0
> @@ -7276,5 +7273,4 @@ const struct powerpc_macro powerpc_macros[] = {
>   {"e_clrlslwi",4, PPCVLE, "e_rlwinm %0,%1,%3,(%2)-(%3),31-(%3)"},
>   };
> 
> -const int powerpc_num_macros =
> -  sizeof (powerpc_macros) / sizeof (powerpc_macros[0]);
> +const int powerpc_num_macros = ARRAY_SIZE(powerpc_macros);
> --
> 2.49.1
> 


