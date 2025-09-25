Return-Path: <linux-kernel+bounces-831663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81733B9D44D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 05:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3701A3825B2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91572E610B;
	Thu, 25 Sep 2025 03:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mJnEUl3G"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54181DFCB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758769501; cv=none; b=hEoe/buk97cb3x3T2ioS1053jG2hSGXtHsvBk1yrxsuLq7sUvK6zgcXx4eZbUrn47JImFWq/89ut42QxAgMuLD719hxFSYotiLfeMPNStfXj+w6OLlsH5A+CfMaapIGGF/XEXEfpwZ+9iU1FwVR5EPn1bGnC6cGOYE/l/79mtO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758769501; c=relaxed/simple;
	bh=jZFA8+dCY7j6Q7kQW4PqYzyZI6GA5lVMHhLr6N2xnUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jWQC5vQAlQp0byXuXeLG6U42srMTEDgiFJtoShWbWPigFVP/Waju8R7XNbI+94NII241Gw+t7BO6CG0lUDIUEKbkS+ZRqvenHfOVBifgGE27FJe6cCmPunutM8QhJompa0J/w/CqQYQFBP1adQpwv72hp6v4jiuKhgWCMC4k458=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mJnEUl3G; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758769498; x=1790305498;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jZFA8+dCY7j6Q7kQW4PqYzyZI6GA5lVMHhLr6N2xnUQ=;
  b=mJnEUl3GlKtdmhsR8M3Vrb+F1XM4i95e8UU0s9NsOpgERXFJFS9fmeJH
   76bHGuw4Im1ckdoynjxg2xYF0+O4iAtV4moRB2zzMGI+qEW3v+8teE/Wr
   uU8u4X9Ktk1OAipiimklvMdvUg1ifRZJGwde3GBe0iaxXVJwjfiD0D/DD
   EuwGG3lMIN3SNmkFWK9yOVfEjIiz2z5zROH5gzPI1ONYr+e76IZsxFFvd
   JtrNtLyGpHkttFO2P5396y792cgmS11g04PCTM3ZehOk87/3l6DdKsICZ
   E2bqx98waMY+qUwqOwfn1fH/xxE0EChw2qRU8to0E5Y04sEU8pELkh1hG
   A==;
X-CSE-ConnectionGUID: 6xAptPCoTZK1DJhyN8SoHg==
X-CSE-MsgGUID: qu5UxiB2RFyabKJe9N26bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="63705645"
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="63705645"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 20:04:56 -0700
X-CSE-ConnectionGUID: 5Vl9Zqd0RDq1jb9Bc6kSTg==
X-CSE-MsgGUID: iu7vv71QQJOxHbsIGnfy7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="176805445"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 20:04:54 -0700
Message-ID: <515e2b1a-cef8-47be-a89c-de7b73367ff9@linux.intel.com>
Date: Thu, 25 Sep 2025 11:01:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Disallow dirty tracking if incoherent
 page walk
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250924083447.123224-1-baolu.lu@linux.intel.com>
 <20250924120431.GF2617119@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250924120431.GF2617119@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/25 20:04, Jason Gunthorpe wrote:
> On Wed, Sep 24, 2025 at 04:34:46PM +0800, Lu Baolu wrote:
>> Dirty page tracking relies on the IOMMU atomically updating the dirty bit
>> in the paging-structure entry. For this operation to succeed, the paging-
>> structure memory must be coherent between the IOMMU and the CPU. In
>> another word, if the iommu page walk is incoherent, dirty page tracking
>> doesn't work.
>>
>> The Intel VT-d specification, Section 3.10 "Snoop Behavior" states:
>>
>> "Remapping hardware encountering the need to atomically update A/EA/D bits
>>   in a paging-structure entry that is not snooped will result in a non-
>>   recoverable fault."
>>
>> To prevent an IOMMU from being incorrectly configured for dirty page
>> tracking when it is operating in an incoherent mode, mark SSADS as
>> supported only when both ecap_slads and ecap_smpwc are supported.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.h | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>

Thank you!

> Basically due to the above spec the IOMMU implementation would be
> invalid to set slads and !smpwc ?

I suppose so.

But even if smpwc is set to 1, software could still configure an
incoherent page walk by clearing the Page Walk Snoop bit in the PASID
entry. (The current Intel IOMMU driver always sets that bit as long as
the capability exists). In that case, the hardware might encounter the
situation mentioned above.

Thanks,
baolu

