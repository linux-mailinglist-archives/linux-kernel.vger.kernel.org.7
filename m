Return-Path: <linux-kernel+bounces-655587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F4AABD856
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 14:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4322C7B1A79
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 12:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB6F1C8FBA;
	Tue, 20 May 2025 12:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B1VMsJdU"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C18B1B4231
	for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 12:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747744987; cv=none; b=NaJPnFkOSfJw3nbSWQSqyGQg0pc/88xA+G3rzIvzZZWK/UJVNsy/no4Phe1Iv4lxPz5jPk/q8BMo/oUaS4JqTTvQs5dxT+gVXQ2V8zpY36N/w+VCcp7wAOZYphVquwTz4dMPaUntfbcmikA6iX683iRtD5ZRG/X+FusdGMO1DhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747744987; c=relaxed/simple;
	bh=EAHzzRlqwHD0tyyHiLnOawAa1WH6/3DVglP+aReQHPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ynjb5PhEW10jVgIO7XHjwEz5/NbkbAvZiK3bZ0oyOWI4g+TTslOZRZXV9TiHiVFMTfbnbEoF1WbsIbh3xNEqzpjZ7hHOqc40ZAPQYC4YoT/iw9/46onNBbcNn0vbSijIt38jMgugFItEiI1oOgTp7GF/OFQliWN5BJrUdYvqi+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B1VMsJdU; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a35919fa8bso2155000f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 05:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747744983; x=1748349783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAHzzRlqwHD0tyyHiLnOawAa1WH6/3DVglP+aReQHPc=;
        b=B1VMsJdUTtNZ5AeibbEr7PXGb+bgZA78QdWsAheDRcoVinv9wUHKmtW7183x/7R0Q7
         77EZ2RqvZSAyd1Mht6XSmypEFCwYBLIbqobkXmRcFX8xPvUOGZh3Ip54AT205WhRjxzR
         eaQ7jG6lgIEFdQX5KmLB1Pf+hjwX1x9FD0E/0hcvkbOm/4lVfm13L+ekdVyvp4l3zgD7
         Li5wKHHeOy+310BDqvSE8RjphNofrdvBrZZP1E8AojPm495mntqF+qc5p+iA7h05mJ4F
         vv3Iwd2Zn/cSuN959zeQ6lm9B9oZ0pSGWgudpYIRT5U59PA1KEvZXDXl5skAM1R49jQ5
         XeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747744983; x=1748349783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAHzzRlqwHD0tyyHiLnOawAa1WH6/3DVglP+aReQHPc=;
        b=Qsn/U95PXEAXKqEg4JlkQ8RUs6tZfNElDp5viUhM6OYZAOtLrg4kPXkAObE+yxTeid
         poDiYPy19E1Skjvu4CSOm/DyJMIh0QiDC1gCwn7QdVrrNkpmjMGZyqRo6Liftdtpfo8W
         2wtlLvKqkNgbgdMvnxxJG3FyV/EDnNXf472imv511ubE6bKm9dFj6PWChTQFiQMLOQKr
         mLK2D6PdgiKJ1b+og02YFuH69AwhaFuYasv8UzZAsepXIFSJ+TO/xpdI6eVyYaG6tZ2s
         fHswEKgf7biT9g6wrfGCGCq1PhUfxgHxtDvYEcaJ/xa2Y2fgdapf54opexWV2LGhVjOZ
         2V7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7nc9PwrjLcVs3Ig1E049UIKeon+giuI07XDkWAy7/0vEYTeO+j2m3vSGRtWuPxi/q1WoPHXARKNFgRt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzscdGF5PHjidZpV9tecoz0CN7qsfbpDnsfi5qQSXwGtEaCoBie
	tfjN/aViIyImM5YxyuhfG+gB0Y7P6YnaGD5bC9rX7Ll7WmGeKXhg959SwuW9CvLvu6sQqwkEQzf
	uO7QZP/H0M4QCViG08Sc3cjVNe26tHetb93EnCPUP
