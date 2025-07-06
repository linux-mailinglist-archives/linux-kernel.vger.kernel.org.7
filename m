Return-Path: <linux-kernel+bounces-712071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A360AF0442
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 22:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C42174437
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 20:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622D6276026;
	Tue,  1 Jul 2025 20:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwkHiNjQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD45220F23;
	Tue,  1 Jul 2025 20:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751400194; cv=none; b=mrPepE+EOO8CjFXLBeWsJ+QM0wzaHFbTIYRyjovcpCRY1VoHcNDikJCupehoaRe0gko/AJ+sQYv3PxeEN82GQWlZmI3o1Yn8+X53hSjmt1hA5nVKYl2WMEb0kvMIkvpD5ewojCO/InprGvfNbV3/MsYuwPPMutsxwoY/U3CraAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751400194; c=relaxed/simple;
	bh=zLG8hsviQknEuvu3ax9pjjgXHOaZgAcLL9QurUfylIs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=KJ5zn3GrLrh349nlNCUqcNRnoksL48be3d0ODvgqsPMQtuFmb5NgsKUUhyLrtX+3C5vk4twiL0brQetLEAdwmeX7wSQvBQZ5MKbxym2BvPEZ/fAo9xWl6X02TTIIhryn5U364YTTgM5Sah+j8p/RzAoAqEYANhyAoftTZXcEtIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwkHiNjQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063AAC4CEEB;
	Tue,  1 Jul 2025 20:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751400194;
	bh=zLG8hsviQknEuvu3ax9pjjgXHOaZgAcLL9QurUfylIs=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=fwkHiNjQaNu1n7D7py4s8pl2Y0/X/lIQidjR5+/5DiCD2dZuSrr5UbBn0yx35v9Lg
	 WjoWLbjgwoPwQnx1cCv5+AQrYIjvfXNDDKW23uoWwFfgorE82U5uUVIIVSCErSjUoC
	 FaZwuT7RY4UOHzS9wDI3yT/lP6ygmtpyHGgvdoBYCRrOmEN5rg0S3w2kp++ttGl3GE
	 PHdYiqw3yW9Wp0uPoBsktuXwREXLdt96eEcMdgVJS+Mw4YrGHFR20JzeY8cWAcWqOt
	 f+eKoAVfn5HSmh99uR51hQ0MTTVQhD6mmsWaKS/V7XJ+ptwzs34nfiTc/VrP1w8O3m
	 7NlCKzNpAM/+g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Jul 2025 22:03:09 +0200
Message-Id: <DB0ZJVL0682F.ZNNOXEIDL5NN@kernel.org>
Subject: Re: [PATCH v8 4/6] rust: debugfs: Support arbitrary owned backing
 for File
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Matthew Maurer" <mmaurer@google.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Sami Tolvanen"
 <samitolvanen@google.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Dirk
 Behme" <dirk.behme@de.bosch.com>
X-Mailer: aerc 0.20.1
References: <5c3a2289-01c5-413e-9d7c-88a41c3f54e2@kernel.org>
 <CAGSQo038u_so+_pMRYj0K546zNfO5-eqoXFivXsEF6ACK=Y5cw@mail.gmail.com>
 <ce8f428b-fcb0-48dc-b13e-6717c9a851b4@kernel.org>
 <CAGSQo02hyJncD1oTpUMgiSZeX5UYYY2p-WZTyroQJJ6fMnOrCQ@mail.gmail.com>
 <aGLUl7ZtuQBPoCuv@pollux> <2025070131-icon-quarters-0c16@gregkh>
 <aGPtCBB6nWTNJuwK@pollux> <2025070137-tartar-juncture-fcd2@gregkh>
 <aGP6d2-jJy5rtjMK@pollux>
 <CAGSQo00eG5oRdN_xORLUyUauLi_vzypU-gz6DSU_FzaAbHRLng@mail.gmail.com>
 <aGQ1VsnFaxBo9zaM@pollux> <DB0Z71SF488V.3QURUHHELOY84@kernel.org>
 <3c928a0e-ccd4-4ba0-9f42-9f2bb0203e75@kernel.org>
