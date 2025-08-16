Return-Path: <linux-kernel+bounces-771978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6C2B28D73
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 13:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C701B66CFD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 11:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BDB2E11BC;
	Sat, 16 Aug 2025 11:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="YrzuUa2n"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7B6280CFA
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 11:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755344482; cv=none; b=PgoNGCCXEMckSMpZd3Mb+z7DOYgCDJng4niWaAqbekalqdS31Z9GE+grO16SX2g3oHm09+LO0DdhOR+1trtF0RfJRnsy904qb6/NbBqOGmsW3Uy+GMuCJtla6xvBJwJw0oJmfhbYXq1oM+LTTKpLx1ubpc1o7LEGxabCiOi2OH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755344482; c=relaxed/simple;
	bh=bg3O/7VPI3Vdi6agm8MsLnTnQoTd2YkaGMWAGLzlcxs=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From; b=rvl+iZXkE1sgg9EomInuEFPwaWOd+QCdjtmLABXbHCZ36EsL9GGxc59/gauPxW+u7jmg1GNIZh11T5ZkgYrZKDCJ3S1Hd0Dc4RomjdrsR07OvncXN0cI96mMAlSHu68t1yDM7K0XldT2490/IAuucejCwN/n5IzgnCXRhgZ7P0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=YrzuUa2n; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1755344474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=1h/bw6MWPhtYkzd58nPhjPCtWtPfRHnCtDvW+x+ZnZs=;
	b=YrzuUa2n/RG3q4uFVXmqTv7AN8BKqBpwh3l7+3yKaVfgUsQRR3E+V1wPoIU0rn9ML2nQlx
	oFYh2NMX0x5PzdhvlKswjrQfVEPw4uFHLeV4Gmg6WwTBRHU8JutCVx9RT5Wc53mQw61psH
	3jrgTcULoNtIvj5zM8NfN+GLqbcQxzQaahz04OrB2ixA+tUTy/5tbyff1ptlKbVuNbQAQz
	D4r9mItjwGIYuzL4J7JPfwq1++YKiTPhk77CY8gVMRR/7WBhkCkX426dg73xwrXGTxxJZq
	QkZypru9pZXZMU6kvTd5XUZRUgHxArDoLP8jcwhJIKc6fT5cy/szKCOO07hvtQ==
Content-Type: multipart/signed;
 boundary=35f8d77e639258498209840db9ef4dfbb4a4ae4bdacbba93267a554176a9;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Sat, 16 Aug 2025 13:40:44 +0200
Message-Id: <DC3TO97G0RMI.3KKUONOCLJHFB@cknow.org>
To: <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, "Diederik de Haas"
 <didi.debian@cknow.org>
Subject: [BUG report] kernel warnings with Samsung 970 EVO 2TB SSD
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
X-Migadu-Flow: FLOW_OUT

--35f8d77e639258498209840db9ef4dfbb4a4ae4bdacbba93267a554176a9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

I have a Samsung 970 EVO 2TB SSD and I see these kernel warnings:

root@nanopi-r5s:~# uname -a
Linux nanopi-r5s 6.16-arm64-cknow #1 SMP PREEMPT Debian 6.16-1 (2025-07-28)=
 aarch64 GNU/Linux
root@nanopi-r5s:~# dmesg --level 0,1,2
root@nanopi-r5s:~# dmesg --level 3
root@nanopi-r5s:~# dmesg --level 4
[    2.410231] dw-apb-uart fe660000.serial: forbid DMA for kernel console
[    5.234812] gpio gpiochip0: Static allocation of GPIO base is deprecated=
, use dynamic allocation.
[    5.242112] gpio gpiochip1: Static allocation of GPIO base is deprecated=
, use dynamic allocation.
[    5.246222] gpio gpiochip2: Static allocation of GPIO base is deprecated=
, use dynamic allocation.
[    5.252811] gpio gpiochip3: Static allocation of GPIO base is deprecated=
, use dynamic allocation.
[    5.265791] gpio gpiochip4: Static allocation of GPIO base is deprecated=
, use dynamic allocation.
[    5.741901] r8169 0000:01:00.0: can't read MAC address, setting random o=
ne
[    5.806644] pci 0001:10:00.0: Primary bus is hard wired to 0
[    5.849952] r8169 0001:11:00.0: can't read MAC address, setting random o=
ne
[    6.017270] pci 0002:20:00.0: Primary bus is hard wired to 0
[    6.393688] nvme nvme0: missing or invalid SUBNQN field.
[   21.484306] nvme nvme0: using unchecked data buffer
root@nanopi-r5s:~# dmesg | grep nvme
[    6.386187] nvme nvme0: pci function 0002:21:00.0
[    6.386697] nvme 0002:21:00.0: enabling device (0000 -> 0002)
[    6.393688] nvme nvme0: missing or invalid SUBNQN field.
[    6.397901] nvme nvme0: D3 entry latency set to 8 seconds
[    6.428168] nvme nvme0: 4/0/0 default/read/poll queues
[    6.465173]  nvme0n1: p1
[   12.522314] systemd[1]: Starting modprobe@nvme_fabrics.service - Load Ke=
rnel Module nvme_fabrics...
[   12.973871] systemd[1]: modprobe@nvme_fabrics.service: Deactivated succe=
ssfully.
[   12.977051] systemd[1]: Finished modprobe@nvme_fabrics.service - Load Ke=
rnel Module nvme_fabrics.
[   21.484306] nvme nvme0: using unchecked data buffer

