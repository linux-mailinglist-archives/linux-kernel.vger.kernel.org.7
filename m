Return-Path: <linux-kernel+bounces-882147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB27C29C09
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 02:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB653B1AD0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 00:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8E6221FB6;
	Mon,  3 Nov 2025 00:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="NQ32fk4k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eIoyL/hv"
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D8C22068B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 00:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762131550; cv=none; b=sSFOSA63/wKE0ViUc33rs0aifs1ECKRqMkCNVJQcUplpYJFj8MRWHzfcle8bha25PbiZEp7W/SVvWeQTX6XJsBMCNudtwJgoK7zc6LwozxjxBAfw777srp8AuUcub97q14699WInB7CczBKOaioAS0AzWh7O/orQZLQCt/eVIbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762131550; c=relaxed/simple;
	bh=BhYBe7h9a6xmIxtQkkw+LctkkKfrhuWqqn/QUiVmV3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUy6n9pTPT9rpKb+QfFr7gKbllBFF0eFCWo+GF0yCUAupLBfjZLu7KDJpoORdpZUfKSoROVSDVj7JAPH2xk6Sx4PQA/r/TFbFoA3W/Dplgp0evEnpr1JKRPbVYgZYIEPT40QCxgqjsDIczfq/qbKMauDM4a2fIyNk6S9n8QW+po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=NQ32fk4k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eIoyL/hv; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id DD0A31D00149;
	Sun,  2 Nov 2025 19:59:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 02 Nov 2025 19:59:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762131545;
	 x=1762217945; bh=VfpHwSy4K3iEN4IlxensOPYh7DJR+ei3YphvNflZmJg=; b=
	NQ32fk4kJ8fOsL6ojnWw7da6lVwPOA0gmCkIe5/zej/Ndkb8KV+Xq8kxww5TP+gN
	CCwEhxQWElkNp+k1Ek4ZLwxyXBL5PIaQuIOx8zkFQ/4RsYveoS25/XUrLs23punt
	nA0XOf0/emoI/jRIjczasuQMFX1dBRjU9a3GKzOa+hvJY/rgMlKdAi7BsG6nswIa
	sYIMG8iiUq7jG3BDfPegAW5e8i4BE9m99MbPOv3rOS4XpRMrfy0HGEgdZ4KSdENl
	0FB0XmSJOC3bIfPNEx85acfXcrG29CU1fvXDJwiZFaJ+3tSol5pWOTnflmXqFjNP
	C+tZ6PwE93JIUzyf6zWujg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762131545; x=1762217945; bh=VfpHwSy4K3iEN4IlxensOPYh7DJR+ei3Yph
	vNflZmJg=; b=eIoyL/hvQ/sxu0WYRPwDYPzId7mv3rPr5u7g301HcAc6gA3+crn
	srigOjpL09ULbhzEQaX4mGAfosW72EXa9BkPPNYpalZun2I6qkKfnehFTIP1//vt
	SqvVfW0e3SEVquLzN+OvkbxVnN3UhSFWY7by/vXTCFjmXSDGzTV9lHLhu+lhb31y
	VnOhOU4YycIWkmEuwGFc/WeZW9AtURZXXp/X47+aVWcfpio1mYrEIXa3cmphqRO0
	JwjPJkKxH8ot8+wDxND/i0U8uBu18dD++X9zHAh0nThno+3AUvWgvOd618Ohjxb8
	475Diw1HdU7inegX8+bdWtHwOp/Lk7tROgA==
X-ME-Sender: <xms:Wf4HafZdz8hfCIbDZwWmk7cCQoW6xJH-mRJ75ALUv4vCyR2hP1iJvA>
    <xme:Wf4HaSFH77gKJX1SV1LDNrYU4503u7S57KZUcQfH_w5koQ8JDBKKksavgAb-PixdT
    8jxKrhhsiC2K1J5nxx_NNelmDuzuYlKwygodfC1LvbQj84p7Q>
