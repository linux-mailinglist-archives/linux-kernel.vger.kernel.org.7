Return-Path: <linux-kernel+bounces-881855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A213C29126
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 16:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F33694E23A4
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 15:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44952154BE2;
	Sun,  2 Nov 2025 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XSD2UeZs"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4A1A930
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762097875; cv=none; b=XSznFDTNJIP/86PwcW4NuHWYDpqnKwJZo0izzxcV4va1Ag77Ft7xF/veOntkw2FEMkptffQljPu5/DnNdtU58XJkA2Q+dd7pBv2SqyMROfdNQzpF7tX+7Yq0Y/nFcQaEjGKLaR10BRcF9Vrp92yrr7fCzWx3a+3VVvvWk/smm70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762097875; c=relaxed/simple;
	bh=9yHmdhpNZf0U+yDBBiY9IyyK1gbUDKyL8nJcBdejmEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q4eNJu8oD9wkeOc42xm3athC4bvRt+TumQz+5mUwR/LrScOe9hhCuWacKgzBayHDvCqMhS+gKWtjwn8WBVjBqogRvfFUM3iRM+qt/XWlteRRKokzatmjN6QoOTuGQeH903HGLYAHvg3WmDHXQM5DWRxfbzMN7cfkOW6AFu+tTNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XSD2UeZs; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2959197b68eso107655ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 07:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762097873; x=1762702673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFYZ8T4QEJnU8ZUt8nnb7h5E7A0/jdywrA81gUOdtgc=;
        b=XSD2UeZsYUdTuURx0EGNOpZ9LhxkSFnNqD+4d/FVYn4EWTda4c2i2GBFkQ+4XIEYTs
         SzdigQRXasK0ZUzZW8AX5j/9kZ79ctdrKNZV4h3U/PJnsk7GWa+vklZZwmVnE67vU+9m
         1GNRcR6jVTx8VZwZ8zJgy1EGRnEOcimgS8i4LoG/sknx4Bt0DNhtD91WSuMV8v9aWR1Q
         A8HJ01YhVQ1Ze8Quv+KfPL9cl0goOAv8jI8hSkx7IMJD0HwMFkHT6Ga5O4dP8OoQuvya
         FaegrrxpSkmJf0L3GMRgeTkGPz9O2KL7gKTOoN5QCN5TsiHS+vSKUTx9w2HKmUMXyX8e
         OM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762097873; x=1762702673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pFYZ8T4QEJnU8ZUt8nnb7h5E7A0/jdywrA81gUOdtgc=;
        b=EDch7TeFADphI0b8tXWeAT2f0Z3yETY6oAJTwMlQfQXHTkZ2qg8WgkEeV8MpB4bfDT
         jK9iewZaQbz2m/SgGZVq+cDPLGTgmVx7S4gPEvO6+oGNnGme3CxnscTuYkOcMvelvePX
         FVIdSs8sUEA1NKDYr/3BzKB06EHtrfW8yTguLNZNnzM2aa1AdzxRo5KBtinrpaFpqRIa
         G9g9opv3BY7xIMPGY5ruVpXr3vYdsez1MPO1OKWaiqUfGEruSo1WL1r1esdewGrRYcnt
         dYsrmLqeklrH79dlfzmLKvov9pbbjqLmBB4fkbWLRf39qTNzUafGaRqa1+ixSSbca7V3
         hYeA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ+xC7INL61RmPUnZVdJkOA1XRjpSIUNegNQ9Hxrrdq6uT5xzixcnBNCdjEOxBir07oo1F7pnRHF4h/Qg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzih6o2iM+CVdAUbv+iV7bO8tdQlmksR8s5ZBg5Vz9itRVmkZaE
	ZDVtMMWGyO1nC77wZ8+6gbrzda1v98gIUG5xi7tLbodiue98G+5m8mknkNL/3W4f7iLOzXYmTWS
	Ncl9qWYk9OnIvXpIXh+Ol0nfTuNl5KWTngnjJO5HO
X-Gm-Gg: ASbGnctMlqXpTADe1nrH90Xcv/USXH5fRY9IRNbGpyjKIGk/TTyYSt2Lc5sjRffqfpP
	Q3pZiBZb4CUJREripCpjuRSsIbXk+86UrFUeUKQc7DYKWNZueSKIJ5fVdJzseOjb1BaOx+1pjP0
	4+0sAqzDnGL9/YvWSJgsu6O+fZAPq1bZLOfvYr2mu2jWEGRmDdJSTYx2lO4y2vxsFb8mvBdRIps
	GUlHII2nbOJsfGStstej/ypR9Mzky19tHW4H/bA7RYMbvdQyCTaKb3lmJfwaK4b5M09Myxozq/p
	kNEgY+oe
