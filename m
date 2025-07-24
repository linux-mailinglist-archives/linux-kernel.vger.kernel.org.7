Return-Path: <linux-kernel+bounces-744873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91791B111FB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A4A11C25C0C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192D923875D;
	Thu, 24 Jul 2025 20:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8WwFdrC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6687322E406;
	Thu, 24 Jul 2025 20:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753387410; cv=none; b=Pl/Er7unxDm+6zfc4WqL+4pJa81LEwz4diuR1OfavolBhxt4BdYf6pu5QHO2Enqq073TqXeT3/sk2aLWRuH+9sWiM/UUClaEmarjV1exDMMYUQdVmmqK1U8hDV/MmAj2tIJoadQhM+Rd8xpN/VHiRJAKSBKTwdCliqYHY617M70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753387410; c=relaxed/simple;
	bh=fP0jCPxK1T2Ab4oOBOWBx+XZP5UkwaWLafeWg2ZgBJs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=GZDZuiA4V3qW6+MGRahMINYAj2EHMq2BrJRoPWvGZEbasYXyxRUTKjIMbUlGLQmhDAZPaEC0Jc4EFCK3DZYaBhfmkaS5LpNTZnYZ3FczsOWZ7ZgsIiP13oUUid5GerBoo4QpnW84x4kFNgBJNLzv7H62dx64Lnk3zlq2C80TBoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8WwFdrC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D066AC4CEED;
	Thu, 24 Jul 2025 20:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753387410;
	bh=fP0jCPxK1T2Ab4oOBOWBx+XZP5UkwaWLafeWg2ZgBJs=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=E8WwFdrC0RZ8rN7KsoVsEMrz9EqPnn13H/y/P7tAdZ247z4YBdpzTMikLpK4D0B5d
	 mckAPFE+mrBsKdgZehZsVF1LVj0xcckG9oVDGyDOKf3sP5m6uNCJ9bRhUZQ9VOH/F8
	 Olz0wT8gw1HaHi64LZXyA1unW6aNq+dVE0toyAZoe6dhlgfHE2MKd81Te/9ty/5vOQ
	 seL1LFy8s0xfTYL5aJIN+IHPYw17vSqzbLN1OCYyr8dDQxFdrfjFr11Nksxt4SWA/T
	 I5ivN9RjFm4i2abAKSt6c9ImLJOwQKIm0cgFzsDmzEGOrg6zoZpXy5HzD46w98A6KF
	 0fzCgFpZzfBaQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Jul 2025 22:03:24 +0200
Message-Id: <DBKJYLF9E3TY.IM6UZFA0BW9I@kernel.org>
Subject: Re: [PATCH] Partially revert "rust: drm: gem: Implement
 AlwaysRefCounted for all gem objects automatically"
Cc: <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Asahi
 Lina" <lina+kernel@asahilina.net>, "Alyssa Rosenzweig"
 <alyssa@rosenzweig.io>, "open list" <linux-kernel@vger.kernel.org>
To: "Lyude Paul" <lyude@redhat.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250724191523.561314-1-lyude@redhat.com>
In-Reply-To: <20250724191523.561314-1-lyude@redhat.com>

On Thu Jul 24, 2025 at 9:15 PM CEST, Lyude Paul wrote:
> -// SAFETY: All gem objects are refcounted.
> -unsafe impl<T: IntoGEMObject> AlwaysRefCounted for T {
> -    fn inc_ref(&self) {
> -        // SAFETY: The existence of a shared reference guarantees that t=
he refcount is non-zero.
> -        unsafe { bindings::drm_gem_object_get(self.as_raw()) };
> -    }
> -
> -    unsafe fn dec_ref(obj: NonNull<Self>) {
> -        // SAFETY: We either hold the only refcount on `obj`, or one of =
many - meaning that no one
> -        // else could possibly hold a mutable reference to `obj` and thu=
s this immutable reference
> -        // is safe.
> -        let obj =3D unsafe { obj.as_ref() }.as_raw();
> -
> -        // SAFETY:
> -        // - The safety requirements guarantee that the refcount is non-=
zero.
> -        // - We hold no references to `obj` now, making it safe for us t=
o potentially deallocate it.
> -        unsafe { bindings::drm_gem_object_put(obj) };
> -    }
> -}

IIUC, you'll add rust/kernel/drm/gem/shmem.rs with a new type shmem::Object=
 that
implements IntoGEMObject, right?

If this is correct, I think that should work.

Do I miss anything?

