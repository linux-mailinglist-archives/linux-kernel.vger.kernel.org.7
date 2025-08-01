Return-Path: <linux-kernel+bounces-753419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C78B3B182AC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A103A8551B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963C5226D16;
	Fri,  1 Aug 2025 13:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivM9yacJ"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020622E371F;
	Fri,  1 Aug 2025 13:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754056129; cv=none; b=tU8sHPSlzHzTLjVtJM3WabwFE0vAxwvSomqdvC0Rug+FT6+CBfmORgPNJBNFX2H6oA2xk6SOdhLy88n0dCEf9LMEQOD7Dhipl+9H7mjPdUn9AbcMsvUv2fOQwx4WgdB1l29S8xUlgFHXLhg0yKR5d1tkB4mrKSVmNq2mgHOcGlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754056129; c=relaxed/simple;
	bh=vgCSAA4ErduD/QpOXOR+7XpcNecyLzyfn71AtX3qTB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzpDiDELGVy2ri5KUzqQMFVtybLVOLLBAfgaZMWKHU6MTutHBMRux6v7QwECzP+m2N+aKGchvii9oh+PaOBMkZcSSgQbAz/uIO3DmaMxlAPYIKy9O/+wloB7gf5SukrP1epebgpG3xrCgG9pqe0nFBSYdfRKePI8CSo/TtxRgUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivM9yacJ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23fc5aedaf0so13182725ad.2;
        Fri, 01 Aug 2025 06:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754056125; x=1754660925; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NHzYamBkV5ewzWXFvxbgZKjihzuC38HrO9o8VCvPljk=;
        b=ivM9yacJHnCbEdnN09I/Xf5VSEqgWGlrnZaKWcOeeafyp6H3ET0OpRpBWBeg2OAJ1c
         QsCsg7H2CSAsXfzRfHqGNyEpPzovxyciAXGA0FZ2q0HjxbndV3L+nSnPU06XxTjSn6CR
         QA5bYUNPlTuQ8+hpGPq1UBfy26jF7cPR4czeJCeNCk4XDUy7Ecw1VLmcOCmOJ4u1Fiwr
         iXoQnQEk0W9rjrpuGtyJV597jLAJcUz4offr25uYM8A7fTPsE56lnSdePFIOqrAQoL96
         xgfuqjMB8ugj8mmCdRe5cuJATse7KjAfW0vfbQLs7Vi5ss3t2c7Jzo7LZxTaSvZbSjhF
         Aa9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754056125; x=1754660925;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NHzYamBkV5ewzWXFvxbgZKjihzuC38HrO9o8VCvPljk=;
        b=G1kH+Mnr+miL5DHRpQdr5W0xv+kHc0KSXi0b3V0EIB5PADHubsy0SaOuNNUIjC5U+e
         aQ3e+zCmF1k9031niguyJLkl8OOAtzSYTkw6G49Q46UR9XAtHC5Ebcwv87wGwkDj6Lq8
         HYmFMlEq+SeVgJUt0sJMF5RWy5cYJeW+WZXtKuikXxdSnNRsHjVisAErEdGknLJIcDX2
         3eCoTYcetvrY0Uh7HCWcmF6qR29Rsq6nWMJzlPHnAWMt+jGzEkISAemzAp1adbEc2TfX
         iLRA8Scwyptgd6vB1V99Lrf6OlY4QAy+M42My4GxklKT94/NJ5LkMc0P2vjdiWFBu1fg
         s0tQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8pU2ifMAcGXiF7SrU/MTC0lIJ8HsyHNPvNVuFpzb7Dt4f5kVSFgP1Tf3+8RcfDUikL6pgqFU/MFJH0y50BF4=@vger.kernel.org, AJvYcCXuFcLcO1bFPCdiOevnNcF5R9N0ZgyaoWMDOK1SrsJrTR/F1/kpPKT+tEBQe9gIgOYTOsFwWRxcBaU5J78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8fP2xh/iu2r8IGAzV7Djgv38ARO/OVIKcmXVu4VMwLqWZxcdI
	WfwW2PQ7cZT5CM3HxrRkGfniJZKJXm5Jv1UR9+KpSyllDm4VuKgq5/9/
