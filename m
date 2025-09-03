Return-Path: <linux-kernel+bounces-797593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1638B4124A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 04:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FDDE7AD9D8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 02:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51D21F2BB8;
	Wed,  3 Sep 2025 02:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zu4ds15A"
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09581B4138
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 02:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756866052; cv=none; b=WndZvljKqNuUIG+64/DAsLVgKCFl3/QY39UX2j9MtB2kugWqgrZE6qqIN6kj/waWFvEqBVfgS0y3Ppl3HIEgfMjWiiJ4D/9u4eZu4PmuhtlkpMi7ZuRM0t968sGXnpWX6p40BC/d73XAh/gI7oO5H2loi/gEwYRKQCy4M4JCnEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756866052; c=relaxed/simple;
	bh=DnWnFqNhE95DJq5W/8mxcJr3OyjwwtDpJjN+VfxI/tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eE3xeS+3kwLT9aKKN22OHlkCxvOlqbX3xV7FZ8xXT9DmDvrtVVeNg+98rqSybFEtEa+fOX46RXzM9IeetOTRz18/Q7Igdxe/cL22QU75MqHa7wRuz34IdRHqO0HZR+qh2DC9AtjWCsv/Ehn1rSlCz60M+5lXzhCrHN0ZpPpy5s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zu4ds15A; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b0439098469so379442766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 19:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756866047; x=1757470847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/70R56Z9K+3RS357Qzbv1U5VUL/YzpdkZBjEBEQaFk=;
        b=Zu4ds15Amm8fi0tdVQPDx6E9CYp91423PC1tewBg1knHwmQD7jwrsLhnzmHGYGBLKk
         wPcekDwBF6oapKBmxV2VM2UOOQhCSNh+EvnpTIbqGOEllzRlJdBktd5F4d7hxAVpz37i
         SdF2/+Zkm+MlR+1iiF8IfrK+jkLsp1ArQF++6hargJXeFF4og9MKmARfDHpV+vGVOLbM
         2rBUI9ALbf7ByBmP0e16SpqxvCQtmtd4ucyGfnuFygJgGozgLmyYsdJ3Zdy+FRLps9oa
         KybQdvPPnd3BkXCnwsZrhLdLPHoOROm1QWRYGXHJ47EkTt6tFMVZeemxwUro5yjBxdlo
         nB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756866047; x=1757470847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/70R56Z9K+3RS357Qzbv1U5VUL/YzpdkZBjEBEQaFk=;
        b=eyxtQh0udkXE48hwkrKzo8iQPO6tKN5scdlV1aPEhthMfbYJ/zAtRx4rSd29dh4/lf
         52hOUsnsCNyJgsF+k5B9gVvoFk4f6BNhLtlQYtWj57bVDj3Q3PjamLaPejwfUHrCorPH
         Qa3lWeBg/+6nhgErFIQ4mdrKuQsm2IkOcEOwYt912sep4HlNx6PgWoThl9JcM0fpLL8d
         fXfHOqSXaCp+n+JaE3jhtDJd0UwNd2tIlN59pjCzKocXghR8OWsPhf+xNwZD2cBws/2g
         fFb6Jmp6OWUNbdP/wYeRN16gDq5eCJThGM+6OrAbCFjI/vW2TWLFEHJHXEuJYRG2V6KU
         wNlA==
X-Forwarded-Encrypted: i=1; AJvYcCU+7Vg3Zf+p6+P5A7Xjm2aCJazipZCZ/Bh5690h01X2XmW8jk+txHOoOo5J4qMQ9Gy/05rVW3M4PwMOFkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMPS15QtfzcKiGXDvgwXAViAeaDdl+jtgMsBayKOJUb6lFNZ9y
	hmZGqyVLkuNoSOdKPrlyuf7EOFM5Gv1ytzUHNzr65x3lCEdAxFvSkg+pexH/90vrnvHh9pR6Pp6
	omhYQ7xRk8BeQ8lG0tfaaBQCvLaLj6w==
X-Gm-Gg: ASbGncu5nUvUAgVe0lNBkNbBgBHpL2zoMD3ycsUIXS4HrWYVzi4FLXR+cxQpqkF/hnW
	bpZAac3HjDL+Z/Fl7DGpM/15voTWFTWDJw14x2kXTmD5cl63welFxP6UUeV+23FUgyv24d/5LOr
	K1p9cFHDOX82umWWJmrxad+91aLhAmO5td9zb0MRJo9BqBYs7oL1iY9nN9NRRL6GOliqCQiMDI0
	Xxj1A==
