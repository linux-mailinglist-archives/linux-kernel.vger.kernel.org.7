Return-Path: <linux-kernel+bounces-723910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE0FAFEC5C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BA73178A2F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25312E6D26;
	Wed,  9 Jul 2025 14:39:45 +0000 (UTC)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488D71DFCE
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752071985; cv=none; b=HnGsYt7OVSUOgD0u8aMSmtDwxtqqOQd5GYHnl32bP8wtdbFbpaRhS/lPi6iNuXctMfKH6izuxSSYoOPKQAZbXzE/hTPhVOCX+MU31oGGpn+2LRSa5U/qe89v40xEXViSyF8nlk+JiJWcbCD16Ea4P8S0wlQRTIqxrVJ+bG7d/4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752071985; c=relaxed/simple;
	bh=dCmop7FmoNp7supB8iY7vJh7HwSlWjEnN5lJZkQZ1bY=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:
	 References:In-Reply-To; b=dbtXHL5k5lslr/XXqba1jbpnKXh1ps9/Lc7XId5/Qp7fnoqZNODvmxSGSPf3A7Op5e5ksouk43hShPKn4RZKVUgXcu7Y1tFRzoa5m4ubEBTJKV9zn9rPZuoSGuxboK2d3wfYRK/LXTWjrm2FyfzqiSGmqFXU++Oq9MBRWcRVH+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4320:1000:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 347636C7;
	Wed,  9 Jul 2025 16:33:42 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Jul 2025 16:33:41 +0200
Message-Id: <DB7LJZF3AZQJ.2I5EWYORV6K33@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: <khairul.anuar.romli@altera.com>, "Tudor Ambarus"
 <tudor.ambarus@linaro.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Miquel
 Raynal" <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, "open list:SPI NOR SUBSYSTEM"
 <linux-mtd@lists.infradead.org>, "open list"
 <linux-kernel@vger.kernel.org>, "Matthew Gerlach"
 <matthew.gerlach@altera.com>
Subject: Re: [PATCH 1/1] mtd: spi-nor: core: Prevent oops during driver
 removal with active read or write operations
X-Mailer: aerc 0.16.0
References: <cover.1752024352.git.khairul.anuar.romli@altera.com>
 <e439e6b85e650a91607a1d02d5d432d096363315.1752024352.git.khairul.anuar.romli@altera.com>
In-Reply-To: <e439e6b85e650a91607a1d02d5d432d096363315.1752024352.git.khairul.anuar.romli@altera.com>

Hi,

