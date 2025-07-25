Return-Path: <linux-kernel+bounces-746048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8EAB12266
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3F171766CF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73E02EF9AC;
	Fri, 25 Jul 2025 16:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="V7e/ysMA"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903791F462D;
	Fri, 25 Jul 2025 16:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753462588; cv=pass; b=B7sZQoeaXTbybD1PNGyuBXQrtiui55kXgVPyoouIrxrOgn1hLtrbtvBMIP8506hRSQvl7v22Ip1RJPUygWXYR+0yYgEXITgGIpr/A2ZIDBem7BuT3mhi/TymAY7pk9cNpIf6fb1n0yvzC3TMu6YYQQ95h7sN53728jsJ8/lLYF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753462588; c=relaxed/simple;
	bh=Yl5REK+UFglfXwTWSGdbbaWOcvRSrhLkBwdP9VaQ8qg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=m4mY0gDnW28YVvwia+AFn7XfogvhTG1jA/lWGUsuwWCCL3UbvG47tx/UdEMxbAJFTqICtuNgcv+F0XxPG8STz2HJj1oZp2QCLd9DUcgDuepXWCKnUeYRMqlVLSHsrHfivfK1GSBbRAh6wDsYJErQDasmxx3pqw1+EyNC/1ljeYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=V7e/ysMA; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753462574; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GI9Uhv9yTxL2FpFK2JwknLzb/fo/36nI9MuyZHKNwq+8u47D7qd1SEtxs8qvq4HG8uC5yrIP7Sl0RAlqEDq68hFuGdocvTGg12kslQDbD42mX0c9wwatuhnVKug5w2P+ypToxlUSXggDLJbSlCweF1xwpXhwNlr7L7hKUT+jFOk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753462574; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PxzxL3ZSC0HyOXFkj5rNMWwy6alHiEgxgh0twPtSxKs=; 
	b=fHG6XqQv6nRUz8HR5SKX6HBLGId/X4ADJoSeX3rbv3RwTcFTsUdKdmaF1gkBHuSm4bzhnSQOTt/1BfbOLDpFiQBAquVGAzxArkGLt+NAwi3jw7I/lnT72DwIQqAbEU3ObLEuNtc2gbxkokk+OpMRvPqT6nDKYxZ4vZ6uyS0AhPQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753462574;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=PxzxL3ZSC0HyOXFkj5rNMWwy6alHiEgxgh0twPtSxKs=;
	b=V7e/ysMARY/imbbcRo/AfCLlb+tnuDuTBnkZ4dFlTXyzznVQtbYUgH73ZxzmoN3I
	JPabOQX9jA5MA+9FawJyfW7V/g7VneagoeK6s57JVO17Biz7Z3soz2frDMdyWyaVrYx
	jKb9ZQzsEISRUclhuWMLJYklRDWQPzPPrw5hn63o=
Received: by mx.zohomail.com with SMTPS id 1753462572169347.0911108420123;
	Fri, 25 Jul 2025 09:56:12 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v2 06/19] gpu: nova-core: register: remove `try_`
 accessors for relative registers
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250718-nova-regs-v2-6-7b6a762aa1cd@nvidia.com>
Date: Fri, 25 Jul 2025 13:55:58 -0300
Cc: Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Beata Michalska <beata.michalska@arm.com>,
 nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CB6E0292-A9D6-4476-A343-2A4C6BC00945@collabora.com>
References: <20250718-nova-regs-v2-0-7b6a762aa1cd@nvidia.com>
 <20250718-nova-regs-v2-6-7b6a762aa1cd@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 18 Jul 2025, at 04:26, Alexandre Courbot <acourbot@nvidia.com> =
wrote:
>=20
> Relative registers are always accessed using a literal base, meaning
> their validity can always be checked at compile-time. Thus remove the
> `try_` accessors that have no purpose.
>=20
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> drivers/gpu/nova-core/regs/macros.rs | 38 =
+-----------------------------------
> 1 file changed, 1 insertion(+), 37 deletions(-)
>=20
> diff --git a/drivers/gpu/nova-core/regs/macros.rs =
b/drivers/gpu/nova-core/regs/macros.rs
> index =
37c7c454ba810447e1fe41231650e616e2f86eb8..742afd3ae1a3c798817bbf8159458890=
77ce10d0 100644
> --- a/drivers/gpu/nova-core/regs/macros.rs
> +++ b/drivers/gpu/nova-core/regs/macros.rs
> @@ -57,9 +57,7 @@
> /// definition, or the field getter and setter methods they are =
attached to.
> ///
> /// Putting a `+` before the address of the register makes it relative =
to a base: the `read` and
> -/// `write` methods take a `base` argument that is added to the =
specified address before access,
> -/// and `try_read` and `try_write` methods are also created, allowing =
access with offsets unknown
> -/// at compile-time:
> +/// `write` methods take a `base` argument that is added to the =
specified address before access:
> ///
> /// ```no_run
> /// register!(CPU_CTL @ +0x0000010, "CPU core control" {
> @@ -386,40 +384,6 @@ pub(crate) fn alter<const SIZE: usize, T, F>(
>                 let reg =3D f(Self::read(io, base));
>                 reg.write(io, base);
>             }
> -
> -            #[inline]
> -            pub(crate) fn try_read<const SIZE: usize, T>(
> -                io: &T,
> -                base: usize,
> -            ) -> ::kernel::error::Result<Self> where
> -                T: ::core::ops::Deref<Target =3D =
::kernel::io::Io<SIZE>>,
> -            {
> -                io.try_read32(base + $offset).map(Self)
> -            }
> -
> -            #[inline]
> -            pub(crate) fn try_write<const SIZE: usize, T>(
> -                self,
> -                io: &T,
> -                base: usize,
> -            ) -> ::kernel::error::Result<()> where
> -                T: ::core::ops::Deref<Target =3D =
::kernel::io::Io<SIZE>>,
> -            {
> -                io.try_write32(self.0, base + $offset)
> -            }
> -
> -            #[inline]
> -            pub(crate) fn try_alter<const SIZE: usize, T, F>(
> -                io: &T,
> -                base: usize,
> -                f: F,
> -            ) -> ::kernel::error::Result<()> where
> -                T: ::core::ops::Deref<Target =3D =
::kernel::io::Io<SIZE>>,
> -                F: ::core::ops::FnOnce(Self) -> Self,
> -            {
> -                let reg =3D f(Self::try_read(io, base)?);
> -                reg.try_write(io, base)
> -            }
>         }
>     };
> }
>=20
> --=20
> 2.50.1
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>


