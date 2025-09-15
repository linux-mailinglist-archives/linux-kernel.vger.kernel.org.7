Return-Path: <linux-kernel+bounces-816245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D996B5717D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22696188418F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A81F2D5A14;
	Mon, 15 Sep 2025 07:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="h6sEUr+M"
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30AD2D46AF;
	Mon, 15 Sep 2025 07:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757921376; cv=none; b=OVofeJ54TL6hZqPJcLMb6UUInVmFo4fkBSsa4LW/bB4ieijQYK+FbOvjD2jV8iSPUW23ogyZeHK3FB5/NxYpK2CcxtU0Z1I6nn1JmIGqUmwaBe+tipinjq62EhK29hrb2K0l3/I5Vslun9fkNXLng9r1C25X84p4wojdAAbKyQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757921376; c=relaxed/simple;
	bh=AZYff6B2X5xOnw0ElaH3FMka5USkGbkAnFbdjeSa91Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QAklTr5/+0o3Bw7Wxul2cL2f2u6RyAjFh1RTGAA+rakU5hODj2pj3/aG45pYsA3rKkgpkuMvw44RrUH31gae0WAtVN87gRFGhqliqQ2Q0CsI36F/xZ/4sPkHBeillPQBn80scp0Y9E/hoW+kQSAH0g/GSXHquXEpLDVyu2ynQig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=h6sEUr+M; arc=none smtp.client-ip=178.154.239.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net [IPv6:2a02:6b8:c22:d15:0:640:4031:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTPS id 2EEA380BEF;
	Mon, 15 Sep 2025 10:29:24 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JTJ3WYuMoqM0-O6cwJvSH;
	Mon, 15 Sep 2025 10:29:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1757921363;
	bh=VJqdXxD+DK6pXojKHstsCLjPvzxSY7UrQTBYHRfeZH4=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=h6sEUr+MaBrBzJfoNLV6+NqdVg1R+3PIwX9udRVNdNU1HMpejFCWW/hL5O27l3htb
	 BzIWGXGT0KFloZBdgevqgcxvKasRzl/7RWJRj1dWKBJEyPE47C4N1eaG1uxUV0pdt5
	 Jc6gR4HsyAHLAafnh2jXDkCw7IHuD8VFqBSmnxSo=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Mon, 15 Sep 2025 10:29:18 +0300
From: Onur <work@onurozkan.dev>
To: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
 dakr@kernel.org, tamird@gmail.com, daniel@sedlak.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: less allocation in CString::try_from
Message-ID: <20250915102918.77adc04a@nimda.home>
In-Reply-To: <CAH5fLgi-VrhDSEjJA4Bg+5Wmr2JDAmmOc1FkfZAZ29SMqkX++w@mail.gmail.com>
References: <20250915065401.20141-1-work@onurozkan.dev>
	<CAH5fLgi-VrhDSEjJA4Bg+5Wmr2JDAmmOc1FkfZAZ29SMqkX++w@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Sep 2025 09:26:00 +0200
Alice Ryhl <aliceryhl@google.com> wrote:

> On Mon, Sep 15, 2025 at 8:54=E2=80=AFAM Onur =C3=96zkan <work@onurozkan.d=
ev> wrote:
> >
> > Allocates buffer with the correct capacity upfront by
> > using the length of the `CStr` to avoid extra and unnecessary
> > re-allocation when converting from `CStr` to `CString`.
> >
> > Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> > ---
> >  rust/kernel/str.rs | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> > index 6c892550c0ba..98d41d995e45 100644
> > --- a/rust/kernel/str.rs
> > +++ b/rust/kernel/str.rs
> > @@ -946,9 +946,10 @@ impl<'a> TryFrom<&'a CStr> for CString {
> >      type Error =3D AllocError;
> >
> >      fn try_from(cstr: &'a CStr) -> Result<CString, AllocError> {
> > -        let mut buf =3D KVec::new();
> > +        let bytes =3D cstr.to_bytes_with_nul();
> >
> > -        buf.extend_from_slice(cstr.to_bytes_with_nul(),
> > GFP_KERNEL)?;
> > +        let mut buf =3D KVec::with_capacity(bytes.len(),
> > GFP_KERNEL)?;
> > +        buf.extend_from_slice(bytes, GFP_KERNEL)?;
>=20
> I don't think this changes the number of allocations. KVec::new() does
> not allocate.
>=20
> Alice

Good to know, thanks!

Onur

