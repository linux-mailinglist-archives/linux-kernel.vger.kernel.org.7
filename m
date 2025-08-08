Return-Path: <linux-kernel+bounces-760368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BF5B1EA3B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6B91173028
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4E827EC73;
	Fri,  8 Aug 2025 14:20:46 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0247916F8E9;
	Fri,  8 Aug 2025 14:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754662846; cv=none; b=IDtVOgOa60KDmY4Ap6aVIMPrmGfpjgW45msqynX2nd9D/flgBe3xe3A5h6JxjRdKvqZ1EXXnp2c1IhJ7P3KBmtdJ2DUZj080tMQkXSsJwsyMYAYcn6RiucEOMfsJJsHw+U+oaGCBk2+aFVXra1PBSuLj9VRj+t0fD+UjDMf9xEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754662846; c=relaxed/simple;
	bh=XNZSPdcPiuGz7gpNMGzvlktxK9vrVq23BePGqaTFwCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MfB35YaaP/pUsgwNNLn4lRsFya+rj3FQysFW5tUVyHL3l1KFxS+tnjYrrdAWpe+VlsQBuG/b1yFKDm6RQD3ryJc3TuUWAReQHTR4qXxmEyFmnY0NMS4aHfmJmXmn8yJCUjuURSmCta+IdMli+RCrfzAwM+QIb1eHAP1+sv+Dg4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4bz5NL0nZBz9sRk;
	Fri,  8 Aug 2025 16:03:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iDjJjZTpeS3K; Fri,  8 Aug 2025 16:03:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4bz5NK6p5Cz9sRg;
	Fri,  8 Aug 2025 16:03:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D0E838B770;
	Fri,  8 Aug 2025 16:03:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id oAEqk_kshTPB; Fri,  8 Aug 2025 16:03:29 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5A35C8B763;
	Fri,  8 Aug 2025 16:03:29 +0200 (CEST)
Message-ID: <7e2c8777-d439-4661-89b6-41b5356cf236@csgroup.eu>
Date: Fri, 8 Aug 2025 16:03:29 +0200
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
 <62aa5231-ed31-43e2-84b7-d6b6ec86e78d@csgroup.eu>
 <8381a142d72f3cd0e92de4dac6acfc0241a87365.camel@aol.com>
 <60ab8434533d214b53af15bb51d830e5f07d512f.camel@aol.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <60ab8434533d214b53af15bb51d830e5f07d512f.camel@aol.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/08/2025 à 15:54, Ruben Wauters a écrit :
