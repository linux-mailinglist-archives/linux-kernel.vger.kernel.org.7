Return-Path: <linux-kernel+bounces-806612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32423B4994F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93EC34E3C46
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D5822ACF3;
	Mon,  8 Sep 2025 19:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQrd480F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A52E7E107;
	Mon,  8 Sep 2025 19:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757358292; cv=none; b=hQ7/JZgXQknfiuahWDP+4p0HFx1vVTW1mxjWPtmOysz3qxbEvaYGeZzQBHpUvrlYOtF2pLeLxDkh2mc/p0BumPhv7FJQRUBOojMqIUed+LfSDqWVOImC3dRcfVxt4msejDr0Mh9uiAOIulja5DZRqDzLOIbUPVp0rhX7eBF41vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757358292; c=relaxed/simple;
	bh=OR+JDujD3Fb8Vx7FEcUt+VBJwg5Qbiq6BsKuLXHf/LM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fRZBl748QwFgiM2ghW7mj27y2LzGez9i0MYO2MwHpMyMYyBeI2Z1GUT7d/sXXSQHLmTFqRvgaxIzDXLvJmT2Ht5YyzIY176xtVUxPPAKMQCXxB1sxhyuW1Kg50BswQ8bdDmcZtI7NNfGdt/bJQx7iHAwsHV7HFHKYqLxblRYDAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQrd480F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB42C4CEF1;
	Mon,  8 Sep 2025 19:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757358291;
	bh=OR+JDujD3Fb8Vx7FEcUt+VBJwg5Qbiq6BsKuLXHf/LM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WQrd480Fgq1Jk+JXmJmwR/YKiGCUZnUSTJaJWmH65DmuXpMi7ZhJAd/tQR9S6B0L6
	 5CI5ASp0pxqYnT42JJ0JIGqacWXGjtU/fZr/TixT3N0OvS3rue+r/Y9C086Teaq09V
	 3ob28CFsh9f/V7aAe86IQ9o2qzmWC/U8IdmltfKMStDN0s6qou6/JmXT3wbXgNKUnn
	 X+Mz+PypoxQYqEsimeZ6Aksdqr+k1IQalM0oYEKEABekbnL3aDHQ6juQcXywI74paJ
	 +XkOPuo00CNGtR9m+JrpVoDhzm0SoTzREMl/op2/4T3Sq1MUq90IAuwMDg/GQ0kALb
	 AB/axqJgWK9Zg==
Message-ID: <b92c52f8-d5b5-45ba-9195-9d8e20b41f0e@kernel.org>
Date: Mon, 8 Sep 2025 21:04:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] rust: drm: gem: Simplify use of generics
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina+kernel@asahilina.net>,
 "open list:DRM DRIVER FOR NVIDIA GPUS [RUST]" <nouveau@lists.freedesktop.org>
References: <20250908185239.135849-1-lyude@redhat.com>
 <20250908185239.135849-2-lyude@redhat.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250908185239.135849-2-lyude@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/8/25 8:46 PM, Lyude Paul wrote:
> Now that my rust skills have been honed, I noticed that there's a lot of
> generics in our gem bindings that don't actually need to be here. Currently
> the hierarchy of traits in our gem bindings looks like this:
> 
>   * Drivers implement:
>     * BaseDriverObject<T: DriverObject> (has the callbacks)
>     * DriverObject (has the drm::Driver type)
>   * Crate implements:
>     * IntoGEMObject for Object<T> where T: DriverObject
>       Handles conversion to/from raw object pointers
>     * BaseObject for T where T: IntoGEMObject
>       Provides methods common to all gem interfaces
> 
>   Also of note, this leaves us with two different drm::Driver associated
>   types:
>     * DriverObject::Driver
>     * IntoGEMObject::Driver
> 
> I'm not entirely sure of the original intent here unfortunately (if anyone
> is, please let me know!), but my guess is that the idea would be that some
> objects can implement IntoGEMObject using a different ::Driver than
> DriverObject - presumably to enable the usage of gem objects from different
> drivers. A reasonable usecase of course.
> 
> However - if I'm not mistaken, I don't think that this is actually how
> things would go in practice. Driver implementations are of course
> implemented by their associated drivers, and generally drivers are not
> linked to each-other when building the kernel. Which is to say that even in
> a situation where we would theoretically deal with gem objects from another
> driver, we still wouldn't have access to its drm::driver::Driver
> implementation. It's more likely we would simply want a variant of gem
> objects in such a situation that have no association with a
> drm::driver::Driver type.
> 
> Taking that into consideration, we can assume the following:
> * Anything that implements BaseDriverObject will implement DriverObject
>   In other words, all BaseDriverObjects indirectly have an associated
>   ::Driver type - so the two traits can be combined into one with no
>   generics.
> * Not everything that implements IntoGEMObject will have an associated
>   ::Driver, and that's OK.
> 
> And with this, we now can do quite a bit of cleanup with the use of
> generics here. As such, this commit:
> 
> * Removes the generics on BaseDriverObject
> * Moves DriverObject::Driver into BaseDriverObject
> * Removes DriverObject
> * Removes IntoGEMObject::Driver
> * Add AllocImpl::Driver, which we can use as a binding to figure out the
>   correct File type for BaseObject
> 
> Leaving us with a simpler trait hierarchy that now looks like this:
> 
>   * Drivers implement: BaseDriverObject
>   * Crate implements:
>     * IntoGEMObject for Object<T> where T: DriverObject
>     * BaseObject for T where T: IntoGEMObject
> 
> Which makes the code a lot easier to understand and build on :).
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

Acked-by: Danilo Krummrich <dakr@kernel.org>

