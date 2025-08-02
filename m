Return-Path: <linux-kernel+bounces-754095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB8BB18E00
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 12:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03C41AA1EE2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 10:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F741221555;
	Sat,  2 Aug 2025 10:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZ1D2NWw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9C321146C;
	Sat,  2 Aug 2025 10:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754131329; cv=none; b=JmRdoGjDLtbkau3jK351UeUd2X96+sEHvf/SrY3L8HyLcMdzVYWV/YfoUm7P8JAinUssNGjEpKDayhDhM58Vv0Yp+HvvRs9AE7KaZbVdfCDfaGRxpUVQBnwWZG7N6MjOsYNtyQjPchlHgnc4kwyCCthA1llOJhuJcMQlbavEsT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754131329; c=relaxed/simple;
	bh=pcGk9y8DlmgUq1EcQLsz9u593YFGYmOv4O5/rbqbbOk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UwO3seyxVUxvZjsk0a+cFC29P+OVa5E3otkJ6oRCuiSrhgWEJvRXJn1cOs90WE1myXUubNcyIhesl1GYPOX2I8Pzi8Bm6BMFK8fCWlmJJXPFrcWANrVLKBPilRwfEtdCTfwPYIQM4gsw5EHrDm2IpxrwEIYqCnk7SbDiiezuRG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZ1D2NWw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F56C4CEEF;
	Sat,  2 Aug 2025 10:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754131328;
	bh=pcGk9y8DlmgUq1EcQLsz9u593YFGYmOv4O5/rbqbbOk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=UZ1D2NWwLxV7PESJmi7SL1Lz+F/usj2zFNAb49RbTzRTrxeauxTmekDoNyGpfsE2L
	 R79o4gC3PKVyPtVAbpoIwH8zmdLrDmoHGRcJbllGnGLnRDKYC9eGniDL3JByuXXHDq
	 nRjYngzEZn+cdWv0DXH+/89fitw2FVqq/fRfl4triPrBlyojwg5PMKNQT4EuThjSYb
	 wCUvAlfeJDeZzBbqbs/LochT7hm44of71L9e1SPQctaIBqMv/0DPes+W3vfXfatJup
	 LaFBy5JCfr338VLoioe4ZPbX2SC6Zi/Fi1bWudZqC/iBqJ4goCzZeaUyAzoKecUidG
	 Bdx7Y8h6fn4wA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 02 Aug 2025 12:42:03 +0200
Message-Id: <DBRVNP4MM5KO.3IXLMXKGK4XTS@kernel.org>
Cc: "Onur" <work@onurozkan.dev>, "Boqun Feng" <boqun.feng@gmail.com>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <gary@garyguo.net>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <dakr@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
 <will@kernel.org>, <longman@redhat.com>, <felipe_life@live.com>,
 <daniel@sedlak.dev>, <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH v5 2/3] implement ww_mutex abstraction for the Rust tree
From: "Benno Lossin" <lossin@kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
X-Mailer: aerc 0.20.1
References: <20250621184454.8354-1-work@onurozkan.dev>
 <20250621184454.8354-3-work@onurozkan.dev>
 <DASY7BECFRCT.332X5ZHZMV2W@kernel.org> <aFlQ7K_mYYbrG8Cl@Mac.home>
 <DATYHYJVPL3L.3NLMH7PPHYU9@kernel.org> <aFlpFQ4ivKw81d-y@Mac.home>
 <DAU0ELV91E2Q.35FZOII18W44J@kernel.org>
 <20250707163913.5ffc046d@nimda.home>
 <DB5XIWGZ8U36.1VB58YBJFL7OT@kernel.org>
 <20250707210613.2fd5bb55@nimda.home>
 <DB62ZN1LTO31.1HVWDLAWJWVM8@kernel.org>
 <FF481535-86EF-41EB-830A-1DA2434AAEA0@collabora.com>
In-Reply-To: <FF481535-86EF-41EB-830A-1DA2434AAEA0@collabora.com>

