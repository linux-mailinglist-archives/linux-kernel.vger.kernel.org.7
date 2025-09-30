Return-Path: <linux-kernel+bounces-837249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3187ABABC84
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D67171C2F4A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C62242D7C;
	Tue, 30 Sep 2025 07:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1Re8VBC"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF81422EE5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759216649; cv=none; b=Zmw26Zz3+UumxoI2NGW5cxzxmNL1l5M2vWIzcEaPWk2YsEXp4Co3BLCNlniJ9QSZY3XRSVKBoTGAn6SWjV6BVO8ieJzsrkSqGMnK2v7FADCtHb2hI6YObrz8ox4IfnLkejVi+1ea3+DuHBKY4ux0013hVOyyNUl/7DvcJ1En6dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759216649; c=relaxed/simple;
	bh=/D4lC7F+UGZr7Evn4mblI8m68a87qPsLaGhGWlKJem8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vDj9EOP/5uKiVfwJ98M178pF8Cqnfovs15p8JFPszzKkwJbdJIvIgGrksJvv0KqJnuRhFB+dPaWq2DWgRk63SE7afPuwi2KD9m599B1rw5U4jEvn5S4OApy3qBpuUirmnNYvVStI8vsFbHmNZ1A7cP3QYt+gz2XCxdoFRzhsloQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1Re8VBC; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-92c781fd73aso132302839f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759216647; x=1759821447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/RLYL9C2/J8Q8nWHpTOfcWgDV+Di6Gs1p9meRtJDAk=;
        b=V1Re8VBCkLcujQ649mKT7PUex8rLkfwEadFAqBSS7qyMebIr3qkCNMLAwDnuz6b2S9
         ilPTfkKU4xaZv8rCY7VyMfGsuIYpmpnKtdzFS0sDCEBmZVbuj64D4ZkRzYBokL59E1th
         Y4a9bcMN8te6lftPvU7rfo7zu7CPF0JGBYimNOpcsSgnnI1I9tU9AgxG7lUqTbQN3nEm
         fbbXL5a2PBKGWKdI/ySqdhzKs2DB0VG/4Cdh2N/SygnuYU8GWBkDbiOCVw6wgJu6ywvE
         JLOejQDCfk0NoVPMohg/Cr+yOuyxuEhVTekZBN8Rkg94PHZGh+I+SCFPV2M7++PCvCxU
         v45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759216647; x=1759821447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/RLYL9C2/J8Q8nWHpTOfcWgDV+Di6Gs1p9meRtJDAk=;
        b=LvFyuLFmZX26nkcvHjjJv27Ye/3lDNT3/iq8M1SmpRKgCLvTbn9i/JVEcqTZGKJKMQ
         ZDsEiaRA4Ssc4bM9lmSIpiRRKlr5zEJArglEMlUJsWv151j7NDCRFj4CQjdrlE2unPW/
         5ePDrwAMnQvJhYtGVmKW/UuYpaYFJwFN430tk0uKFiyic8UGqM3w82h9gTGTGGGWoq9c
         SGagxucGQAFn3hdx79zePvhsW9Ib50+FUmCD4Jdv5teXkGm6Fw9q7Qx9x7A+7X95NclA
         eirW74/rNluOVEdu6VVc75wYLbuAqab8vBC1i+0bgqMsCiVB4XpmjlFpZvz2qaRZsAio
         ubRA==
X-Forwarded-Encrypted: i=1; AJvYcCU0zYJjUi4HEC+bjKUUkhXSpCGv4N36LirOBq5jLKuiCIZbttNOGvHj40OepVPxFIcPZY6DA0VrqGtx9lU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbmVqUHXEQgLQrEwNaglhuhi/eFGUpCXOEItOnLain/CfdlS8U
	WJXPBnhbSPoZsOX0mIoKY/wCZ2RdJypUg5rcOZgf3IsbxPNI+9wDCQPN4oUa7gSsnkJp1apN+XU
	Fp7OJHOmDBqwlSSLcVZq4cXMzsCMxfKA=
X-Gm-Gg: ASbGncsmogytGomGJSNSHaZSxuyyUEW9tAML1a41uCcBiycDY7MbRi5zvJUqLkTVuil
	IMU0VfAm9Bp6bFjcZGMuliCyaDFV0x5FfyTDrz6ARYc1ZSvD8+ey7ImWWYY54tZ8cw8mfCVolCi
	nYdtPWPLl2qY64ZxYR1nFkPn5K/VOTUQ8HWKP59DnqUrXAkwCySfVf60/ncaiHA/t419B9o8Og7
	XCApv45PAksk+Ng93A6g/WlzfuxJK3AMsc+o3Nf/Q==
