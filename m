Return-Path: <linux-kernel+bounces-725844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF81B0049A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3976B3A8CBA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60914270ECD;
	Thu, 10 Jul 2025 13:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="HOgvtAcd"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BED21CC56;
	Thu, 10 Jul 2025 13:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752155936; cv=pass; b=Au6GBcU+efn5ZSmzp59TqwmCv9pgRQSUAOGXPGwwaNNWIoGveMrTRYQLVFto+EbuzfcuwXbX3CqazTw4lfykzgFvp9JJKfQihQBZ1RAF+U8qfBn+M6RikVd7XzDc4rrdqep5fODM4Aa0km/1TeUI6KsLGgh5grIXoc4B7USmAeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752155936; c=relaxed/simple;
	bh=HdrI6efyVPhh2NJvzv4tyvurxsN7yjqMq9UqQlJ8e1w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=d7G+i8MABu5titkoEAaOjGbd7xmM7hT/6toc17EQhQMZ9gl2JC88U+KnbEH/LIfHGunOQwGhy9BQkNKQs3Dc9G5UtXjs0uzvPTUPbd3LBbXxvgCvqWsGtBGE/aF30F09IGZShcWK0NxeYYLtmIj1X4MZJLpAXBYrbiLQBehe1aU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=HOgvtAcd; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752155914; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=d/8rzBVAoHUSePNYWX9lmMfFEu51A5yD27m3AV1gKlqwTTSwiHhG8pTtpTYMTtfaZanYD25CI6fI6JNJBgZhctAsi6yTrwQHQl/Sc2wDaoEXDxZyrTcjpqpFUADzDFKOaS9TuGtR0uj8XodKBX7NTEuNl4tMfjYMJ/YfJIzycRg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752155914; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=q9EjT3z3QHP4xBMhZO9J3DxICN6HoT8p4vySMMhre8A=; 
	b=Ko2l41HErGF7s9+dggj/ULb9j45tPy5CcRG0NXwbKUnn6ka1ZGMTSNJworD9RrcnSCU0w9aSGAllcBqOpCEUONTRvJW04z/F9wbTNRcA9ze+gVSfsn7UBW0o738rILX38QLknsgFUZhpz8GLddkAVCDB9ppsPbL9IPXVFE3Q2NI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752155914;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=q9EjT3z3QHP4xBMhZO9J3DxICN6HoT8p4vySMMhre8A=;
	b=HOgvtAcd1BvOqo1tEgkt/PnMb4LxG87m61UVzxY/TchDkjU9Jj0TVB1yDbmZ+yvS
	G9QW0OJ9stGG9l815LMBkh/rKq9rvrAseIIl7+Ktwpr6vj79eqNjGka7TSgf/6eaO/K
	BjxbOruZmcerV6YTVRU6jlMV6MDzT1KCBaJ+Gk+c=
Received: by mx.zohomail.com with SMTPS id 1752155910731251.0395675919459;
	Thu, 10 Jul 2025 06:58:30 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v12 2/3] rust: io: mem: add a generic iomem abstraction
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <aGt7aItuSINDzj2O@google.com>
Date: Thu, 10 Jul 2025 10:58:13 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Ying Huang <huang.ying.caritas@gmail.com>,
 Benno Lossin <lossin@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7A0457FA-0E09-451E-B035-E739AED7B2C7@collabora.com>
References: <20250704-topics-tyr-platform_iomem-v12-0-1d3d4bd8207d@collabora.com>
 <20250704-topics-tyr-platform_iomem-v12-2-1d3d4bd8207d@collabora.com>
 <aGt7aItuSINDzj2O@google.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Alice,

>> +impl<const SIZE: usize> IoMem<SIZE> {
>> +    fn ioremap(resource: &Resource) -> Result<Self> {
>> +        let size =3D resource.size();
>> +        if size =3D=3D 0 {
>> +            return Err(EINVAL);
>> +        }
>> +
>> +        let res_start =3D resource.start();
>> +
>> +        let addr =3D if resource
>> +            .flags()
>> +            .contains(io::resource::flags::IORESOURCE_MEM_NONPOSTED)
>> +        {
>> +            // SAFETY:
>> +            // - `res_start` and `size` are read from a presumably =
valid `struct resource`.
>> +            // - `size` is known not to be zero at this point.
>> +            unsafe { bindings::ioremap_np(res_start, size as usize) =
}
>=20
> Here you cast from ResourceSize to usize. Are you sure that is =
correct?
> I thought those types could be different.

This seems to what C is doing as well, i.e.:

static void __iomem *__devm_ioremap(struct device *dev, resource_size_t =
offset,
				    resource_size_t size, <---------
				    enum devm_ioremap_type type)
{

        [=E2=80=A6]

	case DEVM_IOREMAP_NP:
		addr =3D ioremap_np(offset, size);
		break;
	}


Where:

`static inline void __iomem *ioremap_np(phys_addr_t offset, size_t =
size)`

IOW: this stems from the mix and match of types used the C API itself.

What do you suggest here? Maybe a try_into() then?

=E2=80=94 Daniel


