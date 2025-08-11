Return-Path: <linux-kernel+bounces-762021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A50B20126
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2DA9189E3A5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3150F2DA75A;
	Mon, 11 Aug 2025 08:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="E9ua75+N"
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348471FE451;
	Mon, 11 Aug 2025 08:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754899368; cv=none; b=avYxV+6SiATBwGtXZwVAS6Szpknc5QhU2DqRWKcMd5pxCAaUe0nMRjruqbmm7nRpBAMTahDNpKV3t9JDx6qPn4qtTM6pP2Au3edunkqTXnqQMXdRYI3K1SDn/z4byb5tPAHbozRzGxkB/Cc8WEorHW5WEsXLq1av6DzmyXzneTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754899368; c=relaxed/simple;
	bh=CsTWccA+bTID6m2MKLcqrCSHVimgeuHk24BK69Y9GU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mb+aGBJyekcHhjcHSMrh2+T7f9WPLaxQmDnDs7y8dOZa2P8l63bsZ4kbzmelAHQ3RoQpcapcrLNLD4YdqtjgR3Sj4s2ogAsNArjkL4U208kX5BVk68apGgNiVMX5GZHUsUUO7/DELuxCOnA+VcuPqncyF1libJh3vylD3R5xPYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=E9ua75+N; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MNqxMRXLftlngWU/+kh0v1RCc0qOSul6Se1CZBaU11s=; b=E9ua75+NNbkOIR8SMFNtiPe7Mu
	gmNCx6Nk7yeXjuQRe6ILLUndIB4GNq0M7uHGCbgbqKg5t8hGce+f4t/5ImaNM3BI4Bl8XubeEPTR9
	NMQodte2dDZ2Z9u8VTprTFCT7oUyKNHnt3+jcDOPJGAZQwYtKxX0vfYpRemoZy6X6Gist4g6gXdz8
	v4/B1jKZAHTgmDeDqQakXKO58Iso1yScWs0y8wqlI+SfOeJD/SP+cMxVwQVDoipW863xSk3IZxs/x
	9BpyuI14S/1vqLFf0GuzRBElsA20ZMBRRkGyn+xt5CpySgrz4oXkia5hh6OGnr/AVaGk3UeJVr54r
	pmolosyw==;
Received: from [167.98.27.226] (helo=[10.35.6.194])
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1ulNUI-00BX56-Un; Mon, 11 Aug 2025 09:02:35 +0100
Message-ID: <cd6ed5b1-619c-4ca9-8fe0-6b47c7d641a7@codethink.co.uk>
Date: Mon, 11 Aug 2025 09:02:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/PATCH] drivers/of: add debug for early dump of the dtb
 strcutrue
To: Saravana Kannan <saravanak@google.com>, Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250808142515.142058-1-ben.dooks@codethink.co.uk>
 <CAL_JsqJntD-o6zMo-vaCQ+f=QDuyEmUgBJqjztoriq4QF7=zEg@mail.gmail.com>
 <CAGETcx99RE6=knBq75sMGUPKcuTKLXqJSo5NKyaZWRfXWEa7tA@mail.gmail.com>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <CAGETcx99RE6=knBq75sMGUPKcuTKLXqJSo5NKyaZWRfXWEa7tA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: ben.dooks@codethink.co.uk

On 08/08/2025 22:10, Saravana Kannan wrote:
> On Fri, Aug 8, 2025 at 9:25 AM Rob Herring <robh@kernel.org> wrote:
>>
>> On Fri, Aug 8, 2025 at 9:26 AM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>>>
>>> When testing for boot issues, it was helpful to dump the
>>> list of nodes and properties in the device-tree passed into
>>> the kernel.
>>
>> Shouldn't the bootloader be able to dump that?
>>
>>> Add CONFIG_OF_EARLY_DUMP option to dump the list of nodes
>>> and properties to the standard console output early in the
>>> boot sequence. Note, you may need to have some sort of
>>
>> s/may/will/
>>
>>> early or debug console output if there are issues stopping
>>> the kernel starting properly.
>>
>> Seems to me this is giving the user the haystack to find the needle...
> 
> Completely agree with Rob.
> 
> Ben, can you give more context on what kind of issues this has helped
> you (or anticipate it will) solve? Maybe there are better ways of
> getting what you need.

We where having issues with u-boot on big-endian riscv.

