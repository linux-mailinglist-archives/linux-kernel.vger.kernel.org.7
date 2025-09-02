Return-Path: <linux-kernel+bounces-796515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FC5B401D3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683AB1881DA2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555FC2D9ED8;
	Tue,  2 Sep 2025 12:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RH2p/s+9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2E628489B;
	Tue,  2 Sep 2025 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817926; cv=none; b=ThtvqwJsQvTaZXR9oFNFbuHRhYEYe+MiPwcFC3YHBNPRl7xhCEZIg6CoZKKQW0RhP1ykZcbKkcwEsAQnsP57odNAQaukyvMIZAHvyAmLNjk8Q3JmL0wN02uDGs2C+KgRGXdIcfqG7APOy5wVZvdGglx6j/nvsNOLFZlmJ1E8jzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817926; c=relaxed/simple;
	bh=JbvKZYq/T9c+ex/qOUiFNhbDFAJ4YblHQurbSxyz1VA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NmAdTwZZ8RlDwEGzu3hmJyF5CjAy22eRBQjAV6qXkzj+nYIdjdPy6Whc8snPJxf2A6EihQIqRyA2ZHfDbq7waLgOL4b8B/bG/Vww3Gsjh4H6rRpn05A6v5CTBlH/XSryblJQIMUNvRRSP61SJxOURoEomKwtPFJAole9bDzVn8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RH2p/s+9; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756817925; x=1788353925;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JbvKZYq/T9c+ex/qOUiFNhbDFAJ4YblHQurbSxyz1VA=;
  b=RH2p/s+9c0GVNoogMwXquql4CuddXQaPCsmUNSq9AMj+9//KpeITJot4
   it5wc0xUzfqXM2Ewep7JiHeTbVLZD9zVRc+T9j0lnB5Q265Hz76bks+FF
   uaV2I+WssBLiwRFRyj68ar1yBtvymlPbrm9iZRTZD8G6Z1hNaN0dTpHHz
   /LWotSvCEApsDGZR6wVqmPXmpRg8uiLka73JJgeaqYdpww1rcUUr9wYYC
   SgLKzgn53VxeaoptaZ1EFpCI+4Rk7UaVxc/nzk1u8KKfemBv8zaZWqHQB
   1MkEhpYQVMNNcjLrva6oLCds8rB8iwT/2nK/FWw8RWZiEINYV4D1dLvHj
   A==;
X-CSE-ConnectionGUID: mbODwKUiRBGL+50WKrkb4w==
X-CSE-MsgGUID: +bmSos0LT0O15j0XsDXADQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="58295409"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="58295409"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 05:58:44 -0700
X-CSE-ConnectionGUID: m2TTrK6USFGW+SuBwk1Wmg==
X-CSE-MsgGUID: 1cdbdKubTfm/vYWEHWTpkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="171713789"
Received: from johunt-mobl9.ger.corp.intel.com (HELO [10.245.245.90]) ([10.245.245.90])
  by fmviesa009.fm.intel.com with ESMTP; 02 Sep 2025 05:58:42 -0700
Message-ID: <20baae05-167f-42bc-aa08-33df1aaa095a@linux.intel.com>
Date: Tue, 2 Sep 2025 15:58:40 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: xhci: Fix xhci_free_virt_devices_depth_first()
To: =?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>
Cc: David Wang <00107082@163.com>, WeitaoWang-oc@zhaoxin.com,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 surenb@google.com, kent.overstreet@linux.dev
References: <20250829181354.4450-1-00107082@163.com>
 <20250830114828.3dd8ed56.michal.pecio@gmail.com>
 <5051e27a.2ba3.198fa7b5f31.Coremail.00107082@163.com>
 <f9476552-a6dc-4f1c-91da-b15c8f0d9844@linux.intel.com>
 <20250902093017.13d6c666.michal.pecio@gmail.com>
 <446082a4.7dbe.199098cd654.Coremail.00107082@163.com>
 <20250902104630.6a9f088a.michal.pecio@gmail.com>
 <20250902110730.723a48a0.michal.pecio@gmail.com>
 <6042295b-8dad-4816-8505-b9b6c6f6049d@linux.intel.com>
 <20250902125549.03f22bcf.michal.pecio@gmail.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20250902125549.03f22bcf.michal.pecio@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2.9.2025 13.55, Michał Pecio wrote:
> On Tue, 2 Sep 2025 13:13:12 +0300, Mathias Nyman wrote:
>> On 2.9.2025 12.07, Michał Pecio wrote:
>>> On Tue, 2 Sep 2025 10:46:30 +0200, Michał Pecio wrote:
>>>> On Tue, 2 Sep 2025 16:30:48 +0800 (CST), David Wang wrote:
>>>>> About the change from "<" to "<=", I did not observe any difference on my system. Is it because my system does not use up all slots?
>>>>
>>>> This too, you would need to fiddle with devices (or connect enough
>>>> of them) to reach Slot ID 255 (probably the highest on most systems),
>>>> depending on the xHCI controller and its ID allocation policy.
>>>
>>> This made me wonder what those policies are. I'm too lazy for thorough
>>> testing, but I plugged and unplugged the same device a few times.
>>>
>>> Most HCs kept assigning ID 1, so they likely always pick the lowest.
>>>
>>> My AMD chipset, two ASMedia USB 3.1 controllers and a Fresco FL1100
>>> kept assigning sequentially increasing IDs, so I suppose I could pump
>>> it up near the top, connect two high speed hubs and trigger this bug.
>>>    
>>>> But also as explained, this bug doesn't make things go boom just yet.
>>>>
>>>> Except if combined with your bug in an obscure edge case:
>>>>
>>>> 1. A high speed hub has slot ID HCS_MAX_SLOTS-1 and some TT children.
>>>> 2. Another high speed hub has slot ID HCS_MAX_SLOTS.
>>>> 3. We start with freeing the second hub.
>>>> 4. The loop is entered and leaves vdev pointing at the first hub.
>>>> 5. The first hub is freed instead of the second one.
>>>> 6. Then its children are freed and UAF its tt_info.
>>
>> I'm not sure I follow the above.
>>
>> I agree that changing the "<" to "<=" makes sense, but fortunately for us there shouldn't be any
>> issue with current implementation as xhci_free_virt_devices_depth_first() is called with highest possible
>> slot_id value first:
>>
>> in xhci-memm.c:
>>    for (i = HCS_MAX_SLOTS(xhci->hcs_params1); i > 0; i--)
>>                   xhci_free_virt_devices_depth_first(xhci, i);
>>
>> if HCS_MAX_SLOTS slot_id is a hs-hub then all its children have slot_id < HCS_MAX_SLOTS,
>> and loop works fine.
> 
> The loop works fine, but it exists with vdev pointing at MAX_SLOTS-1
> due to off by one and then this happens:
> 
> 	xhci_free_virt_device(xhci, vdev, slot_id);
> 
> which means:
> 
> 	xhci_free_virt_device(xhci, xhci->devs[MAX_SLOTS-1], MAX_SLOTS);
> 
> If MAX_SLOTS-1 is a high speed hub, it will be freed right now, without
> freeing its children first.
> 
> And whatever this device is, it will be freed without nulling
> xhci->devs[MAX_SLOTS-1], which might cause other UAF later (not sure).
> 
> I think it's possible, though I haven't tried actually triggering it.
> The problem didn't exist before this recent patch.
> 

I see, yes with the slot_id regression the incorrect vdev will cause issues.

Sent the patch to fix it forward

Thanks
Mathias

