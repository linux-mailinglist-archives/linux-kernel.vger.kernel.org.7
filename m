Return-Path: <linux-kernel+bounces-863609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1E6BF8499
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94C7619C3A3F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C15026F462;
	Tue, 21 Oct 2025 19:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="Y7PiUUfk"
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E9A26CE34;
	Tue, 21 Oct 2025 19:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761075802; cv=none; b=lgX93h+mL7fsbcCuX1Ce+eiQsiXAXGvBdE2tljCxmPXSFZ8LmP9OTBEH3fHxDjgJG6d9aoa9deAF1Ci/cTS3HbXWbjUIVjUQlsk+mGjXFGiGEp9qo7Jk2Us9fxOYBA6xWyPayHeQSdF/hbxf9g5zmhnCQS6PPoL+goIr+WeztlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761075802; c=relaxed/simple;
	bh=cF/2qvNbGtFEaf7MiC2FviRqJj6MFqKh2TuH/gNL7eg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cDDbwr+kmNzIR6jl/fdfS3GFmpGz+xQb6IS7vkLJSxIvizjipgpQGMrltv272ABsHfb9YCkh/QwJRJIGkivI2MlOeFpFk6uA2a7KV0iJMdF657evFtxdHSi5WUU6fH4EIC7KtutWiNDxbS0SG+52NfrbQen/tHjTpTga7zfHMwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=Y7PiUUfk; arc=none smtp.client-ip=178.154.239.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:1ba8:0:640:1638:0])
	by forward500b.mail.yandex.net (Yandex) with ESMTPS id 48623C10F2;
	Tue, 21 Oct 2025 22:36:30 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id NacLXP4R7qM0-90ID0sod;
	Tue, 21 Oct 2025 22:36:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1761075389;
	bh=k8bA4+TKeLiyStyiCxAgIP8Qak5Le/08vM/x7MqG1kQ=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=Y7PiUUfkUrK5IeD/sEEPyok1JtXbfxwOIaw7D31S9U29PPEmUEkC0ldVKbKIYaPZ7
	 xbtnFR9Zmb+fLTFgfCKzrEBh1qpW21TZn4JTAzGoX3fVY4WfYnJgp3x69gIgP+XuV/
	 4kClmfW5uV7W8vgPG94ECfRBwoKwgNISIDU80IdE=
Authentication-Results: mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Tue, 21 Oct 2025 22:36:21 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 lossin@kernel.org, lyude@redhat.com, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 dakr@kernel.org, peterz@infradead.org, mingo@redhat.com, will@kernel.org,
 longman@redhat.com, felipe_life@live.com, daniel@sedlak.dev,
 bjorn3_gh@protonmail.com
Subject: Re: [PATCH v6 6/7] rust: ww_mutex/exec: add high-level API
Message-ID: <20251021223621.46a12324@nimda.home>
In-Reply-To: <20250907113817.768acf3d@nimda.home>
References: <20250903131313.4365-1-work@onurozkan.dev>
	<20250903131313.4365-7-work@onurozkan.dev>
	<6D30FEF7-07E7-4851-A7A2-76649AD0B217@collabora.com>
	<20250906141310.2c29aa8e@nimda.home>
	<2B16DBF4-1F6C-4025-8373-5651867B7D49@collabora.com>
	<20250907112006.6bdbb478@nimda.home>
	<20250907113817.768acf3d@nimda.home>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 7 Sep 2025 11:38:17 +0300
Onur <work@onurozkan.dev> wrote:

