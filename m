Return-Path: <linux-kernel+bounces-754473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B71B194AA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 19:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81DA417264C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 17:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807721DF258;
	Sun,  3 Aug 2025 17:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6OclYV/"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9339E15C0;
	Sun,  3 Aug 2025 17:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754243097; cv=none; b=KmT+dslLLAe+cBMGy64mcKNj40nLpATCPl/SC/XExkJD8UmYUyZkgwE0hVsInaQrE0cAOZWHnEDBaP9ScaB/pBfE8HNQeQ2T5gPE2J0jFvumHjb1j48pI73mNQqDOmriZiKl/ABXmZGdeIss1Ll2pPFUtoaVqgAHsPM6GQ9AUgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754243097; c=relaxed/simple;
	bh=t3iLmLQ2HS7SYoAMndeVxC9knQL14a22W5wBZ1Kz7y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iN405e3GEsQ3snGzvhaRg9NGy3rRWaicXQ95wPjaGtRwu28DSadNTebxCrQ4DVvxijqsHSym2PRreDI67abRNHyzyksFgfg1bdMEWesO2L+bJO8K8Gvkc3K3fh6gGxYIumNdVDie0N3QFv4UADatLgCGcxy1pUlspOvZ3Yvj9Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6OclYV/; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b3badf1afc0so577798a12.3;
        Sun, 03 Aug 2025 10:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754243096; x=1754847896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qe+uCBY7YFwaIdiDF6uReamScrBxl2mCeWpM0+YSCw0=;
        b=F6OclYV/yi26YMp5x49DrvlOsSVemozFi7lFszkG8i/NFjB3AOA6EuipEPVKd7Fxjg
         jKigaL4xmCX+Y9E53dela+hOxfRYdewqi88JvgL6DCERBRMcFR4txRtrXoJYjHOrihJs
         LVWLFDvYScik48jqO4QkNm4kpuZOXjnlpvJIOq3o63u8haUNsdEoUiBGKJVPYTWLzycB
         V68pT5rTbjw4wCVBzQzOw9lGS2CpQvV+JBGhhL0iR/mTD5qwXVayLZc4lx+21ygAn16M
         xpn+ixzaUGDuRA8ZTEy0bHDKHAkA1qdid58bxbVfXjnPcDne1CRlFAYohvSWuuqFZmJK
         Hdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754243096; x=1754847896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qe+uCBY7YFwaIdiDF6uReamScrBxl2mCeWpM0+YSCw0=;
        b=VKgXxt8hNLAtJZAB6PEvkr3a7qLdqEjaPfka/qs6tO3bDT1kFSbgoOtZ4sU/tquQ6J
         kgOSwENxDofO44NTPq0dZDc7fp4ixZnMDGMRjMKauFWNLg0oj4cX1sgyGJaXnUrQsy+A
         r5uKEv7JvAoD84rosUaZ17Sh88zQzQRFC0TJqe8CIAYlRUvOMNeFXGMf15gg70rMuoPV
         8PQmsmtMvHIRCt4t64Cl9ZNNLJklSO1qSQsEdvuJLCdMo0UCY0EchMXEIeI5JffRpw6J
         z2REhRDCAYra0+dEneWO0JLUd5Bv+NK7sPq/PTfrOKmxsQGDCdk8zKpOfejN+Xuhtev4
         E7kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbvzTlUMoIwhyM9km9yLFWeLFDOs8esKQCa2zS7kKPHOtoeCWhJAzwzBkkIfGrkoyMbkEWNq/MEGvDR2A=@vger.kernel.org, AJvYcCVfvWUJeuTPPImbqXmmNOFzauVlS0HZkXbd3A+6jxzisliBxLWKTX57sw1J85G8x7mww1JNxhPi+DJU71DR8o4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKLbKvzN0PJNqq6uWnTWgZiuF4KzgROA/eoKcWiPLkpfZopfLW
	EYpIlZPpnsQVeFjSiVNngT0qp5FuKd/DSwRSAzAagFb4eALM1JywOxYivQb1EKmkBAFEacq4I4A
	XiMxKowXD4DWeCIzv1HkoGyBr6TpW6RcK2b7QiYg=
