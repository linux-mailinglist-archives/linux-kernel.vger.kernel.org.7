Return-Path: <linux-kernel+bounces-846251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 836B3BC7630
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 06:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08DDE188CDA6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 04:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC72225C81F;
	Thu,  9 Oct 2025 04:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="U5E/xReg"
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEDF25B311;
	Thu,  9 Oct 2025 04:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759985469; cv=none; b=aQv60g0hKpxs7dHEbxb4Uan0EzSe9gkAD9jIODPXJbdw+Xf028O0aC0MWzQcSYu5g6k8hA29Zq/8E95Org3nBOhvItzJ3roDmY+VW5lLJUJK1r4h+yDW2lIiqBj1sf+VrTx8BLl2fyIbXoy97XR1Ewy/qOiH9tplPMDlmec9stA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759985469; c=relaxed/simple;
	bh=dD23wYGJzstpufoWQ8iaFldvkDkCluDlE4wFbI0oCOU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l1QdwdgbONP4L5AzoxlAfl5I8O8Y65P8wtpJyaSLfdHGnCR4FgSKq8kZ3Vvo1UfpIIerUD/jaEQFq0NZ8ICEhbZOmQwoinc2UrxKCrClQshHg81Ts1wERDZ31Xck79PRwgTmN55TkWtfjgJFjwS6xEhHg3ydK/dC/UiiKCylp3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=U5E/xReg; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:1311:0:640:df31:0])
	by forward500a.mail.yandex.net (Yandex) with ESMTPS id 6B5DA81AA4;
	Thu, 09 Oct 2025 07:51:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id uoB8DgVLPGk0-JyaASLja;
	Thu, 09 Oct 2025 07:51:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1759985461;
	bh=dd0xy8YVEGEJYa0deBqYb5TfXlH/zF7B3uABe0y3qUI=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=U5E/xRegcJD26gARSedDkHL71OVqDPD3OboEiPavvJuUUo1HWMap3/vcMEm17JiZ9
	 OUtCaS3TcHjuLC+pz6wc4no/Nwz/qbZ3rqnVSaWPpYydq2xxssH0ML1fxG3xsYD20N
	 26/6EAKblaYEFC8qnx0nFndDgLvGixd99of6T3cw=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Thu, 9 Oct 2025 07:50:54 +0300
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
Message-ID: <20251009075054.7ed640c0@nimda.home>
In-Reply-To: <CAJ-ks9nMziN2LU=T=XGhV8xau6UfGXOMZ49+2Lrt8KGbL7Qngg@mail.gmail.com>
References: <20251008124619.3160-1-work@onurozkan.dev>
	<20251008124619.3160-3-work@onurozkan.dev>
	<CAJ-ks9mtfVmP+SwZvBVuQSwViiqo2ZngSGQuU5Y7A-Q_JSwjKQ@mail.gmail.com>
	<20251008225002.011378ed@nimda.home>
	<CAJ-ks9nMziN2LU=T=XGhV8xau6UfGXOMZ49+2Lrt8KGbL7Qngg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 8 Oct 2025 13:45:53 -0700
Tamir Duberstein <tamird@gmail.com> wrote:

> On Wed, Oct 8, 2025 at 12:50=E2=80=AFPM Onur =C3=96zkan <work@onurozkan.d=
ev> wrote:
> >
> > On Wed, 8 Oct 2025 09:59:12 -0700
> > Tamir Duberstein <tamird@gmail.com> wrote:
> >
> > > On Wed, Oct 8, 2025 at 6:05=E2=80=AFAM Onur =C3=96zkan <work@onurozka=
n.dev>
> > > wrote:
> > > >
> > > > Implements `alloc` function to `XArray<T>` that wraps
> > > > `xa_alloc` safely, which will be used to generate the
> > > > auxiliary device IDs.
> > > >
> > > > Resolves a task from the nova/core task list under the "XArray
> > > > bindings [XARR]" section in
> > > > "Documentation/gpu/nova/core/todo.rst" file.
> > > >
> > > > Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> > > > ---
> > > >  rust/kernel/xarray.rs | 41
> > > > ++++++++++++++++++++++++++++++++++++++++- 1 file changed, 40
> > > > insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
> > > > index 90e27cd5197e..0711ccf99fb4 100644
> > > > --- a/rust/kernel/xarray.rs
> > > > +++ b/rust/kernel/xarray.rs
> > > > @@ -10,7 +10,7 @@
> > > >      ffi::c_void,
> > > >      types::{ForeignOwnable, NotThreadSafe, Opaque},
> > > >  };
> > > > -use core::{iter, marker::PhantomData, pin::Pin, ptr::NonNull};
> > > > +use core::{iter, marker::PhantomData, ops::Range, pin::Pin,
> > > > ptr::NonNull}; use pin_init::{pin_data, pin_init, pinned_drop,
> > > > PinInit};
> > > >
> > > >  /// An array which efficiently maps sparse integer indices to
> > > > owned objects. @@ -268,6 +268,45 @@ pub fn store(
> > > >              Ok(unsafe { T::try_from_foreign(old) })
> > > >          }
> > > >      }
> > > > +
> > > > +    /// Allocates an empty slot within the given `limit` and
> > > > stores `value` there.
> > > > +    ///
> > > > +    /// May drop the lock if needed to allocate memory, and
> > > > then reacquire it afterwards.
> > > > +    ///
> > > > +    /// On success, returns the allocated index.
> > >
> > > Returning the index is not a very good abstraction. Would the
> > > reservation API meet your needs?
> > >
> > > https://lore.kernel.org/all/20250713-xarray-insert-reserve-v2-3-b9396=
45808a2@gmail.com/
> > >
> > > If yes, I would appreciate your tags there.
> >
> > It should be "allocated key", I misdocumented it. I don't have a
> > use-case for this implementation, I am just trying to help on the
> > nova task list:
> >     https://docs.kernel.org/gpu/nova/core/todo.html#xarray-bindings-xarr
>=20
> I think implementing things without understanding the use-case is a
> good way to build the wrong thing.
>=20

I was thinking I would get some review notes from people who actually
need this if something wasn't right. Maybe Alexandre can clarify what
the expected outcome was, since he created the task.

Onur

> > The task mentions "generate the auxiliary device IDs", which should
> > be the returned key, right?
>=20
> I dunno.
>=20
> > There is also this reference [1] that shows that the returned key
> > will be useful.
> >
> > [1]: https://lore.kernel.org/all/aOTyVzpJNDOaxxs6@google.com/
>=20
> Sure, it's useful - the reservation API also exposes it. But it is not
> a proper abstraction.
>=20
> Cheers.
>=20
> Tamir


