Return-Path: <linux-kernel+bounces-896096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB93C4FA34
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26563189DB64
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B179366567;
	Tue, 11 Nov 2025 19:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOWsf+Wy"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3623E3596F0
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 19:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762890320; cv=none; b=Ox/b8wh3Dw9SRjDCHSQJFltBNKdlZtWHPHQKgmAFuNVE+ASgnJGOGVQYsOTQKbaArMZrXkcF0kqquC64zUcsaFKX2KRFy7GsgD8Gs8Gx9+sjR2QvWG80bGu0MZ381hpdxt/C1ubhmR822xN6lHg/hTs0vu4TyJVHL7ArmLQCq+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762890320; c=relaxed/simple;
	bh=Sg7FhLFPHYhYHz0dhqTZ1MP6Nbu0jdxwfOGdyNc5gt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFWQhuU1NoYUZH4NgWCxI2PVm17rtaqVgjF/u7zTIGodHMTLOet9jvcaMcsRYuyRn8gtQa4i0dDBovo2T0EUCJJbkLy8wcmX30RJzyYKni9HkpxW6eS3K+CiEq98X9vpxz7aKp7jMTjlalCdzcj4uWLdsDbOV91oOw/dnwDGpb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOWsf+Wy; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7a2687cb882so8345b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762890318; x=1763495118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sg7FhLFPHYhYHz0dhqTZ1MP6Nbu0jdxwfOGdyNc5gt0=;
        b=eOWsf+WyXEw/eSF9CmjV7HIDweZC0asEzb85mqYKzz9wg9h3Fdpm+mS73vV/5Ri0q4
         t8upNUavqVuqv1KuNaDwbNcMTtBmEav4/wRRVAiTOGmNkbKa7JYB8Sr3/GutmNH1zy2b
         sifoMj72Cs8fBjjrfh0B1yIsNwfW1QhayBnLG5uGcBynT17eVAjrj9w8qJgEMGmXwmvS
         KNqDLm1LQdTW45V+nMxQyCR6IuZZ5AEvh72qA2Km/jLtdUtLXA8HsON+YTh7klrydLoW
         gbXlNtwgbm0lWwyAwSzuYEffId7REO1vPMVZZsuaHTmVcPh642HqHwn1o3As6AL1BJIl
         cDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762890318; x=1763495118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sg7FhLFPHYhYHz0dhqTZ1MP6Nbu0jdxwfOGdyNc5gt0=;
        b=UZh/gW6434nxGWLMf7Nq8C6y+9IGibkJG45vNa+nY4L5ekzGvuf8vZDvUxBbzNsxDo
         nTUe0d/EpxTFj9NYULkwWfGCVaFBGN4gyQYc618Ug6VPOITLn07E6BUUpRoelx50HIHb
         tg//vAZbFgV1DvBmlB1AKOaBCOuG3uqkgcuo9rvM/Ttc4zCOOSwwdloMOpf/anmIiGCf
         AlBPvwHxyG4LcUhezLIa/0RbjudK7T3mwhNiMw86T2UOB+35+XXDEfzjoykGfVeY0uPw
         /FYI4Dc8LpBW+wKnkRzIyOD29GAOFjtrhcXadvSko9HyOTB9NTk0+FNToET1W5NXkat3
         qDYg==
X-Forwarded-Encrypted: i=1; AJvYcCVJGco6EbVZQSXQPwqB6fmABcWLnk4k9AI11Jjmotmv1dhuj6j9EqCve1LJA4Sem7WeK9hdEc3qRDEPTOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YynpOhepyqDr/U7YJau/ArkpJ0RVNL1PRKm776q9z2KBZGuhvKM
	Bg4oSb1QurdNxjKodTYFB7YM4bqXjdrMNuci5yNzeOqOKPOuI5Ieqp9S6HboIPacS48Ru052CqC
	tQKXr2iZUWtv7B/zkgMXe47VqbXY8ptw=
X-Gm-Gg: ASbGnctmNrETvORFfwl2AbVMu3qx4M011zRSWeJ6RGsz34KbWcFBO26K9cFEdkHHyFc
	nXPyW9xUCANVSOwS36LlgVpTRU+l2+9XYKnm3fTfvcSk/mwOqVkhFBU8BqkSJAnt/BS09hWD4E1
	yvAdYabCJLOjT3Xt++BqcRGSrjFY58kJO/P72zYueUOK9gYgGJ3nP22fk3ifr1+Ja/2CU2tPZo9
	uq1K6TbyPo97Nws60pf24Wx/04/ABPzQ7WjUXVzsYVHjlXTjtpIfTzRdibsFvHozDe0juK/Cf6h
	CRARmLnq5nc7FSFTYZWs4nztQhsd3H0ZAhzuA+NWt8NCmzFfgmD+P0L60RxZNSA1CXH23ONChK7
	273U=
X-Google-Smtp-Source: AGHT+IE5zjw8D+my40d60Ix41uKXNSt7HOnLAKKhJi0H3LCnV5CTo+qFPBfkXgqbqQK8w6cViFfsGq4E6L6246te+k0=
X-Received: by 2002:a17:902:db0a:b0:295:70b1:edd6 with SMTP id
 d9443c01a7336-2984ed884e3mr3098505ad.3.1762890318029; Tue, 11 Nov 2025
 11:45:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110131913.1789896-1-ojeda@kernel.org> <CANiq72mjFobjfQEtNvk9aA+757RkLpcfmCCEJAH69ZYsr67GdA@mail.gmail.com>
 <CA+icZUVcHfLru9SRfhNGToiRmyOY+fLw-ASEvQakZYfU1Kxq4g@mail.gmail.com>
In-Reply-To: <CA+icZUVcHfLru9SRfhNGToiRmyOY+fLw-ASEvQakZYfU1Kxq4g@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 11 Nov 2025 20:45:06 +0100
X-Gm-Features: AWmQ_bkZOKXuOXoFqnluk99fIIrWIqE98EcoUgehQR7XEFroNIarOWjMBHltciY
Message-ID: <CANiq72mS2SFfMsMgVvmR7dgBpYq6O23Gx9fQmDWuaqrz5sVNYw@mail.gmail.com>
Subject: Re: [PATCH v2] gendwarfksyms: Skip files with no exports
To: sedat.dilek@gmail.com
Cc: Miguel Ojeda <ojeda@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	Haiyue Wang <haiyuewa@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 4:25=E2=80=AFPM Sedat Dilek <sedat.dilek@gmail.com>=
 wrote:
>
> I switched over to gendwarfksyms in the very early testing days.
> Faster builds. DWARFv5 fan.
>
> And was using v5 of Sami's patchset against Linux v6.12 as it cleanly app=
lied.
>
> Last week, I jumped over to Linux v6.17.6 and the next testing will be
> Linux v6.18-rc5+ (upcoming next LTS kernel-version).
>
> I will try this patch - might be you will get a Tested-by.

Sound good -- I have applied it to start getting testing, but if you
have a tag in the next day or so, I can add it.

Thanks!

Cheers,
Miguel

