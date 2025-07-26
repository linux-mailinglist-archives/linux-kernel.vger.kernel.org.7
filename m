Return-Path: <linux-kernel+bounces-746803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D77B0B12B62
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 18:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734B43BE64F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 16:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA7228642B;
	Sat, 26 Jul 2025 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ghxkkvlp"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B681AA1F4
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 16:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753546430; cv=none; b=QPFKTihI85dpNGCJxmYsNOvNM/DDcqonr/Zig/23J+0LzCKYWguhPd97JEOk559GgztHosHG8OCy/9Z/DHnvJWE16e43jtYz8o7wBtJiDmeO62+cQczoRdQF74e3F3WyCYry6xHGKRcEKwuKx3AJD1ftQrmWNzcBr3K/DHSqreQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753546430; c=relaxed/simple;
	bh=KOVFTwTb/EuQIM6jQ7hDcils7oA9qFQIBrqpPTPpKw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CXKFW3UIBuetLgAJWVEpCmI8uYJXWc6LQvkz9eHxV33Qgw6HtHyeR3nSjbFMyYrhfekgYxGf8exzMHwsSB5jn2A2vIV+R6uae25wcBTcHOC2WelsCp/sBKHXn83jqLQHCapdhwUNx3u6jyLl2g1b5yeMzJJTLr6Vc2y7HPIrcos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ghxkkvlp; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-451d7b50815so21226935e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 09:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753546427; x=1754151227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSmE2/IG78aP+245fYXp3PxN702DvxPZXYlkAkGpEZk=;
        b=ghxkkvlp+WMayusNf93yr2OrOxrpaSQx5G23EGm+dH8giUTIBtO5oGOgjOYyZOOu4+
         sMSBoJQtLbtstYX9/Qj4uU7vml6UEMv8YeXB8jFTTAkGFJAGuG27FOtYSbllmFdrL8ot
         oTWxtydUooqUcUxXCUnuuxaWyUvpm2iqhIhlUz5n8chLyiTMp7LSG5TGXXHogZ5abCoY
         2Kog4pVBHkBCMrCPfR6lu+S0w10eDL6S7LnDY2aDXOWn2uQ1Rnae4m1Hw7tuvNrrY0z/
         apSHoP2TA1DByBfx8yEDvcLB0sKeKPFIoykwuOJ1O3b/n3AYjtz2ABCYNBQRUfZ8h9CZ
         3ItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753546427; x=1754151227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSmE2/IG78aP+245fYXp3PxN702DvxPZXYlkAkGpEZk=;
        b=jgC8WU2eF3rG+LWceKlS5ArKU0eQ/vpLyK26nGr9nSlchJR1+GarN/kcmUobmmttZP
         LWd5xL4bfTqIHgOpviD4sfUhb6sSfBkQWhXyYJuKjDXPKXdhaOsfXvnzy8aThHKPsl7w
         6K1WwmEURC2JT1U88QPBRH2ZHJERopUwirqrgGgWQ2morGHudv4g1S4ehCOUSf3kSYhd
         vTt4Rh3ksObyfR76NFCXcM2GABeTajsu4ttzKTd76Q9HgdHgACl9HFnk5TD78d/oX+sq
         kjnC5ZHCsWb8GKG7s4+sxP9GA8l2QEfBO0diqIT+M+NNal4JSWwtRdK10qb4tTGi5s/v
         vBjw==
X-Forwarded-Encrypted: i=1; AJvYcCWTsWJ4Ny8Hx2THAbu/D/C4ZwDiQNG83VfnRmmJyg/UUFueedsBf80fXr231YoFw7JLoKwk12wYrd8ROB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMLKFBgxZs0vOOpGMua1phQkpOzCc0zFyxBraCyTVB5A0Ro8pz
	h+vwp/24+Zt2XxNlnAiiCaA5HEovpoB1GPCmWB5xTENjjILjfGsqdVIi9mcXVGjP102X7QqNDj+
	uv1Z516BHN7ngA4Z0Jy/4Kir3TOKBFLIMoVl7GFzR
X-Gm-Gg: ASbGncvcxXAX0X/xDYel4NJbcS/vSMWNGfTFy5/FoVrngSllIET4wEzMZcGGiqXWD0h
	Q+Ak2FSZWsN++DgUwtOyqZyOYE8sH4hHUVz6rKOGEsWVRX84+Get4MYxDXUkgoiniJ2LSYlPTpR
	t403K6Jef8rPjqiKZ9iiRiyhc7Gv/8BhTeNwhZiIoQ50QCv1Oa5jWgl0AsN5O9U/315xHIxXE5F
	kPfWQhp
