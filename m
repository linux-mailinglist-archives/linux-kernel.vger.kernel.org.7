Return-Path: <linux-kernel+bounces-746812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173BFB12B7D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 18:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC233AC6E6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 16:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DC8286416;
	Sat, 26 Jul 2025 16:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xxUeAPAi"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05451D5AD4
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753548127; cv=none; b=hHYw+7YmtgxePHRon3uU4yuI4XA4KQYl+3K6SfFbg3Ngri2xqkSDhLsMig2WR76myVVie5AmRh47P1oXA7N1oItyQcgOc21XtlwS1pZdstelysF6sMSW3GEZxR5i1RBHyQP7KGKU4cslxXuRd3XUqqhGiQiNDvZk1g08L+cBj84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753548127; c=relaxed/simple;
	bh=a1AO0aaJg6TA/fV1vLIlctD1Kmjg6P4VnJBJPvqtSQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WTTIB/dMxIjpiZzCWi++Mep/9Hh+sy5c+eJ9QPS+ztFppNy4khcXeDhbo0Lpcb1FhUL6T9Ns1CMT9WCEOkL1MX34hmjzFQDIABy6rkQyyDbEdVGesKyNivWTA9gm3qajt+Ir6csZv8AKtXEjy1lZwcMrWinqPBd+8ikr4hmaiFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xxUeAPAi; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a54700a463so1830076f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 09:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753548124; x=1754152924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVowoy9yXuuyjz9Y28xfyjUbBH8nqnAtp4z7aeOQXpE=;
        b=xxUeAPAiEEWr/ttMUFD760aYTxInzTtx+fcGeFHT45dBJR5tJX31sY2zHux9/hVwqE
         1mqsDngAAceZw+O5bltiBIIqPCT8AqfT0F+N1U0Wj9YQ+6cLzDod272Ofh0/JtmDIl8B
         Tk5Ig1MCHatBpimcZ8c4SQzoif/MQhoAV7fpsRmnxRn1IJoI1HrEUPeMGQHhb8bsoGwn
         iILDvbM//bBPyfZCYgFRE0ekqC8jF6yG+ob4QqdSK5hc0et7S/oJHPlRLZJvQsRJcgVF
         IzIk/AUb46vTiK/Sxj5kFJBFfP1loMGyp+d5XFC97Fixi9U7mX1GxCjXQqupNUP3i+/M
         GBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753548124; x=1754152924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVowoy9yXuuyjz9Y28xfyjUbBH8nqnAtp4z7aeOQXpE=;
        b=SHS0LQj8ovlkrI0W92ZWdTrqf52A1HK6PQXMVw9KtWur66g4nvx43PlEbSLuSmDUcG
         GlZ8DH1YY19cYz2xubA0QjhOoJlZe8p1R8DF7Pod8jdJilgbEMpCKrlaQjQfLjuXX1nD
         9+9ymK739jxuVjyXKqOoFsbgTsVKWXErLLL3fod0lK0/YUnMHBVHq6wdWwQ/LrqzOW/x
         nurOCXVck9VmhfDJtC5ILMNe68PY21yvk0rMWOS1jrGDG+1ZjU6IcSgNFED60L8wOJTL
         oAFN8GnVy7ZTJAVVbHuyL53rO0shs7STclWwY/1ZYv0m8PoekkBG8ATFiTqOh/kqxkzp
         uMhA==
X-Forwarded-Encrypted: i=1; AJvYcCWx6pnmTm6i479csPDB6/oOzpSJ3g5ZPMEJr+Ufym/xA6wGQzVnLpK6WnGwJ1fVa5fnWdh9rcDva4ZrRJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/i84FAypzZxvzBj7wjop94tsVr45IvhF/e8vAsZs8rtfdvcp8
	GD3w7zy3txyXy7aRpkN9RTyT/vwHwik6DuOgcLmt5DwxMAtW+tMMAvZgU1AuhXIuTL5lFh+bf+V
	Z30VFURkvXm2I1qq/H+6VYNPbCyuuNunOxuIFLD1R
X-Gm-Gg: ASbGnctT0znMnRKCjnGHby9FLOd4dSYfbLJeYxcPU6YpJWAdOOeFke9DvwVGGNtTRix
	2x9lXUIvnlLBf50OAukT0ThXB6x1t0ye82SIs3BkT8P02Ct6FCj/yAp0Lv3Dt+9+H9kkKJSggGw
	qz6H1IrTR2YFZRjXTiphye3LzenvweQQgq6jTOFRFPISXy67Ft5GBwRQV86yCnzO5FmU3nrskog
	zXcqtAK
X-Google-Smtp-Source: AGHT+IHKtlVV1+6ax8KWh5Kp9Dj1RbPC7OFascTx/drEMtBpiZ7aEXwLkXXw7M9yya1yZA3wXzUXFkeg8MSM4MgMQ+I=
X-Received: by 2002:a5d:5f46:0:b0:3b5:f6f9:e803 with SMTP id
 ffacd0b85a97d-3b771356b1emr8410888f8f.14.1753548123995; Sat, 26 Jul 2025
 09:42:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726-maple-tree-v1-0-27a3da7cb8e5@google.com>
 <20250726-maple-tree-v1-1-27a3da7cb8e5@google.com> <aIUA_HFLXMYNxWDM@casper.infradead.org>
In-Reply-To: <aIUA_HFLXMYNxWDM@casper.infradead.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sat, 26 Jul 2025 18:41:52 +0200
X-Gm-Features: Ac12FXyIP9paBBXsCG4P9QMFCVmav0Ib6KKVd8mim4mgY57RAzHx1WLjuMaq_mc
Message-ID: <CAH5fLghw=6VeXkJm29a0y6QX=--u27FT8erYxDceB8JyT4KTUA@mail.gmail.com>
Subject: Re: [PATCH 1/3] rust: maple_tree: add MapleTree
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Andrew Ballance <andrewjballance@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	maple-tree@lists.infradead.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2025 at 6:23=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Sat, Jul 26, 2025 at 01:23:22PM +0000, Alice Ryhl wrote:
> > +struct ma_state rust_helper_MA_STATE(struct maple_tree *mt, unsigned l=
ong start, unsigned long end)
> > +{
> > +     MA_STATE(mas, mt, start, end);
> > +     return mas;
> > +}
>
> This seems very inefficient.  Returning a struct larger than two words
> (on x86 anyway) means that the compiler implements this as:
>
> void rust_helper_MA_STATE(struct ma_state *masp, ...)
> {
>         MA_STATE(mas, mt, start, end);
>         *masp =3D mas;
> }
>
> so that's about 72 bytes being memcpy'd per access to the maple tree.
> Sure, it's stack, so it's cache hot, but surely we can implement
> the equivalent of MA_STATE in Rust and see a significant performance
> win, at least on read operations.

Some of the methods go through the mtree_* functions that create the
MA_STATE on the C side, so this isn't always the case.

Regardless, we definitely can avoid this helper. It has the
consequence that if MA_STATE is changed in the future, then the Rust
version of the method must also be changed. I can add a comment to
that effect to the header file to remind people of that.

Alice