Before I put this SSD into my FriendlyELEC NanoPi R5S (rk3568; arm64)
I had it in my main PC (AMD Ryzen 1800X; amd64) where I had these
warnings as well, so it seems directly connected to the drive, not the
device it's plugged into.

I wonder if something can be done to fix those warnings.
I'm not aware of these warnings causing actual problems, but I haven't
'really' used it thus far (mostly to store some media files), but I want
to use my NanoPi R5S as my server (with f.e. my git repos), so I want to
be extra sure my data won't be at risk. And I don't like ignoring kernel
warnings; I assume they're warnings for a reason.

Some more data about the drive:

root@nanopi-r5s:~# nvme list
Node                  Generic               SN                   Model     =
                               Namespace  Usage                      Format=
           FW Rev
--------------------- --------------------- -------------------- ----------=
------------------------------ ---------- -------------------------- ------=
---------- --------
/dev/nvme0n1          /dev/ng0n1            xxxxxxxxxxxxxxx      Samsung SS=
D 970 EVO Plus 2TB             0x1        534.51  GB /   2.00  TB    512   =
B +  0 B   2B2QEXM7

root@nanopi-r5s:~# nvme get-feature /dev/nvme0 -f 3
get-feature:0x03 (LBA Range Type): NVMe status: Invalid Namespace or Format=
: The namespace or the format of that namespace is invalid(0x200b)

I don't know if it would/can be risky to share the Serial Number, so I
blanked that out, but I can provide that if that would be helpful.

root@nanopi-r5s:~# lspci -v -s 0002:21:00.0
0002:21:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVM=
e SSD Controller SM981/PM981/PM983 (prog-if 02 [NVM Express])
        Subsystem: Samsung Electronics Co Ltd SSD 970 EVO/PRO
        Flags: bus master, fast devsel, latency 0, IRQ 75
        Memory at f0200000 (64-bit, non-prefetchable) [size=3D16K]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable- 64bit+
        Capabilities: [70] Express Endpoint, IntMsgNum 0
        Capabilities: [b0] MSI-X: Enable+ Count=3D33 Masked-
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [148] Device Serial Number 00-00-00-00-00-00-00-00
        Capabilities: [158] Power Budgeting <?>
        Capabilities: [168] Secondary PCI Express
        Capabilities: [188] Latency Tolerance Reporting
        Capabilities: [190] L1 PM Substates
        Kernel driver in use: nvme
        Kernel modules: nvme

But I did not change the Device Serial Number from lspci.
AFAIK I have the latest firmware (checked with fwupd).

Happy to provide additional data, but as I don't know what would be
useful, I figured I'll leave it up to the experts to ask for it.

Cheers,
  Diederik

--35f8d77e639258498209840db9ef4dfbb4a4ae4bdacbba93267a554176a9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaKBuUgAKCRDXblvOeH7b
biC4AP4xV9B0s22aFzjgq9ft23dgNZj5MmayWFZh8GlHwcLUqwD7BfjNzNwTKk/7
eKwWc79zBlllICr8AE2I9bdnDVnMjgE=
=yiAO
-----END PGP SIGNATURE-----

--35f8d77e639258498209840db9ef4dfbb4a4ae4bdacbba93267a554176a9--

