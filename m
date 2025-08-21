Return-Path: <linux-kernel+bounces-779475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03753B2F492
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B018A16578F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1451D2D3A6E;
	Thu, 21 Aug 2025 09:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qIlOk6ZR"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C943122655B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769854; cv=none; b=Bz2B27ZTtLRvT3NcwQgHQ2EmymA7xUsqsmDoc21nXVIZSkr5OLHlC/hD/gumnys7deZexLZ3DkqoIgXXlN/zFGO5S1bHLnEcTrzfLPuFLmHO4BmQWtUTcJkwfdRrBnfd1kegBFHtXL8tB0trb7bxcqqf4ryYqHOD7i0U1aUBOEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769854; c=relaxed/simple;
	bh=0xDdzDyCErDeuQQlVVx9NmwKlO+IcnoKiX4/jFc87O0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=WilEHV8ryz9mEykIkQF6m8LX0yNFWzxiPSTCduAAAUngFgUpsxUcWGkCQJURZ8izHBDr4Bv8hLYvWDolgcuG/E22GMFTLL+YoNZ9LWoNZm09qQSs79ttfrkv8ktRcU5GjmmUESfQctnAm28/qKmNZ3O98RlO7gbG5gVrVntafK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qIlOk6ZR; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250821095049euoutp02ab5777a878f9968924adcb6573e6244e~dv2BGkc7w2585925859euoutp023
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:50:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250821095049euoutp02ab5777a878f9968924adcb6573e6244e~dv2BGkc7w2585925859euoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755769850;
	bh=HSvuQ3ZafL8FGWMfbxoBhMAcsMdHdvxyBcoWoRljZZM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=qIlOk6ZRqf7+QB+XD5yt3mhe8+5lryKrNJpVK45GhB+j0m2CCy4DDnfb/7ckRhWJK
	 G9i+HO3O4bnVtYH+D/ONJtw1UcsgmO3u3HhNFN20rCgUzq7iBwbj/LZC/yTAd2cRw6
	 0KmjIc/5j8C6Rax9gDtPf5coaCtgAVf4QC1khSs4=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250821095049eucas1p19e5b485fe044f78c1cfcb62b720fd974~dv2Ao05Ph2463024630eucas1p1e;
	Thu, 21 Aug 2025 09:50:49 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250821095048eusmtip104d6456e3cae6213f4fc65d90468cf00~dv1-pHhmh0661206612eusmtip1s;
	Thu, 21 Aug 2025 09:50:48 +0000 (GMT)
Message-ID: <d5c31ec9-84c1-45ea-8c0d-aba78ebd6481@samsung.com>
Date: Thu, 21 Aug 2025 11:50:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/8] drm: verisilicon: add a driver for Verisilicon
 display controllers
To: Maud Spierings <maud_spierings@hotmail.com>
Cc: Laurent.pinchart@ideasonboard.com, airlied@gmail.com,
	andrzej.hajda@intel.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org, fustini@kernel.org, guoren@kernel.org,
	heiko@sntech.de, jernej.skrabec@gmail.com, jonas@kwiboo.se,
	krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, neil.armstrong@linaro.org, p.zabel@pengutronix.de,
	rabenda.cn@gmail.com, rfoss@kernel.org, robh@kernel.org, simona@ffwll.ch,
	tzimmermann@suse.de, uwu@icenowy.me, wefu@redhat.com, ziyao@disroot.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <AM7P189MB10098641C0B58ACFA3502A03E332A@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
X-CMS-MailID: 20250821095049eucas1p19e5b485fe044f78c1cfcb62b720fd974
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250821093817eucas1p1d1f41f99c9fcf800c8230fb5795ad1d1
X-EPHeader: CA
X-CMS-RootMailID: 20250821093817eucas1p1d1f41f99c9fcf800c8230fb5795ad1d1
References: <4e6d1a0f-4270-4d25-86c5-e4ec3721c451@samsung.com>
	<CGME20250821093817eucas1p1d1f41f99c9fcf800c8230fb5795ad1d1@eucas1p1.samsung.com>
	<AM7P189MB10098641C0B58ACFA3502A03E332A@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>



