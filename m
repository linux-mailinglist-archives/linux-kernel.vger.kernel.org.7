Return-Path: <linux-kernel+bounces-768354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C523B26042
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA206188C470
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173AD2F8BDF;
	Thu, 14 Aug 2025 08:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y0/dIBtK"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C81C2E9ED9
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755161943; cv=none; b=cfOOTHHZQxIrMyRwjqH3e0EOFHuZ29uqRBH3e5rnU1PDosP9h3gl0lTqtwMA53OnpQf3R2wPpBv2xoOnbSdWHKcjEd9Blg6MSGg676D/Ld3+uTxY/DSioSleFzvygJVoMp2IrzWGA1aEopNedfcayhIs4XjsBdEYrIrBoQX5JnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755161943; c=relaxed/simple;
	bh=o1Szdoofusn4ja6J2Nq+EgTM/QeJljSbOzJBQYC5Xlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmZCp1oh9NxaHb5+LoRah/qklBlpbHUvqDQoLSD2OISwNfsn7xchixJh0f8AC2wPZVUSYTR/dtWLY/9GBidqPySPOKtECsx12LqW5aqxeluwPoGOnMWeishZWUCKrnLLU7N7hNATgI5Cv8POB8bCMUGtGh3nY/ig5/tUggJLFmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y0/dIBtK; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b9e41669d6so500620f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 01:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755161940; x=1755766740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2fToAB1Rcjn651wF/AF4BoAGXD5OP38Zu/DND4w8MA=;
        b=Y0/dIBtKTmYifsnHoIBTCIVgap2xoV8Ns5E06zvmEzqpCNc+sDVKcsVIp4uBFr8cff
         n1rJASrGfvqtB2frY7WhcqZqDgULq6pak42bw2Jjhns9euLdLg996QaqJF2RG9eQq1aE
         I1gbeai0a7LihfaFeAuQop6eWYSI9Sd1rro8+EdV8t0ESw0WcEtgpJMYxenYtvelp9dT
         b/P6bWjjvMR8rH1205dpExMfG/XbpLSCf1PxpmH1OpyRuoATVqKi94ZvUb5s/GI/IfDO
         aYwfXzHuUzDGPYXCZXIr3h3NN+AkHF82AHmk1ckNRlFonj/25Jq7j3Hht2/Sfag5gpb5
         T2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755161940; x=1755766740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2fToAB1Rcjn651wF/AF4BoAGXD5OP38Zu/DND4w8MA=;
        b=UwN+vp97utoaXP1lSP/BponZwCUMXIN14aUvlmJNLgPJkzlG3RqzFAuo32XoLuLkrP
         vXVS4pgg1HXUI2yoaUWcweAJPAXkll+UkmWeELUKew+CRttqypMYq39Z/iGRr0AF9l5X
         2/zTYsIc58N7DILuHusUDxi0bVPK+2DvHY9u0RIJ3vpPgXzh6ZZ+EspXWhb9YjhaBp9Q
         Xp12oMvW/MoKSSVzrMHO+4VpmZ92r5PU5r6+AMyt22rI3oY/4LZwWGFLV6HTCPWLJUYY
         5k8C4fef/ncYpsNoyRBRo9Nyel9+RnHDFZA9O82CNHXRSn4kmMHi9DAHqeN2jb7MVmXr
         kfsg==
X-Forwarded-Encrypted: i=1; AJvYcCUN9RRERoQZJrT5i3UPvLZR93tzPvgs7ERfG8ailIPjRnq1p4UA4D81fxF1c1SHtvhE2iUQBDhVUPZvP9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVcDE1l/KBLnDajdJrLpqXBPO88pkOjEzm1nW7jFzzQs1yEKIM
	d8GKphWoC/WRb8TGV+5XGqYDpZpk5yf26k7++5qJqD3VWbGFpbk5Aj/t3/8RjatIIBrzjH7/OES
	AA+Xpoiw/8oAP2LQqA/GIkDf/I/zHuZfVpF2hNYCG
X-Gm-Gg: ASbGncuVe04mJhGICAIwkCXszUimQq0KbZAcwKBQg/vF6zP4dwkuLdXkoDIzEQDU/TS
	UmX8fZZPUZA1b//cubHEDKY4+M9X9lckggf19Hs9GIZPPQpW1NtlMNJpJJdRuI43UjlULH/U34s
	RuQCusGTCMSO5VW8U2dosQfNSReKH2ja36qEyZYDa+qyO4zk9WvGd20JUkmU0x/nQ3dpiQdx6NI
	NFkpcG8m2dr6V7aCRwkXoZ79Q==
X-Google-Smtp-Source: AGHT+IEnok90zWddm6EeCa9vOgl+9GHdTol46JTh/NRAVk1/tIT9B8eSdrtVYMiMwwhqV9azFUftNTxZaAYRyPY4DVY=
X-Received: by 2002:a05:600c:64c7:b0:459:e398:ed89 with SMTP id
 5b1f17b1804b1-45a1b61538fmr14062525e9.1.1755161939436; Thu, 14 Aug 2025
 01:58:59 -0700 (PDT)
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
 <CAH5fLggraEP7bwzJ+4ww8-7Ku-Z+d0Em3=NDUpa7r8oTLQy81A@mail.gmail.com>
 <877bz7f7jg.fsf@t14s.mail-host-address-is-not-set> <wKjTynzVeXix56T1eCrpF4Y7zM7dJVumIB3DljSJeXkHx7Vyb4jKR5X5c5B2yV0DFKItLrncGLWxcTkVynD12g==@protonmail.internalid>
 <CAH5fLgi+R=ZW2bFnZP2=231vV6JAHTZJ0UBYkdojG=HjBYR3MA@mail.gmail.com> <87zfc2e4gy.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87zfc2e4gy.fsf@t14s.mail-host-address-is-not-set>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 14 Aug 2025 10:58:47 +0200
