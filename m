Return-Path: <linux-kernel+bounces-858064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D21CBBE8C15
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 661B61AA4CFE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D08C345757;
	Fri, 17 Oct 2025 13:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4yKyRtXL"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A893451AB
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760706621; cv=none; b=rOViIz5H4+Epn++Tjko/w0J7/Srr8qW+J3hgNEpXMtRPn17XwiTRQeNfba9KOQY5gNxWNB5Dth6uHmpmTzSnx567+4uxjYUyYASnAMAm4BYrr1FWpAfHMO/pN4xJoQHnv00mKfJsCzl7drGULpuigMVkGcpD1eZE983OOq6MS1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760706621; c=relaxed/simple;
	bh=EEnm10MyYA68jZvokqSZJ7WfWmlN6TZQC+epsXTbdnY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VYeNjaNIZDxQvVPU+fOWJYh2PT/0cb7bNSYQbq2WEKYVktWlSCJqyplkwO7s14yb+aiwjdfUK6fDQE34Wx6f2hBbKJghsH7t0gYTF1WEkq6B87azKhYLFeguMoDi7OndEIZoBQC07QKdZ6fk9JIAB0/tjy6rnqHG9szStde+umg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4yKyRtXL; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-471001b980eso12842445e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760706618; x=1761311418; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DoKMhSsyXfCYMAzn+A2bSpqJRrRoIP0G76cRQo/jaDg=;
        b=4yKyRtXLt1e28eRbQC+4UoY7CddijifB+pHvv4PunRxXpNJbGNbTzW29kNIbcnNl12
         /pfxM5O7yabXtqi9z4+c8LrYrP85Qq5vulVag4ozniNIzQokIEYMSXoL6hfE/2+2zr+H
         xkFKKrtsEqMWbjH9nVbbJJNXO8dISi9FbNWP3oYzI6HDERg32N1p4i60ezm2UoFcbCSN
         6NVciX/t+vN0CcSXUfvSHANwQF2/qKoyPbLuN4d+6WCjfeLLogVcBF0GDKSzHRWbHYyy
         3kENiOBd91BPd1Xg/dsLs1nJqI/M8UNBauCOKNlfz2fGPvWVqQM+skxIbTXyNFQuDHQQ
         ey0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760706618; x=1761311418;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DoKMhSsyXfCYMAzn+A2bSpqJRrRoIP0G76cRQo/jaDg=;
        b=txwCFOWGTB3u8GYT5ev+cGaMXtj0Oe0H+I4qhqvjs2rpBvwU3qnPF07fOkZUUSbcEY
         fVcLROO+N+EaMhf5KIXj9/n8yFwYwvonddbvYzwVSo6IwWPtM0J6NcLjvej3/7tKaXaQ
         oLRIB/IEqwrRAMKRqD8cIVmzAxlwXRuRWilBhtrcIKkwIbp3O1AWi3MEiJlApEKJ6Pxv
         vu/jcvCzCeEQzC+QOwQ+KGf6nuHVegnSYyfNi2hPVOi0XhmRWApn8K5oP5cwtvGvpzzc
         5yXJpHBkWJqKAOHJuZVSyUD/RX9qfJg7sQoRgWaUNe+7FiHKiiYINLKcdKGWfdtC4Jss
         ZW6g==
X-Gm-Message-State: AOJu0YyoQNhKbq6Mc1zgxPlVDTkyEYnJTWt3ipwnLDMUb3+NcXcRCUAa
	W9sFBPJLY+DC44i0Ezi8g9wnZA7SB19ZEH4gy+c7w6Dseg6HGtMAcXqVJhL9meJKWPZ/GseDTS2
	im/n80o2WTq+VenPUgA==
X-Google-Smtp-Source: AGHT+IFiCznOq3jJbbGi+1Po7x6b9rs4AbbiNhIwAWz98uYVYGfItGbGzMFvBzl0siZ+LujshcHcrsGvZWg5Wc0=
X-Received: from wmgg24.prod.google.com ([2002:a05:600d:18:b0:46f:aa50:d706])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b8c:b0:46e:4287:a85e with SMTP id 5b1f17b1804b1-471178a4af1mr25882615e9.13.1760706618472;
 Fri, 17 Oct 2025 06:10:18 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:10:17 +0000
In-Reply-To: <20251016202044.2748678-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016202044.2748678-1-lyude@redhat.com>
Message-ID: <aPJAOXtv2knFkyDP@google.com>
Subject: Re: [PATCH] rust: drm/gem: Remove Object.dev
From: Alice Ryhl <aliceryhl@google.com>
To: Lyude Paul <lyude@redhat.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Danilo Krummrich <dakr@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Asahi Lina <lina+kernel@asahilina.net>, 
	Shankari Anand <shankari.ak0208@gmail.com>
Content-Type: text/plain; charset="utf-8"

On Thu, Oct 16, 2025 at 04:18:58PM -0400, Lyude Paul wrote:
> I noticed by chance that there's actually already a pointer to this in
> struct drm_gem_object. So, no use in carrying this around!
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  rust/kernel/drm/gem/mod.rs | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
> index 30c853988b942..28d929edae267 100644
> --- a/rust/kernel/drm/gem/mod.rs
> +++ b/rust/kernel/drm/gem/mod.rs
> @@ -187,12 +187,10 @@ impl<T: IntoGEMObject> BaseObject for T {}
>  /// Invariants
>  ///
>  /// - `self.obj` is a valid instance of a `struct drm_gem_object`.
> -/// - `self.dev` is always a valid pointer to a `struct drm_device`.
>  #[repr(C)]
>  #[pin_data]
>  pub struct Object<T: DriverObject + Send + Sync> {
>      obj: Opaque<bindings::drm_gem_object>,
> -    dev: NonNull<drm::Device<T::Driver>>,
>      #[pin]
>      data: T,
>  }
> @@ -222,9 +220,6 @@ pub fn new(dev: &drm::Device<T::Driver>, size: usize) -> Result<ARef<Self>> {
>              try_pin_init!(Self {
>                  obj: Opaque::new(bindings::drm_gem_object::default()),
>                  data <- T::new(dev, size),
> -                // INVARIANT: The drm subsystem guarantees that the `struct drm_device` will live
> -                // as long as the GEM object lives.
> -                dev: dev.into(),
>              }),
>              GFP_KERNEL,
>          )?;
> @@ -247,9 +242,9 @@ pub fn new(dev: &drm::Device<T::Driver>, size: usize) -> Result<ARef<Self>> {
>  
>      /// Returns the `Device` that owns this GEM object.
>      pub fn dev(&self) -> &drm::Device<T::Driver> {
> -        // SAFETY: The DRM subsystem guarantees that the `struct drm_device` will live as long as
> -        // the GEM object lives, hence the pointer must be valid.
> -        unsafe { self.dev.as_ref() }
> +        // SAFETY: `struct drm_gem_object.dev` is initialized and valid for as long as the GEM
> +        // object lives.
> +        unsafe { drm::Device::from_raw((*self.as_raw()).dev) }

The wording here and in the invariants could be improved to say that
T::Driver is the right choice for the generic parameter.

Alice

