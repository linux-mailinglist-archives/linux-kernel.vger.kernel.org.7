Return-Path: <linux-kernel+bounces-858090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EC9BE8D88
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 156C03A32FA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78BF3570B0;
	Fri, 17 Oct 2025 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dtMHYOTf"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820A91DDC1D
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760707829; cv=none; b=GUBQAM924F7Us/b954Ct19gyz7PxsYl9bMbXqKDe/yz5jAIXKjNfV97rDdco0sXLG3KrPmFw3u3wsxPY8B5Xvt4zHjbN5FsQp5VNVJXZdBvTVp5dD7cdpogpsVLZzn5FOaUwHixLdp/KAouU9BYCgWNMZbwvewqLtU9iPATaLSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760707829; c=relaxed/simple;
	bh=oYMU2S4GJJGC7aRx1cjLxEruylUZZplVDTmADd/KpGc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lzXtZgGRbzSeuxsHEJFiHDN9ozkIPPPHILn77X4FrRRiA5nVZNba1Jo0Totlnuo9WJd69aL3FF6VkbUfq2792EBEEBZzGInYvuLnHlU9tl8400sMoTzeUxaJ0yBSa2AcJmCfZ4yb66dAp+FqJoMyU7f9fEC868KuX4XDhNPc35E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dtMHYOTf; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-42700160169so1102419f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760707826; x=1761312626; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ss1QlA7acXACZyHR7wiT2Nqcn1nIjx/VSZWA+hhjA4=;
        b=dtMHYOTfb/1aKFH9AJQ2wo5Ii/2zLRA5Xw4HV4ThvbLnopFpUwHOMzoUSUZ+ggGGvL
         KS9gZr/4GC6tKcF79kQl0P2NlhcH6MLctH+y4gPqh6hQd5uB8Eh383NngzlarkaPkKNA
         nAoMLg3K8qUN38eolWRLGvKr7ovsu5Vo2RVJDw8UEpBzGP75VfNpE32c6K9qbi7CK0FZ
         YcdSNnuTcyw80t62HgiwWCzqpigzcSZ79Ho4DmUx9jEQzS6a8JR0ge6Niu3YXSg9vnKG
         BdPWzr52q+JoNTEYLjlfjOkBH3S8eUxedQ7lJk4go/QBbaY+6Gh5gz1XYfqN3rwMCues
         z+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760707826; x=1761312626;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ss1QlA7acXACZyHR7wiT2Nqcn1nIjx/VSZWA+hhjA4=;
        b=VwWIGtsu4jtMDlCdixRc2XU6MmHhLP3IbvUgECJdKLmPpDK6fma8YNQ8PG3tz6Et7m
         DZGpUKC3kPh78Omfa+yvgGhNBJ0o9YP06HW387St0FphKgIQHrIP15Ea1FEEFX0sFcPj
         N7klnMyHYJMTRXgbN7jg9BFk7m4lQZ8iUP250PlMuwqnadDnVSlWoUcD2VAoCBoo3bNl
         mo5JPpfMbv65h+kAjjBdQ4zcSi2jUMgHSQC045NKC4A9jmw7fXJ1HxeXL+aJ6Va7ekcK
         UG069Ge6MiWOJREzCp14dzv2iR92+ULTtoru10whoT3biNAYBAfzSPcnDjb6QM//8uLr
         lylQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3eNhGXDCBw1hkjgbwY8kEafxe9VObwPiQ6MmruORQxKErOt41J41Y7sEY4Wua4Ui1dqxdU4GBO0qpMVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1MsNG16bP+ijrs+AFxs8kVGV3K9O7RTkKHyDpxbEHzujp4YwG
	Vy/jRNiCK/dx+enZadZ95sTkGtZtf94ii+vXBwvOhoQf0jTFS6z7+4K/OZ/VYHK7vERb/5fOpMx
	pKEgUxC2FTCeLAd26JQ==
X-Google-Smtp-Source: AGHT+IElTbDFCunvl+Q6VKcSJIGvmBa3dVuDKgt0GL3PK5Tj4PCBAZb9dyem+MFrgb18Jr5MVI9nNpg0yqNiOdc=
X-Received: from wmcn16.prod.google.com ([2002:a05:600c:c0d0:b0:46f:aa50:d700])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:400d:b0:3ee:1461:1659 with SMTP id ffacd0b85a97d-42704d98980mr2657038f8f.31.1760707825710;
 Fri, 17 Oct 2025 06:30:25 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:30:24 +0000
In-Reply-To: <20251016210955.2813186-7-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016210955.2813186-1-lyude@redhat.com> <20251016210955.2813186-7-lyude@redhat.com>
Message-ID: <aPJE8EC5OmlmSrYt@google.com>
Subject: Re: [PATCH v4 6/9] rust: drm: gem: shmem: Add DRM shmem helper abstraction
From: Alice Ryhl <aliceryhl@google.com>
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	Daniel Almeida <daniel.almeida@collabora.com>, Asahi Lina <lina@asahilina.net>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Asahi Lina <lina+kernel@asahilina.net>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Shankari Anand <shankari.ak0208@gmail.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"

On Thu, Oct 16, 2025 at 05:08:19PM -0400, Lyude Paul wrote:
> From: Asahi Lina <lina@asahilina.net>
> 
> The DRM shmem helper includes common code useful for drivers which
> allocate GEM objects as anonymous shmem. Add a Rust abstraction for
> this. Drivers can choose the raw GEM implementation or the shmem layer,
> depending on their needs.
> 
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> +impl<T: DriverObject> gem::IntoGEMObject for Object<T> {
> +    fn as_raw(&self) -> *mut bindings::drm_gem_object {
> +        // SAFETY: Our immutable reference is proof that this is are to dereference
> +        unsafe { &raw mut (*self.obj.get()).base }

Typo.

Also, in principle, this should refer to a type invariant saying that
`obj` is a valid shmem object.

> +    }
> +
> +    unsafe fn from_raw<'a>(obj: *mut bindings::drm_gem_object) -> &'a Object<T> {
> +        // SAFETY: The safety contract of from_gem_obj() guarantees that `obj` is contained within
> +        // `Self`
> +        unsafe {
> +            let obj: *mut Opaque<_> =
> +                container_of!(obj, bindings::drm_gem_shmem_object, base).cast();

Please use Opaque::cast_from() instead of the unrestricted cast()
operation.

There are several instances of this throughout the file.

Alice

