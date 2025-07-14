Return-Path: <linux-kernel+bounces-730922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF30EB04C78
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 01:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73FDE4A3910
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2E8279787;
	Mon, 14 Jul 2025 23:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="I6+2RY1g"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9061F3BAC;
	Mon, 14 Jul 2025 23:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752536395; cv=pass; b=tTPN9vWjHvq/FihJ2PFeLvGBbSORDLIzAlNH6i4tbVRkrrPJagcZHJ1plEyTpLSETWkY8ITzmxOesGHt/rg6Nq9wlPmmjgFWsK6KKSF3q/ptP4t3AsgWdN1tp7vWat5RnZOvDkmsIIXnW4HWCArQ/Dm6fBY5DsGHVINlD6E+0L4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752536395; c=relaxed/simple;
	bh=dvi9mKmPim4SejXM+DbPQ6POkLNWnNWVm/KSb1hLr+Q=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Guf+959IkCVjYw1Jxe9J8LgugzmnO0YZ919XO7+kkzAjR/Vz604IRFHWs76vNJTQTXPw69lJtj/bp2WZhcumDrZnvvneV5RYkfV8NyYexxtQAX7nMsELzwmZgysGUOpBb1ykZ8fdEdZ7ixiihrfvm2/YFq5wXnJucl5/CuMnJ+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=I6+2RY1g; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752536375; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FXTAvhhkLQAZEVzoPyR1+y3T+2P8Z31NnoHCJJWtc8oASm9ZfQT//6H+/38tP0Zh6OoevTqxgRuQO/WJEl+0PcfW9yvBsxsiB2/E07Pme6s5sYtXqVQpuG8GOVvLM5ls/266L3SixcjxD7AJIbE6ykwk2B8ULSpJs1NR+egqbck=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752536375; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kY/xppBaRcLOyIwmiqqLaKMA/JQNBE/a0JwDjzCDHD4=; 
	b=S/+Una3FcWde6W150Jepjkr/fj3oaVg7+G+L2Z9Hqs+lx+FGCJ5R2+F7ktHMQaI8FMCCtKalJv3zZQq9ch/ZJ5lJoydM3kiRTs5qovpqu2s9K/oUKHohypAWI/KIrVOcAB3q05ibZCPHdO/Rj69SSj/f120ZFkAdd+dJLGfOLfY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752536375;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=kY/xppBaRcLOyIwmiqqLaKMA/JQNBE/a0JwDjzCDHD4=;
	b=I6+2RY1g6TtBR0bdwf338H+ek2vq5dFjsV/FiqvQBXp2ZHc47z+t6zbjI8KZMCrY
	Sa26yxEtf1gl7PuUl3J82SA44t6+JRR3WyrcFcIZ1J8STLz24W9rYGLcgpMBL7UJWlT
	ZWYM8iYmOtgKjFG3DYZLqjiUDH8lCcvIQ4QpVMa0=
Received: by mx.zohomail.com with SMTPS id 175253637260735.75271672467579;
	Mon, 14 Jul 2025 16:39:32 -0700 (PDT)
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
In-Reply-To: <aHTvMNIenbaGtBBt@google.com>
Date: Mon, 14 Jul 2025 20:39:15 -0300
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
Message-Id: <72809F34-033A-4A72-B56D-519D1D089299@collabora.com>
References: <20250704-topics-tyr-platform_iomem-v12-0-1d3d4bd8207d@collabora.com>
 <20250704-topics-tyr-platform_iomem-v12-2-1d3d4bd8207d@collabora.com>
 <aGt7aItuSINDzj2O@google.com>
 <7A0457FA-0E09-451E-B035-E739AED7B2C7@collabora.com>
 <aHTvMNIenbaGtBBt@google.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Alice,

> On 14 Jul 2025, at 08:51, Alice Ryhl <aliceryhl@google.com> wrote:
>=20
> On Thu, Jul 10, 2025 at 10:58:13AM -0300, Daniel Almeida wrote:
>> Hi Alice,
>>=20
>>>> +impl<const SIZE: usize> IoMem<SIZE> {
>>>> +    fn ioremap(resource: &Resource) -> Result<Self> {
>>>> +        let size =3D resource.size();
>>>> +        if size =3D=3D 0 {
>>>> +            return Err(EINVAL);
>>>> +        }
>>>> +
>>>> +        let res_start =3D resource.start();
>>>> +
>>>> +        let addr =3D if resource
>>>> +            .flags()
>>>> +            =
.contains(io::resource::flags::IORESOURCE_MEM_NONPOSTED)
>>>> +        {
>>>> +            // SAFETY:
>>>> +            // - `res_start` and `size` are read from a presumably =
valid `struct resource`.
>>>> +            // - `size` is known not to be zero at this point.
>>>> +            unsafe { bindings::ioremap_np(res_start, size as =
usize) }
>>>=20
>>> Here you cast from ResourceSize to usize. Are you sure that is =
correct?
>>> I thought those types could be different.
>>=20
>> This seems to what C is doing as well, i.e.:
>>=20
>> static void __iomem *__devm_ioremap(struct device *dev, =
resource_size_t offset,
>>     resource_size_t size, <---------
>>     enum devm_ioremap_type type)
>> {
>>=20
>>        [=E2=80=A6]
>>=20
>> case DEVM_IOREMAP_NP:
>> addr =3D ioremap_np(offset, size);
>> break;
>> }
>>=20
>>=20
>> Where:
>>=20
>> `static inline void __iomem *ioremap_np(phys_addr_t offset, size_t =
size)`
>>=20
>> IOW: this stems from the mix and match of types used the C API =
itself.
>>=20
>> What do you suggest here? Maybe a try_into() then?
>=20
> What a mess. It looks like there aren't any 32-bit architectures that
> define ioremap_np. This means that sometimes this cast will be lossy,
> but in those cases the function body just returns NULL and doesn't =
read
> the size.
>=20
> I would probably cast to an underscore instead of explicitly =
mentioning
> the target type and make a comment about it.
>=20
> Alice

You replied here but v13 was already out [0]. Can we shift the dicussion
there? I ended up using try_into(), but feel free to suggest the cast to =
_
+ the TODO if you still feel like this is the right approach.


-- Daniel

[0] =
https://lore.kernel.org/rust-for-linux/20250711-topics-tyr-platform_iomem-=
v13-0-06328b514db3@collabora.com/


