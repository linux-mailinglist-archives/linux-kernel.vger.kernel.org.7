Return-Path: <linux-kernel+bounces-802178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06817B44E87
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C4C3B87D2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E4228725F;
	Fri,  5 Sep 2025 07:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vJGoX7tH"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF21286D70
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 07:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757055617; cv=none; b=ekooCWqu+ZKxjcrWmUcyxHI0d5llacBbZwYMP51yZuAqtj/B+2qQaHE2Suw5suGfl3R2XD6mASihO4auFIQP5RAt1todNhE3b691yUv3PirPg8nqVrdkBRVHJafvRJFAaRVwFmtdcL3NAtpwBoDbBqM90ZCpKwBP0/8gUmu5Jxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757055617; c=relaxed/simple;
	bh=nHVvz5lhl/XbT/mu17TtR0WDza+IuiXy9pkEoOXmrdk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=NPRT7DcdvzFY/kvmNEVlTkKH+u0HLB5vaOj54x4brWpdMnXHZmjsx8h3afi3Rlq7+/IG3J28nPq6psDyezJ5IjmhBj8UfRy0wrKvplKGtOndFLTJMV0wp01nvxd8J5fdb3lSR3m8xmtoUUi3VxESYeArdVpkQL0hJiUyhnrOZmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=vJGoX7tH; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250905070004epoutp042db4b04b938a28835bd724f78a42b9db~iUMM7EhlP1616816168epoutp04J
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 07:00:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250905070004epoutp042db4b04b938a28835bd724f78a42b9db~iUMM7EhlP1616816168epoutp04J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1757055604;
	bh=Cs1Wwg/pcc9OLfauYBxaMcnQ8auZ8WYaY8tqm6cdbXk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vJGoX7tH2UegcN03nvjaXjfcqvdpNEDUpYsGJcHBvM2X6L+klgiMr2tsY2pHsYlWx
	 xQlbSqG7XKpm4ZJgtA7NEYCskFgmzW5XFR7lWwGwQ6FG99HaJG4VhU64mEIIqcJ65O
	 tEnxYKJVrb6KhY6rSNBnK79nMipnoN94HD49+fOk=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250905070003epcas5p1d0b0001fb09ce8f85b09cc966455ba63~iUMMTAjWQ1344713447epcas5p1J;
	Fri,  5 Sep 2025 07:00:03 +0000 (GMT)
