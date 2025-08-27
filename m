Return-Path: <linux-kernel+bounces-788269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D19BB38203
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6837367BF0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE6F302768;
	Wed, 27 Aug 2025 12:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="UQ5k2Qfe"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42443019B3;
	Wed, 27 Aug 2025 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756296891; cv=pass; b=f+dWXF5HbLqXitSZMqCkHQzxkoL+pCz0Ny4xXsAXHshCJELF1KVjaxG9wLTx4D+zQl4Jy1pMRBdwSbQDFBOuFhgtzQcuGa1pdAQHNcmdJTRUZv/W5zk4QCbV699fb4j7zYg7W0EgKQUbEp/XN1qhmkkfAVytWbY+06xCWxWBvWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756296891; c=relaxed/simple;
	bh=wblPcKt90cfUL8zS9rLjL89DIYgXuGT9216UtH7akZ0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=c0C9lTtZMZoD3+QgjMgsbHumaWh/+UA9GLrIw56n+YbL0UdAW1tx1gQ7xcdz+QBzISCno1NGHgsuqVP6MX67lE4qB+kelnK9onkmtmoHNYSUuEbf/zXU1jPtiEtEWenUz+AHr47fzPmO35LQvLPKuWorqVep5UvmWKgpllwTy5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=UQ5k2Qfe; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756296866; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VwpsCiEAbyQ32oGgk9JqLXq6BUSD03Pb00hoDrNVO/OKCTP36hUW8qLtJLD1hIXJ9f68ZiZfq5eu5ZxXnnEr+tBjhsl5+UG6ecWD2eu1urwJjcULkU4O8i8OqlxLdOJU11uRxbSxdOwn+YxK/oc1zNNPEMcb6t6n8GjtHvkQkCo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756296866; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TGSK8M1S4Urk1y6BmRNJNhLLjVdDvem3osj5JB4wod8=; 
	b=nsgIHE8PV9rVZSv+OFr4Ilx8jZ5aIgI+51jALQU50yfsf7W2g5hIKm0Sbdgwc1+nOoKmNid4PIO9mKlB21DpLVwYvVLW8KnlE3tfshWRB/JOiIAmSGHRtyDBGl8Ih1U833rl8zb/IFKnrG4/PW5Vqhmp168Of+TZSfmiSC+8P6E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756296866;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=TGSK8M1S4Urk1y6BmRNJNhLLjVdDvem3osj5JB4wod8=;
	b=UQ5k2Qfe72Kre8uQweInAbJkNfqdEH43dlqWZ9eaCf5XirLYQI5Tjf2eqMNSBCuH
	ywwpffDGEIDAiyYHE50jIWOWM4U6DvICyscy/2UXB/c0zjUtEYU62Z1tWUomCVHO2ei
	fPW0/biH4Eq0tUvDD/w8zbUinPj8yMp7/M1JY+j0=
Received: by mx.zohomail.com with SMTPS id 1756296863354861.5917412894015;
	Wed, 27 Aug 2025 05:14:23 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v1 2/2] rust: Add read_poll_timeout_atomic function
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <DCD51BP7YXJV.3BLY6YJKGC58W@kernel.org>
Date: Wed, 27 Aug 2025 09:14:04 -0300
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
 a.hindborg@kernel.org,
 alex.gaynor@gmail.com,
 ojeda@kernel.org,
 aliceryhl@google.com,
 anna-maria@linutronix.de,
 bjorn3_gh@protonmail.com,
 boqun.feng@gmail.com,
 frederic@kernel.org,
 gary@garyguo.net,
 jstultz@google.com,
 linux-kernel@vger.kernel.org,
 lossin@kernel.org,
 lyude@redhat.com,
 rust-for-linux@vger.kernel.org,
 sboyd@kernel.org,
 tglx@linutronix.de,
 tmgross@umich.edu,
 acourbot@nvidia.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <D8CE958C-508F-4A09-96BA-985B5A7C2BA7@collabora.com>
References: <20250821035710.3692455-1-fujita.tomonori@gmail.com>
 <20250821035710.3692455-3-fujita.tomonori@gmail.com>
 <DCCF63BESWQ9.9LC8MZK7NG1Y@kernel.org>
 <20250827.091427.1081669324737480994.fujita.tomonori@gmail.com>
 <DCD35NEEPLYB.2PBCLR8FWFGKD@kernel.org>
 <DCD51BP7YXJV.3BLY6YJKGC58W@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Danilo,

[=E2=80=A6}

>=20
> Actually, let me put it in other words:
>=20
> let val =3D read_poll_timeout_atomic(
>     || {
>         // Fetch the offset to read from from the HW.
>         let offset =3D io.read32(0x1000);
>=20
>         // HW needs a break for some odd reason.
>         udelay(100);
>=20
>         // Read the actual value.
>         io.try_read32(offset)
>     },
>     |val: &u32| *val =3D=3D HW_READY,
>     Delta::from_micros(0),      // No delay, keep spinning.
>     Delta::from_millis(10),     // Timeout after 10ms.
> )?;
>=20
> Seems like a fairly reasonable usage without knowing the =
implementation details
> of read_poll_timeout_atomic(), right?
>=20
> Except that if the hardware does not become ready, this will spin for =
16.67
> *minutes* -- in atomic context. Instead of the 10ms the user would =
expect.
>=20
> This would be way less error prone if we do not provide a timeout =
value, but a
> retry count.
>=20
>> Instead, I think it makes much more sense to provide a retry count as =
function
>> argument, such that the user can specify "I want a dealy of 100us, =
try it 100
>> times".
>>=20
>> This way it is transparent to the caller that the timeout may be =
significantly
>> more than 10ms depending on the user's implementation.
>>=20
>> As for doing this in C vs Rust: I don't think things have to align in =
every
>> implementation detail. If we can improve things on the Rust side from =
the
>> get-go, we should not stop ourselves from doing so, just because a =
similar C
>> implementation is hard to refactor, due to having a lot of users =
already.

I must say I do not follow. Can you expand yet some more on this?

=E2=80=94 Daniel



