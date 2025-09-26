Return-Path: <linux-kernel+bounces-833630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8CCBA27D1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9815117E0FA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 06:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECD2279DA9;
	Fri, 26 Sep 2025 06:03:35 +0000 (UTC)
Received: from out28-3.mail.aliyun.com (out28-3.mail.aliyun.com [115.124.28.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922281D90DF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758866614; cv=none; b=RU0Bn/GIgpE67a9PzXS3ErzgHGCI7yUQQBQ+YkgWzFZW0cDY4SDgPiLecAXjWcfyV6l49/jhY0i9qrZgzz/BfDr4qwAdgP7ayg4NKcRlTzSDPFYvlNCA84yNT/YogWXvtynI4nl/OSBZE5zHep1815ZsR9UnJNQcj5NszSPqvec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758866614; c=relaxed/simple;
	bh=og/xF9QMAao2Q3EU36SEgj/hEd205Mwyy7dVTmlYDrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qxtQKe7WTRof+ykIbqVthWnwIyZfDKJAERuE9EKo18W3OaRyboeLTCLOOBB9JrIOuj2oCYbhYocuqrmCsLlqknjBXt2Dd6C+O4WWGoxcFTtaiIdS+axBJfN9CrPl4OWlkW+Wf3R9DfZpPm6ga5wswda/S92D4jJTg4VBaHh8LBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn; spf=pass smtp.mailfrom=bosc.ac.cn; arc=none smtp.client-ip=115.124.28.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bosc.ac.cn
Received: from 172.38.31.119(mailfrom:guoyaxing@bosc.ac.cn fp:SMTPD_---.enkcLB4_1758866281 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 26 Sep 2025 13:58:02 +0800
Message-ID: <dbc55234-58b2-4d3f-8d0e-e78e148b9944@bosc.ac.cn>
Date: Fri, 26 Sep 2025 13:57:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] doc: Add ABI documentation for uio_pci_sva driver
 sysfs attributes
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, wangran@bosc.ac.cn, zhangjian@bosc.ac.cn,
 anxu@bosc.ac.cn
References: <20250925104018.57053-1-guoyaxing@bosc.ac.cn>
 <20250925104018.57053-3-guoyaxing@bosc.ac.cn>
 <2025092538-spokesman-disparity-1aca@gregkh>
From: yaxing guo <guoyaxing@bosc.ac.cn>
In-Reply-To: <2025092538-spokesman-disparity-1aca@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Greg,

Thank you for your feedback.

On 9/25/2025 8:32 PM, Greg KH wrote:
> On Thu, Sep 25, 2025 at 06:40:18PM +0800, Yaxing Guo wrote:
>> Add ABI documentation for the sysfs interface provided by the
>> uio_pci_sva driver, specifically the 'pasid' attribute.
>>
>> The 'pasid' attribute exposes the Process Address Space ID (PASID)
>> assigned by the IOMMU to the device for use with Shared Virtual
>> Addressing (SVA). User-space UIO applications read this attribute
>> to obtain the PASID and program it into the device's configuration
>> registers, enabling the device to perform DMA using user-space
>> virtual addresses.
>>
>> This attribute appears under:
>> /sys/bus/pci/drivers/uio_pci_sva/<pci_dev>/pasid
>>
>> Signed-off-by: Yaxing Guo <guoyaxing@bosc.ac.cn>
>> ---
>>   .../ABI/testing/sysfs-driver-uio_pci_sva-pasid    | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/sysfs-driver-uio_pci_sva-pasid
>>
>> diff --git a/Documentation/ABI/testing/sysfs-driver-uio_pci_sva-pasid b/Documentation/ABI/testing/sysfs-driver-uio_pci_sva-pasid
>> new file mode 100644
>> index 000000000000..a6afa8c2775c
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-driver-uio_pci_sva-pasid
>> @@ -0,0 +1,15 @@
>> +What:		/sys/bus/pci/drivers/uio_pci_sva/<pci_dev>/pasid
>> +Date:		September 2025
>> +Contact:	Yaxing Guo <guoyaxing@bosc.ac.cn>
>> +Description:
>> +		Process Address Space ID (PASID) assigned by IOMMU driver to
>> +		the device for use witch Shared Virtual Addressing (SVA).
> 
> "with", not "witch", right?
> 
>> +
>> +		This read-only attribute exposes the PASID allocated by the
>> +		IOMMU driver during sva device binding.
>> +
>> +		User-space UIO applications must read this attribute to
>> +		obtain the PASID and program it into the device's configuration
>> +		registers. This enables the device to perform DMA using
>> +		user-space virtual address, with address translation handled
>> +		by IOMMU.
> 
> What is a PASID?  What format is it in?
> 
> How can it then be used in userspace?  What is a "device configuration
> register" and what api uses it?
> 
> And where is the userspace code that interacts with all of this?
> 

The UIO userspace code is inherently tied to the hardware and its
register layout. Therefore, there isn't a single open-source userspace
implementation(In my job, this is for a simple FPAG-based test device 
used for iommu-sva functionality validation).

However, to help users understand how to use the interface, I can add a
**code example in this ABI documentation** that demonstrates:

- Reading the PASID from sysfs
- Mapping the device's register space via /dev/uioX
- Writing the PASID to a device-specific register (with example offset)

The code maybe like this:

map = mmap(..., "/dev/uio0", ...);

f = fopen("/sys/.../pasid", "r");
fscanf(f, "%d", &pasid);

map[REG_PASID_OFFSET] = pasid;

Would you prefer that I include such an example directly in the ABI doc, 
or is there another way you'd like this to be documented?

> And finally, this too can be part of the first commit.
> 
> thanks,
> 
> greg k-h

Best regards,
Yaxing Guo


