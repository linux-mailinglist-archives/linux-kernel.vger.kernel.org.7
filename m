Return-Path: <linux-kernel+bounces-813391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0FAB54476
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC4C83B1549
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D172D4803;
	Fri, 12 Sep 2025 08:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pKQOY/S1"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBA02D46B1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757664459; cv=none; b=XVPAl24nMUGZPBy40s0FP1K1HKH1luPpJ2Msa1bZUBgVTWg52BKlD6iX+WKBKWpnb60eWxRiF9YtzK/jjSNup4aoFulyl3zKLCpzaHFKCLR6zOT7eMrlajreQessArwq8qZFwY9z76nMFsaT1ZUs3yi4C1f10wP+dh6mJ/DIemQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757664459; c=relaxed/simple;
	bh=gXY6rpD6dmiNO8w8Ji0dVoTPlEqZB76ZsSgmdEXvDW0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DoQ3pkJ7OtrldhOn9hQaqL37hzSZCjVxxwllkntWIy3qk+BsLhEhJm0FfuA4IKW16Jr0Jy+X0AjHjfCxe4HuBP1qk9RgMNefMlEWnUx/urApJBrVSGOL8NQGRzjacKCbmHDZJT/j3qH1W3b1grLguj2tggx3vCwfFR29epv8/iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pKQOY/S1; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3e7634eb959so753166f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757664456; x=1758269256; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+tgtoriTVA3wUl1fLwqvusUWB5z4BoYTpvvOhTysEkY=;
        b=pKQOY/S1UnIch1qPE5+pX9kMuYwdoB0aEtajEToaVSyxYyyUxqNxUSjRw+ppIHbv30
         bToRGCy3HjdrbrMrKp/2WRhFY7iyrjjp2hGbm+Ecl535hi+JC4ll3Y3H8yrAnDEWI/Bj
         Hu8+M0kys+Rn2+qoIoHzUHGJapgay47OL528QH2VPetzm5sQVF11tlLrtTJTtNPdij0e
         f/7ideA+pfFhciAYszYyN3CxeHFXDXqXFk3B0TF/9J5iUrmGol7JdtsEYjIrkdgUh0U8
         RoPZUwig/8d+SsdOjbp/oMbWvq2ouPBSm4E2NGyKSnbCsEkH5qpYCbHyz8xx6Uu+YsPW
         ottw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757664456; x=1758269256;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+tgtoriTVA3wUl1fLwqvusUWB5z4BoYTpvvOhTysEkY=;
        b=L3Cq5MFSSP/rt7FLUzFoQyFNettqP26axWvfMqGznsmwJBXpJBF/pYjWZYt1zGtAc0
         43IgZQFqMUICR5aT8Y00mZJKOa1ieLzdq9409uORNS/HVHKyjfopR75VngwTPeuiWHSv
         YEZgSK2Nu79qLE1KbgKrCsre0r73jcYYGx02YAzXKjZ28BQ6F8Q7JePzLuFOJ7J3xol6
         yXGXVQQa/KNOP8w5TcpF0YAMUiB49hWr48yn3ZnrGYN4xuRDLSU1bxsQTRvyE86LPA/9
         aDyCz/EfwI+kf7ivWlmg5igvLi9QKGW5gsJaFR8tUkAVmKEjkp8nsDCJ7oYuOzvR2mms
         LWWA==
X-Forwarded-Encrypted: i=1; AJvYcCUoaUFgNfTayMUZ+K3P9Y8zxjP5iyOfy8EG/4766IZZvujyRvOAzk4HdWqXFCIS+QM0DHIpo2NBkwMZ6Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwiDUu44uWa5MUMUwSXzCSFe7nJKjJlAqoxIci/MacUgglEUxQ
	GGURB093X9DiBtz3AJaKaMCwYEvCuXZamnpCG81ZCZCPZClgMBLp2DaPpqIuJyvFlEKSpKeo2Zc
	Ltgs+b30AlNUuSb7j5A==
X-Google-Smtp-Source: AGHT+IFkxsfqAcrnekL3Ice7pB/PeSHdeKiiZaFaWBiHr3Z/hX7oTQ21wuR0+bX+ocJ/wu6+RCMQdyFuzPpJpAo=
X-Received: from wmbdp7.prod.google.com ([2002:a05:600c:6487:b0:45b:9acb:6940])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2f87:b0:3e4:8163:b6f9 with SMTP id ffacd0b85a97d-3e765796c6bmr1878906f8f.14.1757664454769;
 Fri, 12 Sep 2025 01:07:34 -0700 (PDT)
Date: Fri, 12 Sep 2025 08:07:33 +0000
In-Reply-To: <20250910140212.997771-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250910140212.997771-1-ojeda@kernel.org>
Message-ID: <aMPUxZoV9BCqDg0y@google.com>
Subject: Re: [PATCH] rust: maple_tree: fix intra-doc link
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Andrew Ballance <andrewjballance@gmail.com>, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="utf-8"

On Wed, Sep 10, 2025 at 04:02:12PM +0200, Miguel Ojeda wrote:
> A couple `Occupied` intra-doc links are broken:
> 
>     error: unresolved link to `Occupied`
>       --> rust/kernel/maple_tree.rs:96:46
>        |
>     96 |     /// return an [`InsertError`] with the [`Occupied`] kind. It may also fail if memory
>        |                                              ^^^^^^^^ no item named `Occupied` in scope
>        |
>        = help: to escape `[` and `]` characters, add '\' before them like `\[` or `\]`
>        = note: `-D rustdoc::broken-intra-doc-links` implied by `-D warnings`
>        = help: to override `-D warnings` add `#[allow(rustdoc::broken_intra_doc_links)]`
> 
>     error: unresolved link to `Occupied`
>        --> rust/kernel/maple_tree.rs:135:36
>         |
>     135 |     /// [`InsertError`] with the [`Occupied`] kind. It may also fail if memory allocation fails
>         |                                    ^^^^^^^^ no item named `Occupied` in scope
>         |
>         = help: to escape `[` and `]` characters, add '\' before them like `\[` or `\]`
> 
> Thus fix them.
> 
> Fixes: 7f51d867d2ed ("rust: maple_tree: add MapleTree")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>


