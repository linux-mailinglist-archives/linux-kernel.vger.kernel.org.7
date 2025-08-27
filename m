Return-Path: <linux-kernel+bounces-787898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE144B37D63
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0437D1BA3249
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 08:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30083322752;
	Wed, 27 Aug 2025 08:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fVAvD8bG"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2220E192B84
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 08:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756282649; cv=none; b=TYBV/i2u8pVhiH5VJbYHt3rw5zyftZ91LDGFiuSdW1y/QkYT/7TZGVjhGQ2+A4+DITHMBBkoDg/iBjJtRqZKBK4/6KdQ8iYln3QiYVn149YBH4fGB1R3PwIb1m+jhy+79PaBXeaEKumzRE3GE9n8KdzfDzqoJucolfj5u58zmBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756282649; c=relaxed/simple;
	bh=ini/Dg/qMFzbwNKKWsndLioGgin9QxvTIdp1lM1/knI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0mCjhp2WMnWTv8OhWxDEQdKZt4JUhLf4BQ7lGXCgHNf2w/3SDJ7o+oVmpjFpob5IUxM5tlSFfre9ZtfKL1rXwCZYLYMdoI9AZ87a1ckgyn51hJYp3zpIupS+GST8bv/FNz5/J0uPNeFC1CB8Zd7RHzGOz9YqBtIS8gibqeYiC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fVAvD8bG; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32326e8005bso6697878a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756282646; x=1756887446; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rw6pFx8vb3qCt0eWgbwwuAkBawJ8J17IDZtKMfIRe0c=;
        b=fVAvD8bGXejU/Z2MmG7wpFMW6iIkiLDIz7MFGXomSrTOc1PMYgG+G/YfZW3VlOF9kw
         Rg61+FUrKfhAO0lB+gxBIMCnLiyS956s5ovd+OPhOLQ2XFK/1RZFLnWZuxkdegCGv8aH
         /NIksY7MmE9trBF50sOzpjoCIFPYtF8UV0XQuJco2V5oNIfA1iuXakc9GxReUr2qE3yt
         d6VFxudj9gsBxdO3PLeQL0zm4QwoVIuqQVR8v1y0NRZOfuwljLrSIUXpLn6bJPZCFswu
         JlmqMnUz82Lp59Z/wBV5AJb7AbnA+8gTiD4jVvH/bHm+7v/oGWWLAquBM/d/q1p7tGI5
         HTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756282646; x=1756887446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rw6pFx8vb3qCt0eWgbwwuAkBawJ8J17IDZtKMfIRe0c=;
        b=n+4MS6jRNGx7Ts/UyyMzYUCDwmWUR8mGsXTWVyl5/HHmKGzJo7motLtpDnmTGNma9f
         P4u8ZOsTWPkqfzHz9GCnKoeHARsY0fIJXU5S3jdnQ0BMAqp6VTgO5yFQvNvnXI771H5u
         JgBWYTIsPUsCic3JWvyJO//rEPE3raqfP0flPSeQMdFOD5IHdwAds1a40qscSh3ndW0c
         F7h9ejJKDAE80iI80IvyFYHTON2q67YWaWhl2Zriu1yOyc9b61cl2eNyNlS/nLTO0j8d
         uG6WtQWlShqHLrXC/Hb+oFJXFATcXhoc1UbFfpJGTxmIPKBtXmB63gbsB/onsCL947du
         IKRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDFd9DfluDOck5N2HfcNjpz/RkSVmviNnhfbJq8m9osgF81MtMMEiv0vvXx11af08+tya/fvL8k4OGrZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YylxclC+y3pTBWEyHP2+1nkuEW+talnhxI4Y5Ns0WEySVeedtF1
	B0QO62ulgrnYW7VWGu/Wq7EtknyzyvpGuTslqHTmhACKdwDxMjm2Cn8ON7FHp7jZA3YmQ2jHTH0
	B+agkf9MeBhh+bQ8Df05qt358AVVUKN+Ra7bleAUsBA==
