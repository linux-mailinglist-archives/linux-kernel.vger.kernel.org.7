Return-Path: <linux-kernel+bounces-804564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6F8B479D6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 10:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE37B20182C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 08:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B7721CA02;
	Sun,  7 Sep 2025 08:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="Z0B8A6Nt"
Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF02118EAB;
	Sun,  7 Sep 2025 08:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757234624; cv=none; b=UKcNP2tOjKnhLvuEb96us3U1Y8sBDH+FIjoDznmYCm4UpxXMs8iTmmr8goLbQpyEkVeAEfDek0a/6adsMGc5oNJPQKul+n84plfZD8uP8zqy/fvveNHu/i0xkJjFf57jJfCp/ufoq7hA16jN12Cqi7rwVw79FOuLdRiLb1oiKhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757234624; c=relaxed/simple;
	bh=rDgGdEgB5A7k9qddy1JKxSM/owkiMEXnT3pIHNXpXO8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d3VetIg16XWYMpXUH3ePlTbuU+lHuZq1PVnPwqNubDm9lR+NHi01hW97kN4Ope/AthHEhNmatwKxmuiQMRCAYFZJnmRRzVlYU2+OD7fEu0JEX+pH9TaF+EVla7HIEr5t9fGkUL2cWs0+xqDA2C741Vj9gg+ATevv0rF9JUtVj5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=Z0B8A6Nt; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:4720:0:640:9548:0])
	by forward502d.mail.yandex.net (Yandex) with ESMTPS id 9EFA5C0A8F;
	Sun, 07 Sep 2025 11:38:23 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id HcfaraXMqqM0-M3gFR5Jm;
	Sun, 07 Sep 2025 11:38:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1757234302;
	bh=sr1v7CnmN+LAWW7mBJAZyqFsgNPJVxqWyr//sA/8lI8=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=Z0B8A6NtXX6W0nPzOYO8mM66ueVGMVI+KH7EMbJKLtBE715ivmgh2ASlw+VWFEAE6
	 ofH/Q/CR/I8oytEFLFC7vvZi/vQ/A7iiq+vqplzthvGII+o0Wy7M+aJjRoIRoQD7iA
	 5jZOYl0yk9ra3mIM9opFjJW7X6IeVTPI33HTQB1A=
Authentication-Results: mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Sun, 7 Sep 2025 11:38:17 +0300
From: Onur <work@onurozkan.dev>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 lossin@kernel.org, lyude@redhat.com, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 dakr@kernel.org, peterz@infradead.org, mingo@redhat.com, will@kernel.org,
 longman@redhat.com, felipe_life@live.com, daniel@sedlak.dev,
 bjorn3_gh@protonmail.com
Subject: Re: [PATCH v6 6/7] rust: ww_mutex/exec: add high-level API
Message-ID: <20250907113817.768acf3d@nimda.home>
In-Reply-To: <20250907112006.6bdbb478@nimda.home>
References: <20250903131313.4365-1-work@onurozkan.dev>
	<20250903131313.4365-7-work@onurozkan.dev>
	<6D30FEF7-07E7-4851-A7A2-76649AD0B217@collabora.com>
	<20250906141310.2c29aa8e@nimda.home>
	<2B16DBF4-1F6C-4025-8373-5651867B7D49@collabora.com>
	<20250907112006.6bdbb478@nimda.home>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 7 Sep 2025 11:20:06 +0300
Onur <work@onurozkan.dev> wrote:

