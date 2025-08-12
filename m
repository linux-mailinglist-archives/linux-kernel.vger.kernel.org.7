Return-Path: <linux-kernel+bounces-763835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3546B21ACD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 04:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63259426FF9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 02:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D376A1DDC2B;
	Tue, 12 Aug 2025 02:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ozjxrm75"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD0A311C02
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754966342; cv=none; b=fAwMiUsFN7Ac9bkHuKeYWmVvNF96Moh4TEtLMj0M56s/CopUMSJrVPNt891h0WRL/Q5+55EuaZ1MQ9Q0hB2iZuT18n9Xb3XhTrzVXu/WDoUMJ+jAdIGnNCY/h9H3x5T/VEedTnVJpuNF3a99+9KVJDrSzY00x/VXL65aGygFFZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754966342; c=relaxed/simple;
	bh=JYIAJ9fc1rJwUZC6IIh/QZHDIZ/HKFpG9Nny0OS/gG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hQpIVsfjG4GHPjkMTPz0ITAZCDVCIrfxhoieiaK5wLwJD6rVEYwSQpRwFZzHqunoKcL0nMJP7bOC31ZvNSkKVjsThL3AzwWQwhvzMg1b5JrHn9iP7gagGvqntbftVcd7H9yr23rrfoZqtWjJ/Hf37YnoN7Y0bd+wL8JighyCkVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ozjxrm75; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <15fdef37-f380-4b5c-85bb-24482e883dcc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754966327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+V6JNn1qTclk48lL6vZFHUSkocWBaeAf2PNn/YVMcWo=;
	b=Ozjxrm75yxPx1BIPykdr+lWI04fhVMMGxHIm1EP3iR0ODmrvMKkAwitPgr8eNsEibYwjw7
	ENdHH61wWWA0lwkKDzTh7EBfdRJF5ij86bwcNIVOIOh8DQQbF5rLjFLk+o74pavqvtb/5i
	8RXwAriihep/XeC2IFajtYOj7Ko768s=
Date: Tue, 12 Aug 2025 10:38:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/6] LoongArch/kexec_file: Add initrd loading
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
References: <20250811092659.14903-1-youling.tang@linux.dev>
 <20250811092659.14903-4-youling.tang@linux.dev>
 <CAAhV-H4Sf=74-ni=qUkg3doC4iLrVt=m2bCYCgfmVC0WLNhiDQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <CAAhV-H4Sf=74-ni=qUkg3doC4iLrVt=m2bCYCgfmVC0WLNhiDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi, Huacai
On 2025/8/11 22:12, Huacai Chen wrote:
> Hi, Youling,
>
> On Mon, Aug 11, 2025 at 5:28 PM Youling Tang <youling.tang@linux.dev> wrote:
>> From: Youling Tang <tangyouling@kylinos.cn>
>>
>> Add inird loading support and pass it to the second kernel via the
>> cmdline 'initrd=start,size'.
> I think Patch-3 and Patch-5 should be merged into Patch-2.
Not all cases require loading initrd, so Patch-2 is a runnable basic patch.
Separating it into different patches makes it easier to understand and
review the code.

Patch-5 coming out separately can better illustrate the role of "mem"
parameters in capturing the kernel.

Youling.
>
> Huacai
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
>>          return kexec_image_post_load_cleanup_default(image);
>>   }
>>
>> +/* Adds the "initrd=start,size" command line parameter to command line. */
>> +static void cmdline_add_initrd(struct kimage *image, unsigned long *cmdline_tmplen,
>> +                               char *modified_cmdline, unsigned long initrd)
>> +{
>> +       int initrd_strlen;
>> +
>> +       initrd_strlen = sprintf(modified_cmdline + (*cmdline_tmplen), "initrd=0x%lx,0x%lx ",
>> +               initrd, image->initrd_buf_len);
>> +       *cmdline_tmplen += initrd_strlen;
>> +}
>> +
>> +/*
>> + * Tries to add the initrd to the image. If it is not possible to find
>> + * valid locations, this function will undo changes to the image and return non
>> + * zero.
>> + */
>>   int load_other_segments(struct kimage *image,
>>                          unsigned long kernel_load_addr,
>>                          unsigned long kernel_size,
>>                          char *initrd, unsigned long initrd_len,
>>                          char *cmdline, unsigned long cmdline_len)
>>   {
>> +       struct kexec_buf kbuf;
>> +       unsigned long orig_segments = image->nr_segments;
>> +       char *modified_cmdline = NULL;
>> +       unsigned long cmdline_tmplen = 0;
>> +       unsigned long initrd_load_addr = 0;
>> +       int ret = 0;
>> +
>> +
>> +       kbuf.image = image;
>> +       /* not allocate anything below the kernel */
>> +       kbuf.buf_min = kernel_load_addr + kernel_size;
>> +
>> +       modified_cmdline = kzalloc(COMMAND_LINE_SIZE, GFP_KERNEL);
>> +       if (!modified_cmdline)
>> +               return -EINVAL;
>> +
>> +       /* Ensure it's nul terminated */
>> +       modified_cmdline[COMMAND_LINE_SIZE - 1] = '\0';
>> +
>> +       /* load initrd */
>> +       if (initrd) {
>> +               kbuf.buffer = initrd;
>> +               kbuf.bufsz = initrd_len;
>> +               kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>> +               kbuf.memsz = initrd_len;
>> +               kbuf.buf_align = 0;
>> +               /* within 1GB-aligned window of up to 32GB in size */
>> +               kbuf.buf_max = round_down(kernel_load_addr, SZ_1G)
>> +                                               + (unsigned long)SZ_1G * 32;
>> +               kbuf.top_down = false;
>> +
>> +               ret = kexec_add_buffer(&kbuf);
>> +               if (ret)
>> +                       goto out_err;
>> +               initrd_load_addr = kbuf.mem;
>> +
>> +               kexec_dprintk("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
>> +                             initrd_load_addr, kbuf.bufsz, kbuf.memsz);
>> +
>> +               /* Add the initrd=start,size parameter to the command line */
>> +               cmdline_add_initrd(image, &cmdline_tmplen, modified_cmdline, initrd_load_addr);
>> +       }
>> +
>> +       if (cmdline_len + cmdline_tmplen > COMMAND_LINE_SIZE) {
>> +               pr_err("Appending kdump cmdline exceeds cmdline size\n");
>> +               ret = -EINVAL;
>> +               goto out_err;
>> +       }
>> +       memcpy(modified_cmdline + cmdline_tmplen, cmdline, cmdline_len);
>> +       cmdline = modified_cmdline;
>>          image->arch.cmdline_ptr = (unsigned long)cmdline;
>>
>>          return 0;
>> +
>> +out_err:
>> +       image->nr_segments = orig_segments;
>> +       kfree(modified_cmdline);
>> +       return ret;
>>   }
>> --
>> 2.34.1
>>

