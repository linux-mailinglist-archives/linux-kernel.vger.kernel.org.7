Return-Path: <linux-kernel+bounces-807998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEE0B4ABEB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B69521B2187C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6C33203A7;
	Tue,  9 Sep 2025 11:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DC1L2hov"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3637031CA4C;
	Tue,  9 Sep 2025 11:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417337; cv=none; b=bPZMMriRnEIw5PcQANDICwulgFvA6iUDyNxEMRQyvcu1+hiS2+qSNZS013vJUnuQTg1RNvUwPO3ldf0H7rR8+cuwanpsZMOUnHrFV0yZLRqVWGCWWpx8qRSeT6kG9qwyIdTF/BvjeCLfZVVmkCIKzR8grL6lfUpt5eWfFbwBYsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417337; c=relaxed/simple;
	bh=3qTkpRYPWhJIrFaIbetCRPgmK97ch9BSZ6ogh5fYb/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZh6vpxZ0xCXDY1nkPHqO4GOJJxc9C84N8sw7WdvZAzA1jGpxKDju3jyXJUJBl2FPCczDrdeJ9byRUpVOQ6a6AfdrNByXOMH9oFRtAbAqP9fHO4g3hXGwbFTHwqJsSqWjf99yhB9PWJwrA7NI+jn28aw2WEX+g8z704UkWhKrRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DC1L2hov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04505C4CEF4;
	Tue,  9 Sep 2025 11:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757417336;
	bh=3qTkpRYPWhJIrFaIbetCRPgmK97ch9BSZ6ogh5fYb/E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DC1L2hovSrIM4jHOwEoyNSiErADcDr3cBuZY5IwjbHWa+eFIpPWsq2G07AeK9w7Ig
	 RAj2hlIHA/4uC0CSlRgqbHZp7VpoM/58Ms1UBu/BM/wYjgGYatrcK/kA5T7EQIs7t8
	 B6S1iwZp8NR6YED+3gnKcNucAFdOx8olD/GcPMExs0qVA936ZXsRqky7uabkTAl1nN
	 FOhBb5CEMx95/LeLSog2Qzm70D6RBuLgepFF7zm4xtN487i9vo8m5Hc7L6C/M5c+az
	 KQRzFesv1XBg2lGLsmp7ufWyGXXXWgDp94D9uEE5Fapt9gEfWnJ8sp4Fuh3sfOldds
	 FJNKIbtPSAZrA==
Message-ID: <e5afeb60-96cc-4a9b-a360-2da03e4e236e@kernel.org>
Date: Tue, 9 Sep 2025 13:28:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/gpuvm: add deferred vm_bo cleanup
To: Alice Ryhl <aliceryhl@google.com>
Cc: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Matthew Brost <matthew.brost@intel.com>,
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
 <a2006f74-75bb-48ac-ac9c-0a71c8f9d510@linux.intel.com>
 <8078cad2-d5d3-4e20-9848-034c2a503f3d@kernel.org>
 <cbd5c99d2394335ac4aeb2740994ab14508e2553.camel@linux.intel.com>
 <CAH5fLghY8o0ouvaz48D4bsWMJ7A06L750xdKibaoe=bKjVOpzg@mail.gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <CAH5fLghY8o0ouvaz48D4bsWMJ7A06L750xdKibaoe=bKjVOpzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/9/25 1:24 PM, Alice Ryhl wrote:
> On Tue, Sep 9, 2025 at 1:11 PM Thomas Hellström
> <thomas.hellstrom@linux.intel.com> wrote:
>>
>> On Tue, 2025-09-09 at 12:47 +0200, Danilo Krummrich wrote:
>>> On 9/9/25 12:39 PM, Thomas Hellström wrote:
>>>> On 9/8/25 14:20, Danilo Krummrich wrote:
>>>>> On 9/8/25 2:11 PM, Boris Brezillon wrote:
>>>>>> On Mon, 08 Sep 2025 13:11:32 +0200
>>>>>> "Danilo Krummrich" <dakr@kernel.org> wrote:
>>>>>>> No, drivers can't iterate the evict/extobj lists directly; or
>>>>>>> at least this is
>>>>>>> not intended by GPUVM's API and if drivers do so, this is
>>>>>>> considered peeking
>>>>>>> into GPUVM internals, so drivers are on their own anyways.
>>>>>>>
>>>>>>> Iterators, such as for_each_vm_bo_in_list() are not exposed
>>>>>>> to drivers.
>>>>>> Okay, that's a good thing. I thought Xe was doing some funky
>>>>>> stuff with
>>>>>> the list...
>>>>> Maybe, I don't know. If they do so, the should send patches
>>>>> adding the
>>>>> corresponding iterators and provide a rationale why drivers need
>>>>> to access those
>>>>> lists directly and why we can't provide an API that handles the
>>>>> overall
>>>>> use-case, such as drm_gpuvm_prepare_objects(), etc.
>>>>
>>>> We're using the drm_gpuvm_*for_each* macros in drm_gpuvm.h,
>>>> assuming from name
>>>> and docs they are driver api.
>>>>
>>>> Also the drm_gem_for_each_gpuvm_bo(), although this usage could
>>>> easily be
>>>> converted to a helper.
>>>
>>> We were talking about the extobj/evict lists, the ones you mention
>>> are fine of
>>> course. :)
>>>
>>
>> Hmm. Now on closer inspection it looks like we're checking for evict
>> list empty, It looks like rebinding after validation may in theory
>> evict some bos to system memory and then we'd rerun the validation step
>> if the evict list was not empty.
>>
>> We could of course add a helper for that or if there are better
>> suggestions to handle that situation, that'd be fine as well.
> 
> I don't think evict list empty means that there are no evicted GEMs.
> It's possible for an extobj to be missing from the evict list in some
> scenarios. That's why drm_gpuvm_prepare_objects_locked() checks
> evicted on the extobj list to ensure that the evicted list is
> up-to-date when you call into drm_gpuvm_validate_locked().

Indeed, though I would expect that Xe considers that? It was Thomas who proposed
the logic you describe here back then IIRC. :)


