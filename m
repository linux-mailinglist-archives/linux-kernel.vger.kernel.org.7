Return-Path: <linux-kernel+bounces-729923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47485B03DB2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9185417A0EA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842DD246BD8;
	Mon, 14 Jul 2025 11:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c8TbDo2l"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59612242D98
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 11:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752493877; cv=none; b=kClnChvxu5uM4186qwpTClqX0kQxnK+xYNIiSULokRrYmhK053M7oP+FHZZPAbtepMM6oEOyUo5/nIXwvsfDpMBhdZqM2yqrCjPkCqq5utqJkoyPvXY4SnaNuGNi68VX4+QsVXiobEwEBFi+qgfjMkHkEx8UIxfomVxcNju4TUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752493877; c=relaxed/simple;
	bh=1fOsxm8KmM+d67Cn3Rpd/LbmTkIxTdxW+gtVkoYk/EM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A86WoQsMPJ2pKwuPeF8SMX74DjrJtxhaziNZ8e+H9FMY/Ru9l7vvZsRQObrj2S/wK9uiV+GAKkftlJrP4Oig4igijDYFRAxApS5PO2e1LK3flaj/vMRXUHDVpe7eztt3gHE4iO4ebrqoRb5LaZC/4ou6LBVY2OOKVT2AR+fetlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c8TbDo2l; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-455ea9cb0beso21822825e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 04:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752493874; x=1753098674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NO40oCgQSCqkHXjzs0s5Ot/ig0QEzwHdR9AJ2G+vIrQ=;
        b=c8TbDo2laNPCLHRuD64xsmF0pIAJLUJGwrbOO1jr+qvgB3+JHf4XCXq5VzS3G2yYcn
         FJChxJ0DypWrydJRVjhGuxCGDMJpJ4wrssa2OIUmRDypOEkIenLaVG4rlLPVsVxtQJ2P
         PcMgPLfL+++oWGAdN0pv2uv0dYFAJcUWIse5OaWsVMq9/IZFzS/Rib+CKXrIXglVWHZ2
         xd7t+FXds/6tH6O2Da+J6OHtV7OcTAyk0Q1QjmZIVuSLJDk84L6fncSpzyf9NKz3/0wZ
         eoBWGSEVfEiR8CTf+PYUXhkaFezYg5Cm/UDpCbJoCBeSD99TV+B6rKRp1+mOBzCNO9xO
         ClDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752493874; x=1753098674;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NO40oCgQSCqkHXjzs0s5Ot/ig0QEzwHdR9AJ2G+vIrQ=;
        b=ouc+nkjj9tkIvBCEx7eAALvjlocSxvXLuESUTk/RpPDjKaWqftug/mM+MBvqFoRcax
         uXYu/gpZFFITgLxbI43lKxdtZ3FJO97efkAiTBncxU3Bp42mhQGHmiw6SZMwR5K0au8H
         rBM4Vi7YlEzoK3DQEHwhc6ikaNWXPEinTGOgeI5rbpyuVZvLMgAGKRZY84S09izx2fQK
         9NIGGpu6XzZmwV2xRi76vrghgGOYwYqjRRMKHXJg8OOXFySPiitL3TiLnvq52j0g7eKM
         wFy75ZuodjbKOq9kpRRV3c6ro2pl3THtamJ8w32Cw8f3a80rqujetyy6HPuaO1FP9sGB
         k1Yg==
X-Forwarded-Encrypted: i=1; AJvYcCU5T7blx5MbqRaVh50thQQLr+LxfhzoNk45qghhRp4IkdXPW/nNXOeV6p3khXbEKvoyZNWnhOGa7vwCp7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+jbqtnT+lm94gzPuV3L/nIeO1zAleydckVzGiKN//JSzCDOZO
	pmjsGkKe+ThEzaMILVEZnvvdVFmmww5/dKw19iGH96lbKK3XrKov6/MKQ+sK00reP1hH5C29xOJ
	a6JU/KWTwi6viqN3xMQ==
X-Google-Smtp-Source: AGHT+IEC1AXUVxbsXuFfTt+kmPJ2lYfWegg79vPCpBaWdc+ofzAvJ1LZKa5QpJGV+AetC0pRA+Pf3Rt8j/eWnog=
X-Received: from wmbel18.prod.google.com ([2002:a05:600c:3e12:b0:456:1194:a7e7])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:314e:b0:456:1204:e7ec with SMTP id 5b1f17b1804b1-4561204e9d5mr60923015e9.10.1752493873725;
 Mon, 14 Jul 2025 04:51:13 -0700 (PDT)
Date: Mon, 14 Jul 2025 11:51:12 +0000
In-Reply-To: <7A0457FA-0E09-451E-B035-E739AED7B2C7@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250704-topics-tyr-platform_iomem-v12-0-1d3d4bd8207d@collabora.com>
 <20250704-topics-tyr-platform_iomem-v12-2-1d3d4bd8207d@collabora.com>
 <aGt7aItuSINDzj2O@google.com> <7A0457FA-0E09-451E-B035-E739AED7B2C7@collabora.com>
Message-ID: <aHTvMNIenbaGtBBt@google.com>
Subject: Re: [PATCH v12 2/3] rust: io: mem: add a generic iomem abstraction
From: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	"Ilpo =?utf-8?B?SsOkcnZpbmVu?=" <ilpo.jarvinen@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Ying Huang <huang.ying.caritas@gmail.com>, 
	Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 10:58:13AM -0300, Daniel Almeida wrote:
> Hi Alice,
>=20
> >> +impl<const SIZE: usize> IoMem<SIZE> {
> >> +    fn ioremap(resource: &Resource) -> Result<Self> {
> >> +        let size =3D resource.size();
> >> +        if size =3D=3D 0 {
> >> +            return Err(EINVAL);
> >> +        }
> >> +
> >> +        let res_start =3D resource.start();
> >> +
> >> +        let addr =3D if resource
> >> +            .flags()
> >> +            .contains(io::resource::flags::IORESOURCE_MEM_NONPOSTED)
> >> +        {
> >> +            // SAFETY:
> >> +            // - `res_start` and `size` are read from a presumably va=
lid `struct resource`.
> >> +            // - `size` is known not to be zero at this point.
> >> +            unsafe { bindings::ioremap_np(res_start, size as usize) }
> >=20
> > Here you cast from ResourceSize to usize. Are you sure that is correct?
> > I thought those types could be different.
>=20
> This seems to what C is doing as well, i.e.:
>=20
> static void __iomem *__devm_ioremap(struct device *dev, resource_size_t o=
ffset,
> 				    resource_size_t size, <---------
> 				    enum devm_ioremap_type type)
> {
>=20
>         [=E2=80=A6]
>=20
> 	case DEVM_IOREMAP_NP:
> 		addr =3D ioremap_np(offset, size);
> 		break;
> 	}
>=20
>=20
> Where:
>=20
> `static inline void __iomem *ioremap_np(phys_addr_t offset, size_t size)`
>=20
> IOW: this stems from the mix and match of types used the C API itself.
>=20
> What do you suggest here? Maybe a try_into() then?

What a mess. It looks like there aren't any 32-bit architectures that
define ioremap_np. This means that sometimes this cast will be lossy,
but in those cases the function body just returns NULL and doesn't read
the size.

I would probably cast to an underscore instead of explicitly mentioning
the target type and make a comment about it.

Alice

