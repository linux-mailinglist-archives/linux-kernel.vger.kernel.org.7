Return-Path: <linux-kernel+bounces-729968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C12B03E5F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B593AF763
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859D324BC09;
	Mon, 14 Jul 2025 12:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgYIuhCo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E202D8635C;
	Mon, 14 Jul 2025 12:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752494953; cv=none; b=fWfhl7D81BtQkTLMqatVCxhbsbuNaaRbxpaNaCkG5E8UEt4YWaxkhGdNwjlDUKo1ISKhky9uLUX9klCsr6QkmFh/3RMNhMNz4R9ygmatrfPIecl57B60io7bP0wHzivIw+zCbQmSJEyvjjt2jQdnccjg8H0HjXLQXADyPXkNx60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752494953; c=relaxed/simple;
	bh=790j4Ip2q5UeEyImLRL0KLjEyLZD54ZPHny1IERhf4w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=t+WnzDYx3soX4icI/FmKujBwx5zTP85f7Y0rLj9sgldMI2mXyo73CvgERE4Ph964M9f4Bhohg6c9htNsi7488CSDJN65IgETLlkML8HpJAqRk3oJUzIeyCQmRckwv59mtwXI5hNf3/hDmgUYrnC7kPts+u7EQXDJZ9w0m0ouQc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgYIuhCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB59C4CEF4;
	Mon, 14 Jul 2025 12:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752494952;
	bh=790j4Ip2q5UeEyImLRL0KLjEyLZD54ZPHny1IERhf4w=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=FgYIuhCot+kXZPqKZ3GZV+bptXq5GXUvlf9Z+F4wjculcls+xCDIvWMDz/iVblwiB
	 2q/i6YLV2qHQhBFGWipPSbBWuJO0GXetI1Qp8wdI597XT+lGrpEHsQ39UoX+OJjehq
	 RBSSMjXsxAvv+FQlRapvRCNaqwW14UOZyFskekdBplPv3FQsbmZzGxWWld+81/LQIF
	 82Qic6TA8SyTVmI3MUqDYRW0j+yu5I/O0zSfxwjYIoWil+0w1gXTkUMOmKi2xMz5CR
	 bpkcZHJeQkKRF3PG0YIjk+HyxvBAWW9nlJFHxpFrPxSxbk3d4io4xfUqurydNXhVBM
	 +7T1CyvHJPDsA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Jul 2025 14:09:06 +0200
Message-Id: <DBBRM08HB0UO.3HTRN04ZSHVQ8@kernel.org>
Subject: Re: [PATCH v12 2/3] rust: io: mem: add a generic iomem abstraction
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Mika Westerberg"
 <mika.westerberg@linux.intel.com>, "Ying Huang"
 <huang.ying.caritas@gmail.com>, "Benno Lossin" <lossin@kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250704-topics-tyr-platform_iomem-v12-0-1d3d4bd8207d@collabora.com> <20250704-topics-tyr-platform_iomem-v12-2-1d3d4bd8207d@collabora.com> <aGt7aItuSINDzj2O@google.com> <7A0457FA-0E09-451E-B035-E739AED7B2C7@collabora.com> <aHTvMNIenbaGtBBt@google.com>
In-Reply-To: <aHTvMNIenbaGtBBt@google.com>

On Mon Jul 14, 2025 at 1:51 PM CEST, Alice Ryhl wrote:
> On Thu, Jul 10, 2025 at 10:58:13AM -0300, Daniel Almeida wrote:
>> Hi Alice,
>>=20
>> >> +impl<const SIZE: usize> IoMem<SIZE> {
>> >> +    fn ioremap(resource: &Resource) -> Result<Self> {
>> >> +        let size =3D resource.size();
>> >> +        if size =3D=3D 0 {
>> >> +            return Err(EINVAL);
>> >> +        }
>> >> +
>> >> +        let res_start =3D resource.start();
>> >> +
>> >> +        let addr =3D if resource
>> >> +            .flags()
>> >> +            .contains(io::resource::flags::IORESOURCE_MEM_NONPOSTED)
>> >> +        {
>> >> +            // SAFETY:
>> >> +            // - `res_start` and `size` are read from a presumably v=
alid `struct resource`.
>> >> +            // - `size` is known not to be zero at this point.
>> >> +            unsafe { bindings::ioremap_np(res_start, size as usize) =
}
>> >=20
>> > Here you cast from ResourceSize to usize. Are you sure that is correct=
?
>> > I thought those types could be different.
>>=20
>> This seems to what C is doing as well, i.e.:
>>=20
>> static void __iomem *__devm_ioremap(struct device *dev, resource_size_t =
offset,
>> 				    resource_size_t size, <---------
>> 				    enum devm_ioremap_type type)
>> {
>>=20
>>         [=E2=80=A6]
>>=20
>> 	case DEVM_IOREMAP_NP:
>> 		addr =3D ioremap_np(offset, size);
>> 		break;
>> 	}
>>=20
>>=20
>> Where:
>>=20
>> `static inline void __iomem *ioremap_np(phys_addr_t offset, size_t size)=
`
>>=20
>> IOW: this stems from the mix and match of types used the C API itself.
>>=20
>> What do you suggest here? Maybe a try_into() then?
>
> What a mess.

Yeah, it mixes up types describing CPU word width and bus address width. :(

> It looks like there aren't any 32-bit architectures that
> define ioremap_np. This means that sometimes this cast will be lossy,
> but in those cases the function body just returns NULL and doesn't read
> the size.
>
> I would probably cast to an underscore instead of explicitly mentioning
> the target type and make a comment about it.

I think fixing up the C side would be even nicer, but for the scope of this
series that's fine. The comment should mention that, ultimately, we want to=
 fix
up the C side type wise.

