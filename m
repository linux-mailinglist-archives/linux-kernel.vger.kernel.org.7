Return-Path: <linux-kernel+bounces-841842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DEABB8607
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 01:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBEED19C0567
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 23:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFF0275864;
	Fri,  3 Oct 2025 23:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfpHNS1y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA7F35962;
	Fri,  3 Oct 2025 23:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759533972; cv=none; b=LBsyuSsf8aG+rekBvZ+N6K7yxX/LajUSyCi0UclQK9PuIpudacH79yZCeb9r1kssQF7prXBkR5Sci2aV4aQU0Z4X/N+OiYruXN3JbZgLQRW1RIK2QkxAeJZMgqmhW3yQcgmF6DMM1t96Herw4O054IToPmKZT7mkva1hJBvWYt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759533972; c=relaxed/simple;
	bh=gDIEjpiMrPLbEbZ8juu60qbu02+GBX90gGM6pJSF1ZY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=LoNov0gXpL6Edc7zOWT2qnm+5Au9oRIFdlxPLEI+kIX+wNEDSRCWM6btNlNkHwwniWKbtxX5yBE+JH71PnvapYFeIMYe/AS9mlWuejcNxiCqToHd1JELminXbujY4wDDVS1yTaisB0qUWRFOBaNPsxzpkSDhgBTjOpVnJoDuclM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfpHNS1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5574C4CEF5;
	Fri,  3 Oct 2025 23:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759533972;
	bh=gDIEjpiMrPLbEbZ8juu60qbu02+GBX90gGM6pJSF1ZY=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=QfpHNS1yXq1WfgzZoJFUw4QZTHhvIUILRDrFQO9H68EeyVWG+0JQhj9UoE2DndC9C
	 eQu+LEjaGsU/3traJdkHTBEzgj6g2idUSDR4uPpHyXUe58AAbALKg9Bpm/d/OFGpS9
	 ssEgyjZNu5I7E4CNuA0/Mq3xltXxAkSnoNkvSnN1gJRLnBf45YeA/Tc67HrZEEp3i8
	 RGttNwhjXcpxBJLeBBH/rezRDwkuqs5GUyzSBVhwU1QL99g1zx3q3YVFkqQaUJHPMA
	 I3VoU8LJdv8BIKomtomc/BK047MORXNj0xbxH1HNTXbw0OdY4fLBm0Cbhi2cXAUgWt
	 ZrA3uJ33kf1TA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 Oct 2025 01:26:07 +0200
Message-Id: <DD92QHU14T9S.14AE7Z1UWJ6ZT@kernel.org>
To: "Matthew Maurer" <mmaurer@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 4/7] rust: debugfs: support blobs from smart pointers
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20251003222729.322059-1-dakr@kernel.org>
 <20251003222729.322059-5-dakr@kernel.org>
 <CAGSQo02ASwf3Wn21jgB804LMLi3qivhtZuo7SmmD9O4m5O_Qfw@mail.gmail.com>
In-Reply-To: <CAGSQo02ASwf3Wn21jgB804LMLi3qivhtZuo7SmmD9O4m5O_Qfw@mail.gmail.com>

On Sat Oct 4, 2025 at 1:12 AM CEST, Matthew Maurer wrote:
> On Fri, Oct 3, 2025 at 3:27=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>> +// Base implementation for any `T: AsBytes`.
>>  impl<T: AsBytes> BinaryWriter for T {
>>      fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: usiz=
e) -> Result<usize> {
>>          writer.write_slice_partial(self.as_bytes(), offset)
>>      }
>>  }
>>
>> +// Delegate for `Mutex<T>`: Support a `T` with an outer mutex.
>>  impl<T: BinaryWriter> BinaryWriter for Mutex<T> {
>>      fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: usiz=
e) -> Result<usize> {
>>          let guard =3D self.lock();
>> @@ -64,6 +69,56 @@ fn write_to_slice(&self, writer: &mut UserSliceWriter=
, offset: usize) -> Result<
>>      }
>>  }
>>
>> +// Delegate for `Box<T, A>`: Support a `Box<T, A>` with no lock or an i=
nner lock.
>> +impl<T, A> BinaryWriter for Box<T, A>
>> +where
>> +    T: BinaryWriter,
>> +    A: Allocator,
>> +{
>> +    fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: usiz=
e) -> Result<usize> {
>> +        self.deref().write_to_slice(writer, offset)
>> +    }
>> +}
>> +
>> +// Delegate for `Pin<Box<T, A>>`: Support a `Pin<Box<T, A>>` with no lo=
ck or an inner lock.
>> +impl<T, A> BinaryWriter for Pin<Box<T, A>>
>> +where
>> +    T: BinaryWriter,
>> +    A: Allocator,
>> +{
>> +    fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: usiz=
e) -> Result<usize> {
>> +        self.deref().write_to_slice(writer, offset)
>> +    }
>> +}
>> +
>> +// Delegate for `Arc<T>`: Support a `Arc<T>` with no lock or an inner l=
ock.
>> +impl<T> BinaryWriter for Arc<T>
>> +where
>> +    T: BinaryWriter,
>> +{
>> +    fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: usiz=
e) -> Result<usize> {
>> +        self.deref().write_to_slice(writer, offset)
>> +    }
>> +}
>
> For `Box`, `Pin<Box<`, and `Arc`, where the only operation being
> performed is to deref, is there a reason that we couldn't have the
> `File` object be *inside* the object, thus avoiding any need for
> these? I can't see them causing trouble, but
>
> ```
> Box<File<T>>
> Pin<Box<File<T>>>
> Arc<File<T>>
> ```
>
> seem like they'd usually be fine. The one caveat I can think of is
> that if you had other functions that wanted to take an `&Arc<T>` for
> operations on the Arc, then having an `Arc<File<T>>` would be
> suboptimal. Am I missing something?

I think this way around is not compatible with scoped API.

Besides that, there is a semantical difference between File<Arc<T>> and
Arc<File<T>>, i.e. the file itself would become reference counted.

> Depending on the use case I'm missing, would a blanket implementation
> for `T: Deref` in this case and `DerefMut` later on make more sense?
> That should contract these into a single definition and generalize to
> e.g. `ListArc` without further code.

It was also my first thought to generalize over T: Deref, but unfortunately=
 this
does lead to conflicting implementations of BinaryWriter.

>> +// Delegate for `Vec<T, A>`: Support a `Vec<T, A>` with an outer lock.
>> +impl<T, A> BinaryReaderMut for Vec<T, A>
>> +where
>> +    T: AsBytes + FromBytes,
>> +    A: Allocator,
>> +{
>> +    fn read_from_slice_mut(
>> +        &mut self,
>> +        reader: &mut UserSliceReader,
>> +        offset: usize,
>> +    ) -> Result<usize> {
>> +        let slice =3D self.as_mut_slice();
>> +
>
> Nit: This is safe, but it also requires `FromBytes`, and is &mut, &mut

It already requires T: AsBytes + FromBytes above. Or do you mean something =
else?