turns out the string functions had issues with endian-ness and
where corrupting the dtb when doing the final changes when booting
into the kernel.

the kernel wouldn;t boot as sometimes depending on data alignment
the #size-cells and #address-cells where having their names corrupted
and thus the kernel would bail very early.

> -Saravana
> 
>>
>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>> ---
>>>   drivers/of/Kconfig |  8 ++++++++
>>>   drivers/of/fdt.c   | 39 +++++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 47 insertions(+)
>>>
>>> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
>>> index 50697cc3b07e..ed2c52c54a7d 100644
>>> --- a/drivers/of/Kconfig
>>> +++ b/drivers/of/Kconfig
>>> @@ -126,4 +126,12 @@ config OF_OVERLAY_KUNIT_TEST
>>>   config OF_NUMA
>>>          bool
>>>
>>> +config OF_EARLY_DUMP
>>> +       bool "Dump node list at startup"
>>
>> This needs to depend on OF_EARLY_FLATTREE.
>>
>>> +       help
>>> +         This debug feature runs through all the nodes/properties at startup
>>> +         to show if the dtb has been passed correctly from the boot stage.
>>> +
>>> +         If unsure, say N here
>>> +
>>>   endif # OF
>>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>>> index 0edd639898a6..ab40db0e71a5 100644
>>> --- a/drivers/of/fdt.c
>>> +++ b/drivers/of/fdt.c
>>> @@ -1164,6 +1164,43 @@ static void * __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
>>>          return memblock_alloc_or_panic(size, align);
>>>   }
>>>
>>> +#ifdef CONFIG_OF_EARLY_DUMP
>>> +static int __init early_init_iterate_nodes(unsigned long node,
>>> +                                          const char *uname,
>>> +                                          int depth, void *data)
>>> +{
>>> +       void *blob = initial_boot_params;
>>> +       int cur;
>>> +
>>> +       pr_info("node '%s', depth %d\n", uname, depth);
>>
>> Can you add indentation for the depth rather than printing the depth?
>>
>> I'm not completely sure if calling this is safe always. How early this
>> will run depends on the architecture. So need to test on a variety of
>> architectures. Or perhaps limit in kconfig to tested architectures.
>> I'd rather not do that though.
>>
>>> +
>>> +       for (cur = fdt_first_property_offset(blob, node);
>>> +            cur >= 0;
>>> +            cur = fdt_next_property_offset(blob, cur)) {
>>> +               const char *pname;
>>> +               const __be32 *val;
>>> +               u32 sz;
>>> +
>>> +               val = fdt_getprop_by_offset(blob, cur, &pname, &sz);
>>> +               if (!val) {
>>> +                       pr_warn(" Cannot locate property at 0x%x\n", cur);
>>> +                       continue;
>>
>> If this fails, you should probably just stop and bail out.
>>
>>> +               }
>>> +
>>> +               pr_info("node %s: property %s\n", uname, pname ? pname : "unnamed");
>>
>> Can unnamed actually happen?
>>
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static inline void early_init_dump_dt(void)
>>> +{
>>> +       of_scan_flat_dt(early_init_iterate_nodes, NULL);
>>
>> This way to iterate is left over from before having libfdt. Is there
>> not a libfdt way to iterate thru all nodes?
>>
>>> +}
>>> +#else
>>> +static inline void early_init_dump_dt(void) { }
>>> +#endif /* CONFIG_OF_EARLY_DUMP */
>>> +
>>>   bool __init early_init_dt_verify(void *dt_virt, phys_addr_t dt_phys)
>>>   {
>>>          if (!dt_virt)
>>> @@ -1178,6 +1215,8 @@ bool __init early_init_dt_verify(void *dt_virt, phys_addr_t dt_phys)
>>>          initial_boot_params_pa = dt_phys;
>>>          of_fdt_crc32 = crc32_be(~0, initial_boot_params,
>>>                                  fdt_totalsize(initial_boot_params));
>>> +
>>> +       early_init_dump_dt();
>>
>> Use "if (IS_ENABLED(CONFIG_OF_EARLY_DUMP))" here instead of #ifdef.
>>
>>>
>>>          /* Initialize {size,address}-cells info */
>>>          early_init_dt_scan_root();
>>> --
>>> 2.37.2.352.g3c44437643
>>>
> 


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

