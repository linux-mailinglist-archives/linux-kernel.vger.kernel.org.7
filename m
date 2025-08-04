Return-Path: <linux-kernel+bounces-755106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 164BBB1A15E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34CFB164466
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F98258CD3;
	Mon,  4 Aug 2025 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HdV7NArz"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB3345C14
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 12:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754310304; cv=none; b=HoOc1aNMZDg4JtcOMAgjQUyMR5dpU32dF1amn0bDPrcgOjuzTpmn7ezLPBWRbDuI4S6LEVuYKKBIZ3ogtyDIkCZ+RSbbdwXTCkj/VOrzcIe28Wmbf5HtBsMJq0G9YhX3/wMKlATCieztXxQf98/ESb4MzgWH++qqCOOLoe+nmvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754310304; c=relaxed/simple;
	bh=k/SV7mgu5Q93QULXEG0XrEZJOcamX3ZC/G+44c2Hlog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHT2ivVfKykN0r60lHofYHwrh2qKgSuhPbahHRgXdjJhcDc+kWEjR9lUw8eGrxFrZcDppiXEd4DCM7/iE5JQ0tWhwDuV75gmaa5uf9fmlk+r2/lyMZ3vH8IdnAKvxzZBwbPS0t4Jlt+xTbbvnF7UhoeBlGlRSVYdqbSCouGZ9Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HdV7NArz; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6199bd72532so159758eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 05:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754310301; x=1754915101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UidEO3p/JExNkZNMYzF9DbeSLXATOoHJRr54KAZUFg=;
        b=HdV7NArz+6/WRYl9YpXiSTdp/bPwn2/9Jj7y4Olc2vO8jePyBMcI1617EJUv0i+sgA
         BZWtDzAZNQ5UjZTKiUhkhILnJYk6ngHAzDWkk/WeFIRHW46A0ddxxh1nnBERvTuBtIyc
         6zVA4HMeSrPuvlCxddfnA2xf2adPCrxOPF4K2jfiiBIiK2I2rwI82dtbT+JPcVaKEsmB
         Mb+S26sl2lwvzBJKbMlM0OaiI3W5M3ZPspHGARDj0aK7i1G5CVLM4VuwNYR0yAtyuWwU
         jyrGyrfqnDBuXg+sfXiCPTzkXpLlEwiCAhIkqnFazwHTDSZQuNHv4I7kRbT+ti2W2lVu
         qpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754310301; x=1754915101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/UidEO3p/JExNkZNMYzF9DbeSLXATOoHJRr54KAZUFg=;
        b=wsax7HUabeH1z17cV6B1TmIj7Ha5oO2qi0d8rBRUCfUPOlHW/8I9swxvkx6ilNG3N9
         LaosrvYDMcyopc873/AO6Gk6lDILWnAr5+m2Ehq5zIAE1bi6WXWVMjHUDIph31hJ57li
         j5RG0CU9NyMtgjwNA1YJ4jFSIdNjsLZ3Cgbmm9kNu8m4pGQdJShJeQfQ0X3NKdzbClj3
         hn8DNuBxyY9pwrpSXw//MT7Hr0/aIoFw3BDqJyK6EjelwEUyNBkLrCeMVOpZx8pOEmhT
         Zm/OZ/uXRJUELx7ARH8CAUH/K4AR7J2nl9kACZ6mLjL+vlEJQ3KlbXUWUbjTWEKXCKNB
         mjgw==
X-Forwarded-Encrypted: i=1; AJvYcCWASLPzxlM2fagn5SwQCZNbxjB11rvCfHPyJFCuuQveS/wEvitGDDITjV1esn2Y5QmXr5VRQSliehKSe0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw424mzvStsHPeYk7xCdd7gA4MIqjzKaGWwDr29MmU9yywX1fL3
	JQE4XVvNR1Gb4ljRkkR+iOrRfroVeRo7mq1btmupK4/B2vgnJ7s24OF6mbcehOF+AIuMlV282h6
	rKamOIU3hGh+6Od3Lia37QPqiHIaxKx/QJyAaujmuKlm417dsV5bt
X-Gm-Gg: ASbGnctthrRNg9fnWdK5GRhKqJRQZ9CkOHmbDabvYzwWQDtiVrb05Y7hilkav+nv8vD
	tMSaBJ1Mbm6kvAd5RzRBfDBm/L2Z4SjwFNllgSzrO30VDe4SjkcxoOzyxjGoLppE8kRwKMInZXw
	zar64Np8KX/eO0UdHMv2GhAAe8Ab/FomPQ66ocv1GgM1Lt0CqvA+EkDMfUUvTuxi9wI7/aJtCEE
	pchn25U
X-Google-Smtp-Source: AGHT+IEwI3DR1cEwvcgcyKde5qW3Qb7yD1S7YRbPQ8PZrFxcjbQGbcaX5K/LoDeEAYkbNEQmXbEvo9mg4UHsZCSbTls=
X-Received: by 2002:a05:6820:1e81:b0:619:ae98:ad06 with SMTP id
 006d021491bc7-619ae98afb6mr1974484eaf.5.1754310301171; Mon, 04 Aug 2025
 05:25:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fabd3d7560119e52dd83f4a19ad1f8087862993f.1753236468.git.xiaopei01@kylinos.cn>
 <aIiTVdJib4DLgYnC@sumit-X1>
