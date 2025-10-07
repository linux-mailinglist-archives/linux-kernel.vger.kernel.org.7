Return-Path: <linux-kernel+bounces-843758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B5CBC02CC
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 07:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED49F3B1610
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 05:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017151DE3B7;
	Tue,  7 Oct 2025 05:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="WDRxNZYP"
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net [178.154.239.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761A6155C88;
	Tue,  7 Oct 2025 05:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759813855; cv=none; b=gKxJHEa14osEU/TAMSTYRuxlrwRGkj5Ft7uXlmHMdXuSw6LaAoKohXIja3tGG+LvPRLgbbl4smbNCyakFJXgtOVga2UVM6sE5fbR8raogvqf/NAe+u/NSzFlvXUpft/WAshw8VzywDNfqATO1bsUeijsFNuZ7slMB3rkLE3Cu5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759813855; c=relaxed/simple;
	bh=nyZubcmsOsfNGGwUDZTAtRoQQSIE49OuBwTMcrmEWHc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sLMLVoQgN0vN0mVb/dMDCsJhNIqhrsMjtXaY3SsfPXQa52NWVnkxnxpB3ZfjclPgZKINZeVeujNhYR83dYaygp4mdn3WHHfoV2Xtrqy/2PJsiezRA9Y2Mj2dMgusNNxTN3U5WAL3yYsx3fTd9lxjS3P8mtLyVg/uWYO1P3qmf3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=WDRxNZYP; arc=none smtp.client-ip=178.154.239.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:4c01:0:640:9467:0])
	by forward500d.mail.yandex.net (Yandex) with ESMTPS id 6676181889;
	Tue, 07 Oct 2025 08:04:10 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 44dAxY5L5Os0-Umnz7TAb;
	Tue, 07 Oct 2025 08:04:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1759813449;
	bh=X7Bau1taqoDASnuTXeQJxMiBFaFYYp7svzSfKN8My3c=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=WDRxNZYPPjZ/Eell1GfkaTHr/ONis1vJp2C2ZKCJeLT00BXxvrwKB/d0m6t28S00P
	 4GuNY2cdu0NOlwlzJwCqr5ZNHgV68NpFSw7FzUOGn4h8vRjPDiR+hXSZZz8GHGJZV0
	 CZTqLDFNhxaTcme0OjW1R1Rsfud8VZIbIA3SPKgI=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Tue, 7 Oct 2025 08:04:02 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org,
 linux-kernel@vger.kernel.org, acourbot@nvidia.com, airlied@gmail.com,
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, corbet@lwn.net, lyude@redhat.com,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/3] rust: xarray: abstract `xa_alloc`
Message-ID: <20251007080402.1a6d19ea@nimda.home>
In-Reply-To: <aORMNreduCPSIL82@tardis-2.local>
References: <20251006163024.18473-1-work@onurozkan.dev>
	<20251006163024.18473-2-work@onurozkan.dev>
	<aORMNreduCPSIL82@tardis-2.local>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Oct 2025 16:09:42 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

> HI Onur,
>=20
> On Mon, Oct 06, 2025 at 07:30:22PM +0300, Onur =C3=96zkan wrote:
> > Implements `alloc` function to `XArray<T>` that wraps
> > `xa_alloc` safely.
> >=20
> > Resolves a task from the nova/core task list under the "XArray
> > bindings [XARR]" section in "Documentation/gpu/nova/core/todo.rst"
> > file.
> >=20
>=20
> Having this information is good, however I feel it's better if you
> explain/expand what exact the usage will be on the XArray, otherwise,
> it'll be hard for people to dig in the history and find out why we add
> this. Thanks!
>=20

Very true, thanks.

-Onur

> Regards,
> Boqun
>=20
> > Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> > ---
> >  rust/kernel/xarray.rs | 39 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >=20
> > diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
> > index a49d6db28845..1b882cd2f58b 100644
> > --- a/rust/kernel/xarray.rs
> > +++ b/rust/kernel/xarray.rs
> > @@ -266,6 +266,45 @@ pub fn store(
> >              Ok(unsafe { T::try_from_foreign(old) })
> >          }
> >      }
> > +
> > +    /// Allocates an empty slot within the given limit range and
> > stores `value` there.
> > +    ///
> > +    /// May drop the lock if needed to allocate memory, and then
> > reacquire it afterwards.
> > +    ///
> > +    /// On success, returns the allocated id.
> > +    ///
> > +    /// On failure, returns the element which was attempted to be
> > stored.
> > +    pub fn alloc(
> > +        &mut self,
> > +        limit: bindings::xa_limit,
> > +        value: T,
> > +        gfp: alloc::Flags,
> > +    ) -> Result<u32, StoreError<T>> {
> > +        build_assert!(
> > +            T::FOREIGN_ALIGN >=3D 4,
> > +            "pointers stored in XArray must be 4-byte aligned"
> > +        );
> > +
> > +        let new =3D value.into_foreign();
> > +        let mut id: u32 =3D 0;
> > +
> > +        // SAFETY:
> > +        // - `self.xa.xa` is valid by the type invariant.
> > +        // - `new` came from `T::into_foreign`.
> > +        let ret =3D
> > +            unsafe { bindings::__xa_alloc(self.xa.xa.get(), &mut
> > id, new, limit, gfp.as_raw()) }; +
> > +        if ret < 0 {
> > +            // SAFETY: `__xa_alloc` doesn't take ownership on
> > error.
> > +            let value =3D unsafe { T::from_foreign(new) };
> > +            return Err(StoreError {
> > +                value,
> > +                error: Error::from_errno(ret),
> > +            });
> > +        }
> > +
> > +        Ok(id)
> > +    }
> >  }
> >=20
> >  // SAFETY: `XArray<T>` has no shared mutable state so it is `Send`
> > iff `T` is `Send`. --
> > 2.51.0
> >=20


