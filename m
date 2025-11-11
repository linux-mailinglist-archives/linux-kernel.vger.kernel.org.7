Return-Path: <linux-kernel+bounces-896094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA8CC4FA22
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B05134E345A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C362232C93A;
	Tue, 11 Nov 2025 19:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNEQU7rt"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9835332A3F9
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 19:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762890292; cv=none; b=qdj81ZR2ptoE8VaPymTZU5Y3Xa+PVc+wJ1xPeJX9Dy02HwZS01CdXa2QwfYMUgo7cEaMf++G0eWIBCDd8976hs8DPbkpBzumeuqX3CkeBONzAFjjwxVez4vsnGfWlXF6zLjSHY1SD50zxuqTRJoaJORHza0Ut7TB9IV8MfQ1108=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762890292; c=relaxed/simple;
	bh=JiUjPFE5L6L3WUSoWqtnqWCucYId5dZy3dcTcIJ6lbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Talp1ieqq4vklVkKAiDg7jdhMIVu/AG75iGl2/ZFjYoVqBTBA1khUbbGBi9b200uOnOEu5duPuRptd6yPcsfIhuDaal78Qojjvy0U9zAQWd5IZS6qh0U+IqblXfWvBdxievaJLCF1IUH/yH7+gmc3uDtdb6NbEYUPocVjrkRciI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNEQU7rt; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b87171370b5so14255a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762890290; x=1763495090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBwIkGZr5oeEH/G4GQqW+JJA6UiGsteAP6cGwBb+I8s=;
        b=QNEQU7rtfTdxjxfLCG/eoAFCg3CucgTfZVBDPlwuoAPm7XcK9zGsBYVLObEFyEoFYS
         xyv6BnTy2D9SKz6DOkv2E0uQbHF4WgefM7jwP++mKN83FwIhhDCz/vSl4HtaYkAEcqBQ
         0sfjITnHLxKpanUBKGo5ScC6ZjmG90qMQYWQylwp1bKV4Jwbm2/JJrnHqiyW+dfKNk+7
         x992ScOgjL5X9MLD8+gSBGgBfdnK92VKswHf7MhqDuimWgxX5t3kIOCFA38INXZS8AGk
         vGRYu3H6E6R+N6Fn8POgVGwA7nege4shGjmcG/6nHPebFUwjuyvuwYMRLHdB0ub814zb
         Zcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762890290; x=1763495090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hBwIkGZr5oeEH/G4GQqW+JJA6UiGsteAP6cGwBb+I8s=;
        b=iV1DcDt8N6r/i0yLMeH7P35D00J0vICPz2VtfKPKzNXdT03BlrQyM5h61FozIwUpn1
         kyNcEw+r1zw0J3xi/Csa1s8nw/CIfs7k7uVs/NRFC9seW8rUfLfhLoekYRZvJzIHSBRR
         Au05hYIL8W1flcFH31owwG6pVg8glCKsZvU4bMKvOeLsM/9DMX+JDO4i3eMrZxrrEy5V
         9sAQRgxywPsWXyv/zA+vkSU+puNzTL1LIsu27pdxK6t3VRS7Q+k2o113DWjFrKhbp58k
         MuBp9MsSmiZKO3q30iN1t8Eydt8EMtnbxHlBH2qAMrRpd714XqCl1QHDQv/OiicDdGUO
         EKTA==
X-Forwarded-Encrypted: i=1; AJvYcCUmVm9Qoi02zo4CBbyNx8t+S3vrV4mnvdvnLEF6X0xqneh5bcoweQByaZ46wfZ2YSEfeP/XLacjK6HuiGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvVFSEdYkhChcT0m8rEqK5ymajSpbeYIkn7I/u5rEysTnk6aSs
	gXOd+9xrZOlz8S1/sXF5M19+podTUpr5+6dpgu+0XVt2nZ1CASmwjUd873mctWaBJg5859cMfMc
	8u2w6fJKGeXVSv9masZ9oVT+gmjSaOX4=
