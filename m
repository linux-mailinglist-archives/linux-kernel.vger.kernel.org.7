Return-Path: <linux-kernel+bounces-872996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADE0C12CD3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 04:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2892A18926AA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 03:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87E9283C9D;
	Tue, 28 Oct 2025 03:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KGBSvwZ1"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A8B19D092
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761623132; cv=none; b=EAsGJoKfRekU04vOCQrT6LMdbMt1x9G7hUixrlHXrhwLhkiyWyItRPVxWzknSgjaFABhdIBa0/dWnty+QyfCqMDGzqUO1L28cfAfusPf/Rh0aDbGsPD2YzK8m8zGHKAdKLs+6Kh8DDuYrVTbHWsEpLbDxWSlH0op3WPruLISWr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761623132; c=relaxed/simple;
	bh=gx3z6574tADBoClifYJVynXrj9kPfmAQfct1OCm71xM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TTEDfL3k/KMUGdeZLd4BPhTHm8VuPjs9j5lCy8ixkidgLbnf5zDlSMiXu/h9KesjJNg87JfcUYrQP1/OoSubm6OWSHX30+oTYKeCwyoEECI65gT5RLs4wQQ3Yr110E4KrtCeoJkZflPJHrGnHmB0+cGN3LuW1BKSudUtCxcsv7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KGBSvwZ1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ICh+mcNvPsoPkCVr6IYYtsTCCNwWjIV6JOF8t26dINY=; b=KGBSvwZ1E6jAFq0EredJDx4Z+C
	+0jL1eh2ti7KB5oIEJewYV1A0ZwJI+vnWXdzE4NRzv/VkiNlTum2GILzffWcOOervhX9aCCYQceJ0
	b/fTY5A8b/lsXzcvrZ+2oJDP8y5/KSY9aPOcm1rzhkOQUrdKdengNlUrPMrm4FfB8pIW3qaY0VMxJ
	kqdlYz9IEQ01C7oiUjDq4Cp9Br20oqofBgu3dZWUFuZzHFTmgZkwrrP99iuZ1FO7v0xhYKC1R8lbd
	hGCDGzJBuKvHssSmi5yYDWt7LKzwlzcvbCnBRAHIuaSzox/YlVuMOSi14FXLvbqSttB+X4ixZcFHd
	k707SQRg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDaeF-0000000FBO7-3i5J;
	Tue, 28 Oct 2025 03:45:27 +0000
Message-ID: <2813380c-f5d1-4472-a0a8-78215d9c656f@infradead.org>
Date: Mon, 27 Oct 2025 20:45:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virt: acrn: fix kernel-doc in <uapi/linux/acrn.h>
To: Fei Li <fei1.li@intel.com>, linux-kernel@vger.kernel.org
Cc: acrn-dev@lists.projectacrn.org, gregkh@linuxfoundation.org
References: <20251024044226.480531-1-rdunlap@infradead.org>
 <SJ1PR11MB615389E066F50BBB68686A26BFF1A@SJ1PR11MB6153.namprd11.prod.outlook.com>
 <213c918b-b4aa-4174-af89-a4d17e8c30dc@infradead.org>
 <SJ1PR11MB61536DC1E7A32387FCA400E5BFF1A@SJ1PR11MB6153.namprd11.prod.outlook.com>
 <8950bbb2-f1a7-4ae8-971f-7331c7eceff0@infradead.org>
 <SJ1PR11MB6153A77684F68B592851A32EBFFCA@SJ1PR11MB6153.namprd11.prod.outlook.com>
 <be3819fe-c17e-4ce1-83ec-5ae23cfabac4@infradead.org>
 <aQA2Qr2Z8UyaCLO8@louislifei-OptiPlex-7090>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <aQA2Qr2Z8UyaCLO8@louislifei-OptiPlex-7090>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/27/25 8:19 PM, Fei Li wrote:
> On 2025-10-26 at 23:11:07 -0700, Randy Dunlap wrote:
> 
> Hi Randy
> 
>> Hi--
>>
>> On 10/26/25 10:54 PM, Li, Fei1 wrote:
>>>> From: Randy Dunlap <rdunlap@infradead.org>
>>>> Sent: Saturday, October 25, 2025 3:44 AM
>>>> To: Li, Fei1 <fei1.li@intel.com>; linux-kernel@vger.kernel.org
>>>> Cc: acrn-dev@lists.projectacrn.org; Greg Kroah-Hartman
>>>> <gregkh@linuxfoundation.org>
>>>> Subject: Re: [PATCH] virt: acrn: fix kernel-doc in <uapi/linux/acrn.h>
>>>>
>>>> Hi,
>>>>
>>>> On 10/23/25 11:22 PM, Li, Fei1 wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> On 10/23/25 11:00 PM, Li, Fei1 wrote:
>>>>>>>> From: Randy Dunlap <rdunlap@infradead.org>
>>>>>>>> Sent: Friday, October 24, 2025 12:42 PM
>>>>>>>> To: linux-kernel@vger.kernel.org
>>>>>>>> Cc: Randy Dunlap <rdunlap@infradead.org>; Li, Fei1
>>>>>>>> <fei1.li@intel.com>; acrn-dev@lists.projectacrn.org; Greg
>>>>>>>> Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>>>>> Subject: [PATCH] virt: acrn: fix kernel-doc in <uapi/linux/acrn.h>
>>>>>>>>
>>>>>>>> Fix the kernel-doc comments for struct acrn_mmiodev so that all
>>>>>>>> struct members are rendered correctly.
>>>>>>>> Correct io_base to io_addr in struct acrn_vdev.
>>>>>>>>
>>>>>>>> acrn.h:441: warning: Function parameter or struct member 'res'
>>>>>>>>  not described in 'acrn_mmiodev'
>>>>>>>> acrn.h:479: warning: Function parameter or struct member 'io_addr'
>>>>>>>>  not described in 'acrn_vdev'
>>>>>>>> acrn.h:479: warning: Excess struct member 'io_base' description  in
>>>>>>>> 'acrn_vdev'
>>>>>>>>
>>>>>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>>>>>>> ---
>>>>>>>> Cc: Fei Li <fei1.li@intel.com>
>>>>>>>> Cc: acrn-dev@lists.projectacrn.org
>>>>>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>>>>> ---
>>>>>>>>  include/uapi/linux/acrn.h |   11 ++++++-----
>>>>>>>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>>>>>>>
>>>>>>>> --- linux-next-20251022.orig/include/uapi/linux/acrn.h
>>>>>>>> +++ linux-next-20251022/include/uapi/linux/acrn.h
>>>>>>>> @@ -420,12 +420,13 @@ struct acrn_pcidev {
>>>>>>>>  /**
>>>>>>>>   * struct acrn_mmiodev - Info for assigning or de-assigning a MMIO
>>>> device
>>>>>>>>   * @name:			Name of the MMIO device.
>>>>>>>> - * @res[].user_vm_pa:		Physical address of User VM of the
>>>>>> MMIO
>>>>>>>> region
>>>>>>>> + * @res:			MMIO resource descriptor info.
>>>>>>>
>>>>>>> Hi Randy
>>>>>>>
>>>>>>> Thanks for cooking this patch to help fix these warning.
>>>>>>> Could you just add the comment for `res` and keep the other comments
>>>>>>> for
>>>>>> the fields of ` struct acrn_mmiodev ` ?
>>>>>>>
>>>>>>
>>>>>> Do you mean leave the [] square brackets in the field name?
>>>>> yes
>>>>>> If that's what you mean, that's not valid kernel-doc notation.
>>>>> Would you please post the quote how kernel-doc prefer to add this
>>>>> comments ? I didn't see an example in the kernel-doc.rst
>>>>
>>>> There is not anything in kernel-doc that indicates arrays so I can't post a quote
>>>> that shows that.
>>>> The patch shows the preferred kernel-doc here.
>>>
>>> Hi Randy
>>>
>>> IMHO,  the patch shows here is an example of `Nested structs/unions`, not an example of
>>> `Nested structs/unions array`. 
>>> For the ` Nested structs/unions array `, the `In-line member documentation comments`
>>> style is more suitable, or could we just keep what it is for: (1) there're many kernels' codes
>>> still use this comment style for theirs function comments, I.E., in kernel/rcu/srcutree.c
>>
>> but that is not in kernel-doc comments.
>>
>>> (2) the kernel-doc doesn't complain about this warning.
>>
>> Yes, it's just wrong about that. As soon as it sees the "[]",
>> it seems to become confused and omits all struct members
>> after @name.  Here's struct acrn_mmiodev
>> after I rendered it in man format:
>>
>> NAME
>>        struct acrn_mmiodev - Info for assigning or de-assigning a MMIO device
>>
>> SYNOPSIS
>>        struct acrn_mmiodev {
>>            __u8 name[8];
>>            struct {
>>              __u64 user_vm_pa;
>>              __u64 service_vm_pa;
>>              __u64 size;
>>              __u64 mem_type;
>>            } res[ACRN_MMIODEV_RES_NUM];
>>         };
>>
>> Members
>>        name        Name of the MMIO device.  res[].user_vm_pa:           Physi‐
>>                    cal  address  of User VM of the MMIO region for the MMIO de‐
>>                    vice.  res[].service_vm_pa:        Physical address of  Ser‐
>>                    vice VM of the MMIO region for the MMIO device.  res[].size:
>>                    Size   of   the   MMIO   region   for   the   MMIO   device.
>>                    res[].mem_type:             Memory type of the  MMIO  region
>>                    for the MMIO device.
>>
>> Description
>>        This structure will be passed to hypervisor directly.
>>
>> SEE ALSO
>>        Kernel   file   include/uapi/linux/acrn.h  struct  acrn_mmio_request(9),
>>        struct   acrn_pio_request(9),   struct    acrn_pci_request(9),    struct
>>        acrn_io_request(9),  struct  acrn_ioreq_notify(9),  struct  acrn_vm_cre‐
>>        ation(9), struct acrn_gp_regs(9), struct acrn_descriptor_ptr(9),  struct
>>        acrn_regs(9), struct acrn_vcpu_regs(9), struct acrn_vm_memmap(9), struct
>>        acrn_ptdev_irq(9),  struct  acrn_pcidev(9),  struct acrn_vdev(9), struct
>>        acrn_msi_entry(9),       struct       acrn_cstate_data(9),        struct
>>        acrn_pstate_data(9), struct acrn_ioeventfd(9), struct acrn_irqfd(9)
>>
>>
>> and here is the Members section after my patch:
>>
>> Members
>>        name        Name of the MMIO device.
>>
>>        res         MMIO resource descriptor info.
>>
>>        res.user_vm_pa
>>                    Physical  address of User VM of the MMIO region for the MMIO
>>                    device.
>>
>>        res.service_vm_pa
>>                    Physical address of Service VM of the MMIO  region  for  the
>>                    MMIO device.
>>
>>        res.size    Size of the MMIO region for the MMIO device.
>>
>>        res.mem_type
>>                    Memory type of the MMIO region for the MMIO device.
>>
>>
>>> What do you think ?
>>
>> Sure, if you want to leave the file as is, that's your choice.
>> Consider this patch dropped.
> 
> Yes, you are right. The `dump_struct` in `linux/scripts/kernel-doc.pl` can't pasre
> the `[]` properly since it can't tell this is for comment or for a struct_members.
> 
> So before kernel-doc.pl could handle the Nested structure array properly, maybe
> define a structure for `res` maybe the better way to avoid the confusing.

We no longer use kernel-doc.pl. It has been rewritten in Python. The new
script is scripts/kernel-doc.py.

> Would you please help to define a `structure acrn_mmio_dev_res` just before
> `structure acrn_mmio_dev` ?
See below. Is that what you mean?
---
 include/uapi/linux/acrn.h |   36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

--- linux-next-20251024.orig/include/uapi/linux/acrn.h
+++ linux-next-20251024/include/uapi/linux/acrn.h
@@ -418,26 +418,32 @@ struct acrn_pcidev {
 };
 
 /**
- * struct acrn_mmiodev - Info for assigning or de-assigning a MMIO device
- * @name:			Name of the MMIO device.
- * @res[].user_vm_pa:		Physical address of User VM of the MMIO region
- *				for the MMIO device.
- * @res[].service_vm_pa:	Physical address of Service VM of the MMIO
- *				region for the MMIO device.
- * @res[].size:			Size of the MMIO region for the MMIO device.
- * @res[].mem_type:		Memory type of the MMIO region for the MMIO
- *				device.
+ * struct acrn_mmio_dev_res - MMIO device resource description
+ * @user_vm_pa:		Physical address of User VM of the MMIO region
+ *			for the MMIO device.
+ * @service_vm_pa:	Physical address of Service VM of the MMIO
+ *			region for the MMIO device.
+ * @size:		Size of the MMIO region for the MMIO device.
+ * @mem_type:		Memory type of the MMIO region for the MMIO
+ *			device.
+ */
+struct acrn_mmio_dev_res {
+	__u64	user_vm_pa;
+	__u64	service_vm_pa;
+	__u64	size;
+	__u64	mem_type;
+};
+
+/**
+ * struct acrn_mmiodev - Info for assigning or de-assigning an MMIO device
+ * @name:	Name of the MMIO device.
+ * @res:	Array of MMIO device descriptions
  *
  * This structure will be passed to hypervisor directly.
  */
 struct acrn_mmiodev {
 	__u8	name[8];
-	struct {
-		__u64	user_vm_pa;
-		__u64	service_vm_pa;
-		__u64	size;
-		__u64	mem_type;
-	} res[ACRN_MMIODEV_RES_NUM];
+	struct acrn_mmio_dev_res res[ACRN_MMIODEV_RES_NUM];
 };
 
 /**


