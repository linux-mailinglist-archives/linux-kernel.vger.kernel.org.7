Return-Path: <linux-kernel+bounces-840708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B88BB50B5
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 21:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 324EB3B4138
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 19:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C5328726E;
	Thu,  2 Oct 2025 19:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="19rHdDi5"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E61946A
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 19:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759434357; cv=none; b=OGKTSbDcH8KqafaRFkaJxzqRyCFJA9nA7iTZMRa45EC0eGpVZUAYsFy1lmTq2YbdIU8aiyff3nbjFIAvKn6tEQWituvv0nWyEn6Y9OtULfjFZjvQj1MgK+pR/8YJb39VR4PE9bvfqj96XrdNeWSGauTA+1fK5OzBrJPKfpCP3jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759434357; c=relaxed/simple;
	bh=aJhwi6rg9jEdvslC8cDKgP1fwXd3hdCc5/+gx2zo1yY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CcRLBAvJeXgxUF5SEosHhRoapM9TiR+F484EwegBfBc7hq5vc2SB2r3Wn3oi4gjoo+IkTesjm2ohOw0GkWRzx/AV4J5MrJx9IekHetXFQQE5XLpF0KrDQuHm2A/rVQr5hV3wjNtInv/F+M8enJ3xx40RfCKrugnW7dhZCdghojQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=19rHdDi5; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3be330b1f5so273617266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 12:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759434354; x=1760039154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4gQv0EOz4rGm7+DH/Ll/ylPaIILm6U8HqWQMm5vF7w=;
        b=19rHdDi5VvSO7L8Fl3kfII80hcsyWlMv3YUhtKPgTp3yqqknS7McZMlA+fmrk+Cwfr
         UKwIJga6rT8VPtbzEOe33gXnR6s1ilHIbDb1Vj71/4BU6umvTsvUckC1M4bVT7zyKnUJ
         9r7Xc/JbHTEDRV5YrXClSswsDaHLJNqm/i/LRxSFad1U6utv8SHloYOeXSMFtSmQecqN
         vCj2m9i/+4mDimxay7FEpiJVrxRIQzY7lD6+y5KYJjJDuP85N9E3Dhqz+X2N92fyWd4T
         t7EJkqn9LAOe0m3/HUNZ+XtTskJLXYinYMUUAwMF4GL9oXy+LhnPAVDGur8ToPFknqRF
         UIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759434354; x=1760039154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R4gQv0EOz4rGm7+DH/Ll/ylPaIILm6U8HqWQMm5vF7w=;
        b=TvTlqIMfaGz/844Rrc9UYzOLxm+lBHy6KhLKFba32496XmVLT3GuU7/twDSHgE5jF9
         /7cXecKIfMYAgImFbY8RjhLMFskamOGIdXVyiG/jj0b0hLvnPNQSNI9gW6wOc1Mn7Doy
         zLKuM8T5S8cF0LVIIUTi1SuJK37vEsqi7wiM9RvlpUFSwcWtKH9GNmZvIpNJXB3WBnA1
         Ab240N4IuubPIps1Doh6askqB8u6ZYUKexxGF8Uf0Oh3ik6O+4/HehMOCIhaCGNFpYdS
         41BELmGV+I2RdNm1zk/QMgMalD3oT0L50mv7k/xCahwaGwGujwYJQ3bMI6XLhMEhzBgt
         AkIg==
X-Forwarded-Encrypted: i=1; AJvYcCXAv827pDXXG0/cRhlKyj0pv2lrc9XO8//36bUDvrzZq3zhnZ97wveR1sFKbn7RyEKr1+8a2qZ0Jrb45wM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxqeTyZsy2ki1mJxNGO/FxMvvHNRlan6WTvG7rQ8oZZovbj8CE
	/f1GLhqH34MzU9phxsTrCn8B/97O4+rcG0Lo2LcwLkzIPDIRyeU5JjCnmMFvNZ2q6ym9193g1zd
	nuN8h07XdPLjSO9rUpCPQsPm4tvAcFARu3qM0Iew=
X-Gm-Gg: ASbGncsJgKx9e7Te1713cCfP6p++ymTjKjBDXwfIgcUggBGbG2XX1gZtsByc1ae0he4
	EBGMwCQwclvEvU4fSFoSp3FZQfIzu8PWA+rq2LD2aThMg12TExutb97Lkd5Nj91U6Sms2nXdp7y
	fOyEJn25mXg3VJEd72FV5ploW0HnCHJPI7FKrt/bOAti2109DFlUdBDq2kU98HXlc4blWB1m+yB
	c5mnuYj/GbgsL6P4RnZYBxK7VnvFNcHDr5nq/yD+ZfwCva6Ug6wNKxkcr8JVIgkaIo=
