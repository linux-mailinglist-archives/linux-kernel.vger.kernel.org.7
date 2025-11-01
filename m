Return-Path: <linux-kernel+bounces-881232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D509FC27C8E
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 12:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 200673B0F1F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 11:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCE32F3C22;
	Sat,  1 Nov 2025 11:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="082QrFMA"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9EE1A2545
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 11:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761995747; cv=none; b=OWkyNh6FvoR8qXL9q3YzrG04HY4i1NMGUfQA8QVCyfluK0GQWUTPem+nVuOznP9vaM0Snl/Z2++8A5GpD7slADolsvr0OWpNdtPPC6P/+VQLkTeWgJKQ7QmrZLq5UJa9N3f3qqWCWkDvvAgETOpbnvXp2dFSJWHGxyTncBTIj+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761995747; c=relaxed/simple;
	bh=53L4Agml3krEnn3GEm4C8FtLZA7Y88RpvZUAfOW9in8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4E9iJfB+/UGB/8ysdPGVR1cd0obpjvuvm+5qU2hVPP3tAa6gtjVD7K/x3V7jLDPb0onNg9tMboU7MYyjC6P5D51QRiLmRzltdRlZqDEHA+9i+WxND5vbKRNuFPlx/VPXXdvM9xkTtpsAA89ZdliLzZ+JpEfn0FkaXQcDTfLrR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=082QrFMA; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-475dbc3c9efso17978565e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 04:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761995744; x=1762600544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ai02d9ytggMhjQZGGyjFxbHV7RPoREkTPHk/zt6GB60=;
        b=082QrFMAzdqnYNcD5FrlUYEDpqL+MTVfZS4ZGsudqVDsnkqhsRtoIkPpDanv2z/QDc
         D7bBycd6wbzEQXtPYEQyyVlZU6PqXodWed+l4X1BUc5lSn4r73/g0D2lU0zqfa43bPky
         vyYqpKRqPPh39B5xJx1PPgbbWP5PEHhQTHC2jmnkdnNQIzY8gzAXUizTtJB7nFbeD7my
         NN0doXwegkOtB29zUhqIU7OOsW7xko2NX52ulhkkIV4OqutRNxC0vqmusMMouM7Xe2pP
         +Wz9/KQhbLu7+TKJAEdeCLxMAH+7z8ETG+B/wuSpdjA/IrjRJCBtYGOr86y83OkPHbHa
         grNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761995744; x=1762600544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ai02d9ytggMhjQZGGyjFxbHV7RPoREkTPHk/zt6GB60=;
        b=BudJOeoJo1qxFzWdk82z2Cpo3hUeG6bE/fAWE0ldWEa2+/qasrdp5xygZLcN2ko4nA
         zml0czQfGCaTvRIxmHbmVGzZ9+wxaJ1hpJ+W0otNeX9w0RDsPv9nvVR5J8K3hlgUSTik
         +GvVYH+dbeS6mEalOnlubQ14cmNcetrWlpmtE3cCzUORbbkGeqW0HgQFOd96Bp/P+Aq9
         Pa6H8CR0nU5yyRWJXbwQvsiwdwL+WVSLsfKzyU1LZeZj0fVVHrHp6ibtTDH9YGS7hpKQ
         WP3aQPbeOIO9X0mO57UiNMp4PqcbS4ZJK5OfCIVbxkmCsrA5UjiPC/3UjdUvetb6lgNt
         PoTg==
X-Forwarded-Encrypted: i=1; AJvYcCWjQY0Jis09QH6NiNMTnfXhHO5eihVC7gPCv0ercRQNSz+hk5jULBOxUA6wNC/7qqvzoCfku8LPCDl060c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFyRpARyrS1okDB6CxrB/ESh3O2VwJ8xYoCSiwum42h+0AwFRP
	8+GdqG30zPNHpJMz4YAX+Xpj5c5V7OHvi2cyxk+PZWhU0dL+RTBSkWbHPp5USZAPAztQsB3meIc
	GoJnoO54mg6WQRK9S3SiVbw28uE3LcUXeyphRR/Bt
X-Gm-Gg: ASbGncs9jnyCjC1Jy1v/xRrRv8m9F5CKVwXyoNanZ1MmbXoFVUvHRM35I9yRd6IcgRe
	0xAfI5Y2q4IaJiL57kBUCZtlk2xuYmwSiDGP+1tIP3pWjtmxjLJDqrCdVPy7nc9zSli9DKI8NzL
	WND5DygQhBbX44FvJvFdNfcxQHXN+w2dXrhW+R6kh24T01Y2mMgCPwe43MEUyGg1Q0RYgNZ7r9c
	+Iqzt9eUa1mzZuoimqV4PNaSpze4c4HFiB1TZcSwICc/GDD0sWNy1qY0pFPNMQZ8YnpaMKO2hJ1
	iHA9oZw=
X-Google-Smtp-Source: AGHT+IHrIEVELwPGMqLbRWNgWbAG7AKm0IuH/YHGr2zDN7xvNJeF7aEkl72R6eP6GC+NpxMmGv0UTbdaiKEnSuynERI=
X-Received: by 2002:a05:600c:4687:b0:477:fcb:226b with SMTP id
 5b1f17b1804b1-477307b6162mr64979195e9.2.1761995743628; Sat, 01 Nov 2025
 04:15:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101094011.1024534-1-ojeda@kernel.org>
In-Reply-To: <20251101094011.1024534-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sat, 1 Nov 2025 12:15:31 +0100
X-Gm-Features: AWmQ_bmbaSU9JnSKerRHv6L6osQHqI4rsJcPefb_e0R-EWm-pbSdfEtmq0KM5lk
Message-ID: <CAH5fLgjC20QmK0s_6ht1edL8wSR3d-yrJ_viuwdOxTCQRpMmgg@mail.gmail.com>
Subject: Re: [PATCH] rust: kbuild: support `-Cjump-tables=n` for Rust 1.93.0
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Huacai Chen <chenhuacai@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 1, 2025 at 10:40=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Rust 1.93.0 (expected 2026-01-22) is stabilizing `-Zno-jump-tables`
> [1][2] as `-Cjump-tables=3Dn` [3].
>
> Without this change, one would eventually see:
>
>       RUSTC L rust/core.o
>     error: unknown unstable option: `no-jump-tables`
>
> Thus support the upcoming version.
>
> Link: https://github.com/rust-lang/rust/issues/116592 [1]
> Link: https://github.com/rust-lang/rust/pull/105812 [2]
> Link: https://github.com/rust-lang/rust/pull/145974 [3]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Does this need a CC stable too?

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

