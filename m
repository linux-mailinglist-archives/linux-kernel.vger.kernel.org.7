Return-Path: <linux-kernel+bounces-763956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9475B21C01
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 06:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D732682F93
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 04:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E070C2D5C91;
	Tue, 12 Aug 2025 04:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qhuHlinE"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F02DB665
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 04:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754971585; cv=none; b=Qz4SOWsCP1LMs7OmJrBGxMSdzDiYU3kieQ2tdSQH6iFW0VwJl44MdetZW9xuw+ZD/CA1f3E69NMYBlCis6RM81fxskwSr5OQTN8QXcWUtfY8SmjAmfO4xUpUdiublvL2GeM/STiEmTRpP40B0NCOJ1feRqeUbHAUw0Le594HbbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754971585; c=relaxed/simple;
	bh=p8t6k+6GXovC5uDxdFfBS/FvVWKNaHn6GXxjO/8jQDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j3xxchsS30RXvYQRbDcKS0C12kHC05gWel+MQOY4hkWjkA7zQyyuO4hmyMGlpFZ6cST8/qUGKIVKOGpXeOkpwZmOCmI3N0xXt4+CegVuKTBZtdStfgHp9z0mDjZP9bLwBgDQpa1mPLlCR8Taa7rafiQpEv2TPgIYKqrOc5C0yI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qhuHlinE; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0767b8fe-7c04-4e73-9235-ee326ee058cc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754971570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gBKYKsRpkFn4IgKj6ShKVJvxeOJHa9l2mWxrzZCMV7Q=;
	b=qhuHlinEYuRlBDjMI4MbGx0/KxiYdhdqOPfLP0oqsPpOj0jhFjA54EiI3M8GXC6Pk8EVb2
	/qR3qQmpSiB5bweQlDPHRe22e6PYfTC+EImtk1BWutMGnco8opavqMnN7zPSLplYoArMLo
	oySeWvOUlkHDpU7+xZL/bAN7td1TSM8=
Date: Tue, 12 Aug 2025 12:05:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/6] LoongArch/kexec_file: Add initrd loading
To: Yao Zi <ziyao@disroot.org>, Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
References: <20250811092659.14903-1-youling.tang@linux.dev>
 <20250811092659.14903-4-youling.tang@linux.dev> <aJovKIKFqX6xi9ra@pie>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <aJovKIKFqX6xi9ra@pie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi, Yao
On 2025/8/12 01:58, Yao Zi wrote:
> On Mon, Aug 11, 2025 at 05:26:56PM +0800, Youling Tang wrote:
>> From: Youling Tang <tangyouling@kylinos.cn>
>>
>> Add inird loading support and pass it to the second kernel via the
>> cmdline 'initrd=start,size'.
> I think This won't work if the exec'ed kernel enables
> CONFIG_CMDLINE_FORCE. Is it possible to mimic libstub's behavior of
> installing a configuration table LINUX_EFI_INITRD_MEDIA_GUID?
The command line passed by kexec to the second kernel has no effect if
CONFIG_CMDLINE_FORCE is enabled, which is not quite suitable for the
kexec scenario.

