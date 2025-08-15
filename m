Return-Path: <linux-kernel+bounces-771308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E3DB2855D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C773B6A92
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F90823E356;
	Fri, 15 Aug 2025 17:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mqnk78hf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231E231771F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 17:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755280008; cv=none; b=Dj6MPMv++28Iqlt6hH5k63whwNPMbE0kiIRICJe39qsDdN99ogfyvx6mOb9vtX5otkj6naEb1X311j9qgKkGi6KrhnfjKC0RLv/l1l15cC7H8emTa92u3TbXkQC7Zul+aZ41JcmvpZjq6+MYDGwzHzMDVAoj0Z6lGA+Q2RfG7+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755280008; c=relaxed/simple;
	bh=t+Wg/DpQyDidK1Aj2g/Ezl8vUgRcEycT5CPft3M/+JY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ORPKNmJy75Z5X0/+lBRoJtKZrIH1gRfd50fWwrWbXvnt+8Hh1BY4DBb0/iL+doCO5k8TAG7eDvlTpzoh3NjbOnV7smr/9MjyAWA1zS9i8K/mDjacUjcrexStvX8/GFKA12mx5IrF5+dJMmaHbuttOL1zzQcIw+0NA7Is/O3YRUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mqnk78hf; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755280006; x=1786816006;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t+Wg/DpQyDidK1Aj2g/Ezl8vUgRcEycT5CPft3M/+JY=;
  b=mqnk78hfRwYOB5suxy8RK2LY848IkJAgeuvdGjr0lH1SinKMDbuYtfFI
   FvSRlB9wbmuI04wbKKG5bQlIsOc7A74PFMCfkzsgzZu1lssmNXsSr2l03
   jkZLFbSRri1lxDswLCied4VJicYV0LL2fhh9CFjj+x1Tmk8qftPZo5bOB
   mkBAGHwRHV+cuJF7TRtsjEjr6/pxFjzo4G2ljX1w0VJi8LJo7Ww2tL0+q
   qLYgRkq/0oPUChsgtPq+1UQhG27BBKbiYVKwwiVDxOaQ3Y0hFaoLVO0Jg
   oDQztUk9LN2IUVxFi7+lQ18JErIsOMP1yiyhpYwg/3hJQiC03+m4sq1ye
   w==;
X-CSE-ConnectionGUID: o9cgmgCXS5etJmTMVD3eOw==
X-CSE-MsgGUID: plyCJ4LMRI6xbewUu4I5EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="57559239"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57559239"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 10:46:45 -0700
X-CSE-ConnectionGUID: 6U63FjjURNaM7lN6mDnuZg==
X-CSE-MsgGUID: fF17NeaSRoarQE//TkQicw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166279962"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 10:46:46 -0700
Received: from [10.124.223.118] (unknown [10.124.223.118])
	by linux.intel.com (Postfix) with ESMTP id EA10A20B5720;
	Fri, 15 Aug 2025 10:46:44 -0700 (PDT)
Message-ID: <ed04152f-544b-439c-8489-26f72e7e9687@linux.intel.com>
Date: Fri, 15 Aug 2025 10:46:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/tdx: support VM area addresses for
 tdx_enc_status_changed
To: Kiryl Shutsemau <kirill@shutemov.name>,
 Shixuan Zhao <shixuan.zhao@hotmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <OS9PR01MB15202A41CF04F0BBF8CE244B48D34A@OS9PR01MB15202.jpnprd01.prod.outlook.com>
 <enhnj775ryshjrqer24ki7wibngxaj5ydos7xjgone6wobuvdn@77luyq4cawva>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <enhnj775ryshjrqer24ki7wibngxaj5ydos7xjgone6wobuvdn@77luyq4cawva>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/15/25 9:43 AM, Kiryl Shutsemau wrote:
> On Thu, Aug 14, 2025 at 10:34:02PM -0400, Shixuan Zhao wrote:
>> Currently tdx_enc_status_changed uses __pa which will only accept
>> addresses within the linear mapping. This patch allows memory allocated
>> in the VM area to be used.
>>
>> For VM area addresses, we do it page-by-page since there's no guarantee
>> that the physical pages are contiguous. If, however, the entire range
>> falls within the linear mapping, we provide a fast path that do the
>> entire range just like the current version so that the performance
>> would remain roughly the same as current.
>>
>> Signed-off-by: Shixuan Zhao <shixuan.zhao@hotmail.com>
>> ---
>> Hi,
>>
>> I recently ran into a problem where tdx_enc_status_changed was not
>> implemented to handle memory mapped in the kernel VM area (e.g., ioremap
>> or vmalloc). I have created a patch that tries to fix this problem. The
>> overall idea is to keep a fast path for the current __pa-based routine
>> if the range falls within the linear mapping, otherwise fall to a page-by-
>> page page table walk for those in the VM area.
> Could you tell more about use-case?
>
> I am not sure we ever want to convert vmalloc()ed memory to shared as it
> will result in fracturing direct mapping.
>
> And it seems to the wrong layer to make it. If we really need to go
> this pass (I am not convinced) it has to be done in set_memory.c
>
> Sathya, I remember you did something similar for REPORT, right?

Yes, we attempted something similar for Quote buffer allocation.

https://patchew.org/linux/20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com/20220609025220.2615197-4-sathyanarayanan.kuppuswamy@linux.intel.com/

Our approach was to create an alias virtual mapping for the Quote buffer to
avoid modifying direct map page attributes. However, we eventually dropped
this idea due to the complexity of keeping the alias mapping in sync, as well
as issues with load_unaligned_zeropad().

Related discussion can be found in,

https://patchew.org/linux/20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com/20220609025220.2615197-5-sathyanarayanan.kuppuswamy@linux.intel.com/

>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


