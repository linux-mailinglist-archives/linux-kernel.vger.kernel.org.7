Return-Path: <linux-kernel+bounces-753832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0E8B188AC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 23:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 825A03A939A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 21:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343F028DEE0;
	Fri,  1 Aug 2025 21:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="ICTitrtf"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B382A13A3ED;
	Fri,  1 Aug 2025 21:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754083414; cv=pass; b=akdFJlOpVY3NX99sBjCGNma/+qi8G9vdn4O9Ax0wVSTssBpYRfS/g4iBspK84HxWhaOZ9W/AGwLGwwTAvmp/uuIzTqB/oJLKfZfvYZEcdDQnhqqLPIcEj0gX0GDc3XgckVOWnXb5OQYsbTvUf4eYe5tLGOSXJLJdIxbop7BZUI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754083414; c=relaxed/simple;
	bh=936LwS/r8IVDUL6j3HfvUCUdZHWoyg1ZJ+6xpPTUyWg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=a6IEJLFzc92Y7KPWsvECZ/wHe4r3NvaEWq9QoPpO2pk95tNJ6QuVBqxU+Yb3zXBRqOFaMHkJ1LPpTlbX0tFM/l6a/IMfvA4tNeF5lzVbi1q9YVRuF+y6Va+Y+SjTRNr6XTwdldCUwQNJf16+rsd2ljGFLrZ/0PHIqGXtYeYG92c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=ICTitrtf; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1754083382; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=M/2t6l8NDVH3cAXYeEhz1u5yYnRKvWVYo2eJ1vJMK3RYBOXOEtDixgwrT7bRcuLI+F7L9fA+oLRWbx9HhTbB7ovOdmfHUBmaN0gCm5RccqzmUyY2XqOfU5zDTv1Nk7xZqSdVcuB+NNBtwrBdmbBdKxkCEcKfj+BOKKgPXBD56/0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754083382; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9tOBwWQm6WScMmXz4Bg8+/CnxwusloTUAIXeg+S2JHY=; 
	b=CRoTrK4x62/nQv1WkvTYhpXcePOi2GbatBhW2VSypNsPlizDOB+obQ/GFSh7YOrMhY64CgQAsWZgaPbFHjz4u8REpjC2IIHrUbhOvJYt2fvr0N1NBRikum2fYEEDFsPYghjPXVmLndmZNk193NzM+pOuLfyrNqWdrYfkvDJZXNU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754083382;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=9tOBwWQm6WScMmXz4Bg8+/CnxwusloTUAIXeg+S2JHY=;
	b=ICTitrtfMR8XkfzRmt7dfwiRhpvjv9Gyh/9AGV9Lxn47GAXf/3E58pBNeA3KJZX7
	qQBOgNX7KFmFQh7ucjFwk+dVusSrZKHrzhHAZTzF3VKZhpT7bhL1sre7O7Mg16WN+jH
	7Z5bH19YaMCwgNkjbXPvfo9TWtfdx4muozWQ1snA=
Received: by mx.zohomail.com with SMTPS id 1754083380343282.05293676272095;
	Fri, 1 Aug 2025 14:23:00 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v5 2/3] implement ww_mutex abstraction for the Rust tree
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <DB62ZN1LTO31.1HVWDLAWJWVM8@kernel.org>
Date: Fri, 1 Aug 2025 18:22:43 -0300
Cc: Onur <work@onurozkan.dev>,
 Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
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
Message-Id: <FF481535-86EF-41EB-830A-1DA2434AAEA0@collabora.com>
References: <20250621184454.8354-1-work@onurozkan.dev>
 <20250621184454.8354-3-work@onurozkan.dev>
 <DASY7BECFRCT.332X5ZHZMV2W@kernel.org> <aFlQ7K_mYYbrG8Cl@Mac.home>
 <DATYHYJVPL3L.3NLMH7PPHYU9@kernel.org> <aFlpFQ4ivKw81d-y@Mac.home>
 <DAU0ELV91E2Q.35FZOII18W44J@kernel.org> <20250707163913.5ffc046d@nimda.home>
 <DB5XIWGZ8U36.1VB58YBJFL7OT@kernel.org> <20250707210613.2fd5bb55@nimda.home>
 <DB62ZN1LTO31.1HVWDLAWJWVM8@kernel.org>
To: Benno Lossin <lossin@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Benno,

