Return-Path: <linux-kernel+bounces-729137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5157EB0323D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 19:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BC451783E3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 17:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8848D28000A;
	Sun, 13 Jul 2025 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpYNUs2u"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDC42581;
	Sun, 13 Jul 2025 17:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752426021; cv=none; b=dQjLHCw+A/T38KSSyQv/5CFomPZQfwkgiIh0Tk4TYbt9GBvjsDKX8S0A0nC3UkjT9C347YiApl53JL9XBTpkM2hkoA+B6lXSidTFyzByc+5jz9GWconJnDX77fp8eTQbrI3NbBEjFjMBfWnaILcKYkiUDy2fOoyzkpFRLRV9Umc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752426021; c=relaxed/simple;
	bh=bxgvAdEWVaw1boR+4YJBzaW2NRR6Q4mAxdOxbu2uGR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MV+1ynl2V7AvcsDGk+AN8kLAOIbajF5vL9aAFqvlbDRBHlS+hY/BbL3x9UZBMBXcYKZcos4LNOP1lLUXVhZj8OEenfYferX5CgfOxYoXZcziNeJq1UL3bic3JRV+GEpR05qO70i6YR0JftDnBp4Gkm4RtRKw88DUd/AZn0dCMi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpYNUs2u; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-40b54ee16ddso2215513b6e.1;
        Sun, 13 Jul 2025 10:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752426018; x=1753030818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UielU/inQTLMHeeKNBTZ5P8oweh0lbHdXh4gUsettU=;
        b=lpYNUs2uY61QpnjWyQ513TOWBf85FNLqVpL1O/w6tEPoYdi3gn8nu8FaXi4J2lP6A0
         SlLxH2RatbNQmvT7hGcvvgwzHkEQqo6fcwCenoY6uPEF0kG/h3+gH3ypKjL5IhAjQjMZ
         rL16VdRjs0VIG6wj4CYId3aO3gjggOuIFQ08KaCOtpI9Gl7yyH2WGqb5i74AudV9V6Ig
         68EK9k2qxOnk2x8/RRvJYj+CorzWtjkgLRWpny6mRs4c8eSjW6YqD8JRfpMqYW6aq8TN
         EUJ6SJu46EUl0rSZo88CC8VyiMUo7yih9Xw6Vty+DCtALorKJ2RZ8tryzkXScN2q/wnx
         np8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752426018; x=1753030818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6UielU/inQTLMHeeKNBTZ5P8oweh0lbHdXh4gUsettU=;
        b=a07A65eiAPIN7csClc7pebvkcirO1wESKeIo8XjkuPAWuqTigYvwD2r/eFiBSlljA+
         wuTqg/1suzHBRWIaZswZn0G72POOqdGhRu7JPb/QC6iSMPWt0hMDA3xaBeRDl2doRxjA
         K9hbZC/PS+zBFbLv0UVBtDRV6RrWdQdI5U358J3i1MHE3naV2JrkL4VtajGwb5fbDD8c
         F0QXb5DIOr/M8o7UseFxlwOaKKPQnDlVZR0U3PU7tUQ1nIgcw7akyOGUUKHopbHBJqND
         GT7VamMhJbImYZoP4XbUJXUjz6sc/puACqSyB0lsUMrKWtAZGb+dkeClBIxYZLVQPs0Z
         hBVA==
X-Forwarded-Encrypted: i=1; AJvYcCW/z/12xUjYNYWZw45mPfAvG1KJhDITTxW1IT9bzkLvUv2R715JzTqYFMW7eRV7NRxGFdXAV7+fnPpvCKiH@vger.kernel.org, AJvYcCW4w4224ZEe4CYJzYav0sOA4KsAOnkK7tKxgcSfiM6x5DrzWEfk21BGRuwizh1BC4E+jw3rX08vuoXz@vger.kernel.org
X-Gm-Message-State: AOJu0YxLhJwhD2vgWvH+wOR/dV7DBLFXvVz4ovOnDc54zTqXga/4FAZz
	Tjcioyi6iOCaf3221u3/1g/JyVEdSXd768frpBfLk3mDLlDj6UoKEqjYa+5l6S10ku1rClb7Q1A
	9i49VuXfY0hSg8nyo/0rXqOVZ2GlFOY4=
X-Gm-Gg: ASbGncvsicj5JXcDIEx4eXEHycqPIAxPG/xTLhCMy5ozj9Y0TWW5U7QGEyQPfL+sFnU
	br6iMIqCG9bIdV8m4r6HYA96musJKtiWJkd0EuSjreRecymXtLNJhDdDaomDelsgmCA2rZMCwvO
	eVO9Z2OfIeAiZ1pFzt7F9F3p62F7gsztv72MxVHqj1wkPg+b3up4YDPG30QPmNxNNTbiAWF5tde
	7NLI6/w1ohSIfTbv/8=