X-Google-Smtp-Source: AGHT+IGjmxfhiuSOXZOdKrAjq/2iLUvcoITJyFtLrM3SVjwxEvIE+xW4uFMAM5xc3aH0PtQ9ZEiVJc9cs0p0ckcKSlA=
X-Received: by 2002:a05:600c:4f87:b0:456:133f:a02d with SMTP id
 5b1f17b1804b1-4587644278emr60085665e9.17.1753546427335; Sat, 26 Jul 2025
 09:13:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726-maple-tree-v1-0-27a3da7cb8e5@google.com>
 <20250726-maple-tree-v1-3-27a3da7cb8e5@google.com> <20250726165446.2768c6ee.gary@garyguo.net>
In-Reply-To: <20250726165446.2768c6ee.gary@garyguo.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sat, 26 Jul 2025 18:13:34 +0200
X-Gm-Features: Ac12FXxFtdvvjbSWz68LToYZuz9O8rpVTX_BUoiCo2Gz6b2RLEu8Wxik0sZefPk
Message-ID: <CAH5fLghiXEvcAfdCRJ==i4JWE0DQh6fFD4ppVM2DytHTjwA8sQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: maple_tree: add MapleTreeAlloc
To: Gary Guo <gary@garyguo.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Andrew Ballance <andrewjballance@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	maple-tree@lists.infradead.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2025 at 5:54=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> On Sat, 26 Jul 2025 13:23:24 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
>
> > To support allocation trees, we introduce a new type MapleTreeAlloc for
> > the case where the tree is created using MT_FLAGS_ALLOC_RANGE. To ensur=
e
> > that you can only call mtree_alloc_range on an allocation tree, we
> > restrict thta method to the new MapleTreeAlloc type. However, all
> > methods on MapleTree remain accessible to MapleTreeAlloc as allocation
> > trees can use the other methods without issues.
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  rust/kernel/maple_tree.rs | 158 ++++++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 158 insertions(+)
> >
> > diff --git a/rust/kernel/maple_tree.rs b/rust/kernel/maple_tree.rs
> > index c7ef504a9c78065b3d5752b4f5337fb6277182d1..8c025d2c395b6d57f1fb162=
14b4e87d4e7942d6f 100644
> > --- a/rust/kernel/maple_tree.rs
> > +++ b/rust/kernel/maple_tree.rs
> >
> >  /// Error type for failure to insert a new value.
> >  pub struct InsertError<T> {
> >      /// The value that could not be inserted.
> > @@ -378,3 +499,40 @@ fn from(insert_err: InsertError<T>) -> Error {
> >          Error::from(insert_err.cause)
> >      }
> >  }
> > +
> > +/// Error type for failure to insert a new value.
> > +pub struct AllocError<T> {
> > +    /// The value that could not be inserted.
> > +    pub value: T,
> > +    /// The reason for the failure to insert.
> > +    pub cause: AllocErrorKind,
> > +}
> > +
> > +/// The reason for the failure to insert.
> > +#[derive(PartialEq, Eq, Copy, Clone)]
> > +pub enum AllocErrorKind {
> > +    /// There is not enough space for the requested allocation.
> > +    Busy,
> > +    /// Failure to allocate memory.
> > +    Nomem,
> > +    /// The insertion request was invalid.
> > +    InvalidRequest,
> > +}
> > +
> > +impl From<AllocErrorKind> for Error {
> > +    #[inline]
> > +    fn from(kind: AllocErrorKind) -> Error {
> > +        match kind {
> > +            AllocErrorKind::Busy =3D> EBUSY,
> > +            AllocErrorKind::Nomem =3D> ENOMEM,
> > +            AllocErrorKind::InvalidRequest =3D> EINVAL,
> > +        }
> > +    }
> > +}
> > +
> > +impl<T> From<AllocError<T>> for Error {
> > +    #[inline]
> > +    fn from(insert_err: AllocError<T>) -> Error {
> > +        Error::from(insert_err.cause)
> > +    }
> > +}
> >
>
> This looks identical to `InsertError`?

They differ on whether the error code is EBUSY or EEXIST.

Alice