X-Google-Smtp-Source: AGHT+IFgXwwOqLmDQ79Pmnc41XEAjHcW4kdC+C1swSAuuLDWGyEK+XFtermnUbTQaIjvlHytFHyLRkB8gbGmL4RJ3iQ=
X-Received: by 2002:a17:902:f683:b0:293:2a8:3f9b with SMTP id
 d9443c01a7336-295565c1e2cmr4014665ad.15.1762097872429; Sun, 02 Nov 2025
 07:37:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826125617.1166546-1-alexander.usyskin@intel.com>
 <8deef7c4-ac75-4db8-91b7-02cf0e39e371@roeck-us.net> <CY5PR11MB6366B9836B306AD2A72BDDFEEDC6A@CY5PR11MB6366.namprd11.prod.outlook.com>
In-Reply-To: <CY5PR11MB6366B9836B306AD2A72BDDFEEDC6A@CY5PR11MB6366.namprd11.prod.outlook.com>
From: Guenter Roeck <groeck@google.com>
Date: Sun, 2 Nov 2025 07:37:41 -0800
X-Gm-Features: AWmQ_bnfvLsA1Lbuqnyc8sXQwiHxJ6NAiIB80GQvQ8vrHh4WXIebzCyxtS5Igak
Message-ID: <CABXOdTfOfrjP40DhZaqcXXUs0PbEZwv=qcZu=k=TwaRgMhFS_g@mail.gmail.com>
Subject: Re: [char-misc-next] mei: hook mei_device on class device
To: "Usyskin, Alexander" <linux@roeck-us.net>
Cc: =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?= <marmarek@invisiblethingslab.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Abliyev, Reuven" <reuven.abliyev@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 2, 2025 at 7:00=E2=80=AFAM Usyskin, Alexander <linux@roeck-us.n=
et> wrote:
...
>
> Seems I've missed the error flow in probe (my test machines always have a=
n ME in a good state...).
>
> Below patch should fix the problem, can you confirm?
>
Yes, it does. With this patch applied, the log output is:

...
[   16.406790] mtdoops: mtd device (mtddev=3Dname/number) must be supplied
[   18.380400] mei mei0: wait hw ready failed
[   18.384594] mei mei0: hw_start failed ret =3D -62 fw status =3D
00070355 002F0006 00000000 00000000 00000000 00000000
[   20.428395] mei mei0: wait hw ready failed
[   20.432542] mei mei0: hw_start failed ret =3D -62 fw status =3D
00070355 002F0006 00000000 00000000 00000000 00000000
[   22.476390] mei mei0: wait hw ready failed
[   22.480533] mei mei0: hw_start failed ret =3D -62 fw status =3D
00070355 002F0006 00000000 00000000 00000000 00000000
[   22.490847] mei mei0: reset: reached maximal consecutive resets:
disabling the device
[   22.498718] mei mei0: reset failed ret =3D -19
[   22.503012] mei mei0: link layer initialization failed.
[   22.508261] mei_me 0000:00:16.0: init hw failure.
[   22.513662] mei_me 0000:00:16.0: initialization failed.
initramfs(out): Mounting system filesystems for initramfs init.d
...

Official Tested-by: tag below. Note that it is from my Google address
since this is where I tested the fix.

 Thanks a lot for the quick turnaround!

Guenter

> From c58f311df60f26df2efe1e0f9fc523bfa4b93936 Mon Sep 17 00:00:00 2001
> From: Alexander Usyskin <alexander.usyskin@intel.com>
> Date: Sun, 2 Nov 2025 10:57:22 +0200
> Subject: [PATCH] mei: fix error flow in probe
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> Dismantle class device last in probe error flow to avoid accessing freed =
memory like:
>
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
>
> Reported-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingslab=
.com>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: 7704e6be4ed2 ("mei: hook mei_device on class device")
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>

Tested-by: Guenter Roeck <groeck@google.com>

