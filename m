Return-Path: <linux-kernel+bounces-808926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E92FB5069A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22B6316DCEB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B288340D9D;
	Tue,  9 Sep 2025 19:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="UQG/ebZv"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB18F302CD0;
	Tue,  9 Sep 2025 19:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757447466; cv=pass; b=r2E1I/ez87zvz3M2wWZfw42P1BRAYPXv/GzJsBH14B6PfvgRP+ct04d/CLJImZinSzWHzeYtBULRsecYJoOpbsF8omoruM6tk9R1gGwCHkxfplJ1gyc/gXHRKrUHbjQSQdf2jEwyCvtV0tGEXo1VJu68yqqGx3b5O4GIvm4Ebls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757447466; c=relaxed/simple;
	bh=CgaI1ryl2lJRZTbc5uvxKQsL94BLJ/VJBanvuIHtCcs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=u6AMbqp5bLizO0YJZWnKMkxyMXg2V8pB/MvxGMXycf1MWVFTAKebOOQEKWtaHFpC1yijgnts501eFBannl4kD9Zoc/ZwhvMqX3qhqrXTPGWTzDRWSnG6SBpIPnhi5++yZrf5VxNaBZ23hPTc/BKhZS19UfqOR99Nj+lG+4S8UKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=UQG/ebZv; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757447438; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mdXUVHaTT6B+QCx6ISABg9nUfKZdsF9aINIGyxEJTvwqOo+5K1ffYLUmvaQaowxSd3TkIMDxgTLqvjeYHW2h3IwqBzUeAqGAz8G0MGMMWtS46qlfxMSuFXQIFZIz7rvBwIRuzbC9V2UmT8fG+8UfJryj0799vMGXmIZcUt5ZoiQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757447438; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=X4kc+sqIlqwrRZbkovqf9uhYtz6iUvsGomVE2OHyz+c=; 
	b=N8Sai4QeeZiP013Tt6PHIYLVwbFuR3ROZwlSp+cAZ2nozt6Ayt2KjLZP7pEwJ+vGPVk+TaHG/RLLxm5cquC3Mv2j0AHEEHFCloNNAEChQvfAxo6Ep570rfSVROmLoPDraJvpkqm8jAzN3iBGSGIgZvmn7uulSLUZP1isShbyl0c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757447438;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=X4kc+sqIlqwrRZbkovqf9uhYtz6iUvsGomVE2OHyz+c=;
	b=UQG/ebZvJr1AwVLprrByb3U8QkfhR1XqpH5VztWm8GNPYQA89udX2/gEa2SwFO4b
	tqT0zk+K0gmWQ1F7kUEwpqRI63BgUVevqf9cabiRkIH16oKoDTMBmivHb8XyC4fxdJY
	whZsRORpOoSFhB1JC7XbY3+2Zc0S60OOO/IDtnI4=
Received: by mx.zohomail.com with SMTPS id 1757447437317465.8216735890609;
	Tue, 9 Sep 2025 12:50:37 -0700 (PDT)
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
In-Reply-To: <aL47zBoNpvjYxec5@tardis-2.local>
Date: Tue, 9 Sep 2025 16:50:19 -0300
Cc: Benno Lossin <lossin@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>,
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
Message-Id: <A2534940-B847-40F6-8420-4ABEAE1D9A39@collabora.com>
References: <20250828-lock-t-when-t-is-pinned-v2-0-b067c4b93fd6@collabora.com>
 <20250828-lock-t-when-t-is-pinned-v2-3-b067c4b93fd6@collabora.com>
 <DCK43W485VCY.3KE72NNMDP32D@kernel.org>
 <BD4724FF-4AB7-4551-B71C-C22E6E709F19@collabora.com>
 <aL47zBoNpvjYxec5@tardis-2.local>
To: Boqun Feng <boqun.feng@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Boqun, sorry for the delay,

>>>> +
>>>> +    /// Returns a pinned mutable reference to the protected data.
>>>> +    ///
>>>> +    /// The guard implements [`DerefMut`] when `T: Unpin`, so for =
[`Unpin`]
>>>> +    /// types [`DerefMut`] should be used instead of this =
function.
>>>> +    ///
>>>> +    /// [`DerefMut`]: core::ops::DerefMut
>>>> +    /// [`Unpin`]: core::marker::Unpin
>>>> +    ///
>>>> +    /// # Examples
>>>> +    ///
>>>> +    /// ```
>>>> +    /// # use kernel::sync::{Mutex, MutexGuard};
>>>> +    /// # use core::pin::Pin;
>>>> +    /// struct Data;
>>>> +    ///
>>>> +    /// fn example(mutex: &Mutex<Data>) {
>>>> +    ///   let mut data: MutexGuard<'_, Data> =3D mutex.lock();
>>>> +    ///   let mut data: Pin<&mut Data> =3D data.as_mut();
>>>> +    ///  }
>>>=20
>>> The formatting looks off in this one, there should be 4 spaces of
>>> indentation here; there are also 2 spaces in front of the `}`.
>>>=20
>>> Also `Data` implements `Unpin`, so you're not following your own
>>> recommendation from above :)
>>=20
>> I=C2=B4ll fix this :)
>>=20
>=20
> If the fix is small, feel free to send a diff and I can fold it when
> queueing (i.e. no need to resend the whole series). I'm trying to send
> it to tip before -rc6 so there will be some more tests. Thanks!
>=20
> Regards,
> Boqun
>=20


This should address what Benno pointed out:


diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 7191804a244d..cb00fdb94ffd 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -258,13 +258,13 @@ pub(crate) fn do_unlocked<U>(&mut self, cb: impl =
FnOnce() -> U) -> U {
     ///
     /// ```
     /// # use kernel::sync::{Mutex, MutexGuard};
-    /// # use core::pin::Pin;
-    /// struct Data;
+    /// # use core::{pin::Pin, marker::PhantomPinned};
+    /// struct Data(PhantomPinned);
     ///
     /// fn example(mutex: &Mutex<Data>) {
-    ///   let mut data: MutexGuard<'_, Data> =3D mutex.lock();
-    ///   let mut data: Pin<&mut Data> =3D data.as_mut();
-    ///  }
+    ///     let mut data: MutexGuard<'_, Data> =3D mutex.lock();
+    ///     let mut data: Pin<&mut Data> =3D data.as_mut();
+    /// }
     /// ```
     pub fn as_mut(&mut self) -> Pin<&mut T> {
         // SAFETY: `self.lock.data` is structurally pinned.=

