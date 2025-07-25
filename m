Return-Path: <linux-kernel+bounces-746044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DF6B12259
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A242017998A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12DD2EF65B;
	Fri, 25 Jul 2025 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="PmD9gkt2"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F5D24468B;
	Fri, 25 Jul 2025 16:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753462415; cv=pass; b=bQOexMVthNVA+W++3ah5Vp3CpUz4sLUez5x3xYd6gRJbZAiWb/5nongk1fcKVgqXlEFiYjL9hNQg8S6DzWzptYC9HL30jEhTfhF76EW8ujceWZXuXZ++wuRe1VIHyMhm69vaqzHFQJzO/AbxABcMbNtRxs37KpP/lmSsMTJWom0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753462415; c=relaxed/simple;
	bh=IUBoAyjPueIx5pe8QD2xssdi9ljS3EmX95e6VRnfETg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SS5jIQpLWuTbNHh2e3NtGweUuFaKrUGtMnVD4iddOlM1QnefJOtI8vMjqiFidxVfLH11UY31FHVIUt7Na48k8IGtBn0PDKXlrbCLAHa5TUadClFhh3mU69gpzDDuSF/irOPdYxuCOwXauY8G4MMUuLLe1w4a7U3Xo0/0rGK2vb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=PmD9gkt2; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753462398; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bj3FjbUezY/UjRXAgmi55LwrRhuJJjFLAsz/7kkvZ7gfK0a4Tqtm1G/wykb/mumGoo6EbB+1TCfAypGqER7FupC8vz67bBeVsVX4YTbhI9BtsAdTktGalLxu9X41reHU4kmorbkx6TDVSgEJnuFkXQK/VP/J5/WjQTKPG/ieQpk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753462398; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=t3m7gtfDliYNrrxVa5bKfbwWOcoYtXsGA8e/6LGr0RY=; 
	b=jJ9JLYQIPvXCeT5Cbu9sCrU8JT1VY/ROB/YbdCZUXVnZaee0FzXbhHBV3hfzn8nLL3+Ce+40IWbXdGpfpYekNCXArvA6xqi4uHMBl541m2BqWXL2Lc4pqw6CIfh0HYb7mEqzs+4yx+cIfiuSfBiwenNFQ3CqS45EVFD1tNRNOBU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753462398;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=t3m7gtfDliYNrrxVa5bKfbwWOcoYtXsGA8e/6LGr0RY=;
	b=PmD9gkt2znr5aCoLmy+By6GLjlw74hqPH80aJr0Yc5edkXl6EzBxTkW+PHoTPGNB
	Qdv8RaBIRrVovULP/1vpMq640IDAFM6QTi/u/X7/LV5tTcLYDP5g/MjT/qOmxFEnxiR
	z84S2wE7fz3DleKkn2x3qFU5uAqmf9LDPfnAGnn8=
Received: by mx.zohomail.com with SMTPS id 175346239512966.13578064286003;
	Fri, 25 Jul 2025 09:53:15 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v2 05/19] gpu: nova-core: register: simplify
 @leaf_accessor rule
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250718-nova-regs-v2-5-7b6a762aa1cd@nvidia.com>
Date: Fri, 25 Jul 2025 13:53:00 -0300
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
Message-Id: <505C79FD-3C42-4544-ABCC-E03F4170A2A8@collabora.com>
References: <20250718-nova-regs-v2-0-7b6a762aa1cd@nvidia.com>
 <20250718-nova-regs-v2-5-7b6a762aa1cd@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 18 Jul 2025, at 04:26, Alexandre Courbot <acourbot@nvidia.com> =
wrote:
>=20
> The `$type` metavariable is not used in the @leaf_accessor rule, so
> remove it.
>=20
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> drivers/gpu/nova-core/regs/macros.rs | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/nova-core/regs/macros.rs =
b/drivers/gpu/nova-core/regs/macros.rs
> index =
dac02f8055e76da68e9a82133fa09a1e794252bc..37c7c454ba810447e1fe41231650e616=
e2f86eb8 100644
> --- a/drivers/gpu/nova-core/regs/macros.rs
> +++ b/drivers/gpu/nova-core/regs/macros.rs
> @@ -230,7 +230,7 @@ impl $name {
>             $(, $comment:literal)?;
>     ) =3D> {
>         register!(
> -            @leaf_accessor $name $hi:$lo $field as bool
> +            @leaf_accessor $name $hi:$lo $field
>             { |f| <$into_type>::from(if f !=3D 0 { true } else { false =
}) }
>             $into_type =3D> $into_type $(, $comment)?;
>         );
> @@ -248,7 +248,7 @@ impl $name {
>         @field_accessor $name:ident $hi:tt:$lo:tt $field:ident as =
$type:tt ?=3D> $try_into_type:ty
>             $(, $comment:literal)?;
>     ) =3D> {
> -        register!(@leaf_accessor $name $hi:$lo $field as $type
> +        register!(@leaf_accessor $name $hi:$lo $field
>             { |f| <$try_into_type>::try_from(f as $type) } =
$try_into_type =3D>
>             ::core::result::Result<
>                 $try_into_type,
> @@ -262,7 +262,7 @@ impl $name {
>         @field_accessor $name:ident $hi:tt:$lo:tt $field:ident as =
$type:tt =3D> $into_type:ty
>             $(, $comment:literal)?;
>     ) =3D> {
> -        register!(@leaf_accessor $name $hi:$lo $field as $type
> +        register!(@leaf_accessor $name $hi:$lo $field
>             { |f| <$into_type>::from(f as $type) } $into_type =3D> =
$into_type $(, $comment)?;);
>     };
>=20
> @@ -276,7 +276,7 @@ impl $name {
>=20
>     // Generates the accessor methods for a single field.
>     (
> -        @leaf_accessor $name:ident $hi:tt:$lo:tt $field:ident as =
$type:ty
> +        @leaf_accessor $name:ident $hi:tt:$lo:tt $field:ident
>             { $process:expr } $to_type:ty =3D> $res_type:ty $(, =
$comment:literal)?;
>     ) =3D> {
>         ::kernel::macros::paste!(
>=20
> --=20
> 2.50.1
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=

