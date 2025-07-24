Return-Path: <linux-kernel+bounces-745066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5843DB11463
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 01:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 022BAAA573C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B8623E335;
	Thu, 24 Jul 2025 23:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="GCfOorPL"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6164E224225;
	Thu, 24 Jul 2025 23:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753398847; cv=pass; b=swDQWluM5AhBNi7CZl2Bd0E8gtueCn7X9pN1eWDA+oqLE4I4u15RWvSNo5xuAwNGEMtUdV7etJoPvtzJWvhFghteXpngX+GxWHWJtARFQEgcNcdq5HCvwOXI91YMSgAlUfCyRIXWyaOoYwcWH43t9vA6z4a5FP6suWB8OlvUh8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753398847; c=relaxed/simple;
	bh=qoS/nhvhWVOdRPR9TEbn27OPGAu9L7gp5BjJmNczgDE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=l8Yj4dKkACAe0feqlQKfqwcV4xPZNGhbBDpB6Mh8gOzuDEhfuLLieofs0hBeay0s3vYZ9/YAZkeTG7hRfs48UY9xYpKuMm18179L+pn9phD4vyeOs4AZgOkGsCE+4U649G5ekCiTDAv57q0B/sW9bsCev7np/08DRkWie/eytXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=GCfOorPL; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753398813; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QESqvU1fmd4n54OSgYaySl/CHEEEoQxkSlUqDEUi8sF6JOMkNcauBvwoQ8KZxJ1PJlDo9zTQyTiAl2GxAMxlHcz4axkPgse00BpNY696M+gsFlxlkprGaJ7NDKT9NN7cxjfnuRECQO1yUAlKUJEVFZ01CmUM7OTilcbqvn1Mjwo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753398813; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7WbypAsGzahsapPp7xQ+wrpUDPFjbToobgw0emJ/Uh0=; 
	b=GTmoZeM60VZe5HMFwnBH1m8HS7S/xDkrnxl+oi0LrNMcs9Lrq5vOuR9G7wFC0Ri3mhd74tLSZJtIOYgQbAlqoHz4ctyPQS4ygF3ZOXaxj2dUwRfgfqZaK8YK+xl/68AjruM7aS/owRBZQRhbRkaG/Z4eRr3LVLCfXd4xEKytH5c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753398813;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=7WbypAsGzahsapPp7xQ+wrpUDPFjbToobgw0emJ/Uh0=;
	b=GCfOorPLfvxPBlXdRlkZIAIP+WniIjzJfghV7NedxL6/w1N/hLkhR6rLWs2AKytP
	oQORm30pGWwULQJ1+jh9YpWmwIuk/svILXJnvm8uMcx0KhstBhsGkZX42QfFlPNj1tz
	pICfiA7qVpB5ybSyRkCUQzZ+ndmpVgqwtF95OY6U=
Received: by mx.zohomail.com with SMTPS id 1753398810537411.2389352606622;
	Thu, 24 Jul 2025 16:13:30 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] Partially revert "rust: drm: gem: Implement
 AlwaysRefCounted for all gem objects automatically"
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <DBKN0VSJH3TX.2FYLW17KL0SWW@kernel.org>
Date: Thu, 24 Jul 2025 20:13:13 -0300
Cc: Lyude Paul <lyude@redhat.com>,
 nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Asahi Lina <lina+kernel@asahilina.net>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E9028A26-2E47-4431-B4B4-C5B416EB36E2@collabora.com>
References: <20250724191523.561314-1-lyude@redhat.com>
 <DBKJYLF9E3TY.IM6UZFA0BW9I@kernel.org>
 <e7a4cb0cc55a2d19e6eb9bf5280c68c0dd04d61d.camel@redhat.com>
 <DBKN0VSJH3TX.2FYLW17KL0SWW@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 24 Jul 2025, at 19:27, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> On Thu Jul 24, 2025 at 11:06 PM CEST, Lyude Paul wrote:
>> On Thu, 2025-07-24 at 22:03 +0200, Danilo Krummrich wrote:
>>> On Thu Jul 24, 2025 at 9:15 PM CEST, Lyude Paul wrote:
>>>> -// SAFETY: All gem objects are refcounted.
>>>> -unsafe impl<T: IntoGEMObject> AlwaysRefCounted for T {
>>>> -    fn inc_ref(&self) {
>>>> -        // SAFETY: The existence of a shared reference guarantees =
that the refcount is non-zero.
>>>> -        unsafe { bindings::drm_gem_object_get(self.as_raw()) };
>>>> -    }
>>>> -
>>>> -    unsafe fn dec_ref(obj: NonNull<Self>) {
>>>> -        // SAFETY: We either hold the only refcount on `obj`, or =
one of many - meaning that no one
>>>> -        // else could possibly hold a mutable reference to `obj` =
and thus this immutable reference
>>>> -        // is safe.
>>>> -        let obj =3D unsafe { obj.as_ref() }.as_raw();
>>>> -
>>>> -        // SAFETY:
>>>> -        // - The safety requirements guarantee that the refcount =
is non-zero.
>>>> -        // - We hold no references to `obj` now, making it safe =
for us to potentially deallocate it.
>>>> -        unsafe { bindings::drm_gem_object_put(obj) };
>>>> -    }
>>>> -}
>>>=20
>>> IIUC, you'll add rust/kernel/drm/gem/shmem.rs with a new type =
shmem::Object that
>>> implements IntoGEMObject, right?
>>>=20
>>> If this is correct, I think that should work.
>>=20
>> Do you mean you think the blanket implementation that we had would =
work, or
>> that getting rid of it would work?
>=20
> The former.
>=20
>> Since the blanket implementation we have
>> definitely doesn't compile on my machine once we add more then one
>> IntoGEMObject impl. (before adding it, it works just fine)
>=20
> Do you have a branch somewhere, where it doesn't compile?

Hi Lyude, I=E2=80=99m somewhat surprised to be honest. Your gem-shmem =
code works on
tyr-next, which is currently on top of 6.16-rc2. What exactly doesn=E2=80=99=
t
compile?

[0] =
https://gitlab.freedesktop.org/panfrost/linux/-/tree/tyr-next?ref_type=3Dh=
eads




