Return-Path: <linux-kernel+bounces-764462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAA6B2234C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02BF1AA049A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAC22E7BB1;
	Tue, 12 Aug 2025 09:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E/7GW/RO"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DA12E88A2
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754991194; cv=none; b=c+GcgSMGqjsBZMWvUvNfZtCwzXjDEQ+z0aBVhfGHKHCStEXH5hx9fvVJDXfDTmz5HBCMbY9BETFLEFvHqHfoVc/PyW5N4oEEiWyhix56HO2eTwp2ffsyuMsUzovM+4nn6urzr81P6Qh5Pox6/EE5ewx6CG3Fx1pclr6uslpFEWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754991194; c=relaxed/simple;
	bh=45UEym4ypBzRwCttExpHYuZEvNg4l/GdXxzZbyZJX3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nlp2e6+11Vwfb58laTtei4jhfrdjrkuiDPmcYXZoF2cUqSYLhEFIoqEEMHRWNa97cIuVZk8wpHEcc95SgSH8yL+dL7q5vjPkhQVRujJbu4GmG9Iw8bUNzHvTtKA/xNto/g66S/eoedTTEu9tY11e6c2Yf7w3bS2rkmYTptPYwWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E/7GW/RO; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ef249b61-f37e-4b72-9610-7f114564988a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754991175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UB0EMZuXYKOyyxldrdbQ63aHyFJ+9vuYs0ibMI6aTWo=;
	b=E/7GW/RORpntKNSzjue4zCvcXnS3P+iV9m+YlyMAyxJYVmthvQH5CSENyWcj+IciXmG/d8
	Fl2CnYA7F7MrOurBihPqvmoUaPJbWhXzUKEDAoRKFDxHOAP8piIvc5AHVNfPuQlEQPHA7G
	9ZfTya60lIenlfgcBWsgcrnQzAHsqlo=
Date: Tue, 12 Aug 2025 17:32:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/6] LoongArch: Add kexec_file support
To: Yanteng Si <si.yanteng@linux.dev>, Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
References: <20250811092659.14903-1-youling.tang@linux.dev>
 <20250811092659.14903-3-youling.tang@linux.dev>
 <CAAhV-H55n=v+ztBc8UgK339kuhg3LKvcOQu+jhpVrbvO3zf3=g@mail.gmail.com>
 <9760e574-3eb0-46b2-bccd-916f73b9c39e@linux.dev>
 <ce63aa14-11a5-4b2c-bfbc-8465b7065197@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <ce63aa14-11a5-4b2c-bfbc-8465b7065197@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi, Yanteng
