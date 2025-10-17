Return-Path: <linux-kernel+bounces-858077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEDABE8CF9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322456E25EB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A6734F479;
	Fri, 17 Oct 2025 13:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P5XGEUdT"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745B6320CB9
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760707359; cv=none; b=H63yqdKxzSKB4JjLhBPXcjJjnOnFQQJpZv0RC3eaeYrhosUdHIoHM7chrCVL0Gvp2yK+vC5Z/M6BRRRrtAlx2lOE5d9b9XwsJxDZKyZeslfoQyodmPP9VWndnON1D/6PTogoLa9lKz9+m90+7Qjw7sKxOO3x73od8UqAEnMbpHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760707359; c=relaxed/simple;
	bh=jx8LTsLHA8gYmELEACprqZSehQ5I5B2b0owj/V+XDhY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QQzwn7MbIhNbKpk32sZ+uLeoQhVZV2vNGV90uG5q01UP5vO45EyhaIHiWdN5IOfZbey8QD7GN2JJmOl461doZbpggj8AqqQIWMuS3H1KjjIp9daWmaVU9meu24VO9gPYTeXikGmKTwTQwBxZohKk9bwNfUR55iVqGwzqoLxEGCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P5XGEUdT; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4711899ab0aso7485385e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760707356; x=1761312156; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GnaDsn7nll18ow1kOpNbSLp5i6GMNaHfVFAbzbbvH9I=;
        b=P5XGEUdTa56ifSpXe39inGNN3uJ8XOeuuXzFNTKIv/1L9GeVo4244ljv0j5nujdrbl
         qVASVt0VqVKvUTMXbw0E71l/TVAEGekZ+Jj8vxyoYPOmqSkyZ/bxa06Kfq4fGiw0BYZ8
         k0LBQDFdR4nvfnoS1K1NbYS7xwYIUMWzFteInHJtLumE5Vynj7qzkipyJX9u2vCoAMpD
         YPWG5C3RwrexlfQsG0kBiDnwh+1VbyNED/0SwImEXuB//UMp95BEwb6xabAT/AjHV53B
         zPfCjHjt3Na83R3rszRwe5rSsvUQ54rEFimmpjeBSMCWNMZq73+s+341kWWMS8ppabT+
         jzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760707356; x=1761312156;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GnaDsn7nll18ow1kOpNbSLp5i6GMNaHfVFAbzbbvH9I=;
        b=AR0B0BRPodMTXvTSJ3RKszgHrvRNjl0LIESERq2cT2EpmWKROoZ0XEwuOfxd5yrl4d
         j2PERleIb8b80hmKnBYYcGHDR5JtipFmsFPdYY9spB1cy/TnHxrjZ3bGrrTszDPMDd2t
         URe6xSNw1/yhrPQ3cj8bsEPgCyK64a/G5aeAkEe9/uE6xOfeAo/h3GUdtp+gBUN/ji9p
         +2od5/AJdB+LZ5tXdmHJTM3rsXMoFobhkFMRWHlWbsCV63UPpTs03+iUom2yBXmgwB1p
         kBszvrHh7dNSiJKRLqlq8K6R0nIsj02gAQcr+6U7OeEfLdcMDgFR4xAZyQkz8Jgynfyg
         1HXA==
X-Forwarded-Encrypted: i=1; AJvYcCWmfFF9zFb2nWGOLcO1TFhVdsm2yDkDn1tPCIXWjmvUTgaqelgA6x+eeTLnXpf2Ck++6WZJbcH1BYiIsDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa1v2FQ/hj3T7odP9Igaje+dSQiSi4yMQl5duWstRpmRCygCkO
	vVh6/S9CFjCA+9XE9bpApv5rmWTl7qdnsFt9ZZzoFuStyDoejk9JUzFCwfGOEbLmhh3BBRE5xAc
	ZAyfTgxWh/oAW/v0gTA==
X-Google-Smtp-Source: AGHT+IHm/rxQFjzIKD/ix4PvuHjEf9V7l7jdvLwUpstW+PdTOJzmLn/jF0s/g0PNGf6xGAdUynTKR0RdRZTpdF0=
X-Received: from wmna4.prod.google.com ([2002:a05:600c:684:b0:46e:45f4:a00b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1e1f:b0:471:d2f:799a with SMTP id 5b1f17b1804b1-47117877791mr24693975e9.16.1760707355934;
 Fri, 17 Oct 2025 06:22:35 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:22:34 +0000
In-Reply-To: <20251016210955.2813186-3-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016210955.2813186-1-lyude@redhat.com> <20251016210955.2813186-3-lyude@redhat.com>
Message-ID: <aPJDGqsRFzuARlgP@google.com>
Subject: Re: [PATCH v4 2/9] rust/drm: Add gem::impl_aref_for_gem_obj!
From: Alice Ryhl <aliceryhl@google.com>
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	Daniel Almeida <daniel.almeida@collabora.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Asahi Lina <lina+kernel@asahilina.net>, Shankari Anand <shankari.ak0208@gmail.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"

On Thu, Oct 16, 2025 at 05:08:15PM -0400, Lyude Paul wrote:
> In the future we're going to be introducing more GEM object types in rust
> then just gem::Object<T>. Since all types of GEM objects have refcounting,
> let's introduce a macro that we can use in the gem crate in order to copy
> this boilerplate implementation for each type: impl_aref_for_gem_obj!().
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  rust/kernel/drm/gem/mod.rs | 53 +++++++++++++++++++++++++++-----------
>  1 file changed, 38 insertions(+), 15 deletions(-)
> 
> diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
> index 20c2769a8c9d6..981fbb931e952 100644
> --- a/rust/kernel/drm/gem/mod.rs
> +++ b/rust/kernel/drm/gem/mod.rs
> @@ -15,6 +15,43 @@
>  };
>  use core::{ops::Deref, ptr::NonNull};
>  
> +/// A macro for implementing [`AlwaysRefCounted`] for any GEM object type.
> +///
> +/// Since all GEM objects use the same refcounting scheme.
> +macro_rules! impl_aref_for_gem_obj {
> +    (
> +        impl $( <$( $tparam_id:ident ),+> )? for $type:ty
> +        $(
> +            where
> +                $( $bind_param:path : $bind_trait:path ),+
> +        )?
> +    ) => {
> +        // SAFETY: All gem objects are refcounted
> +        unsafe impl $( <$( $tparam_id ),+> )? crate::types::AlwaysRefCounted for $type
> +        $(
> +            where
> +                $( $bind_param : $bind_trait ),+
> +        )?
> +        {
> +            fn inc_ref(&self) {
> +                // SAFETY: The existence of a shared reference guarantees that the refcount is
> +                // non-zero.
> +                unsafe { bindings::drm_gem_object_get(self.as_raw()) };
> +            }
> +
> +            unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
> +                // SAFETY: `obj` is a valid pointer to an `Object<T>`.
> +                let obj = unsafe { obj.as_ref() };
> +
> +                // SAFETY: The safety requirements guarantee that the refcount is non-zero.
> +                unsafe { bindings::drm_gem_object_put(obj.as_raw()) };

I would prefer to move the call to `.as_raw()` to the `let obj` line so
that the reference more clearly expires before the call to
`drm_gem_object_put()`. The reference must not exist during the call to
`drm_gem_object_put()`.

> +            }
> +        }
> +    };
> +}
> +
> +pub(crate) use impl_aref_for_gem_obj;

The usual way to export macros outside the current file is:

1. Annotated with #[macro_export]
2. Export with `pub use impl_aref_for_gem_obj`

Alice

