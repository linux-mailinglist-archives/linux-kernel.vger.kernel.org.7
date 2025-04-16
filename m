Return-Path: <linux-kernel+bounces-602732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA83A87E91
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 13:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40F891897080
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 11:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96C6293B4D;
	Mon, 14 Apr 2025 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Um6HdJmM"
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80471DF42
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744629061; cv=none; b=At550iHpDn/Jh3mCgQ8zZxT2+xnl795r3DIGxVWg4VWd7l6imTYKj4uV/LAn2IpV4cul47jWq3H4RrM62WqVRHpq/rIcMWKMW8rYnwdl6gdc29Y1ONOvRIhh/GGDGbiO8VLOTKRNTr5JwDBM9Ag07JZ2YABtieNWVW1HGttMrlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744629061; c=relaxed/simple;
	bh=9Vep7/5YPgD9bMair/kXqnEQVoJBlizsE2UGtAaNckE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PnaqqRGf4QcJTW/kLw8YEirFPX5o/FydlxuVov/5n3b4cOY4k6YoI9RdKbEfBwtLHDne4lQHHBt7ll7FCS7FgVfNjaFdgjZ//JTCJydiOeqDLVe9zQOTpiNnxnoUCJwx6BC80ujwwDq30hS3tNLL48Ij5N45sX7/H1sHsnOYD20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Um6HdJmM; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=6ugw3erzbffzvieb4nbfwa2try.protonmail; t=1744629057; x=1744888257;
	bh=YB3aL+anaTQ18vPfGLTzxQTLMQsbFelLoVESPaQBWz4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Um6HdJmM+BE2UxoijTgbn1ejCIVGeWK5jbj8AfSl4CUhCM0ZUcfV/OuBU2L5jDIM0
	 mK2hDWav5eMG3qtGwzdEIDFMkJTFMjJtVhmvfJu3QjeXEeygWjNEz5BuRS1p5wB3+q
	 Al/kiQkRfw18moCHU8XDupYUdKbnNZLZO7U389guNFy/J4NfciWHzHY/JPQy1IX3+1
	 Xdr9RBnONNIn8it1qJjMA6ByftYpOi0jQvS6Tn4zUgVgbEoWvAYj5Eco7zflM3TGjd
	 bX2tCuCuI3m+486uz/94/aToTysf1pkvFssj/kKjc9i7dzYpc/FeVKQ2KwLbbHHLBf
	 OnIl3jT7OlT8A==
Date: Mon, 14 Apr 2025 11:10:50 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: bhelgaas@google.com, kwilczynski@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, abdiel.janulgue@gmail.com, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, daniel.almeida@collabora.com, robin.murphy@arm.com, linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/9] rust: device: implement Bound device context
Message-ID: <D96BDR2E04KF.1CSIS0TVB0YI6@proton.me>
In-Reply-To: <Z_zp-AvQ6FMv0ZRK@pollux>
References: <20250413173758.12068-1-dakr@kernel.org> <20250413173758.12068-7-dakr@kernel.org> <D96AXNJRUAA0.3E5KYNM5PZZPG@proton.me> <Z_zp-AvQ6FMv0ZRK@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 14a5d6a4b0252adb2c75c6db8f812e331aacf4c9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Apr 14, 2025 at 12:56 PM CEST, Danilo Krummrich wrote:
> On Mon, Apr 14, 2025 at 10:49:49AM +0000, Benno Lossin wrote:
>> On Sun Apr 13, 2025 at 7:37 PM CEST, Danilo Krummrich wrote:
>> > The Bound device context indicates that a device is bound to a driver.
>> > It must be used for APIs that require the device to be bound, such as
>> > Devres or dma::CoherentAllocation.
>> >
>> > Implement Bound and add the corresponding Deref hierarchy, as well as =
the
>> > corresponding ARef conversion for this device context.
>> >
>> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>> > ---
>> >  rust/kernel/device.rs | 16 +++++++++++++++-
>> >  1 file changed, 15 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
>> > index 487211842f77..585a3fcfeea3 100644
>> > --- a/rust/kernel/device.rs
>> > +++ b/rust/kernel/device.rs
>> > @@ -232,13 +232,19 @@ pub trait DeviceContext: private::Sealed {}
>> >  /// any of the bus callbacks, such as `probe()`.
>> >  pub struct Core;
>> > =20
>> > +/// The [`Bound`] context is the context of a bus specific device ref=
erence when it is guranteed to
>> > +/// be bound for the duration of its lifetime.
>> > +pub struct Bound;
>>=20
>> One question about this: is it possible for me to
>> 1. have access to a `ARef<Device<Bound>>` (or `Core`) via some callback,
>> 2. store a clone of the `ARef` in some datastructure,
>> 3. wait for the device to become unbound,
>> 4. use a `Bound`-only context function and blow something up?
>
> You can never get an ARef<Device> that has a different device context tha=
n
> Normal.
>
> A device must only ever implement AlwaysRefCounted for Device (i.e.
> Device<Normal>).

Ah yes, I thought there was something there, that's perfect. Might also
be a good idea to write this down before it becomes tribal knowledge :)

---
Cheers,
Benno


