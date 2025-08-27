Return-Path: <linux-kernel+bounces-788297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15595B38284
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37A21672F8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E8A31A54D;
	Wed, 27 Aug 2025 12:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBu5KrX0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258292F49F7;
	Wed, 27 Aug 2025 12:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756298183; cv=none; b=lTzeiJth/lE8YO08ssMCbODNfU/RCpqGIcF+I0VBYaUMBL3YwBjDzCXbqbPUeigcrqeDm0JrFjJ72sC3e4PHbVz+JwEIDIBvb3U5o5B/I6kLU4JQsVqj1e+zv7unQNW+QjuyEjKECoG7b32T59n0kfsah9VjzL+LR0F5RVD0UTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756298183; c=relaxed/simple;
	bh=gMawlR1wd4qJw3Yw0u+8/0DluANiBkZNo7MJA2X0QhI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=FZTWUso2YX2nrmgJGbZwsn8QxTwLWnNTFlhU6Dnp+mlkGcgiECNRh9f+FVa77sCMoPvG6Pl3T90vGElHU7evJazd7dFeLfSDN8albmCaSFiE6TsiW3QczKLqF08G1A97vkqIRO/MiuFf/VCuXItbRD6afAR3fkLD842QZpv14S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBu5KrX0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FACC4CEEB;
	Wed, 27 Aug 2025 12:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756298182;
	bh=gMawlR1wd4qJw3Yw0u+8/0DluANiBkZNo7MJA2X0QhI=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=hBu5KrX02FvSF9qmFmCqLiUHIdPLM1OOEAduDXvSMZNA7+HrO+JWQc6/AwecHcHlZ
	 d5x/h/uO0DUD/DazaFemT/Sih0jmA37a72uEbtgAjxAz+XdD2dQOTjsJmBXwYD2xns
	 iI2IxoG1VpDThAuTtqYAfA7tMJQDeD7IAWuU2l/uEWS0s5SYBqL6/q+fJMqJcIohF2
	 yr4g480FPavSunfjsa+vLe3FcrWwyJtOiXXkAFMt2tLRgk7wnRoWswMJ/BtOHS9rft
	 xrl5+KdN6t7PIhw/VKSCfqKitlTwbTC5TGcHNOfLpIiGQIRfBCWer+EvSsYhT1Iq00
	 8TR2ORbxrpzbg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 Aug 2025 14:36:16 +0200
Message-Id: <DCD7QRZ3L781.PSUM0WWF5UDD@kernel.org>
Subject: Re: [PATCH v1 2/2] rust: Add read_poll_timeout_atomic function
Cc: "FUJITA Tomonori" <fujita.tomonori@gmail.com>, <a.hindborg@kernel.org>,
 <alex.gaynor@gmail.com>, <ojeda@kernel.org>, <aliceryhl@google.com>,
 <anna-maria@linutronix.de>, <bjorn3_gh@protonmail.com>,
 <boqun.feng@gmail.com>, <frederic@kernel.org>, <gary@garyguo.net>,
 <jstultz@google.com>, <linux-kernel@vger.kernel.org>, <lossin@kernel.org>,
 <lyude@redhat.com>, <rust-for-linux@vger.kernel.org>, <sboyd@kernel.org>,
 <tglx@linutronix.de>, <tmgross@umich.edu>, <acourbot@nvidia.com>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250821035710.3692455-1-fujita.tomonori@gmail.com>
 <20250821035710.3692455-3-fujita.tomonori@gmail.com>
 <DCCF63BESWQ9.9LC8MZK7NG1Y@kernel.org>
 <20250827.091427.1081669324737480994.fujita.tomonori@gmail.com>
 <DCD35NEEPLYB.2PBCLR8FWFGKD@kernel.org>
 <DCD51BP7YXJV.3BLY6YJKGC58W@kernel.org>
 <D8CE958C-508F-4A09-96BA-985B5A7C2BA7@collabora.com>
 <DCD7DP6A72A8.2HAYR7K7Z14UO@kernel.org>
 <3E41A50E-3D33-4B66-AEBB-91870298137D@collabora.com>
