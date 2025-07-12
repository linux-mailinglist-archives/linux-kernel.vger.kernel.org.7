Return-Path: <linux-kernel+bounces-728818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A7BB02D40
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 23:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2E03BD488
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 21:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7421EF39F;
	Sat, 12 Jul 2025 21:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ppfDqpBG"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05911EDA02
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 21:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752356645; cv=none; b=mED/4ZWYimu8CMiqwywhIImQDEdGfDWrNnNtyrfnL/vD3DDmPDTOGVphA6FP68lysUEjDYQfkpEsuZKiT7iW25MkR6+Jz5Vn37kSwouQkBT8ZUUO162XAQl9yXD/uGn0fV3GddzamDn1ZTY2WQstXFNqktvEgznf5im1bHTSeJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752356645; c=relaxed/simple;
	bh=g3uF/zoGkId6+KY/AVt4Y2W4PFG0QlMx0+rXBUVCrns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KWeHvqHl1ngzHEh0EDb2hBO9B/TCtSKIhM3mPq7X6kuhDNbFEofL6g9OzITGpygusTJi676dMWDB3uTWsEOXDXSH4XM5TE6fCjtRDi35Nul5HEBoIWvfB9RgqGVvDfDazfIjCdCRI+tiPckcIthy6HFF3/JrSCXP9pBftAm2vpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ppfDqpBG; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a6cd1a6fecso3124150f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 14:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752356642; x=1752961442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJzPr9w7Pyu1TsVJ2QolyITY32C7As+7Er3afc51O5c=;
        b=ppfDqpBGytBSYJaSuoRAuBRgjGscX2WU9PEdEwsFSNFPySf0KdlephUTcf0H8RmPXv
         rMpu1SHipPbrg+cRViSAJTDtYji63p3hDHZc1KxW3nrn3udE0bFbBGUK7dRR2C6rN8HK
         nAf9TNh7ptTotkCCEalAtmbqCrYtdJZDnbeGGGAkrLsLGwz0Tn/lu5Uedcd05QJ6Deat
         usRejxJpIxaZMPhLrZ5gxSiKLxsR69J36QAAkG7gLQB3LCfbJ2iYEe9nf2cvSUfqIU/Q
         ILeGLWxLeuEHHaAu9fxJl9GISfviF6GuTohGD0uDvhGtSsIsXW9vezeRDfyx2By9nIh6
         btrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752356642; x=1752961442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJzPr9w7Pyu1TsVJ2QolyITY32C7As+7Er3afc51O5c=;
        b=sUraRJu+EmNBztA3wuPGgVA5akfJ2nrryO4wxur09IRuz1OFPBR/hTtV7Ja3Bc1yCd
         3FcZtekwx/yb9JsvYrSOXyYgJAhWfFunWPNfsB5r+/9UqDmfKx8WePbkhpD4nWyuvpc7
         1s/72SrO7GnjjaDBZPhQ8z8EFJXpI6ptQ+GSyEseUOVJlU/n5M4VGLjvZfhCxPk2SBKD
         fsrhzOnvK6Yeh9obbdObRumq+Rbz/kXlmLxbX//6dvLnCfqgjKluOh5hEf+/OZPIKVVZ
         b48vazu67awy3pSTKENuI4hsqwFA1P/72NhpXuNtKoAAs2Vas96OJjsu5CgLZHIEvGIL
         WSkw==
X-Forwarded-Encrypted: i=1; AJvYcCX9UCiqgVKMGkNTamFFBvGuVPCccsH0gAcrkxLdTRTpuhkyomHZI+htU7WgavuOBp5ZZ0vUDyUF/VuiKYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpQNpgzpS/AI1peEHZvb6+fLvD5K8joBMbrefBXan085pAYrZc
	dK+T4Br8TWtI4S2E56QtWcUeoUmicnN1oLE5E3fH6WQxEke8Q5DtSKzwpdnkSP2A8idArCWUKLj
	CZeWUAusGAMSXDS2/4M37/1/jNUV9Ri+LQoTy6RUY
X-Gm-Gg: ASbGncuo5V+PUdqKpFx+KSWre4FQN0gFNwGJ/Uxx+Pr2Q8E8bhaD6638V3xWzZEtlrL
	y5bGRAyTgJ7W2Jk+uFUGx53NgYO+ejGp8CGCU4fVPCUamc9pTWE7rDyw0Meo68LWT27sJBSm61+
	BXjQCL0DLi9Tqsov5DQ4NS6jIbrR0/2QfEvDVVCvHsJiknNYcO+fZWDvzCc/BghTm8aW+k1coPL
	ZorPR1t