X-Google-Smtp-Source: AGHT+IHmu98fbG+D9HV47qFCZHXVCXT/ybu3qrOz2yU8u8qNaogplji0a1idlXZ5HIcemxPhoSwFCD/ZIn/QgSiWyvY=
X-Received: by 2002:a17:907:7fac:b0:afe:f9fc:89be with SMTP id
 a640c23a62f3a-b01d8a2fe32mr1392418466b.1.1756866046985; Tue, 02 Sep 2025
 19:20:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aKwpnFtdtBlDv69O@didi-ThinkCentre-M930t-N000> <483cc0f8-6caa-4124-a724-433ff0d798fa@intel.com>
In-Reply-To: <483cc0f8-6caa-4124-a724-433ff0d798fa@intel.com>
From: yuanli fu <fuyuanli0722@gmail.com>
Date: Wed, 3 Sep 2025 10:20:33 +0800
X-Gm-Features: Ac12FXxUazAw9qplODu8aGIlMVqGbDpS_b406Pv-MWbS9iukSXEPLn4fYjgPqpg
Message-ID: <CABbqxmc+jkpgiHrWb5UH2FRZtaNpe4754qis=cPKtidW6+Vj6Q@mail.gmail.com>
Subject: Re: [PATCH v2] ntb: Add mutex to make link_event_callback executed linearly.
To: Dave Jiang <dave.jiang@intel.com>
Cc: jdmason@kudzu.us, allenbh@gmail.com, ntb@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dave Jiang <dave.jiang@intel.com> =E4=BA=8E2025=E5=B9=B48=E6=9C=8825=E6=97=
=A5=E5=91=A8=E4=B8=80 23:06=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 8/25/25 2:15 AM, fuyuanli wrote:
> > Since the CPU selected by schedule_work is uncertain, multiple link_eve=
nt
> > callbacks may be executed at same time. For example, after peer's link =
is
> > up, it is down quickly before local link_work completed. If link_cleanu=
p
> > is added to the workqueue of another CPU, then link_work and link_clean=
up
> > may be executed at the same time. So add a mutex to prevent them from b=
eing
> > executed concurrently.
> >
> > Signed-off-by: fuyuanli <fuyuanli@didiglobal.com>
>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Hi Dave,

Hope you are doing well.

Just wanted to gently follow up on this patch which you had acked
before. Is there
anything else I can do to help get this merged? Perhaps it needs a rebase o=
n a
different tree?

Thanks for your time and all your work!

Best regards,
Yuanli Fu


>
> > ---
> > v2:
> > 1) use guard() instead of lock & unlock functions.
> >
> > v1:
> > Link: https://lore.kernel.org/all/aKiBi4ZDlbgzed%2Fz@didi-ThinkCentre-M=
930t-N000/
> > ---
> >  drivers/ntb/ntb_transport.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index 4f775c3e218f..eb875e3db2e3 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> > @@ -59,6 +59,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/types.h>
> >  #include <linux/uaccess.h>
> > +#include <linux/mutex.h>
> >  #include "linux/ntb.h"
> >  #include "linux/ntb_transport.h"
> >
> > @@ -241,6 +242,9 @@ struct ntb_transport_ctx {
> >       struct work_struct link_cleanup;
> >
> >       struct dentry *debugfs_node_dir;
> > +
> > +     /* Make sure workq of link event be executed serially */
> > +     struct mutex link_event_lock;
> >  };
> >
> >  enum {
> > @@ -1024,6 +1028,7 @@ static void ntb_transport_link_cleanup_work(struc=
t work_struct *work)
> >       struct ntb_transport_ctx *nt =3D
> >               container_of(work, struct ntb_transport_ctx, link_cleanup=
);
> >
> > +     guard(mutex)(&nt->link_event_lock);
> >       ntb_transport_link_cleanup(nt);
> >  }
> >
> > @@ -1047,6 +1052,8 @@ static void ntb_transport_link_work(struct work_s=
truct *work)
> >       u32 val;
> >       int rc =3D 0, i, spad;
> >
> > +     guard(mutex)(&nt->link_event_lock);
> > +
> >       /* send the local info, in the opposite order of the way we read =
it */
> >
> >       if (nt->use_msi) {
>