X-Gm-Gg: ASbGncuvzNcJ38Z+UfMfzkLh6yqgfWJfDrIlboK6Y/AW+KpYfSKcayFBnvJuiNKJtpI
	rcCXJYo4DZvOFCAepW0EWqLO+Bk0a0xtxSwyKj8DjvzHDKS6LF7Wc5lLEm4N7QvZSG3uerQ59bt
	t+y12fA21KTl5PENrmChe0kbH6aQNCUWcaRowDD4ImugI7VmHTh1AVhIUbpIkru65fGpUbunBHK
	go6MG2qXCZ8ZL6sfxF9VIaSyqbEL584S45O6ElR1RRzGEPNO8pMmG4S4/ZSfDeAjhTHNYBPxgWL
	Naab5Ydr5v+hvvQzPESvreIvpSk2tTnJIfw083q6WvXFJmlrGO4OBrduYzuuweLuV1M15S4hPCa
	W49sfje90YeKxr7n1q4c=
X-Google-Smtp-Source: AGHT+IFgh6B75+JlHBZmUSEY1FR7SJrGPsWik4EXytdm9L+UPLgS5ERRybsUtROXPx3D8kDg2Od3Ow==
X-Received: by 2002:a17:902:c405:b0:23f:8d03:c4ac with SMTP id d9443c01a7336-2422a339741mr48610365ad.2.1754056125155;
        Fri, 01 Aug 2025 06:48:45 -0700 (PDT)
Received: from fedora ([2405:201:5501:4085:eece:e0ff:6b68:de2e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976995sm44195785ad.91.2025.08.01.06.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 06:48:44 -0700 (PDT)
Date: Fri, 1 Aug 2025 19:19:09 +0530
From: Ritvik Gupta <ritvikfoss@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3] rust: kernel: introduce `unsafe_precondition_assert!`
 macro
Message-ID: <aIzF1dMtIVXN0pDj@fedora>
References: <20250731111234.28602-1-ritvikfoss@gmail.com>
 <CANiq72nDY_ZOk7=1MX3RQqzscaXayAm2XkaeQ0UTke-kdy1fnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nDY_ZOk7=1MX3RQqzscaXayAm2XkaeQ0UTke-kdy1fnA@mail.gmail.com>

On Thu, Jul 31, 2025 at 01:42:42PM +0200, Miguel Ojeda wrote:
> On Thu, Jul 31, 2025 at 1:12 PM Ritvik Gupta <ritvikfoss@gmail.com> wrote:
> >
> > +/// /// - `buf` must be non-null.
> > +/// /// - `buf` must be 16-byte aligned.
> 
> We don't know since the full body is not shown, but it is likely this
> would need to also be a valid pointer, i.e. it may be an uncommon
> example.

I believe this is a valid use-case for `unsafe_precondition_assert!`.
Should we add similar example?

```cpu.rs
/// Creates a new [`CpuId`] from the given `id` without checking bounds.
///
/// # Safety
///
/// The caller must ensure that `id` is a valid CPU ID (i.e., `0 <= id < nr_cpu_ids()`).
#[inline]
pub unsafe fn from_u32_unchecked(id: u32) -> Self {
    debug_assert!(id < nr_cpu_ids());

    // Ensure the `id` fits in an [`i32`] as it's also representable that way.
    debug_assert!(id <= i32::MAX as u32);

    // INVARIANT: The function safety guarantees `id` is a valid CPU id.
    Self(id)
}
```

> More importantly, could we have a user of the macro introduced in a
> second patch so that it gets already used?

I believe the `debug_assert!` calls inside the `unsafe fn`
(excluding 'const fn' and 'CONFIG_RUST_OVERFLOW_CHECKS' flag) 
are the intended targets for `unsafe_precondition_assert!`.

A quick grep (`git grep -B 15 -A 10 "debug_assert"`),
I could find 6 relevant callers in `alloc/kvec.rs` (2) and `cpu.rs` (4),
unless I'm missing something.

I'll send another patch for this, after getting the example correct.
Thanks for the feedback :)

