Return-Path: <linux-kernel+bounces-769413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DEAB26E4C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 19:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABFBA1CE0E8F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F223831078A;
	Thu, 14 Aug 2025 17:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zFtk1Ie+"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760F1308F35
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755194086; cv=none; b=NmAKiFH8zMfXroSHVVKMqqqoOUyO2dECFfdJX7NO22kmPFeOTuQaF51r9v+32fTHVuLhBXt1q6x1iqs2urZYxtBoAvH0gPegas4LGit/vbCbN5KcNtPAO0cacWgvHZInSpfq040deaQr73s2+mVDsT7tE5VoaGNk1DDNYrcaCQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755194086; c=relaxed/simple;
	bh=S/8GhrcVZ0AaJAe2HhWmFv2UDxq1BAi8wbcbacEWvko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=prvwi2yKH/2YR1K90JJ56khnbB8sNSbvC2OGQY5ausJEkqTZStAPDhmzqQTP0ospJIlPUB95qymeKLd+dBXC8EvOOonnjT2x1I2xIvmDloQS0hcbJnVnlhEbAR3+Hhn1g/GYSgBNABesA06Hx24nm6g0G/TkiPdYCM7MnkcowkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zFtk1Ie+; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-89018065338so896407241.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755194083; x=1755798883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OaV0nH5MRnYWLPzPLIg/WKHUGkrNlkaiZ7Kg+yqmp1A=;
        b=zFtk1Ie+GPpx+You2b979/RZa7Enr5bQG0FjOwRYU5yVN2gzIJC9mO4d57wFFeGi00
         w/2fmVkwa1SPP6dDKRrVZWxhBZmgji0B0bnpD7CBnaFQnTsZ5zumJi/gdH9fM6hBTnTA
         iWQGkVy/MXfmRcaPXcc6FetMMvBd5Hj6z93oflxNSVNPVlgbgO6MWssNpuKkWDdgS2g7
         AW6LMQD5MntroByE5GOqs1RIQPfGTNH13KyDaTbWMjA6cR0wiHYM7+ltGlIr32MCEnIw
         vr3Iw59pecEEPSyLFKyQ1JiOhMx7FZuNWz3bC0SaR2gj/Km296WNjL8Jz9Lvn2scTBsa
         Luqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755194083; x=1755798883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OaV0nH5MRnYWLPzPLIg/WKHUGkrNlkaiZ7Kg+yqmp1A=;
        b=Tdbqx931gnak9Rbp3ucW8MUIMCCGebcG3Gq9QZR8GiyOFGcNrmN3w/NT1zbzwWyC54
         n8pdfNU6Pf9IPYHwhq7YZ7p33ZEbz3OQ/NX/nbtvpeAENr7a6IWyeq+FmUo0CKZn0+cP
         wDP8kwJkoKxybwu7fuNXFPVJQAlM6zXBoJctXWfgsGOfyUlpAY0/KthNPvKNHUWlELfh
         chiERQ3uQLXjEs1MYyvROejN5cUoDwGApGL3a67f/e2ueef85ntXpyhGZ51EODpV7UMX
         IVlow9zCmtltienH+cBg74lq9w10YjQBKwE00T8W8ulz5eaZw/LIA09LRrUFm2sg3zBa
         B/kg==
X-Forwarded-Encrypted: i=1; AJvYcCWxXxzdta+jnXc+Lu7+TVpZj4LcdsbVM0SfsF3G6eeq0URxxS75HmfGdIoMcZvkBE/qYfASxf4FnVx7q2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGwj6AZwXQew0VDlQdg3CqlbEBNKKpOWB7yiGSO6Cfkv6oWzAB
	EBel76VfbDpb0xCY4yolYa3wP1Ir3K9V5BQC6AhFoVvVsrkUXMdFBNb8+46uwTPXAINRgLDjjGr
	MXRRMh70XuT7RWKGmz5Cy2b+WM8PwjrOqNEAFLZPO
