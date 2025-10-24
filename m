Return-Path: <linux-kernel+bounces-869462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4BBC07F22
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 878D43B2424
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721E62D593A;
	Fri, 24 Oct 2025 19:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RDmxnHO/"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA6620CCCA
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 19:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761335043; cv=none; b=gTN4MBYeYPhSeNJBSWDvNIuhzAXnC40BsFz3mNu8FNQX6j7N9wCroIUynax1xrCwwXlLJFdlobK/MHfALvjWo8uVtOhcHDfD+ZIFxPai56R8rLT8SUAuNE8Mvs8fawgIHpwOA/8rB6GJLOwrerqi7r99bTBgC6nlJdhzk1zPil8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761335043; c=relaxed/simple;
	bh=shl7bJ1M1+flmvet4xUS68bn/20T+KcV74lkt9mqrMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TALrWTJDQAnSOxHHVEOHZzP2TwUIoWjtOSLTiloGvfxfFn0w+sXPhvjT6vkrTLu2uI0WidnN+DHBOwqNxLY4k/unIA04mzkhqg6XWFGoYpYrGbifa/4xZGMtgofroWS0QUntdqiIaIsGc40cheWEVSW1F/TMFCuiRWrMDURIpeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RDmxnHO/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=OxdWsq282YbNYkIdlx7yU94CDIjeudkCU+GpHh8fTpk=; b=RDmxnHO/R11wCBAXH9TyNM+ASn
	o1JsfVuH96R/3ocNcMxspn6z5ZYurXXyCtUd3NOoZfAVZaMLw+yNt1FwL1E/Dy95WCCBdwBJASt0c
	FZ66t9c2uzdnWpkr7qjhyvF/fa4kKpz2FCijXp8ielBN3cp1FA58itWrK1UN64fsYdTFIQSJlqhs2
	I2MhPWKJpIIQHjuTXZcVijY0qaLPLKTQWrkFmzjlgboch+JFLoSjvnJqLhs9eNtOZG6aoULX/BjKk
	sLkCsG8YmTWnIdISGX5cRG2SCxFiam5hFFfpIsHRXQAFbMuqOhrAlwxtX2GqEV4jGRfK/cXNyPjxo
	IH9w+OTg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCNhh-0000000AOeL-1wz8;
	Fri, 24 Oct 2025 19:44:01 +0000
Message-ID: <8950bbb2-f1a7-4ae8-971f-7331c7eceff0@infradead.org>
Date: Fri, 24 Oct 2025 12:44:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virt: acrn: fix kernel-doc in <uapi/linux/acrn.h>
To: "Li, Fei1" <fei1.li@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "acrn-dev@lists.projectacrn.org" <acrn-dev@lists.projectacrn.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20251024044226.480531-1-rdunlap@infradead.org>
 <SJ1PR11MB615389E066F50BBB68686A26BFF1A@SJ1PR11MB6153.namprd11.prod.outlook.com>
 <213c918b-b4aa-4174-af89-a4d17e8c30dc@infradead.org>
 <SJ1PR11MB61536DC1E7A32387FCA400E5BFF1A@SJ1PR11MB6153.namprd11.prod.outlook.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <SJ1PR11MB61536DC1E7A32387FCA400E5BFF1A@SJ1PR11MB6153.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10/23/25 11:22 PM, Li, Fei1 wrote:
>>
>> Hi,
>>
>> On 10/23/25 11:00 PM, Li, Fei1 wrote:
>>>> From: Randy Dunlap <rdunlap@infradead.org>
>>>> Sent: Friday, October 24, 2025 12:42 PM
>>>> To: linux-kernel@vger.kernel.org
>>>> Cc: Randy Dunlap <rdunlap@infradead.org>; Li, Fei1
>>>> <fei1.li@intel.com>; acrn-dev@lists.projectacrn.org; Greg
>>>> Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Subject: [PATCH] virt: acrn: fix kernel-doc in <uapi/linux/acrn.h>
>>>>
>>>> Fix the kernel-doc comments for struct acrn_mmiodev so that all
>>>> struct members are rendered correctly.
>>>> Correct io_base to io_addr in struct acrn_vdev.
>>>>
>>>> acrn.h:441: warning: Function parameter or struct member 'res'
>>>>  not described in 'acrn_mmiodev'
>>>> acrn.h:479: warning: Function parameter or struct member 'io_addr'
>>>>  not described in 'acrn_vdev'
>>>> acrn.h:479: warning: Excess struct member 'io_base' description  in
>>>> 'acrn_vdev'
>>>>
>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>>> ---
>>>> Cc: Fei Li <fei1.li@intel.com>
>>>> Cc: acrn-dev@lists.projectacrn.org
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> ---
>>>>  include/uapi/linux/acrn.h |   11 ++++++-----
>>>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>>>
>>>> --- linux-next-20251022.orig/include/uapi/linux/acrn.h
>>>> +++ linux-next-20251022/include/uapi/linux/acrn.h
>>>> @@ -420,12 +420,13 @@ struct acrn_pcidev {
>>>>  /**
>>>>   * struct acrn_mmiodev - Info for assigning or de-assigning a MMIO device
>>>>   * @name:			Name of the MMIO device.
>>>> - * @res[].user_vm_pa:		Physical address of User VM of the
>> MMIO
>>>> region
>>>> + * @res:			MMIO resource descriptor info.
>>>
>>> Hi Randy
>>>
>>> Thanks for cooking this patch to help fix these warning.
>>> Could you just add the comment for `res` and keep the other comments for
>> the fields of ` struct acrn_mmiodev ` ?
>>>
>>
>> Do you mean leave the [] square brackets in the field name?
> yes
>> If that's what you mean, that's not valid kernel-doc notation.
> Would you please post the quote how kernel-doc prefer to add this comments ? I didn't see
> an example in the kernel-doc.rst

There is not anything in kernel-doc that indicates arrays
so I can't post a quote that shows that.
The patch shows the preferred kernel-doc here.

>>>> + * @res.user_vm_pa:		Physical address of User VM of the
>> MMIO
>>>> region
>>>>   *				for the MMIO device.
>>>> - * @res[].service_vm_pa:	Physical address of Service VM of the MMIO
>>>> + * @res.service_vm_pa:		Physical address of Service VM of the
>>>> MMIO
>>>>   *				region for the MMIO device.
>>>> - * @res[].size:			Size of the MMIO region for the
>> MMIO
>>>> device.
>>>> - * @res[].mem_type:		Memory type of the MMIO region for
>> the
>>>> MMIO
>>>> + * @res.size:			Size of the MMIO region for the
>> MMIO
>>>> device.
>>>> + * @res.mem_type:		Memory type of the MMIO region for
>> the
>>>> MMIO
>>>>   *				device.
>>>>   *
>>>>   * This structure will be passed to hypervisor directly.
>>>> @@ -449,7 +450,7 @@ struct acrn_mmiodev {
>>>>   * @id.fields.legacy_id:	ID of the virtual device if not a PCI device
>>>>   * @slot:			Virtual Bus/Device/Function of the virtual
>>>>   *				device
>>>> - * @io_base:			IO resource base address of the
>> virtual device
>>>> + * @io_addr:			IO resource base address of the
>> virtual device
>>>>   * @io_size:			IO resource size of the virtual device
>>>>   * @args:			Arguments for the virtual device creation
>>>>   *
>>
>> --
>> ~Randy
> 

-- 
~Randy