> [Vous ne recevez pas souvent de courriers de rubenru09@aol.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Thu, 2025-07-31 at 17:40 +0100, Ruben Wauters wrote:
>> On Wed, 2025-07-30 at 08:14 +0200, Christophe Leroy wrote:
>>>
>>>
>>> Le 20/07/2025 à 00:43, Ruben Wauters a écrit :
>>>> [Vous ne recevez pas souvent de courriers de rubenru09@aol.com.
>>>> Découvrez pourquoi ceci est important à
>>>> https://aka.ms/LearnAboutSenderIdentification ]
>>>>
>>>> The calculations for operand/opcode/macro numbers are done in an
>>>> identical manner to the already existing ARRAY_SIZE macro in
>>>> linux/array_size.h
>>>>
>>>> This patch replaces the sizeof calculations with the macro to
>>>> make
>>>> the
>>>> code cleaner and more immediately obvious what it is doing.
>>>>
>>>> Signed-off-by: Ruben Wauters <rubenru09@aol.com>
>>>> ---
>>>>    arch/powerpc/xmon/ppc-opc.c | 16 ++++++----------
>>>
>>> This file is mostly taken from binutils, refer commit 08d96e0b127e
>>> ("powerpc/xmon: Apply binutils changes to upgrade disassembly").
>>>
>>> I think your change should be done in binutils then backported to
>>> the
>>> kernel. The more we diverge from binutils the worse it is
>>
>> While this is somewhat reasonable, the header (linux/array_size.h) is
>> linux specific, and is included through kernel.h
>>
>> I can probably see if binutils has a similar header, or if they would
>> accept an equivalent header to make the file equivalent, but I'm
>> unsure
>> if they would
>>
> Hello, I have checked the binutils source, and have noticed that
> binutils already uses the ARRAY_SIZE macro, and this patch actually
> brings the kernel more in line with the equivalent file in binutils
> (opcodes/ppc-opc.c)

Ok.


Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>



> 
> As such, I would like to request that the patch be applied as-is.
> 
> Thank you
> 
> Ruben
> 
>> Ruben
>>
>>> Christophe
>>>
>>>
>>>>    1 file changed, 6 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/xmon/ppc-opc.c b/arch/powerpc/xmon/ppc-
>>>> opc.c
>>>> index 0774d711453e..de9b4236728c 100644
>>>> --- a/arch/powerpc/xmon/ppc-opc.c
>>>> +++ b/arch/powerpc/xmon/ppc-opc.c
>>>> @@ -954,8 +954,7 @@ const struct powerpc_operand
>>>> powerpc_operands[]
>>>> =
>>>>      { 0xff, 11, NULL, NULL, PPC_OPERAND_SIGNOPT },
>>>>    };
>>>>
>>>> -const unsigned int num_powerpc_operands = (sizeof
>>>> (powerpc_operands)
>>>> -                                          / sizeof
>>>> (powerpc_operands[0]));
>>>> +const unsigned int num_powerpc_operands =
>>>> ARRAY_SIZE(powerpc_operands);
>>>>
>>>>    /* The functions used to insert and extract complicated
>>>> operands.  */
>>>>
>>>> @@ -6968,9 +6967,8 @@ const struct powerpc_opcode
>>>> powerpc_opcodes[]
>>>> = {
>>>>    {"fcfidu.",    XRC(63,974,1),  XRA_MASK, POWER7|PPCA2,
>>>> PPCVLE,         {FRT, FRB}},
>>>>    };
>>>>
>>>> -const int powerpc_num_opcodes =
>>>> -  sizeof (powerpc_opcodes) / sizeof (powerpc_opcodes[0]);
>>>> -
>>>> +const int powerpc_num_opcodes = ARRAY_SIZE(powerpc_opcodes);
>>>> +
>>>>    /* The VLE opcode table.
>>>>
>>>>       The format of this opcode table is the same as the main
>>>> opcode
>>>> table.  */
>>>> @@ -7207,9 +7205,8 @@ const struct powerpc_opcode vle_opcodes[] =
>>>> {
>>>>    {"se_bl",      BD8(58,0,1),    BD8_MASK,       PPCVLE,
>>>> 0,              {B8}},
>>>>    };
>>>>
>>>> -const int vle_num_opcodes =
>>>> -  sizeof (vle_opcodes) / sizeof (vle_opcodes[0]);
>>>> -
>>>> +const int vle_num_opcodes = ARRAY_SIZE(vle_opcodes);
>>>> +
>>>>    /* The macro table.  This is only used by the assembler.  */
>>>>
>>>>    /* The expressions of the form (-x ! 31) & (x | 31) have the
>>>> value 0
>>>> @@ -7276,5 +7273,4 @@ const struct powerpc_macro powerpc_macros[]
>>>> =
>>>> {
>>>>    {"e_clrlslwi",4, PPCVLE, "e_rlwinm %0,%1,%3,(%2)-(%3),31-
>>>> (%3)"},
>>>>    };
>>>>
>>>> -const int powerpc_num_macros =
>>>> -  sizeof (powerpc_macros) / sizeof (powerpc_macros[0]);
>>>> +const int powerpc_num_macros = ARRAY_SIZE(powerpc_macros);
>>>> --
>>>> 2.49.1
>>>>


