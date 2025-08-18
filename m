Return-Path: <linux-kernel+bounces-773494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D14B2A0F0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DAC9188DF13
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E38F31AF3B;
	Mon, 18 Aug 2025 11:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lm5TMHX2"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302312765EC;
	Mon, 18 Aug 2025 11:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755518207; cv=none; b=C/CiYE3FHgqg0nxz9pID1EUJtiiWnJtOyV+8XkqS4TOQCD/hSzxe6h5f5XO82iQkKnIKsoXB0F2WZSMkq6gYliDC+WOdUZgZQvfsMmuKutSZaLp4T5219fkvnJwu2Uyc+tg4TqwUs9C0IsdaEfCG8+uzdxn1VGhNZxJRFkq2ghk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755518207; c=relaxed/simple;
	bh=ABfmte1TMr5eOsa9OtpZSbd+wrgq/7Rybh+WOqQcv3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AQ1omV49IVtMlX0etZrg/OiovEQ2TW59PDmVDLVHt/SovTwrC9qEoBte3YNlTP4MqPKm57mgw0lvtcfARU8MkuUKHD+97WzNZ9bMp+2luFkxS2+S3/XHgNuhCjaoAxZ1HbBM/63CytzkvD70XgpU43hxTYyjryZwSdy/rRPXblE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lm5TMHX2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24458051ac6so6352075ad.1;
        Mon, 18 Aug 2025 04:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755518205; x=1756123005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V67ukvBS36PynTExAfl7K3TuffqJHkQtzYqDz1sJMxk=;
        b=lm5TMHX2PBgbbeeOmQEXrp5dSgdj/QvNAPZAfWIIoqU5P2EG6k/q8i/LhLmuS8uhi7
         PX1k2iKj1i0rzJFfdmT3YZqJze6OtMyfJYqjKZqNnBqZxxJAY+NTw5SyulgwEJzunBgD
         RMgKqIGKPStYWUWrIKLLkHKjxq+sGF6jYHCAkN/KrqB5RSgejeplJA4pmjaQuS0zSn6m
         9LpA+YrVNvcsou3SjxlErUd84myhNTj6qIm0nKp5Mrtv2tO8cE4RjHVw/H3wsappLKni
         9BE9VEfBkJ3wj14z9mT1uOYgcuTUJDBJTQjvihmBNvCT3WoFL6AtfijwIW76i+djli5I
         XABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755518205; x=1756123005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V67ukvBS36PynTExAfl7K3TuffqJHkQtzYqDz1sJMxk=;
        b=NUEiNgzWPN2P/nvYRp3ucJHnNeYwuLlRhpsNY1rLd6hAaRl7kS6UTR+HPzPi646cY/
         3EguWc9PwhYLeb6X48wI0r7/6pa6z73be4lG4jzmHadytUFrl3K5Fdhns10L9qFrRUGI
         AS9Mgs0gCNeXMUdupDJt8nueWiOU325wbftTdkZAR5SaE5Nu36I7lg7JClbBv0vtOxMk
         sHNu32sZaOrIXT1bHyGPH2qkfiOxowL1yxs720BxEkM55I6XLz15h0kkDdkqAazVPHcy
         Cy5acuCldJRzgrne3vQ0AM2jI27HY4hDJhGNI/vDN/Oj5JCPy8oHwdJGnAEvl8MnxJB8
         PIyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI0TMlntWVRwHtpoEAim9EAv0IVan3ugMCkYFoTci8ufDDKgKHjV894/da2h4tc5hB5HH5YmOjOg+fvfxlGaM=@vger.kernel.org, AJvYcCVpyOOyaboO4IU1TMogTHIIgAonNhNMV9wTAVdyBm1DJUztp54cl16eFX/dWpdC47eOQFgec2Ybr8a8t+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRFmkjjuoCKgJYOgx7NFPQD8CM6M1xzs6N3NuYs+CCwDAj/BVf
	WqPY6unIfJDqdA0IBsdGVMXtSO5xHBoM580RvIrRUTTpjY/8VpQY6FO/TZakBvJ/2mk3rUlO0Kx
	NTybez3Dh9xXo5fscg48Ax9ScX+ZhDD3VYuUwRoY=
