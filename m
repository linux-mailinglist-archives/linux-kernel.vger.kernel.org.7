Return-Path: <linux-kernel+bounces-897238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFC5C52519
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B701534D5B1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CFA329E61;
	Wed, 12 Nov 2025 12:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mlwtMY7v"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E0530748A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762951790; cv=none; b=SjTRaMtx+KxtBClY7dGOzJm+jn2g0EtOZDcbrT3GMChmcuZuNCS842hzT6fjNHAm7w6w8KKHQFOL+0Tn/BaKoKfvWsVmcrfQHOiJf1N/drHHlOW2b8yIP8QTLm1Qn/LaKXGJGkDrDPhLt/hw4M1XCOWfcA+vJaS/YdiZkeHKiHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762951790; c=relaxed/simple;
	bh=U2nCPDVgub9kzMy0prsUD9BkRtn7QIEjv/VMM9n70Ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hWNUJUKB5e5R/xhMtepY+O6symHRemcP5c6yzOMj2CBKdS5sfJX7zrNyWgd5+yazy47H0hxWqy1hUH/VihaCaAHfj0kSh6d9f3rSfVfTQotfCj3sx0Q0NktQfn7nf+mIvXBanMh7UqtG70rk6o0DiMmZXdRWOK34Q1NBBWT5X5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mlwtMY7v; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42b32900c8bso443564f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762951787; x=1763556587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JluyTZuEy1ost+3VmBmjhG1H0YDL31io4EOh18G1QBo=;
        b=mlwtMY7vn9O4XgLtQLAuOFV8EGEJdV9e4Q5dwmAzHllzCy7IEjd2nCmU0z5ipcTqpq
         6Z34oRGsevDPrha1reaKbCyNiU44dUMwsJVT7MIg97AKLBjM5JlCuCGLUEM06xOWdU87
         9pxUyzC5ntRPl8QRieDTCYWAaX7J3dxYVg307B+reSA3h8yDTNPmHRLwedwdQpZQxQNI
         mbReYFBnJ8GFWNoQiSJbKXKx28ob13i4GRCJakau7TEfs1Y0UhYValP5yFHFrRmPxOfG
         NB09PvS6U8R0t9RAqCTVdlbO0DPJ6aHo3phZLeB+ri/deE2yurRZaojhhY8X+NCKFna4
         AQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762951787; x=1763556587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JluyTZuEy1ost+3VmBmjhG1H0YDL31io4EOh18G1QBo=;
        b=tzx6JiVtkf2E+roIaEugdzFdBH4lbpVCTSFE8k45Xf0etKTRzNTJs5SG4xL65MhD0M
         fFIgPIV7CvMhJAuPpVYyvUrW8npE38HSi1bdwlc0heg4D1A9OlanotOhlXZQCAMRD34D
         5PzzIO6y11KiW2Pn8qCkpdZ648FAwUXO5H2Jt2r706KvF8i0Dk2sIDp8/cybfKQjev4n
         2oUOe5PHykSyNJ8R0OiOoBNaVaIxlXIxVuLD5Ryhy2ViarKQikXlJUiUNTuARrYr7x8H
         V+i6JcJyg4Az04nDoYnTYlnAPspMfqWWzpg/9MzipiGziHwuTg4gDN7yr60xXEy5MMfB
         fzQA==
X-Forwarded-Encrypted: i=1; AJvYcCWKZE5DgukIYrBcc6CWUjDJ38OqhT91RRlhyTDwmjrVs36i2zXOCvUnHP5GawVHL0Nb3jamyzQdQXfpadc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUPBtZ5PvZafRPlGjS6D68NAd3j6NzfkClarMuthhawKo+ZKo+
	8EnRlDHSUbojVRauYLzQfs0a6Wo4hQcsdF0fCfKAsGtYcwe8TbFbeyFu7KzyIJjyfzUX5/Ecq0/
	nfTIxXGsF+phq2SOi+RtnGa1faJ9ZZQJZYo83d38p
X-Gm-Gg: ASbGnctlvAo/fQ9cHq9V2VBESjytaQCYeOOgQW7NGjKdu9ObyOckBQFH86m+Q8fEmNt
	CR3Z7YvyNt7trtEVWhhXD4yG64f0dbJ+5j3O97m3XWaB88xl92GtGniX1hSl61eveG1M+3sWzVe
	nVV1BvQXoe98wKqXpp367Ih1trwzps4RG3X/8wWWbHyX5RRTtsfpjnnvwV0qMBit14Tbd2SxU8t
	BKVINjzKJai7ei0Gqx51ade4ayMxsOCFtupCmjAW730SYXFVV2V+pb0B2ECtLT7dKWrsyrLKQUu
	s/LkvlGi+kAfGT8nFpYahMar+g8PbvMYUb2SFAXu9hekmI0=
X-Google-Smtp-Source: AGHT+IEX6hcBCVCZ/in8kvl8FDzHHsXIOXcK9NpB3+wH4Z36BJiEYLMz3bRVH9PF6csB3JhXsNc3R4eeabioVZCYlC4=
X-Received: by 2002:a05:6000:2888:b0:42b:3da6:6d32 with SMTP id
 ffacd0b85a97d-42b4bb94f09mr2305903f8f.23.1762951786364; Wed, 12 Nov 2025
 04:49:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110-binder-bitmap-v4-0-5ed8a7fab1b9@google.com>
 <20251110-binder-bitmap-v4-1-5ed8a7fab1b9@google.com> <CAJ-ks9kvMQ9tUMZyM07jRr8O+pJ6RRvCZodenB==tzDChhHT=A@mail.gmail.com>
 <aRH0oRU5JXKpAKpB@google.com> <aRH-ScufjvGYPx5W@yury> <aRIAp3LHs0NsEKvL@google.com>
 <aRIHPX4d_CF-wfhY@yury>
