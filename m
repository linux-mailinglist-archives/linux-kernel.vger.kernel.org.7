Return-Path: <linux-kernel+bounces-761000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F151B1F2D3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 09:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7701C205DE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D726B277CB2;
	Sat,  9 Aug 2025 07:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b="Rou4xzen"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFDD279DAA
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 07:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754724339; cv=none; b=HyVgtza++jloePOlHM9vXOEFMp7S9WjdFmTs/DcwOtSquUa9hHNGhNglep6oSa0sWb73KNr1dcJz1wbEyyOpsg1BfY9iVhmNjYPvZWwhQe4lZmTEpqrcv+Xo6jUceB6+Hb7SwIH8HXYAvlZRF6m0c7sZELjsr+vWLwmyYEnk7VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754724339; c=relaxed/simple;
	bh=Yz+i5FQslQsUtwK+nDCiUKQt+7XZHV02A+u3AT/7/SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=t6iTzF+mD75gjj0ICW6xdq0gLXDSqk0FupHWohYULXYyGcvVlQpWZ6SXOTW/N+7f7KsSe17ZW7ENV9qPlnwwC0pAn5SkiknJ2TpMFz82gUF/6eRAJJzAhjuUSJCnS2/0J27yIGlDMu5eYPfRn8XlR97OCb/AGIqnqn3EmWKoxy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b=Rou4xzen; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 55BC8240028
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 09:25:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
	s=1984.ea087b; t=1754724329;
	bh=PnOBJp/dCmnaAVtEczBA0DMOWb+q7+EVB4/c2xyrUM8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=Rou4xzenIuode5Do3awcl5z3VhgrbTTW/tCbo9z0pzui0UiSbEl4x7HTmGo2mQo4A
	 sM6cravd4fnjo+R09JVMrikPSEYUPSx+Br0zbPqcNYpbv2QfWqs/gvtOjfZm6GWQeb
	 ttzn5YeRxeChPoO+yTzMwblVSIrlAiIHQv9OXg9sQHzwVjD2J7CTwMCffJm9ZQNokE
	 6lL0AJQrUkZnoijghDQpSww6rSjOgEH5I2kwCSJTzilnORypJddG9IwI2qxVtlN7Hh
	 ciIawjN7IxA5baZm0gos3jIDRNv5gC7gW3OVBi1LI6RH6yxyQO0K9GQqUCoIPDIP3e
	 3jm/CTX+btzjY0J0upfyPvwwsHargKgRb/Z+5wsOfNitMRYVJEOVs0YQ8ZdxDTfvpK
	 9W8kU12E89XTPBnaYGmCB9Xoo9+ykTQ8FOEmaI4afIXV3q4HVTNDn/sm2ziYalVyQr
	 gzpnidCqnTf3wKWUmy7+hcAl6Om5ZHOsflKNKeAGrlOJte5/poN
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4bzXVb1kmTz9rxD;
	Sat,  9 Aug 2025 09:25:27 +0200 (CEST)
Date: Sat, 09 Aug 2025 07:25:29 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: linux-sunxi@lists.linux.dev, linux-sound@vger.kernel.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [BISECTED] NULL pointer dereference while probing sun8i-codec
Message-ID: <aJb311bMDc9x-dpW@probook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

When booting the Allwinner H2+ SoC (Orange Pi Zero) with the audio codec
enabled, recent kernels crash with a NULL pointer dereference:

