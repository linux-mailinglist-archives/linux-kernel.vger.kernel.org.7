Return-Path: <linux-kernel+bounces-815493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5D2B5674D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 09:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 956E51A21095
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 07:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E9522333D;
	Sun, 14 Sep 2025 07:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRwlpxRK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E493472610;
	Sun, 14 Sep 2025 07:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757836735; cv=none; b=ILOdqC7oVTC4swSzaGlsXnn+p/Y554Vt0gW41CP3Hmfj6GXshlRkjMx8NJV9+7IQi4q5d4bqmHH4Ju1sWFMvxkKwabf0YsghEGum4c4MmVjWt6ZRQFGrNCEduVpb2PqLMLAZibgiHLPD2h7NFYhuhbRq0H0d5i8P9H6h3JlRK5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757836735; c=relaxed/simple;
	bh=uz1xVp736uSxGyJV2q+yZ0bzLeyruMJpCl0NX2u+YDY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=aKy5qwPyzzHnTu5gOzpMYdq12JKsbt2pGCYXkqtyquIm2xfMkJx3oHxbrY4PR2dkYEsOqJvajERwHHou5pVmhGfuNxJb0gdcNRA6eMNUou78ZBnhHBHolhk7/JLbyl1ZdnfjKUpn34K3e+d4YmhgxEOSa2eordJomHuVOEYNxTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRwlpxRK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F808C4CEF0;
	Sun, 14 Sep 2025 07:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757836734;
	bh=uz1xVp736uSxGyJV2q+yZ0bzLeyruMJpCl0NX2u+YDY=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=iRwlpxRKA0fAf/GCGQ9DQR0XqhKFY6HiWKEQ7dT1YIHzf9F7YYN47NraYtaedlYqD
	 PH6vlJi6AEdcPanTIJNNr/HV40atxuXo7lrNNHwzEMexrd3Y88ofdVZ3yPfnm7sZ14
	 bi6lSmsST+lW3D+ILXydyeZFCO/s3mDKlYv3CDgRpRc2w8D5SaOJpZi7kJZj5mBwuI
	 7ROzGVxdiFD8d3ts3SRuLuGepqqzFxMV4lxkmFB4MfRrnWLW1deLHyaYMnbn8krwIK
	 HMFUjVHt6A7/qHjY0NEZyiIA3ADKGFD0q+m34Fk65rB9tKLwQge3d4szPjp8Ocdxtk
	 RonRZtjFzk0wQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 14 Sep 2025 09:58:44 +0200
Message-Id: <DCSD437J7EES.359ZQ732TXJY@kernel.org>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v5 02/12] gpu: nova-core: move GSP boot code to a
 dedicated method
From: "Benno Lossin" <lossin@kernel.org>
To: "Joel Fernandes" <joelagnelf@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>
X-Mailer: aerc 0.21.0
References: <20250911-nova_firmware-v5-0-5a8a33bddca1@nvidia.com>
 <20250911-nova_firmware-v5-2-5a8a33bddca1@nvidia.com>
 <e1755470-587b-4a43-8171-3d031b7fb4f4@kernel.org>
 <DCPYQNZG1OJK.2EE4JWJAROK57@nvidia.com>
 <ce74db34-77bc-4207-94c8-6e0580189448@kernel.org>
 <DCQ074EMFNIK.1OJLWJXWZLDXZ@nvidia.com> <20250913010226.GA1478480@joelbox2>
 <DCRPJKD0UHDQ.IOWSOB2IK06E@kernel.org> <20250913171357.GA1551194@joelbox2>
 <DCRXOMQN3Z20.2JCNP4BDEE79T@kernel.org> <20250913230254.GA1568515@joelbox2>
In-Reply-To: <20250913230254.GA1568515@joelbox2>

On Sun Sep 14, 2025 at 1:02 AM CEST, Joel Fernandes wrote:
> On Sat, Sep 13, 2025 at 09:53:16PM +0200, Danilo Krummrich wrote:
>> On Sat Sep 13, 2025 at 7:13 PM CEST, Joel Fernandes wrote:
>> > On Sat, Sep 13, 2025 at 03:30:31PM +0200, Danilo Krummrich wrote:
>> >> However, we should never do such things. If there's the necessity to =
do
>> >> something like that, it indicates a design issue.
>> >>=20
>> >> In this case, there's no problem, we can use pin-init without any iss=
ues right
>> >> away, and should do so.
>> >>=20
>> >> pin-init is going to be an essential part of *every* Rust driver give=
n that a
>> >> lot of the C infrastruture that we abstract requires pinned initializ=
ation, such
>> >> as locks and other synchronization primitives.
>> >
>> > To be honest, the pinning concept seems like an after thought for such=
 a
>> > fundamental thing that we need, requiring additional macros, and banda=
ids on
>> > top of the language itself, to make it work for the kernel. I am not a=
lone in
>> > that opinion. This should be first-class in a (systems) language, buil=
t into
>> > the language itself? I am talking about the whole pin initialization,
>> > accessing fields dances, etc.
>>=20
>> Yes, that's exactly why people (Benno) are already working on making thi=
s a
>> language feature (here's a first step in this direction [1]).
>>=20
>> Benno should have more details on this.
>>=20
>> [1] https://github.com/rust-lang/rust/pull/146307

That's the link to the implementation PR, if you know the internals of
the compiler it sure is useful, but if not, only the first comment is :)

> Ack, thanks for the pointer. I will study it further.

I'd recommend looking at these links, as they talk more about the design
& not the compiler implementation:

* https://github.com/rust-lang/rust/issues/145383
* https://hackmd.io/@rust-lang-team/S1I1aEc_lx
* https://rust-lang.github.io/rust-project-goals/2025h2/field-projections.h=
tml

For pin specifically, there also is the pin-ergonomics effort:

* https://github.com/rust-lang/rust/issues/130494

Which is less general than the field projections that I'm working on,
but more specific to pin & tries to make it more compiler internal.

Now for pinned initialization, Alice has a project goal & proposal:

* https://rust-lang.github.io/rust-project-goals/2025h2/in-place-initializa=
tion.html
* https://hackmd.io/%40aliceryhl/BJutRcPblx

This proposal was heavily influenced by pin-init & we're actively
working together with others from the Rust community in getting this to
a language feature.

It's a pretty complicated feature and people just worked around it
before, which you can do when starting from the ground-up (similar to
field projections).

>> > Also I am concerned that overusage of pinning defeats a lot of optimiz=
ations
>>=20
>> pin-init does the oposite it allows us to use a single memory allocation=
 where
>> otherwise you would need multiple.
>>=20
>> Can you please show some optimizations that can not be done in drivers d=
ue to
>> pin-init for dynamic allocations?
>
> Aren't the vector resizing issues an example? The debugfs discussions for
> example. You can't resize pinned vectors without boxing each element whic=
h is
> suboptimal due to requiring additional allocations?

Yes, but that's not really an optimization, is it? In the non-pinned
case, the compiler wouldn't remove the allocation. You can select less
efficient algorithms, since the objects aren't allowed to move, but that
same restriction also applies in C.

---
Cheers,
Benno

