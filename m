Return-Path: <linux-kernel+bounces-737914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFF6B0B1E5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 23:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B4EA189BFD8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 21:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4040194A60;
	Sat, 19 Jul 2025 21:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNlu+86D"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65FE1FDD;
	Sat, 19 Jul 2025 21:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752959177; cv=none; b=cSbj/38I157smRUjdS9jkjlADiyeDGQvnSu8s+WlVVsfTiMZ/Bn7wxyeGNeBQAzWibn5R+xk/+EdEYLzPpX80U4NuQdfOCprgmy0nD8y0IIPkaxdYFp9oLodJz2iWxWvfrOQ6EeRlFXbgFZ+/m9mbmYs/+6QbNhrGXkfohLd8CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752959177; c=relaxed/simple;
	bh=nyswjgChzex87fkUmGlz803mOXSUIG3Re0obcW/WBZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lAZDCM7J4I1J/DHRh/IzC02xVFZ+ptArdoJjyOfi8hwW1S2+UHU1rNsKWF+RQ/dmZK2knt/y6wm8lUVDthvV/dS6XUjXZUTwysTMXy51z8f9FmVLg37/KGbIXc1O6UTpm5zh7hwp5QOGlCUzpIyTZRgBAq7rG0e+Y3g/n1fo8l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNlu+86D; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32f144d0db8so16486961fa.0;
        Sat, 19 Jul 2025 14:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752959174; x=1753563974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDD5lvVgbLQzMHEKqvD4drpjZqiteKdnziSv4nMIVYg=;
        b=gNlu+86DYbRamez5QJVoSpcor7vbAtBZBywsW5qM31QW38a3M9WCZjKbXt9KoPLfr3
         NPRfCZTwxAR4/4Hh/PpBOMNdvQmkGVVO/eh7EnWNV1cCGY8MUrfV439aHuBCiLTDf9Vt
         bdTqs/cmNmSFnC4ssKBBm3vMBv7rqlH9Tlkm9hmYE2NB+gvRU9gCFGW2kwlDW+vqQXzb
         Br9zjP1K0QNIl8YPqLr2zBXngCP+HfzjBVnolgBHTbuvcPD24VKyBuRoRAoJtlDmCLgG
         6bWRecZ7acGns3y8RXtzr6ALCArIMluFlCQN1/gDNLlbWRft4VwC4zqnT/Uhe1hXqYJ6
         8WlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752959174; x=1753563974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDD5lvVgbLQzMHEKqvD4drpjZqiteKdnziSv4nMIVYg=;
        b=wGWLv8dt1fjmxHBj0LwLA5g8T2IM8tqdRaMg81NfI3Ram2JkO3eJDCaFd78mURNfdO
         ybXlO0SuNvWNxI8AfckcMMymSoN+sk5Z+rbEvQesrce21EVJZf+S7nPoM+Gaml/Tx8zJ
         I1EVbH39lmWVdHZzSOYNXbq6TJC934KhQ+aI9+IU/XaXDCPDbRi61ZPSD46nv1AM6Wrd
         LekLcVZIoJML57NgqeRzIpxmayHwOoAW5MydfUAkpz58bJU0P9TSNwZM8dCXgjSXi4hb
         DQDS+R4V1SfGZyqc7OhmU+0yr0dynjOTSj/ifz2YrEOO1jufzDN9XH4i4Lix5BrZ6rax
         b4Sw==
X-Forwarded-Encrypted: i=1; AJvYcCXVDIpOPqOEVr+UbUP0RjmaureCaQB3iehBJCBxvpi02Wia1u2MOkMuB6mrJyt9CL41ZtIYcJYzaUS0JGbSQOA=@vger.kernel.org, AJvYcCXzQmS/l3jdN/+d8B35XXDb/xFaQvHWjY7PaOMkrYVrFdJhvg7ppsVfByodeKKWNBJfNX0Hk98q9pupKcg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1PQCGVA+KQizmXfFiAoq4hWPbL8/YybXh+37SqzyfCCKP7oOa
	dnGq/t0pwXD8Xw9x020a4g1Bo/iSvDd9w6QxKrQoZslVPJhdj2qmNvtNEdBLzeU+F1Otd5/rGXH
	SrA0TDU3PjvBVuNPmaUyIyduaaI+y/pY=