X-Gm-Gg: ASbGncuaBip39YgrnFkDQh+pq7E+Lqtilf/QxNLldo9cKurVvcPEv4rdGkbcr3aZiZy
	+dmyMUSntWfI018nIHX8GGBch6FT34aRry+uP560JKOTnUSGiuiL8jE3TOZELJ1SjYf0DefG27d
	y93NYUqYHCyUcg9P9XDjgkTOEuHRUG2btMfzk7mMBtbAF9
X-Google-Smtp-Source: AGHT+IHS0wTiDrmTRT4pPLA0kd7EuOcSAEADiFb2xPxNv7tTT14Pcvfk2m6J1zKafjkxbkm02/1Z8djAmA08uVBrLX8=
X-Received: by 2002:a05:6000:40e0:b0:3a0:b733:f264 with SMTP id
 ffacd0b85a97d-3a35fe5ba7amr14020745f8f.11.1747744983401; Tue, 20 May 2025
 05:43:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519161712.2609395-1-bqe@google.com> <20250519161712.2609395-6-bqe@google.com>
 <CAG48ez2WdxXVCzVsAPeQWgso3ZBQS_Xm+9D1FLBx6UHFV1bGHQ@mail.gmail.com>
 <682bc528.c80a0220.13f632.9ec0@mx.google.com> <CAH5fLghNJYjxPFUc2E4-2pJpGT5umUr1EJstZvs88ox3MsXDGQ@mail.gmail.com>
 <aCwRZlkBWekRmDg7@Mac.home>
In-Reply-To: <aCwRZlkBWekRmDg7@Mac.home>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 20 May 2025 05:42:51 -0700
X-Gm-Features: AX0GCFvPyNIDsyx7gzZx16RwjzE4BKj1SXehnk-VJvEazvtsPhKBabrEv6qfeaI
Message-ID: <CAH5fLgj1NVodPy-95CFUygGO7WC0siNEKSyEhgLvpX-1zMXErQ@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] rust: add dynamic ID pool abstraction for bitmap
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Jann Horn <jannh@google.com>, Burak Emir <bqe@google.com>, Yury Norov <yury.norov@gmail.com>, 
	Kees Cook <kees@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 10:21=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> =
wrote:
>
> On Mon, May 19, 2025 at 08:46:37PM -0700, Alice Ryhl wrote:
> > On Mon, May 19, 2025 at 4:56=E2=80=AFPM Boqun Feng <boqun.feng@gmail.co=
m> wrote:
> > >
> > > On Tue, May 20, 2025 at 12:51:07AM +0200, Jann Horn wrote:
> > > > On Mon, May 19, 2025 at 6:20=E2=80=AFPM Burak Emir <bqe@google.com>=
 wrote:
> > > > > This is a port of the Binder data structure introduced in commit
> > > > > 15d9da3f818c ("binder: use bitmap for faster descriptor lookup") =
to
> > > > > Rust.
> > > >
> > > > Stupid high-level side comment:
> > > >
> > > > That commit looks like it changed a simple linear rbtree scan (whic=
h
> > > > is O(n) with slow steps) into a bitmap thing. A more elegant option
> > > > might have been to use an augmented rbtree, reducing the O(n) rbtre=
e
> > > > scan to an O(log n) rbtree lookup, just like how finding a free are=
a
> > >
> > > I think RBTree::cursor_lower_bound() [1] does exactly what you said
> >
> > We need the smallest ID without a value, not the smallest ID in use.
> >
>
> Ok, but it shouldn't be hard to write a Rust function that search that,
> right? My point was mostly the Rust rbtree binding can do O(log n)
> search. I have no idea about "even so, should we try something like Jann
> suggested". And I think your other reply basically says no.

We would need to store additional data in the r/b tree to know whether
to go left or right, so it would be somewhat tricky. We don't have an
implementation of that in Rust.

Alice

