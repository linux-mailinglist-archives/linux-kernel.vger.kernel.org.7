Return-Path: <linux-kernel+bounces-866020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B04DBFE9DB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 01:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5653819A813B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 23:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD39D2F3613;
	Wed, 22 Oct 2025 23:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3AAzY8Fy"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA46277CA8
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 23:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177247; cv=none; b=AlcBe0h2Mxc/OwD65j86jo2a2NbkjH7hrvBk8ql2P3jYAmvxT7TZaAWaIGKPyT52n+YBodiUWMX88slCrXkhyV9oIABqtSQ+o5EkmuzOjxiCSjjw5dYM26qtEi+roVA5Y1cl90Q4y9wflStiU2vMIu7VFB1f23UaEjBo45ifIS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177247; c=relaxed/simple;
	bh=nO5DHKyBlotpTFhDE7x2Z/A+Jp3/mi/ndcWWH+QPYVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=szQ5MalW/PrEsw1kaKtWrcVXwzo0Q5p4t4XotXTfFM1awueCJ4+0OslLT+HzEhRXSrX37FrFEuB28ylRTfTJYADcUhw7053QxO1m0oxOWwuSaQPXgnG7TA+dDlAaUpgA1R4iDr7RwwgGOuM8nFK0LtZtKBOzVHuIQRBKBxBZkQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3AAzY8Fy; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63c44ea68f6so4981a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761177244; x=1761782044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6RHQchnkCCZHFiL1DU1wWeMfjedF3ffXwGFW4DpStk=;
        b=3AAzY8FyDWSAyHIOLBp5xsus3et6haNDeh4BaHTNFjcxZ1izUQlL5zbxywDHi6DUTi
         BED/9KrewQeuwQGlb65WPgK/tFgtwLBeVZ29KYt7yqMX/o8yj/BXz5ROZrl7EgQtBWCE
         +vqAdgr2+v6QqG8CClWu8cNvhZQwBg8S5kNofZIBN8V/SztOZ5GFDBuCX/uve92sPuEK
         jYWzI3u4zSwCRsb03yHqLIAhBhhozq20oeYrcOe3BWN7ZnylG7B9l3OduQ1+gQDRu2QQ
         Unx5rXDMnS7YdszEMyhkuQYM0Jvyo0nDEZ0l8/pRd2c0XJAUzv/0MpNranEZJGhdWqMZ
         TTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761177244; x=1761782044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6RHQchnkCCZHFiL1DU1wWeMfjedF3ffXwGFW4DpStk=;
        b=c54iIf/0SBG2jaGq6YKhCwHmzesyDz7ODMcl+wuRfgXrnkDeyEd4yxMN02vTMh29BV
         ZEgwuF8CyiHa66jtPFF62FQCsQZfUILkAZxCVFHWcZKxX88Al5yrDVSYCDHQAx0eo1F6
         AS8vso3PFZSyBAr8LkhIQtE3sX+MW1ZLD9yiBNeTx8DdZIq0B+SInptJSV1XAdhrFViK
         1V3vXG1+nEW8b8cSuZI1snBvpc5xYLqWxLH23Z5j0Tb/+a48uWVtge1wl0VUMzQI6QMM
         2AOqdFp1HntqZe/j1ivPevgObURLTTWYS1CcPfIU7qAg0jfFwUWmzUfy24WoQfpQ2dyp
         cV1A==
X-Forwarded-Encrypted: i=1; AJvYcCVswCx7eyb9L5aqIfCWAr6geJpOlUaGHjW1KysqQpVTMAhy12l6pqH5EX1ncWzzING/1cBIkodO2a/+RmY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7K0k6S1korHl/2d3i72gmiRrQF216WvnGlP6Oq3THphjLN/Wl
	aagzuldtMZqdAtbOsQPEnkwGv9JGLOnRUO+wRvtzmchUve2064orLtv8OsGEpdqn/WiJ8tjbeoq
	2vTpDdeeWaGXsq1/qH5Rh15NRXfyjtOsVLtMJrkG3