On 2025/8/12 09:53, Yanteng Si wrote:
> 在 8/12/25 9:21 AM, Youling Tang 写道:
>> Hi, Huacai
>> On 2025/8/11 22:07, Huacai Chen wrote:
>>> Hi, Youling,
>>>
>>> On Mon, Aug 11, 2025 at 5:28 PM Youling Tang 
>>> <youling.tang@linux.dev> wrote:
>>>> From: Youling Tang <tangyouling@kylinos.cn>
>>>>
>>>> This patch adds support for kexec_file on LoongArch.
>>>>
>>>> The image_load() as two parts:
>>>> - the first part loads the kernel image (vmlinuz.efi or vmlinux.efi)
>>>> - the second part loads other segments (eg: initrd, cmdline)
>>>>
>>>> Currently, pez(vmlinuz.efi) and pei(vmlinux.efi) format images are 
>>>> supported,
>>>> but ELF format is not supported.
>>>>
>>>> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
>>>> ---
>>>>   arch/loongarch/Kconfig                     |   8 ++
>>>>   arch/loongarch/include/asm/image.h         |  18 ++++
>>>>   arch/loongarch/include/asm/kexec.h         |  12 +++
>>>>   arch/loongarch/kernel/Makefile             |   1 +
>>>>   arch/loongarch/kernel/kexec_image.c        | 112 
>>>> +++++++++++++++++++++
>>>>   arch/loongarch/kernel/machine_kexec.c      |  33 ++++--
>>>>   arch/loongarch/kernel/machine_kexec_file.c |  46 +++++++++
>>>>   7 files changed, 219 insertions(+), 11 deletions(-)
>>>>   create mode 100644 arch/loongarch/kernel/kexec_image.c
>>>>   create mode 100644 arch/loongarch/kernel/machine_kexec_file.c
>>>>
>>>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>>>> index f0abc38c40ac..fd50c83f7827 100644
>>>> --- a/arch/loongarch/Kconfig
>>>> +++ b/arch/loongarch/Kconfig
>>>> @@ -625,6 +625,14 @@ config CPU_HAS_PREFETCH
>>>>   config ARCH_SUPPORTS_KEXEC
>>>>          def_bool y
>>>>
>>>> +config ARCH_SUPPORTS_KEXEC_FILE
>>>> +       def_bool 64BIT
>>>> +
>>>> +config ARCH_SELECTS_KEXEC_FILE
>>>> +       def_bool y
>>>> +       depends on KEXEC_FILE
>>>> +       select HAVE_IMA_KEXEC if IMA
>>>> +
>>>>   config ARCH_SUPPORTS_CRASH_DUMP
>>>>          def_bool y
>>>>
>>>> diff --git a/arch/loongarch/include/asm/image.h 
>>>> b/arch/loongarch/include/asm/image.h
>>>> index 1f090736e71d..829e1ecb1f5d 100644
>>>> --- a/arch/loongarch/include/asm/image.h
>>>> +++ b/arch/loongarch/include/asm/image.h
>>>> @@ -36,5 +36,23 @@ struct loongarch_image_header {
>>>>          uint32_t pe_header;
>>>>   };
>>>>
>>>> +static const uint8_t loongarch_image_pe_sig[2] = {'M', 'Z'};
>>>> +static const uint8_t loongarch_pe_machtype[6] = {'P', 'E', 0x0, 
>>>> 0x0, 0x64, 0x62};
>>>> +
>>>> +/**
>>>> + * loongarch_header_check_pe_sig - Helper to check the loongarch 
>>>> image header.
>>>> + *
>>>> + * Returns non-zero if 'MZ' signature is found.
>>>> + */
>>>> +
>>>> +static inline int loongarch_header_check_pe_sig(const struct 
>>>> loongarch_image_header *h)
>>>> +{
>>>> +       if (!h)
>>>> +               return 0;
>>>> +
>>>> +       return (h->pe_sig[0] == loongarch_image_pe_sig[0]
>>>> +               && h->pe_sig[1] == loongarch_image_pe_sig[1]);
>>>> +}
>>>> +
>>>>   #endif /* __ASSEMBLY__ */
>>>>   #endif /* __ASM_IMAGE_H */
>>>> diff --git a/arch/loongarch/include/asm/kexec.h 
>>>> b/arch/loongarch/include/asm/kexec.h
>>>> index cf95cd3eb2de..3ef8517a3670 100644
>>>> --- a/arch/loongarch/include/asm/kexec.h
>>>> +++ b/arch/loongarch/include/asm/kexec.h
>>>> @@ -41,6 +41,18 @@ struct kimage_arch {
>>>>          unsigned long systable_ptr;
>>>>   };
>>>>
>>>> +#ifdef CONFIG_KEXEC_FILE
>>>> +extern const struct kexec_file_ops kexec_image_ops;
>>>> +
>>>> +int arch_kimage_file_post_load_cleanup(struct kimage *image);
>>>> +#define arch_kimage_file_post_load_cleanup 
>>>> arch_kimage_file_post_load_cleanup
>>>> +
>>>> +extern int load_other_segments(struct kimage *image,
>>>> +               unsigned long kernel_load_addr, unsigned long 
>>>> kernel_size,
>>>> +               char *initrd, unsigned long initrd_len,
>>>> +               char *cmdline, unsigned long cmdline_len);
>>> I think the RISC-V naming "load_extra_segments" is better.
>> This name is also fine, but I prefer it to be consistent with
>> that in kexec-tools.
> I have looked at the code of kexec-tools, and it seems that you 
> referenced a great deal of ARM code when implementing the LoongArch part.
>
>
>>>
>>>> +#endif
>>>> +
>>>>   typedef void (*do_kexec_t)(unsigned long efi_boot,
>>>>                             unsigned long cmdline_ptr,
>>>>                             unsigned long systable_ptr,
>>>> diff --git a/arch/loongarch/kernel/Makefile 
>>>> b/arch/loongarch/kernel/Makefile
>>>> index 6f5a4574a911..bd9405ee3888 100644
>>>> --- a/arch/loongarch/kernel/Makefile
>>>> +++ b/arch/loongarch/kernel/Makefile
>>>> @@ -62,6 +62,7 @@ obj-$(CONFIG_MAGIC_SYSRQ)     += sysrq.o
>>>>   obj-$(CONFIG_RELOCATABLE)      += relocate.o
>>>>
>>>>   obj-$(CONFIG_KEXEC_CORE)       += machine_kexec.o relocate_kernel.o
>>>> +obj-$(CONFIG_KEXEC_FILE)       += machine_kexec_file.o kexec_image.o
>>> We only support the efi format, so we don't need to split a
>>> kexec_image.c like RISC-V, just put everything into
>>> machine_kexec_file.c is OK.
>> I hope it is separated and consistent with other architectures.
>> For instance, arm64 only supports one type.
> The ARM64 architecture has a long history, and we shouldn't be 
> constrained by it.
Support for kexec_elf.c in ELF format may be considered for
addition in the future.

Thanks,
Youling.
>
>
> Thanks,
> Yanteng
>>
>> Youling.
>>>
>>> Huacai

