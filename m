Return-Path: <linux-kernel+bounces-769445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 762C7B26EC8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 20:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E36E07B6B6B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5579622333B;
	Thu, 14 Aug 2025 18:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Ocqlxd2O"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B283731984D;
	Thu, 14 Aug 2025 18:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755195831; cv=pass; b=WQaFQFb+5YTr+BIePiwAM57xiz+fGhGkQXxw6+vRprzeUpV2T2W8pHWp5aV8TeyOEU/tDxlrPMKm4o32y+13LQxHlzVInyBwPF7gcfxixH6eJk10MS5gsPSwdQ7kpC+Zj3d5qSOVxHypWl3nes/Ir73hufrYbZvilOi0hzVg/D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755195831; c=relaxed/simple;
	bh=cWrE7F658AJkN3XHv/TWsYx7H7MlB2s+H9UyIbhoWNw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=cUZ8zuIq+TzJ4jaTzE1SxWUkS99A8s+fNH90KTFjxpX2JE122nCV0300gTVZkoSO/KFV8IzfiOG3QDoIUKSl1HPen2S1PsQEhoYKs9C8wjUf3DOy0KFTtwIvWHZCdrLWv+DAljcqT8slFjv5uxeCud0x1Heqv+JuzBalEMP5H90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Ocqlxd2O; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1755195797; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=f2GttAgI0nXf91lwE14wbQoE11hF1oh8ruNvXwTVlO02FBc6fyjV3Ks/HsdkTRWf+oRN7cW5JdLkjDLRDmmUyqrc+rmgSnPdriyVddcOZPjL4Qd7moWVEAGIyudO3OzlyB02nTl/IheDZv6wgZSmFDVhyEOtf625o9Qf4XNqDmw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755195797; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=O6Wo9DBymeqfNkNyv1Ydoh1TJb6CT7lI7fo4TpEycTE=; 
	b=eUL/JtHVYt2ijhxegX5jYuyWtWihSD7IDebQlwQzgaIrBMU1OU48oUxGcStSYXtXWop3z+u7sdf9ftJ7A5ll+alKQQnNy55bYo1XqWuowELIpPGFwyJQQWITNu29BKC+OExAuJ4C7R23iWr9waqlazloJ3dxxnfgDvo4EF0zWUg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755195797;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=O6Wo9DBymeqfNkNyv1Ydoh1TJb6CT7lI7fo4TpEycTE=;
	b=Ocqlxd2OAA42fEdFtDWTfNoRzFt+5Key7BfS+d5g8iDp48eh+gn7qiNLohcmRhJ2
	JWB1myGPsro/g377E70xZLOEJBrd8obVHm4TigQvnU5w5ng1b7813AXMGLVBq3VMAi1
	IJZBrGBM99J5drELNVsVrBEsJdona/pUHGWLVgfw=
Received: by mx.zohomail.com with SMTPS id 1755195796206305.7272068943655;
	Thu, 14 Aug 2025 11:23:16 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v5 0/3] rust: add `ww_mutex` support
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250814185622.468aad30@nimda.home>
Date: Thu, 14 Aug 2025 15:22:57 -0300
Cc: Benno Lossin <lossin@kernel.org>,
 Lyude Paul <lyude@redhat.com>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 boqun.feng@gmail.com,
 gary@garyguo.net,
 a.hindborg@kernel.org,
 aliceryhl@google.com,
 tmgross@umich.edu,
 dakr@kernel.org,
 peterz@infradead.org,
 mingo@redhat.com,
 will@kernel.org,
 longman@redhat.com,
 felipe_life@live.com,
 daniel@sedlak.dev,
 bjorn3_gh@protonmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <182E916F-3B59-4721-B415-81C3CF175DA7@collabora.com>
References: <20250621184454.8354-1-work@onurozkan.dev>
 <20250724165351.509cff53@nimda.home>
 <ec32fc5f5a8658c084f96540bd41f5462fa5c182.camel@gmail.com>
 <20250806085702.5bf600a3@nimda.home>
 <539d3e0da773c32a42b4ab5c9d4aa90383481ff6.camel@redhat.com>
 <DBVLEGFYBWKE.2RW8J853CJHTY@kernel.org> <20250814141302.1eabda12@nimda.home>
 <76D4D052-79B6-4D3F-AAA1-164FF7A41284@collabora.com>
 <20250814185622.468aad30@nimda.home>
To: Onur <work@onurozkan.dev>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External


Hi Onur,

