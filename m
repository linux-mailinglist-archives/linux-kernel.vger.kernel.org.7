Return-Path: <linux-kernel+bounces-750753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B9EB160A0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1BEC3A7495
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806AA7E110;
	Wed, 30 Jul 2025 12:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="LPqXtAj1"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4951F39FCE;
	Wed, 30 Jul 2025 12:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753879698; cv=pass; b=DkeN3jXEkmUKZikOa7uKNTVvYpil6Jrn/ZFog0B+nOngoJ2000ycSgWICpxmS2VfW3mXX328IbxhmOlAulx0ImyBqeyW636IMnMkXLtd3S5EJGBRAUAl4yx7Rjntrbc8lybqnJlinVpLnXrVOM5IePTKIxjYWlO6Lcm45z2fxK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753879698; c=relaxed/simple;
	bh=LQJvyS0Ptxkc/4sz59cK6OA3QxtTyxr0Qv8/lmUBW4M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mb4a1SV6mhR5VBUDNkT/gXkvIimIyh63SIdKCEEJa1h4ZeUJye+F94eqbTLhKL69S1vLU4AtvIqBlSYQSo2u4KzrvJUH2rg3SxR12MARDWa56ZjacqeJ0q/VGX44mMU+r5LxQvSvPuLd6rtrO2Mcqsh+6+caINwrXuZxq3RRQYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=LPqXtAj1; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753879681; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EgwO8/clcXidq7f5NTIpU176mTfpMVWmEDxmWj7WeOtZdm/NsMUDB2/ZNU2d2aa3ZjvNBp6vVpg5lWbdwIHC+GEAcH/TBqZ0x3XgSF4xhb6THIm+PxXbWYcXbFRUujREoVUETHhAwHbqvsDiD5cD3d0RYqrWtrVLNzSEq8lppdE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753879681; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qCAvTtSpwv/bw10fNrHo7ZJSdHiHGn8ognmTiLYqv5c=; 
	b=FmKnqmnRVOZ+1fBoTHmkZiOjDr8ZZVdGCmuYmtaIK7IpL6j8dTtPmCsCwx0+IQmQWRpZX0ZsXdKOemmTQuGw1N3cGzb5vGuEkrGDDykflnVxH8crUP67YTmBhCHEJ/20+nMgz2744tPSu73LimhWhlpy1gOH3934gleto4pGGmc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753879681;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=qCAvTtSpwv/bw10fNrHo7ZJSdHiHGn8ognmTiLYqv5c=;
	b=LPqXtAj1Hq8kcKQOe+HKg8fp04yscpgn/dprQm29XC/UMsQoEAD/g57cA4xXPHX6
	G4Emvjg6u3GzaYnqZ/dtoV1hpx3XlcDmbnMSn6p1dwn/DKQic/yjcF9hEDrg6HcyqQv
	rjnL4czHLOpUTW2/V/zAB8fiThCkVELhpYZPm9Ag=
Received: by mx.zohomail.com with SMTPS id 1753879678687259.03361556399955;
	Wed, 30 Jul 2025 05:47:58 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v2 01/19] gpu: nova-core: register: minor grammar and
 spelling fixes
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <b1289f95-616f-4bb8-b408-222ce6925e21@arm.com>
Date: Wed, 30 Jul 2025 09:47:43 -0300
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Beata Michalska <beata.michalska@arm.com>,
 nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>,
 Nouveau <nouveau-bounces@lists.freedesktop.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DC0D1E12-75A9-4FFC-871C-05831FA67504@collabora.com>
References: <20250718-nova-regs-v2-0-7b6a762aa1cd@nvidia.com>
 <20250718-nova-regs-v2-1-7b6a762aa1cd@nvidia.com>
 <B1AA6359-7854-4284-B533-F5CA3C18AF34@collabora.com>
 <DBNF8SZWLI79.1NRX9AMW5QW45@nvidia.com>
 <d0ffb55b-690a-4a65-98b5-b83adebfd88b@arm.com>
 <DBNNTU14VH90.25AZCJSVT4JDR@nvidia.com>
 <ce8b4bd9-5122-4b85-b605-a1bf10556208@arm.com>
 <DBOL3HSE1OUW.22PGYP5T6164C@nvidia.com>
 <b1289f95-616f-4bb8-b408-222ce6925e21@arm.com>
To: Steven Price <steven.price@arm.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

[=E2=80=A6]

>>>=20
>>>> The idea of register blocks is interesting. I wonder how that would
>>>> translate in terms of access to invididual registers, i.e. does the
>>>> block end up just being a prefix into the full register name, or is =
it
>>>> something else? =46rom your example declaration I picture that =
accesses
>>>> would look something like `MMU_AS_CONTROL[4]::MEMATTR::read(bar)`, =
which
>>>> ngl looks great, but I also cannot think of a construct that would =
allow
>>>> such a syntax... Happy to think more about it though.
>>>=20
>>> Yes, that is the sort of syntax I was imagining, although I was =
hoping
>>> you could do something like:
>>>=20
>>>  let as =3D MMU_AS_CONTROL[as_id]::try_get(&bar)?;
>>>=20
>>>  let memattr =3D as.MEMATTR.read(&bar);
>>>  memattr.set_attr0(3).write(&bar);
>>>  as.TRANSTAB.write(&bar, 0x1000);
>>>=20
>>> Which I'm sure shows how little Rust I've written, but hopefully you =
get
>>> the idea - only the first line is a try_xxx which can fail and takes =
the
>>> address space ID from a variable and bounds checks it. The other
>>> accesses we already know the bounds so there's no need to deal with
>>> failure, and we don't have to consider the situation where MEMATTR =
is
>>> written but the TRANSTAB write fails (which couldn't actually happen
>>> with non-contiguous register arrays but the compiler wouldn't be =
able to
>>> tell).
>>=20
>> That for sure looks elegant. Now the question is how can we implement
>> something similar using only ZSTs? `MMU_AS_CONTROL` would have to be =
a
>> static array. Then `as` needs to be some sort of struct?
>>=20
>> The way this works looks very similar to what I suggested above with
>> register arrays and validating once that a given index is valid for =
the
>> register array accesses. Then the non-try accessors can be used, =
knowing
>> that the compiler will be able to infer that the index is valid. The
>> only drawback being that each `read` and `write` will have to carry =
the
>> `as_id`.
>=20
> Presumably it should be possible to implement with 'as' being a type
> which actually contains 'as_id' (as opposed to an actual ZST) so you
> don't need to explicitly pass that in. Otherwise there's a possibility
> of passing the wrong as_id in and so the compiler won't be able to =
infer
> that it must be valid.
>=20
>> This would work, but if someone wants to experiment to try and =
implement
>> something closer to the interface you proposed, I'm very open to the
>> idea. I wonder if we could do this without any runtime overhead...
>=20
> Since my Rust knowledge is very limited there might be a better way of
> doing this, but that this seemed like the most natural interface to =
me.
> I can see how a similar approach could be used in C with minimal/no
> overhead so I would have thought this is possible in Rust.

I hate macros with a passion, but I can try tackling this in the =
interest of
moving it forward :)

=E2=80=94 Daniel



