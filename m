Return-Path: <linux-kernel+bounces-746056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F724B12276
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AAD71C275F8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DB52EE971;
	Fri, 25 Jul 2025 17:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="bu2GEaYD"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076E746B5;
	Fri, 25 Jul 2025 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753463026; cv=pass; b=o5IhFzGImzgbmRaauOBKKqk+OM0HlmDvRyiaPZHatNj32uUhLXsTmqheolYLtxZ9WKRw288au/JNfoA14XB2KOMEIr4f8UGb5khHQUHWm39thH3dYXG4tWVp+hUGGdL7H5DIHHHgp0ESCZPHzu3ycCfx5RuELsEBeWtSMoBGJyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753463026; c=relaxed/simple;
	bh=Ni6JoEEUx8OEFJ8DpHdNPqWVHqBH2tV9gAveqIzzvUw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=K/EqTEzOGazApM0bj9KmvxCJUA4aqnSXl1dPHYfz449hd/EdtgNS9cuT8BPcNp2OmlwN+J268GC4xmPX+g/IBKWcDeVjagbZhy0OYVHIxmGZxAeJpyji55xJGu/VrvQMjHFmaQhnQXynIQaiStzF4KOK/QLCh7h0/TcZienD3Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=bu2GEaYD; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753463008; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NO52SEf+/eMR0Dd5wDOQY3lSDtWoBF0SxDFmRLctIKeLMlEDN1Yptq+76zbhOYkBWpJrY9SCJWH71zFjo1M/X0hPp++ousmmEeykprL7FYBFGevYgqn/cp+LZXPJ9mMJafVzy5zKHEf/SDrwpo8rnX55v6B0TkvZLLb52xfV6jg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753463008; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aN04ZKphhrGWMee1OgqWXxu+3D/2PH0iBDNAixSHvzA=; 
	b=ZLGX6+QycshMRsLXlCXTLJm10X/Pw3K8fA5EYx5Q1zfTqtdFg3Z9Y9zmbqAh0o73uRRE9u4jvhpsE11k9tmBxjJXQN7fHmzJ2RIEGkHHDc9olVxmP19DAE02ilXH0DoimNLk710IbGI/P1o3Mq422X/rybaD36cG+C0bOp4vQC0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753463008;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=aN04ZKphhrGWMee1OgqWXxu+3D/2PH0iBDNAixSHvzA=;
	b=bu2GEaYDebo3q8VAWv8OTbb52RYbw0w7huY+bbL4qHJQbyhrYPGuPM5uruFBVZOc
	fEENk7Lv6QJ6wniFd5KK7bUYGy0GHH5YnglcJCzbdmf73nDuJvEw6eakX/azrUtmZSG
	84SUxXraT7iwXYhkBz4bj6nE37qexds7IaqQMld8=
Received: by mx.zohomail.com with SMTPS id 1753463004291786.0204238906209;
	Fri, 25 Jul 2025 10:03:24 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v2 07/19] gpu: nova-core: register: move OFFSET
 declaration to I/O impl block
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250718-nova-regs-v2-7-7b6a762aa1cd@nvidia.com>
Date: Fri, 25 Jul 2025 14:03:09 -0300
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
Message-Id: <856B6814-1782-4FB0-9DD1-BD46C8FE935C@collabora.com>
References: <20250718-nova-regs-v2-0-7b6a762aa1cd@nvidia.com>
 <20250718-nova-regs-v2-7-7b6a762aa1cd@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 18 Jul 2025, at 04:26, Alexandre Courbot <acourbot@nvidia.com> =
