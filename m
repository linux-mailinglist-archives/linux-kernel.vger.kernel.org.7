Return-Path: <linux-kernel+bounces-755305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A843B1A45D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7DC18A22C6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CAC271441;
	Mon,  4 Aug 2025 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHCnwl9t"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC47B1DED4A;
	Mon,  4 Aug 2025 14:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754317060; cv=none; b=o/ptU3rW4gHk+WVuOb2aMkrIiXtefeAxPtVSlKAGAQpZVeboEvND8JE+V7kHGiYxdwywNeRilMOGfAbOFk0k2fcuNlbwJ6ic0DyB2WllIABODeEg5te+HuIevHmQVxiuNg29tSwjAcML8ustcF23eIGXCN+TdaNmGjQbmr31+QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754317060; c=relaxed/simple;
	bh=MFgHgyF0Iz4E4+42hQmWTTsQavQBJ5x9rIcuMVZaCCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QjswB/nyzW3FblnlCMW2tQkF/6lwoQQt4EffxyZ/2hZiuWMdBXpiqf2RYM3N8C2KGfUBgp05XoZX1uBjRoRT6OAm1svjiJNcDV/4kP+4AXfydTFUYds1vuOAbtArKrvrIMRa9vlFCd5lxLyExae0t4zRCfYQxJb6rWEtkmeGSVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHCnwl9t; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23ffa774f00so5659465ad.1;
        Mon, 04 Aug 2025 07:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754317058; x=1754921858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cj5LMXFCZ1M7KQUj/Qw+ZYW8TP1RxMgPY8c23lvf4BM=;
        b=KHCnwl9tCu51MEdrXudkiwjnFptZt+pJqxf6eKUl2MWxCe6wMxTMjITUOPqW220f0y
         mk537WWX4qIGM0lfYCkSk4tOhnIcmQ6b95FbudUJ+lBtV+aoE1J+lruuQnk7gzcOKvGM
         b0TKRE1mu0B2/nZCzB6+jzFJ+QGKiO7DuKxiYlheC87HYw90usdbRM7bsYGxZaQkW3yc
         DevUu86pc+1P7YcJ/Nf9SeuGUXgXnCoQP56yjJWD7CrwcE8G1bDvFTaHRUgayRRq4RiJ
         X8qL+uj0l4748W2A3Eg6+/PvdljbnXTI/L9jCEi6WY1tGL5h/KoKVaiQ8o5Nsj59PU2k
         tYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754317058; x=1754921858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cj5LMXFCZ1M7KQUj/Qw+ZYW8TP1RxMgPY8c23lvf4BM=;
        b=efbWmOOoD5Y5gSWqpoDLjbrj67kRUeaRiFN2WYs4HCXJRthLqeKRwLMHsrxBWkTM2z
         IR22dhNIZ/Gzxjqpe+FlYJNQMbsTOG3L53ULqUm1rPv72Ojvq5O7RNrSc+her+94KSze
         Pk9oHKMGAcF0kdNRL2NAfBQFuE8YVQTR0/yaQe8tJYvGkGqd6M/P+FOFPviwyyuFUA/9
         SZiTn3dop+YwdAijJqRrmweekIjMl5Jzw7r/Drs64Fuj1spAvoS9qy8lYCufDjkn27mh
         3uO20Ii4JyF+mkWlD59yG+hD9K0vGP93k+wda2ycNxvIHf/03bMvk4p7Qi5Hz6qJ2dpV
         62GA==
X-Forwarded-Encrypted: i=1; AJvYcCU72XiqPyAGyg2ytUuRKjUl5zxyXuBbqTJ+CO0wLQ0gqBdwdTqGRi9vG5woVh1Um2u5PHR/Dy67h9h2kG4=@vger.kernel.org, AJvYcCWRewBVm7hOarXt+hJBeCqFGYhPQvSw09KMd92IyvdmVl4aWbroDqdbe9mZyUy8HWOLzl6Nk8lkkijRLoFLNeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPAi0JkeaGOiqP9YCSnbiJRILJI6/RjB5LuqBnfQAGFhyu0Mjt
	loIzKbTXq2t/I66pCr7RPiDPBpTpc14U+Jbc+SlyLuctifDeXwqYU7PfJHGiNpfIpuN+MdSQU4u
	x6UAI8C8ihdLlV+3fFbjK0RDvW2k95MM0YXr8oKU=
X-Gm-Gg: ASbGncs0LOHQE/LvgEi2Zljq/pAdVDgiB4FEwkgRyxYWMQ2P1qhgQ6lTCxIhsnoyGnB
	SeXkciuge5TbYI9BNh+j2VuJdX/RKMZ6Eldb03gg7wN2jG10wg9spNL79z92jd1uTx7M9OAJjYf
	3RPdveeTPoNAJxRSeAtxRv5OSxDpL7HU/QSRVM6ACnmeh9iYR1fiApojYX/HtLnQk/iRHfsL3bn
	vLlAS9M
X-Google-Smtp-Source: AGHT+IHoIKRTao7XkfgA4kePRWm3e59NNTaknJ0r8ZXP5Lhp3Ma7eKeiuMTWnPj5rGZqOm7Zr5ROoZlk5pWcnXNkUMQ=
X-Received: by 2002:a17:902:e743:b0:240:71db:fd0 with SMTP id
 d9443c01a7336-24246fcb42emr54973825ad.8.1754317057946; Mon, 04 Aug 2025
 07:17:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804-num-v2-0-a96b9ca6eb02@nvidia.com> <20250804-num-v2-2-a96b9ca6eb02@nvidia.com>
In-Reply-To: <20250804-num-v2-2-a96b9ca6eb02@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 4 Aug 2025 16:17:26 +0200
X-Gm-Features: Ac12FXzf9euOeG2E0bVmnruyqbjbiK7AJnC-T013YUx-5fpBzzCknyhtAiw29Y8
Message-ID: <CANiq72miQSuEEzKZsOhHKDah1kP+8PYcmODGqwtcaRwAggF-+g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] rust: add `Alignment` type
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

On Mon, Aug 4, 2025 at 1:45=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.c=
om> wrote:
>
> +/// align down/up operations. The alignment operations are done using th=
e [`align_up!`] and
> +/// [`align_down!`] macros.

These intra-doc links don't work (they are not macros in this version at le=
ast).

> +    /// Returns the alignment of `T`.
> +    #[inline(always)]
> +    pub const fn of<T>() -> Self {
> +        // INVARIANT: `align_of` always returns a power of 2.
> +        Self(unsafe { NonZero::new_unchecked(align_of::<T>()) })

Missing safety comment (`CLIPPY=3D1` spots it).

Also, cannot we use `new()` here? i.e. the value will be known at compile-t=
ime.

> +        if !self.0.is_power_of_two() {
> +            // SAFETY: per the invariants, `self.0` is always a power of=
 two so this block will
> +            // never be reached.
> +            unsafe { core::hint::unreachable_unchecked() }
> +        }

I guess this one is here to help optimize users after they inline the
cal? Is there a particular case you noticed? i.e. it may be worth
mentioning it.

> +    pub const fn mask(self) -> usize {
> +        // INVARIANT: `self.as_usize()` is guaranteed to be a power of t=
wo (i.e. non-zero), thus
> +        // `1` can safely be substracted from it.
> +        self.as_usize() - 1
> +    }

I am not sure why there is `// INVARIANT` here, since we are not
creating a new `Self`.

I guess by "safely" you are trying to say there is no overflow risk --
I would be explicit and avoid "safe", since it is safe to overflow.

Typo: subtracted

Cheers,
Miguel