X-Gm-Gg: ASbGncvws3au5Qp6x294sYY4AXbxQVB1MVXNPn+D3wnU1ZMmhhPbgykcSnb3Qi0M+3H
	xmRPG+XbE7gSwybNhDKI8JS8C5Nh9tlZUP6hacfBa3IA7L0POLNaYuA/JnuI2W9voaaMmJSiJQA
	onsDApp7RxfTdjnsUVbVHXRx+yUQynsdbDnwMQ4UPiWfXEY7JeVtRP1A5l4gLG0oRbSiHSMUYgY
	e4GtFH7
X-Google-Smtp-Source: AGHT+IG/gPJpsUe9Hw6RXHtL5/SVchcXyzwOTzlUv3ZeQ1/hqSeg0gPC33lI3TalvSss9XVQjDzgMEDzcBb9D2gFXH0=
X-Received: by 2002:a17:902:c403:b0:240:3c1d:cbe3 with SMTP id
 d9443c01a7336-2446d7435f1mr78231685ad.4.1755518205279; Mon, 18 Aug 2025
 04:56:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815171058.299270-1-dakr@kernel.org> <20250815171058.299270-2-dakr@kernel.org>
 <aKLzrp0m00J6CCYz@google.com> <DC5INEG2DXU5.DM4JIICEQ2PC@kernel.org>
In-Reply-To: <DC5INEG2DXU5.DM4JIICEQ2PC@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 18 Aug 2025 13:56:33 +0200
X-Gm-Features: Ac12FXynbCAPmTPp8j3I58p5no3GNZj0rUlZcOC00Gsq7s7vkIBA7YBOVsFTFdo
Message-ID: <CANiq72ncROtm8Qkv_W95_Gigb1aVhq85zZ37itN-jHGDgTUJMA@mail.gmail.com>
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

On Mon, Aug 18, 2025 at 1:27=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Does bindgen ever pick another type than i32 for C enums? If so, it'd be =
a
> downside that we'd have to mess with the type either in the `repr` or by =
casting
> the variants.

Yes, it can easily pick `u32` -- the variants are always `int` in C,
but the actual enum can be a type compatible with int, unsigned or
char; and `bindgen` generates each variant with a type alias to the
underlying type of the `enum`, not `int`.

So e.g. for

    enum uint_enum { uint_enum_a, uint_enum_b };
    enum int_enum { int_enum_a =3D -1, int_enum_b };

    _Static_assert(_Generic(uint_enum_a, int: 1, default: 0), "");
    _Static_assert(_Generic(uint_enum_b, int: 1, default: 0), "");
    _Static_assert(_Generic(int_enum_a, int: 1, default: 0), "");
    _Static_assert(_Generic(int_enum_b, int: 1, default: 0), "");

    _Static_assert(_Generic((enum uint_enum)0, unsigned: 1, default: 0), ""=
);
    _Static_assert(_Generic((enum int_enum)0, int: 1, default: 0), "");

you get:

    pub const uint_enum_uint_enum_a: uint_enum =3D 0;
    pub const uint_enum_uint_enum_b: uint_enum =3D 1;
    pub type uint_enum =3D ffi::c_uint;

    pub const int_enum_int_enum_a: int_enum =3D -1;
    pub const int_enum_int_enum_b: int_enum =3D 0;
    pub type int_enum =3D ffi::c_int;

Then there is this issue I reported to be careful about, which can
change it back to `i32` if there is a forward reference:

    https://github.com/rust-lang/rust-bindgen/issues/3179

I hope that helps.

Cheers,
Miguel

