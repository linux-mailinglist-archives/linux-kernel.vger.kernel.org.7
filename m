Return-Path: <linux-kernel+bounces-750289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A0CB15995
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8734A3BB77B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 07:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74545288C1E;
	Wed, 30 Jul 2025 07:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKw4qa1W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27F31F1906
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753860614; cv=none; b=deQSBdtjhKXLgLYfjWa7+7Y2g7SIRhDc/hd5Fi8klsZA+dAs98eSRLnWKHZ/qqivLsz7bInG8twFDWaVYWhjOGTxUkIEn4xfrmQApuf3srBPb82z5zCcIQ3iplFKCe/LHR9CixTkux5aAwThhwj5HhCLzxcNJZ/qmgHa3FLT7A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753860614; c=relaxed/simple;
	bh=H/pqotFZUKNnyxSNnhtzvMiTrU7Ao/+haG8ZKeInaec=;
	h=Content-Type:Date:Message-Id:From:To:Subject:References:
	 In-Reply-To; b=rniBJoUZcfr4HDa1T854WoGZprl9Uv7kWDP8dZzc6kglstuwYCCO+eOMptoMe2XFMeiwEMs2PzaQjpLkJWtKA/J+uJqJ05bu+mVP9n52R8fHDucFHlCMQ5URzhAp2F+hjd/i5oE2A8la2l2+CivMMA3FrKSjHZ+GUuIk0xQM3/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKw4qa1W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91B5C4CEE7;
	Wed, 30 Jul 2025 07:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753860614;
	bh=H/pqotFZUKNnyxSNnhtzvMiTrU7Ao/+haG8ZKeInaec=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=sKw4qa1WsD98Zi1U0HNE5xEtnC0Ozn/EkWRLtWlnaSRidZd97CxLS+0MtAcYIg4ef
	 HF0Y2smDLxZsM7th6pRC7roNv6IMXyWuYyEDSvyL+QmN9rRmL+zbq/jj1CbNCJP9Ky
	 JnyqtSXf/yU334XrvNzire2kjPgN2LZrTiHj2btkexq0xt4em/r6ExEtpxRX7p3RBw
	 F2+9XkPw6ONCJHkX94/McbmqNlpUFuL0i15Mg4b3yF1PD3AiCaPSe0QyB1u3CLlcma
	 /46gvngmyr659hW0jLmDeedH1ITcc4bEjF7LkoWHbMUbwwegsL+rWhk5f7ySnE4aPT
	 2SCHZQOhjQRYA==
Content-Type: multipart/signed;
 boundary=a3e9b9de6cf3dc4c98cb83aa2206db48083b13031472f83fa1f6f0a267af;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 30 Jul 2025 09:30:06 +0200
Message-Id: <DBP7P3RWX17B.14Q27IBS3T3FL@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Khairul Anuar Romli" <khairul.anuar.romli@altera.com>, "Tudor Ambarus"
 <tudor.ambarus@linaro.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Miquel
 Raynal" <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, "open list:SPI NOR SUBSYSTEM"
 <linux-mtd@lists.infradead.org>, "open list"
 <linux-kernel@vger.kernel.org>, "Matthew Gerlach"
 <matthew.gerlach@altera.com>
Subject: Re: [PATCH v3 1/1] mtd: spi-nor: core: Prevent oops during driver
 removal with active read or write operations
X-Mailer: aerc 0.16.0
References: <cover.1753839339.git.khairul.anuar.romli@altera.com>
 <566fc1168db723672ab0bc6482ec7b72b4b8fe2b.1753839339.git.khairul.anuar.romli@altera.com>
In-Reply-To: <566fc1168db723672ab0bc6482ec7b72b4b8fe2b.1753839339.git.khairul.anuar.romli@altera.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--a3e9b9de6cf3dc4c98cb83aa2206db48083b13031472f83fa1f6f0a267af
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Wed Jul 30, 2025 at 3:39 AM CEST, Khairul Anuar Romli wrote:
> From: kromli <khairul.anuar.romli@altera.com>
>
> Ensure that the pointer passed to module_put() in spi_nor_put_device() is
> not NULL before use. This change adds a guard clause to return early,
> preventing the kernel crash below when the cadence-qspi driver is removed
> during a dd operation:

As already asked in v2. This needs a (more detailed) description
what is going on and what is going wrong.

-michael

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
> Changes in v3:
>     - exclude !dev && !dev->driver check in spi_nor_get_device to
>       resolve kernel test robot smatchwarnings.
> Changes in v2:
>     - Move the null check prior to try_module_get().
> ---
>  drivers/mtd/spi-nor/core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index ac4b960101cc..eb21d660036b 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -3210,6 +3210,9 @@ static int spi_nor_get_device(struct mtd_info *mtd)
>  	else
>  		dev =3D nor->dev;
> =20
> +	if (!dev->driver->owner)
> +		return -EINVAL;
> +
>  	if (!try_module_get(dev->driver->owner))
>  		return -ENODEV;
> =20
> @@ -3227,7 +3230,8 @@ static void spi_nor_put_device(struct mtd_info *mtd=
)
>  	else
>  		dev =3D nor->dev;
> =20
> -	module_put(dev->driver->owner);
> +	if (dev && dev->driver && dev->driver->owner)
> +		module_put(dev->driver->owner);
>  }
> =20
>  static void spi_nor_restore(struct spi_nor *nor)


--a3e9b9de6cf3dc4c98cb83aa2206db48083b13031472f83fa1f6f0a267af
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaInJ/xIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/i97wGA9CAFtXIoHqpiNWKi9a7EpgDY7fGtmecV
/MppRb3od4IUHW5/vIJPK8EPO25YkAVMAX98MjA03NK1yq3Z4qVPVCWlTsxIZD3C
0Kv41gIx/WQqq4trGWkFhbdeb0t9ERUjfOE=
=fIbF
-----END PGP SIGNATURE-----

--a3e9b9de6cf3dc4c98cb83aa2206db48083b13031472f83fa1f6f0a267af--

