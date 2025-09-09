Return-Path: <linux-kernel+bounces-807897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41627B4AAD8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 140EE7A5269
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05269275847;
	Tue,  9 Sep 2025 10:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WWzWQmjS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99FF3191B4;
	Tue,  9 Sep 2025 10:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757414406; cv=none; b=HQM1LJaFJpTZP+t8GyhwS3FFbtmAy54QwMmZdkh72PaKOGeKkz5Ice9tqC7lR6Zra6zH7JSxju3ACLXxGf1kcsfpqLQ7m6KQAKtBZoIL4jjyfePpViYNT3GiuqruJwS0jSuisthMEjism44YuhYIVc6pqDsZ0RUl0oExUvyvt68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757414406; c=relaxed/simple;
	bh=QFFhbMDKwNRaHn+F2bynsGPDcC6TVygzOweEmuYMtco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PQTyj7Pa1J0OruO255Gv1w9V0P+kmB85aEPsoevVRtwePwsQed3Mh/Xr4qSMeshEcAcefjiZz2nrmcdmBzcd92/ta9rllUz2PfqiF5kYBY564MJm6TD5Sork6zrZtpHf0qcBxhWzou/RLuE1Q0++sEIhPMvGEBlQs9+dmITi+pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WWzWQmjS; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757414405; x=1788950405;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QFFhbMDKwNRaHn+F2bynsGPDcC6TVygzOweEmuYMtco=;
  b=WWzWQmjS5fZOflt6X7DMUPF5Ln09fSnecnZDfCYJzGBkExWtUQAldHMG
   ACqMB6pJHNXMzrY0DTdtdvipsiLr2u7Yibeez3RnXKXKtap3Yfc8IIyOS
   GMyPMPWNSIgbezMXuBvLXGLjaGlEg+CATNZHxqgd92yO9hIqBF7pk6rTl
   fB3qwKOWlIxq6uqlYIrqwne2WxYoF8OtFqaEHebEyyRfCq7CtdQV7caXX
   2qWNkUxECSos/PCa7UoS1RXt28fnAWfJghypR3/MkyXbwRyAsD2wB02pn
   4Til8TuVLP6A480V97yMLRTWUMXQCXgBW6s6x89iZReznjeEimn1RtFuJ
   g==;
X-CSE-ConnectionGUID: ffpNP+yjSFGpyFSp+Eop4w==
X-CSE-MsgGUID: fQT7iyCrQpqSZpBo3Xz5fA==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="59387813"
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="59387813"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 03:40:05 -0700
X-CSE-ConnectionGUID: nyAPWHYpQuakfqWlFa5bYQ==
X-CSE-MsgGUID: llkZRbCmTCKxOdwPI3QTjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="172927459"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO [10.245.244.108]) ([10.245.244.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 03:39:59 -0700
Message-ID: <a2006f74-75bb-48ac-ac9c-0a71c8f9d510@linux.intel.com>
Date: Tue, 9 Sep 2025 12:39:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/gpuvm: add deferred vm_bo cleanup
To: Danilo Krummrich <dakr@kernel.org>,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Matthew Brost
 <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Steven Price <steven.price@arm.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20250905-vmbo-defer-v1-0-7ae1a382b674@google.com>
 <20250905-vmbo-defer-v1-1-7ae1a382b674@google.com>
 <20250905152505.005a610d@fedora>
 <CAH5fLghgqv0mNYf8r-rdeBaCGxYsdkBouqgo_ohx3DYHwpcZRQ@mail.gmail.com>
 <DCL8DQV23FIZ.KJ74UQ9YOFZV@kernel.org> <aL1pSFB9iBsfHFM_@google.com>
 <DCMJ6K06T63T.2UBTM1RL4YJ0A@kernel.org> <aL1u_YxOkuj1kIq6@google.com>
 <20250908091140.44856fde@fedora> <aL6TJYRmWIkQXujj@google.com>
 <DCNAE3CJMEJ0.JH1F0MJABXQI@kernel.org> <20250908122002.2c80dd3a@fedora>
 <DCNDGFE7RR5Q.X3PCDW0KIX89@kernel.org> <20250908141156.3dbdea0b@fedora>
 <7aa3f464-a3d0-47a0-b044-d8db93f45918@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
In-Reply-To: <7aa3f464-a3d0-47a0-b044-d8db93f45918@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 9/8/25 14:20, Danilo Krummrich wrote:
> On 9/8/25 2:11 PM, Boris Brezillon wrote:
>> On Mon, 08 Sep 2025 13:11:32 +0200
>> "Danilo Krummrich" <dakr@kernel.org> wrote:
>>> I'm saying exactly what you say: "has to be a special unlink function" ->
>>> drm_gpuva_unlink_defer_put(). :)
>> I don't see how calling drm_gpuva_unlink() instead of
>> drm_gpuva_unlink_defer_put() would leak the vm_bo though.
> Initially (i.e. a few mails back), it sounded to me as if you'd propose to drop
> the drm_gpuva's vm_bo reference only when it is freed.
>
>>> No, drivers can't iterate the evict/extobj lists directly; or at least this is
>>> not intended by GPUVM's API and if drivers do so, this is considered peeking
>>> into GPUVM internals, so drivers are on their own anyways.
>>>
>>> Iterators, such as for_each_vm_bo_in_list() are not exposed to drivers.
>> Okay, that's a good thing. I thought Xe was doing some funky stuff with
>> the list...
> Maybe, I don't know. If they do so, the should send patches adding the
> corresponding iterators and provide a rationale why drivers need to access those
> lists directly and why we can't provide an API that handles the overall
> use-case, such as drm_gpuvm_prepare_objects(), etc.

We're using the drm_gpuvm_*for_each* macros in drm_gpuvm.h, assuming 
from name and docs they are driver api.

Also the drm_gem_for_each_gpuvm_bo(), although this usage could easily 
be converted to a helper.

So I don't think we're abusing internals ATM. If so we should ofc fix that.

IMO if some iteration macros or members that are exposed in the 
driver-facing headers need to be private (where it's not totally 
obvious) they should be marked as such or moved to private headers.

Thanks,

Thomas




