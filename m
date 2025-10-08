Return-Path: <linux-kernel+bounces-845506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2481ABC5319
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 15:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D55401886
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 13:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E1D2848AF;
	Wed,  8 Oct 2025 13:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="oIcsj5TS"
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [178.154.239.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBC81F12E9;
	Wed,  8 Oct 2025 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759930063; cv=none; b=Ylyi2fvxTM/6rKWXvyECgtuyv4KSr6/MPPMCUPiSazwNOBRH7A8HiUfIqfCIaKhK+GZFV4/a5Iyp2TDwfXWo3ueifsUwLZkCELwWIAioN+fsCqCLuinDLTG7ipHnMgDo8kNapbTPvWew8rcvtTOuUEwsAcpqO999wyQ5MnI1Epk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759930063; c=relaxed/simple;
	bh=48tBRZ4UObr9hdBTbxUPKO25q+0h3XVgD5hTqQX+b10=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NonTau2CEY1oMOmWKiwzh88Jh4kQdXzFhZD6UsNaLrMd6pbVXPKYxsJzUFOvraRX2p7cV/qv+TjR9R4X3PCiyb/4/18N7lrAYhHbcSC2oinOOa0HFweMAG5h9X/DVk9y4zzDefDNgmBvscZCBrobpeD9PwTanzdx7LHXKXx2K2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=oIcsj5TS; arc=none smtp.client-ip=178.154.239.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:2908:0:640:b877:0])
	by forward502b.mail.yandex.net (Yandex) with ESMTPS id 7CA2481A79;
	Wed, 08 Oct 2025 16:22:09 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 3MmpYOILNmI0-h2DvORhn;
	Wed, 08 Oct 2025 16:22:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1759929728;
	bh=PuyYnJGb4e3zcRscqjbRMizi4amoHlbd7ZcZT1x5DhY=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=oIcsj5TSZ9PMFLRbqWRxmJ6LIdAHCf5ARsxnWQWOjyTPxakdUyXG7t70nU3XGzCCw
	 ngBtReOrO5zTPbtHBM+1Ud8GsE0Rrer/P8g4zkail6xtKbdQlYgchVdNIpfHLlrbUx
	 ETNsrbGFjJPru6hCq/CmItHZWodD36HJesFlRC2g=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Wed, 8 Oct 2025 16:22:01 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Benno Lossin <lossin@kernel.org>, rust-for-linux@vger.kernel.org,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, tmgross@umich.edu,
 dakr@kernel.org, linux-kernel@vger.kernel.org, acourbot@nvidia.com,
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, corbet@lwn.net, lyude@redhat.com,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/3] rust: xarray: abstract `xa_alloc`
Message-ID: <20251008162201.79e76046@nimda.home>
In-Reply-To: <aOZgrhsNrKpxM_PW@google.com>
References: <20251006163024.18473-1-work@onurozkan.dev>
	<20251006163024.18473-2-work@onurozkan.dev>
	<DDBHMNEIU9HJ.68MGF28IF58I@kernel.org>
	<aOTyVzpJNDOaxxs6@google.com>
	<DDCV43KW9OGL.27I8HP4TSTQ6N@kernel.org>
	<aOZgrhsNrKpxM_PW@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 8 Oct 2025 13:01:34 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> On Wed, Oct 08, 2025 at 12:18:24PM +0200, Benno Lossin wrote:
> > On Tue Oct 7, 2025 at 12:58 PM CEST, Alice Ryhl wrote:
> > > On Mon, Oct 06, 2025 at 09:31:43PM +0200, Benno Lossin wrote:
> > >> On Mon Oct 6, 2025 at 6:30 PM CEST, Onur =C3=96zkan wrote:
> > >> > Implements `alloc` function to `XArray<T>` that wraps
> > >> > `xa_alloc` safely.
> > >> >
> > >> > Resolves a task from the nova/core task list under the "XArray
> > >> > bindings [XARR]" section in
> > >> > "Documentation/gpu/nova/core/todo.rst" file.
> > >> >
> > >> > Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> > >> > ---
> > >> >  rust/kernel/xarray.rs | 39
> > >> > +++++++++++++++++++++++++++++++++++++++ 1 file changed, 39
> > >> > insertions(+)
> > >> >
> > >> > diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
> > >> > index a49d6db28845..1b882cd2f58b 100644
> > >> > --- a/rust/kernel/xarray.rs
> > >> > +++ b/rust/kernel/xarray.rs
> > >> > @@ -266,6 +266,45 @@ pub fn store(
> > >> >              Ok(unsafe { T::try_from_foreign(old) })
> > >> >          }
> > >> >      }
> > >> > +
> > >> > +    /// Allocates an empty slot within the given limit range
> > >> > and stores `value` there.
> > >> > +    ///
> > >> > +    /// May drop the lock if needed to allocate memory, and
> > >> > then reacquire it afterwards.
> > >> > +    ///
> > >> > +    /// On success, returns the allocated id.
> > >> > +    ///
> > >> > +    /// On failure, returns the element which was attempted
> > >> > to be stored.
> > >> > +    pub fn alloc(
> > >> > +        &mut self,
> > >> > +        limit: bindings::xa_limit,
> > >> > +        value: T,
> > >> > +        gfp: alloc::Flags,
> > >> > +    ) -> Result<u32, StoreError<T>> {
> > >>=20
> > >> I think it would be a good idea to make the id a newtype wrapper
> > >> around u32. Maybe not even allow users to manually construct it
> > >> or even inspect it if possible.
> > >
> > > What? People need to know what the assigned index is.
> >=20
> > The documentation says "allocated id", so I assumed that it was some
> > internal, implementation-dependent thing, not an index. In that
> > case we should change the docs instead.
>=20
> An xarray is a map from integer to pointer. The allocated id the key
> in this map. The alloc method picks the smallest unused key in a given
> range.
>=20
> Alice

Perhaps we should document it as "allocated key" or "allocated id (key)"
?

-Onur

