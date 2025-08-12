Return-Path: <linux-kernel+bounces-764109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD071B21E1D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E229C502BF1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 06:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FA32DEA90;
	Tue, 12 Aug 2025 06:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mb3H/tVW"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7AD20C001
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754979365; cv=none; b=n7Dvux2RLDIYlIwcwMcQC9IM142jNau4iWWjeXEbSyD/qvbqn0CDpRrJspb05C3fIoSu7hpcvapNH1jK+1o6N9jUIZxx0po5VEy6MWUmJVzdRFRqvqkFZAdOTjD5xcDnjImTsP2S+j+NOpqiyLFKNE1IS4OvCkuDscsCLkkTByo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754979365; c=relaxed/simple;
	bh=UBgZc0gbbIXVBiFZNdSDMzCIkXeE7fHrfF7LLYhV3gQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MzaxWbwAPqsH0pdTEP9P0kQ7NGto9h6KoG4zoyCPnXzvPW+yDggry0vIwGawa8vR50TanEt8p4e1ghP+ZSd5MX8LLLEeZysouG6GvipRWAL8N5zLVX93UyClI7JXi21gNYGdmOYyU9DJiv/PH3bCrnUCPiUB2YEkCDNggAgXI80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mb3H/tVW; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6de97571-7ef0-4bbd-b55f-5ad41898a6ec@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754979359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v2gTpUJPUXvo+zC/3w7+1UJ07KaE1bkVttXQvFeeqeY=;
	b=mb3H/tVWq//a1igtQxsEAHJWv0y+bRdUerzjxr+nURYRzjnt5c7SfShRJdAdoGDZCO+Uso
	TchAHi4rro/RURbAc3ZGxGD0H1bHztQwxm5TrGW0Pt8xFFN+WYXw27ME5nc6lulfMn0zzK
	VgcyHFGUDauKxBSbIv7kWOF92P9rCUs=