> On Sun, 7 Sep 2025 11:20:06 +0300
> Onur <work@onurozkan.dev> wrote:
>=20
> > On Sat, 6 Sep 2025 12:04:34 -0300
> > Daniel Almeida <daniel.almeida@collabora.com> wrote:
> >=20
> > >=20
> > >=20
> > > > On 6 Sep 2025, at 08:13, Onur <work@onurozkan.dev> wrote:
> > > >=20
> > > > On Fri, 5 Sep 2025 16:42:09 -0300
> > > > Daniel Almeida <daniel.almeida@collabora.com> wrote:
> > > >=20
> > > >> Hi Onur,
> > > >>=20
> > > >>> On 3 Sep 2025, at 10:13, Onur =C3=96zkan <work@onurozkan.dev>
> > > >>> wrote:
> > > >>>=20
> > > >>> `ExecContext` is a helper built on top of ww_mutex
> > > >>=20
> > > >> Again, I wonder what people think about this particular name.
> > > >>=20
> > > >>> that provides a retrying interface for lock acquisition.
> > > >>> When `EDEADLK` is hit, it drops all held locks, resets
> > > >>> the acquire context and retries the given (by the user)
> > > >>> locking algorithm until it succeeds.
> > > >>>=20
> > > >>> The API keeps track of acquired locks, cleans them up
> > > >>> automatically and allows data access to the protected
> > > >>> data through `with_locked()`. The `lock_all()` helper
> > > >>> allows implementing multi-mutex algorithms in a simpler
> > > >>> and less error-prone way while keeping the ww_mutex
> > > >>> semantics.
> > > >>>=20
> > > >>=20
> > > >> Great, this was exactly what I was looking for! :)
> > > >>=20
> > > >>> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> > > >>> ---
> > > >>> rust/kernel/sync/lock/ww_mutex.rs      |   2 +
> > > >>> rust/kernel/sync/lock/ww_mutex/exec.rs | 176
> > > >>> +++++++++++++++++++++++++ 2 files changed, 178 insertions(+)
> > > >>> create mode 100644 rust/kernel/sync/lock/ww_mutex/exec.rs
> > > >>>=20
> > > >>> diff --git a/rust/kernel/sync/lock/ww_mutex.rs
> > > >>> b/rust/kernel/sync/lock/ww_mutex.rs index
> > > >>> b415d6deae9b..7de6578513e5 100644 ---
> > > >>> a/rust/kernel/sync/lock/ww_mutex.rs +++
> > > >>> b/rust/kernel/sync/lock/ww_mutex.rs @@ -16,6 +16,8 @@
> > > >>> use core::cell::UnsafeCell;
> > > >>> use core::marker::PhantomData;
> > > >>>=20
> > > >>> +pub mod exec;
> > > >>> +
> > > >>> /// Create static [`WwClass`] instances.
> > > >>> ///
> > > >>> /// # Examples
> > > >>> diff --git a/rust/kernel/sync/lock/ww_mutex/exec.rs
> > > >>> b/rust/kernel/sync/lock/ww_mutex/exec.rs new file mode 100644
> > > >>> index 000000000000..2f1fc540f0b8
> > > >>> --- /dev/null
> > > >>> +++ b/rust/kernel/sync/lock/ww_mutex/exec.rs
> > > >>> @@ -0,0 +1,176 @@
> > > >>> +// SPDX-License-Identifier: GPL-2.0
> > > >>> +
> > > >>> +//! A high-level [`WwMutex`] execution helper.
> > > >>> +//!
> > > >>> +//! Provides a retrying lock mechanism on top of [`WwMutex`]
> > > >>> and [`WwAcquireCtx`]. +//! It detects [`EDEADLK`] and handles
> > > >>> it by rolling back and retrying the +//! user-supplied locking
> > > >>> algorithm until success. +
> > > >>> +use crate::prelude::*;
> > > >>> +use crate::sync::lock::ww_mutex::{WwAcquireCtx, WwClass,
> > > >>> WwMutex, WwMutexGuard}; +use core::ptr;
> > > >>> +
> > > >>> +/// High-level execution type for ww_mutex.
> > > >>> +///
> > > >>> +/// Tracks a series of locks acquired under a common
> > > >>> [`WwAcquireCtx`]. +/// It ensures proper cleanup and retry
> > > >>> mechanism on deadlocks and provides +/// type-safe access to
> > > >>> locked data via [`with_locked`]. +///
> > > >>> +/// Typical usage is through [`lock_all`], which retries a
> > > >>> user-supplied +/// locking algorithm until it succeeds without
> > > >>> deadlock. +pub struct ExecContext<'a> {
> > > >>> +    class: &'a WwClass,
> > > >>> +    acquire: Pin<KBox<WwAcquireCtx<'a>>>,
> > > >>> +    taken: KVec<WwMutexGuard<'a, ()>>,
> > > >>> +}
> > > >>> +
> > > >>> +impl<'a> Drop for ExecContext<'a> {
> > > >>> +    fn drop(&mut self) {
> > > >>> +        self.release_all_locks();
> > > >>=20
> > > >> If we move this to the acquire context, then we can do away
> > > >> with this drop impl.
> > > >>=20
> > > >>> +    }
> > > >>> +}
> > > >>> +
> > > >>> +impl<'a> ExecContext<'a> {
> > > >>> +    /// Creates a new [`ExecContext`] for the given lock
> > > >>> class.
> > > >>> +    ///
> > > >>> +    /// All locks taken through this context must belong to
> > > >>> the same class.
> > > >>> +    ///
> > > >>> +    /// TODO: Add some safety mechanism to ensure classes are
> > > >>> not different.
> > > >>=20
> > > >> core::ptr::eq()?
> > > >>=20
> > > >=20
> > > > I was thinking more of a type-level mechanism to do ensure that.
> > >=20
> > > Why?
> > >=20
> >=20
> > So that wait-wound and wait-die classes don't get mixed up in the
> > same `ExecContext` by using type validation at compile time.
> >=20
> > Of course, `core::ptr::eq()` is still useful/required when the
> > classes are of the same type but not exactly the same value. Maybe
> > we can do both.
> >=20
> >=20
> > Thanks,
> > Onur
>=20
> I will also look into whether it's possible to remove the class from
> the mutex and instead derive it from ExecContext and WwAcquireCtx.
> This would fix both issues at once in a better way.

This is not possible due to limitations in the C implementation. :(

A mutex must be initialized with a specific class (or without one if
it's just a regular mutex) and this cannot be changed later.

I noted this to revisit the C side and see if we can make this possible
in the future (once this patch has landed).

Regards,
Onur

>=20
>  -Onur=20
>=20