> On 7 Jul 2025, at 16:48, Benno Lossin <lossin@kernel.org> wrote:
>=20
> On Mon Jul 7, 2025 at 8:06 PM CEST, Onur wrote:
>> On Mon, 07 Jul 2025 17:31:10 +0200
>> "Benno Lossin" <lossin@kernel.org> wrote:
>>=20
>>> On Mon Jul 7, 2025 at 3:39 PM CEST, Onur wrote:
>>>> On Mon, 23 Jun 2025 17:14:37 +0200
>>>> "Benno Lossin" <lossin@kernel.org> wrote:
>>>>=20
>>>>>> We also need to take into consideration that the user want to
>>>>>> drop any lock in the sequence? E.g. the user acquires a, b and
>>>>>> c, and then drop b, and then acquires d. Which I think is
>>>>>> possible for ww_mutex.
>>>>>=20
>>>>> Hmm what about adding this to the above idea?:
>>>>>=20
>>>>>    impl<'a, Locks> WwActiveCtx<'a, Locks>
>>>>>    where
>>>>>        Locks: Tuple
>>>>>    {
>>>>>        fn custom<L2>(self, action: impl FnOnce(Locks) -> L2) ->
>>>>> WwActiveCtx<'a, L2>; }
>>>>>=20
>>>>> Then you can do:
>>>>>=20
>>>>>    let (a, c, d) =3D ctx.begin()
>>>>>        .lock(a)
>>>>>        .lock(b)
>>>>>        .lock(c)
>>>>>        .custom(|(a, _, c)| (a, c))
>>>>>        .lock(d)
>>>>>        .finish();
>>>>=20
>>>>=20
>>>> Instead of `begin` and `custom`, why not something like this:
>>>>=20
>>>> let (a, c, d) =3D ctx.init()
>>>>     .lock(a)
>>>>            .lock(b)
>>>>            .lock(c)
>>>>            .unlock(b)
>>>>            .lock(d)
>>>>            .finish();
>>>>=20
>>>> Instead of `begin`, `init` would be better naming to imply `fini`
>>>> on the C side, and `unlock` instead of `custom` would make the
>>>> intent clearer when dropping locks mid chain.
>=20
> Also, I'm not really fond of the name `init`, how about `enter`?
>=20
>>>=20
>>> I don't think that this `unlock` operation will work. How would you
>>> implement it?
>>=20
>>=20
>> We could link mutexes to locks using some unique value, so that we =
can
>> access locks by passing mutexes (though that sounds a bit odd).
>>=20
>> Another option would be to unlock by the index, e.g.,:
>>=20
>> let (a, c) =3D ctx.init()
>>     .lock(a)
>>            .lock(b)
>>            .unlock::<1>()

Why do we need this random unlock() here? We usually want to lock =
everything
and proceed, or otherwise backoff completely so that someone else can =
proceed.

One thing I didn=E2=80=99t understand with your approach: is it amenable =
to loops?
i.e.: are things like drm_exec() implementable?

/**
 * drm_exec_until_all_locked - loop until all GEM objects are locked
 * @exec: drm_exec object
 *
 * Core functionality of the drm_exec object. Loops until all GEM =
objects are
 * locked and no more contention exists. At the beginning of the loop it =
is
 * guaranteed that no GEM object is locked.
 *
 * Since labels can't be defined local to the loops body we use a jump =
pointer
 * to make sure that the retry is only used from within the loops body.
 */
#define drm_exec_until_all_locked(exec)					=
\
__PASTE(__drm_exec_, __LINE__):						=
\
	for (void *__drm_exec_retry_ptr; ({				=
\
		__drm_exec_retry_ptr =3D &&__PASTE(__drm_exec_, =
__LINE__);\
		(void)__drm_exec_retry_ptr;				=
\
		drm_exec_cleanup(exec);					=
\
	});)

In fact, perhaps we can copy drm_exec, basically? i.e.:

/**
 * struct drm_exec - Execution context
 */
struct drm_exec {
	/**
	 * @flags: Flags to control locking behavior
	 */
	u32                     flags;

	/**
	 * @ticket: WW ticket used for acquiring locks
	 */
	struct ww_acquire_ctx	ticket;

	/**
	 * @num_objects: number of objects locked
	 */
	unsigned int		num_objects;

	/**
	 * @max_objects: maximum objects in array
	 */
	unsigned int		max_objects;

	/**
	 * @objects: array of the locked objects
	 */
	struct drm_gem_object	**objects;

	/**
	 * @contended: contended GEM object we backed off for
	 */
	struct drm_gem_object	*contended;

	/**
	 * @prelocked: already locked GEM object due to contention
	 */
	struct drm_gem_object *prelocked;
};

This is GEM-specific, but we could perhaps implement the same idea by
tracking ww_mutexes instead of GEM objects.

Also, I=E2=80=99d appreciate if the rollback logic could be automated, =
which is
what you=E2=80=99re trying to do, so +1 to your idea.

>>            .lock(c)
>>            .finish();
>=20
> Hmm yeah that's interesting, but probably not very readable...
>=20
>    let (a, c, e) =3D ctx
>        .enter()
>        .lock(a)
>        .lock(b)
>        .lock_with(|(a, b)| b.foo())
>        .unlock::<1>()
>        .lock(c)
>        .lock(d)
>        .lock_with(|(.., d)| d.bar())
>        .unlock::<2>();
>=20
>> The index approach would require us to write something very similar
>> to `Tuple` (with macro obviously) you proposed sometime ago.
>>=20
>> We could also just go back to your `custom` but find a better name
>> for it (such as `retain`).
>=20
> Oh yeah the name was just a placeholder.
>=20
> The advantage of custom is that the user can do anything in the =
closure.
>=20
> ---
> Cheers,
> Benno

=E2=80=94 Daniel=