Date: Tue, 12 Aug 2025 14:15:19 +0800
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <aJojDiHWi8cgvA2W@pie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi, Yao
On 2025/8/12 01:06, Yao Zi wrote:
> On Mon, Aug 11, 2025 at 05:26:55PM +0800, Youling Tang wrote:
>> From: Youling Tang <tangyouling@kylinos.cn>
>>
>> This patch adds support for kexec_file on LoongArch.
>>
>> The image_load() as two parts:
>> - the first part loads the kernel image (vmlinuz.efi or vmlinux.efi)
>> - the second part loads other segments (eg: initrd, cmdline)
>>
>> Currently, pez(vmlinuz.efi) and pei(vmlinux.efi) format images are supported,
>> but ELF format is not supported.
>>
>> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
>> ---
>>   arch/loongarch/Kconfig                     |   8 ++
>>   arch/loongarch/include/asm/image.h         |  18 ++++
>>   arch/loongarch/include/asm/kexec.h         |  12 +++
>>   arch/loongarch/kernel/Makefile             |   1 +
>>   arch/loongarch/kernel/kexec_image.c        | 112 +++++++++++++++++++++
>>   arch/loongarch/kernel/machine_kexec.c      |  33 ++++--
>>   arch/loongarch/kernel/machine_kexec_file.c |  46 +++++++++
>>   7 files changed, 219 insertions(+), 11 deletions(-)
>>   create mode 100644 arch/loongarch/kernel/kexec_image.c
>>   create mode 100644 arch/loongarch/kernel/machine_kexec_file.c
> ...
>
>> diff --git a/arch/loongarch/include/asm/image.h b/arch/loongarch/include/asm/image.h
>> index 1f090736e71d..829e1ecb1f5d 100644
>> --- a/arch/loongarch/include/asm/image.h
>> +++ b/arch/loongarch/include/asm/image.h
>> @@ -36,5 +36,23 @@ struct loongarch_image_header {
>>   	uint32_t pe_header;
>>   };
>>   
>> +static const uint8_t loongarch_image_pe_sig[2] = {'M', 'Z'};
>> +static const uint8_t loongarch_pe_machtype[6] = {'P', 'E', 0x0, 0x0, 0x64, 0x62};
> loongarch_pe_machtype isn't used at all.
It will be removed.
>
>> +
>> +/**
>> + * loongarch_header_check_pe_sig - Helper to check the loongarch image header.
>> + *
>> + * Returns non-zero if 'MZ' signature is found.
>> + */
>> +
>> +static inline int loongarch_header_check_pe_sig(const struct loongarch_image_header *h)
>> +{
>> +	if (!h)
>> +		return 0;
>> +
>> +	return (h->pe_sig[0] == loongarch_image_pe_sig[0]
>> +		&& h->pe_sig[1] == loongarch_image_pe_sig[1]);
> This could be simplified with a memcmp(). Also, this check isn't strict
> enough: PE files for any architectures, and even legacy MS-DOS COM
> executables all start with "MZ".
>
>> +}
>> +
>>   #endif /* __ASSEMBLY__ */
>>   #endif /* __ASM_IMAGE_H */
> ...
>
>> diff --git a/arch/loongarch/kernel/kexec_image.c b/arch/loongarch/kernel/kexec_image.c
>> new file mode 100644
>> index 000000000000..fdd1845b4e2e
>> --- /dev/null
>> +++ b/arch/loongarch/kernel/kexec_image.c
>> @@ -0,0 +1,112 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Kexec image loader for LoongArch
>> +
>> + * Author: Youling Tang <tangyouling@kylinos.cn>
>> + * Copyright (C) 2025 KylinSoft Corporation.
>> + */
>> +
>> +#define pr_fmt(fmt)	"kexec_file(Image): " fmt
>> +
>> +#include <linux/err.h>
>> +#include <linux/errno.h>
>> +#include <linux/kernel.h>
>> +#include <linux/kexec.h>
>> +#include <linux/pe.h>
>> +#include <linux/string.h>
>> +#include <asm/byteorder.h>
>> +#include <asm/cpufeature.h>
>> +#include <asm/image.h>
>> +
>> +static int image_probe(const char *kernel_buf, unsigned long kernel_len)
>> +{
>> +	const struct loongarch_image_header *h =
>> +		(const struct loongarch_image_header *)(kernel_buf);
> Parentheses around "kernel_buf" are unnecessary.
It will be removed.
>
>> +	if (!h || (kernel_len < sizeof(*h))) {
> Comparisons have higher priority than logic operations, so this pair of
> parentheses is redundant, too.
Yes, but the parentheses will be retained for greater readability.
>
>> +		pr_err("No loongarch image header.\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!loongarch_header_check_pe_sig(h)) {
>> +		pr_err("Bad loongarch PE image header.\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void *image_load(struct kimage *image,
>> +				char *kernel, unsigned long kernel_len,
>> +				char *initrd, unsigned long initrd_len,
>> +				char *cmdline, unsigned long cmdline_len)
>> +{
>> +	struct loongarch_image_header *h;
>> +	struct kexec_buf kbuf;
>> +	unsigned long text_offset, kernel_segment_number;
>> +	struct kexec_segment *kernel_segment;
>> +	int ret;
>> +
>> +	h = (struct loongarch_image_header *)kernel;
>> +	if (!h->image_size)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	/* Load the kernel */
>> +	kbuf.image = image;
>> +	kbuf.buf_min = 0;
>> +	kbuf.buf_max = ULONG_MAX;
>> +	kbuf.top_down = false;
>> +
>> +	kbuf.buffer = kernel;
>> +	kbuf.bufsz = kernel_len;
>> +	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>> +	kbuf.memsz = le64_to_cpu(h->image_size);
>> +	text_offset = le64_to_cpu(h->text_offset);
>> +	kbuf.buf_align = SZ_2M;
> I think this aligment is unnecessary for relocatable LoongArch kernels:
> it should be enough to align to the page size. See also my comments
> below.
>
>> +	kernel_segment_number = image->nr_segments;
>> +
>> +	/*
>> +	 * The location of the kernel segment may make it impossible to satisfy
>> +	 * the other segment requirements, so we try repeatedly to find a
>> +	 * location that will work.
>> +	 */
>> +	while ((ret = kexec_add_buffer(&kbuf)) == 0) {
>> +		/* Try to load additional data */
>> +		kernel_segment = &image->segment[kernel_segment_number];
>> +		ret = load_other_segments(image, kernel_segment->mem,
>> +					  kernel_segment->memsz, initrd,
>> +					  initrd_len, cmdline, cmdline_len);
>> +		if (!ret)
>> +			break;
>> +
>> +		/*
>> +		 * We couldn't find space for the other segments; erase the
>> +		 * kernel segment and try the next available hole.
>> +		 */
>> +		image->nr_segments -= 1;
>> +		kbuf.buf_min = kernel_segment->mem + kernel_segment->memsz;
>> +		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>> +	}
>> +
>> +	if (ret) {
>> +		pr_err("Could not find any suitable kernel location!");
>> +		return ERR_PTR(ret);
>> +	}
>> +
>> +	kernel_segment = &image->segment[kernel_segment_number];
>> +
>> +	/* Make sure the second kernel jumps to the correct "kernel_entry". */
>> +	image->start = kernel_segment->mem + h->kernel_entry - text_offset;
> A non-relocatable loongarch kernel cannot be loaded to arbitrary
> address. Thus this loading function seems to only work for relocatable
> kernels, maybe it's better to leave a comment indicating the limitation.
>
> For now, we don't seem to have a way to find out whether the kernel is
> relocatable (for example, a flag in kernel image header), so it's
> impossible to point out whether the loaded kernel boots fine with
> arbitrary loading address...
LoongArch enables the relocation of the kernel when the kdump
feature is enabled.

config ARCH_SELECTS_CRASH_DUMP
         def_bool y
         depends on CRASH_DUMP
         select RELOCATABLE

After enabling the relocation, LoongArch is the PIE kernel. For
more details, please refer to commit d8da19fbdedd ("LoongArch:
Add support for kernel relocation")
>> +	kexec_dprintk("Loaded kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
>> +		      kernel_segment->mem, kbuf.bufsz,
>> +		      kernel_segment->memsz);
>> +
>> +	return NULL;
>> +}
>> +
>> +const struct kexec_file_ops kexec_image_ops = {
>> +	.probe = image_probe,
>> +	.load = image_load,
>> +};
>> diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kernel/machine_kexec.c
>> index f9381800e291..008f43e26120 100644
>> --- a/arch/loongarch/kernel/machine_kexec.c
>> +++ b/arch/loongarch/kernel/machine_kexec.c
>> @@ -70,18 +70,28 @@ int machine_kexec_prepare(struct kimage *kimage)
> ...
>
>> -	if (!kimage->arch.cmdline_ptr) {
>> -		pr_err("Command line not included in the provided image\n");
>> -		return -EINVAL;
>> +		if (!kimage->arch.cmdline_ptr) {
>> +			pr_err("Command line not included in the provided image\n");
>> +			return -EINVAL;
>> +		}
>>   	}
>>   
>>   	/* kexec/kdump need a safe page to save reboot_code_buffer */
>> @@ -288,7 +298,8 @@ void machine_kexec(struct kimage *image)
>>   	local_irq_disable();
>>   
>>   	pr_notice("EFI boot flag 0x%lx\n", efi_boot);
>> -	pr_notice("Command line at 0x%lx\n", cmdline_ptr);
>> +	pr_notice("Command line addr at 0x%lx\n", cmdline_ptr);
>> +	pr_notice("Command line at %s\n", (char *)cmdline_ptr);
> The printed message doesn't match meaning of the pointer: you're
> printing the content of cmdline_ptr, instead of its address, thus
> "Command line at" sounds confusing to me.
I will correct it.

Thanks,
Youling.
>
> Furthermore, this chunk isn't related to "support for kexec_file", I
> think it's better to separate it into another patch (or even another
> series).
>
>>   	pr_notice("System table at 0x%lx\n", systable_ptr);
>>   	pr_notice("We will call new kernel at 0x%lx\n", start_addr);
>>   	pr_notice("Bye ...\n");
> Best regards,
> Yao Zi