X-Google-Smtp-Source: AGHT+IF6oX4c1oT2QtGdImEkUmXn1fXUlDQYi0f+7OA8UeT8rnRYJ0Dbg7DVj5ZgRDIjPNT7QjcBtGER6b7SwehrbY4=
X-Received: by 2002:a05:6e02:1686:b0:427:511c:f86f with SMTP id
 e9e14a558f8ab-42bfab93823mr84067065ab.17.1759216646727; Tue, 30 Sep 2025
 00:17:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755235180.git.y.j3ms.n@gmail.com> <948a28f26a0e9924d82eb1d8d377e3ddc7335b24.1755235180.git.y.j3ms.n@gmail.com>
 <DD5VAPG2QFWA.2A58AL13VHPN2@nvidia.com>
In-Reply-To: <DD5VAPG2QFWA.2A58AL13VHPN2@nvidia.com>
From: Jesung Yang <y.j3ms.n@gmail.com>
Date: Tue, 30 Sep 2025 16:17:15 +0900
X-Gm-Features: AS18NWCt4CiaOBLLw6E3ZJGY5ZpvbTCUTklAJf6rpPrTAabktBULuqhmTF6POuo
Message-ID: <CA+tqQ4L9PN9n0e2A5BfGhn4n02v8LKSK+BRpHcfbK_fNUKBJPA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] rust: macros: extend custom `quote!()` macro
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 30, 2025 at 1:58=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
[...]
> On Fri Aug 15, 2025 at 2:32 PM JST, Jesung Yang wrote:
> > Extend the `quote_spanned!()` macro to support additional punctuation
> > tokens: `->`, `<`, `>`, and `=3D=3D`. This symbols are commonly needed =
when
> > dealing with functions, generic bounds, and equality comparisons.
> >
> > Tested-by: Alexandre Courbot <acourbot@nvidia.com>
> > Signed-off-by: Jesung Yang <y.j3ms.n@gmail.com>
> > ---
>
> Note that this patch doesn't apply cleanly in `rust-next`, I've had to
> add the following on top of it.

Thanks for pointing out the conflict. I see that the commit
9578c3906c7d ("rust: macros: reduce collections in `quote!` macro") was
added after my patch series.

> I suggest waiting for -rc1 to be released and using it as a base for a
> new version - hopefully this will also give time for more feedback to
> come.

Sure, happy to wait until -rc1 and perhaps we'll get more feedback by
then. Once it's out, I'll rebase on top of it and send v3.

Best Regards,
Jesung

>
> diff --git a/rust/macros/quote.rs b/rust/macros/quote.rs
> index 76a99f7e01c4..bb6970fd2a26 100644
> --- a/rust/macros/quote.rs
> +++ b/rust/macros/quote.rs
> @@ -147,33 +147,33 @@ macro_rules! quote_spanned {
>          quote_spanned!(@proc $v $span $($tt)*);
>      };
>      (@proc $v:ident $span:ident -> $($tt:tt)*) =3D> {
> -        $v.push(::proc_macro::TokenTree::Punct(
> +        $v.extend([::proc_macro::TokenTree::Punct(
>                  ::proc_macro::Punct::new('-', ::proc_macro::Spacing::Joi=
nt)
> -        ));
> -        $v.push(::proc_macro::TokenTree::Punct(
> +        )]);
> +        $v.extend([::proc_macro::TokenTree::Punct(
>                  ::proc_macro::Punct::new('>', ::proc_macro::Spacing::Alo=
ne)
> -        ));
> +        )]);
>          quote_spanned!(@proc $v $span $($tt)*);
>      };
>      (@proc $v:ident $span:ident < $($tt:tt)*) =3D> {
> -        $v.push(::proc_macro::TokenTree::Punct(
> +        $v.extend([::proc_macro::TokenTree::Punct(
>                  ::proc_macro::Punct::new('<', ::proc_macro::Spacing::Alo=
ne)
> -        ));
> +        )]);
>          quote_spanned!(@proc $v $span $($tt)*);
>      };
>      (@proc $v:ident $span:ident > $($tt:tt)*) =3D> {
> -        $v.push(::proc_macro::TokenTree::Punct(
> +        $v.extend([::proc_macro::TokenTree::Punct(
>                  ::proc_macro::Punct::new('>', ::proc_macro::Spacing::Alo=
ne)
> -        ));
> +        )]);
>          quote_spanned!(@proc $v $span $($tt)*);
>      };
>      (@proc $v:ident $span:ident =3D=3D $($tt:tt)*) =3D> {
> -        $v.push(::proc_macro::TokenTree::Punct(
> +        $v.extend([::proc_macro::TokenTree::Punct(
>                  ::proc_macro::Punct::new('=3D', ::proc_macro::Spacing::J=
oint)
> -        ));
> -        $v.push(::proc_macro::TokenTree::Punct(
> +        )]);
> +        $v.extend([::proc_macro::TokenTree::Punct(
>                  ::proc_macro::Punct::new('=3D', ::proc_macro::Spacing::A=
lone)
> -        ));
> +        )]);
>          quote_spanned!(@proc $v $span $($tt)*);
>      };
>      (@proc $v:ident $span:ident # $($tt:tt)*) =3D> {

