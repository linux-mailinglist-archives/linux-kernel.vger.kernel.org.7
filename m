Return-Path: <linux-kernel+bounces-765776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 896FEB23E22
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 04:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D0DB583930
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 02:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9FD1C9DE5;
	Wed, 13 Aug 2025 02:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IVFGGoMY"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E57273FD
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 02:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755051560; cv=none; b=lsEG7RYoO6uuDrn+iEgZPqcJooRP8On6sn7T/8uAKU3Bwui/cmKtbnrO12sfn43URx1XhR6yXb1NnN4+8kWOJ8bYwsBCh0bCSkJu43/Ft5Sn5bd+YdGUWPpgDFBChM0BDYwPMxNVP3V5xOLrMoeQ/dEivS/cnqub0nXPM1F9pSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755051560; c=relaxed/simple;
	bh=dRM+6DqjoWj7xIway7qOT3MeBBrgzJLjy6gwSB8nqGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mpi8+NdW3j+EkwcnhrTeyr0MudfZYo/8qkdgOhIpK4diJKsT4/9qn8k8LOv3OIlKk4xt1UG+1rty6fhZWv0aCP4gq4CDwBrSM1BC6PzG1sjFPx+QByXMw0yxrrHJNcXRr4TdMtq6nmwsvpjDZnUrowjcA357EjjG1erbFwnst3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IVFGGoMY; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <27513334-3086-4353-bf6c-fdee082a8ce8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755051545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nMss20SDGbXY1dMDpG7fyXCbHMpQ4bsQAbINwnsqRUk=;
	b=IVFGGoMYVDBJ/itT32notwts4Tsq6ydD6JQ45HSQ6xmLgXBPG7MeIB3uTKEfv9N2Ag/SSM
	lg2gL/PtD4wdZt5iJpBJrVUYMvifKRpR9ShWuG0MAm+niPM0J4Mngr7ak7Uguoq7FoH+Ck
	IQqfivki9GyuYP6E7H++OwkL5+w/m68=
Date: Wed, 13 Aug 2025 10:18:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/6] LoongArch: Add kexec_file support
To: Yao Zi <ziyao@disroot.org>, Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
References: <20250811092659.14903-1-youling.tang@linux.dev>
 <20250811092659.14903-3-youling.tang@linux.dev> <aJojDiHWi8cgvA2W@pie>
 <6de97571-7ef0-4bbd-b55f-5ad41898a6ec@linux.dev>
 <af866071-81c1-44d5-ae02-273d6e9c04d4@linux.dev> <aJsGg8__ppyBrkfL@pie>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <aJsGg8__ppyBrkfL@pie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi, Yao