> On Sat, 6 Sep 2025 12:04:34 -0300
> Daniel Almeida <daniel.almeida@collabora.com> wrote:
>=20
> >=20
> >=20
> > > On 6 Sep 2025, at 08:13, Onur <work@onurozkan.dev> wrote:
> > >=20
> > > On Fri, 5 Sep 2025 16:42:09 -0300
> > > Daniel Almeida <daniel.almeida@collabora.com> wrote:
> > >=20
> > >> Hi Onur,
> > >>=20
> > >>> On 3 Sep 2025, at 10:13, Onur =C3=96zkan <work@onurozkan.dev> wrote:
> > >>>=20
> > >>> `ExecContext` is a helper built on top of ww_mutex
> > >>=20
> > >> Again, I wonder what people think about this particular name.
> > >>=20
> > >>> that provides a retrying interface for lock acquisition.
> > >>> When `EDEADLK` is hit, it drops all held locks, resets
> > >>> the acquire context and retries the given (by the user)
> > >>> locking algorithm until it succeeds.
> > >>>=20
> > >>> The API keeps track of acquired locks, cleans them up
> > >>> automatically and allows data access to the protected
> > >>> data through `with_locked()`. The `lock_all()` helper
> > >>> allows implementing multi-mutex algorithms in a simpler
> > >>> and less error-prone way while keeping the ww_mutex
> > >>> semantics.
> > >>>=20
> > >>=20
> > >> Great, this was exactly what I was looking for! :)
> > >>=20
> > >>> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> > >>> ---
> > >>> rust/kernel/sync/lock/ww_mutex.rs      |   2 +
> > >>> rust/kernel/sync/lock/ww_mutex/exec.rs | 176
> > >>> +++++++++++++++++++++++++ 2 files changed, 178 insertions(+)
> > >>> create mode 100644 rust/kernel/sync/lock/ww_mutex/exec.rs
> > >>>=20
> > >>> diff --git a/rust/kernel/sync/lock/ww_mutex.rs
> > >>> b/rust/kernel/sync/lock/ww_mutex.rs index
> > >>> b415d6deae9b..7de6578513e5 100644 ---
> > >>> a/rust/kernel/sync/lock/ww_mutex.rs +++
> > >>> b/rust/kernel/sync/lock/ww_mutex.rs @@ -16,6 +16,8 @@
> > >>> use core::cell::UnsafeCell;
> > >>> use core::marker::PhantomData;
> > >>>=20
> > >>> +pub mod exec;
> > >>> +
> > >>> /// Create static [`WwClass`] instances.
> > >>> ///
> > >>> /// # Examples
> > >>> diff --git a/rust/kernel/sync/lock/ww_mutex/exec.rs
> > >>> b/rust/kernel/sync/lock/ww_mutex/exec.rs new file mode 100644
> > >>> index 000000000000..2f1fc540f0b8
> > >>> --- /dev/null
> > >>> +++ b/rust/kernel/sync/lock/ww_mutex/exec.rs
> > >>> @@ -0,0 +1,176 @@
> > >>> +// SPDX-License-Identifier: GPL-2.0
> > >>> +
> > >>> +//! A high-level [`WwMutex`] execution helper.
> > >>> +//!
> > >>> +//! Provides a retrying lock mechanism on top of [`WwMutex`]
> > >>> and [`WwAcquireCtx`]. +//! It detects [`EDEADLK`] and handles
> > >>> it by rolling back and retrying the +//! user-supplied locking
> > >>> algorithm until success. +
> > >>> +use crate::prelude::*;
> > >>> +use crate::sync::lock::ww_mutex::{WwAcquireCtx, WwClass,
> > >>> WwMutex, WwMutexGuard}; +use core::ptr;
> > >>> +
> > >>> +/// High-level execution type for ww_mutex.
> > >>> +///
> > >>> +/// Tracks a series of locks acquired under a common
> > >>> [`WwAcquireCtx`]. +/// It ensures proper cleanup and retry
> > >>> mechanism on deadlocks and provides +/// type-safe access to
> > >>> locked data via [`with_locked`]. +///
> > >>> +/// Typical usage is through [`lock_all`], which retries a
> > >>> user-supplied +/// locking algorithm until it succeeds without
> > >>> deadlock. +pub struct ExecContext<'a> {
> > >>> +    class: &'a WwClass,
> > >>> +    acquire: Pin<KBox<WwAcquireCtx<'a>>>,
> > >>> +    taken: KVec<WwMutexGuard<'a, ()>>,
> > >>> +}
> > >>> +
> > >>> +impl<'a> Drop for ExecContext<'a> {
> > >>> +    fn drop(&mut self) {
> > >>> +        self.release_all_locks();
> > >>=20
> > >> If we move this to the acquire context, then we can do away with
> > >> this drop impl.
> > >>=20
> > >>> +    }
> > >>> +}
> > >>> +
> > >>> +impl<'a> ExecContext<'a> {
> > >>> +    /// Creates a new [`ExecContext`] for the given lock class.
> > >>> +    ///
> > >>> +    /// All locks taken through this context must belong to the
> > >>> same class.
> > >>> +    ///
> > >>> +    /// TODO: Add some safety mechanism to ensure classes are
> > >>> not different.
> > >>=20
> > >> core::ptr::eq()?
> > >>=20
> > >=20
> > > I was thinking more of a type-level mechanism to do ensure that.
> >=20
> > Why?
> >=20
>=20
> So that wait-wound and wait-die classes don't get mixed up in the
> same `ExecContext` by using type validation at compile time.
>=20
> Of course, `core::ptr::eq()` is still useful/required when the classes
> are of the same type but not exactly the same value. Maybe we can do
> both.
>=20
>=20
> Thanks,
> Onur

I will also look into whether it's possible to remove the class from the
mutex and instead derive it from ExecContext and WwAcquireCtx. This
would fix both issues at once in a better way.

 -Onur=20

