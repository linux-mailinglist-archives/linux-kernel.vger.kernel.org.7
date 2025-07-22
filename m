Return-Path: <linux-kernel+bounces-740753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8317DB0D89F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DD4BAA09E2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A732E498E;
	Tue, 22 Jul 2025 11:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfkfuBIj"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227552E426F;
	Tue, 22 Jul 2025 11:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753185293; cv=none; b=RsivHQEoxFMcp9iZ+WIxH2uDjnqsBpKOim4zMLJKWTx2c57M6GajrqvfMnVocoY6Wo4MLuhU2Ub8iPx9Htuv9oWgq8s0fjFpWXlaCMXv/5GtEbUrB06H3gckh2aXI5S0rtJclO/16ZRVU1VDmN7f3agk1Y10L6Sr4RUQQGR54zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753185293; c=relaxed/simple;
	bh=E4Dkn7NcDpEWeXn2YLmxaE2xi8IMfWGpUCj/kG/FlVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IqLqJmCIIcrHL/nCF1ESksrqZVASoO5/KM5mu8gO5FQZCsZdYAoF/IcuFX/X3PJgqmxg7t8BH2PeJ6eOGqXC6EbYGlv5nh7xK+fW2YaGPTBE4H5fJYibkmr+lkXzy+2YPYdJ7/UjMKQS0j2GPuU4XCeYoyDICHd6F/CJNwsFsBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfkfuBIj; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-31305ee3281so1028927a91.0;
        Tue, 22 Jul 2025 04:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753185290; x=1753790090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsezFB7twUsX0ZLoOlHE3YcVFcZntXYTioAJAcm+CZA=;
        b=DfkfuBIjQv6H5MD0UGQr8//Hh1jXe2ljnJoZU77s23F6aGAXsKOeN//5XrsYY5pOmc
         PRBOtKUtycmt4pAad/aHZCbzmPps81XvJ6KOh0gIB7rZ02KeObNcbkBeWpzIkspQEP/0
         r94agv92W2dluWDaswp51rmqQRi6NRWcFHMnpi9gwC2OhAx2uV7frM56XH6uSLFXv9/8
         MrKddxHOt1IeAlQIrD/tHcs1usB3ZU+sFjoMXAljMYh52GbtLDK2rBA8IPjF3pd5GsqS
         gTKVvVm0gesnwipg/KINeV7lYo6BsLu0UAuRdTXLDfa9OqSv4hu28HJ59nuerTTk/Ium
         w22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753185290; x=1753790090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsezFB7twUsX0ZLoOlHE3YcVFcZntXYTioAJAcm+CZA=;
        b=RRictmgegHIW+oNi9cHS1j6+HK1ON2dgm9ZTsq25Jc6Rk15p5tgaCtg6vV6B0nceB5
         Rj3YnHM2vaxU4BuSemCiNAjJffdnfZ0SfSMQvadIRu2IqLqu16rQkHYb91QoQVd5MNtI
         gWI1aNit/eh6bgyUVBe/+B7ab/gs1RLzCxqPBBoekYDjhzXRd7kYV1GN1wBPmiAEtr+J
         TPgiCBEuwGj8opC/pVYYMyZqATvub8uVAzaRyT02CD0odWR4EV/yqFpcGMy5i/ESCOhO
         R4BozvvgYvf9AogR359xp2asuVy4YH/6zjLdECUzndJBIzrqOS6McMrO7lrb87ObALd9
         3w6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWgn05eUlw4Xzyt0EhcVK5MVBzENVvzHZO/ROv5baH46zBMJudWEyO21Q5YnKaiIYwKj7kGBoBZ78PzB0sIw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo54EZhTmqzJlmstkqLfcVBytlCziv5bxu/RYOUE3aUlosLeE3
	qXX6XGI9zMG98HX+JWTObClNJ/WqZmlr8V4kMFiVDFQ45AeCtpMChZxZ3COvC5l2hNUqryogA7A
	F2D3PJFLJqqiurD4j2o2qRk9a85LEh6k=
X-Gm-Gg: ASbGnctNHVmltBKLFvUB6oYa3AxTl+yZniHVQQww+xoxUmnruJskUGTfbnyMV+zIhzH
	4fYgg2HXZNb5twm/nrhPOPaHL++ecxFC7TovF2e3vHMJztjCOWJ58p6dYlHUJzzxHLMCOf+7t7C
	RSiUThN1eX6H1QpDNgBwdWhmkwxnI8ClCewCN/yYtuF0ssMPTicQ4PDE+shaIUIQOCJ1W3GH59L
	zBqgEWA
X-Google-Smtp-Source: AGHT+IFN8QsBpc9vqEF7CDmMc/H+QcSObQg2oPTwam+LdjpEjHnRaTYJ6LwjpNfNn87QDwhqb76qm0JnbW+q/EaeZTc=
X-Received: by 2002:a17:90b:3f8d:b0:311:c939:c842 with SMTP id
 98e67ed59e1d1-31c9e7a4012mr14165173a91.7.1753185290308; Tue, 22 Jul 2025
 04:54:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715110423.334744-1-shankari.ak0208@gmail.com>
In-Reply-To: <20250715110423.334744-1-shankari.ak0208@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 22 Jul 2025 13:54:37 +0200
X-Gm-Features: Ac12FXygerF3kHBo_KQpx_Goa9PlBBf573EIFyf0aW1IbiSF0lAzga6Cro81Jtg
Message-ID: <CANiq72=zy_EKX9gvnb3V3f9jrR2QpgAHpUFWgJWVadaumv2L+A@mail.gmail.com>
Subject: Re: [PATCH v4] rust: move ARef and AlwaysRefCounted to sync::aref
To: Shankari Anand <shankari.ak0208@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 1:04=E2=80=AFPM Shankari Anand
<shankari.ak0208@gmail.com> wrote:
>
> Move the definitions of `ARef` and `AlwaysRefCounted` from `types.rs`
> to a new file `sync/aref.rs`.
> Define the corresponding `aref` module under `rust/kernel/sync.rs`.
> These types are better grouped in `sync`.
>
> To avoid breaking existing imports, they are re-exported from `types.rs`.
> Drop unused imports `mem::ManuallyDrop`, `ptr::NonNull` from `types.rs`,
> they are now only used in `sync/aref.rs`, where they are already imported=
.
>
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1173
> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>

Applied to `rust-next` -- thanks everyone!

    [ Added missing `///`. Changed module title. Reworded slightly. - Migue=
l ]

Cheers,
Miguel

