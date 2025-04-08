Return-Path: <linux-kernel+bounces-594904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63180A817F4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 23:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EEBB1B67C86
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 21:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782ED2571C6;
	Tue,  8 Apr 2025 21:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="lZAxYtak"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB2A256C91;
	Tue,  8 Apr 2025 21:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744149261; cv=none; b=ihm53oRKZU6kNW9fYdwWA9yu+YtwaWIJXfYTlj3XheMJrne3rVFzvcChFQIBt60Y5mrg/lBI/Yu5PlvqldwUgieb26/Bl4mlX33bj88DxbJS5qHItStkjN3gPqqIyPeSuVZZ1XSdgjcP/2diY7KLwWgvZB1MP0+F7YsFs524sF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744149261; c=relaxed/simple;
	bh=N2bmtbQcDP9Mdup7ZszbI863T052O3MauAWYf2Olje8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l6BlL/F9jac5MTX0qVAMphiuqnPHzDimHz7XaAL9+e5TY6gw6AOpFamvvSfB54SRYWN+VcqyJ5qB0bYA3SNEHYzMN/PawQU/aQuzU00rl0w+cLDm5zRSNGeraC6iYW5FeUw0pkffcOPCU7NMR5lyNre4cLXEE7Zf3EwFoVgcodQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=lZAxYtak; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1744149258; x=1744408458;
	bh=N2bmtbQcDP9Mdup7ZszbI863T052O3MauAWYf2Olje8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=lZAxYtakptsiy1arjsJjMqzyrOhX+dpUg+wP29Zcma8a6BFHFK26cH1j/aspw7LYq
	 EkHUwvi51Foe8p13dtEqVYeoJxso/81F3s6IGm8YJocWT9kpw9phHsSwdvsqaygHt5
	 9ccbTt17CzdFFwzoSdG1xBT/Hcm8nEOcsoylvoHPasvy5PhQMc07reaPaowMeRzT2z
	 X0gjwbsc2GApi1momsNezJeSbs3kPJDTGR89S/Yvy+PVJW2qp7/Y2OJ6ocL5cTUUzI
	 EYTIm/L9dI8ZZOXv5f+jdZQ64SCUemMy68w+Th+N5MBUKhHiV32X2TU99Zv2awNvQN
	 R3ZplTa08UpsA==
Date: Tue, 08 Apr 2025 21:54:13 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, ojeda@kernel.org, Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, "open list:DMA MAPPING HELPERS DEVICE DRIVER API [RUST]" <rust-for-linux@vger.kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] rust: dma: convert the read/write macros to return Result
Message-ID: <D91LB39LUIG6.1P7MMHZ6YHSMA@proton.me>
In-Reply-To: <87a58qh1w8.fsf@kernel.org>
References: <20250326201230.3193329-1-abdiel.janulgue@gmail.com> <20250326201230.3193329-3-abdiel.janulgue@gmail.com> <nujfDI6IKBsjlQtGWaMrhjZSQYYeQYckCyOUs9jIzgZGsP1WTalJE0sSg6tp_WMACWo9mzuDfpdzsIlmkKnL8w==@protonmail.internalid> <D8REH728BFP1.2BGE9DTRP2IPU@proton.me> <87ldsahlxr.fsf@kernel.org> <NBhs6N93VPsKCxDOdnggZCiQWIxBfcYJU49nl2DmkqlTDaZet_q7V-_LjkS_uZPtkb8u2yW_oRh0TVjV3cLdkQ==@protonmail.internalid> <CANiq72mahS0jiOHv-7RE8QWQunYo0bJqeGo-FAVoUL7v42RsoQ@mail.gmail.com> <87a58qh1w8.fsf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 2d5278348a76761637ed3d6c8c0d86e988b34425
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Apr 8, 2025 at 9:46 PM CEST, Andreas Hindborg wrote:
> "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com> writes:
>> On Tue, Apr 8, 2025 at 2:40=E2=80=AFPM Andreas Hindborg <a.hindborg@kern=
el.org> wrote:
>>>
>>> But the `assert_eq!` would panic anyway if comparison fails, right?
>>
>> Previously the `?` generated by the macro would return out of the
>> closure written by the sample, and thus it wouldn't reach the
>> `assert_eq!`.
>
> Right, I see. So the question is whether we want to have the assert
> panic here or not, of we get an Err. I vote yes.

The assert wouldn't be the source of the panic though, it would be the
`.unwrap()`, but I think it's better to report the error. Although I
think it would be nicer if the example could use better error handling,
but this code is in a `drop` function, so no way to bubble up a
result...

---
Cheers,
Benno