X-Google-Smtp-Source: AGHT+IEJCZL2ARGJeEeEwvrVmP2Ub2cGteMg+w7kiF1YDvqzpB5wrAQNEs5BtROFcFTFw+/s+TKqny8W+JPLAoTfeEQ=
X-Received: by 2002:adf:9d8d:0:b0:3a5:1241:c1a3 with SMTP id
 ffacd0b85a97d-3b5f18a7eb2mr5744590f8f.50.1752356642103; Sat, 12 Jul 2025
 14:44:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
 <20250703-topics-tyr-request_irq-v6-2-74103bdc7c52@collabora.com>
 <fcdae3ca-104d-4e8b-8588-2452783ed09a@sedlak.dev> <aGeF_W74OfhRbkoR@google.com>
 <49ABD63B-05C6-4FDC-B825-5AA2ED323F1C@collabora.com> <CAH5fLgggM7ZCX7nRz7M=hkxwzcp8UA1=2BQqRFA2CgN9eEUmsA@mail.gmail.com>
 <82EFFBBD-C6BF-444C-9209-70805E31EE9E@collabora.com>
In-Reply-To: <82EFFBBD-C6BF-444C-9209-70805E31EE9E@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sat, 12 Jul 2025 23:43:50 +0200
X-Gm-Features: Ac12FXzMen0His9GRs6zooYieCyoacBxhr-tKSvLnOA_LIg59_k_fvdb-RWybi0
Message-ID: <CAH5fLgiCVJbmYd0QC1n_ANeJoDbxW_hn-i5FnUkd5Hx6fxQ=fA@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] rust: irq: add flags module
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Daniel Sedlak <daniel@sedlak.dev>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Benno Lossin <lossin@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 12, 2025 at 10:49=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
>
>
> > On 12 Jul 2025, at 17:03, Alice Ryhl <aliceryhl@google.com> wrote:
> >
> > On Sat, Jul 12, 2025 at 6:27=E2=80=AFPM Daniel Almeida
> > <daniel.almeida@collabora.com> wrote:
> >>
> >> Hi Alice,
> >>
> >>> On 4 Jul 2025, at 04:42, Alice Ryhl <aliceryhl@google.com> wrote:
> >>>
> >>> On Fri, Jul 04, 2025 at 08:14:11AM +0200, Daniel Sedlak wrote:
> >>>> Hi Daniel,
> >>>>
> >>>> On 7/3/25 9:30 PM, Daniel Almeida wrote:
> >>>>> +/// Flags to be used when registering IRQ handlers.
> >>>>> +///
> >>>>> +/// They can be combined with the operators `|`, `&`, and `!`.
> >>>>> +#[derive(Clone, Copy, PartialEq, Eq)]
> >>>>> +pub struct Flags(u64);
> >>>>
> >>>> Why not Flags(u32)? You may get rid of all unnecessary casts later, =
plus
> >>>> save some extra bytes.
> >>>
> >>> It looks like the C methods take an `unsigned long`. In that case, I'=
d
> >>> probably write the code to match that.
> >>>
> >>> pub struct Flags(c_ulong);
> >>>
> >>> and git rid of the cast when calling bindings::request_irq.
> >>>
> >>> As for all the constants in this file, maybe it would be nice with a
> >>> private constructor that uses the same type as bindings to avoid the
> >>> casts?
> >>>
> >>> impl Flags {
> >>>   const fn new(value: u32) -> Flags {
> >>>    ...
> >>>   }
> >>> }
> >>
> >>
> >> Sure, but what goes here? This has to be "value as c_ulong=E2=80=9D an=
yways so it
> >> doesn=E2=80=99t really reduce the number of casts.
> >>
> >> We should probably switch to Flags(u32) as Daniel Sedlak suggested. Th=
en
> >> it=E2=80=99s a matter of casting once for bindings::request_irq().
> >
> > IMO the advantage of doing it here is that we can fail compilation if
> > the cast is out of bounds, whereas the other cast is at runtime so we
> > can't do that.
> >
> > Alice
>
> I=E2=80=99m not sure I am following. How is this compile-time checked?
>
> >>> impl Flags {
> >>>   const fn new(value: u32) -> Flags {
> >>>    Self(value as c_ulong)
> >>>   }
>
> Or perhaps I misunderstood you?

Well, that particular implementation would not be. But you could
implement it to compile-time check.

Alice