In-Reply-To: <aRIHPX4d_CF-wfhY@yury>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 12 Nov 2025 13:49:34 +0100
X-Gm-Features: AWmQ_bliX846jcbhOZ77cU5skl4FOpn5FxaWHK8FBJFEbU9xH4B1NEKznGFOltE
Message-ID: <CAH5fLgiiUafMoXhN14m3xHfL=0=YB9S7+U-QPvpOi0YZ19TDhA@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] rust: bitmap: add MAX_LEN and NO_ALLOC_MAX_LEN constants
To: Yury Norov <yury.norov@gmail.com>
Cc: Tamir Duberstein <tamird@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Burak Emir <bqe@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 4:39=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> On Mon, Nov 10, 2025 at 03:11:35PM +0000, Alice Ryhl wrote:
> > On Mon, Nov 10, 2025 at 10:01:29AM -0500, Yury Norov wrote:
> > > On Mon, Nov 10, 2025 at 02:20:17PM +0000, Alice Ryhl wrote:
> > > > On Mon, Nov 10, 2025 at 08:59:36AM -0500, Tamir Duberstein wrote:
> > > > > On Mon, Nov 10, 2025 at 8:06=E2=80=AFAM Alice Ryhl <aliceryhl@goo=
gle.com> wrote:
> > > > > >
> > > > > > To avoid hard-coding these values in drivers, define constants =
for them
> > > > > > that drivers can reference.
> > > > > >
> > > > > > Acked-by: Danilo Krummrich <dakr@kernel.org>
> > > > > > Reviewed-by: Burak Emir <bqe@google.com>
> > > > > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > > > > > ---
> > > > > >  rust/kernel/bitmap.rs | 16 +++++++++++-----
> > > > > >  1 file changed, 11 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> > > > > > index aa8fc7bf06fc99865ae755d8694e4bec3dc8e7f0..15fa23b45054b92=
72415fcc000e3e3b52c74d7c1 100644
> > > > > > --- a/rust/kernel/bitmap.rs
> > > > > > +++ b/rust/kernel/bitmap.rs
> > > > > > @@ -149,14 +149,14 @@ macro_rules! bitmap_assert_return {
> > > > > >  ///
> > > > > >  /// # Invariants
> > > > > >  ///
> > > > > > -/// * `nbits` is `<=3D i32::MAX` and never changes.
> > > > > > +/// * `nbits` is `<=3D MAX_LEN`.
> > > > > >  /// * if `nbits <=3D bindings::BITS_PER_LONG`, then `repr` is =
a `usize`.
> > > > >
> > > > > Should this and other references to bindings::BITS_PER_LONG be
> > > > > `NO_ALLOC_MAX_LEN` instead?
> > > >
> > > > Ah yeah it probably makes sense to update this in a bunch of places=
.
> > >
> > > Yes, please.
> > >
> > > NO_ALLOC sounds a bit weird in exported API. Maybe NBITS_INPLACE
> > > or similar?
> >
> > Ah, good point. We started using the "inplace" wording in other places,
> > so lets also do so here.
> >
> > > Also, at this point we're really close to:
> > >
> > >    pub const NBITS_INPLACE: usize =3D CONFIG_NBITS_INPLACE;
> > >
> > >    union BitmapRepr {
> > >        bitmap: [usize, BITS_TO_LONGS(NBITS_INPLACE)]
> > >        ptr: NonNull<usize>,
> > >    }
> > >
> > > That would be a very useful addition for some particular scenarios,
> > > I believe. Even if you don't want to make it configurable, let's
> > > keep this option in mind?
> >
> > Actually, one option here is to define BitmapVec like this:
> >
> > pub struct BitmapVec<const INPLACE_LEN: usize =3D 1> {
> >     repr: BitmapRepr<INPLACE_LEN>,
> >     nbits: usize,
> > }
> >
> > union BitmapRepr<const INPLACE_LEN: usize> {
> >     bitmap: [usize; INPLACE_LEN],
> >     ptr: NonNull<usize>,
> > }
> >
> > This way, the driver can specify this by saying: BitmapVec<4> for a
> > BitmapVec where the inline capacity is 4 longs.
> >
> > And if Binder wanted to make that configurable, Binder could define a
> > constant based on a Binder specific CONFIG_* that controls what value
> > Binder passes.
> >
> > Since I wrote `=3D 1` in the struct, you may also write BitmapVec witho=
ut
> > specifying any number and get the default.
> >
> > It may be possible to specify the number in bits rather than longs too,
> > but then we have to decide what to do if it's not divisible by
> > BITS_PER_LONG.
> >
> > (But in the case of Rust Binder, the value we want is one long worth of
> > bits.)
>
> It's better to define the actual number of bits. One reason is 32 vs
> 64 bit portability. Another one is readability - when dealing with
> bit structures, it's better to think of it as a set of bits.
>
> Those providing unaligned defaults... - you can drop a comment for
> them. :)

Makes sense. I'm not going to do it in this series, but it seems like
a reasonable idea.

Alice

