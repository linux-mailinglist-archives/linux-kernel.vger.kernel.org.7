Return-Path: <linux-kernel+bounces-756817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 417F7B1B9AD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2AFD34E1AB3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC2F295DBE;
	Tue,  5 Aug 2025 17:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Mqdj0Coy"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451632AD00;
	Tue,  5 Aug 2025 17:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754416633; cv=pass; b=VAOUlRWS0SCT+hrOjw38azTfzPrU1+7XlTqpr8aHBeHju7Zomqhn6mKf1POBkN2tNzZP58XNPOBfxqXGWMuRdrd2wxQjIfWT+uc19V7Ulo+aeWkxGN3N9zdRJ8NfhAJKTIgNCXkLIYCeNcKnf8OVljdwDdCsOjr61X5OJqNZ/BU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754416633; c=relaxed/simple;
	bh=f4qUwwmTjP8z24cY61CQx/WPsrh41HP5fDyt9wMVSxM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SkxnfXB+tYSx9yL9M+MHzzlkNbpsxSyulsNwmu8iz+6DKb/w1sA+bjpwIwQrkc2jFmc+927tUGtUJ6e1Phx7KiRZODn4jl1ayN0Uj2feye8IMV26MisipcMhdSknE3GtJIPKFmTLyO5uhGHC5VyyLo0/uGdHY6SWcUKLI8N/iqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Mqdj0Coy; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1754416604; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dASTlVU2m+CEfC74ZZH1XGJb1qJGHaPLvLTxulAM79ecn8t06CULnxdix7D8I34OMg0iPg/VQL5QTLZoUMkcFiQ51ZQwq3LpKUSvd6jVCA8EHcI3kdn2RyOl3qwbzq5K8qsLVOaltzG2jfgLlk9usrZ0AGDaYetwJcwjiVJTxAE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754416604; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=f4qUwwmTjP8z24cY61CQx/WPsrh41HP5fDyt9wMVSxM=; 
	b=Q7vyK4m4Wv7DADx6mBK23ejP9mKktj2Q36R9dvucVCffON/EAaT2hPBIgrjcrh5AVR2tXjXXMj9r7Ah+iBHjwbrwvMMillA+QzDRoN9zL0KbW5n4aPdxj6dlaquTtuSZlmgaLG1Nrii915X7U7gmEWxKmi3+hsD8nhRiLMtf7B8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754416604;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=f4qUwwmTjP8z24cY61CQx/WPsrh41HP5fDyt9wMVSxM=;
	b=Mqdj0CoydzQvumUfHTqZ3KECVA+ltrcUkUYCG5Fb/zRYtA74m0JNbrlSMetOLKUY
	pfGE5KpyW5fKCTp16gQxlZKjYduHChDxPnX1YxeFSk++EB45+f+6LHKK+1Q25ceAdF7
	npkCL7YNaxSQG+WBuI/bvlz2ZDST0nGo3hJ8kw80=
Received: by mx.zohomail.com with SMTPS id 1754416601399165.46384762186733;
	Tue, 5 Aug 2025 10:56:41 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v5 0/3] rust: add `ww_mutex` support
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <ec32fc5f5a8658c084f96540bd41f5462fa5c182.camel@gmail.com>
Date: Tue, 5 Aug 2025 14:56:24 -0300
Cc: =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 boqun.feng@gmail.com,
 gary@garyguo.net,
 lossin@kernel.org,
 a.hindborg@kernel.org,
 aliceryhl@google.com,
 tmgross@umich.edu,
 dakr@kernel.org,
 peterz@infradead.org,
 mingo@redhat.com,
 will@kernel.org,
 longman@redhat.com,
 felipe_life@live.com,
 daniel@sedlak.dev,
 bjorn3_gh@protonmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <89BB40E5-24CA-44E8-AE67-3E58A118A5A8@collabora.com>
