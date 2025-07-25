Return-Path: <linux-kernel+bounces-746003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1D4B121BD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35B197BA43D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28AE2EFDA4;
	Fri, 25 Jul 2025 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="gSmnJG5m"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030F12EFD93;
	Fri, 25 Jul 2025 16:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460126; cv=pass; b=doyFAYuMVFiFWLgCpMGWTH65hzr5jB6zSo+MWRg+ZR7u1cZfW8Hh3DQVtgyI3+nk4mVdoVl3umK3fKWp0E4pB9xcEkC+M9jiu8hCPbPNaUMnHvAHRowdEMks98OHJRPdE99tXUzoXFHtCHuoBXSdHwMe5wpn/hndWz5s/4qi7mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460126; c=relaxed/simple;
	bh=A7ksU1bvZAG9k7j6F5UZQWe/Z8XScE+seNtXItM5jmg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pizaZY0iLk41jAV4k6EzsehbDQXN4l8YBe5FazDaEB6v75rowcZMyVE6H56lnTohtr7XeTzCkb1PnUUHB/IMvoKzaw7AUqOch3GUxzf3UHlYufnKPftjR51Ax3aGYilrdGnmHBX9CYIaWtl8gGgSVx+7dMqp0V1YSj8Wr3l0P2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=gSmnJG5m; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753460106; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=J1WA3IXrUGpGOYPbJ9ZgPNX3m5pjoql//Rr6QiIc0/a8DBBksmQ6Urkzjn0zI4196iWY1/1X1jMvjsQ44piT4vILeaSE0eQNEggv24Spa9fFuAf/kdu+oWsjwOJcDYBpK6bZdu+MDwrs9Qz5Vd2LlIjUi3uB60ZWEHINF2DtbjQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753460106; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Cbvvomnbtrld2kTiEXZvpI4lmoKBMsw0XyhLoXt6moE=; 
	b=OhcsiiYmHKW98rgFm52+kLIPJ3dkkEVTs9egwzepqjos4A/F7IAIwM/mD+5JMK5OxOlfj5+r6YKF1Ib1q72j+dAIR60pAVe6WJ5Dvns329k1yXGEk0yXuMcFRz0OMwYPjeEVYZEFjxh70IoyYvlfJTwSg7JAR/kiyFR08/63oAM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753460106;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=Cbvvomnbtrld2kTiEXZvpI4lmoKBMsw0XyhLoXt6moE=;
	b=gSmnJG5mXW1NZv6+BgCGA3dQ3uyWcDxxMDLgCjLBnlGi/41pNAthyUzhEjKn46Xz
	L2wgQRachDsuZ9/aNUBvl7aPr1GNcFBZAmrahf/XnrKu6N6s1utp8pqakF4IR//WlZ+
	SuiaYNM3/SDvkdrqTCE1Ys/HxfPS+HTfKFmS8JkI=
Received: by mx.zohomail.com with SMTPS id 175346010455174.4659064233291;
	Fri, 25 Jul 2025 09:15:04 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v2 01/19] gpu: nova-core: register: minor grammar and
 spelling fixes
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250718-nova-regs-v2-1-7b6a762aa1cd@nvidia.com>
Date: Fri, 25 Jul 2025 13:14:49 -0300
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
 linux-kernel@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>,
 steven.price@arm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <B1AA6359-7854-4284-B533-F5CA3C18AF34@collabora.com>
References: <20250718-nova-regs-v2-0-7b6a762aa1cd@nvidia.com>
 <20250718-nova-regs-v2-1-7b6a762aa1cd@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Alex. Thank you and John for working on this in general. It will be =
useful
for the whole ecosystem! :)=20

> On 18 Jul 2025, at 04:26, Alexandre Courbot <acourbot@nvidia.com> =
wrote:
>=20
> From: John Hubbard <jhubbard@nvidia.com>
>=20
> There is only one top-level macro in this file at the moment, but the
> "macros.rs" file name allows for more. Change the wording so that it
> will remain valid even if additional macros are added to the file.
>=20
> Fix a couple of spelling errors and grammatical errors, and break up a
> run-on sentence, for clarity.
>=20
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> drivers/gpu/nova-core/regs/macros.rs | 14 +++++++-------
> 1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/nova-core/regs/macros.rs =
b/drivers/gpu/nova-core/regs/macros.rs
> index =
cdf668073480ed703c89ffa8628f5c9de6494687..864d1e83bed2979f5661e038f4c9fd87=
d33f69a7 100644
> --- a/drivers/gpu/nova-core/regs/macros.rs
> +++ b/drivers/gpu/nova-core/regs/macros.rs
> @@ -1,17 +1,17 @@
> // SPDX-License-Identifier: GPL-2.0
>=20
> -//! Macro to define register layout and accessors.
> +//! `register!` macro to define register layout and accessors.

I would have kept this line as-is. Users will most likely know the name =
of the
macro already. At this point, they will be looking for what it does, so
mentioning "register" here is a bit redundant IMHO.

> //!
> //! A single register typically includes several fields, which are =
accessed through a combination
> //! of bit-shift and mask operations that introduce a class of =
potential mistakes, notably because
> //! not all possible field values are necessarily valid.
> //!
> -//! The macro in this module allow to define, using an intruitive and =
readable syntax, a dedicated
> -//! type for each register with its own field accessors that can =
return an error is a field's value
> -//! is invalid.
> +//! The `register!` macro in this module provides an intuitive and =
readable syntax for defining a
> +//! dedicated type for each register. Each such type comes with its =
own field accessors that can
> +//! return an error if a field's value is invalid.
>=20
> -/// Defines a dedicated type for a register with an absolute offset, =
alongside with getter and
> -/// setter methods for its fields and methods to read and write it =
from an `Io` region.
> +/// Defines a dedicated type for a register with an absolute offset, =
including getter and setter
> +/// methods for its fields and methods to read and write it from an =
`Io` region.

+cc Steven Price,

Sorry for hijacking this patch, but I think that we should be more =
flexible and
allow for non-literal offsets in the macro.

In Tyr, for example, some of the offsets need to be computed at runtime, =
i.e.:

+pub(crate) struct AsRegister(usize);
+
+impl AsRegister {
+    fn new(as_nr: usize, offset: usize) -> Result<Self> {
+        if as_nr >=3D 32 {
+            Err(EINVAL)
+        } else {
+            Ok(AsRegister(mmu_as(as_nr) + offset))
+        }
+    }

Or:

+pub(crate) struct Doorbell(usize);
+
+impl Doorbell {
+    pub(crate) fn new(doorbell_id: usize) -> Self {
+        Doorbell(0x80000 + (doorbell_id * 0x10000))
+    }

I don't think this will work with the current macro, JFYI.

> ///
> /// Example:
> ///
> @@ -24,7 +24,7 @@
> /// ```
> ///
> /// This defines a `BOOT_0` type which can be read or written from =
offset `0x100` of an `Io`
> -/// region. It is composed of 3 fields, for instance `minor_revision` =
is made of the 4 less
> +/// region. It is composed of 3 fields, for instance `minor_revision` =
is made of the 4 least
> /// significant bits of the register. Each field can be accessed and =
modified using accessor
> /// methods:
> ///
>=20
> --=20
> 2.50.1
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>


