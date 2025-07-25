Return-Path: <linux-kernel+bounces-746042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9C8B1224D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B1C33AB05F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508D52EF644;
	Fri, 25 Jul 2025 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="AtUZbhQG"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA31A1FC8;
	Fri, 25 Jul 2025 16:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753462173; cv=pass; b=KrUvzyrDuBrKyFmmLszwC6BBJ3ZteBSGh4llgFk2tei/3XgUmnrTy88qdFxhMHxd1YPwySGzdPsXcBf92UZSKwVwDhdL+vLIOopMjGXXR6san7gl/gadgeYi6VLE7IDdnBSRHAGop5A3vl6k4o7xcgsjg4BExc3NDxncjh5SMwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753462173; c=relaxed/simple;
	bh=vcJhR+5G/azJiDJdvOJCHz7Zh94+Ne85tA8OIZsi3/o=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Ez8OA8OLhlKF89DWNGcv2rGk1LcdBXhXPFMP28KigT4gEdGp4V9KVCqw3u0wjwmidhnDJlmMbi8z9gzLICs+5i4eeloONTmCmR0CKiTWk2rWsbd2zGp9j+UgwJ7tLDmTc/LnLDvwDLd8tMKOuB9bd4bpWs8UmrEqzoQpORCOG60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=AtUZbhQG; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753462158; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GqNDNttFirSXO1T+EH0KNwpgYZVNE2Rm0VZG5BZjBczTsK38B+rUl+p4s7KkzdOWinvSAquceOWrFXUNAudJTPhDpRw679fv+MrYNypdUHp1ldc4EawREqGi9xPaoVLLgE+GR6vi0j+VtUWZmwXxf5Pt2qpvJameuzOOlXWEhw4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753462158; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8H+Dpp+WGr2WT6IwVYaMpKQetTMiZxLndpNFF+SWOwc=; 
	b=lAIrxEzJ4YtwjvK0904XWSbFCgxpoEtSuIXeHFQKvGeUpx1qz9MT/jglklTJk0XiORNaqfa5ezjQqcMfu5FKdHUNiT6gpG9vaT9AmibvEqu8btoFxssYeNL09JsnmcIyxEPw1UVerrdIQH4hsSX9Td902r9gAOzthescN5WNCSI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753462158;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=8H+Dpp+WGr2WT6IwVYaMpKQetTMiZxLndpNFF+SWOwc=;
	b=AtUZbhQGvnjTJYQj1t7B72sTFqQ7PKWo3W2MSxshG3/1r6h3/W/yiZWro+x6YmbK
	f2y7EkNuueXZeEJeKgWUH6G7bxkuxhM1z7rNdW8vliQ2vVVrgP2Yk1qiyP7M5nlvPv2
	hvAyiwo/4S8HG5akah+iPqom/BEsytkZRQvKpUwQ=
Received: by mx.zohomail.com with SMTPS id 1753462154658166.30563791566476;
	Fri, 25 Jul 2025 09:49:14 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v2 04/19] gpu: nova-core: register: improve documentation
 for basic registers
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250718-nova-regs-v2-4-7b6a762aa1cd@nvidia.com>
Date: Fri, 25 Jul 2025 13:49:00 -0300
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
Message-Id: <54F2B09C-13F1-41E8-AFA2-6AEF4492F659@collabora.com>
References: <20250718-nova-regs-v2-0-7b6a762aa1cd@nvidia.com>
 <20250718-nova-regs-v2-4-7b6a762aa1cd@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 18 Jul 2025, at 04:26, Alexandre Courbot <acourbot@nvidia.com> =
wrote:
>=20
> Reword parts of the documentation that were a bit heavy to read, and
> harmonize/fix the examples.
>=20
> The relative registers section is about to be redesigned and its
> documentation rewritten, so do not touch this part.
>=20
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> drivers/gpu/nova-core/regs/macros.rs | 24 +++++++++++++-----------
> 1 file changed, 13 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/gpu/nova-core/regs/macros.rs =
b/drivers/gpu/nova-core/regs/macros.rs
> index =
d015a9f8a0b01afe1ff5093991845864aa81665e..dac02f8055e76da68e9a82133fa09a1e=
794252bc 100644
> --- a/drivers/gpu/nova-core/regs/macros.rs
> +++ b/drivers/gpu/nova-core/regs/macros.rs
> @@ -33,25 +33,25 @@
> /// let boot0 =3D BOOT_0::read(&bar);
> /// pr_info!("chip revision: {}.{}", boot0.major_revision(), =
boot0.minor_revision());
> ///
> -/// // `Chipset::try_from` will be called with the value of the field =
and returns an error if the
> -/// // value is invalid.
> +/// // `Chipset::try_from` is called with the value of the `chipset` =
field and returns an
> +/// // error if it is invalid.
> /// let chipset =3D boot0.chipset()?;
> ///
> /// // Update some fields and write the value back.
> /// boot0.set_major_revision(3).set_minor_revision(10).write(&bar);
> ///
> -/// // Or just read and update the register in a single step:
> +/// // Or, just read and update the register in a single step:
> /// BOOT_0::alter(&bar, |r| =
r.set_major_revision(3).set_minor_revision(10));
> /// ```
> ///
> -/// Fields can be defined as follows:
> +/// Fields are defined as follows:
> ///
> -/// - `as <type>` simply returns the field value casted as the =
requested integer type, typically
> -///   `u32`, `u16`, `u8` or `bool`. Note that `bool` fields must have =
a range of 1 bit.
> +/// - `as <type>` simply returns the field value casted to <type>, =
typically `u32`, `u16`, `u8` or
> +///   `bool`. Note that `bool` fields must have a range of 1 bit.
> /// - `as <type> =3D> <into_type>` calls `<into_type>`'s =
`From::<<type>>` implementation and returns
> ///   the result.
> /// - `as <type> ?=3D> <try_into_type>` calls `<try_into_type>`'s =
`TryFrom::<<type>>` implementation
> -///   and returns the result. This is useful on fields for which not =
all values are value.
> +///   and returns the result. This is useful with fields for which =
not all values are valid.
> ///
> /// The documentation strings are optional. If present, they will be =
added to the type's
> /// definition, or the field getter and setter methods they are =
attached to.
> @@ -76,15 +76,17 @@
> /// for cases where a register's interpretation depends on the =
context:
> ///
> /// ```no_run
> -/// register!(SCRATCH_0 @ 0x0000100, "Scratch register 0" {
> +/// register!(SCRATCH @ 0x00000200, "Scratch register" {
> ///    31:0     value as u32, "Raw value";
> +/// });
> ///
> -/// register!(SCRATCH_0_BOOT_STATUS =3D> SCRATCH_0, "Boot status of =
the firmware" {
> +/// register!(SCRATCH_BOOT_STATUS =3D> SCRATCH, "Boot status of the =
firmware" {
> ///     0:0     completed as bool, "Whether the firmware has completed =
booting";
> +/// });
> /// ```
> ///
> -/// In this example, `SCRATCH_0_BOOT_STATUS` uses the same I/O =
address as `SCRATCH_0`, while also
> -/// providing its own `completed` method.
> +/// In this example, `SCRATCH_0_BOOT_STATUS` uses the same I/O =
address as `SCRATCH`, while also
> +/// providing its own `completed` field.
> macro_rules! register {
>     // Creates a register at a fixed offset of the MMIO space.
>     (
>=20
> --=20
> 2.50.1
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>


