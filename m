Return-Path: <linux-kernel+bounces-767315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B63B252C0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F695627405
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2339B2C0F65;
	Wed, 13 Aug 2025 18:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RJDJwV/L"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52752877F7
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 18:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755108318; cv=none; b=IpeNoIPC+VrKrfgsqCErMuUDdBUarIgqzce5Zk4n5qfTADsALFe1aIEJDGOejwtCPZMEYkiYCFgBcT7k6zs0f3fai/PKHoLtwVsGsfl8/KpRsx+z2VsJW+mMR1nfrUMWJEuTk2VziXw53VhAZZaw+ACWTK4nR4aU8/jMSqLBjpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755108318; c=relaxed/simple;
	bh=Vg7gh9cfy51BXM2JMJDjES6VAxhOmu+e+zQgq91e+7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHzNfoZB608qSM1ArxUgmNbxADznHFmDCb1A7cshatboEFsUtBOo1t4zN/IgmFdZsRlLdM+PokxwZgzhQehXU2rZ6ExKMBDn6gY0+lll5NEEuvusj5nebS/HEACjH74WOnjxLDucLys7tdLtrhUFlExE8Uv+uKjyWozZEbK1E/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RJDJwV/L; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b9e41101d4so57730f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 11:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755108315; x=1755713115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZhIj1HIBrkAfuxlxrCJHN84IlcctzUEsdAGx6WHyfc=;
        b=RJDJwV/LeLboJG6zJ1QJ3HkuKwsinxrfP/CMzgxK62TZgm6hbVua0hMxWWFJ5NhUk+
         /1YFjvmg0ZCxOhkf8KmWAGEzq0bfMImpjbd+ggr+2Ch+lYFPADFQKpxLnXCflvODvNXf
         XGScLq34OSxy3kZBdjHEWhKpU4BPcdQv6owLRGqNUo/PA+Q0ae7HLEmCAvYxtJ2kvaKO
         7VFBWPmr7ej/jgT7+KTwXqCnbJB93rXvFeErGnju6bMDnDMCKdLMbXyMwqfZ4o/FEDs7
         QN8p03bfmIsD1NaZ5o/efkO0+Bz94z4jI89XUo0nsJBPaYYudYFWKcqNm+vIb1/wX41x
         Uc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755108315; x=1755713115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZhIj1HIBrkAfuxlxrCJHN84IlcctzUEsdAGx6WHyfc=;
        b=iin3iaCpORYA99C+fPoHh1hzLqjeH7ID09J1HK915nFOC0JM7JkrLPjg0Wt0dgnINi
         N3wFLzXC0ZgPUKxAxGtRsPLYZuX/JNUtPC7hkGj6TVT48OhIzZVKxP+s7ECerd2GWd6B
         yrFSQUij3o6BBC8TJuj7e14TjG9ZBLQCsugHyd87NPtqiYBzM89O7BMIhF/pCQ45rt6x
         +lfYTjlZ2fjarH3Vuh6TPtk+W5m4MHsIWbFctUdnDcZBuCQp6K+8mOeUniaMtnOyQz2K
         T2QiM5dwH+sUJh4bMrPPXjuQr+Uw5ox4ES/mQ66OBH41+RFbbvn07SH9YdLfF+vJtpJb
         nTFA==
X-Forwarded-Encrypted: i=1; AJvYcCWsRv7dD0qePIox7/DPjzjyjam4a5/8ySuzcyX56JXjeyH5FgoUwp1D0dkDqcKqmiKYw0ByNhpeEzkhyuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrjZ902zwNNR3lqM41JhC/AHBQ0bj0eTCn3btyTbe3O4vWcUAe
	/rud/3uIyt4e+ts8RvdCGB5Z/LknzlBCGGUBikNwrpFBNCkhW4NZTsmMgIILFlA5PLLD3Gmz09j
	3d4AfOP4+rn+OFoE9H2TX7ooF5JIDLIOALM+wMwyK
X-Gm-Gg: ASbGnctX9bigBaufuPdSLkHaRv9cPINl4ZYTrASUi2nJ7h4QXk0/l5qAau/8f8jg79b
	IIzglxdZPzgV4xPlxUiHouI09VvpOl4L0mtbaAT5/pT/ljTUZbis3uRzrzxrLeU2D+kAmzISpgp
	177qZdkFKMY5ihxmafs6BvshFj5FcGZO0TMuWn128rhd7uh5rk4S5Vi+bqvKGYapwAe2Yje1ox4
	not7j+9