X-Gm-Gg: ASbGnctHhw/yyXo/uzg57VmqwogMdVc+6F+noKwWW/qoyz1uPWvtFRdPWhZ3f2AeQey
	9fmKf2os6BMCgFaIUE0C1lBLX/iqyum2gjZCh2rU1yYt8pTKgxfi1dXYbwtQs27sh86Ee+Eh7zk
	TXoMlzxoV8B/CkHG2mHLr/KdmIbBY69wX013pU94zO4pYXl4VnduzNyoKtEM4f0Nh+8+jcndxZ5
	6uSWp0DTYzC1Jz5vq0Ml0gWFIeWPEJh+u/QYidyYf6vHYXZdAg5keOZrFyYOpuc584dqEuOJC99
	BJruu31aO3SWFa0=
X-Google-Smtp-Source: AGHT+IEWd9FR9gKb9Zr14FO/SKIlqzxl6oi295G5iTkBVXoZe00E7i9wXEgtTQAijiYV0qbtiq+FZcMar8NwTFkA0k4=
X-Received: by 2002:aa7:d519:0:b0:62f:9f43:2117 with SMTP id
 4fb4d7f45d1cf-63e38faf5f8mr36697a12.0.1761177244223; Wed, 22 Oct 2025
 16:54:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002131900.3252980-1-mclapinski@google.com> <68f96adc63d_10e9100fc@dwillia2-mobl4.notmuch>
In-Reply-To: <68f96adc63d_10e9100fc@dwillia2-mobl4.notmuch>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Wed, 22 Oct 2025 16:53:52 -0700
X-Gm-Features: AS18NWAykxizA4pVQXnJ4CA0IxhWYm4ch5MzN7bzmvn3HrW8QsvVciVZgzdKZZQ
Message-ID: <CAAi7L5eY898mdBLsW113c1VNdm9n+1rydT8WLLNJX86n8Q+zHQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] dax: add PROBE_PREFER_ASYNCHRONOUS to the pmem driver
To: dan.j.williams@intel.com
Cc: Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 4:38=E2=80=AFPM <dan.j.williams@intel.com> wrote:
>
> Michal Clapinski wrote:
> > Comments in linux/device/driver.h say that the goal is to do async
> > probing on all devices. The current behavior unnecessarily slows down
> > the boot by synchronous probing dax_pmem devices, so let's change that.
> >
> > Signed-off-by: Michal Clapinski <mclapinski@google.com>
> > ---
> >  drivers/dax/pmem.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
> > index bee93066a849..737654e8c5e8 100644
> > --- a/drivers/dax/pmem.c
> > +++ b/drivers/dax/pmem.c
> > @@ -77,6 +77,7 @@ static struct nd_device_driver dax_pmem_driver =3D {
> >       .probe =3D dax_pmem_probe,
> >       .drv =3D {
> >               .name =3D "dax_pmem",
> > +             .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> >       },
> >       .type =3D ND_DRIVER_DAX_PMEM,
> >  };
>
> Hi Michal,
>
> Apologies for not commenting earlier. When this first flew by I paused
> because libnvdimm predated some of the driver core work on asynchronous
> and has some local asynchronous registration.
>
> Can you say a bit more about how this patch in particular helps your
> case? For example, the pmem devices registered by memmap=3D (nd_e820
> driver), should end up in the nd_async_device_register() path.
>
> So even though the final attach is synchronous with device arrival, it
> should still be async with respect to other device probing.
>
> However, I believe that falls back to synchronous probing if the driver
> is loaded after the device has already arrived. Is that the case you are
> hitting?

Yes. I use all pmem/devdax modules built into the kernel so loading
them is in the critical path for kernel boot.
I use memmap=3D with devdax. So first, the pmem device is created
asynchronously, which means loading the nd_e820 module is always fast.
But then, the dax_pmem driver is loaded. If the dax device has not yet
been created by the async code, then loading this module is also fast.
But if the dax device has already been created, then attaching it to
the dax_pmem driver will be synchronous and on the critical boot path.

For thousands of dax devices, this increases the boot time by more
than a second. With the patch it takes ~10ms.

> I am ok with this in concept, but if we do this it should be done for
> all dax drivers, not just dax_pmem.

Will do in v2.

