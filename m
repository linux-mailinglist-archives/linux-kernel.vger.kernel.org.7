Return-Path: <linux-kernel+bounces-755301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EECB1A44F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58078178E2B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772EE271441;
	Mon,  4 Aug 2025 14:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReC32taa"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E3B26E142;
	Mon,  4 Aug 2025 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754316999; cv=none; b=X8vJg80jd67ZBWgDB6m7AOpZ4N3XpDXnYoyajVi31y74Pj/RcxeXjl+IxMLtoZT6MI6KSqRzpo+JTjqy4Leg8rDhbj683ch1uLMrDcxaGGee3LFP53Xy0+ldkbT9gPCNrfIPwCKxv3Oy8o0yGsadvXLeOrcIUNSdfQDZ3gCIlR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754316999; c=relaxed/simple;
	bh=13nQXf2MXFWJJ9YxsnwMAzwpgTMydQn5q144rXppyeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OUN1ErZ60bMacVMaNC8dSCS2go1fvhKv4BhUfad8XkdwgaAx6BXNraJGrcw+HwSHST6fLC2WuBg1SNeVh73LceeyNaK7juF0YbdkN5SliW/Yih7K65UAyIGQSMg+e/+u676xC24BiJSMLebBwSqSCiSLh02y22Iq15/D7gr+3ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReC32taa; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76b81161f45so252495b3a.3;
        Mon, 04 Aug 2025 07:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754316997; x=1754921797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgDAHWFhVwGpRNKhb0AEdmDTrFYe+pHDBd5Ka/1/dW4=;
        b=ReC32taaEKRuZUtGFr6I1/zLvCjjSZgFne4nNGxEpyM5YUm+dmvmxwsSFmiXc5PC8g
         hjNxgxXGUDJ56AAAyDi/I3B8Pxmm1RYAiBR8KM4BgC7/uUsAWytdWI0wtpig/DZbvl1e
         ITLnQt+0AjAwkLXOltLYxYXhIYqr9Kn43iZM1hyHRObg7sGxCo7WkKrB3dG/k4gSMLT1
         JeaM2PZPSpvfroR5aLHU0DStyE/12Gyyc4a7Whcz7ExUGs6SSxJuQ9gWSJqqfbZWb527
         ksb7VbhOFfOksAUzqxIYkayoa59iCzMKKrQUhIK/+ye+oIeqtpiuhbpz8qDKfUVaH/VD
         UERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754316997; x=1754921797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JgDAHWFhVwGpRNKhb0AEdmDTrFYe+pHDBd5Ka/1/dW4=;
        b=rIL7vH/tphoARvLRiCKTmf486zWIyWHHVlJSWZ8H7/q/MLAIyDzbwDelBHWpnz8XoV
         DKs1dHVEV41qKHVrFM7cooJsD+qtVSQszU6IRRboPvjv3S7XLxfGzDGsv35hlnogYpJp
         K+WMnHImGMneWaj4eDi/Wwef+SX52oWu5LemAI+3/xEMNCI16mmf775smkidwyFNc6lJ
         jJyCyzTbwr+jSUHUuk58mZOlB7JK46qIJw5AOpyTgp8HqylDdnmHKimd6DdUL3B3X33q
         WRxXB+Ihlc+YtOBHfF5kZUGAcdHpPWvMUkvZqH2CQb9eTwW96egq9/n/bMT3ZUMDkjm1
         otGg==
X-Forwarded-Encrypted: i=1; AJvYcCVlAsJ2OM7MQtJXVGXVN6NnMlA+CUpB6oodpaLZM8gDEq8j7saYgUqtl2zUyL9sHdn5s8fCfoMqguYgNAOQSSg=@vger.kernel.org, AJvYcCXTmPzWhYmKMyxbwcsesawZ6MLAWf9oHccsh8JBCf+q56SAbKRexBo7wYLHnxT5ZWzmoWvOiotfmJYvJG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGNfQHIR1BQyot6ZTZmIBvtpaO5xPm6IsKM9s9Whl1/t5Y00Pl
	cqG5NV/qchSX1qWHwdUfdFmCuRrarnUEibigXVoDdlyOFggprvEGT8PvV43I99vhurH3L92Z8ig
	rYtoOLQOsiX39ISXJxSk32iVy7PyiFSA=
X-Gm-Gg: ASbGncsUFbHiJ5Klg67ncyzlh2puMdK4p/jPIlvKgmqTDZ3gEsbLI9vNGFQ0GEFNA+n
	dcnjbP4leOAKUe5HRE6bAgV5NELr51q51kRLHRarlUgPNYNzIKtEBB+5LdzisqSZIrCEYLEywGQ
	9o85J8EJ/gI/keaDVzKXaWbqh9vkMEHNM3MDKsHaHSwXyZJwyyXFUG8uxR5HzOK4/N18T2lLzBW
	U8LbX73IPf9mhaq1Gs=
X-Google-Smtp-Source: AGHT+IHHggR0XTFbQEEybwLhQWYFEh3VycMYEY6HgdFW8J7vPcer8wJi9FGlCMFZ72vcVudiPgvVRU7PL/+X8CjpuXU=
X-Received: by 2002:a05:6a20:c6c1:b0:240:17b3:3851 with SMTP id
 adf61e73a8af0-24017b33c2dmr1069613637.1.1754316997374; Mon, 04 Aug 2025
 07:16:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804-num-v2-0-a96b9ca6eb02@nvidia.com>
In-Reply-To: <20250804-num-v2-0-a96b9ca6eb02@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 4 Aug 2025 16:16:25 +0200
X-Gm-Features: Ac12FXzU7NmSVNVwYMFLEOWr49mfh3wxZZCCON1MnCd2t8fHQm-Ufjf7MXkUMZ0
Message-ID: <CANiq72mEDhT_OvSo1b=z4Z4VhND8+DFzeGBY_NNfXhq9jy5GhA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] rust: add `Alignment` type
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
> - The `last_set_bit` function is dropped, with the recommendation to use
>   the standard library's `checked_ilog2` which does essentially the same
>   thing.

Yeah, let's see what people think about this one on the kernel side.

I don't mind either way, i.e. to have a few wrappers with slightly
different semantics if that is more common/understandable.

> The upstream `Alignment` is more constrained than the `PowerOfTwo` of
> the last revision: it uses `usize` internally instead of a generic
> value, and does not provide `align_down` or `align_up` methods.

`PowerOfTwo` seemed fine to me as well (or even implementing one in
terms of the other).

> These two shortcomings come together very nicely to gift us with a nice
> headache: we need to align values potentially larger than `usize`, thus
> need to make `align_down` and `align_up` generic. The generic parameter
> needs to be constrained on the operations used to perform the alignment
> (e.g. `BitAnd`, `Not`, etc) and there is one essential operation for
> which no trait exists in the standard library: `checked_add`. Thus the
> first patch of this series introduces a trait for it in the `num` module
> and implements it for all integer types. I suspect we will need
> something alongside these lines for other purposes anyway, and probably
> other traits too.

This part could be avoided implementing them the other way around,
right? i.e. as an extension trait on the other side.

It may also be also a bit easier to understand on the call site, too,
since value would be first.

> This generic nature also restricts these methods to being non-const,
> unfortunately. I have tried to implement them as macros instead, but
> quickly hit a wall due to the inability to convert `Alignment`'s `usize`
> into the type of the value to align.

I guess we could also just have one per type like for other ones to
have them `const`, like we do for other similar things like
`bit`/`genmask`.

Cheers,
Miguel

