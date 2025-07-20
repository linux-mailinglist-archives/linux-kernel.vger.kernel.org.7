Return-Path: <linux-kernel+bounces-738286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3693B0B6C7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 17:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C14DE3A2E1C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 15:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5721F1306;
	Sun, 20 Jul 2025 15:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="HR1U3IRx"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD8A33EC;
	Sun, 20 Jul 2025 15:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753026393; cv=pass; b=nJBzEaFeK1XGCYtvQkE4ix6OFMhhpBSKOLmgZn3LqwLLJMzxKCL6oIMBkG0U8uek+p7wzTqS7l2D8pdSjiLh76BSv4vIEZpFzbtaIuP3UJaW1/1ZQzWfHjTxDbIhdtsma7WYaLWmCVzgkaENz1SiFRtzKW1gtRgReUNh8gXCZHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753026393; c=relaxed/simple;
	bh=SWrdQ75/W3pdI1BG0oYfX92cV84Xc6bVcxLpW8kUZEs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VLAUi+omngXKmLKvsEKMnEd82+AkGkADZSrHFQEn+P26SezB/O5PpA0nE/MO24LZQcn8whDsHnIvTEWaJlNr57fc2XpXwMh9Tcnq9gDSbV9mcpZjHlAkJfqolWdlo36x52Gbiw0PZ2M+2DTzCqlMb6D/xbV5rP61eZSb9u4rJxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=HR1U3IRx; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753026376; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GLBfcEeJGoXGMdN9u6VcG2NeTnCtZdrBFTBJOzhmy9iefzJuQw/1Egd70Z/IrFud9jbpAClMX/NU4JHkrXAKgHSP1WDMozIDlWRJ5hy5mFDggenxiWKLqx8ltGEmi25GtqlVFKEBXZyyw3XpFQe2iWzPVgZBXtIqL/qxT/nOPGE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753026376; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1y2hcgr9LDGf6qQClQBmzWZPkkht65KCRDW2/a9pYp4=; 
	b=k2y6Ar6WiiHr8tG0HSpqF5eK2SQssulp0Mf12zAoizbBwgcU662bxicsP862zzexyHXR+oruNHiOCO7b1pUmjnGD3St4CXU86tB7dJq9UbezOYuN3bpEpYFKcDSidFWHR2N3jELLPg6daa1HPTrdARVZLMdo2kQ8Lq6dSGasx4U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753026376;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=1y2hcgr9LDGf6qQClQBmzWZPkkht65KCRDW2/a9pYp4=;
	b=HR1U3IRxjEUXeho7fN9BbVIM/Q/HymA4AFb5OW7bkyQMRCaxkhvixTeGYyBOOtKG
	vmFYgNRswBJWLEFTW1Ym1DYWuURwUC1Olkfh4IX2y/xa3TYxXIE5vWofrnc32MRYRMk
	xuxL4lCyLJSWlja/CvPU4IbpwlZ5xx8NDkz6m178=
Received: by mx.zohomail.com with SMTPS id 1753026374391872.1369164322014;
	Sun, 20 Jul 2025 08:46:14 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH 1/3] device: rust: documentation for DeviceContext
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <DBF8TZJ2SFLR.1I57R8BX2A9ZN@kernel.org>
Date: Sun, 20 Jul 2025 12:45:58 -0300
Cc: gregkh@linuxfoundation.org,
 rafael@kernel.org,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 boqun.feng@gmail.com,
 gary@garyguo.net,
 bjorn3_gh@protonmail.com,
 lossin@kernel.org,
 a.hindborg@kernel.org,
 aliceryhl@google.com,
 tmgross@umich.edu,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1551F811-1574-4F62-9A18-781A8A2E2D9E@collabora.com>
References: <20250717224806.54763-1-dakr@kernel.org>
 <20250717224806.54763-2-dakr@kernel.org>
 <664AA6FF-4EFD-49FD-91A6-4D66B8614529@collabora.com>
 <DBF8TZJ2SFLR.1I57R8BX2A9ZN@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Danilo,


[=E2=80=A6]

>>> unsafe impl Sync for Device {}
>>>=20
>>> -/// Marker trait for the context of a bus specific device.
>>> +/// Marker trait for the context or scope of a bus specific device.
>>> ///
>>> -/// Some functions of a bus specific device should only be called =
from a certain context, i.e. bus
>>> -/// callbacks, such as `probe()`.
>>> +/// [`DeviceContext`] is a marker trait for structures representing =
the context of a bus specific
>>> +/// [`Device`].
>>> ///
>>> -/// This is the marker trait for structures representing the =
context of a bus specific device.
>>> +/// The specific device context types are: [`CoreInternal`], =
[`Core`], [`Bound`] and [`Normal`].
>>> +///
>>> +/// [`DeviceContext`] types are hierarchical, which means that =
there is a strict hierarchy that
>>> +/// defines which [`DeviceContext`] type can be derived from =
another. For instance, any
>>> +/// [`Device<Core>`] can dereference to a [`Device<Bound>`].
>>> +///
>>> +/// The following enunumeration illustrates the dereference =
hierarchy of [`DeviceContext`] types.
>>> +///
>>> +/// - [`CoreInternal`] =3D> [`Core`] =3D> [`Bound`] =3D> [`Normal`]
>>> +/// - [`Core`] =3D> [`Bound`] =3D> [`Normal`]
>>> +/// - [`Bound`] =3D> [`Normal`]
>>> +/// - [`Normal`]
>>> +///
>>> +/// Bus devices can automatically implement the dereference =
hierarchy by using
>>> +/// =
[`impl_device_context_deref`](kernel::impl_device_context_deref).
>>> pub trait DeviceContext: private::Sealed {}
>>=20
>> Overall this looks good to me. I think that one point you could =
perhaps
>> consider is that, to me at least, it wasn't clear that the contexts =
were only
>> valid for a given scope. Or what was precisely meant by =E2=80=9Cscope=E2=
=80=9D.
>=20
> Scope really means scope in the sense of programming languages, which =
is why I
> didn't define it more specifically.
>=20
> So, a reference to a Device<Bound> (i.e. &Device<Bound>) indicates =
that the
> device is guaranteed to be bound for the scope the reference is valid =
in.


Maybe this is the piece of information that I missed, i.e.: that scope =
was
being used in the usual sense in a programming language, and that the =
term
wasn't being borrowed to describe some other sort of device behavior. =
This
might look obvious now, but wasn't when I saw it the first time.

Anyway, this is starting to look like I was the only one to get =
confused, so
scratch what I said :)

Also, looking at this patch again, it looks like you already explain =
this well
enough, for example in the docs for Device<Core>, where "reference's =
scope" is
mentioned:

/// The core context indicates that the [`Device<Core>`] reference's =
scope is limited to the bus
/// callback it appears in.=20

[=E2=80=A6]

>=20
>>>=20
>>>> Fine, but can=E2=80=99t you get a &Device<Bound> from a =
ARef<drm::Device>, for example?
>>>> Perhaps a nicer solution would be to offer this capability instead?
>>>=20
>>> I think you're confusing quite some things here.
>>>=20
>>>  [...]
>>>=20
>>>  (2) Owning a reference count of a device (i.e. ARef<Device>) does =
*not*
>>>      guarantee that the device is bound. You can own a reference =
count to the
>>>      device object way beyond it being bound. Instead, the guarantee =
comes from
>>>      the scope.
>>>=20

I wonder if it would be helpful to specifically state this in the docs =
somehow?
Perhaps as an extra "Note that ...". It doesn't hurt to repeat ourselves =
a bit
here, IMHO.

=E2=80=94 Daniel