>
> ---
>  drivers/misc/mei/pci-me.c       | 13 ++++++-------
>  drivers/misc/mei/pci-txe.c      | 13 ++++++-------
>  drivers/misc/mei/platform-vsc.c | 11 +++++------
>  3 files changed, 17 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
> index b017ff29dbd1..73cad914be9f 100644
> --- a/drivers/misc/mei/pci-me.c
> +++ b/drivers/misc/mei/pci-me.c
> @@ -223,6 +223,10 @@ static int mei_me_probe(struct pci_dev *pdev, const =
struct pci_device_id *ent)
>         hw->mem_addr =3D pcim_iomap_table(pdev)[0];
>         hw->read_fws =3D mei_me_read_fws;
>
> +       err =3D mei_register(dev, &pdev->dev);
> +       if (err)
> +               goto end;
> +
>         pci_enable_msi(pdev);
>
>         hw->irq =3D pdev->irq;
> @@ -237,13 +241,9 @@ static int mei_me_probe(struct pci_dev *pdev, const =
struct pci_device_id *ent)
>         if (err) {
>                 dev_err(&pdev->dev, "request_threaded_irq failure. irq =
=3D %d\n",
>                        pdev->irq);
> -               goto end;
> +               goto deregister;
>         }
>
> -       err =3D mei_register(dev, &pdev->dev);
> -       if (err)
> -               goto release_irq;
> -
>         if (mei_start(dev)) {
>                 dev_err(&pdev->dev, "init hw failure.\n");
>                 err =3D -ENODEV;
> @@ -283,11 +283,10 @@ static int mei_me_probe(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
>         return 0;
>
>  deregister:
> -       mei_deregister(dev);
> -release_irq:
>         mei_cancel_work(dev);
>         mei_disable_interrupts(dev);
>         free_irq(pdev->irq, dev);
> +       mei_deregister(dev);
>  end:
>         dev_err(&pdev->dev, "initialization failed.\n");
>         return err;
> diff --git a/drivers/misc/mei/pci-txe.c b/drivers/misc/mei/pci-txe.c
> index 06b55a891c6b..98d1bc2c7f4b 100644
> --- a/drivers/misc/mei/pci-txe.c
> +++ b/drivers/misc/mei/pci-txe.c
> @@ -87,6 +87,10 @@ static int mei_txe_probe(struct pci_dev *pdev, const s=
truct pci_device_id *ent)
>         hw =3D to_txe_hw(dev);
>         hw->mem_addr =3D pcim_iomap_table(pdev);
>
> +       err =3D mei_register(dev, &pdev->dev);
> +       if (err)
> +               goto end;
> +
>         pci_enable_msi(pdev);
>
>         /* clear spurious interrupts */
> @@ -106,13 +110,9 @@ static int mei_txe_probe(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
>         if (err) {
>                 dev_err(&pdev->dev, "mei: request_threaded_irq failure. i=
rq =3D %d\n",
>                         pdev->irq);
> -               goto end;
> +               goto deregister;
>         }
>
> -       err =3D mei_register(dev, &pdev->dev);
> -       if (err)
> -               goto release_irq;
> -
>         if (mei_start(dev)) {
>                 dev_err(&pdev->dev, "init hw failure.\n");
>                 err =3D -ENODEV;
> @@ -145,11 +145,10 @@ static int mei_txe_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *ent)
>         return 0;
>
>  deregister:
> -       mei_deregister(dev);
> -release_irq:
>         mei_cancel_work(dev);
>         mei_disable_interrupts(dev);
>         free_irq(pdev->irq, dev);
> +       mei_deregister(dev);
>  end:
>         dev_err(&pdev->dev, "initialization failed.\n");
>         return err;
> diff --git a/drivers/misc/mei/platform-vsc.c b/drivers/misc/mei/platform-=
vsc.c
> index 288e7b72e942..9787b9cee71c 100644
> --- a/drivers/misc/mei/platform-vsc.c
> +++ b/drivers/misc/mei/platform-vsc.c
> @@ -362,28 +362,27 @@ static int mei_vsc_probe(struct platform_device *pd=
ev)
>
>         ret =3D mei_register(mei_dev, dev);
>         if (ret)
> -               goto err_dereg;
> +               goto err;
>
>         ret =3D mei_start(mei_dev);
>         if (ret) {
>                 dev_err_probe(dev, ret, "init hw failed\n");
> -               goto err_cancel;
> +               goto err;
>         }
>
>         pm_runtime_enable(mei_dev->parent);
>
>         return 0;
>
> -err_dereg:
> -       mei_deregister(mei_dev);
> -
> -err_cancel:
> +err:
>         mei_cancel_work(mei_dev);
>
>         vsc_tp_register_event_cb(tp, NULL, NULL);
>
>         mei_disable_interrupts(mei_dev);
>
> +       mei_deregister(mei_dev);
> +
>         return ret;
>  }
>
> --
> 2.43.0
>
>
>
>