On 8/21/25 11:38, Maud Spierings wrote:
>> So I am trying to make it work on JH7110 as well, and here is the
>> problem:
>>
>> =5B    5.564433=5D ------------=5B cut here =5D------------             =
                                                                           =
                                                   =5B    5.569161=5D refco=
unt_t: addition on 0; use-after-free.                                      =
                                                                           =
                    =5B    5.574485=5D WARNING: CPU: 2 PID: 71 at lib/refco=
unt.c:25 refcount_warn_saturate+0x110/0x162                                =
                                                                =5B    5.57=
4537=5D Modules linked in:                                                 =
                                                                           =
                                 =5B    5.574560=5D CPU: 2 UID: 0 PID: 71 C=
omm: kworker/u17:2 Not tainted 6.17.0-rc1-g60ec647ec20c-dirty =2377 NONE   =
                                                                           =
    =5B    5.574596=5D Hardware name: StarFive
>> VisionFive 2 v1.2A (DT)                                                 =
                                                                           =
    =5B    5.574613=5D Workqueue: events_unbound deferred_probe_work_func  =
                                                                           =
                                                =5B    5.574654=5D epc : re=
fcount_warn_saturate+0x110/0x162                                           =
                                                                           =
                 =5B    5.574682=5D  ra : refcount_warn_saturate+0x110/0x16=
2                                                                          =
                                                             =5B    5.57471=
0=5D epc : ffffffff81336608 ra : ffffffff81336608 sp : ffffffc6006e7530    =
                                                                           =
                              =5B    5.574732=5D  gp : ffffffff8514c1c0 tp =
: ffffffd6c14ba580 t0 :
>> ffffffc6006e7134                                                        =
                                                     =5B    5.574753=5D  t1=
 : fffffffef0a29898 t2 : 5f746e756f636665 s0 : ffffffc6006e7550            =
                                                                           =
                      =5B    5.574774=5D  s1 : ffffffff83c058a8 a0 : 000000=
000000002a a1 : 0000000000000004                                           =
                                                                  =5B    5.=
574794=5D  a2 : 0000000000000000 a3 : ffffffff801ef586 a4 : 000000000000000=
0                                                                          =
                                   =5B    5.574813=5D  a5 : 000000000000000=
0 a6 : fffffffef0a29899 a7 : 0000000000000003                              =
                                                                           =
    =5B    5.574833=5D  s2 : ffffffd6c35e68e8 s3 : ffffffd6c35e6990 s4 :
>> ffffffd6c33dc008                                                        =
                                                     =5B    5.574854=5D  s5=
 : 0000000000000000 s6 : 1ffffffad867b801 s7 : 0000000000000000            =
                                                                           =
                      =5B    5.574873=5D  s8 : ffffffd6c35e6990 s9 : 000000=
0000000000 s10: ffffffd6c3099058                                           =
                                                                  =5B    5.=
574894=5D  s11: 1ffffffad861320b t3 : 1ffffff8c00dce34 t4 : fffffffef0a2989=
8                                                                          =
                                   =5B    5.574915=5D  t5 : fffffffef0a2989=
9 t6 : ffffffc6006e6f38                                                    =
                                                                           =
    =5B    5.574933=5D status: 0000000200000120 badaddr: 0000000000000000 c=
ause:
>> 0000000000000003                                                        =
                                             =5B    5.574952=5D =5B<fffffff=
f81336608>=5D refcount_warn_saturate+0x110/0x162                           =
                                                                           =
                  =5B    5.574985=5D =5B<ffffffff8193a506>=5D drm_bridge_ge=
t+0x66/0x6e                                                                =
                                                                  =5B    5.=
575022=5D =5B<ffffffff8001f26e>=5D drm_bridge_attach+0x54/0x5a2            =
                                                                           =
                                       =5B    5.575055=5D =5B<ffffffff80027=