In-Reply-To: <3c928a0e-ccd4-4ba0-9f42-9f2bb0203e75@kernel.org>

On Tue Jul 1, 2025 at 9:58 PM CEST, Danilo Krummrich wrote:
> On 7/1/25 9:46 PM, Benno Lossin wrote:
>> On Tue Jul 1, 2025 at 9:21 PM CEST, Danilo Krummrich wrote:
>>> On Tue, Jul 01, 2025 at 11:11:13AM -0700, Matthew Maurer wrote:
>>>> On Tue, Jul 1, 2025 at 8:10=E2=80=AFAM Danilo Krummrich <dakr@kernel.o=
rg> wrote:
>>>>>          impl Firmware {
>>>>>             pub fn new(&dir: debugfs::Dir, buffer: [u8]) -> impl PinI=
nit<Self> {
>>>>>                pin_init!(Self {
>>>>>                   minor <- dir.create_file("minor", 1),
>>>>>                   major <- dir.create_file("major", 2),
>>>>>                   buffer <- dir.create_file("buffer", buffer),
>>>>>                })
>>>>>             }
>>>>>          }
>>>>>
>>>>>          // This is the only allocation we need.
>>>>>          let fw =3D KBox::pin_init(Firmware::new(...), GFP_KERNEL)?;
>>>>>
>>>>> With this everything is now in a single allocation and since we're us=
ing
>>>>> pin-init, Dir::create_file() can safely store pointers of the corresp=
onding data
>>>>> in debugfs_create_file(), since this structure is guaranteed to be pi=
nned in
>>>>> memory.
>>>>>
>>>>> Actually, we can also implement *only this*, since with this my previ=
ous example
>>>>> would just become this:
>>>>
>>>> If we implement *only* pinned files, we run into an additional problem
>>>> - you can't easily extend a pinned vector. This means that you cannot
>>>> have dynamically created devices unless you're willing to put every
>>>> new `File` into its own `Box`, because you aren't allowed to move any
>>>> of the previously allocated `File`s for a resize.
>>>>
>>>> Where previously you would have had
>>>>
>>>> ```
>>>> debug_files: Vec<File>
>>>> ```
>>>>
>>>> you would now have
>>>>
>>>> ```
>>>> debug_files: Vec<PinBox<File<T>>>
>>>> ```
>>>
>>> Stuffing single File instances into a Vec seems like the wrong thing to=
 do.
>>>
>>> Instead you may have instances of some data structure that is created
>>> dynamically in your driver that you want to expose through debugfs.
>>>
>>> Let's say you have (userspace) clients that can be registered arbitrari=
ly, then
>>> you want a Vec<Client>, which contains the client instances. In order t=
o provide
>>> information about the Client in debugfs you then have the client embed =
things as
>>> discussed above.
>>>
>>> 	struct Client {
>>> 	   id: File<ClientId>,
>>> 	   data: File<ClientData>,
>>> 	   ...
>>> 	}
>>>
>>> I think that makes much more sense than keeping a Vec<Arc<Client>> *and=
* a
>>> Vec<File> separately. Also, note that with the above, your Client insta=
nces
>>> don't need to be reference counted anymore.
>>>
>>> I think this addresses the concerns below.
>>=20
>> You still have the issue that `Client` now needs to be pinned and the
>> vector can't be resized. But if you know that it's bounded, then we
>> could just make `Pin<Vec<T>>` work as expected (not relocating the
>> underlying allocation by not exposing `push`, only
>> `push_within_capacity`).
>>=20
>> We also could have a `SegmentedVec<T>` that doesn't move elements.
>> Essentially it is
>>     =20
>>      enum SegmentedVec<T> {
>>          Cons(Segment<T>, KBox<SegmentedVec<T>>)
>>          Nul,
>>      }
>>=20
>>      struct Segment<T> {
>>          elements: [T; 16]
>>      }
>>=20
>> or make the segments variable-sized and grow them accordingly.
>
> That sounds a lot like the perfect application for XArray. :)

Haha I didn't know this already existed in the kernel :) Yeah then we
should make XArray work for this use-case.

---
Cheers,
Benno

