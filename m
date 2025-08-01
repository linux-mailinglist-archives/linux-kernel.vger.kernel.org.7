Return-Path: <linux-kernel+bounces-753723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EA7B186EF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF739543724
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1871628CF5F;
	Fri,  1 Aug 2025 17:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0QKJ9d/D"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9C01AAA1B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 17:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754070974; cv=none; b=ovyuaWA0dzM5DMVUq5QbNSUJ9y6f7JdrUeQz3JzfjhsID9hO2yXYxPRsBId/H7IF6uyPz8YvZAXVPquJ0ADfYho+av2U3A7wdKfO6n7ANZdo3vW5xAtsGZm2LmeLEXorZkjZh8pMoHYjdKle8FyKAUPv3EtrwHRHfHpH2XJoeO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754070974; c=relaxed/simple;
	bh=0M/tJPfKsbYH+xw3E6m9VJlr0c68OrqSrrrzuvjYw3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f817jgqgwbkHpiB0wJ9oWYcgv0UbbfxJUsb7LXpUdAWTB3xv+89z9TZroF2YvlT35OIycXTOUhZvBX9uKmyMuhSj1VdGuFvRjQFJxsntkmmmK+hk8yxH4zIif7EhxUyraqaIA7NujTJjv3SjM6KRnwMaES//0lALkpsXNeEEvJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0QKJ9d/D; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-458b2d9dba5so3471385e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 10:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754070971; x=1754675771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfAsYAfR+/YK9jsRvUDbKg5u2kXyF1RTviQ65IrOhxo=;
        b=0QKJ9d/DOYaLUpsRI8McY6kaeO7KPaDWxo9DfDxkS7eSiSHA82KMy2Jglc8lRKzAp8
         /Kz+r4yquRNhpJ/x1/gs+EuxkfDMSfzn9P3zxtcz+LRuT2Mf5D68BJUSHVDQU+FXi899
         zoxWORNcgUIKcuErQv5j175alfk01uyN6x45TXeVkAqDQTlrzQLLK0DChqEurGciN1Ab
         ecMJ8dEjZRVhhJ4Rrsj2KfbcVcNcRy/Lv6cm0n7stY+aTvGfgpigrlM24IQBL9MNYxAS
         /cgpIjxZCiCBYVPVNIwgOyw7ljsfS/6hdIfjVjQ7UzvcT91FToGFe3mg9OjL2p5nKj2Y
         qSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754070971; x=1754675771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zfAsYAfR+/YK9jsRvUDbKg5u2kXyF1RTviQ65IrOhxo=;
        b=LYUUQ0583/mMTrjdhCZxDBhL5bwA+cqBNBc0pJFJ8XGIulfqvXbuFicRrVcJqDgjYI
         /BQAee4sQ+c7g9cgVrYIbiubyolTNOqCxh3ZVnp//guWYM2Ipne8yzyi5mYLejwvSDOu
         2vSyiZOqDHbf2vwdeLWStEI8KjelAUO3WcR9nGIMBSPMveRppZ8A0IKE75SAoVwWcu7e
         /wLllhg9QKsCWlsr0NgCEJklgDqYZvqNsPBkbmoJ4yF+UEsJ7ePePGE5e3tO7vymjQTQ
         8yC1pePneJzsgyaDHZSmf6au8OudfgeO95Cegy22Fj5sTQzarBgFn9jBmmbsY9nvlg65
         ddUA==
X-Forwarded-Encrypted: i=1; AJvYcCWOBWpASa0f6PDaXtuvzR7kHjcOJCOrCGUON1QmPEUSNx0XPcwjD9J/DH2TipSktNg7WXwyGYTyomYWRlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgtPiYRdmaQPivufaxZWShW+a1Bio4n2b96hCnBoiJdgT2pHQQ
	9n2csv/G1uke+SaQ2VckkAEmhoX7L1J4C90S9N+U6bWIaweVX8C0TIncWULbOB7es9wAijXxWgw
	kbQE4Z08C0geOnG1PzYrucUKhM2MMKT+/2aofJPJ8
X-Gm-Gg: ASbGncszRmiZJRH8Z+Ct0ZBnFXMmyUUCkuCnk/eHUz5pNhjMgr/DImIHTM2bg4KKwQB
	Itafai4pCBR7ANup/rbJy8ndm+it8Tgi+rPijUQ32G/6E8NxnQOyOjWAzvDrMF6oBI89UkVer37
	1oaFKTs+8TB9qfiHUgOR7nW+gqm2UjOzMSkcVB3I75SS5h5g9dezolEfcsu1ff8DP2ooo07SG4G
	Hto/UCP
X-Google-Smtp-Source: AGHT+IH5iyoraxt1MqhsOV7Wo1Vl0oy/M8gdsqvDQuvj38MG42AcgPxCKrGsYFjRYglZAErHpBINtAm5x8csp6uGERE=
X-Received: by 2002:a05:6000:401f:b0:3b7:8914:cd94 with SMTP id
 ffacd0b85a97d-3b8d94c1367mr465035f8f.41.1754070970934; Fri, 01 Aug 2025
 10:56:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801161752.443431-1-ojeda@kernel.org>
In-Reply-To: <20250801161752.443431-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 1 Aug 2025 19:55:59 +0200
X-Gm-Features: Ac12FXyPfPflOZinXuov3eku6WJJUyueclLsgVuYKQ--6v94gWhcCn1e-LQsq6c
Message-ID: <CAH5fLghFKZgW8T82ZKQNAANfhGBEQG2oLE2rmUOAb6N9UDEMhw@mail.gmail.com>
Subject: Re: [PATCH] rust: prelude: re-export `core::mem::{align,size}_of{,_val}`
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 6:18=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> Rust 1.80.0 added:
>
>     align_of
>     align_of_val
>     size_of
>     size_of_val
>
> from `core::mem` to the prelude [1].
>
> For similar reasons, and to minimize potential confusion when code may
> work in later versions but not in our current minimum, add it to our
> prelude too.
>
> Link: https://github.com/rust-lang/rust/pull/123168 [1]
> Link: https://lore.kernel.org/rust-for-linux/CANiq72kOLYR2A95o0ji2mDmEqOK=
h9e9_60zZKmgF=3DvZmsW6DRg@mail.gmail.com/ [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  rust/kernel/prelude.rs | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> index 25fe97aafd02..198d09a31449 100644
> --- a/rust/kernel/prelude.rs
> +++ b/rust/kernel/prelude.rs
> @@ -12,7 +12,10 @@
>  //! ```
>
>  #[doc(no_inline)]
> -pub use core::pin::Pin;
> +pub use core::{
> +    mem::{align_of, align_of_val, size_of, size_of_val},
> +    pin::Pin,
> +};
>
>  pub use ::ffi::{
>      c_char, c_int, c_long, c_longlong, c_schar, c_short, c_uchar, c_uint=
, c_ulong, c_ulonglong,
>
> base-commit: dff64b072708ffef23c117fa1ee1ea59eb417807
> --
> 2.50.1
>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

