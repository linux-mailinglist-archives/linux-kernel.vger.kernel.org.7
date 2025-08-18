Return-Path: <linux-kernel+bounces-773777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A287B2A997
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA161BA695E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4051034575B;
	Mon, 18 Aug 2025 14:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dTNBT+M9"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9015334721
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525644; cv=none; b=Nhi3PuQJpStrhIfsAcyjF1eGL1unRgWUkVYwLzSY6Fw5ytD2CNDk2jkxopgNqn4a/7JCyJ7HWQ28f/YBEoBrCvWkf5LhxTK2cPSX3S/21fh3S90Tbh3DCeXWV1TunPijc2S0VsRXjPvzhkGOQKu7sGZvvsG6O9OvPWW44YjIJm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525644; c=relaxed/simple;
	bh=j4dxZvMIsnu96pdNWhEO71lMIgFAwiyiGxghEdpT/Zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kAd4UYd3g63TZk2zuBVDXj55pCoadHGhgRXx108XwhhJoS5ycMqWOvuPWd0DWUeZL6MUukdn6vE56u+pZ3YytnS0m8gv08r0fcag8DP5D96aJEt3AWJjXh/Yu1OxgO9AW5mpXlVGUDPdJgoL48fvIibtQLj1YeYi3i0hmEy/fB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dTNBT+M9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b00e4a1so27592275e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755525641; x=1756130441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LERH+4S6MKDV2FjiZGpbA7HIp9naO0TKoXGRD11W5PI=;
        b=dTNBT+M9K312JN42sf5sobs3RP90Iy4/NNZ9bGfqVxVyvsgnuS4LxlzOkNKtAuEba1
         /wOs/j0Zl1nfT+A2X9YbyemRcx4PI/J0MnDIttQx4cJVtV4L56gPfPfRXwLhd3iMTkbn
         o2CzriNzdU4UudJjKdPFliySxu8a/QI2WzGmiITv5uibToNOhCaifXO53RykUNRHTWB2
         GiS7jDrzmAaZRfneFS7QHSM4n78pXFmuiv8P+hr7PNiZmwnP5lwiSDzLGpllK/28Qnt4
         dc3x69ktW9++gjlggFwWv3I299oogYziJI9XN0qdmp1mSrmm7uJ0F5Okp83tF4Pk5Exi
         dbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755525641; x=1756130441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LERH+4S6MKDV2FjiZGpbA7HIp9naO0TKoXGRD11W5PI=;
        b=VU0MCGnrICYmWbHOr+KeWamjptU1b/WFDeXZI6l/ZIEKDh+bqILQ2TbtG4bGWiuJQg
         pdmOeeR1ze1OoDqrJstmKUc8bnyrQX5LflCCeajBUy2oJkfM2m0XRidNRrgZqxBo0SRd
         JdeCJngO4SQAwZiKjYbLDoRzVdaozN5GseFOBZWh2b6s2FEtItNdg1AVU2ucBQQsuFA2
         WVZlrcBi5txVKcvMojHeK3IujJv4rLHhIQjsaF61CvYeHTGNLj+Rk8CaS//weQ/LZ+Ua
         D2J40wItLnMjziWfREpa1r/i01swIDZ5bVlUvkydF3xDyfAP6jpAIhHcN6eGMo2LqDRQ
         q68A==
X-Forwarded-Encrypted: i=1; AJvYcCV8dzjSyZP+FjV5ns/zedLXf1RmjyE62ypAMh5tj0fNg0cTOGuFodMlh8atodpCT8xuH1E/DAE+m30j0so=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkVrvPfs5By1Dswkxd9GXDA2SiOcbwgBOZ56wIf0P6WaHUg6gC
	AK0boo0+Rz85VJh4MmrVg4M8LUWX7rK2sebQ+jZJ0TTndupCiME9DY9xtx7oA+0X6kowScK8MQX
	AqyiRsNn/BB3lwYREwKGv+zQJGhecLUd4lZs175Oi
X-Gm-Gg: ASbGncutUXTE37F6wGs2tgn7073FYAzwE5+Go7H7RDE9XX5wYonUm1FFLP0zlugv+db
	sJz3SydX5tHgFwRzzHARDLMWWxRCWY7MB++eHMRyO40wodmRdr+pEk25nPOTunWtu709upjcAwP
	GCIVu5c6mqDBotogzwmR1Zl5QgDtOSbkosQDysM5+dyQzk5Yf95EtzDugT/7VcwABnbtK+drscv
	1R4Itzjab+CXQap4d/OohZj0uE6fx3DTwCZZesstrSBVEds
X-Google-Smtp-Source: AGHT+IHx7KsKVi01XWbXuzwGL6RWiwHgwWOoLF/CZ/s4xxyQzI7mYIcDAffbw55tV9bAS1QQIs4V2clOdwTtPOHB+mU=
X-Received: by 2002:a05:600c:b8d:b0:459:dfde:3324 with SMTP id
 5b1f17b1804b1-45a21857f09mr100132795e9.29.1755525640601; Mon, 18 Aug 2025
 07:00:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815171058.299270-1-dakr@kernel.org> <20250815171058.299270-2-dakr@kernel.org>
 <aKLzrp0m00J6CCYz@google.com> <DC5INEG2DXU5.DM4JIICEQ2PC@kernel.org>
 <aKMa7YzO-PwEv9AT@google.com> <DC5KK67M752R.N9PX4LUG2F68@kernel.org>