> Ensure that the pointer passed to module_put() in spi_nor_put_device() is
> not NULL before use. This change adds a guard clause to return early,
> preventing the kernel crash below when the cadence-qspi driver is removed
> during a dd operation:
>
> [  200.448732] Unable to handle kernel NULL pointer deref
> erence at virtual address 0000000000000010
> [  200.457576] Mem abort info:
> [  200.460370]   ESR =3D 0x0000000096000004
> [  200.464136]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [  200.469527]   SET =3D 0, FnV =3D 0
> [  200.472609]   EA =3D 0, S1PTW =3D 0
> [  200.475904]   FSC =3D 0x04: level 0 translation fault
> [  200.480786] Data abort info:
> [  200.483659]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
> [  200.489141]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> [  200.494189]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> [  200.499500] user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000185df800=
0
> [  200.505932] [0000000000000010] pgd=3D0000000000000000, p4d=3D000000000=
0000000
> [  200.512720] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> [  200.518968] Modules linked in: 8021q garp mrp stp llc bluetooth ecdh_g=
eneric
> ecc rfkill crct10dif_ce rtc_ds1307 at24 stratix10_soc soc64_hwmon gpio_al=
tera of
> _fpga_region fpga_region fpga_bridge uio_pdrv_genirq uio fuse drm backlig=
ht ipv6
> [  200.540016] CPU: 0 UID: 0 PID: 372 Comm: dd Not tainted 6.12.19-altera=
-gb6b26
> c4179a6 #1
> [  200.547996] Hardware name: SoCFPGA Stratix 10 SoCDK (DT)
> [  200.553292] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [  200.560234] pc : spi_nor_put_device+0x30/0x60
> [  200.564594] lr : __put_mtd_device+0x8c/0x120
> [  200.568856] sp : ffff80008411bc20
> [  200.572161] x29: ffff80008411bc20 x28: ffff000185e2c500 x27: 000000000=
0000000
> [  200.579282] x26: 0000000000000000 x25: ffff000185e2cb00 x24: ffff00018=
5e2cc88
> [  200.586404] x23: ffff00018034c620 x22: 0000000000000001 x21: ffff00018=
873e080
> [  200.593524] x20: 0000000000000000 x19: ffff00018873e080 x18: fffffffff=
fffffff
> [  200.600645] x17: 0030393d524f4a41 x16: 4d0064746d3d4d45 x15: ffff00018=
5757700
> [  200.607767] x14: 0000000000000000 x13: ffff000180045010 x12: ffff00018=
57576c0
> [  200.614888] x11: 000000000000003a x10: ffff000180045018 x9 : ffff00018=
0045010
> [  200.622009] x8 : ffff80008411bb70 x7 : 0000000000000000 x6 : ffff00018=
1325048
> [  200.629129] x5 : 00000000820001cf x4 : fffffdffc60095e0 x3 : 000000000=
0000000
> [  200.636250] x2 : 0000000000000000 x1 : ffff00018873e080 x0 : 000000000=
0000000
> [  200.643371] Call trace:
> [  200.645811]  spi_nor_put_device+0x30/0x60
> [  200.649816]  __put_mtd_device+0x8c/0x120
> [  200.653731]  put_mtd_device+0x30/0x48
> [  200.657387]  mtdchar_close+0x30/0x78
> [  200.660958]  __fput+0xc8/0x2d0
> [  200.664011]  ____fput+0x14/0x20
> [  200.667146]  task_work_run+0x70/0xdc
> [  200.670718]  do_exit+0x2b4/0x8e4
> [  200.673944]  do_group_exit+0x34/0x90
> [  200.677512]  pid_child_should_wake+0x0/0x60
> [  200.681686]  invoke_syscall+0x48/0x104
> [  200.685432]  el0_svc_common.constprop.0+0xc0/0xe0
> [  200.690128]  do_el0_svc+0x1c/0x28
> [  200.693439]  el0_svc+0x30/0xcc
> [  200.696454] dw_mmc ff808000.mmc: Unexpected interrupt latency
> [  200.696485]  el0t_64_sync_handler+0x120/0x12c
> [  200.706552]  el0t_64_sync+0x190/0x194
> [  200.710213] Code: f9400000 f9417c00 f9402000 f9403400 (f9400800)
> [  200.716290] ---[ end trace 0000000000000000 ]---
> [  200.720948] Fixing recursive fault but reboot is needed!
>
> Fixes: be94215be1ab ("mtd: spi-nor: core: Fix an issue of releasing resou=
rces during read/write")
> CC: stable@vger.kernel.org # 6.12+
> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
> ---
>  drivers/mtd/spi-nor/core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index ac4b960101cc..501e48a342ad 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -3213,6 +3213,9 @@ static int spi_nor_get_device(struct mtd_info *mtd)
>  	if (!try_module_get(dev->driver->owner))
>  		return -ENODEV;
> =20
> +	if (!dev && !dev->driver && !dev->driver->owner)
> +		return -EINVAL;
> +
>  	return 0;
>  }
> =20
> @@ -3227,7 +3230,8 @@ static void spi_nor_put_device(struct mtd_info *mtd=
)
>  	else
>  		dev =3D nor->dev;
> =20
> -	module_put(dev->driver->owner);
> +	if (dev && dev->driver && dev->driver->owner)
> +		module_put(dev->driver->owner);

Why is dev->driver or dev->driver->owner NULL in the first place?

-michael

