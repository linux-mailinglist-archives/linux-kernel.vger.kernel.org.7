Return-Path: <linux-kernel+bounces-890719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B99C40BFD
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 17:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D54DF3B4663
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 16:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1461DE8AE;
	Fri,  7 Nov 2025 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YV4JZBk7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0C7256C9E;
	Fri,  7 Nov 2025 16:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531523; cv=none; b=KnqeQZ0+Yb/rPGVKE2R6O3AOICVU3iKGV20IAdI0HAWkgHZVmTok0kLOXArYNM1ex7WYul6WGlBKZO2M73rLlEa7NeuZfe+PoT0iapz81GjYDOJwQpPMwz3G5N2+iweqofxhKdHNsk2jcUeSWSsLY5ieMNzqn0QpbIKlIkN0YjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531523; c=relaxed/simple;
	bh=topRWpDa2VOJ+GGH5NHqAfQH+TNox/Nr7BHY8HnDNRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mzhi1JvxmV5YinRQaK73Dp+K+wlPyl7Uh+2PZ5JHaBX/9jL2FClYVWfiedujUdgyHQzj0VUmHATqN4Y4d6qPaFeyqRWoBicyfMAYYtaIv0PbQ7Tyf2pMjfSoEiX2CTe9yrVQ8v4yV2I+KM4tdzT3ErvDayzqv5nwGAgKXCn6Hjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YV4JZBk7; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762531522; x=1794067522;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=topRWpDa2VOJ+GGH5NHqAfQH+TNox/Nr7BHY8HnDNRc=;
  b=YV4JZBk7x3w1D+oJAGM3Y6h2/VsPrqKB2CtCmEZPN7cVk3hkr3qjf8Je
   7BnsNO8x4wS2SlXFoxlAUEUk5odaA5+UAB4sOTqacQDLCqfhoHYpsCs29
   G5oCSmV1R7/8uaM7PCIfv4tmgFHIi8ROkHg08BPpVbe1SEjsF7PHNPc1t
   pbX8W8lPuSWO1/sKx5ghyK3nRMpyZz5q4mmIW4EGAo+36Nw6MPqg43Q9j
   A8pzx3SCyrdQAPcCYKe1YmCph9mueIwKvKMYNKZVbXFsW50GTawQUWVMX
   gcPVPuEMn8rhvTHkBq8M93Gsh0nlu5d+iWXK8KvuUY64hpdjTZMpTxvVp
   Q==;
X-CSE-ConnectionGUID: 2JPgyNxLTO6sVcJaqUR5tQ==
X-CSE-MsgGUID: WGXNiMWISEOMm+E1kmP97Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="68521396"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="68521396"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 08:05:20 -0800
X-CSE-ConnectionGUID: jMkmIaB2SLephsvXgwQZGQ==
X-CSE-MsgGUID: flmgstb2TOWHDJFjwOGYcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="192167392"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.61]) ([10.245.245.61])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 08:05:17 -0800
Message-ID: <c4a8bd46-0ee4-4bc3-a572-824cb8a7e524@linux.intel.com>
Date: Fri, 7 Nov 2025 18:05:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT PATCH v3] xhci: sideband: Fix race condition in sideband
 unregister
To: Uttkarsh Aggarwal <uttkarsh.aggarwal@oss.qualcomm.com>,
 Mathias Nyman <mathias.nyman@intel.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 wesley.cheng@oss.qualcomm.com
References: <2025102948-trickery-creative-417e@gregkh>
 <20251029122436.375009-1-mathias.nyman@linux.intel.com>
 <2025102956-daunting-roping-a987@gregkh>
 <094a2124-f6c9-4510-b7ec-8df872882a7d@intel.com>
 <22d15a74-f04f-413a-966f-9581739e4c5a@oss.qualcomm.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <22d15a74-f04f-413a-966f-9581739e4c5a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/7/25 08:16, Uttkarsh Aggarwal wrote:
> 
> 
> On 10/29/2025 7:22 PM, Mathias Nyman wrote:
>> On 10/29/25 14:51, Greg KH wrote:
>>> On Wed, Oct 29, 2025 at 02:24:35PM +0200, Mathias Nyman wrote:
>>>> Uttkarsh Aggarwal observed a kernel panic during sideband un-register
>>>> and found it was caused by a race condition between sideband unregister,
>>>> and creating sideband interrupters.
>>>> The issue occurrs when thread T1 runs uaudio_disconnect() and released
>>>> sb->xhci via sideband_unregister, while thread T2 simultaneously accessed
>>>> the now-NULL sb->xhci in xhci_sideband_create_interrupter() resulting in
>>>> a crash.
>>>>
>>>> Ensure new endpoints or interrupter can't be added to a sidenband after
>>>> xhci_sideband_unregister() cleared the existing ones, and unlocked the
>>>> sideband mutex.
>>>> Reorganize code so that mutex is only taken and released once in
>>>> xhci_sideband_unregister(), and clear sb->vdev while mutex is taken.
>>>>
>>>> Use mutex guards to reduce human unlock errors in code
>>>>
>>>> Refuse to add endpoints or interrupter if sb->vdev is not set.
>>>> sb->vdev is set when sideband is created and registered.
>>>>
>>>> Reported-by: Uttkarsh Aggarwal <uttkarsh.aggarwal@oss.qualcomm.com>
>>>> Closes: https://lore.kernel.org/linux-usb/20251028080043.27760-1- uttkarsh.aggarwal@oss.qualcomm.com
>>>> Fixes: de66754e9f80 ("xhci: sideband: add initial api to register a secondary interrupter entity")
>>>> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>>>> ---
>>>
>>> Looks good, thanks for respinning this.  I don't know if it fixes the
>>> issue, but it looks sane :)
>>>
>>> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>
>> Thanks for reviewing this.
>>
>> I don't have the hardware to test this myself either
>>
>> Thanks
>> Mathias
> 
> Hi Mathias,
> 
> I have shared the patch with our OEMs and so far, have not received any reports of issues from them.
> 
> Thanks
> Uttkarsh
> 

Thanks, I'll send it forward

-Mathias