In-Reply-To: <3E41A50E-3D33-4B66-AEBB-91870298137D@collabora.com>

On Wed Aug 27, 2025 at 2:22 PM CEST, Daniel Almeida wrote:
>
>
>> On 27 Aug 2025, at 09:19, Danilo Krummrich <dakr@kernel.org> wrote:
>>=20
>> On Wed Aug 27, 2025 at 2:14 PM CEST, Daniel Almeida wrote:
>>> Hi Danilo,
>>>=20
>>> [=E2=80=A6}
>>>=20
>>>>=20
>>>> Actually, let me put it in other words:
>>>>=20
>>>> let val =3D read_poll_timeout_atomic(
>>>>    || {
>>>>        // Fetch the offset to read from from the HW.
>>>>        let offset =3D io.read32(0x1000);
>>>>=20
>>>>        // HW needs a break for some odd reason.
>>>>        udelay(100);
>
> Why would we have a delay here? Can=E2=80=99t this be broken into two cal=
ls to
> read_poll_timeout_atomic()? That would be equivalent to what you wrote
> IIUC.

I'm sure this can somehow be written otherwise as well. But that's not the
point, the point is that this looks like perfectly valid code from a users
perspective.

>>>>=20
>>>>        // Read the actual value.
>>>>        io.try_read32(offset)
>>>>    },
>>>>    |val: &u32| *val =3D=3D HW_READY,
>>>>    Delta::from_micros(0),      // No delay, keep spinning.
>>>>    Delta::from_millis(10),     // Timeout after 10ms.
>>>> )?;
>>>>=20
>>>> Seems like a fairly reasonable usage without knowing the implementatio=
n details
>>>> of read_poll_timeout_atomic(), right?
>>>>=20
>>>> Except that if the hardware does not become ready, this will spin for =
16.67
>>>> *minutes* -- in atomic context. Instead of the 10ms the user would exp=
ect.
>
> This is where you lost me. Where does the 16.67 come from?

Ah, I see -- let me explain:

Internally read_poll_timeout_atomic() would convert the timeout (10ms) into=
 ns
(let's call it nanos). Then, it would decrement nanos in every iteration of=
 the
internal loop, based on the (wrong) assumption that every loop takes exactl=
y
1ns.

However, since the user executes udelay(100), which is perfectly valid from=
 the
users perspective, in the Op closure, every loop iteration takes at least 1=
00us
instead.

So, the actual timeout calculates as follows.

	Timeout: 10ms =3D 10.000us =3D 10.000.000ns

In every iteration this number is decremented by one, hence 10.000.000
iterations.

	100us * 10.000.000 iterations =3D 16.67 minutes

So, the issue really is that we're not measuring time, but the number of
iterations if delay_delta =3D=3D 0.

As delay_delta grows the relative eror becomes smaller, yet this is far fro=
m
sane behavior.

>>>>=20
>>>> This would be way less error prone if we do not provide a timeout valu=
e, but a
>>>> retry count.
>>>>=20
>>>>> Instead, I think it makes much more sense to provide a retry count as=
 function
>>>>> argument, such that the user can specify "I want a dealy of 100us, tr=
y it 100
>>>>> times".
>>>>>=20
>>>>> This way it is transparent to the caller that the timeout may be sign=
ificantly
>>>>> more than 10ms depending on the user's implementation.
>>>>>=20
>>>>> As for doing this in C vs Rust: I don't think things have to align in=
 every
>>>>> implementation detail. If we can improve things on the Rust side from=
 the
>>>>> get-go, we should not stop ourselves from doing so, just because a si=
milar C
>>>>> implementation is hard to refactor, due to having a lot of users alre=
ady.
>>>=20
>>> I must say I do not follow. Can you expand yet some more on this?
>>=20
>> Sure, but it would help if you could clarify which aspect you want me to=
 expand
>> on. :)