X-Gm-Features: Ac12FXzvl-VOlMNOzmyRS7iEzUNls9Gq8WBcmNjnQTA3yaE2PQLweZJ0Y0vj2qk
Message-ID: <CAH5fLgjnYiAo3jfbyjZeRu5siMgoqYi1fbFaxrixGdqXxtZXcA@mail.gmail.com>
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

On Thu, Aug 14, 2025 at 9:40=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> "Alice Ryhl" <aliceryhl@google.com> writes:
>
> > On Wed, Aug 13, 2025 at 7:36=E2=80=AFPM Andreas Hindborg <a.hindborg@ke=
rnel.org> wrote:
> >>
> >> "Alice Ryhl" <aliceryhl@google.com> writes:
> >>
> >> > For your convenience, I already wrote a safe wrapper of kstrtobool f=
or
> >> > an out-of-tree driver. You're welcome to copy-paste this:
> >> >
> >> > fn kstrtobool(kstr: &CStr) -> Result<bool> {
> >> >     let mut res =3D false;
> >> >     to_result(unsafe {
> >> > kernel::bindings::kstrtobool(kstr.as_char_ptr(), &mut res) })?;
> >> >     Ok(res)
> >> > }
> >>
> >> Thanks, I did one as well today, accepting `&str` instead. The example=
s
> >> highlight why it is not great:
> >
> > Yeah, well, I think we should still use it for consistency.
> >
> >>   /// Convert common user inputs into boolean values using the kernel'=
s `kstrtobool` function.
> >>   ///
> >>   /// This routine returns `Ok(bool)` if the first character is one of=
 'YyTt1NnFf0', or
> >>   /// [oO][NnFf] for "on" and "off". Otherwise it will return `Err(EIN=
VAL)`.
> >>   ///
> >>   /// # Examples
> >>   ///
> >>   /// ```
> >>   /// # use kernel::str::kstrtobool;
> >>   ///
> >>   /// // Lowercase
> >>   /// assert_eq!(kstrtobool("true"), Ok(true));
> >>   /// assert_eq!(kstrtobool("tr"), Ok(true));
> >>   /// assert_eq!(kstrtobool("t"), Ok(true));
> >>   /// assert_eq!(kstrtobool("twrong"), Ok(true)); // <-- =F0=9F=A4=B7
> >>   /// assert_eq!(kstrtobool("false"), Ok(false));
> >>   /// assert_eq!(kstrtobool("f"), Ok(false));
> >>   /// assert_eq!(kstrtobool("yes"), Ok(true));
> >>   /// assert_eq!(kstrtobool("no"), Ok(false));
> >>   /// assert_eq!(kstrtobool("on"), Ok(true));
> >>   /// assert_eq!(kstrtobool("off"), Ok(false));
> >>   ///
> >>   /// // Camel case
> >>   /// assert_eq!(kstrtobool("True"), Ok(true));
> >>   /// assert_eq!(kstrtobool("False"), Ok(false));
> >>   /// assert_eq!(kstrtobool("Yes"), Ok(true));
> >>   /// assert_eq!(kstrtobool("No"), Ok(false));
> >>   /// assert_eq!(kstrtobool("On"), Ok(true));
> >>   /// assert_eq!(kstrtobool("Off"), Ok(false));
> >>   ///
> >>   /// // All caps
> >>   /// assert_eq!(kstrtobool("TRUE"), Ok(true));
> >>   /// assert_eq!(kstrtobool("FALSE"), Ok(false));
> >>   /// assert_eq!(kstrtobool("YES"), Ok(true));
> >>   /// assert_eq!(kstrtobool("NO"), Ok(false));
> >>   /// assert_eq!(kstrtobool("ON"), Ok(true));
> >>   /// assert_eq!(kstrtobool("OFF"), Ok(false));
> >>   ///
> >>   /// // Numeric
> >>   /// assert_eq!(kstrtobool("1"), Ok(true));
> >>   /// assert_eq!(kstrtobool("0"), Ok(false));
> >>   ///
> >>   /// // Invalid input
> >>   /// assert_eq!(kstrtobool("invalid"), Err(EINVAL));
> >>   /// assert_eq!(kstrtobool("2"), Err(EINVAL));
> >>   /// ```
> >>   pub fn kstrtobool(input: &str) -> Result<bool> {
> >>       let mut result: bool =3D false;
> >>       let c_str =3D CString::try_from_fmt(fmt!("{input}"))?;
> >>
> >>       // SAFETY: `c_str` points to a valid null-terminated C string, a=
nd `result` is a valid
> >>       // pointer to a bool that we own.
> >>       let ret =3D unsafe { bindings::kstrtobool(c_str.as_char_ptr(), &=
mut result as *mut bool) };
> >>
> >>       kernel::error::to_result(ret).map(|_| result)
> >>   }
> >>
> >> Not sure if we should take `CStr` or `str`, what do you think?
> >
> > Using CStr makes sense, since it avoids having the caller perform a
> > useless utf-8 check.
>
> If we re-implement the entire function in rust, we can do the processing
> on a `&str`. That way, we can skip the allocation to enforce null
> termination. At least for this use case. I would rather do a utf8 check
> than allocate and copy.

You can copy to an array on the stack, so allocations aren't necessary
even if the string is not nul-terminated. I don't think we should
duplicate this logic.

And if we do add a Rust method that does not enforce a nul-check, then
I'd say it should use &[u8] as the argument rather than &str. (Or
possibly &Bstr.)

Alice