X-Gm-Gg: ASbGnctzsfVGZtXhbYoJV0h1HF7DrlAZNVtqrbj+HO19ztHqBptmEAWzKl86kTJ03N1
	MdLaXcIxe8M0YtwtzuIRH/7F37eWffPfQ8M/mt43z76VRZ1bqX7CTbdu/01WG+kRAZGelg2pdjH
	EWNe4v6cjXpzzaGQOBBpbxh7GcZbDcJWpig7TU3rchaN9TzZ7APlEkQ6685LG1Wgl5uUMi8Wr+4
	BsZjIll7ozrjUQWk64WVobDlPTnv65svhFqIRgvVUEuzYMKuJHbRKjI5XbzAgaLqiAgi4nuKL22
	u00IRVxk6vPtPxdX6Y3vifsNOOCLBhIqEIHBXFbffE0mkuOH2zLcQZ5NVJGe8IvbnS29JXB+d05
	S0Jo=
X-Google-Smtp-Source: AGHT+IEIgD2TIb5lI+JHX8EN36MOz76t2fs8U9WrA5lSIrN1Ee1RN3oycFlI6xL09eb/igzj3iXymu1H+QisdP+gzoo=
X-Received: by 2002:a17:902:c951:b0:295:f926:c030 with SMTP id
 d9443c01a7336-2984ed34944mr3301345ad.2.1762890289896; Tue, 11 Nov 2025
 11:44:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110131913.1789896-1-ojeda@kernel.org>
In-Reply-To: <20251110131913.1789896-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 11 Nov 2025 20:44:37 +0100
X-Gm-Features: AWmQ_bl0uHm3iTs5smKUuF4u87o5Gft8n3MmJwhpnH_Cho0hzrCzkBHz2YKCGnk
Message-ID: <CANiq72kOOieyK03wukCDRaG8po1nmH6BFnyEe_Y7Do42BF_S8w@mail.gmail.com>
Subject: Re: [PATCH v2] gendwarfksyms: Skip files with no exports
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	Haiyue Wang <haiyuewa@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 2:19=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> From: Sami Tolvanen <samitolvanen@google.com>
>
> Starting with Rust 1.91.0 (released 2025-10-30), in upstream commit
> ab91a63d403b ("Ignore intrinsic calls in cross-crate-inlining cost model"=
)
> [1][2], `bindings.o` stops containing DWARF debug information because the
> `Default` implementations contained `write_bytes()` calls which are now
> ignored in that cost model (note that `CLIPPY=3D1` does not reproduce it)=
.
>
> This means `gendwarfksyms` complains:
>
>       RUSTC L rust/bindings.o
>     error: gendwarfksyms: process_module: dwarf_get_units failed: no debu=
gging information?
>
> There are several alternatives that would work here: conditionally
> skipping in the cases needed (but that is subtle and brittle), forcing
> DWARF generation with e.g. a dummy `static` (ugly and we may need to
> do it in several crates), skipping the call to the tool in the Kbuild
> command when there are no exports (fine) or teaching the tool to do so
> itself (simple and clean).
>
> Thus do the last one: don't attempt to process files if we have no symbol
> versions to calculate.
>
>   [ I used the commit log of my patch linked below since it explained the
>     root issue and expanded it a bit more to summarize the alternatives.
>
>       - Miguel ]
>
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).
> Reported-by: Haiyue Wang <haiyuewa@163.com>
> Closes: https://lore.kernel.org/rust-for-linux/b8c1c73d-bf8b-4bf2-beb1-84=
ffdcd60547@163.com/
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://lore.kernel.org/rust-for-linux/CANiq72nKC5r24VHAp9oUPR1HVPq=
T+=3D0ab9N0w6GqTF-kJOeiSw@mail.gmail.com/
> Link: https://github.com/rust-lang/rust/commit/ab91a63d403b0105cacd72809c=
d292a72984ed99 [1]
> Link: https://github.com/rust-lang/rust/pull/145910 [2]
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-fixes` to start getting some testing.

If someone doesn't want it, then please let me know.

Cheers,
Miguel

