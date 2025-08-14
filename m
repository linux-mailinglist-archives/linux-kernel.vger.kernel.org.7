Return-Path: <linux-kernel+bounces-769433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 156E3B26E99
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 20:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3953B1BC513A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F38F31985C;
	Thu, 14 Aug 2025 18:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wPPlQnnT"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D7431984A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755194778; cv=none; b=BMkKrG+YzxcPgspRcfQR6KLL4yYCtnVcYMh39G3Oa01R9PKXsMsHg15zjEfMMXCvNEDsWLe8OC8w+WtxZbQg6t3klPK0ApLvc2X3ERo8182pOalSPPrP6aYktTVMq02UfoQhu2KplcDWflfSVecRivVNPT+d+T70bITwOVVVCNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755194778; c=relaxed/simple;
	bh=WcgIBnASYRHaICBaf4OkhcSTx9dWbiSbipQCzxw3P3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7wKOOhErle/b1J7joQmNpq/Crg6UjjzwtXYkblmSmGZz5xMpoLctDiiawgiVyZjBHxa7S2PjbIS4DYylmuzxgZCaSsFC2RcpAbP5wqYHZLtvrXhcCCS2dCs2o/QDD06o4sUV7N3h1GEkU6RsPefXOZtv32Qb72TiPWDFHVGskI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wPPlQnnT; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-50f8b94596fso703229137.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755194774; x=1755799574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IiwDYZLPHBCwryyT3uECATdVMw9CdaQ+dyZ7QK0KM9A=;
        b=wPPlQnnT9cBQDh8nuhnjwj3kwqLJsE7HtxbdutimLMZGDVR76qjL2eLLBKBS0TXzZt
         Xk16srBN6gOtXa0718+3Q73RkHkiRDtbusDPGzkzKKrA/yY9T9bXShW1zdqJ4y2cEYrC
         xfdu49qjsu/E3aD7TZSKh5WW0pLYrwtlOLgdq17H/KjzKwG+31fibxZGdZyYAoDzMZKl
         r2234XQBQwSmFcql+/5fVVCQ2tyaryUUTMDVN6kUbE3nbYG9tCwnPO6tmfhfrPFD1WNv
         cQlQlMXdzORWGBR7Dfov/pXiSJn4jhB1Rin9iyjfzvWZT0LZmKNXa0P1t2b4lt6ExtPV
         /YUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755194774; x=1755799574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IiwDYZLPHBCwryyT3uECATdVMw9CdaQ+dyZ7QK0KM9A=;
        b=gBUgEqAM/tY8u7UoLB2Eh/VbnoSQns2Pg784P/EXV7KHAR6x25tB60qSkJL+QMkF01
         xaOnEOuLZcvEGfdKRXsJEmGf+gn2Vo75616aKZPpa524g8e9gZD5HSRvCqNqkvn63cl3
         8uhvs/S+lfOxuD6rxMHkoBiIuCJl4LF1y1buCznL5F7OJBJzpf8UTjJXgURpKV3/a8Vw
         anGrKFnvLI+oBsFeLT95GxwGo+RrDK4nwpYgF+uDEkD6SIUmqo7JKWfA3sD2BmSo8ib4
         9ekbLFMjYM/i6aYtS60daCyYuy3BzCYFpHPpChsw/lifuX75yBOXo2uZid0COs9iwB84
         FIDw==
X-Forwarded-Encrypted: i=1; AJvYcCW6FxFtlybQUbqNb1AAlCAWxyUd8Og828F2Bjm2Od9tMoXZmSLbCs3xEetZuwDPaLSxm+6zCoSFq2Wa5/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsgUgQD/Ycu25xKr1YVltBlwU1XdFNbbY88d3aDV7cGSnYz6oT
	472e6ugHdV2JV5B2M2HuQpIZTc3bzSDrMFKd/Q5ivt/W4nwksXuw3CMVQJZF5HSyhI27hyBZ0+7
	QE7gKGC31U2RHYJy9kMhXDVCu2dDm38gOVr0q4JwT
X-Gm-Gg: ASbGnctBJ7l+Ny47o309nY3BoOBdE+v61nMGBnQSG9axb2RQDkEpSUsChp2E/eyNm/J
	3WrXR1ClACoUhjIxtVk0mX/bV1c9FD/w0O4uCnL9f5cl9P8ROOfKLYiopIwbIw60d7TnIzf572O
	KrAcakRl7CIQfdByaM9rPNaaOf72BbTVKumMmuccH6Jo0Vc5B/fG1II5fiWcnq0f/3KatLu/MM/
	pFO9YYgBCaX8Ib+cC+k3o4=
X-Google-Smtp-Source: AGHT+IHzkLz5FYr9GgEmctg/US0TXCY001uoTthKuGY4NqwthfZZqDlys1sRDX39fgb3vX8Rg4UFbpGwJ2dUiMf+CJs=
X-Received: by 2002:a05:6102:8021:b0:50f:196c:afb with SMTP id
 ada2fe7eead31-50fea2baa72mr1973573137.23.1755194774039; Thu, 14 Aug 2025
 11:06:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814111023.2693-1-wangwensheng4@huawei.com>
 <20250814111023.2693-4-wangwensheng4@huawei.com> <2025081405-automatic-perkiness-7145@gregkh>
In-Reply-To: <2025081405-automatic-perkiness-7145@gregkh>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 14 Aug 2025 11:05:37 -0700
X-Gm-Features: Ac12FXyDeRnL9Rt5ulcrn_YAvfUgPWaYA_unqSqze3s8ZINrW5Bd-Knu6pXU6Ko
Message-ID: <CAGETcx-92+zN3YivUoEU-U68=GUnGs-68+g8rM7LnLXBRH=xyQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] irqchip/mbigen: Use fw_devlink_relax_consumers() helper
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Wang Wensheng <wangwensheng4@huawei.com>, rafael@kernel.org, dakr@kernel.org, 
	tglx@linutronix.de, robh@kernel.org, broonie@kernel.org, 
	linux-kernel@vger.kernel.org, chenjun102@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 4:39=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Aug 14, 2025 at 07:10:23PM +0800, Wang Wensheng wrote:
> > Use this to prevernt the consumer devices of mbigen to be probed too
> > later.
> >
> > Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
> > ---
> >  drivers/irqchip/irq-mbigen.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.=
c
> > index 6f69f4e5dbac..4e96eb9b6a6a 100644
> > --- a/drivers/irqchip/irq-mbigen.c
> > +++ b/drivers/irqchip/irq-mbigen.c
> > @@ -252,6 +252,8 @@ static int mbigen_of_create_domain(struct platform_=
device *pdev,
> >
> >               if (!mbigen_create_device_domain(&child->dev, num_pins, m=
gn_chip))
> >                       return -ENOMEM;
> > +
> > +             fw_devlink_relax_consumers(&child->dev);
>
> Ick, no, individual drivers should not be doing this.  Saravana, any
> ideas?

Yeah, I responded to patch 2/3.

To give a more specific answer, this driver is just adding platform
devices to the platform bus that it never probes. They should create a
class for these and add these devices to their own class. fw_devlink
is smart enough about not waiting on class devices to probe. If for
whatever reason, switching it to a class is impossible, then they
should write a stub driver to probe these devices.

-Saravana

