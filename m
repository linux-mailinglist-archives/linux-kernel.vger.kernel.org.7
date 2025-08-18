Return-Path: <linux-kernel+bounces-773547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB80B2A17F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02B604E43CD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6AE31CA6B;
	Mon, 18 Aug 2025 12:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHkDlhAL"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA04D2765F1;
	Mon, 18 Aug 2025 12:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755519858; cv=none; b=cnKmdhS21rLIVUaSR1C6HdZv+C1U33mPAOuTrgmOHhRUrCaYUY4zkcyltcSszkzQorUyc2x5O2kHgZC8lC3tYk5dHvclCDN16e/PSR/gO53jvXaD8DDzoVoJutoj31FduSEn5oj0CH5vuUBmK9HjgOGGV4qGrK55qUb/IO7QKUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755519858; c=relaxed/simple;
	bh=YDeulKZRohKjfolnyPb4TZI66hEnspG3mULKzotC+mU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iHyk/Ehk/OvlqoYTdHYFUQcekq7Ha8mCydV4NO4u9xtSjcX49yDQ2aD7BqWEStLHzsRbxyCBFRVNGZEeBZsss/sxgn/Tr9efWy8g/BQd7VSTvwEuEIRCxTFmeANhW5psGDs54D+KsuXp/mQ9zoOeBcN2flL94UnHg8imBeAl0UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHkDlhAL; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24457f4ff1aso3975105ad.0;
        Mon, 18 Aug 2025 05:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755519855; x=1756124655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkuNB+kVlM2Vl8F5Z7cJgcGRa4zKwkWP5+HtmcqRDdw=;
        b=fHkDlhALNcpAia2260aH5tqgDwse4n6hTEgcBVDEhgb9hsAAfs0jI0oxDktDmWAWRx
         qji7LP25hHfSIWVNR6HleqEiMS9iUPyDIl7Z6vGVTYNN6tOx5zy9oRpimPYk7Mot0T9i
         LbYdFUWXC20a3kfxKGQEmuggbSdTPHdDF2ercrDRQMDqhJFNG8x9SIETfldOyPJ90xFS
         YDvNv9Dw++Qh9PDKRn6YCqJJxNP32i5uTIb/qn7qGPxYDh40uALNRFtcMIQNI2f5pop1
         PpRFLWmxHYEjGdatIf383k8U4Nacaec79P/0Y8IVVWqBuu3HjdcH4aaKH3exdIG8ff42
         0UBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755519855; x=1756124655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkuNB+kVlM2Vl8F5Z7cJgcGRa4zKwkWP5+HtmcqRDdw=;
        b=eWAKwukgn2AW/LpPWm/nB8Ry/AExcTW4nRwjEkZ+3zBheScl/Mun49G/sYACoCo93I
         S8hJlAkXPDMo5SNOFwt6G+NeXLXVoUfy4vPtc9xkuQ2nL19dxNGrWy+dP9YsdCc23hqI
         DVrXn02rLtE48IsU4isJoXhHN729M9QGZ7iCwEPMaNNFm86QGXeDqZqxDo2NykXhUjc7
         Dcp8GDMC7Cvm9yzWmDlyJoBb8mluvBJ9qoNx6lVZ+y8DVX0EmunIeKRcoKrDtE5DPKYf
         4OXM5zP+huxBJYe9iRTWEXV2LvYwrQmevc2ObILu6IrYpXyYFTlTRmaJM+2pgkSDsedr
         2Rjw==
X-Forwarded-Encrypted: i=1; AJvYcCUiF3md7LYrBpfdOfK8KaOxovsPCe6s/8l/5QNLyAe3cOAtPIgpdujlAnKstrYbzWjPaUoDtRoUTRzEVUCXWbE=@vger.kernel.org, AJvYcCWStXO6CKGBHzJlrZHSyNYs7UC3mYFZElg2Y1cbq0AKKIdAyTS2g6N6WjWJ6LRmPOxwJr+HI/A1LXMSba0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr2jy4vOZND7RGool27v1FIZsxjECuyyQWj9B4eQEL/7WpIEyJ
	IsDsbfgSmTzkH5rlcySmKG1LePiIf6ELnKs3ProfmPWme1CoFxGovsM8UmUAbED19bgudsrevtq
	Z0n0CPb7YqKHmI23tZ04L+rLmHSUugItjAKN8hBE=
X-Gm-Gg: ASbGncvVu4g1M7Vr8Jj7uCB+zKgnP57mUgSwy6KupxvP9GW40y+5i9ZOWuXImXKwROk
	psXOtw+vwETm82g/chEPK7XZSC/GAJsmTRcTWWRca0twJCiYNzyPLWXNx8SaGL0ePJdNzhmSKxz
	0pcW1HjWuHc+6PB8rOXs31uH+Bw/TouAxFFfF4lbIxilZSKiS6iTS2cAzvVBW9BhNj4lcpQNZkV
	cVVaxsm
X-Google-Smtp-Source: AGHT+IFNk4ME0DyTYux6g3gCHfJWG7qqmc8MpoJX78ZpWVv4kM4VwPlZdhEBMnCwkuHSSfbgxsP99blKh31kn9uNA0Y=
X-Received: by 2002:a17:903:1a70:b0:240:11be:4dbe with SMTP id
 d9443c01a7336-2446d95b26cmr73589225ad.8.1755519855112; Mon, 18 Aug 2025
 05:24:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815171058.299270-1-dakr@kernel.org> <20250815171058.299270-2-dakr@kernel.org>
 <aKLzrp0m00J6CCYz@google.com> <DC5INEG2DXU5.DM4JIICEQ2PC@kernel.org> <CANiq72ncROtm8Qkv_W95_Gigb1aVhq85zZ37itN-jHGDgTUJMA@mail.gmail.com>
In-Reply-To: <CANiq72ncROtm8Qkv_W95_Gigb1aVhq85zZ37itN-jHGDgTUJMA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 18 Aug 2025 14:24:01 +0200
X-Gm-Features: Ac12FXwG4Lr5SxQVDVDqHE9t0Eygc1otdM0r7jU8zZy9Ntvv7hvS3r00c1K6H9k
Message-ID: <CANiq72=Lz1jH9C3XT5YLdHxjSUyBE7FethmBBRbXRbJdC29FJQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] rust: dma: implement DataDirection
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, akpm@linux-foundation.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, abdiel.janulgue@gmail.com, acourbot@nvidia.com, 
	jgg@ziepe.ca, lyude@redhat.com, robin.murphy@arm.com, 
	daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 1:56=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Yes, it can easily pick `u32` -- the variants are always `int` in C,

And, for completeness, if the kernel eventually uses C23 enums (I
don't see any, from a quick grep), i.e. with an underlying type, then
in C the variants will actually have that type, not `int`:

    enum c23_enum : short { c23_enum_a, c23_enum_b };

    _Static_assert(_Generic(c23_enum_a, short: 1, default: 0), "");
    _Static_assert(_Generic(c23_enum_b, short: 1, default: 0), "");

    _Static_assert(_Generic((enum c23_enum)0, short: 1, default: 0), "");

And `bindgen` will have the underlying type too, so everything matches
in that case:

    pub const c23_enum_c23_enum_a: c23_enum =3D 0;
    pub const c23_enum_c23_enum_b: c23_enum =3D 1;
    pub type c23_enum =3D ffi::c_short;

So, in a way, what `bindgen` tries to do (for the normal ones) is
behave a bit like these new ones.

But I always wondered if it is good or not differing there.

Cheers,
Miguel

