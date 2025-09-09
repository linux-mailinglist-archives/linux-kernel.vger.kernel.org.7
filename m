Return-Path: <linux-kernel+bounces-807363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B28F9B4A36E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41DF1B23A9F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AFA3054CB;
	Tue,  9 Sep 2025 07:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen0n.name header.i=@xen0n.name header.b="IX3Zs1xK"
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A4F1FFC7B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 07:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.28.160.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757402729; cv=none; b=is+vAlx3zyEQ+HOnCZfpL30cz5tZVDHkLWfkRI2Kxd3rlj31M32fPbAyxJadWS3MgKNjbC2jbefxbtF0t5BwFWeGoXhrd9R0uO84mTjxKDzkXC3Cq9/+DdQzRZ7K9YvuCQ9ZL0iBG5WB/iq1ck9PivD6LjsxUT7Ee5ZlXfgAlwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757402729; c=relaxed/simple;
	bh=iLUNvEOeUmUSUU1ItHfiK2Z4LKlmvDTV43kYoaHQ+iE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n1Zu+J39UlVLflk0uiNFsvbxLjc9Rifjclqe8DgwnEATGlVnQesNarIo6hoGv3sm19SiOW5fPFYTz4zsh3Za1jekp+YDLjPX25XkFs0wqw1YPY7FfMyhZXDFbndJYn6dWvYM92tOZYgUOzElCjakLPXXy9kL0B4BnYD9bxcJT3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen0n.name; spf=pass smtp.mailfrom=xen0n.name; dkim=pass (1024-bit key) header.d=xen0n.name header.i=@xen0n.name header.b=IX3Zs1xK; arc=none smtp.client-ip=115.28.160.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen0n.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xen0n.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
	t=1757402322; bh=iLUNvEOeUmUSUU1ItHfiK2Z4LKlmvDTV43kYoaHQ+iE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IX3Zs1xKIjkmqAgCe4ynsfqvwUnhknfwOKcy3L+1hgLM8WDo4j4jKuWBCKdNLZWyd
	 I/ixhFBI2s/EtT2463HLo8D6ep8muiLYva8nfLIZCe/biZ+9mU8HiPE3CkZVW6BG6k
	 qZBVyxqWTNgJ47d5RjY3TA+H8NDbVwmR+lSa9dyo=
Received: from [28.0.0.1] (unknown [182.200.16.183])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mailbox.box.xen0n.name (Postfix) with ESMTPSA id EC3E26017A;
	Tue,  9 Sep 2025 15:18:41 +0800 (CST)
Message-ID: <5169d057-28c9-439c-a6b7-1138b4f79e65@xen0n.name>
Date: Tue, 9 Sep 2025 15:18:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] LoongArch: Added detection of return values of some steps
 in the system init process
To: Huacai Chen <chenhuacai@kernel.org>, cuitao <cuitao@kylinos.cn>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250909023448.1820120-1-cuitao@kylinos.cn>
 <CAAhV-H7ECnVeOgf93SEXLHLc4wvhQMjQXDbGKCR-KXKWf8Vgtg@mail.gmail.com>
Content-Language: en-US
From: WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAAhV-H7ECnVeOgf93SEXLHLc4wvhQMjQXDbGKCR-KXKWf8Vgtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 9/9/25 11:13, Huacai Chen wrote:
> Hi, Cuitao,
> 
> Don't over-design!

I generally agree with this, but...

