Return-Path: <linux-kernel+bounces-845925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD45BC682B
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 21:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 178CD3AA5A7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 19:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50019274B5E;
	Wed,  8 Oct 2025 19:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="iTHDHS8m"
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5C626F29F;
	Wed,  8 Oct 2025 19:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759953419; cv=none; b=s+O2WGTZ7a3m1fO8H6x3jS0lfIIik7TnnvbBal0w8wby17N8ak80LleMWWJxmhdJVE5wseH/72wiTb4OowtwVFXfSqlGDukr6ZYhUbc5YtBbm9krL+jlTjmR5FXAM+3QFiy01bKF2dMWUp6QCMc9cysmwGlosNAi+zISZ7jqLbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759953419; c=relaxed/simple;
	bh=Jo/AvdmTyo5vFa2A2QkL6eEnnecQrA3Fv545ir6Qgfg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fC1o5ing87jnn+DAEL01AedNC6o5AuZs5aV4iM0yCgxr3tvDUkobKBWGeqAsfL5ZMDUWPFQ3vcPXoIUcRfjh6GSBgq1yj3Ax7BvQ5ExOvI13VzSYpwYYqG9a/9+dkzeQIygm0Ca3ilPplCZyY6wTJDiWCHpZDcSx2NuvAQugdMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=iTHDHS8m; arc=none smtp.client-ip=178.154.239.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:942:0:640:e3c0:0])
	by forward500b.mail.yandex.net (Yandex) with ESMTPS id A4C8FC16BA;
	Wed, 08 Oct 2025 22:50:12 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 4osbeDSLxuQ0-JRjQwJ60;
	Wed, 08 Oct 2025 22:50:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1759953011;
	bh=aidSHiomRyJ68d+Z7mwP/WOC8Nu++7GfxKmsEuxZL0Y=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=iTHDHS8m61dQbStfx6p7wgmXgY37iaY49Yi7jcclZCiCiWYsj37RvbH4iSZ0kMKA9
	 0XXHakq9hDleSRtOQGrdRMTOLt4xS0rmUKwKMHavZb2LKF5rF1/+wkp8j1uT2r706Y
	 gIr2DhgWkcl9o6qepF7aKUUjeF689xNkFupAVRHM=
Authentication-Results: mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Wed, 8 Oct 2025 22:50:02 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: Tamir Duberstein <tamird@gmail.com>
Cc: rust-for-linux@vger.kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 dakr@kernel.org, linux-kernel@vger.kernel.org, acourbot@nvidia.com,
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, corbet@lwn.net, lyude@redhat.com,
 linux-doc@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/4] rust: xarray: abstract `xa_alloc`
Message-ID: <20251008225002.011378ed@nimda.home>
In-Reply-To: <CAJ-ks9mtfVmP+SwZvBVuQSwViiqo2ZngSGQuU5Y7A-Q_JSwjKQ@mail.gmail.com>
References: <20251008124619.3160-1-work@onurozkan.dev>
	<20251008124619.3160-3-work@onurozkan.dev>
	<CAJ-ks9mtfVmP+SwZvBVuQSwViiqo2ZngSGQuU5Y7A-Q_JSwjKQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 8 Oct 2025 09:59:12 -0700
Tamir Duberstein <tamird@gmail.com> wrote:

> On Wed, Oct 8, 2025 at 6:05=E2=80=AFAM Onur =C3=96zkan <work@onurozkan.de=
v> wrote:
> >
> > Implements `alloc` function to `XArray<T>` that wraps
> > `xa_alloc` safely, which will be used to generate the
> > auxiliary device IDs.
> >
> > Resolves a task from the nova/core task list under the "XArray
> > bindings [XARR]" section in "Documentation/gpu/nova/core/todo.rst"
> > file.
> >
> > Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> > ---
> >  rust/kernel/xarray.rs | 41
> > ++++++++++++++++++++++++++++++++++++++++- 1 file changed, 40
> > insertions(+), 1 deletion(-)
> >
> > diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
> > index 90e27cd5197e..0711ccf99fb4 100644
> > --- a/rust/kernel/xarray.rs
> > +++ b/rust/kernel/xarray.rs
> > @@ -10,7 +10,7 @@
> >      ffi::c_void,
> >      types::{ForeignOwnable, NotThreadSafe, Opaque},
> >  };
> > -use core::{iter, marker::PhantomData, pin::Pin, ptr::NonNull};
> > +use core::{iter, marker::PhantomData, ops::Range, pin::Pin,
> > ptr::NonNull}; use pin_init::{pin_data, pin_init, pinned_drop,
> > PinInit};
> >
> >  /// An array which efficiently maps sparse integer indices to
> > owned objects. @@ -268,6 +268,45 @@ pub fn store(
> >              Ok(unsafe { T::try_from_foreign(old) })
> >          }
> >      }
> > +
> > +    /// Allocates an empty slot within the given `limit` and
> > stores `value` there.
> > +    ///
> > +    /// May drop the lock if needed to allocate memory, and then
> > reacquire it afterwards.
> > +    ///
> > +    /// On success, returns the allocated index.
>=20
> Returning the index is not a very good abstraction. Would the
> reservation API meet your needs?
>=20
> https://lore.kernel.org/all/20250713-xarray-insert-reserve-v2-3-b93964580=
8a2@gmail.com/
>=20
> If yes, I would appreciate your tags there.

It should be "allocated key", I misdocumented it. I don't have a
use-case for this implementation, I am just trying to help on the nova
task list:
    https://docs.kernel.org/gpu/nova/core/todo.html#xarray-bindings-xarr

The task mentions "generate the auxiliary device IDs", which should be
the returned key, right?

There is also this reference [1] that shows that the returned key will
be useful.

[1]: https://lore.kernel.org/all/aOTyVzpJNDOaxxs6@google.com/

Regards,
Onur