[    0.976256] 8<--- cut here ---
[    0.979398] Unable to handle kernel NULL pointer dereference at virtual address 00000000 when read
[    0.988365] [00000000] *pgd=00000000
[    0.991955] Internal error: Oops: 5 [#1] SMP ARM
[    0.996572] Modules linked in:
[    0.999632] CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.15.0-rc5-00242-gc208844ffc64 #56 NONE
[    1.008846] Hardware name: Allwinner sun8i Family
[    1.013545] PC is at strcmp+0x0/0x34
[    1.017135] LR is at snd_soc_lookup_component_nolocked+0x64/0xa4
[    1.023151] pc : [<c08bf8e4>]    lr : [<c073f82c>]    psr: 00000013
[    1.029412] sp : e0821de8  ip : 00000000  fp : 00000000
[    1.034632] r10: c0c65f4c  r9 : c0c49834  r8 : 0000001b
[    1.039853] r7 : c0aff7e0  r6 : c165b810  r5 : c10dc614  r4 : c1df6340
[    1.046374] r3 : c09b1994  r2 : 0000006e  r1 : c0aff7e0  r0 : 00000000
[    1.052896] Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[    1.060027] Control: 10c5387d  Table: 4000406a  DAC: 00000051
[    1.065767] Register r0 information: NULL pointer
[    1.070473] Register r1 information: non-slab/vmalloc memory
[    1.076132] Register r2 information: non-paged memory
[    1.081183] Register r3 information: non-slab/vmalloc memory
[    1.086840] Register r4 information: slab kmalloc-256 start c1df6300 pointer offset 64 size 256
[    1.095552] Register r5 information: non-slab/vmalloc memory
[    1.101210] Register r6 information: slab kmalloc-1k start c165b800 pointer offset 16 size 1024
[    1.109919] Register r7 information: non-slab/vmalloc memory
[    1.115576] Register r8 information: non-paged memory
[    1.120626] Register r9 information: non-slab/vmalloc memory
[    1.126284] Register r10 information: non-slab/vmalloc memory
[    1.132027] Register r11 information: NULL pointer
[    1.136817] Register r12 information: NULL pointer
[    1.141607] Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
[    1.147610] Stack: (0xe0821de8 to 0xe0822000)
[    1.151969] 1de0:                   c0aff7e0 c165b810 c165b810 e0821e20 0000001b c0741fa4
[    1.160142] 1e00: c1df650c c165b810 c165b810 c07557d0 c1df5f80 c17e1000 c165b810 c056dad8
[    1.168315] 1e20: c1dbab40 c1df6600 00000007 d3dfed03 c165b810 00000205 c10dc9fc 00000000
[    1.176487] 1e40: c1df5738 c0567cf0 c165b810 c05684a0 c165b810 c10dc9fc c165b810 00000000
[    1.184660] 1e60: c1df5738 c05685d0 60000013 c0c49834 c1125878 c10dc9fc c165b810 00000000
[    1.192833] 1e80: c1df5738 c05687b4 c165b810 c10dc9fc c165b854 c1416000 c1df5738 c0568a2c
[    1.201005] 1ea0: 00000000 c10dc9fc c056899c c0566490 c1416000 c1416058 c1542ab4 d3dfed03
[    1.209178] 1ec0: c1416000 c10dc9fc c1df5700 00000000 c1416000 c05676b4 c0aff880 00000000
[    1.217351] 1ee0: c10dc9fc c1450000 00000000 c0b0df40 c10e9000 c0569738 c0c2e2bc c1450000
[    1.225523] 1f00: 00000000 c010e26c 000004c4 00000000 00000000 00000000 00000000 00000000
[    1.233695] 1f20: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    1.241867] 1f40: 00000000 00000000 00000000 00000000 00000000 d3dfed03 c15a1980 000000f4
[    1.250040] 1f60: c15a1980 00000006 c0b0df40 c0c49854 c0c49834 c0c01220 00000006 00000006
[    1.258212] 1f80: 00000000 c0c004d0 c1004e00 c08ca784 00000000 00000000 00000000 00000000
[    1.266384] 1fa0: 00000000 c08ca7a0 00000000 c010014c 00000000 00000000 00000000 00000000
[    1.274556] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    1.282728] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[    1.290896] Call trace:
[    1.290910]  strcmp from snd_soc_lookup_component_nolocked+0x64/0xa4
[    1.299807]  snd_soc_lookup_component_nolocked from snd_soc_unregister_component_by_driver+0x2c/0x44
[    1.308948]  snd_soc_unregister_component_by_driver from snd_dmaengine_pcm_unregister+0x28/0x64
[    1.317654]  snd_dmaengine_pcm_unregister from devres_release_all+0x98/0xfc
[    1.324625]  devres_release_all from device_unbind_cleanup+0xc/0x60
[    1.330899]  device_unbind_cleanup from really_probe+0x220/0x2c8
[    1.336913]  really_probe from __driver_probe_device+0x88/0x1a0
[    1.342841]  __driver_probe_device from driver_probe_device+0x30/0x110
[    1.349375]  driver_probe_device from __driver_attach+0x90/0x178
[    1.355390]  __driver_attach from bus_for_each_dev+0x7c/0xcc
[    1.361056]  bus_for_each_dev from bus_add_driver+0xcc/0x1ec
[    1.366720]  bus_add_driver from driver_register+0x80/0x11c
[    1.372301]  driver_register from do_one_initcall+0x58/0x23c
[    1.377973]  do_one_initcall from kernel_init_freeable+0x198/0x1f4
[    1.384168]  kernel_init_freeable from kernel_init+0x1c/0x12c
[    1.389925]  kernel_init from ret_from_fork+0x14/0x28
[    1.394982] Exception stack(0xe0821fb0 to 0xe0821ff8)
[    1.400033] 1fa0:                                     00000000 00000000 00000000 00000000
[    1.408205] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    1.416376] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    1.422991] Code: e5e32001 e3520000 1afffffb e12fff1e (e4d03001)
[    1.429166] ---[ end trace 0000000000000000 ]---
[    1.433797] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    1.441577] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---


