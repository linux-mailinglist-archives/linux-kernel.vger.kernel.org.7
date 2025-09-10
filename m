Return-Path: <linux-kernel+bounces-810458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DE6B51AEA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520E618964C0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784D2327A0C;
	Wed, 10 Sep 2025 14:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHoyjENO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EFA2BE7BB;
	Wed, 10 Sep 2025 14:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757516357; cv=none; b=WOhJWMayoWzo/8+gxpeGalPODNmCZMt/ed1MVhS+Z1qG76W0FV4N5ZPt6RA0S6nuVoRbiBeSYrvd7olIFYha3Pbtfr1Bein1VleZ+Bx8tDzBJT17hs9JD7oTsuupzJ4v8lKFJagdcGXEvQ4Z+blDgyRwi8ZNW+oHNK61CaPj4wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757516357; c=relaxed/simple;
	bh=2LDzN10cx2BWaLcJ9AwxZ1ehZQX1L6fRUnHukaEuBu8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Hj1f/6vRg17CKL9dlEgQo9TnX5uZ7xDzvoZdh5N82enwYk57OAeDNwThAwCh3Uu8iui+IwlPuy+Zo+JLWdrkztz+UgSFNUfBJvhTTPEzYg/ml2szdtNydCaCdu4S1r5uG0QfY03170fRPZFOWqOI0QId+gf5fjkzKoG5jvaxvjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHoyjENO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C7FC4CEEB;
	Wed, 10 Sep 2025 14:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757516356;
	bh=2LDzN10cx2BWaLcJ9AwxZ1ehZQX1L6fRUnHukaEuBu8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=UHoyjENOYMi9OFRn+rZaKrMuC9pHJBeDUNRfINtgH3rRdfEJIdmet1QWMKog90ez+
	 MNSC5jjynUe/VYqqFYwSPmvHgvtQjRq6aeCvvI3Dxn/FSiCOONiz7+N4ZsmyDH3WcK
	 fLm0c3sbq7c5K5ohGQSanhjPPc0z7SCflPs+QIdwr57b1Cf+SJHQA5wVxaxNWq6f8J
	 183sNs0E9+fwQCZKyoPOYe0wu6vd9mFilqcVQS8Yh4MCkWLdbus8ezJiNiaBWBMQZ1
	 vciF+tk7tgRsZgMSotrPr4jcPzK1JVbDCTo0XEZ8iLKOfE/uk3S2wggAnS/hs2s5w4
	 nrr9EcsPzA+XQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Sep 2025 16:59:11 +0200
Message-Id: <DCP7JTWPA4QS.9PTE12UVZFDC@kernel.org>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Fiona Behrens" <me@kloenk.dev>, "Alban Kurti" <kurti@invicto.ai>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rust: pin-init: add `#[bind]` attribute to access
 previously initialized fields
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250910100755.2361281-1-lossin@kernel.org>
 <aMFQL-Hq1KvBG5lh@google.com> <DCP1Y8N4SRRF.25V7F6PV5ODCQ@kernel.org>
 <CAH5fLgg+-oz_cP9=ke+ukp9qYZAsD=hKqvvGfkJWRcCKdrTQ-g@mail.gmail.com>
 <DCP456FHT625.1L5BVZ4LPD8VQ@kernel.org> <aMGE64_J5R8U_rk5@tardis-2.local>
In-Reply-To: <aMGE64_J5R8U_rk5@tardis-2.local>

On Wed Sep 10, 2025 at 4:02 PM CEST, Boqun Feng wrote:
> On Wed, Sep 10, 2025 at 02:19:00PM +0200, Benno Lossin wrote:
>> On Wed Sep 10, 2025 at 12:40 PM CEST, Alice Ryhl wrote:
>> > On Wed, Sep 10, 2025 at 12:36=E2=80=AFPM Benno Lossin <lossin@kernel.o=
rg> wrote:
>> >>
>> >> On Wed Sep 10, 2025 at 12:17 PM CEST, Alice Ryhl wrote:
>> >> > On Wed, Sep 10, 2025 at 12:07:53PM +0200, Benno Lossin wrote:
>> >> >> Assigning a field a value in an initializer macro can be marked wi=
th the
>> >> >> `#[bind]` attribute. Doing so creates a `let` binding with the sam=
e
>> >> >> name. This `let` binding has the type `Pin<&mut T>` if the field i=
s
>> >> >> structurally pinned or `&mut T` otherwise (where `T` is the type o=
f the
>> >> >> field).
>> >> >>
>> >> >> Signed-off-by: Benno Lossin <lossin@kernel.org>
>> >> >
>> >> > Is there a reason we can't apply this to all fields and avoid the
>> >> > attribute?
>> >>
>> >> Adding the attribute was due to Boqun's concern on v1 [1]. I think it
>> >> might be surprising too, but I'm also happy with no attribute.
>> >>
>> >> [1]: https://lore.kernel.org/all/aLshd0_C-1rh3FAg@tardis-2.local
>> >
>> > IMO the ideal is if it works without an attribute. Perhaps trying that
>> > in the kernel is a reasonable experiment to find out whether that's
>> > reasonable to do for the general language feature?
>>=20
>> @Boqun what is your opinion on this?
>>=20
>
> If we plan to make the in-place initializer language feature behave
> similar, as I asked here [1], then dropping `#[bind]` seems good to me.

I don't think we can promise how that language feature is going to look
like. It will definitely support accessing already initialized fields,
but in what form remains to be seen.

---
Cheers,
Benno

> [1]: https://lore.kernel.org/rust-for-linux/aLshd0_C-1rh3FAg@tardis-2.loc=
al/
>
> Thanks!
>
> Regards,
> Boqun
>
>> I'm open to take v2 or v1, whatever you guys prefer.
>>=20
>> ---
>> Cheers,
>> Benno


