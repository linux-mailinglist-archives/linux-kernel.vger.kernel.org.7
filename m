Return-Path: <linux-kernel+bounces-843102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F36A3BBE688
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 16:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D19B4E4B84
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 14:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD96C2D6605;
	Mon,  6 Oct 2025 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RzgzRTjW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C88521FF48;
	Mon,  6 Oct 2025 14:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759762452; cv=none; b=gYueOiPo7M/b0M+FGILmJ1iaA9mj3xJiC3RqUtbFo1q5cY5AJTOpt6Lowzruw3Ejj2TSgDdFzNH1Oza1UngOWfmamm65fd19ojjuxZbnQgiq8Ekjyqcq/83wFabRXR2vk8uXJfbIaKclZ2HEAj2P90z78zU2Bsu1oibE/e69IkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759762452; c=relaxed/simple;
	bh=lKylPas55ITTVT/Acc/mCgXBUoM+tFkGFkBMhQ08gu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fxokgd2aSSwbJLHjFBF55jiNThoym5en7UKtSrtQ6i1znFBZiYZrGDRiEt1L3HC9UFCB0l+ba+JI/U9KOxADyv9BbbjoEHqLvy19IH3cPgofW0g/FnqK1KJQ/Tv2nnShtON99NLV6RpAwO5995ndPkUI3etbQU46Qc9x4RxNYJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RzgzRTjW; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759762451; x=1791298451;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lKylPas55ITTVT/Acc/mCgXBUoM+tFkGFkBMhQ08gu8=;
  b=RzgzRTjWAKdJjDDjy1UbLnSpX9oQJkWRPzrDmMJZ2N74GJLIp9DhbNHt
   KpQKc9CuDD1EgRwdcQxATgv8BloUZDTXn218h/h469EQK1QyeCteeFvqC
   wyk/mQu/KfM0JxpyKhboUNslRicvyQrenWci6tI4h4qnWcyVxEerhZubj
   i2AGm8yyM6iR/B+SfKq1m5RITPKQIuxFxDQC5TeLUVjdfRyUwcqR3PDYD
   mtrNuWBvvc6Nwl+AJMOX9Up7kaOlaAYdwzXC8b74CIhoWmAHsszPvlMs7
   BQIr/8s2aNq4M1p0GkiB9bLWKV2AhP6SLynOINP54G0QqhndKI+e+191Y
   w==;
X-CSE-ConnectionGUID: 5Cw5GUPzR1G08yX8t7ux3g==
X-CSE-MsgGUID: EAkvjkLbQ8aRstjDOwR1uA==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="61142908"
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; 
   d="scan'208";a="61142908"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 07:54:09 -0700
X-CSE-ConnectionGUID: ZnERCEnxRPm1rvbAGdEubg==
X-CSE-MsgGUID: 2YfLwbmgSsSTgc2+yvtz1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; 
   d="scan'208";a="179507237"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.110.110]) ([10.125.110.110])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 07:54:08 -0700
Message-ID: <8877e886-c7f4-42c0-8e1d-422a40d6e092@intel.com>
Date: Mon, 6 Oct 2025 07:54:07 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/hdm: allow zero sized committed decoders
To: Vishal Aslot <vaslot@nvidia.com>, Gregory Price <gourry@gourry.net>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Li Ming <ming.li@zohomail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Zijun Hu <zijun.hu@oss.qualcomm.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <SN7PR12MB81316C958DF0F4B10369B928BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <aN4SSEmaCaxbeiwJ@gourry-fedora-PF4VCD3F>
 <02a4b5f1-ad29-4825-9040-ff96e328f674@intel.com>
 <SN7PR12MB8131EE31375531673BCF0C62BBE4A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <43ca6827-2bcc-41d3-8a7b-3aec24f2b0e1@intel.com>
 <SN7PR12MB8131FC2DE9E9A521CE91339DBBE5A@SN7PR12MB8131.namprd12.prod.outlook.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <SN7PR12MB8131FC2DE9E9A521CE91339DBBE5A@SN7PR12MB8131.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/4/25 7:05 AM, Vishal Aslot wrote:
>> ________________________________________
>> From: Dave Jiang <dave.jiang@intel.com>
>> Sent: Friday, October 3, 2025 11:14 AM
>> To: Vishal Aslot; Gregory Price
>> Cc: Davidlohr Bueso; Jonathan Cameron; Alison Schofield; Vishal Verma; Ira Weiny; Dan Williams; Li Ming; Peter Zijlstra; Dan Carpenter; Zijun Hu; linux-cxl@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] cxl/hdm: allow zero sized committed decoders
>>
>> External email: Use caution opening links or attachments
>>
>>
>> On 10/2/25 6:03 PM, Vishal Aslot wrote:
>>>> ________________________________________
>>>> From: Dave Jiang <dave.jiang@intel.com>
>>>> Sent: Thursday, October 2, 2025 10:32 AM
>>>> To: Gregory Price; Vishal Aslot
>>>> Cc: Davidlohr Bueso; Jonathan Cameron; Alison Schofield; Vishal Verma; Ira Weiny; Dan Williams; Li Ming; Peter Zijlstra; Dan Carpenter; Zijun Hu; linux-cxl@vger.kernel.org; linux-kernel@vger.kernel.org
>>>> Subject: Re: [PATCH] cxl/hdm: allow zero sized committed decoders
>>>>
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On 10/1/25 10:48 PM, Gregory Price wrote:
>>>>> On Wed, Oct 01, 2025 at 08:37:26PM +0000, Vishal Aslot wrote:
>>>>>> @@ -1210,6 +1210,11 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>>>>>>                 rc = init_hdm_decoder(port, cxld, target_map, hdm, i,
>>>>>>                                       &dpa_base, info);
>>>>>>                 if (rc) {
>>>>>> +                       if (rc == -ENOSPC) {
>>>>>> +                               put_device(&cxld->dev);
>>>>>> +                               rc = 0;
>>>>>> +                               continue;
>>>>>> +                       }
>>>>>
>>>>> How do you suggest actually testing this? I briefly poked at this in
>>>>> QEMU trying to commit decoders, but i found myself incapable of
>>>>> exercising this path.
>>>
>>> I tested it locally with our BIOS (UEFI) where we commit and lock all decoders and
>>> all except decoder 0 are zero-sized.
>>>
>>>>
>>>> It may be worthwhile adding a cxl_test test case for this.
>>>
>>> Yeah, sure. Would cxl mock tests be the right place to explore this?
>>
>> Yes. Under tools/testing/cxl. Let me know if you need help with that.
>>
>> DJ
> 
> Hi Dave,
>     Would the test be a separate patch or part of this one? Thanks.

It would be a separate patch and you post a series with a cover letter. You can see examples in the lore archive [1] of submissions more than 1 patches.

[1]: https://lore.kernel.org/linux-cxl/

DJ

> -Vishal
> 
>>>
>>>>>
>>>>>>                         dev_warn(&port->dev,
>>>>>>                                  "Failed to initialize decoder%d.%d\n",
>>>>>>                                  port->id, i);
>>>>>> --
>>>>>> 2.34.1
>>>
> 


