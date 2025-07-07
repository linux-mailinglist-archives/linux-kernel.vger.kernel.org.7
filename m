Return-Path: <linux-kernel+bounces-720335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E08D5AFBA6C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B24801AA7C5D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B36263F4E;
	Mon,  7 Jul 2025 18:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="llFSf5Iw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A6D1D9A54
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751911960; cv=none; b=LCGKYWs3iwrfcV1rFpwLTZZsG19o/Vk2Y9zX7icox8IGJ0lfv9zMlhFcDuyUtYNvdO5We7cefX32kZUUiXdWlA8x+7769EoYDWKQHUm+ArcTnJtnBlvfj6DdtTzTk6BCtmNdz+0oGFJz+z21SAXy5Q6P/ax/TLhVBlKJ5OsLZW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751911960; c=relaxed/simple;
	bh=NAu3UMC9sbvDuSmHn2BVkDXHwEMKSYLUedC4xfIZnI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NExBlOoavLoA87k9pndsboZ3BNhOudPqvJ/FS6JYIsuspN9uynOxAUMF6D6brTM/cKpjw5WqX5LUyG5OrNgsqNL9d1DMgbVqlZtq6cYSHimKIF44cQhoRri55PQJeM0fQQKCm9VRpf1w9mj7CFIhJoXoxsWHoiOkPsj6AooeYZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=llFSf5Iw; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751911959; x=1783447959;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NAu3UMC9sbvDuSmHn2BVkDXHwEMKSYLUedC4xfIZnI0=;
  b=llFSf5IwpLpPBvVLVTTgAdjeDSeCVvy+5jKXU5q+03RipKH2y3Ns8lmz
   GgX6GWjjgDSKcg5C+iLqjWP3F/ekUQBadKFqerZzfTJqiX45ii6QIbeYA
   zwy566f6vpitYpdi8+xkLPAhm7Y1r41KMvrdNvQhmNCB+o1DmO/yAEWcy
   /QwUFFVv2cAJosFaAkx2DnfKqRxsM6PpYrSfc3+LUZ3G8tc8Ww4ZYb1jN
   LsJ9jyiXzt4CB9uZ+LSxVoN1BpD1ARz5BlIfOatzJwA68LpQ14crPSbPJ
   ePe7CRKhFf//P0wMe0uwYHIsXhYsKllMOtx+bVeB4E4JrbYgObnuLQpd6
   w==;
X-CSE-ConnectionGUID: a4n8fPSaQk2rMHOnQgtlHg==
X-CSE-MsgGUID: UJi2s4e4Q8ClZA0QK3U5RA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="41764984"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="41764984"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 11:12:39 -0700
X-CSE-ConnectionGUID: eYMvh9/cT46orQQjcBE8Iw==
X-CSE-MsgGUID: fEhAus6tTcGneOmpxYgRpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="154899310"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 11:12:38 -0700
Received: from [10.124.128.64] (kliang2-mobl1.ccr.corp.intel.com [10.124.128.64])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 6D8F220B571C;
	Mon,  7 Jul 2025 11:12:34 -0700 (PDT)
Message-ID: <94d2de81-47e4-4ad1-ab92-cfacdab3cf68@linux.intel.com>
Date: Mon, 7 Jul 2025 11:12:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V2 06/13] perf: Support SIMD registers
To: Mark Brown <broonie@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
 irogers@google.com, adrian.hunter@intel.com, jolsa@kernel.org,
 alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
 dapeng1.mi@linux.intel.com, ak@linux.intel.com, zide.chen@intel.com,
 mark.rutland@arm.com, ravi.bangoria@amd.com
References: <20250626195610.405379-1-kan.liang@linux.intel.com>
 <20250626195610.405379-7-kan.liang@linux.intel.com>
 <69afb239-da54-452d-8ab4-2d80dbdf8dce@sirena.org.uk>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <69afb239-da54-452d-8ab4-2d80dbdf8dce@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-07-02 4:16 a.m., Mark Brown wrote:
> On Thu, Jun 26, 2025 at 12:56:03PM -0700, kan.liang@linux.intel.com wrote:
> 
>>  	 *	{ u64			abi; # enum perf_sample_regs_abi
>> -	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_USER
>> +	 *	  u64			regs[weight(mask)];
>> +	 *	  struct {
>> +	 *		u16 nr_vectors;
>> +	 *		u16 vector_qwords;
>> +	 *		u16 nr_pred;
>> +	 *		u16 pred_qwords;
>> +	 *		u64 data[nr_vectors * vector_qwords + nr_pred * pred_qwords];
>> +	 *	  } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
>> +	 *	} && PERF_SAMPLE_REGS_USER
> 
> I'm not super familiar with perf but I think this should work for arm64,
> it supplies the vector length through the _qwords and we can handle FFR
> being optional by varying the number of predicate registers.

That's great. Thanks for the confirmation.

Thanks,
Kan


