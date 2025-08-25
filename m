Return-Path: <linux-kernel+bounces-785003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F002FB3449B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71EDE1891D2F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6B02FC88E;
	Mon, 25 Aug 2025 14:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQK7cYNX"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A95EAD21;
	Mon, 25 Aug 2025 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133519; cv=none; b=Mv8YKeDS4jR05vneHVV5+33EAYg1OwUaiIZ3QwyTo5PKZPYXD8DlqSU6AEu8AscH+9tstuf0/Ok9pMXfOz0vAtzwb0fnx6jIQEKPQfeYJWC+fkUt+gCdMrKY7A85fjJfeuh6XXabViy3MwiCRCaDWsbxvxo9vufoSNd0YQgrdNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133519; c=relaxed/simple;
	bh=0AHdAFoo9NUnBLi2yL1Hkt16S3TnM8kkEFOt08Qqdi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=biY+wBCYmaYpEGCBKyeMKwlBBbdthmT2lv4NVDn3gyNvNy/FlpythGkZ4/hFCit2uXDhrg7Q8UcdnUrmhQfu4MVmPRxFBugR/H71HaAguOagubmRWa0A5JuAgnlcNQPeXAeJXUBrlqMCKAeDasOYBO+QnNhFrBjIx4GkPf97rR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQK7cYNX; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24602f6d8b6so8240835ad.1;
        Mon, 25 Aug 2025 07:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756133518; x=1756738318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BqZleZrrFxOteURMhxhHqzZKHhKVUcc/Y6rTQqNU24=;
        b=mQK7cYNXXPSQK3cnKWWLSL60t2v3GzdZsVMqyH+puMON3RCCpyQJSOC1qTuEBtLZsd
         JPlOVxsvtBTB7o6Xlmh+5bRQtPODaYNFWmxOWiDW8gIHuLv/GU5TCKVks0Php73Qbvy/
         maq1zJhPBeoF1xEWRh5wTIwZBgK8e6dSNaTiu6quI+1dVN//00WSab1RhnA4Wry0c5A7
         eofY8amOZzVs1pFlcI7yCk93aTFgwX35Zbyoo35YYlbpBGpXF/krhsZG1Jc4HplwRUQt
         TWvqZwbdNvkCSPk4wCZE+sQ0G1hGtd2MkKR6WW5xcSR7tEAgyLhaM6VAet3J0a/jtHJe
         Z3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133518; x=1756738318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2BqZleZrrFxOteURMhxhHqzZKHhKVUcc/Y6rTQqNU24=;
        b=r5z3gOgjcT1IcWNId8PsaJ72d4bH3wRpnHUdwyzgw5gacG6UCUtYSDnB5gmjDaahxc
         Gwcu+w1CS8HxmZT1iTDDS4bFMa5jLg9ZdtRpye4ZCowy4PWi8jXp4eCScPVy+ysDP3hA
         w6L+asuvanqQHPQ2Dn17FvmQ0Yi+A2tN4fDUGtNQ5gU+2v5+NmFyGjcO41TXCdgUxKJv
         VzpR1z6C0lM8s61Ap+RIqL3UYyQ260kY2tZSrQCG4AFBucjULhyTsyXx+Kfw9B6d4DNh
         6fdgrBTdPwGx8P5vPfsAVlP8ChgNmGepyEvtCzhjejS4OBl+vMBzjHfYVII7BGpZHYx2
         8l5A==
X-Forwarded-Encrypted: i=1; AJvYcCVqlnxaKG1fKXmdkQuvZgv4PRu53wzeXrq7IjY0JSN+LVVKv3AN1J2RwvLtP90/zqsZ6iYUS+m2It2KlBs=@vger.kernel.org, AJvYcCXXljh3uBWNX/6Btq8/RwXxyhx3n2Rq6XMciQk4vum6UHWfRd6VRKS0tOs5IhjQlbcv081iriTelUfq3FJESXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyds0VUNrJELPDJlWalfK5Wr0AKVxyxinsYW9pHi+sOcJbfTgUn
	4eYhTfBXKxRlkvlhwKF1JbqNJnu6Gvfs2xwBj6x2SNlnSPf8Eix3rKAH3LzR0yRUrOdpYmzZKIh
	beW8nhrufHAG5h6QsGGZlHCmi9I6nA8A=
