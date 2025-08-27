Return-Path: <linux-kernel+bounces-788282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23223B3822B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DC5E7A427D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F60303CA8;
	Wed, 27 Aug 2025 12:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="f6nkEzIj"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158EA86348;
	Wed, 27 Aug 2025 12:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756297426; cv=pass; b=a0Zu6AACL/O9K6z/pQvud4MKUGMs5Dt1tU4jyYRaG9uAd0x703IINTJT5wh4U/BcDl01pFtQFUTsfsvaFCXksqvkqDN0m4kqrzlfMu9k4TCTZdQXNf1n9Ugohvhnmpcj4lZCAwTSh/8VnmmzUMtvfD7pSeIea+jJ3oSxb/UkgQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756297426; c=relaxed/simple;
	bh=1e27FPcG4nbp1HEbNe6Saus66/Yx9y4AM2QLfqSbWz8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=rDk2Eit8n2KGcZ8JF7QHmOG0nI0u3iUBewj+a5GNEA05IZF40n4LCXqahEwMNu+9IPJEzuKZ7+T9+7g+tyidkWLbaiOUoRgTvcTkXW1Fp/KBQ47+1B5qHyuhK3rkSfJ86HxqTfS1JxN5oAnJPEcTKdfTSu+5fKBVPr79yTWHMYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=f6nkEzIj; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756297401; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GAubs1AyTGVlPhpzrIfq8A694jmif+sWyhUIREW3nwgvhQcRmIifNNCFguYCMjOEAgBdz+O1w8V0BFU3kRQQiLiazR+10bh0iy+H02AfzVfXTWN8Z/DBmREGpS1cwVWP5yQsVJHX7KR07ZcRo+OposE3PHYIMCi0rkYEtfdXeoM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756297401; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4bLlzZ7dR7ES6osPfpzWXriFSdPBG1uiNu7yZ002bl8=; 
	b=bq1TGIqDySExiyVg4A0mevM/sJU+NlXfsTJBpSSTPx3x+lIIlklVvOcmimRxSsGQ0JcjvAL1lBynHLgKA4m+PiYoYtRR73FgbVjrWWhKltW27YJs2dlI8bgwa/IjjT1yZ9Emji+Y66rjDsONylvgBSOEKCclbJj1DzcH2KlgXUU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756297401;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=4bLlzZ7dR7ES6osPfpzWXriFSdPBG1uiNu7yZ002bl8=;
	b=f6nkEzIjelddWZtH06EGLqMXnK2oqKJQBANKnugMQQfTwdOyEoPucN2T5TJ839rV
	p8p6qRL8KvhDzEwSo4QAVgf8WK6fteNEOHzhbwvD9JGr4YqvyZc+D6TW1by/h+pDuax
	ZjRxKJRzBESOu9TLaX0jqkAvsygToGCTn0NHreU8=
Received: by mx.zohomail.com with SMTPS id 175629739838083.65255691152697;
	Wed, 27 Aug 2025 05:23:18 -0700 (PDT)
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
In-Reply-To: <DCD7DP6A72A8.2HAYR7K7Z14UO@kernel.org>
Date: Wed, 27 Aug 2025 09:22:50 -0300
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
Message-Id: <3E41A50E-3D33-4B66-AEBB-91870298137D@collabora.com>
References: <20250821035710.3692455-1-fujita.tomonori@gmail.com>
 <20250821035710.3692455-3-fujita.tomonori@gmail.com>
 <DCCF63BESWQ9.9LC8MZK7NG1Y@kernel.org>
 <20250827.091427.1081669324737480994.fujita.tomonori@gmail.com>
 <DCD35NEEPLYB.2PBCLR8FWFGKD@kernel.org>
 <DCD51BP7YXJV.3BLY6YJKGC58W@kernel.org>
 <D8CE958C-508F-4A09-96BA-985B5A7C2BA7@collabora.com>
 <DCD7DP6A72A8.2HAYR7K7Z14UO@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 27 Aug 2025, at 09:19, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> On Wed Aug 27, 2025 at 2:14 PM CEST, Daniel Almeida wrote:
>> Hi Danilo,
>>=20
>> [=E2=80=A6}
>>=20
>>>=20
>>> Actually, let me put it in other words:
>>>=20
>>> let val =3D read_poll_timeout_atomic(
>>>    || {
>>>        // Fetch the offset to read from from the HW.
>>>        let offset =3D io.read32(0x1000);
>>>=20
>>>        // HW needs a break for some odd reason.
>>>        udelay(100);

Why would we have a delay here? Can=E2=80=99t this be broken into two =
calls to
read_poll_timeout_atomic()? That would be equivalent to what you wrote
IIUC.

>>>=20
>>>        // Read the actual value.
>>>        io.try_read32(offset)
>>>    },
>>>    |val: &u32| *val =3D=3D HW_READY,
>>>    Delta::from_micros(0),      // No delay, keep spinning.
>>>    Delta::from_millis(10),     // Timeout after 10ms.
>>> )?;
>>>=20
>>> Seems like a fairly reasonable usage without knowing the =
implementation details
>>> of read_poll_timeout_atomic(), right?
>>>=20
>>> Except that if the hardware does not become ready, this will spin =
for 16.67
>>> *minutes* -- in atomic context. Instead of the 10ms the user would =
expect.

This is where you lost me. Where does the 16.67 come from?

>>>=20
>>> This would be way less error prone if we do not provide a timeout =
value, but a
>>> retry count.
>>>=20
>>>> Instead, I think it makes much more sense to provide a retry count =
as function
>>>> argument, such that the user can specify "I want a dealy of 100us, =
try it 100
>>>> times".
>>>>=20
>>>> This way it is transparent to the caller that the timeout may be =
significantly
>>>> more than 10ms depending on the user's implementation.
>>>>=20
>>>> As for doing this in C vs Rust: I don't think things have to align =
in every
>>>> implementation detail. If we can improve things on the Rust side =
from the
>>>> get-go, we should not stop ourselves from doing so, just because a =
similar C
>>>> implementation is hard to refactor, due to having a lot of users =
already.
>>=20
>> I must say I do not follow. Can you expand yet some more on this?
>=20
> Sure, but it would help if you could clarify which aspect you want me =
to expand
> on. :)



