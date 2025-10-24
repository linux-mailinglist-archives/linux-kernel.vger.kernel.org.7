Return-Path: <linux-kernel+bounces-868134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F2BC04710
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 259E51A04831
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 06:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25097231832;
	Fri, 24 Oct 2025 06:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NJUKzOUf"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C067726AEC
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761285965; cv=none; b=BCCY6CVwJjfX4pqp0E2yol493W1sJaBzw3upjWjPxia9C0xnNIocw0dUDz/jdBEMyCKQEtF7iL0BmoxZk0drwNiU7oiKpZ9n//VePbLIGyKJBzaRKeFvpxYfGWmUPLPFcTELKCHZrDrOZ5rqxFucigx+P/l/LAqt8ixXrV4jLiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761285965; c=relaxed/simple;
	bh=rXF4umgSu9oOr5/8TRrw6ExyTTxD5m+8vb93+vkExg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oO5uaXhI9QPHmeFXXUxgAfeIuG2iE04iRj8FEfuVQXIftzmQQdCm9B9ULjftyNhRELzDjFSKr73twHxe5DHifjrWKUnIfs7YcUdgNoECUqqhRe4UyXIiD+trAdVsLBoyriRz16akYowSgFVUAS5KCbngKadV0XtOFuEHXL4P0Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NJUKzOUf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=VmfSVBHCqDy/D97x5HXHHleMilR/qAd2VWq9WxztGek=; b=NJUKzOUfmODFhKbdHHfgxyplfk
	sZ39sRaVPxoZN6v1Z5Vb1epn7T46OZbzcS9xJ7++KfEUB/gfW6jkPTwfiiLG9fFXxFVvJMwjx46Ej
	0q2nVs0HHdzbV4c8Lab9xdR0L773Y+nUI5m+p7vcalbk3a3er6Rky93TPjb7ltjXeLttGncnF/D54
	v3sb6+vyubbAeDB9TTkU94O9TLQJB1Rv7ezOz/HoGxELZGl6j14woMQTAWFqq3et8HtASEjAsaS6Y
	UPSn3A1D1aUSwuihF5W9VDbGmf2p1qjnfub44VecIqxOcafraVMKPj7nWrpZsLBgkaje31BMWAz67
	CHugddvQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCAw5-00000008Jz7-038p;
	Fri, 24 Oct 2025 06:06:01 +0000
Message-ID: <213c918b-b4aa-4174-af89-a4d17e8c30dc@infradead.org>
Date: Thu, 23 Oct 2025 23:06:00 -0700
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
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <SJ1PR11MB615389E066F50BBB68686A26BFF1A@SJ1PR11MB6153.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10/23/25 11:00 PM, Li, Fei1 wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>> Sent: Friday, October 24, 2025 12:42 PM
>> To: linux-kernel@vger.kernel.org
>> Cc: Randy Dunlap <rdunlap@infradead.org>; Li, Fei1 <fei1.li@intel.com>;
>> acrn-dev@lists.projectacrn.org; Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org>
>> Subject: [PATCH] virt: acrn: fix kernel-doc in <uapi/linux/acrn.h>
>>
>> Fix the kernel-doc comments for struct acrn_mmiodev so that all struct
>> members are rendered correctly.
>> Correct io_base to io_addr in struct acrn_vdev.
>>
>> acrn.h:441: warning: Function parameter or struct member 'res'
>>  not described in 'acrn_mmiodev'
>> acrn.h:479: warning: Function parameter or struct member 'io_addr'
>>  not described in 'acrn_vdev'
>> acrn.h:479: warning: Excess struct member 'io_base' description  in
>> 'acrn_vdev'
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> ---
>> Cc: Fei Li <fei1.li@intel.com>
>> Cc: acrn-dev@lists.projectacrn.org
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>>  include/uapi/linux/acrn.h |   11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> --- linux-next-20251022.orig/include/uapi/linux/acrn.h
>> +++ linux-next-20251022/include/uapi/linux/acrn.h
>> @@ -420,12 +420,13 @@ struct acrn_pcidev {
>>  /**
>>   * struct acrn_mmiodev - Info for assigning or de-assigning a MMIO device
>>   * @name:			Name of the MMIO device.
>> - * @res[].user_vm_pa:		Physical address of User VM of the MMIO
>> region
>> + * @res:			MMIO resource descriptor info.
> 
> Hi Randy
> 
> Thanks for cooking this patch to help fix these warning.
> Could you just add the comment for `res` and keep the other comments for the fields of ` struct acrn_mmiodev ` ?
> 

Do you mean leave the [] square brackets in the field name?
If that's what you mean, that's not valid kernel-doc notation.

> 
>> + * @res.user_vm_pa:		Physical address of User VM of the MMIO
>> region
>>   *				for the MMIO device.
>> - * @res[].service_vm_pa:	Physical address of Service VM of the MMIO
>> + * @res.service_vm_pa:		Physical address of Service VM of the
>> MMIO
>>   *				region for the MMIO device.
>> - * @res[].size:			Size of the MMIO region for the MMIO
>> device.
>> - * @res[].mem_type:		Memory type of the MMIO region for the
>> MMIO
>> + * @res.size:			Size of the MMIO region for the MMIO
>> device.
>> + * @res.mem_type:		Memory type of the MMIO region for the
>> MMIO
>>   *				device.
>>   *
>>   * This structure will be passed to hypervisor directly.
>> @@ -449,7 +450,7 @@ struct acrn_mmiodev {
>>   * @id.fields.legacy_id:	ID of the virtual device if not a PCI device
>>   * @slot:			Virtual Bus/Device/Function of the virtual
>>   *				device
>> - * @io_base:			IO resource base address of the virtual device
>> + * @io_addr:			IO resource base address of the virtual device
>>   * @io_size:			IO resource size of the virtual device
>>   * @args:			Arguments for the virtual device creation
>>   *

-- 
~Randy


