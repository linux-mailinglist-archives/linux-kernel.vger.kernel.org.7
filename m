Return-Path: <linux-kernel+bounces-781742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DB9B31623
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0088318950E9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091C7278E67;
	Fri, 22 Aug 2025 11:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkX7xk7e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC5D2DCF47;
	Fri, 22 Aug 2025 11:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755860999; cv=none; b=K6sGuYJ+s/CG4DtmWnMh1QYYnyMGUOw8lSiYVgHx1KzH5NNh8ryGN8R5NipuchpV4+IOr10VluelkgLo2mLBw4M6TokdpneptnfqEzxI81D7qsAiyF6V6RHBbiJfilWapGcLyW2qYBz1+jFUrLFDK95z0R0Nnde+Q8RaRGT9M7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755860999; c=relaxed/simple;
	bh=QENZNcSjzZ+T1rw0YhDJJ50P5QH7ed0Ga7GIZxfb05U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G7MaNIulB9VKY5FMFH+aD/nPaTKWM4a4n1WItkYy9J722KGQQEPd8hCANdPbi2HQJunZuVQPFb7pVsu0nEtdadTpYpCvX+hz19Lz5EgS9OSLUboJsVsRRt79CZn5EeX0+1VM+YeFdylSXieEfx6mpOS9qdrjFJNEJzAO2165Emo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkX7xk7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E834C4CEED;
	Fri, 22 Aug 2025 11:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755860998;
	bh=QENZNcSjzZ+T1rw0YhDJJ50P5QH7ed0Ga7GIZxfb05U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CkX7xk7ezO+kEpGqYB9FGizrlz8gIOW/h9VQNxiJZ2gnvymRfhsaKDbDQvWL4stQc
	 JxQPqIaSTpGercxM6ZRWNYMK8VpB3PMHlBPu0WP3I3Ct2BuI0O2gA5TVg0bLUd/lbm
	 vC+cnOrGk/LM/XqD6oKfCOXjE2JXzOoOugEODlj7GSngCRYVOPKVprDa9oO8VRM/da
	 L5E8yPvDYfcRPNT11+siIcayf+C3aphFDv8CqIwPYN+VpqreZ72Vp02lQ8UmCcvDlp
	 kDFje00nq6DJwiClEOAnmS573SrrXf3IBuBhfsVSt7zhDE3h8wh2NfvSpRJp69Y9AJ
	 rYx3gLDE7Uj7g==
Message-ID: <0a548dc5-72c0-4f73-be0d-808606707924@kernel.org>
Date: Fri, 22 Aug 2025 13:09:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drm_gem: add mutex to drm_gem_object.gpuva
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Rob Herring <robh@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20250822-gpuva-mutex-in-gem-v2-0-c41a10d1d3b9@google.com>
 <20250822-gpuva-mutex-in-gem-v2-1-c41a10d1d3b9@google.com>
 <20250822115221.24fffc2c@fedora> <aKhNFn7hdsLapLWO@google.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <aKhNFn7hdsLapLWO@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/22/25 12:57 PM, Alice Ryhl wrote:
> On Fri, Aug 22, 2025 at 11:52:21AM +0200, Boris Brezillon wrote:
>> On Fri, 22 Aug 2025 09:28:24 +0000
>>
>> Maybe it's time we start moving some bits of the gpuva field docs next
>> to the fields they describe:
>>
>> 	/**
>> 	 * @gpuva: Fields used by GPUVM to manage mappings pointing to this GEM object.
>> 	 */
>> 	struct {
>> 		/**
>> 		 * @gpuva.list: list of GPU VAs attached to this GEM object.
>> 		 *
>> 		 * Drivers should lock list accesses with the GEMs &dma_resv lock
>> 		 * (&drm_gem_object.resv) or &drm_gem_object.gpuva.lock if the
>> 		 * list is being updated in places where the resv lock can't be
>> 		 * acquired (fence signalling path).
>> 		 */
>> 		struct list_head list;
> 
> This isn't a new issue, but it's somewhat confusing to call it a list of
> VAs when it's a list of vm_bos.

Yes, I already suggested (don't remember where though) to change the name of the
anonymous accordingly. I think I forgot to rename it back when I introduced
struct drm_gpuvm_bo.

If you want, please add a patch for this in the next version. But it's also fine
to leave as is for your series of course. I can also fix it up. :)

