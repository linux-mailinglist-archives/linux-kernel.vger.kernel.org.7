Return-Path: <linux-kernel+bounces-794083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32371B3DC9B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308CF440314
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B172FB978;
	Mon,  1 Sep 2025 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hwwSNaT8"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F2F2FAC1B
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715783; cv=none; b=tcRcFkXoatiOG+p0VvrGC00VlCh9VRI8yXSxsSbe1tvrDvWICIUXUwNCe8BQpMfX5BCWCT7NXcz2RFe2wbanqXp982aMo4Odk002pmCA+L4Jsgig2He9+VLXSwdatS885rRff4HV37oH9W4v+Nkb2PYyySVqY5KTmzCiNnvuMlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715783; c=relaxed/simple;
	bh=yGTmQwopt1HdGhxa/Ad97/8uXXqeHBaz5YtUtcqQjCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tzw8XtrKJ5psdrH6t7PaCYbBbWgJxcpSCK9w/GjEWB7unLzuf9TCx9mcSo89RGn/KGf/4KDLJi4YS1vqaEsZ0YIwRdh4ct8J2LPHojvQT4m1gS5hpD/iAKPfCuIt3EOe8wnCDPCTbVvnWK6IwPYUSOzMYp/hoDerF8+d5JgwU3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hwwSNaT8; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b8b02dd14so4928365e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 01:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756715780; x=1757320580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHm6+8TqjeCNqsd1vb4l6ddQt0tZxWa+70awNp7aNXU=;
        b=hwwSNaT8/VngiRY0kRUEfhE5Ec/h0JztgogCAdECtVxHn4/yW5Xeua8HuAFpb/RqRZ
         1BS2VREhDJD+kqo8MyH66od2R9XNSShfdmV50W5wdB8sCBHUd8DqZ0Na2CEqHodbdWxJ
         CSgC/PODdxpIndyQ1ybQi5M5T/xphNuk3hg5VGwLZjbwRIHQUH6ATL9XYDKkEmvAneW9
         0RAV6RCUG/NSrFfzEpCwD8Gzyec+03LzhwF0OP7kxk1basGkMqeyj1z8A7gzF+1AHZlF
         t4j9L3eYw5wQxMASsHGX0xDUJOfsl0pC1Bm/oegYei3H5Iepx2gTzLRUT8pEjV2ckfdx
         f+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756715780; x=1757320580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHm6+8TqjeCNqsd1vb4l6ddQt0tZxWa+70awNp7aNXU=;
        b=SDl7eYAEVRLzXMuCh4JVE+WUn4/U9IjnghzXerK/MC4KCtFsrH5uvzmcBKHSE39Iue
         OovPaFeFA6gK3VXj/pzq/Q1qqDN8t9kBYOJWbIGt612lZ9SOc20nc3pvXShWI7NJrivx
         OFw4SSdlgYrv8YP9uD5qdlgOVT3jZ1gxiGDtXCqT4a8ljDVzt31atROyuCj8XUBXpS9L
         JSZ2gg5kXZHUx+8kAwy7RJixHyJQxF34hUwnOnLv3OeY7k4+ZCjdxODN6jmDXxDGsbpN
         w8aQYOa8f82fuu9OUz8ZEDKbLGx5wot6TIc8iNN27YCId05SAmmvl4jLH9Lchrd+saTt
         9XDA==
X-Forwarded-Encrypted: i=1; AJvYcCXr6B/iquk5nImRrKcLFWUpmOb8JgqI87beDKFIOy1vpnvM098maUBiLdSqXpcbM3x6tf3f8hj8hHtmrh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd8hJ9mvwJhS018oc1zQJ4jkwhNBVpZ22NjcP5QOuS19imKgmc
	0fQxkKrZJbxIfi6aMsFE7UnpVlU2yiL/ebZcgISixV7DZAKo7QSKUbMkMGw9NyXSkVI5uBtqcJv
	G72od6V2Q7wsUOXOZOp9tLfLgVc28DKoFlZRGxZW4
X-Gm-Gg: ASbGncsRCmIc00Lg+Bo+20pU8dMCkbs5BJ/V2t3VkGCt21/3dfoLKeuPLbQUnGDlABL
	BJpA1zZEwifvMbLDiseWXB9r26Y8mnaqWpR05rCUr3sf3s4XYo2UJzix62pola4yU50ETwg6uvL
	VaNort8uU5nQBuQ3OH9IOk2uD4LQpwUdTUGKS9Lsl7Rlujx42JWZZ7ZqWhHgN70YC6jIBLSoEvb
	8rqHAlvOP9Exy6TIN891xkYVHPm2WTiP6f3r9CdjorBcXN44rmSxPxmPwtZaFZK2WPyjqY1LDbK
	68dDcIdeHwc=
