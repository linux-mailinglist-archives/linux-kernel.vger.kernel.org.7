Return-Path: <linux-kernel+bounces-733983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A64B6B07B93
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D75D3BE212
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C7D2F5C2A;
	Wed, 16 Jul 2025 16:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="N2lfx/QT"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0111DE4E5;
	Wed, 16 Jul 2025 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752684797; cv=pass; b=Bn4+/vwbt4jF7mBQ8YvvApS9L8jSYjI+Bkh4+f8em++vgDKT/czXs3JygDkGnYlPEbgpQTRhZ9x6jh27qsoxIoJlzXnOkST7SJpzjAhytOTSD448GApGpm23hZVxy/0Z5nwbHExWdmZLTUql2DcdRQbp2+2d5Iw2TGRWxFwjHBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752684797; c=relaxed/simple;
	bh=bSWd8eHKxi4VT9Mcqje/lIGYRiX8TbuMY1ga068r4zg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SuXsgrTtYo68ftcKmdq+4z20r6BJQlNeTWufY1CzQatUm2WIWk+lqCiGbY0097an8zedLw+4zK31927BeMg9Jdg4nYKaIUlw5caVDdFl+Oe7s556xWeQcipcV/fNTNCqArovWH0hBtpCFARHDFs9YSg71qjW9TTCOhixf+I/W9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=N2lfx/QT; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752684777; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=L03g1rghm9mFWCGBX6tloaYzP3noDS3GoU+vqraKSjSmrW6VUc/mlvrm6gG3Oxjmqp8/FclbT3vHrAv85d1a0YeP5HC1P/CQ9oKmpu2tK69/MwNsW8YAkU/SW4gdC6BdxOkysjzF6Rom0gJI1T6vz94KCvxSLCQScGdPS6jshzY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752684777; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zUd9zcDoZlqwIzWUGICXBQwCfCHj88+1mMQYGh+G6qM=; 
	b=R1l7HMQXBrxzZBlUg8rY4ZVFYADVE4gOnICgy2t3and1vHclVXbv/+9TmVp6gL0ZNEICNNHQf103Go07ZKA14rkIw7bBaMkcghYT7Cz6wgtNL/PqBm9vRMo7AecvN5NVi72OCknMf9lPrOAScFVugGUtZui//tuXcP51MNCreIY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752684777;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=zUd9zcDoZlqwIzWUGICXBQwCfCHj88+1mMQYGh+G6qM=;
	b=N2lfx/QTO5/Nw1YwbXtwkM7CR6g43LH2273tewruZvSoiX/9gyis0gLPoOeNV9+X
	/K/DteqYjKq8Bt0AIoKo6N5zCFr9dnqW6Ft20xnPO9X+KewPk0ixlq/gNFi1e6mAREF
	SkjmnxVCP3dLy/9PVAuj1irgO9WnwHIIdXgl+h8U=
Received: by mx.zohomail.com with SMTPS id 1752684774306661.8061332714378;
	Wed, 16 Jul 2025 09:52:54 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v13 1/3] rust: io: add resource abstraction
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <aHYLWc_KkMHj_jF-@google.com>
Date: Wed, 16 Jul 2025 13:52:36 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 Fiona Behrens <me@kloenk.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D9C5D4EC-FA24-47DB-BE89-609713F093FF@collabora.com>
References: <20250711-topics-tyr-platform_iomem-v13-0-06328b514db3@collabora.com>
 <20250711-topics-tyr-platform_iomem-v13-1-06328b514db3@collabora.com>
 <aHYLWc_KkMHj_jF-@google.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Alice,

>=20
>> +        let inner =3D self.0.get();
>> +        // SAFETY: safe as per the invariants of `Resource`.
>> +        unsafe { (*inner).start }
>> +    }
>> +
>> +    /// Returns the name of the resource.
>> +    pub fn name(&self) -> &'static CStr {
>> +        let inner =3D self.0.get();
>> +        // SAFETY: safe as per the invariants of `Resource`
>> +        unsafe { CStr::from_char_ptr((*inner).name) }
>=20
> This is 'static? I would like this safety comment to explicitly say =
that
> the string always lives forever no matter what resource you call this
> on.
>=20
> Alice
>=20

Actually, we have a bit of a problem here.

First, there appears to be no guarantee that a `Resource` has a valid =
name.

In fact:

#define DEFINE_RES_NAMED(_start, _size, _name, _flags) \
DEFINE_RES_NAMED_DESC(_start, _size, _name, _flags, IORES_DESC_NONE)
#define DEFINE_RES(_start, _size, _flags) \
DEFINE_RES_NAMED(_start, _size, NULL, _flags)

#define DEFINE_RES_IO_NAMED(_start, _size, _name) \
DEFINE_RES_NAMED((_start), (_size), (_name), IORESOURCE_IO)
#define DEFINE_RES_IO(_start, _size) \
DEFINE_RES_IO_NAMED((_start), (_size), NULL)

The non _NAMED version of these macros will assign a NULL pointer, so we =
can't
derive a CStr from that at all.

On top of that, although some call sites do use static names, i.e.:

struct resource ioport_resource =3D {
.name =3D "PCI IO",
.start =3D 0,
.end =3D IO_SPACE_LIMIT,
.flags =3D IORESOURCE_IO,
};
EXPORT_SYMBOL(ioport_resource);

struct resource iomem_resource =3D {
.name =3D "PCI mem",
.start =3D 0,
.end =3D -1,
.flags =3D IORESOURCE_MEM,
};
EXPORT_SYMBOL(iomem_resource);

static struct resource busn_resource =3D {
.name =3D "PCI busn",
.start =3D 0,
.end =3D 255,
.flags =3D IORESOURCE_BUS,
};

Some appear to use other, smaller lifetimes, like the one below:

struct pnp_resource *pnp_add_resource(struct pnp_dev *dev,
      struct resource *res)
{
struct pnp_resource *pnp_res;

pnp_res =3D pnp_new_resource(dev);
if (!pnp_res) {
dev_err(&dev->dev, "can't add resource %pR\n", res);
return NULL;
}

pnp_res->res =3D *res;
pnp_res->res.name =3D dev->name;


I guess the easiest solution is to drop 'static in order to account for =
the
above, and change the signature to return Option<&CStr> instead. =20

We can also change Region to own the name, and pass name by value here:

    pub fn request_region(
        &self,
        start: ResourceSize,
        size: ResourceSize,
        name: &'static CStr <------


Thoughts?

=E2=80=94 Daniel=

