Return-Path: <linux-kernel+bounces-740717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 170E5B0D846
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 332AC7A40AE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE4D2E3373;
	Tue, 22 Jul 2025 11:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E4clNe7s"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A17A1C32
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184087; cv=none; b=HTBnHd1Rd1l6JGJ1+9tfVhrR8FA4Qx5qKdLZ3bMNgEQpy4A+SwQP50abxuFwdBGCMvBTLALsYZ0X4PeBDeP3oearSJMNgoXcTTPiQ6LvT3BVuTYDGUTjv7uY2WfYcYz86iqo9u576PcWRmGdQt/0amcUdQ55IQR9rSkkc+sjmgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184087; c=relaxed/simple;
	bh=IJcOlmtw/NnWcYNlHgTN6xStFqfXiMJp2oPUjlf6G1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XFwUX9NfYLKHXPVQizBZ19BuBqCIMNMb1FBmrsvbNZDKOHGAXrHscVEeZFgf+xCXdL8jADZCanQtiFqF9kimDZVgCUKL2e9LjloKsQ97gtndc0+QjjrZN/5sPesYTmqaaAYB1Q4EXaKjMqbD0u5UmPoMka6MvpAA2IDQRlT7cbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E4clNe7s; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-455fdfb5d04so30533655e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 04:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753184084; x=1753788884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZMPht7gkTTHVxsbBVjCpliqfu5/ygYf7gghg6pj8Lc=;
        b=E4clNe7s8ZUmzUDNnGuC5I80ZkDairVl9L57IF/BVfRJ9PYTZHeCth5fBWe1QvnmvY
         cUDegTlfDdvFAtn8ivPBvq+qC6JA2H7iccQO8wZelRPezSSbMfgsLnloHy4t4Dgq+rmB
         XwRrO2XBQgaVFv5pxafKT1PUfOacDBCM3mC6KnugIsCx7ZirKbFi+UXtZit7VdcF1E9N
         xflg+bvzq/YCPBRAXD5xy/FDHeA9pBS7HrEAWYsyQtGtL2EgygDz+QXsoqtSHbw/MM54
         r8/cY433KX6M3V1PgzUNojMyZdHFeU/xgcxCyqNwCRSX/DhD+LH0M1H/q0Z6e4bgaW3n
         f+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753184084; x=1753788884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZMPht7gkTTHVxsbBVjCpliqfu5/ygYf7gghg6pj8Lc=;
        b=jVWBc8KpY469xdqQ68fo3HncMuBxexCVt5Tqkjs/e6UjQTvAkuyH913Gjwk9laSYR4
         r1HeUx1JYrVuVGXxWcmXjGc1y68SX+dqmAH+GpFdE4C/Gv1S8YhnvryLQEiXsGHguc0e
         Jk7TcEHgnd7JJdzvKL9LkYEWyuNyroY1yTN9Hz7uzeDUy1o/0ceSGpgAtVpRimqpVxap
         4QjiFqoYzzklYU/QawpiYl05RD8XtUB409pTkKnLqjmYWBb79ZKbbM+GfIlgzWJ/DqSj
         MeDMfeWUinZuPdWrTshdqF2uQf5KkphFAcYQxcGR7ugYuE1sdPeyzi9QYkPjAbfkuWt4
         jAww==
X-Forwarded-Encrypted: i=1; AJvYcCUOgYmkz+/te3e+0tnNVLTeFSRVh/p4cfOxEx7i19LPDU6ZlmGLTIuozDROXGn8IHhU5r9S6aEu8UOgVSk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzjy4VNbJ2psSbNhiC0SxlM5LacJ1BG3fgF9SpmINmsqLD9o2t
	R88hquD/4MDiw+yQYMFg+fs4xP8kpqt9g8bK81B4/i6IkQnVVOc08f58B4u9KVw+l+x6FnfPoPN
	hMT3hEDVfNu17vx9VFHNTsZVmnO89v7AaIzfPLQ7O