This particular error path is taken after platform_probe returns -EPROBE_DEFER
to call_driver_probe and really_probe calls device_unbind_cleanup.

The parameters to the strcmp call in snd_soc_lookup_component_nolocked are
component->driver->name = NULL and driver_name = "snd_dmaengine_pcm".

I have bisected this to:

commit 144d6dfc7482455eabf8e8caa974a6e8d9572705
Author: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date:   Mon May 12 02:33:16 2025 +0000

    ASoC: soc-core: merge snd_soc_unregister_component() and snd_soc_unregister_component_by_driver()

    We have below 2 functions, but these are very similar

    (A)     snd_soc_unregister_component_by_driver()
    (B)     snd_soc_unregister_component()

    (A)     void snd_soc_unregister_component_by_driver(...)
            {
                    ...

    (a)             mutex_lock(&client_mutex);
     ^ (X)          component = snd_soc_lookup_component_nolocked(dev, component_driver->name);
     |              if (!component)                                    ^^^^^^^^^^^^^^^^^^^^^^
     |                      goto out;
    (b)
     |              snd_soc_del_component_unlocked(component);
     v
            out:
    (c)             mutex_unlock(&client_mutex);
            }

    (B)     void snd_soc_unregister_component_by_driver(...)
            {
    (a)             mutex_lock(&client_mutex);
     ^              while (1) {
     | (X)                  struct snd_soc_component *component = snd_soc_lookup_component_nolocked(dev, NULL);
     |                                                                                                   ^^^^
    (b)                     if (!component)
     |                              break;
     |
     |                      snd_soc_del_component_unlocked(component);
     v              }
    (c)             mutex_unlock(&client_mutex);
            }

    Both are calling lock (a), find component and remove it (b), and
    unlock (c). The big diff is whether use driver name for lookup() or
    not (X).

    Merge these into snd_soc_unregister_component_by_driver() (B), and
    snd_soc_unregister_component_by_driver() (A) can be macro.

    Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    Link: https://patch.msgid.link/87h61qy2vn.wl-kuninori.morimoto.gx@renesas.com
    Signed-off-by: Mark Brown <broonie@kernel.org>

 include/sound/soc.h  |  2 +-
 sound/soc/soc-core.c | 30 +++++-------------------------
 2 files changed, 6 insertions(+), 26 deletions(-)


Reverting this commit on top of almost-v6.17-rc1 (v6.16-12250-gc30a13538d9f8b)
results in a successful boot. sun8i-codec's probe returns -EPROBE_DEFER
the first time, and success the second time.


Best regards,
J. Neuschäfer