> On 14 Aug 2025, at 12:56, Onur <work@onurozkan.dev> wrote:
>=20
> On Thu, 14 Aug 2025 09:38:38 -0300
> Daniel Almeida <daniel.almeida@collabora.com> wrote:
>=20
>> Hi Onur,
>>=20
>>> On 14 Aug 2025, at 08:13, Onur =C3=96zkan <work@onurozkan.dev> =
wrote:
>>>=20
>>> Hi all,
>>>=20
>>> I have been brainstorming on the auto-unlocking (on dynamic number
>>> of mutexes) idea we have been discussing for some time.
>>>=20
>>> There is a challange with how we handle lock guards and my current
>>> thought is to remove direct data dereferencing from guards. Instead,
>>> data access would only be possible through a fallible method (e.g.,
>>> `try_get`). If the guard is no longer valid, this method would fail
>>> to not allow data-accessing after auto-unlock.
>>>=20
>>> In practice, it would work like this:
>>>=20
>>> let a_guard =3D ctx.lock(mutex_a)?;
>>> let b_guard =3D ctx.lock(mutex_b)?;
>>>=20
>>> // Suppose user tries to lock `mutex_c` without aborting the
>>> // entire function (for some reason). This means that even on
>>> // failure, `a_guard` and `b_guard` will still be accessible.
>>> if let Ok(c_guard) =3D ctx.lock(mutex_c) {
>>>    // ...some logic
>>> }
>>>=20
>>> let a_data =3D a_guard.try_get()?;
>>> let b_data =3D b_guard.try_get()?;
>>=20
>> Can you add more code here? How is this going to look like with the
>> two closures we=E2=80=99ve been discussing?
>=20
> Didn't we said that tuple-based closures are not sufficient when
> dealing with a dynamic number of locks (ref [1]) and ww_mutex is =
mostly
> used with dynamic locks? I thought implementing that approach is not
> worth it (at least for now) because of that.
>=20
> [1]: https://lore.kernel.org/all/DBS8REY5E82S.3937FAHS25ANA@kernel.org
>=20
> Regards,
> Onur



I am referring to this [0]. See the discussion and itemized list at the =
end.

To recap, I am proposing a separate type that is similar to drm_exec, =
and that
implements this:

```
a) run a user closure where the user can indicate which ww_mutexes they =
want to lock
b) keep track of the objects above
c) keep track of whether a contention happened
d) rollback if a contention happened, releasing all locks
e) rerun the user closure from a clean slate after rolling back
f) run a separate user closure whenever we know that all objects have =
been locked.
```

In other words, we need to run a closure to let the user implement a =
given
locking strategy, and then one closure that runs when the user signals =
that
there are no more locks to take.

What I said is different from what Benno suggested here:

>>>>>>    let (a, c, d) =3D ctx.begin()
>>>>>>        .lock(a)
>>>>>>        .lock(b)
>>>>>>        .lock(c)
>>>>>>        .custom(|(a, _, c)| (a, c))
>>>>>>        .lock(d)
>>>>>>        .finish();

i.e.: here is a brief example of how the API should be used by clients:

```
// The Context keeps track of which locks were successfully taken.
let locking_algorithm =3D |ctx: &Context| {
  // client-specific code, likely some loop trying to acquire multiple =
locks:
  //
  // note that it does not _have_ to be a loop, though. It up to the =
clients to
  // provide a suitable implementation here.
  for (..) {
    ctx.lock(foo); // If this succeeds, the context will add  "foo" to =
the list of taken locks.
  }

  // if this closure returns EDEADLK, then our abstraction must =
rollback, and
  // run it again.
};

// This runs when the closure above has indicated that there are no more =
locks
// to take.
let on_all_locks_taken =3D |ctx: &Context| {
  // everything is locked here, give access to the data in the guards.
};

ctx.lock_all(locking_algorithm, on_all_locks_taken)?;
```

Yes, this will allocate but that is fine because drm_exec allocates as =
well.

We might be able to give more control of when the allocation happens if =
the
number of locks is known in advance, e.g.:

```
struct Context<T> {
  taken_locks: KVec<Guard<T>>,
}

impl<T> Context<T> {
  fn prealloc_slots(num_slots: usize, flags: ...) -> Result<Self> {
    let taken_locks =3D ... // pre-alloc a KVec here.=20
    Self {
      taken_slots,
    }=20
  }
}
```

The main point is that this API is optional. It builds a lot of =
convenience of
top of the Rust WWMutex abstraction, but no one is forced to use it.

IOW: What I said should be implementable with a dynamic number of locks. =
Please
let me know if I did not explain this very well.=20

[0]: =
https://lore.kernel.org/rust-for-linux/8B1FB608-7D43-4DD9-8737-DCE59ED74CC=
A@collabora.com/=

