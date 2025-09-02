Return-Path: <linux-kernel+bounces-796104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24267B3FBF7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0285217992E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF36D2EE285;
	Tue,  2 Sep 2025 10:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eF2nay1p"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC19026E173;
	Tue,  2 Sep 2025 10:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756807998; cv=none; b=lO9VJK10F1urbzdYPPRDNVaIMUppNoeAov8P1Mp51bXm3bGdw6V/2GBP3z8J5xNGKYgl0Qoprz8lvhqr7rh87bv7fALgnpW4QOMrCbdRo70aupOis9gpYwmnUlYJo3snYcQMTV/7ayBJrvGJlQl3HAsPJGkuyjTmx9vpQPfISy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756807998; c=relaxed/simple;
	bh=/8llQIdNMkqIPygj9KDjXPYnYcL7e734n9r/vQ45k7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qMiMqgcN9x74aiVu66tG6BiyNyto74/vJ8P8FKNxhKwXKV5UcOd6avdAnqBHKzO2qUPuAy03GSn7bHovrbFQ9O7eJpSw1Z3BJN9yYbb+4jeufRqaNWwTG05ngSL9RD181ywlR5NgfqoIN2dk4Tvc0FcoWC6xOA5+2SQQ/pnYAAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eF2nay1p; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756807997; x=1788343997;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/8llQIdNMkqIPygj9KDjXPYnYcL7e734n9r/vQ45k7I=;
  b=eF2nay1pPp3VlxgW8FKqfABTlAuOv+FjVGNzSqQI3LbKutPkV5TVLgMA
   By7BphMuMSQhBWI2TndOc90e33Gq+VhCLgwUKlEDHMceB3u0lSBFbtyqL
   vG5nfs8VAbxHyNvJhx8wEhMe6Nb+QUKlhwg/qnOs6HCiKHZ4BTCiadO6U
   Ie2fv4wkbA9YjFZVXv5NAPBrqqHOkaHYnMCL5WCRm8Ga5cqCFkPVnlb3J
   iB9vMA5CuisqaiM6GJe4taHGvqpNc9vfUh+DUk/HosV1sj29FUpFhacpN
   1B5eAtyjFMZbvUTCPZvqama7KmBM6mmNQ7eDs3jR7KTjR5TP2V5NVsfhD
   g==;
X-CSE-ConnectionGUID: SB5co0VmRYi+PPgs2gGhrA==
X-CSE-MsgGUID: 6fxyflyFQmWS+JP0wB8yPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="62718427"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="62718427"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 03:13:16 -0700
X-CSE-ConnectionGUID: nUbt2PhnQKeweUVMh7BtIw==
X-CSE-MsgGUID: 5S6D+71WQe2L+tJ/WT/Pig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="176553990"
Received: from johunt-mobl9.ger.corp.intel.com (HELO [10.245.245.90]) ([10.245.245.90])
  by orviesa005.jf.intel.com with ESMTP; 02 Sep 2025 03:13:13 -0700
Message-ID: <6042295b-8dad-4816-8505-b9b6c6f6049d@linux.intel.com>
Date: Tue, 2 Sep 2025 13:13:12 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: xhci: Fix xhci_free_virt_devices_depth_first()
To: =?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>,
 David Wang <00107082@163.com>
Cc: WeitaoWang-oc@zhaoxin.com, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org, surenb@google.com, kent.overstreet@linux.dev
References: <20250829181354.4450-1-00107082@163.com>
 <20250830114828.3dd8ed56.michal.pecio@gmail.com>
 <5051e27a.2ba3.198fa7b5f31.Coremail.00107082@163.com>
 <f9476552-a6dc-4f1c-91da-b15c8f0d9844@linux.intel.com>
 <20250902093017.13d6c666.michal.pecio@gmail.com>
 <446082a4.7dbe.199098cd654.Coremail.00107082@163.com>
 <20250902104630.6a9f088a.michal.pecio@gmail.com>
 <20250902110730.723a48a0.michal.pecio@gmail.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20250902110730.723a48a0.michal.pecio@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2.9.2025 12.07, Michał Pecio wrote:
> On Tue, 2 Sep 2025 10:46:30 +0200, Michał Pecio wrote:
>> On Tue, 2 Sep 2025 16:30:48 +0800 (CST), David Wang wrote:
>>> About the change from "<" to "<=", I did not observe any difference on my system. Is it because my system does not use up all slots?
>>
>> This too, you would need to fiddle with devices (or connect enough
>> of them) to reach Slot ID 255 (probably the highest on most systems),
>> depending on the xHCI controller and its ID allocation policy.
> 
> This made me wonder what those policies are. I'm too lazy for thorough
> testing, but I plugged and unplugged the same device a few times.
> 
> Most HCs kept assigning ID 1, so they likely always pick the lowest.
> 
> My AMD chipset, two ASMedia USB 3.1 controllers and a Fresco FL1100
> kept assigning sequentially increasing IDs, so I suppose I could pump
> it up near the top, connect two high speed hubs and trigger this bug.
> 
>> But also as explained, this bug doesn't make things go boom just yet.
>>
>> Except if combined with your bug in an obscure edge case:
>>
>> 1. A high speed hub has slot ID HCS_MAX_SLOTS-1 and some TT children.
>> 2. Another high speed hub has slot ID HCS_MAX_SLOTS.
>> 3. We start with freeing the second hub.
>> 4. The loop is entered and leaves vdev pointing at the first hub.
>> 5. The first hub is freed instead of the second one.
>> 6. Then its children are freed and UAF its tt_info.

I'm not sure I follow the above.

I agree that changing the "<" to "<=" makes sense, but fortunately for us there shouldn't be any
issue with current implementation as xhci_free_virt_devices_depth_first() is called with highest possible
slot_id value first:

in xhci-memm.c:
  for (i = HCS_MAX_SLOTS(xhci->hcs_params1); i > 0; i--)
                 xhci_free_virt_devices_depth_first(xhci, i);

if HCS_MAX_SLOTS slot_id is a hs-hub then all its children have slot_id < HCS_MAX_SLOTS,
and loop works fine.

If HCS_MXA_SLOT slot_id is a leaf node then it is freed first.

Thanks
Mathias