Currently, the initrd, elfcorehdr, and mem parameters will all be passed
through the command line to maintain consistency with the implementation
behavior of kexec-tools. It is possible that the content of systab will
be modified in the future and some parts will be integrated into systab
(the current cmdline mode will be better compatible with the elf kernel).
>
>> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
>> ---
>>   arch/loongarch/kernel/machine_kexec_file.c | 71 ++++++++++++++++++++++
>>   1 file changed, 71 insertions(+)
>>
>> diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
>> index bc91ae0afa4c..e1240644f529 100644
>> --- a/arch/loongarch/kernel/machine_kexec_file.c
>> +++ b/arch/loongarch/kernel/machine_kexec_file.c
>> @@ -34,13 +34,84 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
>>   	return kexec_image_post_load_cleanup_default(image);
>>   }
>>   
>> +/* Adds the "initrd=start,size" command line parameter to command line. */
>> +static void cmdline_add_initrd(struct kimage *image, unsigned long *cmdline_tmplen,
>> +				char *modified_cmdline, unsigned long initrd)
>> +{
>> +	int initrd_strlen;
>> +
>> +	initrd_strlen = sprintf(modified_cmdline + (*cmdline_tmplen), "initrd=0x%lx,0x%lx ",
> modified_cmdline is allocated as COMMAND_LINE_SIZE bytes, thus I think
> it's possible to overflow the buffer.
At this point, modified_cmdline can clearly know that it only stores
the additional commands we add (initrd,mem,elfcorehdr), and will not
exceed COMMAND_LINE_SIZE.
>
>> +		initrd, image->initrd_buf_len);
>> +	*cmdline_tmplen += initrd_strlen;
>> +}
>> +
>> +/*
>> + * Tries to add the initrd to the image. If it is not possible to find
>> + * valid locations, this function will undo changes to the image and return non
>> + * zero.
>> + */
>>   int load_other_segments(struct kimage *image,
>>   			unsigned long kernel_load_addr,
>>   			unsigned long kernel_size,
>>   			char *initrd, unsigned long initrd_len,
>>   			char *cmdline, unsigned long cmdline_len)
>>   {
>> +	struct kexec_buf kbuf;
>> +	unsigned long orig_segments = image->nr_segments;
>> +	char *modified_cmdline = NULL;
>> +	unsigned long cmdline_tmplen = 0;
>> +	unsigned long initrd_load_addr = 0;
>> +	int ret = 0;
>> +
>> +
>> +	kbuf.image = image;
>> +	/* not allocate anything below the kernel */
>> +	kbuf.buf_min = kernel_load_addr + kernel_size;
>> +
>> +	modified_cmdline = kzalloc(COMMAND_LINE_SIZE, GFP_KERNEL);
>> +	if (!modified_cmdline)
>> +		return -EINVAL;
>> +
>> +	/* Ensure it's nul terminated */
>> +	modified_cmdline[COMMAND_LINE_SIZE - 1] = '\0';
>> +
>> +	/* load initrd */
>> +	if (initrd) {
>> +		kbuf.buffer = initrd;
>> +		kbuf.bufsz = initrd_len;
>> +		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>> +		kbuf.memsz = initrd_len;
>> +		kbuf.buf_align = 0;
>> +		/* within 1GB-aligned window of up to 32GB in size */
>> +		kbuf.buf_max = round_down(kernel_load_addr, SZ_1G)
>> +						+ (unsigned long)SZ_1G * 32;
>> +		kbuf.top_down = false;
>> +
>> +		ret = kexec_add_buffer(&kbuf);
>> +		if (ret)
>> +			goto out_err;
>> +		initrd_load_addr = kbuf.mem;
>> +
>> +		kexec_dprintk("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
>> +			      initrd_load_addr, kbuf.bufsz, kbuf.memsz);
>> +
>> +		/* Add the initrd=start,size parameter to the command line */
>> +		cmdline_add_initrd(image, &cmdline_tmplen, modified_cmdline, initrd_load_addr);
>> +	}
>> +
>> +	if (cmdline_len + cmdline_tmplen > COMMAND_LINE_SIZE) {
> It's too later to check for overflowing here, where the data after
> modified_cmdline may already be overwritten.
At this point, we append the original command line to modified_cmdline,
so it is appropriate to determine whether the command line length exceeds
the limit.
>
>> +		pr_err("Appending kdump cmdline exceeds cmdline size\n");
> I think load_other_segments could be invoked without kdump involved. If
> that's correct, this message is inaccurate.
Yes, it should be corrected.


Thanks,
Youling.
>
>> +		ret = -EINVAL;
>> +		goto out_err;
>> +	}
> Regards,
> Yao Zi
>
>> +	memcpy(modified_cmdline + cmdline_tmplen, cmdline, cmdline_len);
>> +	cmdline = modified_cmdline;
>>   	image->arch.cmdline_ptr = (unsigned long)cmdline;
>>   
>>   	return 0;
>> +
>> +out_err:
>> +	image->nr_segments = orig_segments;
>> +	kfree(modified_cmdline);
>> +	return ret;
>>   }
>> -- 
>> 2.34.1
>>
>>

