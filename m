Return-Path: <linux-kernel+bounces-807901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BD2B4AAE5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EEA07A7FBF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092C331B82F;
	Tue,  9 Sep 2025 10:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyym0s+Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F9F23FC4C;
	Tue,  9 Sep 2025 10:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757414875; cv=none; b=QTUuRTSXWw8x0FfORuJoqzacDESt4ALQSR76NJSXS6niJhlA/THkwyFlXQGc5UfEhJPITp/Hf37RuQ7G6aUaywty83c+vg06l2U2oGvSDPQvoKsvEK+Yy8KMItwTZIx1JFv6/P6yLdN8RjUmpQnnVZVPrV0cLgWdI/WUivjX66k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757414875; c=relaxed/simple;
	bh=bmhTPFMKRiQCz4gQV8Fjuf7q7QGKh0xTa7e+3ea1Fy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r2xESKy7GCVrqt+6xx9VRHOWUYCnuZJMVqOq2EpJ3JYUkOw+yqboK4nIAw2icyWzokNC4Mx6RUKem+27PzVQ9BTNm1XiRabCvF/QU0G4fmNc3YTwOZYS4TpOq09Ivi2GJ2rkx9wJMTpqGA11SofgW+wUrrO/YWb114rwky0rS5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyym0s+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D3FC4CEF5;
	Tue,  9 Sep 2025 10:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757414875;
	bh=bmhTPFMKRiQCz4gQV8Fjuf7q7QGKh0xTa7e+3ea1Fy0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qyym0s+Z7gvlQR9Q+U7sH2VTi4H7dP2O2a6fbFiY4tvzDh83T/fRHHjI5nkNrplWX
	 oMrW233YvxUetjpxjRDCkCjMBqgRVbKrxzBqgZ30CcST+ffef2PYZwY7DE30qqNPPz
	 F2RkltCOqiIgLrH92kJolxl6xKVCgSndaWan+lBREoAhEIfzWDJ/Mpz9CobOJa49RP
	 roMDG333OUTA1Rov2FkuiFicQ2J8Z8m5cJ9UyMwsauAPQoxGbwjUnQYZaO8HEDO9rH
	 XqFL8OpJLRmjxfnhGuxsVTexR56u2SuZOQNhl+H5DWbqzW2f06IUPEq0dbkusP6f/v
	 g+17sZx4zBCzw==
Message-ID: <8078cad2-d5d3-4e20-9848-034c2a503f3d@kernel.org>
Date: Tue, 9 Sep 2025 12:47:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/gpuvm: add deferred vm_bo cleanup
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, Matthew Brost <matthew.brost@intel.com>,
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
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <a2006f74-75bb-48ac-ac9c-0a71c8f9d510@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/9/25 12:39 PM, Thomas Hellström wrote:
> On 9/8/25 14:20, Danilo Krummrich wrote:
>> On 9/8/25 2:11 PM, Boris Brezillon wrote:
>>> On Mon, 08 Sep 2025 13:11:32 +0200
>>> "Danilo Krummrich" <dakr@kernel.org> wrote:
>>>> I'm saying exactly what you say: "has to be a special unlink function" ->
>>>> drm_gpuva_unlink_defer_put(). :)
>>> I don't see how calling drm_gpuva_unlink() instead of
>>> drm_gpuva_unlink_defer_put() would leak the vm_bo though.
>> Initially (i.e. a few mails back), it sounded to me as if you'd propose to drop
>> the drm_gpuva's vm_bo reference only when it is freed.
>>
>>>> No, drivers can't iterate the evict/extobj lists directly; or at least this is
>>>> not intended by GPUVM's API and if drivers do so, this is considered peeking
>>>> into GPUVM internals, so drivers are on their own anyways.
>>>>
>>>> Iterators, such as for_each_vm_bo_in_list() are not exposed to drivers.
>>> Okay, that's a good thing. I thought Xe was doing some funky stuff with
>>> the list...
>> Maybe, I don't know. If they do so, the should send patches adding the
>> corresponding iterators and provide a rationale why drivers need to access those
>> lists directly and why we can't provide an API that handles the overall
>> use-case, such as drm_gpuvm_prepare_objects(), etc.
> 
> We're using the drm_gpuvm_*for_each* macros in drm_gpuvm.h, assuming from name
> and docs they are driver api.
> 
> Also the drm_gem_for_each_gpuvm_bo(), although this usage could easily be
> converted to a helper.

We were talking about the extobj/evict lists, the ones you mention are fine of
course. :)