Received: from epcpadp1new (unknown [182.195.40.141]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4cJ6fq2Ysqz6B9mb; Fri,  5 Sep
	2025 07:00:03 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250904132422epcas5p3253bf8b371a27169899f4ce089d40244~iFydmnS-X1243012430epcas5p3t;
	Thu,  4 Sep 2025 13:24:22 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250904132421epsmtip1610130f243c2a3f9adb650a9d7c6041e~iFycHnEsI2709727097epsmtip1l;
	Thu,  4 Sep 2025 13:24:20 +0000 (GMT)
Date: Thu, 4 Sep 2025 18:54:07 +0530
From: Neeraj Kumar <s.neeraj@samsung.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, gost.dev@samsung.com,
	a.manzanares@samsung.com, vishak.g@samsung.com, neeraj.kernel@gmail.com,
	cpgs@samsung.com
Subject: Re: [PATCH V2 01/20] nvdimm/label: Introduce NDD_CXL_LABEL flag to
 set cxl label format
Message-ID: <1983025922.01757055603347.JavaMail.epsvc@epcpadp1new>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7ff8b51b-7263-4d9c-99f8-1b507cf46262@intel.com>
X-CMS-MailID: 20250904132422epcas5p3253bf8b371a27169899f4ce089d40244
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----At96h8_oYHqdM-HzD.Qv-z6Hqrsj5DpI3AOnKMLFsbTdazMP=_eab9c_"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20250730121223epcas5p1386bdf99a0af820dd4411fbdbd413cd5
References: <20250730121209.303202-1-s.neeraj@samsung.com>
	<CGME20250730121223epcas5p1386bdf99a0af820dd4411fbdbd413cd5@epcas5p1.samsung.com>
	<20250730121209.303202-2-s.neeraj@samsung.com>
	<20250813141218.0000091f@huawei.com>
	<7ff8b51b-7263-4d9c-99f8-1b507cf46262@intel.com>

------At96h8_oYHqdM-HzD.Qv-z6Hqrsj5DpI3AOnKMLFsbTdazMP=_eab9c_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 15/08/25 11:06AM, Dave Jiang wrote:
>
>
>On 8/13/25 6:12 AM, Jonathan Cameron wrote:
>> On Wed, 30 Jul 2025 17:41:50 +0530
>> Neeraj Kumar <s.neeraj@samsung.com> wrote:
>>
>>> Prior to LSA 2.1 version, LSA contain only namespace labels. LSA 2.1
>>> introduced in CXL 2.0 Spec, which contain region label along with
>>> namespace label.
>>>
>>> NDD_LABELING flag is used for namespace. Introduced NDD_CXL_LABEL
>>> flag for region label. Based on these flags nvdimm driver performs
>>> operation on namespace label or region label.
>>>
>>> NDD_CXL_LABEL will be utilized by cxl driver to enable LSA2.1 region
>>> label support
>>>
>>> Accordingly updated label index version
>>>
>>> Signed-off-by: Neeraj Kumar <s.neeraj@samsung.com>
>> Hi Neeraj,
>>
>> A few comments inline.
>>
>>> diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
>>> index 04f4a049599a..7a011ee02d79 100644
>>> --- a/drivers/nvdimm/label.c
>>> +++ b/drivers/nvdimm/label.c
>>> @@ -688,11 +688,25 @@ static int nd_label_write_index(struct nvdimm_drvdata *ndd, int index, u32 seq,
>>>  		- (unsigned long) to_namespace_index(ndd, 0);
>>>  	nsindex->labeloff = __cpu_to_le64(offset);
>>>  	nsindex->nslot = __cpu_to_le32(nslot);
>>> -	nsindex->major = __cpu_to_le16(1);
>>> -	if (sizeof_namespace_label(ndd) < 256)
>>> +
>>> +	/* Set LSA Label Index Version */
>>> +	if (ndd->cxl) {
>>> +		/* CXL r3.2 Spec: Table 9-9 Label Index Block Layout */
>>> +		nsindex->major = __cpu_to_le16(2);
>>>  		nsindex->minor = __cpu_to_le16(1);
>>> -	else
>>> -		nsindex->minor = __cpu_to_le16(2);
>>> +	} else {
>>> +		nsindex->major = __cpu_to_le16(1);
>>> +		/*
>>> +		 * NVDIMM Namespace Specification
>>> +		 * Table 2: Namespace Label Index Block Fields
>>> +		 */
>>> +		if (sizeof_namespace_label(ndd) < 256)
>>> +			nsindex->minor = __cpu_to_le16(1);
>>> +		else
>>> +		 /* UEFI Specification 2.7: Label Index Block Definitions */
>>
>> Odd comment alignment. Either put it on the else so
>> 		else /* UEFI 2.7: Label Index Block Defintions */
>>
>> or indent it an extra tab
>>
>> 		else
>> 			/* UEFI 2.7: Label Index Block Definitions */
>> 			
>>> +			nsindex->minor = __cpu_to_le16(2);
>>> +	}
>>> +
>>>  	nsindex->checksum = __cpu_to_le64(0);
>>>  	if (flags & ND_NSINDEX_INIT) {
>>>  		unsigned long *free = (unsigned long *) nsindex->free;
>>
>>> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
>>> index e772aae71843..0a55900842c8 100644
>>> --- a/include/linux/libnvdimm.h
>>> +++ b/include/linux/libnvdimm.h
>>> @@ -44,6 +44,9 @@ enum {
>>>  	/* dimm provider wants synchronous registration by __nvdimm_create() */
>>>  	NDD_REGISTER_SYNC = 8,
>>>
>>> +	/* dimm supports region labels (LSA Format 2.1) */
>>> +	NDD_CXL_LABEL = 9,
>>
>> This enum is 'curious'.  It combined flags from a bunch of different
>> flags fields and some stuff that are nothing to do with flags.
>>
>> Anyhow, putting that aside I'd either rename it to something like
>> NDD_REGION_LABELING (similar to NDD_LABELING that is there for namespace labels
>> or just have it a meaning it is LSA Format 2.1 and drop the fact htat
>> also means region labels are supported.
>
>I agree. I had a conversation with Dan about it where I mentioned calling it CXL to describe LSA 2.1 just doesn't seem quite right. He also offered up something like NDD_REGION_LABELING instead of NDD_CXL_LABEL. So +1 to this comment.
>
>DJ

Sure Dave, I will rename it to NDD_REGION_LABELING in next patch-set

Regards,
Neeraj

------At96h8_oYHqdM-HzD.Qv-z6Hqrsj5DpI3AOnKMLFsbTdazMP=_eab9c_
Content-Type: text/plain; charset="utf-8"


------At96h8_oYHqdM-HzD.Qv-z6Hqrsj5DpI3AOnKMLFsbTdazMP=_eab9c_--