wrote:
>=20
> The OFFSET const is an I/O property, and having to pass it to the
> @common rule makes it impossible to make I/O optional, as we want to =
get
> to eventually.
>=20
> Thus, move OFFSET to the I/O impl block so it is not needed by the
> @common rule anymore.
>=20
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> drivers/gpu/nova-core/regs/macros.rs | 19 +++++++++----------
> 1 file changed, 9 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/gpu/nova-core/regs/macros.rs =
b/drivers/gpu/nova-core/regs/macros.rs
> index =
742afd3ae1a3c798817bbf815945889077ce10d0..4da897787c065e69657ce65327e3290a=
f403a615 100644
> --- a/drivers/gpu/nova-core/regs/macros.rs
> +++ b/drivers/gpu/nova-core/regs/macros.rs
> @@ -92,7 +92,7 @@ macro_rules! register {
>             $($fields:tt)*
>         }
>     ) =3D> {
> -        register!(@common $name @ $offset $(, $comment)?);
> +        register!(@common $name $(, $comment)?);
>         register!(@field_accessors $name { $($fields)* });
>         register!(@io $name @ $offset);
>     };
> @@ -103,7 +103,7 @@ macro_rules! register {
>             $($fields:tt)*
>         }
>     ) =3D> {
> -        register!(@common $name @ $alias::OFFSET $(, $comment)?);
> +        register!(@common $name $(, $comment)?);
>         register!(@field_accessors $name { $($fields)* });
>         register!(@io $name @ $alias::OFFSET);
>     };
> @@ -114,7 +114,7 @@ macro_rules! register {
>             $($fields:tt)*
>         }
>     ) =3D> {
> -        register!(@common $name @ $offset $(, $comment)?);
> +        register!(@common $name $(, $comment)?);
>         register!(@field_accessors $name { $($fields)* });
>         register!(@io $name @ + $offset);
>     };
> @@ -125,7 +125,7 @@ macro_rules! register {
>             $($fields:tt)*
>         }
>     ) =3D> {
> -        register!(@common $name @ $alias::OFFSET $(, $comment)?);
> +        register!(@common $name $(, $comment)?);
>         register!(@field_accessors $name { $($fields)* });
>         register!(@io $name @ + $alias::OFFSET);
>     };
> @@ -134,7 +134,7 @@ macro_rules! register {
>=20
>     // Defines the wrapper `$name` type, as well as its relevant =
implementations (`Debug`, `BitOr`,
>     // and conversion to regular `u32`).
> -    (@common $name:ident @ $offset:expr $(, $comment:literal)?) =3D> =
{
> +    (@common $name:ident $(, $comment:literal)?) =3D> {
>         $(
>         #[doc=3D$comment]
>         )?
> @@ -142,11 +142,6 @@ macro_rules! register {
>         #[derive(Clone, Copy, Default)]
>         pub(crate) struct $name(u32);
>=20
> -        #[allow(dead_code)]
> -        impl $name {
> -            pub(crate) const OFFSET: usize =3D $offset;
> -        }
> -
>         // TODO[REGA]: display the raw hex value, then the value of =
all the fields. This requires
>         // matching the fields, which will complexify the syntax =
considerably...
>         impl ::core::fmt::Debug for $name {
> @@ -319,6 +314,8 @@ pub(crate) fn [<set_ $field>](mut self, value: =
$to_type) -> Self {
>     (@io $name:ident @ $offset:expr) =3D> {
>         #[allow(dead_code)]
>         impl $name {
> +            pub(crate) const OFFSET: usize =3D $offset;
> +

Minor suggestion, have you ever though about somehow making this a const
generic? This saves the space needed to store the actual constant in the
binary.

Again, not sure whether this is feasible.


>             #[inline]
>             pub(crate) fn read<const SIZE: usize, T>(io: &T) -> Self =
where
>                 T: ::core::ops::Deref<Target =3D =
::kernel::io::Io<SIZE>>,
> @@ -351,6 +348,8 @@ pub(crate) fn alter<const SIZE: usize, T, F>(
>     (@io $name:ident @ + $offset:literal) =3D> {
>         #[allow(dead_code)]
>         impl $name {
> +            pub(crate) const OFFSET: usize =3D $offset;
> +
>             #[inline]
>             pub(crate) fn read<const SIZE: usize, T>(
>                 io: &T,
>=20
> --=20
> 2.50.1
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>