X-Gm-Gg: ASbGncv3piKWe8BPeJgupjfzt3cTEJ0jiXEG1jWoMAR2eDj60CDgLHfpkPcTfR5bf5P
	XoYKycE0L0ylMWA9iAiK8SUY+2FTbelJ0LQ14NLr9itI/d3QKFEabLYrp6KQDU9WMY6UgMqPewn
	XospKbXkRXNL6MUQBu4AUExLDy/ywqWKiag/SwEZKcmZNKiFrbedX4Lb2OQm7SKQFUH5LEECv8K
	aMeQ8bO1IdPEp91Dlg=
X-Google-Smtp-Source: AGHT+IFMx1InobcfVZog5AEyfwx4NS6Pc52HTcZFt8niNUWiTQz7qyELBrwE3tmk4N6Tb0AocdovUh+BFZgmPtu6ILQ=
X-Received: by 2002:a17:902:c951:b0:23f:fd0e:e5c0 with SMTP id
 d9443c01a7336-24246fe91bemr40899865ad.9.1754243095604; Sun, 03 Aug 2025
 10:44:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+TpbOLLATyTRtNxVEJ9Dz6=YSZHAyYOrt20TR8AAEfP+qm1Qw@mail.gmail.com>
In-Reply-To: <CA+TpbOLLATyTRtNxVEJ9Dz6=YSZHAyYOrt20TR8AAEfP+qm1Qw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 3 Aug 2025 19:44:44 +0200
X-Gm-Features: Ac12FXwC0gy_FHaZhZG-_AB243dyP2UM-OWoBYP5q89TpWdAHRh-vduMDQT2fws
Message-ID: <CANiq72kYBvx9Wb-jEGqfUrpbzy8SQvcbjTmAytHZ=2_qx7c1pA@mail.gmail.com>
Subject: Re: [PATCH] rust: kernel: add missing safety comments
To: Jinheng LI <ahengljh@gmail.com>
Cc: ojeda@kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 3, 2025 at 7:10=E2=80=AFPM Jinheng LI <ahengljh@gmail.com> wrot=
e:
>
> From 5cba005b59a032fc80f818b393b7e4c36a460710 Mon Sep 17 00:00:00 2001
> From: Jinheng Li <ahengljh@gmail.com>
> Date: Mon, 4 Aug 2025 00:56:11 +0800
> Subject: [PATCH] rust: kernel: add missing safety comments

This is supposed to be used by e.g. Git `send-email` to craft the
email, rather than being sent in the body.

> Add safety documentation for unsafe functions that were missing proper
> SAFETY comments. This improves code maintainability and helps
> developers understand the safety requirements.
>
> - str.rs: Document safety requirements for as_str_unchecked()
> - list.rs: Document safety requirements for remove() method
>
> These functions had TODO markers for safety documentation that are
> now properly filled in with clear explanations of the invariants
> and caller responsibilities.

These paragraphs all sound as if we are documenting the safety
requirements of the outer function. However, `// SAFETY: ...` comments
are meant to explain how we satisfy the safety requirements of the
functions etc. used within the `unsafe` block that follows.

Also, to avoid confusion, we normally use the word "documentation" for
the `///` ones, i.e. things that are meant for users of APIs.

So I think the commit message is a bit confusing.

The contents are also a bit strange, e.g.:

> +        // Since `CStr` is guaranteed to contain no interior null
> bytes (by its invariants),
> +        // and we're excluding the trailing null byte via
> `as_bytes()`, the resulting slice
> +        // is valid for `from_utf8_unchecked`.

`from_utf8_unchecked`'s requirements are just that "The bytes passed
in must be valid UTF-8.". Why does the NUL matter here?

Thanks!

Cheers,
Miguel

