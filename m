Return-Path: <linux-kernel+bounces-863015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AE8BF6CAC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AAAE462FFD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E8D33711A;
	Tue, 21 Oct 2025 13:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="GwSjfYdb"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9667F1494A8;
	Tue, 21 Oct 2025 13:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053557; cv=pass; b=CC6nh+IbP2DLUm2SfBLi1LfgvptmZoX/pSlnDdbR2CRWQiZ/zIQQgkfq2JPJqye402mg5bTZs/QDQxIjspgNII5/KYN8eeL6oUpdgJ4DdvjzbgBhNJe5VKOnQtrctOjLJ36UEqazAg3OchLPikDLlt3qV9XQm1eecZh0yD5Zgmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053557; c=relaxed/simple;
	bh=7CPTQ73nWl5I4OjIOSIGL7LFYvAsftq10jNl6Nocmqk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RkUQgN29XZO5H2ZuuqoxQYu6AvBemPKYttt/Z/u/6K5DJzOH5nmXIgdaH7MJxQ5HDDGiukuRqB0u+HjCdcEi+oVLWs3wn9x3Aazrm+qsf9ATekxVoOWelhnkuH4dC8gt2Rxl2QhXhCLObb/ohexiHfJnIAvprZzL/il/MpLTZwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=GwSjfYdb; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1761053514; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IHGpkrjzC2o3d+VJZwE03aLjrs3WUJT7uCIEArSnb8g2SlMfdAoPNQvw4cw/aO3dKwOXdn6jSlN6X6o2FT2WawVbRKw1Ny1YH5AdiSx5VaTXYVEORmfPGyfp6VznAVpVHMw9Ypn3tyYrcC12Q6chTWc82RJc13J1rXT8BbEeQkY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761053514; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7CPTQ73nWl5I4OjIOSIGL7LFYvAsftq10jNl6Nocmqk=; 
	b=ivghX8LCfYPPIjPj1TYf8xT0OiR8MerXi1SnBeDwPlXP/OrpaiAXmXVz5WfKvRZ3r5Nk7iWnJDSqx75B+KRIdC95YvZ2rSKVSFG4Z3bQDGR9DOOpc1va2/HP2ULkLxaqE3FrDMwkfKZr5fX3sjTn571mSACYS8MoYsziqGloUdU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761053514;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=7CPTQ73nWl5I4OjIOSIGL7LFYvAsftq10jNl6Nocmqk=;
	b=GwSjfYdbbWJUWuD87VG4cwcpZdjRASmqH+YKdSnWSH2af3IJ+f+HC6rw2As8VEmS
	uuXspObKXDwCjatgxAEV+LbiTIRasFGZLkqEntL7seGsjopF6zjTvQXX3zp2W9kZIyO
	3CxcRN2XwXXRj8wA5rJPvY2tS11CaA2bUGHMAM7I=
Received: by mx.zohomail.com with SMTPS id 1761053512681371.05774871833614;
	Tue, 21 Oct 2025 06:31:52 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 5/7] rust: ww_mutex: add context-free locking functions
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250906142059.35bf5fc1@nimda.home>
Date: Tue, 21 Oct 2025 10:31:35 -0300
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
Message-Id: <BD330420-E9AA-40B5-B908-71F6108DD22F@collabora.com>
References: <20250903131313.4365-1-work@onurozkan.dev>
 <20250903131313.4365-6-work@onurozkan.dev>
 <392B3416-61A7-4A41-8BDA-3A114F23D3F8@collabora.com>
 <20250906142059.35bf5fc1@nimda.home>
To: Onur <work@onurozkan.dev>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 6 Sep 2025, at 08:20, Onur <work@onurozkan.dev> wrote:
>=20
> On Fri, 5 Sep 2025 16:14:59 -0300
> Daniel Almeida <daniel.almeida@collabora.com> wrote:
>=20
>> Hi Onur
>>=20
>>> On 3 Sep 2025, at 10:13, Onur =C3=96zkan <work@onurozkan.dev> wrote:
>>>=20
>>> Adds new `WwMutex` functions (`lock`, `lock_interruptible`,
>>> `lock_slow`, `lock_slow_interruptible` and `try_lock`) that
>>> can be used without `WwAcquireCtx`. This provides simpler API
>>> when deadlock avoidance grouping is not needed.
>>>=20
>>> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
>>> ---
>>> rust/kernel/sync/lock/ww_mutex.rs | 162
>>> ++++++++++++++++++++++-------- 1 file changed, 122 insertions(+),
>>> 40 deletions(-)
>>>=20
>>> diff --git a/rust/kernel/sync/lock/ww_mutex.rs
>>> b/rust/kernel/sync/lock/ww_mutex.rs index
>>> d289718d2c98..b415d6deae9b 100644 ---
>>> a/rust/kernel/sync/lock/ww_mutex.rs +++
>>> b/rust/kernel/sync/lock/ww_mutex.rs @@ -138,6 +138,75 @@ pub fn
>>> new_wound_wait(name: &'static CStr) -> impl PinInit<Self> { }
>>> }
>>>=20
>>> +/// Locking kinds used by [`lock_common`] to unify internal FFI
>>> locking logic.
>>=20
>> Can you please mention how this is not exposed to the outside world?
>>=20
>> It should be obvious from its private visibility, but still.
>>=20
>=20
> I would like to keep this private and force users to go through the
> public ones. This function contains the entire internal locking logic
> and its signature may need to change if we update any of the =
internals.
> Since it's private, we can safely make breaking changes without
> affecting external calls.
>=20
> The public functions on the other hand are much more stable (at worst,
> only one or two of them might need a breaking change).
>=20

That=E2=80=99s fine, what I mean is that you should mention that users =
aren=E2=80=99t
expected to use it directly.

Again, this is obvious (given that the visibility is private) but it
doesn=E2=80=99t hurt to explain things a bit more on the docs.


=E2=80=94 Daniel=