X-Gm-Gg: ASbGncs/hYm6nRggs1TcWqzUIaaTLMah6kx1Wd9iLvW3Bj6n81hHViHdys03uxI2foQ
	V+3dqA4IY/+qogcVSJgMlSZBTR6Zc32l+zQf12y2ni3GtpFcJ5XmCWnq0KueX4IJhd8JMctaAth
	hc8dKD893R+8I/IHite39k1coWVfjpA9bWEB1f1T/w/rJALQjSpLcf9o5bZR9fkZ8I8zyKn1+hT
	RSTiDCSzOB2YZyyBftbn2I=
X-Google-Smtp-Source: AGHT+IFINWpqYubk11kVXk1huw2oTv573sOTSXam/xIpQKCW1oMhjyXS2ZHbYDVzim8yoYiVfwnWdWBR2sLz2KgZNnw=
X-Received: by 2002:a05:6102:818e:20b0:4e1:5132:67c9 with SMTP id
 ada2fe7eead31-5103503d0bbmr1096565137.0.1755194082978; Thu, 14 Aug 2025
 10:54:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814111023.2693-1-wangwensheng4@huawei.com>
 <20250814111023.2693-3-wangwensheng4@huawei.com> <2025081429-lair-esophagus-eb8b@gregkh>
In-Reply-To: <2025081429-lair-esophagus-eb8b@gregkh>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 14 Aug 2025 10:54:06 -0700
X-Gm-Features: Ac12FXwt14RQAAFOuqkAXK6TDaLpMigLpASoR2PKFcHUxw-KqfPgTlKoolpxcLY
Message-ID: <CAGETcx9F3+9Pw0eYUNC_08yLdVAWuPk-gCnLMtqNKTPwshtnkg@mail.gmail.com>
Subject: Re: [PATCH 2/3] driver core: Introduce fw_devlink_relax_consumers helper
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Wang Wensheng <wangwensheng4@huawei.com>, rafael@kernel.org, dakr@kernel.org, 
	tglx@linutronix.de, robh@kernel.org, broonie@kernel.org, 
	linux-kernel@vger.kernel.org, chenjun102@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 4:39=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Aug 14, 2025 at 07:10:22PM +0800, Wang Wensheng wrote:
> > Some devices are added during its parent's probe and will never get
> > bound to a driver.

Hi Wang,

I'm guessing you are adding these "will never probe" devices to a bus?
Why are you adding devices to a bus if you'll never probe them? You
should use a "class" if these are devices of a type and don't need to
be probed.

> > In this case, with fw_devlink set to "rpm",
> > which is the default value, its consumers will be deferred probe
> > until deferred_probe_timeout when fw_devlink_drivers_done() would
> > relax the devlinks to the suplier.
> >
> > Use this function to relax the consumer devlinks, just like what we
> > do for the unmatched devices in fw_devlink_drivers_done(), so that
> > the consumer devices would be probed not that later.

This function is not meant for use outside fw_devlink core code.

Write a stub driver or move those devices to a class.

> >
> > Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
> > ---
> >  drivers/base/core.c    | 22 ++++++++++++++++++++++
> >  include/linux/device.h |  1 +
> >  2 files changed, 23 insertions(+)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index d22d6b23e758..2f7101ad9d11 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -1754,6 +1754,28 @@ static void fw_devlink_relax_link(struct device_=
link *link)
> >               dev_name(link->supplier));
> >  }
> >
> > +/**
> > + * fw_devlink_relax_consumers - Relax the devlinks with all its consum=
ers
> > + * @dev: Device whose consumer devlinks will be relaxed
> > + *
> > + * Some devices are added during its parent's probe and will never get=
 bound
> > + * to a driver. In this case its consumers will be deferred probe unti=
l
> > + * deferred_probe_timeout.
> > + *
> > + * Use this function to relax the consumer devlinks so that the consum=
ers
> > + * device would be probed not that later.
> > + */
> > +void fw_devlink_relax_consumers(struct device *dev)
> > +{
> > +     struct device_link *link;
> > +
> > +     device_links_write_lock();
> > +     list_for_each_entry(link, &dev->links.consumers, s_node)
> > +             fw_devlink_relax_link(link);
> > +     device_links_write_unlock();
> > +}
> > +EXPORT_SYMBOL_GPL(fw_devlink_relax_consumers);
>
> We currently do not export any "fw_" functions from the driver core, why
> do that now?  This feels wrong as this should all be "internal" to the
> driver core, no driver should be calling this.

Yup, you are right. Definite NACK.

-Saravana