X-Google-Smtp-Source: AGHT+IEXxPpWP/dtV2YRycGfty4buirPPVySHBnKiGkqMEsgvMURnxPmxX4fTm9QuMVyENgF0pJocmO64hiRDd19eKg=
X-Received: by 2002:a05:6000:238a:b0:3b8:fb31:a426 with SMTP id
 ffacd0b85a97d-3b9fc383fccmr150346f8f.57.1755108314922; Wed, 13 Aug 2025
 11:05:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org>
 <20250812-rnull-up-v6-16-v4-11-ed801dd3ba5c@kernel.org> <mACGre8-fNXj9Z2EpuE3yez_o2T-TtqrdB6HB-VkO0cuvhXsqzECKWMhsz_c43NJUxpsnVpO_U0oLbaaNhXqRQ==@protonmail.internalid>
 <aJw-XWhDahVeejl3@google.com> <87cy8zfkw5.fsf@t14s.mail-host-address-is-not-set>
 <WporCpRrDB_e8ocWi63px_bwtPWqRjDL4kVPNNXFNoI6H-4bgk5P_n4iO0E4m-ElwkiNTyBITwgdMXjREE8VXQ==@protonmail.internalid>
 <CAH5fLggraEP7bwzJ+4ww8-7Ku-Z+d0Em3=NDUpa7r8oTLQy81A@mail.gmail.com> <877bz7f7jg.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <877bz7f7jg.fsf@t14s.mail-host-address-is-not-set>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 13 Aug 2025 20:05:02 +0200
X-Gm-Features: Ac12FXz5FhnA2ZFwHRbSUpKHD0xBzeC_yFvarbuLcF5iab4q_93gsNFoSEqE4nw
Message-ID: <CAH5fLgi+R=ZW2bFnZP2=231vV6JAHTZJ0UBYkdojG=HjBYR3MA@mail.gmail.com>
Subject: Re: [PATCH v4 11/15] rnull: enable configuration via `configfs`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 7:36=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> "Alice Ryhl" <aliceryhl@google.com> writes:
>
> > For your convenience, I already wrote a safe wrapper of kstrtobool for
> > an out-of-tree driver. You're welcome to copy-paste this:
> >
> > fn kstrtobool(kstr: &CStr) -> Result<bool> {
> >     let mut res =3D false;
> >     to_result(unsafe {
> > kernel::bindings::kstrtobool(kstr.as_char_ptr(), &mut res) })?;
> >     Ok(res)
> > }
>
> Thanks, I did one as well today, accepting `&str` instead. The examples
> highlight why it is not great:

Yeah, well, I think we should still use it for consistency.

>   /// Convert common user inputs into boolean values using the kernel's `=
kstrtobool` function.
>   ///
>   /// This routine returns `Ok(bool)` if the first character is one of 'Y=
yTt1NnFf0', or
>   /// [oO][NnFf] for "on" and "off". Otherwise it will return `Err(EINVAL=
)`.
>   ///
>   /// # Examples
>   ///
>   /// ```
>   /// # use kernel::str::kstrtobool;
>   ///
>   /// // Lowercase
>   /// assert_eq!(kstrtobool("true"), Ok(true));
>   /// assert_eq!(kstrtobool("tr"), Ok(true));
>   /// assert_eq!(kstrtobool("t"), Ok(true));
>   /// assert_eq!(kstrtobool("twrong"), Ok(true)); // <-- =F0=9F=A4=B7
>   /// assert_eq!(kstrtobool("false"), Ok(false));
>   /// assert_eq!(kstrtobool("f"), Ok(false));
>   /// assert_eq!(kstrtobool("yes"), Ok(true));
>   /// assert_eq!(kstrtobool("no"), Ok(false));
>   /// assert_eq!(kstrtobool("on"), Ok(true));
>   /// assert_eq!(kstrtobool("off"), Ok(false));
>   ///
>   /// // Camel case
>   /// assert_eq!(kstrtobool("True"), Ok(true));
>   /// assert_eq!(kstrtobool("False"), Ok(false));
>   /// assert_eq!(kstrtobool("Yes"), Ok(true));
>   /// assert_eq!(kstrtobool("No"), Ok(false));
>   /// assert_eq!(kstrtobool("On"), Ok(true));
>   /// assert_eq!(kstrtobool("Off"), Ok(false));
>   ///
>   /// // All caps
>   /// assert_eq!(kstrtobool("TRUE"), Ok(true));
>   /// assert_eq!(kstrtobool("FALSE"), Ok(false));
>   /// assert_eq!(kstrtobool("YES"), Ok(true));
>   /// assert_eq!(kstrtobool("NO"), Ok(false));
>   /// assert_eq!(kstrtobool("ON"), Ok(true));
>   /// assert_eq!(kstrtobool("OFF"), Ok(false));
>   ///
>   /// // Numeric
>   /// assert_eq!(kstrtobool("1"), Ok(true));
>   /// assert_eq!(kstrtobool("0"), Ok(false));
>   ///
>   /// // Invalid input
>   /// assert_eq!(kstrtobool("invalid"), Err(EINVAL));
>   /// assert_eq!(kstrtobool("2"), Err(EINVAL));
>   /// ```
>   pub fn kstrtobool(input: &str) -> Result<bool> {
>       let mut result: bool =3D false;
>       let c_str =3D CString::try_from_fmt(fmt!("{input}"))?;
>
>       // SAFETY: `c_str` points to a valid null-terminated C string, and =
`result` is a valid
>       // pointer to a bool that we own.
>       let ret =3D unsafe { bindings::kstrtobool(c_str.as_char_ptr(), &mut=
 result as *mut bool) };
>
>       kernel::error::to_result(ret).map(|_| result)
>   }
>
> Not sure if we should take `CStr` or `str`, what do you think?

Using CStr makes sense, since it avoids having the caller perform a
useless utf-8 check.

Alice