On 2025/8/12 17:43, Yao Zi wrote:
> On Tue, Aug 12, 2025 at 03:06:23PM +0800, Youling Tang wrote:
>> On 2025/8/12 14:15, Youling Tang wrote:
>>> Hi, Yao
>>> On 2025/8/12 01:06, Yao Zi wrote:
>>>> On Mon, Aug 11, 2025 at 05:26:55PM +0800, Youling Tang wrote:
>>>>> From: Youling Tang <tangyouling@kylinos.cn>
>>>>>
>>>>> This patch adds support for kexec_file on LoongArch.
>>>>>
>>>>> The image_load() as two parts:
>>>>> - the first part loads the kernel image (vmlinuz.efi or vmlinux.efi)
>>>>> - the second part loads other segments (eg: initrd, cmdline)
>>>>>
>>>>> Currently, pez(vmlinuz.efi) and pei(vmlinux.efi) format images
>>>>> are supported,
>>>>> but ELF format is not supported.
>>>>>
>>>>> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
>>>>> ---
>>>>>    arch/loongarch/Kconfig                     |   8 ++
>>>>>    arch/loongarch/include/asm/image.h         |  18 ++++
>>>>>    arch/loongarch/include/asm/kexec.h         |  12 +++
>>>>>    arch/loongarch/kernel/Makefile             |   1 +
>>>>>    arch/loongarch/kernel/kexec_image.c        | 112
>>>>> +++++++++++++++++++++
>>>>>    arch/loongarch/kernel/machine_kexec.c      |  33 ++++--
>>>>>    arch/loongarch/kernel/machine_kexec_file.c |  46 +++++++++
>>>>>    7 files changed, 219 insertions(+), 11 deletions(-)
>>>>>    create mode 100644 arch/loongarch/kernel/kexec_image.c
>>>>>    create mode 100644 arch/loongarch/kernel/machine_kexec_file.c
> ...
>
>>>>> diff --git a/arch/loongarch/kernel/kexec_image.c
>>>>> b/arch/loongarch/kernel/kexec_image.c
>>>>> new file mode 100644
>>>>> index 000000000000..fdd1845b4e2e
>>>>> --- /dev/null
>>>>> +++ b/arch/loongarch/kernel/kexec_image.c
> ...
>
>>>>> +    /*
>>>>> +     * The location of the kernel segment may make it
>>>>> impossible to satisfy
>>>>> +     * the other segment requirements, so we try repeatedly to find a
>>>>> +     * location that will work.
>>>>> +     */
>>>>> +    while ((ret = kexec_add_buffer(&kbuf)) == 0) {
>>>>> +        /* Try to load additional data */
>>>>> +        kernel_segment = &image->segment[kernel_segment_number];
>>>>> +        ret = load_other_segments(image, kernel_segment->mem,
>>>>> +                      kernel_segment->memsz, initrd,
>>>>> +                      initrd_len, cmdline, cmdline_len);
>>>>> +        if (!ret)
>>>>> +            break;
>>>>> +
>>>>> +        /*
>>>>> +         * We couldn't find space for the other segments; erase the
>>>>> +         * kernel segment and try the next available hole.
>>>>> +         */
>>>>> +        image->nr_segments -= 1;
>>>>> +        kbuf.buf_min = kernel_segment->mem + kernel_segment->memsz;
>>>>> +        kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>>>>> +    }
>>>>> +
>>>>> +    if (ret) {
>>>>> +        pr_err("Could not find any suitable kernel location!");
>>>>> +        return ERR_PTR(ret);
>>>>> +    }
>>>>> +
>>>>> +    kernel_segment = &image->segment[kernel_segment_number];
>>>>> +
>>>>> +    /* Make sure the second kernel jumps to the correct
>>>>> "kernel_entry". */
>>>>> +    image->start = kernel_segment->mem + h->kernel_entry -
>>>>> text_offset;
>>>> A non-relocatable loongarch kernel cannot be loaded to arbitrary
>>>> address. Thus this loading function seems to only work for relocatable
>>>> kernels, maybe it's better to leave a comment indicating the limitation.
>>>>
>>>> For now, we don't seem to have a way to find out whether the kernel is
>>>> relocatable (for example, a flag in kernel image header), so it's
>>>> impossible to point out whether the loaded kernel boots fine with
>>>> arbitrary loading address...
>>> LoongArch enables the relocation of the kernel when the kdump
>>> feature is enabled.
>>>
>>> config ARCH_SELECTS_CRASH_DUMP
>>>          def_bool y
>>>          depends on CRASH_DUMP
>>>          select RELOCATABLE
>>>
> This only means the currently-running kernel is relocatable, not the one
> being exec'ed, right?
No.
>> When enabling KEXEC_FILE, the RELOCATABLE configuration should
>> also be enabled. Both kexec and kdump require this.
> I'm not sure whether you're talking about the running kernel or the one
> that is going to be exec'ed. This method of kernel loading requires the
> exec'ed kernel being relocatable, not the currently running one.
>
> And I think it's totally reasonable to use KEXEC_FILE for non-crash-dump
> purpose, for example, linuxboot. It'll be confusing to the user if the
> system just hangs after booting a non-relocatable kernel, which is hard
> to debug.
>
> Thus IMHO we should ideally refuse to load non-relocatable kernels, or
> add a FIXME comment to indicate the situation that it's impossible to
> determine whether the exec'ed image is relocatable.
The first kernel and the second kernel are generally the same kernel
(the same image). When KEXEC_FILE is enabled and RELOCATEABLE
is enabled by default, it has been forcibly guaranteed that both the
first kernel and the second kernel are relocatable kernels regardless
of kexec/kdump operations.

Unless the second kernel it loads is an older version of the kernel (the
older version of the kernel does not use the default configuration, with
CONFIG_KEXEC enabled but CONFIG_CRASH_DUMP disabled, this is not acorrect
usage).

Thanks,
Youling.
>> Youling.
>>> After enabling the relocation, LoongArch is the PIE kernel. For
>>> more details, please refer to commit d8da19fbdedd ("LoongArch:
>>> Add support for kernel relocation")
> Best regards.
> Yao Zi

