Return-Path: <linux-kernel+bounces-824009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9963FB87EB6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659C91C801AB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 05:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F1B24BC0A;
	Fri, 19 Sep 2025 05:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZF9HLF9b"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1308B2E40E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 05:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758260060; cv=none; b=Fw1sYCJEAcV9UtPQxLfFA4pW6tt5gumQu7S0J+el1ln8m+jurHMfuRB4FyNoPTBzD9JqbImTL9g17gFmaUPd/Xf6Zcs4OZGPoA+nnvNIIcMpsaHZ22ISsbxQ8KJHGDnvVDL8gPWimnpXWFghY/xTkLoTe7YfnCS1sXzwAYjDnmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758260060; c=relaxed/simple;
	bh=9SxHfrcqskz5jRgs+Z6aXfQaOLQgnlPW6FQQBEu6sYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r6+csy5c0/2LhS5en5FAKiHj3HlZTkFpqE1Gd3x6QCmizse7DD2xDSapY5kPj7gqYfVR1XebkFVn6trDHuND2/x2J0fPny2EeVoWYYHu8Gph6M2Hn4jRWnr7WfjL8hldVOUWtnPBr/RSq1rzSrZgR5RP4BSPwVOnTaO/sEEzdSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZF9HLF9b; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758260058; x=1789796058;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9SxHfrcqskz5jRgs+Z6aXfQaOLQgnlPW6FQQBEu6sYs=;
  b=ZF9HLF9bApun9txyh9wgHVyMcsvnhqJ7FmdxAbl8/DXDToGsI6PQ9i+b
   8ccXD4tyx3TlZKESgmokwBPisoRBN2nf/HhGfZcSnNpvsBtNIzMSVQJaV
   1zbKyujHw7FKZ9TJD7dMwgteV2HqBrAhT8Dxk/OAG+saNgqCtzPDVrpmC
   3+BqRzil+rYCPpKhEWn92L4jYZ+ooFCdX1WOt/lFrpkZnU7Zh9/EIQibg
   cZjq3/w44mCnw3gLsdviyZAJmRmSYrxUz+PTaJjvLj5q/j6fBroLj8VSx
   tg+/9HHXyUznOrDSTGV7Mw7+STNvJDEXZyzxmdq5Xo0f6nf/OWeBJ7WLx
   w==;
X-CSE-ConnectionGUID: Dj3QqsfqRBC5QaVrpe+2vw==
X-CSE-MsgGUID: eEW7IXlVTnODDbfnKsE/1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60548051"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60548051"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 22:34:17 -0700
X-CSE-ConnectionGUID: Yn7nF68pQyWlTCBAyVY3fQ==
X-CSE-MsgGUID: 0aE4g3U1S76D8CaE26qk0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="175568596"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 22:34:12 -0700
Message-ID: <eced5393-16f1-4756-9703-3bae05160ade@linux.intel.com>
Date: Fri, 19 Sep 2025 13:31:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] x86/mm: Use pagetable_free()
To: Dave Hansen <dave.hansen@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Alistair Popple <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
 iommu@lists.linux.dev, security@kernel.org, linux-kernel@vger.kernel.org
References: <20250905055103.3821518-1-baolu.lu@linux.intel.com>
 <20250905055103.3821518-6-baolu.lu@linux.intel.com>
 <20250905184115.GQ616306@nvidia.com>
 <04983c62-3b1d-40d4-93ae-34ca04b827e5@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <04983c62-3b1d-40d4-93ae-34ca04b827e5@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/6/25 04:11, Dave Hansen wrote:
> On 9/5/25 11:41, Jason Gunthorpe wrote:
>>> --- a/arch/x86/mm/init_64.c
>>> +++ b/arch/x86/mm/init_64.c
>>> @@ -1013,7 +1013,7 @@ static void __meminit free_pagetable(struct page *page, int order)
>>>   		free_reserved_pages(page, nr_pages);
>>>   #endif
>>>   	} else {
>>> -		free_pages((unsigned long)page_address(page), order);
>>> +		pagetable_free(page_ptdesc(page));
>>>   	}
>>>   }
>> Er.. So if bootmem happens to be under the table and we happen to free
>> it due to memory hotplug we don't go through the SVA fixing path?
>>
>> Seems wrong??
> 
> On second thought...
> 
> Yes, freeing bootmem with no SVA fixing is wrong. It should be fixed.
> Period. But, it's wrong one time for something super rare: memory unplug
> of memory that was present at boot. It also can't be triggered by
> unprivileged users.
> 
> As-is, this series fixes vfree(). That path is not nearly rare, can
> happen an arbitrary number of times on each boot, and might even be
> triggered by folks that are less than root.
> 
> So I kinda think we should just make clear that this series leaves
> _some_ holes, but I do think it should go in mostly as-is.
> 

Okay, I will put this in the commit message and update this series with
a new version.

Thanks,
baolu

