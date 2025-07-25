Return-Path: <linux-kernel+bounces-746024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18882B12207
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25F2C1C8179F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02ED11F462D;
	Fri, 25 Jul 2025 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="pE4Yj3S2"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DF2374D1
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753461017; cv=pass; b=nsy9//loy2Mp494x95Cx7PRnV2iJluHxi2VKeE39Qg32aLR/rYhP/bPKD3Awf4mDKkv/qhkPJYfCUaITY+5Ar4ZhCIP9E9pJ9dXIXxRaOVb8e4Y7CyCXLSsqGWXk2rxNL9IZI+4OpRtYI8s6OtzVeK1PdNHWUtWv3W+3oz8b4LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753461017; c=relaxed/simple;
	bh=x0EtQta/5k2J6Ni5cItYFjcIO3DeluIxw4qZ5J6tZI0=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=L3wHamfKGJ56p6w8j9I/y0IWi0jF6SPD9dZ5XJxuDvPPMcgs7FrCYE42DH38p8HOtZ76QEIJtF8FwpjGvs44G/diIKgV/ooj9zL5chxhxiEZclwdmzAkTMU+o4QhZgWIIrT7fb7B215eZLPKX7nekpiDSJ5bJxFGffVgg6E8RII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=pE4Yj3S2; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1753461001; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aEUfV3gZVITtA1V4+T10FU6Zp2cRgW/Vw5mIpQxxGoDgll87FQIaTDiIXFo5ZVo4vzQzc/qnq5oLr6gI9nJSvkDMs3NCtiKVnSWKzD6AchL1uKpJpgr0F8VVDPEMhoif9W7vuvqQfP9NKwaKyiMlUZT1D3Wk1NBPAS77+YxQjs8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753461001; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=V7UB6j/9y8mHrSKKCeR3NkchjsE3+xKogIfJfdZ88s0=; 
	b=GFU9/Ul0PVlcWPc8Ahil1Rsp5NWpbSGc+r5+ZPzm5Y5yMqTHz3BY/oac4k3LAsb0Ox3FVqtp8pQv3nSve8M/0sNt4yvw1j3TiuV+fipIYkNZucGgLUPG1RIbti9Ds7Js0M1PPEXDF7Qdz+IMAX2YTKClak8orVT1a1qzOgrjPtI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753461001;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=MIME-Version:From:From:To:To:In-Reply-To:Cc:Cc:Subject:Subject:Message-ID:Date:Date:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=V7UB6j/9y8mHrSKKCeR3NkchjsE3+xKogIfJfdZ88s0=;
	b=pE4Yj3S2YyEqZb3A5ZEkjA2Va9iGhnyexrnASyMU0nA9Zqz/hPDuOFX7ocJMDxTV
	lB3Q9O0vvF/ug/RyVl7uEk7CXR+qcSBj6rIjR9HtW0VZQj332/Q29s48VDEBOMb9Ixm
	3wAyQIQE65qqK25mrV2+n1P/XI3XiMNWZqdACOXU=
Received: by mx.zohomail.com with SMTPS id 1753460998721142.7352358306208;
	Fri, 25 Jul 2025 09:29:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "Alexandre Ghiti" <alex@ghiti.fr>, 
	"Paul Walmsley" <paul.walmsley@sifive.com>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>
In-Reply-To: <e7499ddb-04f6-4891-bbce-38bb80a87401@ghiti.fr>
Cc: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] riscv: mm: Use mmu-type from FDT to limit SATP mode
Message-ID: <18558b7c6df10da0.2100f58a3d0fe250.7de105a1ea2dd0f@Mac>
Date: Fri, 25 Jul 2025 16:29:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

On 25/07/2025 16:04, Alexandre Ghiti wrote:
> On 7/21/25 18:53, Junhui Liu wrote:
>> Some RISC-V implementations may hang when attempting to write an
>> unsupported SATP mode, even though the latest RISC-V specification
>> states such writes should have no effect. To avoid this issue, the
>> logic for selecting SATP mode has been refined:
>>
>> The kernel now determines the SATP mode limit by taking the minimum of
>> the value specified by the kernel command line (noXlvl) and the
>> "mmu-type" property in the device tree (FDT). If only one is specified,
>> use that.
>> - If the resulting limit is sv48 or higher, the kernel will probe SATP
>>    modes from this limit downward until a supported mode is found.
>> - If the limit is sv39, the kernel will directly use sv39 without
>>    probing.
>>
>> This ensures SATP mode selection is safe and compatible with both
>> hardware and user configuration, minimizing the risk of hangs.
>>
>> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
>> ---
>>   arch/riscv/kernel/pi/fdt_early.c | 40 +++++++++++++++++++++++++++++++++=
+++++++
>>   arch/riscv/kernel/pi/pi.h        |  1 +
>>   arch/riscv/mm/init.c             | 11 ++++++++---
>>   3 files changed, 49 insertions(+), 3 deletions(-)
>>

[...]

>=20
> I guess it's more convenient to use the 'mmu-type' property on this core=
=20
> rather than using no4lvl right?

Yes, It's hard to ensure that all the users are aware of the need to use
the 'no4lvl', and the cmdline args can easily be overridden by the
bootloader or users if a `bootargs =3D "no4lvl"` is defined in the device
tree. Therefore, relying on the 'mmu-type' property is more robust and
user-friendly.

>=20
> Anyway, what you implemented matches the description of the 'mmu-type'=20
> binding, so:
>=20
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>=20
> I'll take that for 6.17.

Thanks!

>=20
> Thanks,
>=20
> Alex

--=20
Best regards,
Junhui Liu


