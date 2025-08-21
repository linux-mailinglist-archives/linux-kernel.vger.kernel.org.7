Return-Path: <linux-kernel+bounces-779466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC8EB2F469
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92FD37A3963
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5C62D9781;
	Thu, 21 Aug 2025 09:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I3M3RD8T"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB87287266
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769527; cv=none; b=TKXuZWdHImeC0pWuE/W8uEe+iiYLZVAN0oeuySeCFC3UF5HL+2RpZJD2doZsURRVsyILX8lrTUwZ8R2s5VXsvQTk4TR+0rlz0IGphKRjR30aRatZQl6V/IkKvjkJ9PReFascGRzF92Vq9cQvvUR4X/4MoQHUfXz0tmgWbXOgO6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769527; c=relaxed/simple;
	bh=+KxGB/dKJ4pb+tY+o0803YJCfK/BgA6DR2F3Eml0X7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LxGXb8i36NjL00jhad0HmiVuUg7q/SDhZkHVKsct5lDKwiAHqOJXVQGSCqfTBgshxXwhTqal9yTFU24TvZluif8jdQXbnHCc2Pj6eQu/hlD41Lz00DPtFTXHFPfp9jcwpPB3HTC17y0oqTFsh436K3UUhqRi/2iQ6pX5K8m/bh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I3M3RD8T; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3bea24519c0so900145f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 02:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755769524; x=1756374324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYYHIISUuCy2JfQNPh+L51Upj+t6+AJZfjbcWAfxVxk=;
        b=I3M3RD8TSi3NMGsheq8q8Al1puWs9W3t63Cl27Arf3dNwQQK7GtaduGQHEgt46YDHA
         9xX2hfIVjXngTseehuNGZXp/YdgMu0LqXBlPnhTjC86+YgeYVagMBlN+TE+kuqJRUc8X
         RZiqkhmEncZI4RXf/JJhyKtjselwx3Mp6QouNAKanbKdjW0obSzF+fgHhM6hA89Ve9kz
         8cKjc1olS1rjL4Xf6Bg0Az1pwlSrdL1zPeUQutMY32mie5u0pcRQ6V0wiJ1mhkts3LgU
         oqBvGQ8x9VO9Knd7DJBpcRoIzL9vFu1lxeskCVJjNtTJnoZWWOgA+Md7FU42U7sigwOc
         HOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755769524; x=1756374324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYYHIISUuCy2JfQNPh+L51Upj+t6+AJZfjbcWAfxVxk=;
        b=mNIA8k8TLcuij42YBGsAUm6UQX6mZROhLOOJpWuONSOiiQ9UDVis7225DaE54inqhC
         8OGK8LRRtmoa+W5s2bhzMMgF6fPNJe24oOY8vxQeVw7Xoo+KATAKcNqQKAnil5UvtJbU
         qJVKNmNPku0WuNbS0qmoOVxsCpKoGYERynzDYwgYfjknWvZYErSxrbRS0C5MrJmVaDfe
         vxn2o5GL+jsZ5dDJZNT4LSt5MGU0KjKBcBlwW580KXIiU73n9HQBkkpz3mawdOc/6A8u
         Q3v6H6vX2S5bLqgBoVsV/cEPkuX+KyzSGeVhPCXk08tRBnX+3Sglmi/rS138NVC34osy
         H20w==
X-Forwarded-Encrypted: i=1; AJvYcCUHv6zYv/FUxydIj2OnJFRG/SCmVb7oqZgTpydB7cGe23oKptjG/qV/5HMoPuQb7ZqNzYfC2zFIsS+Zz5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEinGUPd/H8pxZPkNPKQg7urfOuqgY+SKGYcX4budQboL6tzUe
	xyKSlmn0R1ZgYWNbS9rIHRjn8/gyxSfE3PB78Ii9xJAcEgxgb9PXcQEyFTO9IMDr68pz7mmBVaU
	bPctzmSU83vwUVONzV3nFUcKkfZLlmOv0ypt5Lbfe
X-Gm-Gg: ASbGncs7AkS37Y4/wbR0wWoaITk9YkK4hxb23n9gs8D9B+7AkbVywTm1K3kpeqj1FF9
	zDF3Zv+L7mZDt0i+rFljgNYKh7tZ10v2Z2YXBbOT65O0keQgp4v5R1zzTf7I+PQng4PTE/eqVnf
	km9VculpnphdLergdtenhQIhzGc1LnhdePG4Th0+PtF99vBm/EZ5kSWOViNXm9w79SvIyhMgPGW
	F87OLmbgXMY8EB8+UmIR4+YmeKD6bS4P+sD2yXQ+4TC
X-Google-Smtp-Source: AGHT+IGn/wQOgVGJFmdB5PCUsV9/j1HIemTZs47Lm99Ax8kZZi+0rJsXvH9qzrIslE8FnssJag3hkMGPPm2tMopx1XE=
X-Received: by 2002:adf:a19c:0:b0:3a4:e231:8632 with SMTP id
 ffacd0b85a97d-3c4b4c0f1c4mr1130278f8f.12.1755769523630; Thu, 21 Aug 2025
 02:45:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812132712.61007-1-baptiste.lepers@gmail.com> <20250820162927.34201cfb395ec7319b15920a@linux-foundation.org>
In-Reply-To: <20250820162927.34201cfb395ec7319b15920a@linux-foundation.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 21 Aug 2025 11:45:11 +0200
X-Gm-Features: Ac12FXwc6xuQOhVNEpGEy9nGpcxRQ0IxCgJJo1p3FE9jDQG2LnUgqbP8cpbBPG0
Message-ID: <CAH5fLghx7K1fsdx15VsaTT1i3DRQD8zH2Yd-sEwumiByefTVAQ@mail.gmail.com>
Subject: Re: [PATCH] rust: mm: Mark VmaNew as transparent
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Baptiste Lepers <baptiste.lepers@gmail.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jann Horn <jannh@google.com>, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 1:29=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 12 Aug 2025 15:26:56 +0200 Baptiste Lepers <baptiste.lepers@gmail=
.com> wrote:
>
> > Unsafe code in VmaNew's methods assumes that the type has the same
> > layout as the inner `bindings::vm_area_struct`. This is not guaranteed =
by
> > the default struct representation in Rust, but requires specifying the
> > `transparent` representation.
> >
> > ...
> >
> > +++ b/rust/kernel/mm/virt.rs
> > @@ -209,6 +209,7 @@ pub fn vm_insert_page(&self, address: usize, page: =
&Page) -> Result {
> >  ///
> >  /// For the duration of 'a, the referenced vma must be undergoing init=
ialization in an
> >  /// `f_ops->mmap()` hook.
> > +#[repr(transparent)]
> >  pub struct VmaNew {
> >      vma: VmaRef,
> >  }
>
> Alice suggests that I add a cc:stable to this.  But I see nothing in
> the changelog which explains why we're proposing a backport.
>
> So please send us a description of the userspace-visible runtime
> impact of this flaw and I'll paste it into the changelog, thanks.

I don't think it has any userspace-visible runtime impact. But I've
seen many things get backported when they are incorrect even if it
works in practice, so that is why I suggested to backport it anyway.

The annotation makes it so that VmaNew is guaranteed to have the same
layout and ABI as struct vm_area_struct, which is required for
correctness. Without the annotation, rustc doesn't *guarantee* that
the layout/ABI is identical, but in this case, they are identical in
practice even if the annotation is missing.

Alice

