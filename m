Return-Path: <linux-kernel+bounces-811480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A16B529AC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95E897B28A4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0615A2459C9;
	Thu, 11 Sep 2025 07:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dar66LjG"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A23329F3C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757574954; cv=none; b=m2YGT7N5lBD6/ToZzeHzIdHPvk7Uvh45XBz94Q16c52x7jzGrsQTrPMmG6G4i8Bj05Ci3qFpF1uQBFqdp6tpuyl1XZ71WabU1Uh/gVffi0p2kDEt0nzt8CFLFnnC9p2rJv2mVJlrItEqhwZBS8QOkaZfefjNhkaEXq0H+QP4I6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757574954; c=relaxed/simple;
	bh=3IyfD1UfYcTLUF/3VnJ3kGLOU2Buly+WMW7fkboaoGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qLw4lMxmgqJNwXc7eK+xzm+UjMe+8Sa4eGqvZKu25H6PpM39ObhlUeRiVjblzlYAqw6dS5/0nDYj4p6j8umFmn+yesy8Jpi8GkQrmy0AFZvCf4h78nDY5pYl5CGezgP+JE9KOTq/X4yudmp58WWoZqZ+fVmmzwUjCnlmBBE4GIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dar66LjG; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7ae31caso57419866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 00:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757574951; x=1758179751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GP9NntJ30KfEYObDqnhrL+C6H0K6PogP4x/qLVkNDh8=;
        b=Dar66LjGy91Vfom+IrQzPwVAbPWKyxGCTInDy5FK1z+5zPUgc+iTVBGfFg0V+0FXw7
         qKSrKNfqLODUTc6GgI5ly7FJ+w0i4vDwxRFRyjIQI53N9oztrkYpWC2HT7WJYNUREkQu
         HrHe167C+vLJRaEmSQYp7rMJNhPbuk6DMjeWYWt8EjZlGx+bfGlNNJL4jTTTf8ucCVw9
         Ow3/mQORZDASnamU8Xg8v830ykhSIgDxfgr4fHnfhoMILS6/BM+BdHa7ltO+PEyQ3fta
         3x/tRr3GhWF91pfaLedz7fJgpqSG9WD+qGHpTLt6+ZXIPrmc4QqcSfHRwTIsUGH/njFM
         Zi/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757574951; x=1758179751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GP9NntJ30KfEYObDqnhrL+C6H0K6PogP4x/qLVkNDh8=;
        b=vxkJeG0oOyd8DHzgUoBUF+AmFdp/OPck1SiB8+Ky+QO9WsYsIVf49MEGc3BkrUrf/f
         3Zsu7dFNBOheXrPXzmXWTvWm+SEtgI3+zKIDcH0njlsoJDSl12Je2UQwYkBTetMx1Mso
         N11qcVQegtpXZP7XVpXy+6lUDF/m3c3/xC9OWIbxyIkD+6GzqO4CneVUODpXtkxSEBc2
         l8TXV+jWNJIfoFDdfbaoFM5meeeCjzCgE0iy07d59ZQboK6ScW5T3OQ7M0me4ADTPw7n
         4faaXaVmwhgnhlgFH8grydQKP8bC8pZKEmuakO0C7cskUMh3VhB3dJF+Dh5ucZdd3VRP
         Ok0w==
X-Forwarded-Encrypted: i=1; AJvYcCUuJZDoKWETLhXuOL7l9FURffop60qRSbun0YBeYDghr8FAhJcXfYIS3lARmHgkV5fybsBDeFT3XPewPjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwINQst6PL+xSyIV5CXEQZuNwizrbbW3syyg0IyK4ObxMXQc40f
	hASlFgh8mRXO1ENhjo293qc+zigatqj1xohH61Lw2xzbaq3niCWXj5AWsIkXi1XL+aTwPlCEVn4
	QnKzikIgvyfI/bzqFpJOhSu4imU/KFYov8s4/ogwEfQ==
X-Gm-Gg: ASbGnctkQ/Sei4CArl+MsK17Pz30Bj04zu44+isyC8yHZyuL+sG0+vTf2H5QFYZmQ3Z
	HQFJLtt/AoSUpslLaKGsmNRE0qYerA3uGFRNHAn2Y5MwWRgOlklTMPaPeQC054bWldCOxdXxC5N
	bnpZY0atM4OEVsZ4GFNEMX/Z92hO+DVPVpCMEGp7JLhd8pG0z8n5pfoREbdOP/FaXMvmigJbMrR
	niaYEMyF9UCl//+kxDPRCLr153KEqSAL2DD62o=