X-Google-Smtp-Source: AGHT+IEB4Vjq2MsGI3l8ASuGgXvLmMm3snf9k1QQxT74CBmG6fuOrZfLSiwL66z7qqJZ6YCbD48YTDm6ikzm+G0/g68=
X-Received: by 2002:a05:6808:4fe3:b0:401:cae9:4dc3 with SMTP id
 5614622812f47-4150d745d33mr7375679b6e.8.1752426017998; Sun, 13 Jul 2025
 10:00:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609031627.1605851-1-peter.chen@cixtech.com>
 <20250609031627.1605851-6-peter.chen@cixtech.com> <CABb+yY17OOBx73655OhBp8At1b81w9M61zzGu4uhXcMTw4Q=Dw@mail.gmail.com>
 <aG0i75h32dWg/L2G@gchen>
In-Reply-To: <aG0i75h32dWg/L2G@gchen>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sun, 13 Jul 2025 12:00:06 -0500
X-Gm-Features: Ac12FXz1lC8UVKS1fKWne5OFNOSCLRX_KfU-_2Y_l2QFGnsGYRRkOTZbJq257xg
Message-ID: <CABb+yY2BmqiQ18hU+7C234UnY8n-8PH5VEoS7nH5Xq5O1krGhQ@mail.gmail.com>
Subject: Re: [PATCH v9 5/9] mailbox: add CIX mailbox driver
To: Guomin chen <guomin.chen@cixtech.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, 
	Peter Chen <peter.chen@cixtech.com>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cix-kernel-upstream@cixtech.com, maz@kernel.org, sudeep.holla@arm.com, 
	kajetan.puchalski@arm.com, eballetb@redhat.com, 
	Gary Yang <gary.yang@cixtech.com>, Lihua Liu <Lihua.Liu@cixtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 8:54=E2=80=AFAM Guomin chen <guomin.chen@cixtech.com=
> wrote:
....
> > > +/* [0~7] Fast channel
> > > + * [8] doorbell base channel
> > > + * [9]fifo base channel
> > > + * [10] register base channel
> > > + */
> > > +#define MBOX_FAST_IDX          7
> > > +#define MBOX_DB_IDX            8
> > > +#define MBOX_FIFO_IDX          9
> > > +#define MBOX_REG_IDX           10
> > > +#define CIX_MBOX_CHANS         11
> > > +
> > if it is not really a single controller owning different channels,
> > maybe implement only what you currently use.
> >
> As mentioned in the previous email, a single controller can support
> multiple different channels.
>
OK. I am not too worried about having all variants in one driver esp
when it is manageable and share the code.
Unless I am overlooking something. Arnd?


> > > +static u32 cix_mbox_read(struct cix_mbox_priv *priv, u32 offset)
> > > +{
> > > +       if (priv->use_shmem)
> > > +               return ioread32(priv->base + offset - SHMEM_OFFSET);
> > > +       else
> > > +               return ioread32(priv->base + offset);
> > > +}
> > > +
> > use_shmem is set for only CIX_MBOX_TYPE_DB, but it affects every read/w=
rite.
> > Maybe instead adjust the base for TYPE_DB?
> >
> The reason we introduced use_shmem here is that we had to adjust the base
> address of TYPE_DB to resolve the reg conflict in the DTS.
> This change has virtually no impact on performance.
>
Yes, I can see it should have no impact on performance and I think
adjusting the base once
during init is cleaner than checking the flag every read/write.
But wait... use_shmem is a controller wide flag, and isn't
priv->use_shmem always set to true  in cix_mbox_init() ?
Is the driver even tested?
....

> > > +static int cix_mbox_startup(struct mbox_chan *chan)
> > > +{
> > > +       struct cix_mbox_priv *priv =3D to_cix_mbox_priv(chan->mbox);
> > > +       struct cix_mbox_con_priv *cp =3D chan->con_priv;
> > > +       int index =3D cp->index, ret;
> > > +       u32 val_32;
> > > +
> > > +       ret =3D request_irq(priv->irq, cix_mbox_isr, 0,
> > > +                         dev_name(priv->dev), chan);
> > The same irq is requested for each channel. How do you expect it to
> > work? Maybe request it just once in probe and pass the 'priv' instead
> > of 'chan' , and in the cix_mbox_isr handle according to INT_STATUS
> >
> For the same mailbox controller, there won't be multiple channels
> simultaneously requesting the same IRQ, so there won't be an issue
> here. As you mentioned, if we need to handle multiple channels working
> concurrently in the future, we would need to modify cix_mbox_isr.
> However, that is not required at the moment.
>
Is it too hard to do it right already?

....
> > > +MODULE_AUTHOR("Cix Technology Group Co., Ltd.");
> > > +MODULE_DESCRIPTION("CIX mailbox driver");
> > > +MODULE_LICENSE("GPL");
> >
> > GPL v2 ? according to the SPDX-License-Identifier
> >
> > And please make sure you run scripts/checkpatch.pl
>
> Yes, I'm also confused here. I was previously using GPL v2,
> but when I ran checkpatch.pl, it triggered a warning due to
> commit bf7fbeeae6db ("module: Cure the MODULE_LICENSE 'GPL'
> vs. 'GPL v2' bogosity").  So I changed it to GPL.
>
Sorry, I was wrong. It should simply be GPL

Thanks.

