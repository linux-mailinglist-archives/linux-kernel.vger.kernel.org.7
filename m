Return-Path: <linux-kernel+bounces-731499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4627AB05540
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F441C23497
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836DB2D0C7A;
	Tue, 15 Jul 2025 08:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WpnWAQhX"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE6E28A73E
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752569064; cv=none; b=SldJ59G0dNpa2UjjUj18zGKGxCgrPyhDaEa4+PfbI/G7QpJCIub+QVyUbvuOCjI8zuB2tQAdtsEFD1agba1qDqZHhJmFIRVAgcop7dIk3wFBBm2W9ph0OemRiixsWRwvnHwdddHkayU3zoyRBjSQuJj5GMQJ3IFZMioF+VLxyBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752569064; c=relaxed/simple;
	bh=WksxcT0vew5gQIK21EEwb9zJ+2MlPcoIhesf2cYfLvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qam7wsEQOk5+TKdRBzL6g4f8OtUQgkeqHg6S9HpWSDEJxBVfOty9JwPY/SGXqtA0IaDddMIcI1ym9HpLOr50Emt+V6uk5H9xQjyohUDFt22wPue7t5NCJtBrOBrvLA4Mw8HPmjDSQHUAFTFRgEyRqOrbkt/tvOBzbuX5MiJ+AsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WpnWAQhX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-455e6fb8057so38808725e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 01:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752569060; x=1753173860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WksxcT0vew5gQIK21EEwb9zJ+2MlPcoIhesf2cYfLvI=;
        b=WpnWAQhX4WczwZ6JBHRq5/q7LDmSLPeckR+fI49nX3zUNwS/9W/r4YCITNj1uRoTlL
         IW0iP/kmv3yo6azGojFJRSOMZZ4d9VCtDPzLpuERk9Rogg9mdLSpAZykm0YJ5IKf7EOi
         WjERKP5BNHP6ijfgozXgqxJu15CTV6K8TbXjTFix8A/1C7rCbd1Cjvx53JPgs1j9dhKI
         tP2MixiNiQl/AR1amWaP8HhULESz2tMKxB+sw/kgQwmafJP8CzUYfBqz0rfPm1w613P9
         uxGfY15wE+C2JPQieG0QA8B2Yra3Mdhc0nkRWPyod5MFX5Fb49G2lYWAEvnf9n2qiTmR
         SBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752569060; x=1753173860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WksxcT0vew5gQIK21EEwb9zJ+2MlPcoIhesf2cYfLvI=;
        b=IpnM8LcVIv9sQ3upXjSrWAK2AYPfZGkktuASHZwcS4fGFaxagwua2fFQbsf3OOHdwy
         94ysvOYMeEMbJ4WNWR1e+E7+gtOoKG8pDLz2ald7H8wZOO29WwPkrjCmP86fbz61vIpm
         iBILUYHQR9OUX72D/j8QfelBxdEj21leN7DjUX5so8Nxdy6lnN3xzzBlZUq1I5LLxoXl
         4zgdeQ+dn69JTfDli8htmy/NGnKgCnowzapJH8QT2NFBb4tv173MwWOeJJVZW0enTHQO
         1NYz0cJ0J3ZDisCAxpwJ7Rl6GSwL7E3eGQgYV2CJ0oKDYcBt2j4jpl3pCj1I5ppcLRNn
         Ghaw==
X-Forwarded-Encrypted: i=1; AJvYcCWI6Ef1u9kUIkWZSU9Kvo6L+96OT3I5viT4Q6RVX2xdtaoD6B6/Y1CrJDhH2ocBmm5xW8MRgIC+EjOdZyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwABqOzBvu7aHfggcBYIfnX9UTzEOyv3HkCrToQWynbufmg9Io0
	4bYRHLMgeYCCT6lKvS1PazNZstAu+6HhbQ4ohYSt1JcyxzTTYR7ECK6xU5mcLhmDjrDV0wUqrsv
	L0VVk8hFdWwy4Ckc1WXst45H21JH2g54wxGhnC0RN
X-Gm-Gg: ASbGncvuok212arRzK31baVPdWW16qk1c0QEon3fF8vwDsGHLRSxEj7VA4LGzJB9pj2
	XOWYMVoknK/foZiYBC5/s9KiiaJ8aU8XZI1c+LSlUHSugsh2nq1a+TFqmXm9uKlqZmedt6ZzWJC
	Ilo0VLyYQRCRHBYL4Zh3cZ9/ZfW5WmQnHPGwHn76uWaD+8j4CZL9wON+Dj6tmM+E0qkmgI+lbJO
	XdER9l0B6s8U3CcMtQ=
X-Google-Smtp-Source: AGHT+IHzMFyvUx98+ytThz9kGyW5N9noGp3DlfBh9jRa1JcqVzpneWTBVnQXWg7nciIv953hMjQK9Rnq07N/ncoJOsM=
X-Received: by 2002:a5d:5f88:0:b0:3b5:e077:af24 with SMTP id
 ffacd0b85a97d-3b5f2dc21famr13129817f8f.14.1752569059746; Tue, 15 Jul 2025
 01:44:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714113712.22158-1-dakr@kernel.org> <aHYCOFZZYbgP39nR@google.com>
 <DBCHFBDWRHZ1.96R3AMCDUX9S@kernel.org>
In-Reply-To: <DBCHFBDWRHZ1.96R3AMCDUX9S@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 15 Jul 2025 10:44:07 +0200
X-Gm-Features: Ac12FXwoj1Dq7KKw4Qu02ROnGWXG9HPYTeSOfU04fr5zzoADs9AgIW4IUuzD4Po
Message-ID: <CAH5fLgjG9YpyNQMO9mJhCvS1r9MNKt9Upnr8B-LPSkwXr1A41g@mail.gmail.com>
Subject: Re: [PATCH] rust: devres: initialize Devres::inner::data last
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, daniel.almeida@collabora.com, m.wilczynski@samsung.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 10:22=E2=80=AFAM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> On Tue Jul 15, 2025 at 9:24 AM CEST, Alice Ryhl wrote:
> > On Mon, Jul 14, 2025 at 01:32:35PM +0200, Danilo Krummrich wrote:
> >> Users may want to access the Devres object from callbacks registered
> >> through the initialization of Devres::inner::data.
> >>
> >> For those accesses to be valid, Devres::inner::data must be initialize=
d
> >> last [1].
> >>
> >> Credit to Boqun for spotting this [2].
> >>
> >> Link: https://lore.kernel.org/lkml/DBBPHO26CPBS.2OVI1OERCB2J5@kernel.o=
rg/ [1]
> >> Link: https://lore.kernel.org/lkml/aHSmxWeIy3L-AKIV@Mac.home/ [2]
> >> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> >> ---
> >> base-commit: 3964d07dd821efe9680e90c51c86661a98e60a0f
> >
> > I couldn't find this commit. Where does this apply?
>
> The commit is in driver-core-next.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

