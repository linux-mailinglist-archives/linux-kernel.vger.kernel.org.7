Return-Path: <linux-kernel+bounces-801139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A80B4404A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDEF87BEEC9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24E72D0C98;
	Thu,  4 Sep 2025 15:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="htwuitqH"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FE8264F85;
	Thu,  4 Sep 2025 15:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998996; cv=pass; b=Wncr8Rpw+1JBC9W/GlnI/GE3kekCCjr7zlIdqZ1CejV0Gvo2jhTVYdPy5scDFdsxHHXrCxGdmaeYtulfLI+7EPEQ9edVavsUguUnEyYhFiNFqK48ku0xJPY0a7WiREXET1dss93O7C6rpOrlZPjcNMH/bpVNrw9jXIiFlrwRxX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998996; c=relaxed/simple;
	bh=IDWyLVzecAEfVD400butClxhszlQia4W90O4OX+Q7fc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=s9oY+N8j0JademDdm93n8jMNiJe15/af906DrIVk2Z1GQ/B822Mt66JYxWfKXULj2aMSe68KeW5lb+cll+vMh6Bcxn25GoLxMY/YDjOqlbi6UkxGfqd7aJ/Ma/GiyvrinTUljfurDaIszzZnqk2QuVUBk8YoWEjAm+hJmfD9XjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=htwuitqH; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756998962; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gBqLL5q3yLt9fLimxiEJFgOeTcafEBg721TEAIBeEAQWdJVcxleHHIVAvwURkYYS8Zc1WeNPn5mN3OLLWPn68+FS3GZFMQM9/GIpYQWxj46c4mKp1mLvhp4ojhsPM4lASBIwW3qe8QEo2tJbizhSmygtVy0z7Cm7Sa/ZDk/xbSc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756998962; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+8kLEzOcFQCu6rX0G1Q4op3WkweRqgBGuaJYySKuIus=; 
	b=C9Mz3vlBXxqN07qVHyNN2CKTWXhyZoOqITPue85u+OAVS06hvrFk24M+NF1MyiVRbnxvsC6DuxgvbOF/XvflZ8YntVz1b6x5EnQAXlD9/47nwJvF6zdKNpcn2VI/+YMvcRNiPEcGM4vtHSQNs9NdlLcSfaVTbAN2u0duhUcOz0I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756998962;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=+8kLEzOcFQCu6rX0G1Q4op3WkweRqgBGuaJYySKuIus=;
	b=htwuitqHKgRocLnSjZRHD6gcp8XjjkHBxYZRBZpbqZyc22UitnFytOBTR05ouda8
	T4BpK+JI+lrtLqrT79Ybf8jSI5cVuJq/28MqWuulYeVPEMwfbdTxfFB4XkZ3p+nZsRu
	YcHafLCQAh5N5rUSRF65UdznVWHnJzydhDvF1YIE=
Received: by mx.zohomail.com with SMTPS id 1756998960392971.3692629958074;
	Thu, 4 Sep 2025 08:16:00 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2 3/3] rust: lock: add a Pin<&mut T> accessor
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <DCK43W485VCY.3KE72NNMDP32D@kernel.org>
Date: Thu, 4 Sep 2025 12:15:43 -0300
Cc: Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Waiman Long <longman@redhat.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BD4724FF-4AB7-4551-B71C-C22E6E709F19@collabora.com>
References: <20250828-lock-t-when-t-is-pinned-v2-0-b067c4b93fd6@collabora.com>
 <20250828-lock-t-when-t-is-pinned-v2-3-b067c4b93fd6@collabora.com>
 <DCK43W485VCY.3KE72NNMDP32D@kernel.org>
To: Benno Lossin <lossin@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 4 Sep 2025, at 12:13, Benno Lossin <lossin@kernel.org> wrote:
>=20
> On Thu Aug 28, 2025 at 10:52 PM CEST, Daniel Almeida wrote:
>> In order for callers to be able to access the inner T safely if T: =
!Unpin,
>> there needs to be a way to get a Pin<&mut T>. Add this accessor and a
>> corresponding example to tell users how it works.
>>=20
>> This is not useful on its own for now, because we do not support pin
>> projections yet. This means that the following is not going to =
compile:
>>=20
>>    let mut data: MutexGuard<'_, Data> =3D mutex.lock();
>>    let mut data: Pin<&mut Data> =3D data.as_mut();
>>    let foo =3D &mut data.foo;
>>=20
>> A future patch can enable the behavior above by implementing support =
for
>> pin projections. Said patch is in the works already and will possibly
>> land on 6.18.
>>=20
>> Link: https://github.com/Rust-for-Linux/linux/issues/1181
>> Suggested-by: Benno Lossin <lossin@kernel.org>
>> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
>=20
> Reviewed-by: Benno Lossin <lossin@kernel.org>
>=20
>> ---
>> rust/kernel/sync/lock.rs | 25 +++++++++++++++++++++++++
>> 1 file changed, 25 insertions(+)
>>=20
>> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
>> index =
9242790d15dbf65d66518d060a8a777aac558cfc..7191804a244da05db74294fdec598f1a=
4732682c 100644
>> --- a/rust/kernel/sync/lock.rs
>> +++ b/rust/kernel/sync/lock.rs
>> @@ -245,6 +245,31 @@ pub(crate) fn do_unlocked<U>(&mut self, cb: impl =
FnOnce() -> U) -> U {
>>=20
>>         cb()
>>     }
>> +
>> +    /// Returns a pinned mutable reference to the protected data.
>> +    ///
>> +    /// The guard implements [`DerefMut`] when `T: Unpin`, so for =
[`Unpin`]
>> +    /// types [`DerefMut`] should be used instead of this function.
>> +    ///
>> +    /// [`DerefMut`]: core::ops::DerefMut
>> +    /// [`Unpin`]: core::marker::Unpin
>> +    ///
>> +    /// # Examples
>> +    ///
>> +    /// ```
>> +    /// # use kernel::sync::{Mutex, MutexGuard};
>> +    /// # use core::pin::Pin;
>> +    /// struct Data;
>> +    ///
>> +    /// fn example(mutex: &Mutex<Data>) {
>> +    ///   let mut data: MutexGuard<'_, Data> =3D mutex.lock();
>> +    ///   let mut data: Pin<&mut Data> =3D data.as_mut();
>> +    ///  }
>=20
> The formatting looks off in this one, there should be 4 spaces of
> indentation here; there are also 2 spaces in front of the `}`.
>=20
> Also `Data` implements `Unpin`, so you're not following your own
> recommendation from above :)

I=E2=80=99ll fix this :)

=E2=80=94 Daniel

>=20
> ---
> Cheers,
> Benno
>=20
>> +    /// ```
>> +    pub fn as_mut(&mut self) -> Pin<&mut T> {
>> +        // SAFETY: `self.lock.data` is structurally pinned.
>> +        unsafe { Pin::new_unchecked(&mut *self.lock.data.get()) }
>> +    }
>> }
>>=20
>> impl<T: ?Sized, B: Backend> core::ops::Deref for Guard<'_, T, B> {