X-Gm-Gg: ASbGnctzNJyN6tr2/lGeyXv3b8zvJWvVMqwgafUxLe0UECLVDa1k92RPxccXaW0lS7O
	BTaxVt4xnOaCKoGpWdosVPlgSQSdcgeCQI5MF4gBdWjjm2U7nxN9znGO+hpBf9yp99mdKuRYrQa
	PBTq4cRDfXYFiy3COLktnVgbvCtcPExHIJ5s6L570A7Q5n8qhbvsAzjJ3wBDozMxnu/AZOcH6gz
	nTogPsq+K0vKMDdgbbQlCssBBHeIUeB4N+ifA==
X-Google-Smtp-Source: AGHT+IGeBYHszJWBXESmP50bCsejIs3JvKygU35UM4Qg/ob8h3/kNTtSDZTbH5p3tZc7qBiTgE9jp/n1XIah4JTa+l8=
X-Received: by 2002:a05:600c:450a:b0:442:c993:6f94 with SMTP id
 5b1f17b1804b1-456352e8aa8mr210909705e9.12.1753184083614; Tue, 22 Jul 2025
 04:34:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520231714.323931-1-lossin@kernel.org> <DBIJLR7XNI6U.21PMPODHE83DZ@kernel.org>
In-Reply-To: <DBIJLR7XNI6U.21PMPODHE83DZ@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 22 Jul 2025 13:34:30 +0200
X-Gm-Features: Ac12FXxNuYgWIcswNv8WCkf9UX8cFJMqKP-_bEHztMIj8b3nC6J90x3Qbf1cNj0
Message-ID: <CAH5fLgh9aEF5V9rNq2a8utS=NxSU8rdxpKsNbsuPoMpDfHN0fg@mail.gmail.com>
Subject: Re: [PATCH] rust: sync: fix safety comment for `static_lock_class`
To: Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Mitchell Levy <levymitchell0@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 1:21=E2=80=AFPM Benno Lossin <lossin@kernel.org> wr=
ote:
>
> On Wed May 21, 2025 at 1:17 AM CEST, Benno Lossin wrote:
> > The safety comment mentions lockdep -- which from a Rust perspective
> > isn't important -- and doesn't mention the real reason for why it's
> > sound to create `LockClassKey` as uninitialized memory.
> >
> > Signed-off-by: Benno Lossin <lossin@kernel.org>
> > ---
> >
> > I don't think we need to backport this.
> >
> > ---
> >  rust/kernel/sync.rs | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> > index 36a719015583..a10c812d8777 100644
> > --- a/rust/kernel/sync.rs
> > +++ b/rust/kernel/sync.rs
> > @@ -93,8 +93,11 @@ fn drop(self: Pin<&mut Self>) {
> >  macro_rules! static_lock_class {
> >      () =3D> {{
> >          static CLASS: $crate::sync::LockClassKey =3D
> > -            // SAFETY: lockdep expects uninitialized memory when it's =
handed a statically allocated
> > -            // lock_class_key
> > +            // Lockdep expects uninitialized memory when it's handed a=
 statically allocated `struct
> > +            // lock_class_key`.
> > +            //
> > +            // SAFETY: `LockClassKey` transparently wraps `Opaque` whi=
ch permits uninitialized
> > +            // memory.
> >              unsafe { ::core::mem::MaybeUninit::uninit().assume_init() =
};
>
> Looking at this patch with fresh eyes (thanks for the bump, Alice :) I
> think we should rather have a public unsafe function on `LockClassKey`
> that creates an uninitialized lock class key. I'd like to avoid the
> `MaybeUninit::uninit().assume_init()` pattern, as it might confuse
> people & it looks very wrong.
>
> We can take this patch, as it definitely is an improvement, but I think
> we should also just fix this properly. Any thoughts?

Could that constructor be used in non-static cases?

Alice