X-Gm-Gg: ASbGnctGajeTFlFvqHtDLrZywdPtIU/0FJw6vBZHcJHv0k9JF1nNqF3drATmoqK/2ih
	7CbUNSBtP/K32magep+Nj6pW6mQP9PhKg/oI/c14Gk5L2augftihcdtI/8prkb0OE+p4m4JB8lV
	O2WlZjUSYRg3ZJ0IMXzOB3ZGB32fWdG9i1LFrbcVaY8Z6k2MTMcgowJEl818i3M7lTf1ecN5X3g
	Qbri1XzO4aDv9zlL2olPyrzOTk4NmG0sXj++z6DaA==
X-Google-Smtp-Source: AGHT+IFel6LcPVo3L3MCsNHOrcdqbyyvw2loT4c8a3F8Eu9ST3sLv5A/WpAB8b1q4cUP+onWoJI49Fm8mHtQap8cx7Y=
X-Received: by 2002:a05:651c:b28:b0:32b:9792:1029 with SMTP id
 38308e7fff4ca-33098f6680amr28756151fa.14.1752959173475; Sat, 19 Jul 2025
 14:06:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250719183649.596051-1-ojeda@kernel.org>
In-Reply-To: <20250719183649.596051-1-ojeda@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 19 Jul 2025 17:05:37 -0400
X-Gm-Features: Ac12FXwNuJFlNB4FrlOz_4LZnrwumCxbRuVE87wbB2tt8bbMYaX8TCEyZEcw5sk
Message-ID: <CAJ-ks9=Ye4v4g0roTu_CJSveRwj6c6P95kGfzy29VEh2c8XHKA@mail.gmail.com>
Subject: Re: [PATCH] rust: list: undo unintended replacement of method name
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 19, 2025 at 2:37=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> When we renamed `Opaque::raw_get` to `cast_into`, there was one
> replacement that was not supposed to be there.
>
> It does not cause an issue so far because it is inside a macro rule (the
> `ListLinksSelfPtr` one) that is unused so far. However, it will start
> to be used soon.
>
> Thus fix it now.
>
> Fixes: 64fb810bce03 ("rust: types: rename Opaque::raw_get to cast_into")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Tamir Duberstein <tamird@gmail.com>

> ---
>  rust/kernel/list/impl_list_item_mod.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/im=
pl_list_item_mod.rs
> index c1edba0a9501..3f6c30e14904 100644
> --- a/rust/kernel/list/impl_list_item_mod.rs
> +++ b/rust/kernel/list/impl_list_item_mod.rs
> @@ -252,7 +252,7 @@ unsafe fn view_value(links_field: *mut $crate::list::=
ListLinks<$num>) -> *const
>                  // the pointer stays in bounds of the allocation.
>                  let self_ptr =3D unsafe { (links_field as *const u8).add=
(spoff) }
>                      as *const ::core::cell::UnsafeCell<*const Self>;
> -                let cell_inner =3D ::core::cell::UnsafeCell::cast_into(s=
elf_ptr);
> +                let cell_inner =3D ::core::cell::UnsafeCell::raw_get(sel=
f_ptr);
>                  // SAFETY: This is not a data race, because the only fun=
ction that writes to this
>                  // value is `prepare_to_insert`, but by the safety requi=
rements the
>                  // `prepare_to_insert` method may not be called in paral=
lel with `view_value` or
>
> base-commit: 23b128bba76776541dc09efaf3acf6242917e1f0
> --
> 2.50.1
>