References: <20250621184454.8354-1-work@onurozkan.dev>
 <20250724165351.509cff53@nimda.home>
 <ec32fc5f5a8658c084f96540bd41f5462fa5c182.camel@gmail.com>
To: Lyude Paul <thatslyude@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 5 Aug 2025, at 13:22, Lyude Paul <thatslyude@gmail.com> wrote:
>=20
> Hey! Onur, if you could make sure that future emails get sent to
>=20
> lyude at redhat dot com
>=20
> That would be appreciated! I usually am paying much closer attention =
to that
> email address. That being said, some comments down below:
>=20
> On Thu, 2025-07-24 at 16:53 +0300, Onur =C3=96zkan wrote:
>> Hi again,
>>=20
>> Just finished going over the C-side use of `ww_mutex` today and I
>> wanted to share some notes and thoughts based on that.
>>=20
>> To get the full context, you might want to take a look at this thread
>> [1].
>>=20
>> - The first note I took is that we shouldn't allow locking without
>> `WwAcquireCtx` (which is currently possible in v5). As explained in
>> ww_mutex documentation [2], this basically turns it into a regular
>> mutex and you don't get benefits of `ww_mutex`.
>=20
> I disagree about this conclusion actually, occasionally you do just =
need to
> acquire a single mutex and not multiple. Actually - we even have a
> drm_modeset_lock_single_*() set of functions in KMS specifically for =
this
> purpose.=20
>=20
> Here's an example where we use it in nouveau for inspecting the atomic =
display
> state of a specific crtc:
>=20
> =
https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/nouveau/disp=
nv50/crc.c#L682
>=20
> This isn't actually too unusual of a usecase tbh, especially =
considering that
> the real reason we have ww_mutexes in KMS is to deal with the atomic
> transaction model that's used for modesetting in the kernel.
>=20
> A good example, which also doubles as a ww_mutex example you likely =
missed on
> your first skim since all of it is done through the drm_modeset_lock =
API and
> not ww_mutex directly:
>=20
> =
https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/nouveau/disp=
nv50/crc.c#L544
>=20
> drm_modeset_acquire_init() is a wrapper around ww_mutex_init() which =
actually
> does pretty much exactly what Daniel is describing lower in the =
thread:
> keeping track of a list of each acquired lock so that they can be =
dropped once
> the context is released.
>=20
> drm_atomic_get_crtc_state() grabs the CRTC context and ensures that =
the crtc's
> modeset lock (e.g. a ww_mutex) is actually acquired
>=20
> drm_atomic_commit() performs the checking of the atomic modeset =
transaction,
> e.g. going through the requested display settings and ensuring that =
the
> display hardware is actually capable of supporting it before allowing =
the
> modeset to continue. Often times for GPU drivers this process can =
involve not
> just checking limitations on the modesetting object in question, but
> potentially adding other modesetting objects into the transaction that =
the
> driver needs to also inspect the state of. Adding any of these =
modesetting
> objects potentially means having to acquire their modeset locks using =
the same
> context, and we can't and don't really want to force users to have an =
idea of
> exactly how many locks can ever be acquired. Display hardware is =
wonderful at
> coming up with very wacky limitations we can't really know ahead of =
time
> because they can even depend on the global display state.
>=20
> So tracking locks is definitely the way to go, but we should keep in =
mind
> there's already infrastructure in the kernel doing this that we want =
to be
> able to handle with these APIs as well.
>=20

Well, the API I proposed would be implemented as a separate type, so the =
whole
thing would be opt-in anyways. There=E2=80=99s nothing stopping us from =
providing
abstractions for the current infrastructure as well and both things =
should
co-exist fine, at least that=E2=80=99s my understanding at this point.

IOW: there is nothing stopping us from implementing say, a drm_exec =
abstraction
(or whatever else, really) if needed for whatever reason. But the =
proposed API
should be much more idiomatic for Rust code.

=E2=80=94 Daniel


