Return-Path: <linux-kernel+bounces-803623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FE1B46317
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0441795D6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A77169AE6;
	Fri,  5 Sep 2025 19:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="SBn/twbl"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2752315D2E;
	Fri,  5 Sep 2025 19:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099043; cv=pass; b=Ya2pj7DHdE5LyhOP271HuK8Okrkoi9ujRFVoIU/++GtaduJeo+1d8mFtZFq4gu3L9TZYeMagznD65Ak/04UJzjS+IFk7SjHgrfP50pm2ZAM4xEL6lL9tKy4rv1/j0aZZdKAtOKYqixOZnGnYmmzjqAqX5+aDMfvwflCaKNCUmTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099043; c=relaxed/simple;
	bh=UfMRvbCdz//QcrjCmuh19y/FVDAsWrc1l8Lsivmaeq4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=HDeo4cSzXbEj+HB3dDiI9smxUD3iUr4xykwCwc/H8/iViDi/pwZN+ig9Lzu9Ul4biTLs9ItWzfoK/T7Z5ZvUkJ71icT2sPobY/gRvlL0ZHD5k7B/WmfRwGVyK8ZMT1jlvFVe16FcJa6FzNqnoG8dU9KTWEDR9EYTSbsO0KD9EL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=SBn/twbl; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757099001; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SWEf5Q/+/3tQS6q4IL9ngfhDcDP1qUO78lRIKwnzgqZZLQiUoCPoDx9NxFilZyG7g6xvf5TOHltDngenlCEbrUCzmloJCTUPb51bWw4ojnRPxzqSH+NaI/3iJhUDeGCR/QBhKwyt5RrgDiDLd9g1FEnb0QLdhF46Fd0EqNd1+d0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757099001; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7x9ncDrrrS5zRZo4deaFxhL1RLmq8zmIxWh53uHA2TM=; 
	b=ic99RPrLQUPPazIc+KJ8yEfgtSD/CyPVVaX5A0Uk6vvJxD57f8kv6cOwJPsvoUd0WUpmZANLCMAF8CU/63jGaJxLoHkmAIlalhZm81BLQT1TDRkFE5he8F7gUGuxJ4nhJ3PcXeQWftNtDZmGuVbqDb67fPcLRY5dB3h+5QdB3yU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757099001;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=7x9ncDrrrS5zRZo4deaFxhL1RLmq8zmIxWh53uHA2TM=;
	b=SBn/twblvcIKwSX3dDOMYodlyejcb+lONzT6Y8udwHzs2ore0foP8L/Ud31/WJ0X
	cZu+GqZ9oRkM6xok4xhi4ee4dFe+XnikH23LwA9YW+V6dhzaEeyq//w2d7pxKCdppvF
	giri92t4lcB8o8PKW694bWxqkIHeIM3TiuKFAMm0=
Received: by mx.zohomail.com with SMTPS id 1757098999295176.35403178460876;
	Fri, 5 Sep 2025 12:03:19 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 3/7] rust: implement `WwMutex`, `WwAcquireCtx` and
 `WwMutexGuard`
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <886565B2-B5CD-49DA-9598-EBD60490C0DC@collabora.com>
Date: Fri, 5 Sep 2025 16:03:02 -0300
Cc: rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 lossin@kernel.org,
 lyude@redhat.com,
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
Message-Id: <E98866AA-AE29-432E-B6D3-4625103B8D07@collabora.com>
References: <20250903131313.4365-1-work@onurozkan.dev>
 <20250903131313.4365-4-work@onurozkan.dev>
 <886565B2-B5CD-49DA-9598-EBD60490C0DC@collabora.com>
To: =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

[=E2=80=A6]

>=20
>> +///
>> +/// # Examples
>> +///
>> +/// ## Basic Usage
>> +///
>> +/// ```
>> +/// use kernel::c_str;
>> +/// use kernel::sync::Arc;
>> +/// use kernel::sync::lock::ww_mutex::{WwClass, WwAcquireCtx, =
WwMutex };
>> +/// use pin_init::stack_pin_init;
>> +///
>> +/// stack_pin_init!(let class =3D =
WwClass::new_wound_wait(c_str!("buffer_class")));
>> +/// let mutex =3D Arc::pin_init(WwMutex::new(42, &class), =
GFP_KERNEL)?;
>> +///
>> +/// let ctx =3D KBox::pin_init(WwAcquireCtx::new(&class), =
GFP_KERNEL)?;
>> +///
>> +/// let guard =3D ctx.lock(&mutex)?;
>> +/// assert_eq!(*guard, 42);
>> +///
>> +/// # Ok::<(), Error>(())
>> +/// ```
>> +///
>> +/// ## Multiple Locks
>> +///
>> +/// ```
>> +/// use kernel::c_str;
>> +/// use kernel::prelude::*;
>> +/// use kernel::sync::Arc;
>> +/// use kernel::sync::lock::ww_mutex::{WwClass, WwAcquireCtx, =
WwMutex};
>> +/// use pin_init::stack_pin_init;
>> +///
>> +/// stack_pin_init!(let class =3D =
WwClass::new_wait_die(c_str!("resource_class")));
>> +/// let mutex_a =3D Arc::pin_init(WwMutex::new("Resource A", =
&class), GFP_KERNEL)?;
>> +/// let mutex_b =3D Arc::pin_init(WwMutex::new("Resource B", =
&class), GFP_KERNEL)?;
>> +///
>> +/// let ctx =3D KBox::pin_init(WwAcquireCtx::new(&class), =
GFP_KERNEL)?;
>> +///
>> +/// // Try to acquire both locks.
>> +/// let guard_a =3D match ctx.lock(&mutex_a) {
>> +///     Ok(guard) =3D> guard,
>> +///     Err(e) if e =3D=3D EDEADLK =3D> {
>> +///         // Deadlock detected, use slow path.
>=20
> You must release all other locks before calling this, except there =
aren=E2=80=99t any taken in your example.
>=20
> You should perhaps add a release_all() function to the context.
>=20

By the way, if we need a context in the first place to lock, it makes =
sense to
release_all() once this context is dropped.

=E2=80=94 Daniel



