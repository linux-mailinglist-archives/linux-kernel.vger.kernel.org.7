Return-Path: <linux-kernel+bounces-893349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3927AC47214
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C359D3BE03B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E332F31282C;
	Mon, 10 Nov 2025 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o8wPV626"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C925930EF7D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762784421; cv=none; b=cG7u/pH/isBimjwfnobNj2vgaXcMCIXt96OibGVFtqIpN2rmVtAegNy/dzrw5w6xZfV0QgJ5LO/qODOVDu/Wpzb+6ozqhav3ocl+vexU49ykKnRRVbTHNmmdWrcGRL0X4sV6IPgfwLRmeiA8LV+4jikxF+/ImySFhR5Jj9eK1sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762784421; c=relaxed/simple;
	bh=qOe6RlsRxbbpjF5yUGUHA1xvBuskgAyFDmfx01XXhAw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dmgGe+NgbHnxx1DCK8eA5bAPpawbOCGrYKr3ezhRWQIt1VYg0yA6oprlF25mhZC9bOexCe+xyeGw7DhOrtY1tMinEtsLaIW3T370tFMd3Dj0+dISfwe4bt8IACCpG6IlO5T3GRw0LORuH89fOKLCnDXBmArzrJdDx+dAGhz86Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o8wPV626; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-429cdb0706aso2055960f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762784418; x=1763389218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=psMAW+A9N493zhAMdvYWcZIn1t44bxjpvUHDwOK81aM=;
        b=o8wPV626NgQ2GpWxaojClOj7FUfOEzVml/oAEJVZDlT2W4Vu81DjzBPHhALFM3I4iI
         f8H4EB9W+9hoWlxsMakpf0uFpJJxtCGqKlym38K4IC8u8IiHPPJjeAQoj7QKtnExKpsb
         eQvSNsB2WNd56hyP6rEAQAmfR9N/8zKhQeDGt4BkunLAzJ3cwmVCOlEfYCPcXRywpunk
         hKFa26vICNHDH0nYa8OL6Q3jUzHPCyF6QRoKUFDczSzC+orpUOpWONvS46yaxj3n3hgQ
         ZYY5T4/1g0xpUACH3gD+fxC09fHq+7ak9r65SNli3byWFCPUmpPShJ0alV79ilU/4ibf
         jkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762784418; x=1763389218;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=psMAW+A9N493zhAMdvYWcZIn1t44bxjpvUHDwOK81aM=;
        b=Xf0NEeJesgYR/r7BZ/E9ASwlZBgOyTrlxyANMOlhAECzBrldQOVIhSTtfCK+o6lstt
         V6J7jLixKReORcFYDOS3X8UbmrRMZbTIqK5AgQxOz5bS9nqWlrKBZ2NKeE5hq0deLIfH
         AjbWUugYvVmcRujDwQmoIusxPbDyrMOCd55ju3B+WtXGh3X0mGM5ihO5JX2G5EWct0oy
         iAnrWBt3ixBo/eNtq6gvEnGCQAeOvV4AtgM3hJ+s2GIAQINrHHAKwBgSnHb/nVMGwpzp
         PMVP6YQAdukq1amgBlHKD3LuGTi8F8JKY0FRBmjtbsC/jJVZ9ovVJX8anckrIVbLk3wT
         Wwfg==
X-Forwarded-Encrypted: i=1; AJvYcCUHE7PTxwUBt5VLzp3NnfdHJ4kWjviBW+N3d5zTN3v9P75yFS77VfX9V/52oYVGASzvBVGTmoXngQlyOCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyUkDruFznxnsdSrVwRM4b/4jV3esGZ7FeXFByX0LRkaGERghA
	veF0Gi/88Q4JhWUJNPPmKWeuUoWgO6TsTKPMLI/qkzxQWn/jBjYwKnvMbFK+n1UJGSlR1Vxf5Hd
	DYlCulr4F8F8vbUyBjg==
X-Google-Smtp-Source: AGHT+IE7lZKYOZxQK4wSJWQnJ1H7sAQgindPi4gfJiLl8K1QY12SP/r6PQCMmeTdn9tCxq3wOp7gpa8Kwy9YvTw=
X-Received: from wrxk16.prod.google.com ([2002:a05:6000:50:b0:429:c767:a6f5])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:186e:b0:42b:3d9d:c605 with SMTP id ffacd0b85a97d-42b3d9dca2emr1761165f8f.49.1762784418053;
 Mon, 10 Nov 2025 06:20:18 -0800 (PST)
Date: Mon, 10 Nov 2025 14:20:17 +0000
In-Reply-To: <CAJ-ks9kvMQ9tUMZyM07jRr8O+pJ6RRvCZodenB==tzDChhHT=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110-binder-bitmap-v4-0-5ed8a7fab1b9@google.com>
 <20251110-binder-bitmap-v4-1-5ed8a7fab1b9@google.com> <CAJ-ks9kvMQ9tUMZyM07jRr8O+pJ6RRvCZodenB==tzDChhHT=A@mail.gmail.com>
Message-ID: <aRH0oRU5JXKpAKpB@google.com>
Subject: Re: [PATCH v4 1/6] rust: bitmap: add MAX_LEN and NO_ALLOC_MAX_LEN constants
From: Alice Ryhl <aliceryhl@google.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yury Norov <yury.norov@gmail.com>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Burak Emir <bqe@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 08:59:36AM -0500, Tamir Duberstein wrote:
> On Mon, Nov 10, 2025 at 8:06=E2=80=AFAM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> >
> > To avoid hard-coding these values in drivers, define constants for them
> > that drivers can reference.
> >
> > Acked-by: Danilo Krummrich <dakr@kernel.org>
> > Reviewed-by: Burak Emir <bqe@google.com>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  rust/kernel/bitmap.rs | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> > index aa8fc7bf06fc99865ae755d8694e4bec3dc8e7f0..15fa23b45054b9272415fcc=
000e3e3b52c74d7c1 100644
> > --- a/rust/kernel/bitmap.rs
> > +++ b/rust/kernel/bitmap.rs
> > @@ -149,14 +149,14 @@ macro_rules! bitmap_assert_return {
> >  ///
> >  /// # Invariants
> >  ///
> > -/// * `nbits` is `<=3D i32::MAX` and never changes.
> > +/// * `nbits` is `<=3D MAX_LEN`.
> >  /// * if `nbits <=3D bindings::BITS_PER_LONG`, then `repr` is a `usize=
`.
>=20
> Should this and other references to bindings::BITS_PER_LONG be
> `NO_ALLOC_MAX_LEN` instead?

Ah yeah it probably makes sense to update this in a bunch of places.

Alice

