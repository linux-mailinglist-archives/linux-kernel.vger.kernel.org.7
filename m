Return-Path: <linux-kernel+bounces-746238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7D5B12474
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1E23586F2E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C42C25743D;
	Fri, 25 Jul 2025 18:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="NU3BDFUt"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D024225394C;
	Fri, 25 Jul 2025 18:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753469809; cv=pass; b=iickW6fOWmda2KOj20SMNUWV7BR9ZfIELcBSfEMuy7l9om+maom6IDZQVinX6ngM1LoQ/kuUP3SQPY1y28dALSW2sLDquj5yMU29MCtYZYgHa3Zl8MSaeGrdhoCZoSvjos9hZGwk2oAt+0gAT9MtAG/ui3T3bJ2a5JcECZ893Go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753469809; c=relaxed/simple;
	bh=VigHQ5VbXX40LCqzfFLMODjqTGl9OmpTAQNkTErOBeI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Wqtg0wtZueBDtyjHA/gI1+dzDxiRFoQ0zx7ThFSVL4f2w+FPp3P1Dp98PTJX4uTVbGFtnkDTx7oc/Qym2ikjAb2EeyjrKBdxtk8RCN8+XAFV+aclI4AbhqX+TNzLf9bD6y4uq2+KxZvJ7NagLTvwVK1T33kZyg7D9wsil39+Wb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=NU3BDFUt; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753469792; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TWAFnRBmW5sG1SXFpDtSRFAUhdo6qQjgsCzmI9eQxxAKe+rLvdWr2odE6uX1eagrgCVAyEiRKiSbHvZZsLiCsL2wGmpPrWbm9pL9gCInGlzG2VlEfcZlnUIA7Yzg1DeMa4lx6elWrQvmxDP+oZAuR+sYR4lculwEPDOhLjm6HSU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753469792; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=X1uK2olKYL8ou4YyzWVOCVnW71YBYE+pWaxRKyBZkk4=; 
	b=VkWRvd2nGX6QiUb4d04YIgjivySNXU+WWUsXtdNlWweFtse2271R3NW8sioKFDAnFD14Yq/U4DUc8u3g57ZMzy3CpohZ42nC4r8u5l3/D9iVUz4t3rKclE2+S3CqcJLi3D1xMeWWlAoRHjiau+/Bo2mYW02yr/T48LfUQrSPISk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753469792;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=X1uK2olKYL8ou4YyzWVOCVnW71YBYE+pWaxRKyBZkk4=;
	b=NU3BDFUt11IbXyU2pj3v4ojTvXzbVWS4GaFa98M5+ndUR0jHdMhH6fpr/H53At79
	RWbSogIoY0xPUu9BoFx089lbZE/heudpDjVGyshoDl0ODWnuugTgVsgbklwhoDHn9Xl
	JaMYGhWeFKrVdAHyQOS9nWgfI1heGENozNk3d2f0=
Received: by mx.zohomail.com with SMTPS id 1753469789200186.12466149981094;
	Fri, 25 Jul 2025 11:56:29 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v2 15/19] gpu: nova-core: register: redesign relative
 registers
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250718-nova-regs-v2-15-7b6a762aa1cd@nvidia.com>
Date: Fri, 25 Jul 2025 15:56:14 -0300
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
Message-Id: <F19649A8-3002-4BAC-8FBF-095CF67B3946@collabora.com>
References: <20250718-nova-regs-v2-0-7b6a762aa1cd@nvidia.com>
 <20250718-nova-regs-v2-15-7b6a762aa1cd@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Alex,

> On 18 Jul 2025, at 04:26, Alexandre Courbot <acourbot@nvidia.com> =
wrote:
>=20
> The relative registers are currently very unsafe to use: callers can
> specify any constant as the base address for access, meaning they can
> effectively interpret any I/O address as any relative register.
>=20
> Ideally, valid base addresses for a family of registers should be
> explicitly defined in the code, and could only be used with the =
relevant
> registers
>=20
> This patch changes the relative register declaration into this:
>=20
>    register!(REGISTER_NAME @ BaseTrait[offset] ...
>=20
> Where `BaseTrait` is the name of a ZST used as a parameter of the
> `RegisterBase<>` trait to define a trait unique to a class of =
register.
> This specialized trait is then implemented for every type that =
provides
> a valid base address, enabling said types to be passed as the base
> address provider for the register's I/O accessor methods.
>=20
> This design thus makes it impossible to pass an unexpected base =
address
> to a relative register, and, since the valid bases are all known at
> compile-time, also guarantees that all I/O accesses are done within =
the
> valid bounds of the I/O range.
>=20
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>


I think it would be helpful to showcase a before/after in the commit =
message. IIUC, we'd go from:

/// Putting a `+` before the address of the register makes it relative =
to a base: the `read` and
/// `write` methods take a `base` argument that is added to the =
specified address before access:
///
/// ```no_run
/// register!(CPU_CTL @ +0x0000010, "CPU core control" {
///    0:0     start as bool, "Start the CPU core";
/// });


To:

/// ```no_run
/// // Type used to identify the base.
/// pub(crate) struct CpuCtlBase;
///
/// // ZST describing `CPU0`.
/// struct Cpu0;
/// impl RegisterBase<CpuCtlBase> for Cpu0 {
///     const BASE: usize =3D 0x100;
/// }
/// // Singleton of `CPU0` used to identify it.
/// const CPU0: Cpu0 =3D Cpu0;
///
/// // ZST describing `CPU1`.
/// struct Cpu1;
/// impl RegisterBase<CpuCtlBase> for Cpu1 {
///     const BASE: usize =3D 0x200;
/// }
/// // Singleton of `CPU1` used to identify it.
/// const CPU1: Cpu1 =3D Cpu1;

So you can still pass whatever base you want, the difference (in this
particular aspect) is whether it's specified in the macro itself, or as =
an
associated constant of RegisterBase<Foo>?

In any case, have you considered what happens when the number of "CPUs" =
in your
example grows larger? I can only speak for Tyr, where (IIUC), I'd have =
to
define 16 structs, each representing a single AS region, i.e.:

+pub(crate) const MMU_BASE: usize =3D 0x2400;
+pub(crate) const MMU_AS_SHIFT: usize =3D 6;
+
+const fn mmu_as(as_nr: usize) -> usize {
+ MMU_BASE + (as_nr << MMU_AS_SHIFT)
+
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

It's still somewhat manageable, but I wonder if there are usecases out =
there
(in other drivers/devices) where this number will be even higher, which =
will
make this pattern impossible to implement.

Or maybe I misunderstood the usecase?

In any case, the patch itself looks fine to me.


[=E2=80=A6]


=E2=80=94 Daniel