X-ME-Received: <xmr:Wf4HabxJ-DB66PnLf3tHlXNKvnnZzBJVFOASNpXmh_MuuuynvvkFLmFNRdtpJVHiWMiiJeo2rlIJPSITKe0bnmlL-7iGJ_eBwgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeeijeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrrhgvkhcu
    ofgrrhgtiiihkhhofihskhhiqdfikphrvggtkhhiuceomhgrrhhmrghrvghksehinhhvih
    hsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepieeluddv
    keejueekhfffteegfeeiffefjeejvdeijedvgfejheetuddvkeffudeinecuffhomhgrih
    hnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehmrghrmhgrrhgvkhesihhnvhhishhisghlvghthhhinhhgshhlrg
    gsrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegrlhgvgigrnhguvghrrdhushihshhkihhnsehinhhtvghlrdgtohhmpdhrtghpth
    htohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthht
    oheprhgvuhhvvghnrdgrsghlihihvghvsehinhhtvghlrdgtohhmpdhrtghpthhtoheplh
    hinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhrohgvtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuhigsehrohgvtg
    hkqdhushdrnhgvth
X-ME-Proxy: <xmx:Wf4Hacm8M9G_yPA7YL--0jAfHz4maPvo-HPakD2ODKSOZQWOaClO3g>
    <xmx:Wf4HacnGZUxysiIlOrWbRvnZWK0CnfXPl1CWOA0T9WDRBQQLAGoAcg>
    <xmx:Wf4HaWxYahb3Z0pOGWR59q_YRgzLcKffuVi4eL4aasw5SFgS6_FEdA>
    <xmx:Wf4HaZokUVB4wSzBWcW9S-7qnpddymG5yNQr89LPebnr2foeGmVieQ>
    <xmx:Wf4HaS-_wmQS36iO2kKu15uj6Xt2kzbcwUanRATVjwsw0eqTkUzj_U_9>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Nov 2025 19:59:04 -0500 (EST)
Date: Mon, 3 Nov 2025 01:59:02 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Reuven Abliyev <reuven.abliyev@intel.com>,
	linux-kernel@vger.kernel.org, Guenter Roeck <groeck@google.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [char-misc] mei: fix error flow in probe
Message-ID: <aQf-VkevcCf7F_04@mail-itl>
References: <20251102180836.1203314-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Cb0eK72uMioendig"
Content-Disposition: inline
In-Reply-To: <20251102180836.1203314-1-alexander.usyskin@intel.com>


--Cb0eK72uMioendig
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 3 Nov 2025 01:59:02 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Reuven Abliyev <reuven.abliyev@intel.com>,
	linux-kernel@vger.kernel.org, Guenter Roeck <groeck@google.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [char-misc] mei: fix error flow in probe

