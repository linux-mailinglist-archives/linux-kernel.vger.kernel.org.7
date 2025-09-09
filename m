Return-Path: <linux-kernel+bounces-808904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD79B5064F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05DF816A749
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D832343217;
	Tue,  9 Sep 2025 19:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PiIGAT9C"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA04C1A83F8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 19:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757445661; cv=none; b=Q62dlFU+UefMknnUrZwZerFgJSW+BTfo+TpErNPlckavyJQXBYHYb6UZBn5TN8KAe1n9EQ3yCjSO1Ij9wZMFVR/VE7SNwD4biVcqrIriWndE2JwO4Ndta0aHJ+rt0EuHooiWGSQoBRyQ9NwQiG+VmKmyZvl0DarBFwMDstF5QEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757445661; c=relaxed/simple;
	bh=hcjqtg/1buYqemHe8vyu9yPhcW7/0Rq1/Z5Z5WmXe8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b+v0fRhvCFmf5EyFNbeIfMEYzhQnkK++c62hiPvKiR1JJM69WkWCBWH335E7Dr5/cvYRwRkX2hOPcxoPKGJDALb0+V9f8JXp8sp2JjIRbNBkvQdYB1vmXiQG06wtGy7rqZtutMjEpIGSlGpsxnoYjrCpcRk/iq3X3boWo291iVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PiIGAT9C; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757445659; x=1788981659;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hcjqtg/1buYqemHe8vyu9yPhcW7/0Rq1/Z5Z5WmXe8A=;
  b=PiIGAT9CJV4IRbeVrG4j+ClMjCt4UdgIj5Po2MvQ7f1Z84iRChhk8o01
   w9exliZtLs9vXhRT5arBN/w7hqkcmvGYr68N5ThHJbD+UCuOb4gk1kOM0
   haZV7H1ESIf1q0FiyIfilIssNNA22YLIiPUzAw6dxG+yinzDfHhBiKt/N
   K2uv4L11i7VbLxJt2ceImyZd5W+0e7L2SJ6qiyumRxNXfNVvv7f3q4DGP
   9Le2ohR6akGzNgoEtskPQdDLW7/Q1DejLbce56nJOJuqLmg6zKv+z1ZjH
   q6vM0/19F4iIHIgAHXv7Aua4RXiir1DGdIKUZgsm7Uj/XpG7hZ2CsFiAr
   w==;
X-CSE-ConnectionGUID: dudiCSwzSNC1yTVTMEuQ+Q==
X-CSE-MsgGUID: Zzkyo8scS1WhMpoDNjDsWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="70358341"
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="scan'208";a="70358341"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 12:20:57 -0700
X-CSE-ConnectionGUID: CJff4aiHSuGiEcUS/1DR3Q==
X-CSE-MsgGUID: U/RToG1uTFeCKPDxk7m0/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="scan'208";a="196847577"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO [10.245.244.108]) ([10.245.244.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 12:20:55 -0700
Message-ID: <823c4b68-64ab-4e0f-bb6b-e8d52586e7f1@linux.intel.com>
Date: Tue, 9 Sep 2025 21:20:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] mm/mmu_notifier: Allow two-pass struct
 mmu_interval_notifiers
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: intel-xe@lists.freedesktop.org, Andrew Morton
 <akpm@linux-foundation.org>, Simona Vetter <simona.vetter@ffwll.ch>,
 Dave Airlie <airlied@gmail.com>, Alistair Popple <apopple@nvidia.com>,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20250821114626.89818-1-thomas.hellstrom@linux.intel.com>
 <20250821114626.89818-2-thomas.hellstrom@linux.intel.com>
 <20250909171831.GC882933@ziepe.ca>
Content-Language: en-US
From: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
In-Reply-To: <20250909171831.GC882933@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, Jason

On 9/9/25 19:18, Jason Gunthorpe wrote:
> On Thu, Aug 21, 2025 at 01:46:21PM +0200, Thomas Hellström wrote:
>> +struct mmu_interval_notifier_finish {
>> +	struct list_head link;
>> +	/**
>> +	 * @finish: Driver callback for the finish pass.
>> +	 * @final: Pointer to the mmu_interval_notifier_finish structure.
>> +	 * @range: The mmu_notifier_range.
>> +	 * @cur_seq: The current sequence set by the first pass.
>> +	 *
>> +	 * Note that there is no error reporting for additional passes.
>> +	 */
>> +	void (*finish)(struct mmu_interval_notifier_finish *final,
>> +		       const struct mmu_notifier_range *range,
>> +		       unsigned long cur_seq);
> I would rather this be in mmu_interval_notifier_ops

Thanks for reviewing.

We could have the struct mmu_interval_notifier_finish have a pointer to 
mmu_interval_notifier_ops or even to
mmu_interval_notifier. Now that you mention it IIRC Linus has pointed 
out that he strongly prefer function pointers in const ops wherever 
possible. Would like to keep the linked list, though, as we've discussed 
before, for passing of state and to avoid a second interval tree traversal.

Thanks,

Thomas



>   though I guess I
> see why it was done like this, I don't think it is a great idea for
> DRM to wrapper the notifier library with yet another library :\
>
> Regardless
>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>
> Jason