X-Gm-Gg: ASbGncu5ykYMa+nW/B8TS9+5/zpdbT8PdEytl/Mg4wuq3gVGT2s839AFy334SVyikpv
	PigHu9r06IAfe0q67wQUMDZgipZOOwOf+qN+XbYtqWYNKtRuE/msTQiumSQAdhktLcL3mYd8zsC
	uBvRcA8JLoKbCdM9alFXEzqUyWCGr5oKK4lil/0/BOcVHViNjXsMm0+fKCQ3ALxW/Xo2Idc2QEF
	03WchFtAdycZjJH07F+DI6tphoUpjjlKmmFDITCtEeBQQEwwGv5zuG/4xLpqtKQo35+z0VkvZmp
	4D6kndVYZv+QBLGp9wqtpwmqGA==
X-Google-Smtp-Source: AGHT+IHrHEtDFdZXx6OwpKEsX6eFTavEPg2U8G81wkwJbHp6xnJPfhKKEMwEDrqZpeVIjWOqmLeKxFAdl5tu053jfl8=
X-Received: by 2002:a17:902:e74b:b0:246:ed8f:c63e with SMTP id
 d9443c01a7336-246ed8fc9fbmr14687675ad.0.1756133517444; Mon, 25 Aug 2025
 07:51:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824213134.27079-1-christiansantoslima21@gmail.com>
In-Reply-To: <20250824213134.27079-1-christiansantoslima21@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 25 Aug 2025 16:51:45 +0200
X-Gm-Features: Ac12FXw8VAm1i2zud1eI5ub7qZLi4BK_xQJ9EuI65TDWsEAtHaZNbetakPRSfis
Message-ID: <CANiq72kGh2PS-c1n2Q1g0t24J-b3ctB0kN3GK8RDXhtQMGAtTA@mail.gmail.com>
Subject: Re: [PATCH v10] rust: transmute: Add methods for FromBytes trait
To: "Christian S. Lima" <christiansantoslima21@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ~lkcamp/patches@lists.sr.ht, 
	richard120310@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 24, 2025 at 11:31=E2=80=AFPM Christian S. Lima
<christiansantoslima21@gmail.com> wrote:
>
> Since the `is_aligned` method for pointer types has been stabilized in
> `1.79` version and is being used in this patch. I'm enabling the
> feature.

Period -> comma? No need to backquote version numbers.

> Even enabling in `rust/kernel/lib.rs` when compiling with `make LLVM=3D1
> CLIPPY=3D1` a warning is issued, so in order to compile, it was used
> locally the `#[allow(clippy::incompatible_msrv)]`.

I would perhaps try to reword this a bit.

> Link: https://github.com/Rust-for-Linux/linux/issues/1119
> Suggested-by: Alexandre Courbot <acourbot@nvidia.com>

Please add a link to the original suggestion if possible. If it is the
link above, then the tags should be in the opposite order.

Did Benno and Alexandre both suggest it?

> +/// fn test() -> Option<()> {
> +///    let raw =3D [1, 2, 3, 4];
> +///
> +///    let result =3D u32::from_bytes(&raw)?;
> +///
> +///    #[cfg(target_endian =3D "little")]
> +///    assert_eq!(*result, 0x4030201);
> +///
> +///    #[cfg(target_endian =3D "big")]
> +///    assert_eq!(*result, 0x1020304);
> +///
> +///    Some(())
> +/// }

Should the function be called? Otherwise, we are only build-testing this.

Should we just remove the function and to it directly at the top-level?

> +    /// Converts a slice of bytes to a reference to `Self`.

An intra-doc link may work here.

> +    /// In another case, it will return `None`.

Ditto (also elsewhere).

I would perhaps just say "Otherwise," to simplify.

> +    #[allow(clippy::incompatible_msrv)]

If this can be made more local, then please do so; otherwise, no big deal.

> +            // SAFETY: Checking for size and alignment ensure
> +            // that the conversion to a type is valid

Period at the end. I would probably say "Size and alignment were just
checked, thus ...".

> +    /// Converts a mutable slice of bytes to a reference to `Self`

Period at the end, intra-doc link if possible (ditto elsewhere).

> +    /// When the reference is properly aligned and the size of slice
> +    /// is equal to that of `T`and is different from zero.

Missing space after `T`.

These are all mostly nits that I sometimes fixed on-apply, for
Alexandre in case it helps, i.e. no need to send a new version if it
is getting applied already.

The actually-run-the-test is probably the most important one.

Thanks!

Cheers,
Miguel