On Sun, Nov 02, 2025 at 08:08:36PM +0200, Alexander Usyskin wrote:
> Dismantle class device last in probe error flow to avoid accessing
> freed memory like:
>=20
> [   87.926774] WARNING: CPU: 9 PID: 518 at kernel/workqueue.c:4234
> __flush_work+0x340/0x390
> ...
> [   87.926912] Workqueue: async async_run_entry_fn
> [   87.926918] RIP: e030:__flush_work+0x340/0x390
> [   87.926923] Code: 26 9d 05 00 65 48 8b 15 26 3c ca 02 48 85 db 48 8b
> 04 24 48 89 54 24 58 0f 85 de fe ff ff e9 f6 fd ff ff 0f 0b e9 77 ff ff
> ff <0f> 0b e9 70 ff ff ff 0f 0b e9 19 ff ff ff e8 7d 8b 0e 01 48 89 de
> [   87.926931] RSP: e02b:ffffc900412ebc00 EFLAGS: 00010246
> [   87.926936] RAX: 0000000000000000 RBX: ffff888103e55090 RCX: 000000000=
0000000
> [   87.926941] RDX: 000fffffffe00000 RSI: 0000000000000001 RDI: ffffc9004=
12ebc60
> [   87.926945] RBP: ffff888103e55090 R08: ffffffffc1266ec8 R09: ffff88811=
09076e8
> [   87.926949] R10: 0000000080040003 R11: 0000000000000000 R12: ffff88810=
3e54000
> [   87.926953] R13: ffffc900412ebc18 R14: 0000000000000001 R15: 000000000=
0000000
> [   87.926962] FS:  0000000000000000(0000) GS:ffff888233238000(0000) knlG=
S:0000000000000000
> [   87.926967] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   87.926971] CR2: 00007e7923b32708 CR3: 00000001088df000 CR4: 000000000=
0050660
> [   87.926977] Call Trace:
> [   87.926981]  <TASK>
> [   87.926987]  ? __call_rcu_common.constprop.0+0x11e/0x310
> [   87.926993]  cancel_work_sync+0x5e/0x80
> [   87.926999]  mei_cancel_work+0x19/0x40 [mei]
> [   87.927051]  mei_me_probe+0x273/0x2b0 [mei_me]
> [   87.927060]  local_pci_probe+0x45/0x90
> [   87.927066]  pci_call_probe+0x5b/0x180
> [   87.927070]  pci_device_probe+0x95/0x140
> [   87.927074]  ? driver_sysfs_add+0x57/0xc0
> [   87.927079]  really_probe+0xde/0x340
> [   87.927083]  ? pm_runtime_barrier+0x54/0x90
> [   87.927087]  __driver_probe_device+0x78/0x110
> [   87.927092]  driver_probe_device+0x1f/0xa0
> [   87.927095]  __driver_attach_async_helper+0x5e/0xe0
> [   87.927100]  async_run_entry_fn+0x34/0x130
> [   87.927104]  process_one_work+0x18d/0x340
> [   87.927108]  worker_thread+0x256/0x3a0
> [   87.927111]  ? __pfx_worker_thread+0x10/0x10
> [   87.927115]  kthread+0xfc/0x240
> [   87.927120]  ? __pfx_kthread+0x10/0x10
> [   87.927124]  ? __pfx_kthread+0x10/0x10
> [   87.927127]  ret_from_fork+0xf5/0x110
> [   87.927132]  ? __pfx_kthread+0x10/0x10
> [   87.927136]  ret_from_fork_asm+0x1a/0x30
> [   87.927141]  </TASK>
>=20
> Tested-by: Guenter Roeck <groeck@google.com>
> Reported-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingslab=
=2Ecom>
> Closes: https://lore.kernel.org/lkml/aQbYAXPADqfiXUYO@mail-itl/
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/lkml/8deef7c4-ac75-4db8-91b7-02cf0e39e371=
@roeck-us.net/
> Fixes: 7704e6be4ed2 ("mei: hook mei_device on class device")
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>

I also confirm this patch fixes the issue:
Tested-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingslab.com>