X-Google-Smtp-Source: AGHT+IHFUMZbxy2/RNA58+rbmrFxgard/FJeBDueJyRahdE9BuRrcf+Nu3HssY90NgcmF3JiiWGdZyfE5Xm8slA6aeE=
X-Received: by 2002:a17:906:dc94:b0:b3b:eb5f:9f1a with SMTP id
 a640c23a62f3a-b49c3933030mr76697066b.38.1759434353566; Thu, 02 Oct 2025
 12:45:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911135007.1275833-1-jens.wiklander@linaro.org>
 <20250911135007.1275833-3-jens.wiklander@linaro.org> <20251002-shaggy-mastiff-of-elevation-c8e1f0@houat>
In-Reply-To: <20251002-shaggy-mastiff-of-elevation-c8e1f0@houat>
From: John Stultz <jstultz@google.com>
Date: Thu, 2 Oct 2025 12:45:41 -0700
X-Gm-Features: AS18NWBdha9LdZ51VIWM4Jj3n7QLoIkRAEzrxrFPUOsILr8-gV57tRYN27CBzqA
Message-ID: <CANDhNCqS+WKhTWjeC7yBL+x4erK4S4bievTxdneaCu1haA8=hA@mail.gmail.com>
Subject: Re: [PATCH v12 2/9] dma-buf: dma-heap: export declared functions
To: Maxime Ripard <mripard@redhat.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, 
	linux-arm-kernel@lists.infradead.org, Olivier Masse <olivier.masse@nxp.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	"T . J . Mercier" <tjmercier@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Sumit Garg <sumit.garg@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, 
	Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, 
	Rouven Czerwinski <rouven.czerwinski@linaro.org>, robin.murphy@arm.com, 
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 12:47=E2=80=AFAM Maxime Ripard <mripard@redhat.com> =
wrote:
> On Thu, Sep 11, 2025 at 03:49:43PM +0200, Jens Wiklander wrote:
> > Export the dma-buf heap functions to allow them to be used by the OP-TE=
E
> > driver. The OP-TEE driver wants to register and manage specific secure
> > DMA heaps with it.
> >
> > Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > Reviewed-by: T.J. Mercier <tjmercier@google.com>
> > Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/dma-buf/dma-heap.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> > index 3cbe87d4a464..8ab49924f8b7 100644
> > --- a/drivers/dma-buf/dma-heap.c
> > +++ b/drivers/dma-buf/dma-heap.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/dma-buf.h>
> >  #include <linux/dma-heap.h>
> >  #include <linux/err.h>
> > +#include <linux/export.h>
> >  #include <linux/list.h>
> >  #include <linux/nospec.h>
> >  #include <linux/syscalls.h>
> > @@ -202,6 +203,7 @@ void *dma_heap_get_drvdata(struct dma_heap *heap)
> >  {
> >       return heap->priv;
> >  }
> > +EXPORT_SYMBOL_NS_GPL(dma_heap_get_drvdata, "DMA_BUF_HEAP");
> >
> >  /**
> >   * dma_heap_get_name - get heap name
> > @@ -214,6 +216,7 @@ const char *dma_heap_get_name(struct dma_heap *heap=
)
> >  {
> >       return heap->name;
> >  }
> > +EXPORT_SYMBOL_NS_GPL(dma_heap_get_name, "DMA_BUF_HEAP");
> >
> >  /**
> >   * dma_heap_add - adds a heap to dmabuf heaps
> > @@ -303,6 +306,7 @@ struct dma_heap *dma_heap_add(const struct dma_heap=
_export_info *exp_info)
> >       kfree(heap);
> >       return err_ret;
> >  }
> > +EXPORT_SYMBOL_NS_GPL(dma_heap_add, "DMA_BUF_HEAP");
>
> It's not clear to me why we would need to export those symbols.
>
> As far as I know, heaps cannot be removed, and compiling them as module
> means that we would be able to remove them.
>
> Now, if we don't expect the users to be compiled as modules, then we
> don't need to export these symbols at all.
>
> Am I missing something?

For things like distro kernels (or in Android's case, the GKI),
there's a benefit for modules that can be loaded permanently (not
having a module_exit hook).
One doesn't have to bloat the base kernel image/memory usage for
everyone, while still not having to necessarily deal with
complications from module unloading issues.

thanks
-john

