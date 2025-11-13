Return-Path: <linux-kernel+bounces-899163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86670C56FFA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C613BF93E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60BE330D24;
	Thu, 13 Nov 2025 10:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o4kKUDTO"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD2333120B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030573; cv=none; b=YizKZ5a5WkhOXyYakBSY8Uo5toSJjqCroa6FRLSOcYB+x4GDrwEn4BWtebKLu2DQktgcl2NEAi9DLtZ+osGgiuOUnrAq17x9RKSWYmLj947qUcBwXl3WwotTeceYo8KkFpvKlA4Uf6f5v9m4Vjk9syJOf/WycnEn1MlL7owAzOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030573; c=relaxed/simple;
	bh=Y2beyEks39HhBc2BrxrHaxgpiCJTDWPeYBQlMBA5pyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1cfjv7wArkVCShGF7/xS8l14B3T5cFZSHrvbZ+Ar8f89K+R29aT6rcmzGmAKA1zJ9gv5+sNnPZVlnLT8mQhp2KC27+NYlgOF9i2kyoiMWYWbGuVSpbBMupTEjZFWK0d8AIxh+LrtpkIt0MRK8w9P+Z6qNTnwz1Yycy913lHmGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o4kKUDTO; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ede12521d4so222441cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763030570; x=1763635370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LeSfacy1gs/xLiayFMR+nTUKUnhwINpOKIlFew1QGiY=;
        b=o4kKUDTOhrDUIlI72twzzXIeZBSAvRXsDh/lNy/kLuU8j1YmauTMakLPVudESa9Po5
         iTitvYOFBKzxCVnW9Pw/oO0BykIH7ty96ACQp3PldWK8EFfTRhpAQXuDr1iz46vrV0jN
         w1UtdfNiPKXbGHnyjgN6WY+jLoqrhd0JRfk3WsTQFFUfTAemp+UXliA+eMsDfp60LJfZ
         1B8RoNQ9oniIpI5euU22+cdHVoJPLp9FPaqXUHr0alenHo9MDFSpAE2PaLy2xLM3L9le
         VV2Q5la97jTCaWTLzf92aUKZInHELzUxpx9O8RTx1sAnQioLYVqv4BBMvLNsKwTBBlqZ
         naJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763030570; x=1763635370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LeSfacy1gs/xLiayFMR+nTUKUnhwINpOKIlFew1QGiY=;
        b=d7bH56jS+LQwoizUZvA5ElIWtBWgIV1m6ogpLQgUgcKc1AkBqJ6IIfFJN1lebKmIF3
         J38Cevqp8S4YuysDBxSqzqQJDr9qHuT928lNqZRWXu4i2HtBFsdiDA3h/CwjO2wb/5Gw
         OMwE5oc7JTsa+hrrlyMiKfk9Gy+lJPkt8I1tD3TOAVhnxZLb/zKjY7pGbldFKUOBZjvO
         StmwDidCdyRQwuSuVDfFnxJk72DXrpDg7svviIruuFCKLm4iKbGRznnnrwq7gSf2efwM
         hc9Nd2B50leG180CMvKf43W5y/dH4mNLecphIdNTFnwz1ciEg6IUJv6PTvQ+k44bh8jB
         U8bw==
X-Forwarded-Encrypted: i=1; AJvYcCXtXpbb9jONh5TjWXLMDfoSwo9HPN0NugP8eXdf7toyCP6Tu3LsULNTKRuEkVjnIoHVVq7D+dfjFtMG3Bo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7m/wlE2NNCP0LQnI5lB11CK1oJMuxtTfA2ooFg4p5JkOlJNAH
	3eZNA+QAsjS4pDwgs26mbEmyxB9AmpvYj6+Lugp6rUuLwm7RKqhQx1cBmQ8Xpr6b1zovC8MWB4E
	npanT8KYmD/M0/Ik6HvXOAHA/qjGbkIIBMFhq1O4a
X-Gm-Gg: ASbGncuSt9Cx4nfgsz3/WU/iQfCkLw5P/dhUSSO2xvvH/Zp2K/HvhtfCn7IIrshfJzN
	RMLCJcwpatfLgRos49vUoz+9LmSBYbWTViL1U/KVqfHZ0aar6exBVjAEGuMXKxlSA2DiAVNFsw8
	4i8lkn5cjCZ9bq1Ta5Gs+uaRrNpEgPZZIRI/13UFBZwjfgZO6ZNhAQwRBzFiWIKpREYcVTBf0zA
	Y3K3ziep+U4bc9iwiQhSgRpzTZIWooIrPqay4K7FY0NMZ6+lAtAfJYsbROBmhjk4OdmMBzP140/
	Y9lH3A==
X-Google-Smtp-Source: AGHT+IGuq3UUASg2Jn8+Z0VXxFfKQzi8BW0tAm9drL020DxGhTLHU+Jdz0fBGmwffHQHjH6oxzuUdHoSWkLgUx57T1w=
X-Received: by 2002:a05:622a:c6:b0:4e8:aa24:80ec with SMTP id
 d75a77b69052e-4ede787ca08mr5670161cf.14.1763030570203; Thu, 13 Nov 2025
 02:42:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112192408.3646835-1-lrizzo@google.com> <20251112192408.3646835-7-lrizzo@google.com>
 <87ldkack1o.ffs@tglx>
In-Reply-To: <87ldkack1o.ffs@tglx>
From: Luigi Rizzo <lrizzo@google.com>
Date: Thu, 13 Nov 2025 11:42:13 +0100
X-Gm-Features: AWmQ_blpYZ1m-Z5TN3Dc6kUMVoF93xIL5WA2KrstazbwKwzAJ5LDdCDfctKA0QM
Message-ID: <CAMOZA0KYpxXB7teDuxR1U2JJ4dOBR1KveR-F8MJuqGVodT6J+g@mail.gmail.com>
Subject: Re: [PATCH 6/6] genirq: soft_moderation: implement per-driver
 defaults (nvme and vfio)
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Sean Christopherson <seanjc@google.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 11:18=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> On Wed, Nov 12 2025 at 19:24, Luigi Rizzo wrote:
...
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -72,6 +72,8 @@
> >  static_assert(MAX_PRP_RANGE / NVME_CTRL_PAGE_SIZE <=3D
> >       (1 /* prp1 */ + NVME_MAX_NR_DESCRIPTORS * PRPS_PER_PAGE));
> >
> > +DEFINE_IRQ_MODERATION_MODE_PARAMETER;
> > +
> >  static int use_threaded_interrupts;
> >  module_param(use_threaded_interrupts, int, 0444);
> >
> > @@ -1989,6 +1991,7 @@ static int nvme_create_queue(struct nvme_queue *n=
vmeq, int qid, bool polled)
> >               result =3D queue_request_irq(nvmeq);
> >               if (result < 0)
> >                       goto release_sq;
> > +             IRQ_MODERATION_SET_DEFAULT_MODE(pci_irq_vector(to_pci_dev=
(dev->dev), vector));
>
> What's the point of this IRQ_MODERATION_SET_DEFAULT_MODE() wrapper?

I wanted to avoid exposing the module parameter name,
so that adding support in a driver is mechanical and we can
change the name in one place for all (during this review or later).

Ideally I would have preferred some generic parameter
irq_moderation.enable_on=3D"nvme vfio ..."
to set defaults without having to patch individual drivers.
But I have not found a way to go from the irq_desc to the driver's name
(desc->name is often renamed especially for NICs)

cheers
luigi

