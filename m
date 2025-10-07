Return-Path: <linux-kernel+bounces-844252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA78BC161D
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4ECD19A1244
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CB42DF3D9;
	Tue,  7 Oct 2025 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="bagptNy8"
Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net [178.154.239.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0945216E1B;
	Tue,  7 Oct 2025 12:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840769; cv=none; b=aQ7EmYeIhUtYnYXwE/mLsHWQ7nEXgnZJ5LXp9chbPvjyI4uDplmgaH4EdN6Vn1ApZDVhVkTI7wRk8P8RkpHez/mnzi/gqo1qrTvbWDtWfZJD/O6fypWPexEzoZrjRMut3mV4cKfaMQJX4bCONhnGDxczcOUbgiuT5Zp4H+m8SAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840769; c=relaxed/simple;
	bh=oFy1w/DBiVHeo7r0txwpZk2/D9lOSxSb2MvCi4fT7os=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jaxvx/J3PQu31Y31Gi7bpbjpZqTwnnSenZkGsAN8Th0m3P2law7/pNxdC4OV82sJXk/i0l+85mYRJK2B1AMSW5eUl8nYzfVXw3mPRv8b7fw5hLWomSp3QQWG3Jt4V4Nf+tLJu1PZGpAwZMzNG7ULrEVwX+gAUi6iCcJ0pecNeiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=bagptNy8; arc=none smtp.client-ip=178.154.239.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:4985:0:640:840f:0])
	by forward501d.mail.yandex.net (Yandex) with ESMTPS id 9A35C819F9;
	Tue, 07 Oct 2025 15:31:52 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id kVkW8Z9LwmI0-Gnpxajx6;
	Tue, 07 Oct 2025 15:31:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1759840312;
	bh=G2/cgYV5Or3gqo3/yRdVe76JD2g/XhjsNtfRymMInok=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=bagptNy8VHfNTkff0O5HFYDh5yoFUMGQKrzlUCkx2maYAt0bnrEKmDaEBrfIM0aHh
	 DL/Ltg3oF/DXkpEQutSnHyKuse0vFp9axUc86+AywTKedjahBnlYyhipUgQ31PLTj7
	 zbjuoO0HyHi57Dd3AM+dBo64wLgyu02Ies9ZMd5Q=
Authentication-Results: mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Tue, 7 Oct 2025 15:31:45 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, tmgross@umich.edu, dakr@kernel.org,
 linux-kernel@vger.kernel.org, acourbot@nvidia.com, airlied@gmail.com,
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, corbet@lwn.net, lyude@redhat.com,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/3] rust: xarray: abstract `xa_alloc_cyclic`
Message-ID: <20251007152724.2b33a899@nimda.home>
In-Reply-To: <aOTx-Oj_VN6fVV_s@google.com>
References: <20251006163024.18473-1-work@onurozkan.dev>
	<20251006163024.18473-3-work@onurozkan.dev>
	<aOTx-Oj_VN6fVV_s@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Oct 2025 10:56:56 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> On Mon, Oct 06, 2025 at 07:30:23PM +0300, Onur =C3=96zkan wrote:
> > Implements `alloc_cyclic` function to `XArray<T>` that
> > wraps `xa_alloc_cyclic` safely.
> >=20
> > Resolves a task from the nova/core task list under the "XArray
> > bindings [XARR]" section in "Documentation/gpu/nova/core/todo.rst"
> > file.
> >=20
> > Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> > ---
> >  rust/kernel/xarray.rs | 43
> > +++++++++++++++++++++++++++++++++++++++++++ 1 file changed, 43
> > insertions(+)
> >=20
> > diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
> > index 1b882cd2f58b..4c2fdf53c7af 100644
> > --- a/rust/kernel/xarray.rs
> > +++ b/rust/kernel/xarray.rs
> > @@ -305,6 +305,49 @@ pub fn alloc(
> >=20
> >          Ok(id)
> >      }
> > +
> > +    /// Allocates an empty slot within the given `limit`, storing
> > `value` and cycling from `*next`.
> > +    ///
> > +    /// May drop the lock if needed to allocate memory, and then
> > reacquire it afterwards.
> > +    ///
> > +    /// On success, returns the allocated id.
> > +    ///
> > +    /// On failure, returns the element which was attempted to be
> > stored.
> > +    pub fn alloc_cyclic(
> > +        &mut self,
> > +        limit: bindings::xa_limit,
>=20
> Could we use a Range<u32> type or similar here? I don't think we want
> a bindings type.
>=20

Why do we not like to use the bindings type directly?


> > +        next: &mut u32,
>=20
> So this is a mutable reference because it writes `*id + 1` to next,
> taking wrap-around into account? The docs should probably explain
> that.
>=20

Sure. To be honest, I didn't really like doing this in the first place.
I can drop the mutable reference and return the next value as part of
the result to make it more idiomatic. This way, it will be easier for
the caller to use, especially for those who don't care about the next
value.

> > +        value: T,
> > +        gfp: alloc::Flags,
> > +    ) -> Result<u32, StoreError<T>> {
> > +        build_assert!(
> > +            T::FOREIGN_ALIGN >=3D 4,
> > +            "pointers stored in XArray must be 4-byte aligned"
> > +        );
>=20
> It should be enough to have this in the constructor. I don't think
> it's needed here.
>=20
> Alice

Regards,
Onur