X-Google-Smtp-Source: AGHT+IFOyZ/K9inIYcfsBcdFd2sn+axEaovrgR1WQbNKlDCM7EkUFX8hdWD8GiWTp7Mb8lsTdSYIgKbtCsVTIIXZFIE=
X-Received: by 2002:a05:600c:8b42:b0:45b:79fd:cb3d with SMTP id
 5b1f17b1804b1-45b8558b522mr50268455e9.36.1756715779928; Mon, 01 Sep 2025
 01:36:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
 <20250822-rnull-up-v6-16-v6-6-ec65006e2f07@kernel.org> <60D09FDF-D1EB-46A0-8F76-13F98BE9C518@collabora.com>
In-Reply-To: <60D09FDF-D1EB-46A0-8F76-13F98BE9C518@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 1 Sep 2025 10:36:07 +0200
X-Gm-Features: Ac12FXwspuKkks0jeuxbZRG0FFiSi8FCXOsFN9qbGxckrqaGTXEv6cLZ9MWyrFc
Message-ID: <CAH5fLgiEi4gZtb6qProd0tXBHU-ZEs2CKCduO25w9V4ZGqgF4g@mail.gmail.com>
Subject: Re: [PATCH v6 06/18] rust: str: add `bytes_to_bool` helper function
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, Breno Leitao <leitao@debian.org>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 3:46=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
>
>
> > On 22 Aug 2025, at 09:14, Andreas Hindborg <a.hindborg@kernel.org> wrot=
e:
> >
> > Add a convenience function to convert byte slices to boolean values by
> > wrapping them in a null-terminated C string and delegating to the
> > existing `kstrtobool` function. Only considers the first two bytes of
> > the input slice, following the kernel's boolean parsing semantics.
> >
> > Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> > ---
> > rust/kernel/str.rs | 35 +++++++++++++++++++++++++++++------
> > 1 file changed, 29 insertions(+), 6 deletions(-)
> >
> > diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> > index d070c0bd86c3..b185262b4851 100644
> > --- a/rust/kernel/str.rs
> > +++ b/rust/kernel/str.rs
> > @@ -921,6 +921,20 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
> >     }
> > }
> >
> > +/// # Safety
> > +///
> > +/// - `string` must point to a null terminated string that is valid fo=
r read.
> > +unsafe fn kstrtobool_raw(string: *const u8) -> Result<bool> {
> > +    let mut result: bool =3D false;
> > +
> > +    // SAFETY:
> > +    // - By function safety requirement, `string` is a valid null-term=
inated string.
> > +    // - `result` is a valid `bool` that we own.
> > +    let ret =3D unsafe { bindings::kstrtobool(string, &mut result) };
> > +
> > +    kernel::error::to_result(ret).map(|()| result)
> > +}
> > +
> > /// Convert common user inputs into boolean values using the kernel's `=
kstrtobool` function.
> > ///
> > /// This routine returns `Ok(bool)` if the first character is one of 'Y=
yTt1NnFf0', or
> > @@ -968,13 +982,22 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
> > /// assert_eq!(kstrtobool(c_str!("2")), Err(EINVAL));
> > /// ```
> > pub fn kstrtobool(string: &CStr) -> Result<bool> {
> > -    let mut result: bool =3D false;
> > -
> > -    // SAFETY: `string` is a valid null-terminated C string, and `resu=
lt` is a valid
> > -    // pointer to a bool that we own.
> > -    let ret =3D unsafe { bindings::kstrtobool(string.as_char_ptr(), &m=
ut result) };
> > +    // SAFETY:
> > +    // - The pointer returned by `CStr::as_char_ptr` is guaranteed to =
be
> > +    //   null terminated.
> > +    // - `string` is live and thus the string is valid for read.
> > +    unsafe { kstrtobool_raw(string.as_char_ptr()) }
> > +}
> >
> > -    kernel::error::to_result(ret).map(|()| result)
> > +/// Convert `&[u8]` to `bool` by deferring to [`kernel::str::kstrtoboo=
l`].
> > +///
> > +/// Only considers at most the first two bytes of `bytes`.
> > +pub fn kstrtobool_bytes(bytes: &[u8]) -> Result<bool> {
> > +    // `ktostrbool` only considers the first two bytes of the input.
> > +    let stack_string =3D [*bytes.first().unwrap_or(&0), *bytes.get(1).=
unwrap_or(&0), 0];
>
> Can=E2=80=99t this be CStr::from_bytes_with_nul() ?
>
> This means that kstrtobool_raw could take a &CStr directly and thus not b=
e unsafe IIUC?

That's what Andreas did in the previous version. It ended up being
pretty complex because CStr::from_bytes_with_nul() requires that we
compute the length of `stack_string`, which isn't really needed here.
I recommended having a _raw method like this to avoid that complexity.
I don't think this is meaningfully more unsafe the way it is in this
patch.

Alice