> On Tue, Sep 9, 2025 at 10:35 AM cuitao <cuitao@kylinos.cn> wrote:
>>
>> Check the return value after early_memremap_ro and kobject_create_and_add,
>> and check whether the memory allocation was successful after kstrdup
>>
>> Signed-off-by: cuitao <cuitao@kylinos.cn>
>> ---
>>   arch/loongarch/kernel/env.c | 30 ++++++++++++++++++++++++++----
>>   1 file changed, 26 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/loongarch/kernel/env.c b/arch/loongarch/kernel/env.c
>> index c0a5dc9aeae2..eaa9e054209c 100644
>> --- a/arch/loongarch/kernel/env.c
>> +++ b/arch/loongarch/kernel/env.c
>> @@ -23,7 +23,13 @@ EXPORT_SYMBOL(loongson_sysconf);
>>   void __init init_environ(void)
>>   {
>>          int efi_boot = fw_arg0;
>> -       char *cmdline = early_memremap_ro(fw_arg1, COMMAND_LINE_SIZE);
>> +       char *cmdline;
>> +
>> +       cmdline = early_memremap_ro(fw_arg1, COMMAND_LINE_SIZE);
>   early_memremap_ro() is "return ((void __iomem *)TO_CACHE(phys_addr))"
> on LoongArch, there is no chance to return NULL.
> 
>> +       if (!cmdline) {
>> +               pr_err("Failed to map command line memory\n");
>> +               return;
>> +       }
>>
>>          if (efi_boot)
>>                  set_bit(EFI_BOOT, &efi.flags);
>> @@ -46,10 +52,18 @@ static int __init init_cpu_fullname(void)
>>
>>          /* Parsing cpuname from DTS model property */
>>          root = of_find_node_by_path("/");
> After 7b937cc243e5b1df8780a0aa743ce800df6c6 ("of: Create of_root if no
> dtb provided by firmware"), there is no chance to have no root.

... These are indeed valid reasons, but only known by people already 
(deeply) familiar with the codebase and the port.

>> +       if (!root) {
>> +               pr_warn("Failed to find root device node\n");
>> +               return -ENODEV;
>> +       }
>>          ret = of_property_read_string(root, "model", &model);
>>          if (ret == 0) {
>>                  cpuname = kstrdup(model, GFP_KERNEL);
>> -               loongson_sysconf.cpuname = strsep(&cpuname, " ");
>> +               if (cpuname) {
>> +                       loongson_sysconf.cpuname = strsep(&cpuname, " ");
>> +               } else {
>> +                       pr_warn("Failed to allocate memory for cpuname\n");
> Have a cpuname in the model string is not mandatory, print a warning for what?

So is this piece of know-how. Therefore, I'd suggest keeping the code 
intact but adding comments regarding the safety -- why omitted checks 
here and there are safe in the port's scope.

>> +               }
>>          }
>>          of_node_put(root);
>>
>> @@ -67,14 +81,18 @@ static int __init fdt_cpu_clk_init(void)
>>          struct device_node *np;
>>
>>          np = of_get_cpu_node(0, NULL);
>> -       if (!np)
>> +       if (!np) {
>> +               pr_warn("Failed to get CPU node\n");
> The same, this is not mandatory.
> 
>>                  return -ENODEV;
>> +       }
>>
>>          clk = of_clk_get(np, 0);
>>          of_node_put(np);
>>
>> -       if (IS_ERR(clk))
>> +       if (IS_ERR(clk)) {
>> +               pr_warn("Failed to get CPU clock\n");
> The same, this is not mandatory.
> 
> 
> Huacai
> 
>>                  return -ENODEV;
>> +       }
>>
>>          cpu_clock_freq = clk_get_rate(clk);
>>          clk_put(clk);
>> @@ -109,6 +127,10 @@ static int __init boardinfo_init(void)
>>          struct kobject *loongson_kobj;
>>
>>          loongson_kobj = kobject_create_and_add("loongson", firmware_kobj);
>> +       if (!loongson_kobj) {
>> +               pr_warn("loongson: Firmware registration failed.\n");
>> +               return -ENOMEM;
>> +       }
>>
>>          return sysfs_create_file(loongson_kobj, &boardinfo_attr.attr);
>>   }
>> --
>> 2.33.0
>>

I'd agree that the remaining debug prints are less useful than the 
commentary I suggested before, and should be better left out.

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