X-Google-Smtp-Source: AGHT+IHy2Mv7dBIklAlXQ3z1llA5qfh3QOZdDcp9k/xtxjZUz/DCzy7vfzzhI0hlOYW8883NeAHTA7AVAmb3DRGTR8w=
X-Received: by 2002:a17:906:730e:b0:b04:6546:345a with SMTP id
 a640c23a62f3a-b04b16c733fmr1789866766b.52.1757574950692; Thu, 11 Sep 2025
 00:15:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813060339.2977604-1-jens.wiklander@linaro.org>
 <20250813060339.2977604-3-jens.wiklander@linaro.org> <aJ1-YpgvGt4_6CFU@sumit-X1>
 <CABdmKX2FPg+hO55qWndMajuWP0kZH=OWEh9v-d8aO6HQWyxJtQ@mail.gmail.com>
In-Reply-To: <CABdmKX2FPg+hO55qWndMajuWP0kZH=OWEh9v-d8aO6HQWyxJtQ@mail.gmail.com>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Thu, 11 Sep 2025 12:45:39 +0530
X-Gm-Features: Ac12FXy7pNPcf0b_CAub_P3Nk83sbsucFa_59lr_vcagvKGZnRZhFr4eESPBY3M
Message-ID: <CAO_48GEqkf_Jm8kSTPEDZkZy-YmT56Zs1Jx9zCvzETPsCzrkEg@mail.gmail.com>
Subject: Re: [PATCH v11 2/9] dma-buf: dma-heap: export declared functions
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, Jens Wiklander <jens.wiklander@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, 
	Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Yong Wu <yong.wu@mediatek.com>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, 
	Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, 
	Rouven Czerwinski <rouven.czerwinski@linaro.org>, robin.murphy@arm.com, 
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jens,

On Fri, 15 Aug 2025 at 05:00, T.J. Mercier <tjmercier@google.com> wrote:
>
> On Wed, Aug 13, 2025 at 11:13=E2=80=AFPM Sumit Garg <sumit.garg@kernel.or=
g> wrote:
> >
> > On Wed, Aug 13, 2025 at 08:02:51AM +0200, Jens Wiklander wrote:
> > > Export the dma-buf heap functions to allow them to be used by the OP-=
TEE
> > > driver. The OP-TEE driver wants to register and manage specific secur=
e
> > > DMA heaps with it.
Thank you for the series.

Could you please use EXPORT_SYMBOL_GPL_NS instead of EXPORT_SYMBOL for thes=
e?

With that change, please feel free to use my
Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
> > >
> > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > ---
> > >  drivers/dma-buf/dma-heap.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> >
> > Can we get an ack from DMAbuf maintainers here? With that we should be
> > able to queue this patch-set for linux-next targetting the 6.18 merge
> > window.
> >
> > -Sumit
>
> Reviewed-by: T.J. Mercier <tjmercier@google.com>
>
> Sorry I haven't been able to participate much upstream lately.
> >
> > > diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> > > index 3cbe87d4a464..cdddf0e24dce 100644
> > > --- a/drivers/dma-buf/dma-heap.c
> > > +++ b/drivers/dma-buf/dma-heap.c
> > > @@ -202,6 +202,7 @@ void *dma_heap_get_drvdata(struct dma_heap *heap)
> > >  {
> > >       return heap->priv;
> > >  }
> > > +EXPORT_SYMBOL(dma_heap_get_drvdata);
> > >
> > >  /**
> > >   * dma_heap_get_name - get heap name
> > > @@ -214,6 +215,7 @@ const char *dma_heap_get_name(struct dma_heap *he=
ap)
> > >  {
> > >       return heap->name;
> > >  }
> > > +EXPORT_SYMBOL(dma_heap_get_name);
> > >
> > >  /**
> > >   * dma_heap_add - adds a heap to dmabuf heaps
> > > @@ -303,6 +305,7 @@ struct dma_heap *dma_heap_add(const struct dma_he=
ap_export_info *exp_info)
> > >       kfree(heap);
> > >       return err_ret;
> > >  }
> > > +EXPORT_SYMBOL(dma_heap_add);
> > >
> > >  static char *dma_heap_devnode(const struct device *dev, umode_t *mod=
e)
> > >  {
> > > --
> > > 2.43.0
> > >

Best,
Sumit.

