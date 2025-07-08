Return-Path: <linux-kernel+bounces-721835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5E8AFCE6E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7F83189D3FE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65162E0931;
	Tue,  8 Jul 2025 15:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABGeFg8I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068FA223DE7;
	Tue,  8 Jul 2025 15:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986809; cv=none; b=f0Z8ZO6nj4KnQYpuPl7PlpwMNfzX/kwZNd6ik4M+dBNHYyDxdmjUM+A/yL6wCrI8qOWmc9U/KuosUlkG9cMcIOnhHgBUOXVHx4ZVNcRpkPMJTp/JZ8EvEru+usEzdQto8fRXpmCj+FFY93VRcIuhpwMX7aLicaasRobdZqe9rHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986809; c=relaxed/simple;
	bh=8zhdXKTkB9Q4veJXhlqQ8WPtuFRRjdAu8mZrNb0FZIM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hCOTakkvcZLjl3/gepX3W8GFzLoDxUHnUj0xZxPDg2HrlA6qP+v8oEIUwoDNYZ8hk97kQTMP+jsS8GCQAvqIJGDuDslN3kl19gHLSG70xQ8p5NsDQJpPYO4IpkDBiQpnzBCLTbBfbHkwP5RzWtOHG6N3mhdAes7qd6AtzyiGhDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABGeFg8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5426FC4CEEF;
	Tue,  8 Jul 2025 15:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751986808;
	bh=8zhdXKTkB9Q4veJXhlqQ8WPtuFRRjdAu8mZrNb0FZIM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ABGeFg8IZcrpiwF2E5/VAvkRG+wMvkvFc2Ddba5FN/gXW/iwOBuVdp6OTkqN3dwjO
	 uWSDMs9o0RbluEucdgQi/Qg334hI4dOlr/+eey3nPQIUywQ6Vohzx+oq1rxszOMGNx
	 Tn3aQJKZgoy4dR8u8wF5I496GfCTu/vDtiV+FO67BgKVOLhAV3+OCqb4PecIQg3wEJ
	 S8+ZIqWxLo1ycJ6NveVnpztGPoihkyS3QRPYpxXaUwLhjUYpj7vgSuZBxi1uAEkAVo
	 UpK3bLYur6v0I/qfPkVlZsxRNSyg32bvDeg2vZrLJLiGQldfK2aeW5xHv13HuX+n2+
	 ECB60jByno6Zw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 17:00:03 +0200
Message-Id: <DB6RHMJJ5I4F.3LB85KT35FO5C@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Asahi Lina" <lina+kernel@asahilina.net>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 1/4] rust: types: Add Ownable/Owned types
From: "Benno Lossin" <lossin@kernel.org>
To: "Oliver Mangold" <oliver.mangold@pm.me>
X-Mailer: aerc 0.20.1
References: <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me>
 <20250618-unique-ref-v11-1-49eadcdc0aa6@pm.me>
 <DB1IPFNLFDWV.2V5O73DOB2RV6@kernel.org> <aGtv9qs682gTyQWX@mango>
 <DB5PPGOWNW4K.2C5A4UE9V9IEF@kernel.org> <aGzrZqIrStGD_UBp@mango>
In-Reply-To: <aGzrZqIrStGD_UBp@mango>

On Tue Jul 8, 2025 at 11:56 AM CEST, Oliver Mangold wrote:
> On 250707 1123, Benno Lossin wrote:
>> On Mon Jul 7, 2025 at 8:58 AM CEST, Oliver Mangold wrote:
>> > On 250702 1303, Benno Lossin wrote:
>> >> On Wed Jun 18, 2025 at 2:27 PM CEST, Oliver Mangold wrote:
>> >> > +///
>> >> > +/// # Invariants
>> >> > +///
>> >> > +/// The pointer stored in `ptr` can be considered owned by the [`O=
wned`] instance.
>> >>
>> >> What exactly is "owned" supposed to mean? It depends on the concrete =
`T`
>> >> and that isn't well-defined (since it's a generic)...
>> >
>> > "owned" means that access to the `T` is exclusive through the `Owned<T=
>`,
>> > so normal Rust semantics can be applied.
>>=20
>> Okay, in that case just say that `ptr` has exclusive access.
>
> Or, ehm, sorry, I forgot, ownership also implies that the allocation of t=
he
> underlying resource/object is now under the responsibility of the owner,
> i.e. the owner should free it at the appropriate time.
>
> In short, just the standard meaning of ownership in Rust.
>
> https://doc.rust-lang.org/book/ch04-01-what-is-ownership.html

Okay that's good to hear. I think what tripped me up the most was the
"can be considered" wording. Let's just say:

    /// # Invariants
    ///
    /// - `ptr` is valid,
    /// - `*ptr` is owned by `self`,
    /// - `ptr` is an "owning pointer" according to the [`Ownable`] impleme=
ntation for `T`.

And then on `Ownable` we add:

    /// # Invariants
    ///
    /// An implementer of this trait needs to define which pointers can be =
supplied to
    /// [`Self::release`]. These pointers are called "owning pointers".

This should be as general as possible and still give us exactly the
guarantees that we need to implement `Owned`.

`Owned::from_raw` can then require that the pointer is an owning
pointer (& it's valid) and that the caller yields ownership to
`from_raw`.

---
Cheers,
Benno

