Return-Path: <linux-kernel+bounces-761891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC82B1FFAB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC77F17B671
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 06:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4192D8DB0;
	Mon, 11 Aug 2025 06:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i5/clQyt"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC6F2D8798
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895258; cv=none; b=D7zyFk0cQxrrcOlRwKAJjnxlZhAeQs5zWm5M3ROwiHt5cIL+DnEaxqkalZvhg9wZm72pAXjvJVuowFmh2nsFNGEfe24h1QfHHk5oSs0uFD11xPFi8JqwU2/YkT0vx6xbWsrW2nrrnIkrmT+h0vaQg2MXGr+ieVo6RgDQKU8UPIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895258; c=relaxed/simple;
	bh=IMF7oxhWWht5Rfg97jPniIkxBcIiuZXkIEqgJK9FhhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SGWr2t9CZVURwUlyeCyExbO2lZPcteGcEG3oCbsEduBU6+/MVEyImp8m05s8evdYZwg5aH5GGm3TKhhWBV4sW6oSXaNXU8Fn8e7A6XZHvxCps9OU2NDm0F9eJgsMU5fA9O9oma8+SFSX6nZQAie2Q3XJNGTRUahrv62Mj4uqqnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i5/clQyt; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b7961cf660so3277368f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 23:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754895255; x=1755500055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMF7oxhWWht5Rfg97jPniIkxBcIiuZXkIEqgJK9FhhA=;
        b=i5/clQytAI6aNJ5lAru6FytsDdA1kj8Wj70cqEiMNDyFMW/BSxl2PwfEVO5I93EPeN
         vicnNtheqhW/40qANqgrfzgf0pt6b5uyYYagDM1VuKpnPjJ39GyS8MvwCbpG0fd/IS/6
         TUXCT+N5alEKrgzrHsQs+tW8ANbicIO/BUWXB9kLxhRT74ijwOmIM8HO5cNWpeITV2Gh
         lnL/2h2kqbEIagf9qs9S4ysnD9G5vPfJRfeWGt+bWs0bv0yaWEK1torbz2ihz61Cj1KX
         SzuG95k+vo+ZyCtyUWPk4SAhQJ+IEZijGY8xG5bWb4aOOwVhlmYskSb3gm1XmFPY1qJq
         z2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754895255; x=1755500055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMF7oxhWWht5Rfg97jPniIkxBcIiuZXkIEqgJK9FhhA=;
        b=QBWdlSLVzE8odcdVPMegxFLeGcwwxj60wSCej+wlLyQVg6z3HS956BlVkrPZYuNFyT
         POrsrD7CjtfR1MMrNiLP8GVPymMKTwUh+qqFToV3m2sFvDB25n66EUXLEqA0S92k1VqT
         h5Z1KV1y1P9iM5BLPySs98yhTkUPtgaiqxg25QEP9GEbrm7FbUd4sOqpH8kek9h86k2Z
         v5CzODG0mqn58/N4U/VyhunjbBs67hutZpsi97O8XdbyYin4N1bLQ8leOvC2iOFQan18
         nIGd12gB0HZcLoDTizIOX3DFp3xith9G+LHrL3PxFeBM7MTeGzeAP9rHuE4cqcuLA1FB
         VEAg==
X-Forwarded-Encrypted: i=1; AJvYcCXUK7zzoqxkILJ0U5AIlER6IKsL/bCW0Y6OhyCkTdqM+4aaf85Jgl2h+6m6IJeig0TACLFBz/uMtxzIr04=@vger.kernel.org
X-Gm-Message-State: AOJu0YymaWlUERLp7opMPAxtHnrUqJDYFLTEOV3Oc42J9wUgZBY1ixcZ
	7alLTB8vMstmID7HRn38qVLR39iM4sA32ZT94TjrjgeBIXaiwpgU4hc2SES0689+WVEbs6DcKg9
	NzVEQxkTj9jiVdz6Eymh1MeXH28bsoTKczyMomGgC
