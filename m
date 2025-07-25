Return-Path: <linux-kernel+bounces-746063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B81E4B122AD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3B1417B6DF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD6A2EF673;
	Fri, 25 Jul 2025 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="YPemz9Vl"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4544922F16E;
	Fri, 25 Jul 2025 17:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753463212; cv=pass; b=kDsac8VAuiguNOGYwPu2/BAXY/osXsl6DFR16csvRy1oGHB4qFZ/ksLEQiWZ9ybqoKMa3T112SVd5rD/7B2t4H1gXejTWWLMFparxsdBKTfyAX0r3sNKIumoYjq9qwFLKfa1FVlgZESWoVuJtdZdbYLx+7UtBfxLtFcTa1CjQbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753463212; c=relaxed/simple;
	bh=FoIWiFy1jEZ60VFWVpAERgtxLQIVgrT4B31KGNpqvjw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=k+rkcHOQ85annJady4SBJMy8zs+ol4sIhTjPNwTzuXOpAiwmPfjTjvcnRS1/o2GNx04UKRHb2oQMW7fFSPudWdYvJe3q5nbt32W0KLw1CAjJC8TUA1bpmYxVJ3SXOBzOGD0Tnf69qnC1597VUNmocZXbttTKuZBOU7W22AKb98s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=YPemz9Vl; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753463195; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LIed8KIRFEltgk/rFESIgvCFrQmocPYrKhRFam/U6iKdKfxAaAogQax24ewN6Nqctfig9lQHv6hwQXYlsxHRuSmZKL8CIwZl3xf/Tk9d3M+VFofF/4kABY9jQ8YljBND9KQWiyTQTjxLzE3LZ290u9OAmoQMeCwO1EJcBGPW2Dg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753463195; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=I3p0cmlDXTJ40vRzTy/x/1iLH5ttLbUdq/BrX3qem8g=; 
	b=Zql/xrrcoFiCl3NhU1H24McywT52cW7qVK3J+m9ZWura+oOg+eoTWPpf2yA0lh9rdmKeaXH17bFVWMIAzAKpg8ZwPPBPbX50v91Y2LY/4Iu8jCHrPNwecgAsjQIPEs+bgcGChV8nkeVKM5HPs0SYZrHcI1EKndi5UA+E50X0Dlw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753463195;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=I3p0cmlDXTJ40vRzTy/x/1iLH5ttLbUdq/BrX3qem8g=;
	b=YPemz9Vl2JL31QtuKFZ0GSiYA9Mk1s1so9egr+nJ8iWCUcYLnKhkgj9YBXb0PzxJ
	VfsCv9+fNRTCfIrrv+0Ng+7GRGfFpnA+tVq+pLsnCKzEgi7POSxKMQLsb4FzDG5y8ye
	qUiL2saYhxLlrJZImSvyrhLfOwhF+jBeMC+/smBE=
Received: by mx.zohomail.com with SMTPS id 1753463193434517.7493357147465;
	Fri, 25 Jul 2025 10:06:33 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v2 09/19] gpu: nova-core: register: add missing
 doccomments for fixed registers I/O accessors
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250718-nova-regs-v2-9-7b6a762aa1cd@nvidia.com>
Date: Fri, 25 Jul 2025 14:06:19 -0300
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
Message-Id: <C0299B00-B2E9-44F7-8527-D6C03D95786E@collabora.com>
References: <20250718-nova-regs-v2-0-7b6a762aa1cd@nvidia.com>
 <20250718-nova-regs-v2-9-7b6a762aa1cd@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 18 Jul 2025, at 04:26, Alexandre Courbot <acourbot@nvidia.com> =
wrote:
>=20
> Add the missing doccomments for these accessors, as having a bit of
> inline documentation is always helpful.
>=20
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> drivers/gpu/nova-core/regs/macros.rs | 4 ++++
> 1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/gpu/nova-core/regs/macros.rs =
b/drivers/gpu/nova-core/regs/macros.rs
> index =
32fbd7e7deb9edeed91972a373a5a6ac7ce9db53..0a18a0d76b2265d3138f93ffc7c561b9=
4bca3187 100644
> --- a/drivers/gpu/nova-core/regs/macros.rs
> +++ b/drivers/gpu/nova-core/regs/macros.rs
> @@ -300,6 +300,7 @@ pub(crate) fn [<set_ $field>](mut self, value: =
$to_type) -> Self {
>         impl $name {
>             pub(crate) const OFFSET: usize =3D $offset;
>=20
> +            /// Read the register from its address in `io`.
>             #[inline]
>             pub(crate) fn read<const SIZE: usize, T>(io: &T) -> Self =
where
>                 T: ::core::ops::Deref<Target =3D =
::kernel::io::Io<SIZE>>,
> @@ -307,6 +308,7 @@ pub(crate) fn read<const SIZE: usize, T>(io: &T) =
-> Self where
>                 Self(io.read32($offset))
>             }
>=20
> +            /// Write the value contained in `self` to the register =
address in `io`.
>             #[inline]
>             pub(crate) fn write<const SIZE: usize, T>(self, io: &T) =
where
>                 T: ::core::ops::Deref<Target =3D =
::kernel::io::Io<SIZE>>,
> @@ -314,6 +316,8 @@ pub(crate) fn write<const SIZE: usize, T>(self, =
io: &T) where
>                 io.write32(self.0, $offset)
>             }
>=20
> +            /// Read the register from its address in `io` and run =
`f` on its value to obtain a new
> +            /// value to write back.

Ah, really neat!

>             #[inline]
>             pub(crate) fn alter<const SIZE: usize, T, F>(
>                 io: &T,
>=20
> --=20
> 2.50.1
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>


