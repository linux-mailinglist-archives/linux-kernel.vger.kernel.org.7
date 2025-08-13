Return-Path: <linux-kernel+bounces-767474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1FBB254CB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8BC1C28735
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74042F9982;
	Wed, 13 Aug 2025 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dE7oQnO3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665B02EBBB8
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 20:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755118539; cv=none; b=pIXEBqH7nzwpoxXR0Yl09C4Vvyiy7JDOQe9dsOjYJw7mIPZf/352rW9UEIzIj20ckpDv1PyyDtnoUNKaoXnxdenCfiKSAr21Nl9UNO3f2YpUf5z7b+fzyf+WAvssNkipJB5am7b2qz0dMmWO8s+Y1EXru/XI3uoNmtUYcMcOXeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755118539; c=relaxed/simple;
	bh=0To9pwJkbgYS18+DHtZ4PEbk9/P2k7rFe9KwjTtTGwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FPUEcWshaEi4hZjWEChKbjqHQKbfAjAHxraTRlEk2m2pBRspVJdDSBKejSNc9WJpdKvMruVNMRIH80PNB5aCg0F0tMfbdkit7mxust3VPq7S+1fbEgpqdeZQQs18qeV5L0XCEZb1MWHd337IEy7VksigP2fKcUIsHPIuTyf3mxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dE7oQnO3; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755118538; x=1786654538;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0To9pwJkbgYS18+DHtZ4PEbk9/P2k7rFe9KwjTtTGwM=;
  b=dE7oQnO30bx77NEItZb/sU8UF2hiWL7JqHNK4v54QuhEOivnkJAV9tlm
   tLdBU7YzF/29zU/eI3ag3dU+i7KMtHSFvbVuAV+wpZdrgO4j8Kibz9N6W
   WdB+q3m5DvBnoJ3axlE77QjqxcD2h2/HcVvm6vFeT88oPxT15mp1oU87O
   nNBsdc1ppI9Wj1sfujO07cwG+XmtcvKyz5TOWU3oZvT4etLndTQl5otkp
   ZzuAXlAIM5hYRDN8Xmf9JkUyK7iwdMcBz3WrWJ6qzt8cgkjzx+0/XC2EC
   a3qs3Wb2LYeab3ESf9nOcM5GxcXpGwxzcKY6mtpIod5sgA9gxXRuhRLdG
   Q==;
X-CSE-ConnectionGUID: 1W5wkTMQRc6A90LRnPXMdA==
X-CSE-MsgGUID: NpYGD+7IRKmkeA9KtL3IAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="68508982"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="68508982"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 13:55:36 -0700
X-CSE-ConnectionGUID: BuNUGaZLTuWBbik0iOc2Nw==
X-CSE-MsgGUID: pOZS9eJCRUuOVpney9lA9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="165757924"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.111.131]) ([10.125.111.131])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 13:55:36 -0700
Message-ID: <04cb59cb-e9ed-489c-b36f-6c6209b2e93f@intel.com>
Date: Wed, 13 Aug 2025 13:55:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] x86/microcode/intel: Establish staging control
 logic
To: "Chang S. Bae" <chang.seok.bae@intel.com>, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, colinmitchell@google.com, chao.gao@intel.com,
 abusse@amazon.de, linux-kernel@vger.kernel.org
References: <20250409232713.4536-1-chang.seok.bae@intel.com>
 <20250813172649.15474-1-chang.seok.bae@intel.com>
 <20250813172649.15474-3-chang.seok.bae@intel.com>
 <06d43a86-204f-4658-9759-d24b7038b2d3@intel.com>
 <776e439c-60b6-474e-ac47-f33357c272de@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <776e439c-60b6-474e-ac47-f33357c272de@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/13/25 13:46, Chang S. Bae wrote:
>> Isn't 'cpu_none_mask' a mask containing no CPUs? How can that possible
>> work here:
>>
>>     for_each_cpu(cpu, cpu_primary_thread_mask) {
>>
>> ? Wouldn't it just not run through the for loop at all on CONFIG_SMP=n?
>> Is that what we want for some reason? I would have thought that we'd
>> still want to find the MMIO address for CPU 0, the one and only CPU.
> 
> Yeah, right.
> 
> Then, looking at it again, I see this:
> 
> config MICROCODE_LATE_LOADING
>     bool "Late microcode loading (DANGEROUS)"
>     default n
>     depends on MICROCODE && SMP
> 
> This optimization only applies to the late-loading path. But, today I
> also had to clarify this dependency for myself. At least, my changelog
> could've made it clearer, sorry.

I'm not following.

I _think_ you're trying to say that it's a "no harm, no foul" situation
because this user of 'cpu_primary_thread_mask' won't even get compiled
in the buggy !SMP case.

But that's not the problem. The issue is that this line of code:

#define cpu_primary_thread_mask cpu_none_mask

reads as 100% bogus to me. Even on !SMP kernels,
'cpu_primary_thread_mask' should have one CPU in it. Right? The _one_
thread that's present is a primary thread. If this were a mask for
secondary threads, 'cpu_none_mask' would make sense. But it's not.

So could we please make use 'cpu_primary_thread_mask' is getting defined
correctly whether it's really getting compiled into the end image or not?