In-Reply-To: <DC5KK67M752R.N9PX4LUG2F68@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 18 Aug 2025 16:00:27 +0200
X-Gm-Features: Ac12FXw71lT-sa08Sow1dkhfN1gjNRFkyLNRIW7cb0GpdCcOBD3KYCaUW0zEc7Q
Message-ID: <CAH5fLgi6OZaqjnDScDrJ3YjN2a8mJuPiO5MLPUqUWo62WkvvrA@mail.gmail.com>
Subject: Re: [PATCH 1/4] rust: dma: implement DataDirection
To: Danilo Krummrich <dakr@kernel.org>
Cc: akpm@linux-foundation.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	abdiel.janulgue@gmail.com, acourbot@nvidia.com, jgg@ziepe.ca, 
	lyude@redhat.com, robin.murphy@arm.com, daniel.almeida@collabora.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 2:57=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Mon Aug 18, 2025 at 2:22 PM CEST, Alice Ryhl wrote:
> > On Mon, Aug 18, 2025 at 01:27:44PM +0200, Danilo Krummrich wrote:
> >> On Mon Aug 18, 2025 at 11:34 AM CEST, Alice Ryhl wrote:
> >> > On Fri, Aug 15, 2025 at 07:10:02PM +0200, Danilo Krummrich wrote:
> >> >> Add the `DataDirection` struct, a newtype wrapper around the C
> >> >> `enum dma_data_direction`.
> >> >>
> >> >> This provides a type-safe Rust interface for specifying the directi=
on of
> >> >> DMA transfers.
> >> >>
> >> >> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> >> >
> >> >> +/// DMA data direction.
> >> >> +///
> >> >> +/// Corresponds to the C [`enum dma_data_direction`].
> >> >> +///
> >> >> +/// [`enum dma_data_direction`]: srctree/include/linux/dma-directi=
on.h
> >> >> +#[derive(Copy, Clone, PartialEq, Eq)]
> >> >> +pub struct DataDirection(bindings::dma_data_direction);
> >> >
> >> > Perhaps this should be a real Rust enum so that you can do an exhaus=
tive
> >> > match?
> >>
> >>      /// DMA data direction.
> >>      ///
> >>      /// Corresponds to the C [`enum dma_data_direction`].
> >>      ///
> >>      /// [`enum dma_data_direction`]: srctree/include/linux/dma-direct=
ion.h
> >>      #[derive(Copy, Clone, PartialEq, Eq, Debug)]
> >>      #[repr(i32)]
> >>
> >> Does bindgen ever pick another type than i32 for C enums? If so, it'd =
be a
> >> downside that we'd have to mess with the type either in the `repr` or =
by casting
> >> the variants.
> >>
> >>      pub enum DataDirection {
> >>          /// The DMA mapping is for bidirectional data transfer.
> >>          ///
> >>          /// This is used when the buffer can be both read from and wr=
itten to by the device.
> >>          /// The cache for the corresponding memory region is both flu=
shed and invalidated.
> >>          Bidirectional =3D bindings::dma_data_direction_DMA_BIDIRECTIO=
NAL,
> >>
> >>          /// The DMA mapping is for data transfer from memory to the d=
evice (write).
> >>          ///
> >>          /// The CPU has prepared data in the buffer, and the device w=
ill read it.
> >>          /// The cache for the corresponding memory region is flushed.
> >>          ToDevice =3D bindings::dma_data_direction_DMA_TO_DEVICE,
> >>
> >>          /// The DMA mapping is for data transfer from the device to m=
emory (read).
> >>          ///
> >>          /// The device will write data into the buffer for the CPU to=
 read.
> >>          /// The cache for the corresponding memory region is invalida=
ted before CPU access.
> >>          FromDevice =3D bindings::dma_data_direction_DMA_FROM_DEVICE,
> >>
> >>          /// The DMA mapping is not for data transfer.
> >>          ///
> >>          /// This is primarily for debugging purposes. With this direc=
tion, the DMA mapping API
> >>          /// will not perform any cache coherency operations.
> >>          None =3D bindings::dma_data_direction_DMA_NONE,
> >>      }
> >>
> >>      impl From<DataDirection> for bindings::dma_data_direction {
> >>          /// Returns the raw representation of [`enum dma_data_directi=
on`].
> >>          fn from(direction: DataDirection) -> Self {
> >>              direction as Self
> >>          }
> >>      }
> >
> > My suggestion is to cast on the Rust-side.
> >
> > #[repr(whateveryouwant)]
>
> What's your suggestion for whateveryouwant?
>
> And I mean this in general, not only for this case of dma::DataDirection.=
 If we
> pick u32 than things break if a negative enum variant is added on the C s=
ide. If
> we pick i32, it can happen that we overflow.
>
> > enum DataDirection {
> >     Bidirectional =3D bindings::dma_data_direction_DMA_BIDIRECTIONAL as=
 _,
>
> We have a clippy lint that warns about `as _` casts, but I guess you mean=
t
> `as whateveryouwant`. However, if bindgen picks whateveryouwant too, we a=
lso get
> a warning.
>
> Ultimately, we'd need to suppress a warning.

In general, I think we want some sort of helper function to cast
between arbitrary integer types in const-evaluation that panics if the
cast is out of bounds. Both here and many other places.

Alice