X-Gm-Gg: ASbGncvtecoKCW0EiRaDjft4SzNoWn9tCk9cz1bheaICRoxcElTkF5d2u7vGRUuQ4YM
	xwoRQ7ZwMxWirruiE4lafi9GVPEeBn5+wsInGzh7mz5kkfSAJuSQTFFCsS7LrHNaOdA3ObJIwFy
	vwPxl2iz1mhOs3rD8W41Q4ZfoeozyVNuJBD09t9P1z800OLkXLG7wmD46tGQrbQBELQ5+pLScZD
	nOwNjobcqCkL7X22DxcIuj3SpYF0B/4mQQeVZe7
X-Google-Smtp-Source: AGHT+IHXV0XIJbSOruANIhEDSo4ztOVg47pK0P0Ye2hoQsvKDAy3OuT0JReOys0s//MIC3rIMXgdY/LDTorvaRJkGgc=
X-Received: by 2002:a17:90b:54c3:b0:311:c970:c9c0 with SMTP id
 98e67ed59e1d1-32515ec1313mr22920541a91.22.1756282646397; Wed, 27 Aug 2025
 01:17:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813232835.43458-1-inochiama@gmail.com> <20250813232835.43458-3-inochiama@gmail.com>
 <aK4O7Hl8NCVEMznB@monster> <db2pkcmc7tmaozjjihca6qtixkeiy7hlrg325g3pqkuurkvr6u@oyz62hcymvhi>
 <qe23hkpdr6ui4mgjke2wp2pl3jmgcauzgrdxqq4olgrkbfy25d@avy6c6mg334s> <20250827004719.GA2519033@ax162>
In-Reply-To: <20250827004719.GA2519033@ax162>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 27 Aug 2025 13:47:14 +0530
X-Gm-Features: Ac12FXzvPaHx0Y-UEkNxm_tosSQU8r9fXEo91EwR-5NGfEUW74KCwisELg0mjB0
Message-ID: <CA+G9fYsAxq-RmU7fVSDQ8_B2Hm5NY7Q7=DUnqcpnt8BOtd0dUA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] PCI/MSI: Add startup/shutdown for per device domains
To: Nathan Chancellor <nathan@kernel.org>
Cc: Inochi Amaoto <inochiama@gmail.com>, Anders Roxell <anders.roxell@linaro.org>, 
	regressions@lists.linux.dev, linux-next@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Shradha Gupta <shradhagupta@linux.microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Jonathan Cameron <Jonathan.Cameron@huwei.com>, 
	Juergen Gross <jgross@suse.com>, Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Chen Wang <unicorn_wang@outlook.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>, arnd@arndb.de, dan.carpenter@linaro.org, 
	benjamin.copeland@linaro.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Aug 2025 at 06:17, Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Wed, Aug 27, 2025 at 07:28:46AM +0800, Inochi Amaoto wrote:
> > OK, I guess I know why: I have missed one condition for startup.
> >
> > Could you test the following patch? If worked, I will send it as
> > a fix.
>
> Yes, that appears to resolve the issue on one system. I cannot test the
> other at the moment since it is under load.

I have built on top of Linux next-20250826 tag and the qemu-arm64 boot test
pass and LTP smoke test also pass.

>
> Tested-by: Nathan Chancellor <nathan@kernel.org>

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

>
> > ---
> > diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
> > index e0a800f918e8..b11b7f63f0d6 100644
> > --- a/drivers/pci/msi/irqdomain.c
> > +++ b/drivers/pci/msi/irqdomain.c
> > @@ -154,6 +154,8 @@ static void cond_shutdown_parent(struct irq_data *data)
> >
> >       if (unlikely(info->flags & MSI_FLAG_PCI_MSI_STARTUP_PARENT))
> >               irq_chip_shutdown_parent(data);
> > +     else if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
> > +             irq_chip_mask_parent(data);
> >  }
> >
> >  static unsigned int cond_startup_parent(struct irq_data *data)
> > @@ -162,6 +164,9 @@ static unsigned int cond_startup_parent(struct irq_data *data)
> >
> >       if (unlikely(info->flags & MSI_FLAG_PCI_MSI_STARTUP_PARENT))
> >               return irq_chip_startup_parent(data);
> > +     else if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
> > +             irq_chip_unmask_parent(data);
> > +
> >       return 0;
> >  }
> >

