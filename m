Return-Path: <linux-kernel+bounces-804078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8422B4698A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 08:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA1B058725F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 06:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4118F315D4A;
	Sat,  6 Sep 2025 06:50:38 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C394326773C
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 06:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757141437; cv=none; b=JnPJKrRERKea82BXoWXmAVv6LWFEpOyQqhrdy5RA8FInw60SOqR9r88vCyzj/1dts+b1/SVqbwqSe/XrEp6L9JXEnWh+htdtVWnX8xn+1w2g+joGfzHaocKObQ+/bLfbcL4Zo7D6yc3MEHH8exkrEquLNk3ZQseHs5IJRCvIEU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757141437; c=relaxed/simple;
	bh=fNbaQwBvNzrsbvGuXsLYce653AT80uzWgvFOpCgCr6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZJuWSsXlUIAJSxDny0wqDm1oIwAZOstEmDjj+jG0XwY1MchGsTciGUDmj8/SfJqZEPz/FvDjilnwsZlVL1BPa0MiIeeB/5p7SgVht9kGg98xMWAlMo8A3WfqPnShyWnBspf5PnkvZ+VIQgn6eIpDf15xMNAC/DubVlrhkIXpP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cJkCj5Mvkz9sS7;
	Sat,  6 Sep 2025 08:42:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ofr8zKUh7ixS; Sat,  6 Sep 2025 08:42:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cJkCj4F9Kz9sRy;
	Sat,  6 Sep 2025 08:42:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 769E58B776;
	Sat,  6 Sep 2025 08:42:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id O04ntYOWCf3E; Sat,  6 Sep 2025 08:42:09 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id BDEE08B773;
	Sat,  6 Sep 2025 08:42:08 +0200 (CEST)
Message-ID: <1b4cc6d5-5f5b-4b39-8fdf-ac02c94cd5e2@csgroup.eu>
Date: Sat, 6 Sep 2025 08:42:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] powerpc: Panic on jump label code patching failure
To: "Ritesh Harjani (IBM)" <riteshh@linux.ibm.com>,
 Andrew Donnellan <ajd@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
 peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com
Cc: npiggin@gmail.com, rostedt@goodmis.org, ardb@kernel.org,
 Erhard Furtner <erhard_f@mailbox.org>
References: <20250905061135.1451362-1-ajd@linux.ibm.com>
 <87qzwki6fv.fsf@ritesh.list@gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <87qzwki6fv.fsf@ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 06/09/2025 à 05:52, Ritesh Harjani a écrit :
> [Vous ne recevez pas souvent de courriers de riteshh@linux.ibm.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> Andrew Donnellan <ajd@linux.ibm.com> writes:
> 
>> If patch_branch() or patch_instruction() fails while updating a jump
>> label, we presently fail silently, leading to unpredictable behaviour
>> later on.
>>
>> Change arch_jump_label_transform() to panic on a code patching failure,
>> matching the existing behaviour of arch_static_call_transform().
>>
>> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
>> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
>>
>> ---
>>
>> Ran into this while debugging an issue that Erhard reported to me about my
>> PAGE_TABLE_CHECK series on a G4, where updating a static key failed
>> silently, but only for one call site, leading to an incorrect reference
>> count later on. This looks to be due to the issue fixed in [0]. A loud
>> failure would have saved us all considerable debugging time.
>>
>> Should I change the return type of arch_jump_label_transform() and handle
>> this in an arch-independent way? Are there other users of code patching
>> in powerpc that ought to be hardened?
>>
>> Or is this excessive?
>>
>> [0] https://patchwork.ozlabs.org/project/linuxppc-dev/patch/4b5e6eb281d7b1ea77619bee17095f905a125168.1757003584.git.christophe.leroy@csgroup.eu/
>> ---
>>   arch/powerpc/kernel/jump_label.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/jump_label.c b/arch/powerpc/kernel/jump_label.c
>> index 2659e1ac8604..80d41ed7ac50 100644
>> --- a/arch/powerpc/kernel/jump_label.c
>> +++ b/arch/powerpc/kernel/jump_label.c
>> @@ -12,9 +12,14 @@ void arch_jump_label_transform(struct jump_entry *entry,
>>                               enum jump_label_type type)
>>   {
>>        u32 *addr = (u32 *)jump_entry_code(entry);
>> +     int err;
>>
>>        if (type == JUMP_LABEL_JMP)
>> -             patch_branch(addr, jump_entry_target(entry), 0);
>> +             err = patch_branch(addr, jump_entry_target(entry), 0);
>>        else
>> -             patch_instruction(addr, ppc_inst(PPC_RAW_NOP()));
>> +             err = patch_instruction(addr, ppc_inst(PPC_RAW_NOP()));
>> +
>> +     if (err)
>> +             panic("%s: patching failed, err %d, type %d, addr %pS, target %pS\n",
>> +                   __func__, err, type, addr, (void *)jump_entry_target(entry));
>>   }
> 
> arch_jump_label_transform() is mainly getting called from
> __jump_level_update() and it's used for enabling or updating static keys / branch.
> 
> But static keys can also be used by drivers / module subsystem whose
> initialization happens late. Although I understand that if the above
> fails, it might fail much before, from the arch setup code itself, but
> panic() still feels like a big hammer.

But not being able to patch the kernel as required means that you get a 
kernel behaving differently from what is expected.

Imagine a kernel running on a board that is controlling a saw. There is 
a patch_instruction() to activate the safety feature which detects when 
your hands are too close to the blade. Do you want the kernel to 
continue running seamlessly when that patch_instruction() fails ? I'm 
sure you don't !

> 
> Would pr_err() print with WARN_ON_ONCE(1) would suffice in case of an
> err?

No, that's not enough, you can't rely on a kernel that will no behave as 
expected.

> 
> Also you said you ran into a problem at just one call site where above
> was silently failing. With the above change are you able to hit the
> panic() now? Because from what I see in patch_instruction(), it mainly
> will boil down to calling __patch_mem() which always returns 0.

As far as I can see, __patch_mem() returns -EPERM when 
__put_kernel_nofault() fails:

static int __patch_mem(void *exec_addr, unsigned long val, void 
*patch_addr, bool is_dword)
{
	if (!IS_ENABLED(CONFIG_PPC64) || likely(!is_dword)) {
		/* For big endian correctness: plain address would use the wrong half */
		u32 val32 = val;

		__put_kernel_nofault(patch_addr, &val32, u32, failed);
	} else {
		__put_kernel_nofault(patch_addr, &val, u64, failed);
	}

	asm ("dcbst 0, %0; sync; icbi 0,%1; sync; isync" :: "r" (patch_addr),
							    "r" (exec_addr));

	return 0;

failed:
	mb();  /* sync */
	return -EPERM;
}


> Although there are other places where there can be an error returned,
> so I was wondering if that is what you were hitting or something else?

Andrew was hitting the -EPERM because the memory area was read-only.

Christophe