X-Gm-Gg: ASbGncsWHXRKZHOXpRdhRwT8G2h+95GYz8MbgAjougiUP4bCAj4gOd+Rqdevpe+BWDb
	fAVDWQCAeOMQbQ2ZPIoDImyFToxrGXvmfOsly/eEMmbCFfblh85euwGSRJIC5awRWwyKsKS6ePV
	TBteShiFa3UWxMr3KDQ3BPCuF8oxuQkbFTiCyFDUKUOtFX1GwN8pz/b0YsBgYlwQvz+pGJStVhz
	pqmBI3y7D/jiELDcOc=
X-Google-Smtp-Source: AGHT+IE/b40zkpS05GhNxK8XjZNGAut87hJOzbsMuY++YS8Jo6CClprJ6Pmx87Y6WX+z9WagLq8WqZGJ4Jcedzh3yJU=
X-Received: by 2002:a05:6000:1ac5:b0:3b7:9715:75f1 with SMTP id
 ffacd0b85a97d-3b900b735c9mr8726917f8f.36.1754895254840; Sun, 10 Aug 2025
 23:54:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721-irq-bound-device-v1-1-4fb2af418a63@google.com>
 <DCBBFAC5-A4B4-41BA-8732-32FA96EDE28E@collabora.com> <CAH5fLghRi-QAqGdxOhPPdp6bMyGSuDifnxMFBn3a3NWzN4G4vQ@mail.gmail.com>
 <0303C763-76CC-456D-AB76-215DF253560C@collabora.com>
In-Reply-To: <0303C763-76CC-456D-AB76-215DF253560C@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 11 Aug 2025 08:54:02 +0200
X-Gm-Features: Ac12FXzMwuxocaFnrrcDOWSm5kfQ5RQ2kLadCTdi78EU3qPMWKi0IrhJ_Ix6Rug
Message-ID: <CAH5fLghPz3UF-yKVt5x3JrMZ8f-mgT2gysRhJG8TK2kmF1ejGw@mail.gmail.com>
Subject: Re: [PATCH] rust: irq: add &Device<Bound> argument to irq callbacks
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Benno Lossin <lossin@kernel.org>, Dirk Behme <dirk.behme@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 2:49=E2=80=AFAM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
>
>
> > On 21 Jul 2025, at 16:33, Alice Ryhl <aliceryhl@google.com> wrote:
> >
> > On Mon, Jul 21, 2025 at 9:14=E2=80=AFPM Daniel Almeida
> > <daniel.almeida@collabora.com> wrote:
> >>
> >> Alice,
> >>
> >>> On 21 Jul 2025, at 11:38, Alice Ryhl <aliceryhl@google.com> wrote:
> >>>
> >>> When working with a bus device, many operations are only possible whi=
le
> >>> the device is still bound. The &Device<Bound> type represents a proof=
 in
> >>> the type system that you are in a scope where the device is guarantee=
d
> >>> to still be bound. Since we deregister irq callbacks when unbinding a
> >>> device, if an irq callback is running, that implies that the device h=
as
> >>> not yet been unbound.
> >>>
> >>> To allow drivers to take advantage of that, add an additional argumen=
t
> >>> to irq callbacks.
> >>>
> >>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> >>> ---
> >>> This patch is a follow-up to Daniel's irq series [1] that adds a
> >>> &Device<Bound> argument to all irq callbacks. This allows you to use
> >>> operations that are only safe on a bound device inside an irq callbac=
k.
> >>>
> >>> The patch is otherwise based on top of driver-core-next.
> >>>
> >>> [1]: https://lore.kernel.org/r/20250715-topics-tyr-request_irq2-v7-0-=
d469c0f37c07@collabora.com
> >>
> >> I am having a hard time applying this locally.
> >
> > Your irq series currently doesn't apply cleanly on top of
> > driver-core-next and requires resolving a minor conflict. You can find
> > the commits here:
> > https://github.com/Darksonn/linux/commits/sent/20250721-irq-bound-devic=
e-c9fdbfdd8cd9-v1/
>
> Ah, we=E2=80=99ve already discussed this, it seems.

My suggestion is that you pull the tag I shared and cherry-pick it from the=
re.

Alice

