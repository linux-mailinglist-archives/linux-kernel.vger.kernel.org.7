Return-Path: <linux-kernel+bounces-843172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE71BBBE8F7
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 17:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A65603A4510
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 15:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E982D979B;
	Mon,  6 Oct 2025 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B3jkVGxu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E212641C6;
	Mon,  6 Oct 2025 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759766156; cv=none; b=WkkRWzEriTRGgu0qcNuv6f2GLUDzrrPs8Erh12u9/VGVJvTLVJBN/fkL8w27gC69kWYtvwhE6nuVwl5m6tmo1qOLqtuY9n7YZjwwX/dgUHcUmeQhyQZhNZRqmJx25+1IQopQNgqGUzIriHVx881kZUKa0w6MTNB56BmN6diLvCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759766156; c=relaxed/simple;
	bh=bbY3CJftkec/YNYKO4Fm0HrwlOp58R/d8MGE465xN9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+DEg3uIjJkU8DBEp8AnyKhdMmzzUw+8CETw8FFik/MumRIkABr6EdXzQfo0HnSnYL6XTTtOaSfxLRxtNNmb/dbdwCjwTDqt79NL/KRExuTSyY1y2e3j4wladhxnZ4yg9WibLT9mCf9YTnyqITbJxwjltkV8CqeB816UIEssUe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B3jkVGxu; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759766154; x=1791302154;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bbY3CJftkec/YNYKO4Fm0HrwlOp58R/d8MGE465xN9g=;
  b=B3jkVGxuJgKsdvHDpmUNzC6w3gcKTsdzq/NOGqEa8CUWUM+A+9h5Ptgh
   e+K7iBFfnyqtop7xODOqQPSMqY+cNuvnvoNM/OF7GWjAhkuQmrfNCPA2u
   IUFoD8yOXivYGTgUEZ1wiHphG099KCWsLMeTJvptGKNkHxjrvX65HCRh5
   IYWIP/Q0VfhfbFk/d7LETwyBq738QgOGJHlNoOl9GAtgvZeNmWZFvoSJ4
   nlm6sU9t/gexsRjoga3oMthRvXYFqXmzHs70uryQ0oRvSuo3Vb2YI6COI
   9qFTV6E+mACpyKguQsqh/kXUDy73iFRpixsXFeBOsOgQw5rakWLNgPF0x
   g==;
X-CSE-ConnectionGUID: orTPhdYSRLWkMs+zlTWlfA==
X-CSE-MsgGUID: On3YmYBgQEW8dpSckd8QtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="61974997"
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; 
   d="scan'208";a="61974997"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 08:55:54 -0700
X-CSE-ConnectionGUID: AX1pK7UCQ9CPvfrGsHWMSg==
X-CSE-MsgGUID: KjdhSbBLRLixqHRNPExRfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; 
   d="scan'208";a="184194089"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.110.110]) ([10.125.110.110])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 08:55:53 -0700
Message-ID: <361d0e84-9362-4389-a909-37878910b90f@intel.com>
Date: Mon, 6 Oct 2025 08:55:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 13/20] cxl/mem: Refactor cxl pmem region
 auto-assembling
To: Neeraj Kumar <s.neeraj@samsung.com>
Cc: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-kernel@vger.kernel.org, gost.dev@samsung.com,
 a.manzanares@samsung.com, vishak.g@samsung.com, neeraj.kernel@gmail.com,
 cpgs@samsung.com
References: <20250917134116.1623730-1-s.neeraj@samsung.com>
 <CGME20250917134157epcas5p1b30306bc8596b7b50548ddf3683c3b97@epcas5p1.samsung.com>
 <20250917134116.1623730-14-s.neeraj@samsung.com>
 <c7b41eb6-b946-4ac0-9ddd-e75ba4ceb636@intel.com>
 <1296674576.21759726502325.JavaMail.epsvc@epcpadp1new>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <1296674576.21759726502325.JavaMail.epsvc@epcpadp1new>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/29/25 6:30 AM, Neeraj Kumar wrote:
> On 23/09/25 03:37PM, Dave Jiang wrote:
>>
>>
>> On 9/17/25 6:41 AM, Neeraj Kumar wrote:
>>> In 84ec985944ef3, devm_cxl_add_nvdimm() sequence was changed and called
>>> before devm_cxl_add_endpoint(). It's because cxl pmem region auto-assembly
>>> used to get called at last in cxl_endpoint_port_probe(), which requires
>>> cxl_nvd presence.
>>>
>>> For cxl region persistency, region creation happens during nvdimm_probe
>>> which need the completion of endpoint probe.
>>>
>>> In order to accommodate both cxl pmem region auto-assembly and cxl region
>>> persistency, refactored following
>>>
>>> 1. Re-Sequence devm_cxl_add_nvdimm() after devm_cxl_add_endpoint(). This
>>>    will be called only after successful completion of endpoint probe.
>>>
>>> 2. Moved cxl pmem region auto-assembly from cxl_endpoint_port_probe() to
>>>    cxl_mem_probe() after devm_cxl_add_nvdimm(). It gurantees both the
>>>    completion of endpoint probe and cxl_nvd presence before its call.
>>
>> Given that we are going forward with this implementation [1] from Dan and drivers like the type2 enabling are going to be using it as well, can you please consider converting this change to Dan's mechanism instead of creating a whole new one?
>>
>> I think the region discovery can be done via the ops->probe() callback. Thanks.
>>
>> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?h=for-6.18/cxl-probe-order&id=88aec5ea7a24da00dc92c7778df4851fe4fd3ec6
>>
>> DJ
>>
> 
> Sure, Let me revisit this.
> It seems [1] is there in seperate branch "for-6.18/cxl-probe-order", and not yet merged into next, right?

Right. I believe Smita and Alejandro are using that as well. Depending on who gets there first. We can setup an immutable branch at some point.

[1]: https://lore.kernel.org/linux-cxl/20250822034202.26896-1-Smita.KoralahalliChannabasappa@amd.com/T/#t

DJ

> 
> 
> Regards,
> Neeraj
> 