> ---
>  drivers/misc/mei/pci-me.c       | 13 ++++++-------
>  drivers/misc/mei/pci-txe.c      | 13 ++++++-------
>  drivers/misc/mei/platform-vsc.c | 11 +++++------
>  3 files changed, 17 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
> index b017ff29dbd1..73cad914be9f 100644
> --- a/drivers/misc/mei/pci-me.c
> +++ b/drivers/misc/mei/pci-me.c
> @@ -223,6 +223,10 @@ static int mei_me_probe(struct pci_dev *pdev, const =
struct pci_device_id *ent)
>  	hw->mem_addr =3D pcim_iomap_table(pdev)[0];
>  	hw->read_fws =3D mei_me_read_fws;
> =20
> +	err =3D mei_register(dev, &pdev->dev);
> +	if (err)
> +		goto end;
> +
>  	pci_enable_msi(pdev);
> =20
>  	hw->irq =3D pdev->irq;
> @@ -237,13 +241,9 @@ static int mei_me_probe(struct pci_dev *pdev, const =
struct pci_device_id *ent)
>  	if (err) {
>  		dev_err(&pdev->dev, "request_threaded_irq failure. irq =3D %d\n",
>  		       pdev->irq);
> -		goto end;
> +		goto deregister;
>  	}
> =20
> -	err =3D mei_register(dev, &pdev->dev);
> -	if (err)
> -		goto release_irq;
> -
>  	if (mei_start(dev)) {
>  		dev_err(&pdev->dev, "init hw failure.\n");
>  		err =3D -ENODEV;
> @@ -283,11 +283,10 @@ static int mei_me_probe(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
>  	return 0;
> =20
>  deregister:
> -	mei_deregister(dev);
> -release_irq:
>  	mei_cancel_work(dev);
>  	mei_disable_interrupts(dev);
>  	free_irq(pdev->irq, dev);
> +	mei_deregister(dev);
>  end:
>  	dev_err(&pdev->dev, "initialization failed.\n");
>  	return err;
> diff --git a/drivers/misc/mei/pci-txe.c b/drivers/misc/mei/pci-txe.c
> index 06b55a891c6b..98d1bc2c7f4b 100644
> --- a/drivers/misc/mei/pci-txe.c
> +++ b/drivers/misc/mei/pci-txe.c
> @@ -87,6 +87,10 @@ static int mei_txe_probe(struct pci_dev *pdev, const s=
truct pci_device_id *ent)
>  	hw =3D to_txe_hw(dev);
>  	hw->mem_addr =3D pcim_iomap_table(pdev);
> =20
> +	err =3D mei_register(dev, &pdev->dev);
> +	if (err)
> +		goto end;
> +
>  	pci_enable_msi(pdev);
> =20
>  	/* clear spurious interrupts */
> @@ -106,13 +110,9 @@ static int mei_txe_probe(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
>  	if (err) {
>  		dev_err(&pdev->dev, "mei: request_threaded_irq failure. irq =3D %d\n",
>  			pdev->irq);
> -		goto end;
> +		goto deregister;
>  	}
> =20
> -	err =3D mei_register(dev, &pdev->dev);
> -	if (err)
> -		goto release_irq;
> -
>  	if (mei_start(dev)) {
>  		dev_err(&pdev->dev, "init hw failure.\n");
>  		err =3D -ENODEV;
> @@ -145,11 +145,10 @@ static int mei_txe_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *ent)
>  	return 0;
> =20
>  deregister:
> -	mei_deregister(dev);
> -release_irq:
>  	mei_cancel_work(dev);
>  	mei_disable_interrupts(dev);
>  	free_irq(pdev->irq, dev);
> +	mei_deregister(dev);
>  end:
>  	dev_err(&pdev->dev, "initialization failed.\n");
>  	return err;
> diff --git a/drivers/misc/mei/platform-vsc.c b/drivers/misc/mei/platform-=
vsc.c
> index 288e7b72e942..9787b9cee71c 100644
> --- a/drivers/misc/mei/platform-vsc.c
> +++ b/drivers/misc/mei/platform-vsc.c
> @@ -362,28 +362,27 @@ static int mei_vsc_probe(struct platform_device *pd=
ev)
> =20
>  	ret =3D mei_register(mei_dev, dev);
>  	if (ret)
> -		goto err_dereg;
> +		goto err;
> =20
>  	ret =3D mei_start(mei_dev);
>  	if (ret) {
>  		dev_err_probe(dev, ret, "init hw failed\n");
> -		goto err_cancel;
> +		goto err;
>  	}
> =20
>  	pm_runtime_enable(mei_dev->parent);
> =20
>  	return 0;
> =20
> -err_dereg:
> -	mei_deregister(mei_dev);
> -
> -err_cancel:
> +err:
>  	mei_cancel_work(mei_dev);
> =20
>  	vsc_tp_register_event_cb(tp, NULL, NULL);
> =20
>  	mei_disable_interrupts(mei_dev);
> =20
> +	mei_deregister(mei_dev);
> +
>  	return ret;
>  }
> =20
> --=20
> 2.43.0
>=20

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--Cb0eK72uMioendig
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmkH/lYACgkQ24/THMrX
1yzZXgf5Afb3d9jpS0E4uGrOCTXX4tDVjg/2jCz1nZusCNLo0wQByPGPILeNmJM4
9UyvruAtQ4Ph2v6T7hB5fAl66ZosjXX5daenxPP9B+2ooJORWLSaNCf/IwdAksIC
D+pS8o3fpBmIKbMrSF65ieNak46EsB4n2bjMPIwK7O3MTRKIk1mR/YYyt75Qk6oy
FpZ7/3ZjtXzJWsFptgKbbnMfYnb0Sf1SI+Obn9isbpJgkxMDnwKN2X59YzdzOu/R
VXVSbsR1qcbu0SkwoZ/D1LmynnSb7kgKJ9Seb+Fx8BIO3wSlp7oCgO0o0vsVGGRX
wcjUsOKOb0yhYxJHsOOU4WpRA1cnng==
=McZF
-----END PGP SIGNATURE-----

--Cb0eK72uMioendig--