40e>=5D vs_bridge_init+0x3bc/0x4ba                                         =
                                                                           =
            =5B    5.575087=5D =5B<ffffffff82313026>=5D
>> vs_drm_initialize+0xe0/0x2f2                                            =
                                                                           =
       =5B    5.575126=5D =5B<ffffffff80027ca4>=5D vs_dc_probe+0x758/0x85c =
                                                                           =
                                                       =5B    5.575156=5D =
=5B<ffffffff8233123c>=5D platform_probe+0xac/0x138                         =
                                                                           =
                             =5B    5.575186=5D =5B<ffffffff8232b2a8>=5D re=
ally_probe+0x164/0x59e                                                     =
                                                                           =
  =5B    5.575221=5D =5B<ffffffff8232b818>=5D __driver_probe_device+0x136/0=
x266
>> =5B    5.575257=5D =5B<ffffffff8232bb18>=5D driver_probe_device+0x56/0x2=
14
>> =5B    5.575292=5D =5B<ffffffff8232bdf0>=5D __device_attach_driver+0x11a=
/0x278
>> =5B    5.575329=5D =5B<ffffffff823272d8>=5D bus_for_each_drv+0xea/0x16e
>> =5B    5.575363=5D =5B<ffffffff8232c680>=5D __device_attach+0x160/0x2d4
>> =5B    5.575398=5D =5B<ffffffff8232ca06>=5D device_initial_probe+0xe/0x1=
6
>> =5B    5.575434=5D =5B<ffffffff823291d8>=5D bus_probe_device+0xfe/0x134
>> =5B    5.575468=5D =5B<ffffffff82329c62>=5D deferred_probe_work_func+0x1=
28/0x1d6
>> =5B    5.575503=5D =5B<ffffffff80126aae>=5D process_one_work+0x5c0/0xe76
>> =5B    5.575543=5D =5B<ffffffff80129da6>=5D worker_thread+0x6d4/0x1316
>> =5B    5.575572=5D =5B<ffffffff801429ce>=5D kthread+0x29a/0x570
>> =5B    5.575608=5D =5B<ffffffff8004693e>=5D ret_from_fork_kernel+0x10/0x=
9a
>> =5B    5.575643=5D =5B<ffffffff835f55f6>=5D ret_from_fork_kernel_asm+0x1=
6/0x18
>> =5B    5.575682=5D ---=5B end trace 0000000000000000 =5D---
>>
>>
>> When a bridge is allocated with kzalloc, its kref count is initialized
>> to zero. The drm_bridge_attach() function then calls drm_bridge_get() on
>> this bridge, which sees the zero refcount and triggers a use-after-free
>> warning because it assumes the object has already been freed.
>>
>> To fix this, the bridge's refcount must be initialized with kref_init()
>> after allocation and before it's attached.
>=20
> Do you have a tree I can look at? I am very interested in getting this wo=
rking on the jh7110. looked at it myself a week ago, but got lost quite qui=
ckly. If you end up upstreaming it I will definetly be there to test it.

I first started working od getting the Keith version working and have
the 'old' tree here =5B1=5D. It works with older version of the DC driver.

=5B1=5D - https://github.com/mwilczy/linux/commits/dpu_Aug_9_2/

So the above version works, however the display was 'purple-ish', colors
were skewed. I shared the image in the 'Mainline Linux for RISC-V'
telegram chat.

For the current version from Icenowy it's still a bit messy to share
however it includes addition to inno-hdmi driver to make it works a bit
more like dw-hdmi currently - introduce a probe function, not just
bind, so it doesn't use component framework. Plus changes to
clocks/resets that were discussed.

>=20
> Did you actually manage to get display out over hdmi? The hdmi output fro=
m last years starfive driver gave me some strange output issues that I'm cu=
rrently just living with, but would love to see it gone.
>=20

On the current version of the DC driver I'm still working on it.

Best regards,
--=20
Michal Wilczynski <m.wilczynski=40samsung.com>