In-Reply-To: <aIiTVdJib4DLgYnC@sumit-X1>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 4 Aug 2025 14:24:49 +0200
X-Gm-Features: Ac12FXy0LIz3mNrzQl6ojyMPHYRczjOKU3Drs4kD05hFb2F7PMYVYOyqV-8GnDw
Message-ID: <CAHUa44GB8LF4iPR2tyy8HnVCwFYBXy+B2kLyf1g9GoCmsP8xsQ@mail.gmail.com>
Subject: Re: [PATCH] tee: fix NULL pointer dereference in tee_shm_put
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Pei Xiao <xiaopei01@kylinos.cn>, larper@axis.com, op-tee@lists.trustedfirmware.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 11:24=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org>=
 wrote:
>
> On Wed, Jul 23, 2025 at 10:09:07AM +0800, Pei Xiao wrote:
> > tee_shm_put have NULL pointer dereference:
> >
> > __optee_disable_shm_cache -->
> >       shm =3D reg_pair_to_ptr(...);//shm maybe return NULL
> >         tee_shm_free(shm); -->
> >               tee_shm_put(shm);//crash
> >
> > Add check in tee_shm_put to fix it.
> >
> > panic log:
> > Unable to handle kernel paging request at virtual address 0000000000100=
cca
> > Mem abort info:
> > ESR =3D 0x0000000096000004
> > EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > SET =3D 0, FnV =3D 0
> > EA =3D 0, S1PTW =3D 0
> > FSC =3D 0x04: level 0 translation fault
> > Data abort info:
> > ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
> > CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> > GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> > user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000002049d07000
> > [0000000000100cca] pgd=3D0000000000000000, p4d=3D0000000000000000
> > Internal error: Oops: 0000000096000004 [#1] SMP
> > CPU: 2 PID: 14442 Comm: systemd-sleep Tainted: P OE ------- ----
> > 6.6.0-39-generic #38
> > Source Version: 938b255f6cb8817c95b0dd5c8c2944acfce94b07
> > Hardware name: greatwall GW-001Y1A-FTH, BIOS Great Wall BIOS V3.0
> > 10/26/2022
> > pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> > pc : tee_shm_put+0x24/0x188
> > lr : tee_shm_free+0x14/0x28
> > sp : ffff001f98f9faf0
> > x29: ffff001f98f9faf0 x28: ffff0020df543cc0 x27: 0000000000000000
> > x26: ffff001f811344a0 x25: ffff8000818dac00 x24: ffff800082d8d048
> > x23: ffff001f850fcd18 x22: 0000000000000001 x21: ffff001f98f9fb88
> > x20: ffff001f83e76218 x19: ffff001f83e761e0 x18: 000000000000ffff
> > x17: 303a30303a303030 x16: 0000000000000000 x15: 0000000000000003
> > x14: 0000000000000001 x13: 0000000000000000 x12: 0101010101010101
> > x11: 0000000000000001 x10: 0000000000000001 x9 : ffff800080e08d0c
> > x8 : ffff001f98f9fb88 x7 : 0000000000000000 x6 : 0000000000000000
> > x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> > x2 : ffff001f83e761e0 x1 : 00000000ffff001f x0 : 0000000000100cca
> > Call trace:
> > tee_shm_put+0x24/0x188
> > tee_shm_free+0x14/0x28
> > __optee_disable_shm_cache+0xa8/0x108
> > optee_shutdown+0x28/0x38
> > platform_shutdown+0x28/0x40
> > device_shutdown+0x144/0x2b0
> > kernel_power_off+0x3c/0x80
> > hibernate+0x35c/0x388
> > state_store+0x64/0x80
> > kobj_attr_store+0x14/0x28
> > sysfs_kf_write+0x48/0x60
> > kernfs_fop_write_iter+0x128/0x1c0
> > vfs_write+0x270/0x370
> > ksys_write+0x6c/0x100
> > __arm64_sys_write+0x20/0x30
> > invoke_syscall+0x4c/0x120
> > el0_svc_common.constprop.0+0x44/0xf0
> > do_el0_svc+0x24/0x38
> > el0_svc+0x24/0x88
> > el0t_64_sync_handler+0x134/0x150
> > el0t_64_sync+0x14c/0x15
> >
> > Fixes: dfd0743f1d9e ("tee: handle lookup of shm with reference count 0"=
)
> > Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> > ---
> >  drivers/tee/tee_shm.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Looks good. I'm picking up this.

Thanks,
Jens

>
> -Sumit
>
> >
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > index daf6e5cfd59a..915239b033f5 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -560,9 +560,13 @@ EXPORT_SYMBOL_GPL(tee_shm_get_from_id);
> >   */
> >  void tee_shm_put(struct tee_shm *shm)
> >  {
> > -     struct tee_device *teedev =3D shm->ctx->teedev;
> > +     struct tee_device *teedev;
> >       bool do_release =3D false;
> >
> > +     if (!shm || !shm->ctx || !shm->ctx->teedev)
> > +             return;
> > +
> > +     teedev =3D shm->ctx->teedev;
> >       mutex_lock(&teedev->mutex);
> >       if (refcount_dec_and_test(&shm->refcount)) {
> >               /*
> > --
> > 2.25.1
> >