On Fri Aug 1, 2025 at 11:22 PM CEST, Daniel Almeida wrote:
> Hi Benno,
>
>> On 7 Jul 2025, at 16:48, Benno Lossin <lossin@kernel.org> wrote:
>>=20
>> On Mon Jul 7, 2025 at 8:06 PM CEST, Onur wrote:
>>> On Mon, 07 Jul 2025 17:31:10 +0200
>>> "Benno Lossin" <lossin@kernel.org> wrote:
>>>=20
>>>> On Mon Jul 7, 2025 at 3:39 PM CEST, Onur wrote:
>>>>> On Mon, 23 Jun 2025 17:14:37 +0200
>>>>> "Benno Lossin" <lossin@kernel.org> wrote:
>>>>>=20
>>>>>>> We also need to take into consideration that the user want to
>>>>>>> drop any lock in the sequence? E.g. the user acquires a, b and
>>>>>>> c, and then drop b, and then acquires d. Which I think is
>>>>>>> possible for ww_mutex.
>>>>>>=20
>>>>>> Hmm what about adding this to the above idea?:
>>>>>>=20
>>>>>>    impl<'a, Locks> WwActiveCtx<'a, Locks>
>>>>>>    where
>>>>>>        Locks: Tuple
>>>>>>    {
>>>>>>        fn custom<L2>(self, action: impl FnOnce(Locks) -> L2) ->
>>>>>> WwActiveCtx<'a, L2>; }
>>>>>>=20
>>>>>> Then you can do:
>>>>>>=20
>>>>>>    let (a, c, d) =3D ctx.begin()
>>>>>>        .lock(a)
>>>>>>        .lock(b)
>>>>>>        .lock(c)
>>>>>>        .custom(|(a, _, c)| (a, c))
>>>>>>        .lock(d)
>>>>>>        .finish();
>>>>>=20
>>>>>=20
>>>>> Instead of `begin` and `custom`, why not something like this:
>>>>>=20
>>>>> let (a, c, d) =3D ctx.init()
>>>>>     .lock(a)
>>>>>            .lock(b)
>>>>>            .lock(c)
>>>>>            .unlock(b)
>>>>>            .lock(d)
>>>>>            .finish();
>>>>>=20
>>>>> Instead of `begin`, `init` would be better naming to imply `fini`
>>>>> on the C side, and `unlock` instead of `custom` would make the
>>>>> intent clearer when dropping locks mid chain.
>>=20
>> Also, I'm not really fond of the name `init`, how about `enter`?
>>=20
>>>>=20
>>>> I don't think that this `unlock` operation will work. How would you
>>>> implement it?
>>>=20
>>>=20
>>> We could link mutexes to locks using some unique value, so that we can
>>> access locks by passing mutexes (though that sounds a bit odd).
>>>=20
>>> Another option would be to unlock by the index, e.g.,:
>>>=20
>>> let (a, c) =3D ctx.init()
>>>     .lock(a)
>>>            .lock(b)
>>>            .unlock::<1>()
>
> Why do we need this random unlock() here? We usually want to lock everyth=
ing
> and proceed, or otherwise backoff completely so that someone else can pro=
ceed.

No the `unlock` was just to show that we could interleave locking and
unlocking.

> One thing I didn=E2=80=99t understand with your approach: is it amenable =
to loops?
> i.e.: are things like drm_exec() implementable?

I don't think so, see also my reply here:

    https://lore.kernel.org/all/DBOPIJHY9NZ7.2CU5XP7UY7ES3@kernel.org

The type-based approach with tuples doesn't handle dynamic number of
locks.

> /**
>  * drm_exec_until_all_locked - loop until all GEM objects are locked
>  * @exec: drm_exec object
>  *
>  * Core functionality of the drm_exec object. Loops until all GEM objects=
 are
>  * locked and no more contention exists. At the beginning of the loop it =
is
>  * guaranteed that no GEM object is locked.
>  *
>  * Since labels can't be defined local to the loops body we use a jump po=
inter
>  * to make sure that the retry is only used from within the loops body.
>  */
> #define drm_exec_until_all_locked(exec)					\
> __PASTE(__drm_exec_, __LINE__):						\
> 	for (void *__drm_exec_retry_ptr; ({				\
> 		__drm_exec_retry_ptr =3D &&__PASTE(__drm_exec_, __LINE__);\
> 		(void)__drm_exec_retry_ptr;				\
> 		drm_exec_cleanup(exec);					\
> 	});)

My understanding of C preprocessor macros is not good enough to parse or
understand this :( What is that `__PASTE` thing?

> In fact, perhaps we can copy drm_exec, basically? i.e.:
>
> /**
>  * struct drm_exec - Execution context
>  */
> struct drm_exec {
> 	/**
> 	 * @flags: Flags to control locking behavior
> 	 */
> 	u32                     flags;
>
> 	/**
> 	 * @ticket: WW ticket used for acquiring locks
> 	 */
> 	struct ww_acquire_ctx	ticket;
>
> 	/**
> 	 * @num_objects: number of objects locked
> 	 */
> 	unsigned int		num_objects;
>
> 	/**
> 	 * @max_objects: maximum objects in array
> 	 */
> 	unsigned int		max_objects;
>
> 	/**
> 	 * @objects: array of the locked objects
> 	 */
> 	struct drm_gem_object	**objects;
>
> 	/**
> 	 * @contended: contended GEM object we backed off for
> 	 */
> 	struct drm_gem_object	*contended;
>
> 	/**
> 	 * @prelocked: already locked GEM object due to contention
> 	 */
> 	struct drm_gem_object *prelocked;
> };
>
> This is GEM-specific, but we could perhaps implement the same idea by
> tracking ww_mutexes instead of GEM objects.

But this would only work for `Vec<WwMutex<T>>`, right?

> Also, I=E2=80=99d appreciate if the rollback logic could be automated, wh=
ich is
> what you=E2=80=99re trying to do, so +1 to your idea.

Good to see that it seems useful to you :)

---
Cheers,
Benno

