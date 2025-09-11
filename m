Return-Path: <linux-kernel+bounces-811631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20522B52BC5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 196B27BBE6B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AA42E2F14;
	Thu, 11 Sep 2025 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ilWwErg+"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29FA2E2DDD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757579709; cv=none; b=XFHDvxNJwOPmxGLKmgVQgjGpYQARK8YZB4SQmfqBUZ+Bh/m4TQVLsf1LN0Grppa0PD/EiXfekekIbqZ53WEay94XsDul4lcPa/VdbkwfZXaljqo5lud30HXMlyWClO7e88E8aA0YyGlV/mjY6RaFmTzXGuPYMZbjdvW12n9NI+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757579709; c=relaxed/simple;
	bh=T6ilPcXZgQ5f5CxPTAYUfjyTCdf1YYJ3+E29eRIGUTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kw5M0vStytn6CYaQ+1GZbN4zt+xJMr39hub10Gzrkx72phsYra+1zfJeG5TtYTPxpFUWx9BjSI/KLKsoaPrDEzKUHtBheM8W8rpdpPLrLOkDQK+kJfbVFf5BE7FwnurQ4s3V6X94Ea1OFp2AWsnqFDe5JQmMx8n6ksqLBzff95Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ilWwErg+; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-74526ca7d64so464737a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 01:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757579707; x=1758184507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3kQgAiwPfvEAAOGUV7iUTri/K2HtvbKjHs1xtQRX0U=;
        b=ilWwErg+wKTRWwdDweqCYtBQs0YnKgvW9qbHBGFsSCHzfUAAmT0PY45Ock0KUp5fm6
         NVOwLtUFUoW22vUeCxIBqYnZ4WduWP8/zIb23pInc7+80tB2KvU3JyHtNLFp35o2rBjg
         a1j26qVH0Mk1l9bZfo8aloCVu0zxRZ2gEySdZbYWJ99vdapdRJPJJhhOyKBJYfaSFm2y
         bYNordX4gnXIrIbJ3/IuE5nctMqbNCEi5n4z8QrUNSWhdm8CDyFPziOqGfDPKVTlhEIZ
         FHwSe/u02qNRBa2oSGjXNNZ5vwk+2B2YktK/gZKU6o/Z6KZ8xl2W34sQF2Lk8QLLmFEE
         O+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757579707; x=1758184507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3kQgAiwPfvEAAOGUV7iUTri/K2HtvbKjHs1xtQRX0U=;
        b=nrWsTEANnbu4SWcCFTc3Lrmcy9vj3c2KZxYWrrvc5g2FwV9LoMDc4TcaXER7ZlFIHw
         3lWCXgp4GAzMx7+3QmDjrpG2p2v7ByTwCuAaFrUgcx9wwbglIqfnv+et3tfvOlifcEi4
         DIQkAqvZ2yYCfSFblQIQxFoPaiPS+Mh0RlXTmKsbeZGiimntFBzv+mCPLsRQcyh/JGTe
         qxfDo46r+xsjt2eRd/GEj2/lwPwb+gXh2i7qelHCGzPsdMJcbVY5msDoygy1L7vcCKAI
         1uiWvp55JB5B8ghUHJBJlVbw2S3zKwEhjzTL1uLvRP4zVtMDfjHLOioQ+d+ZOn0k6p8+
         OIbA==
X-Forwarded-Encrypted: i=1; AJvYcCVdla6H7Hll07LgJ2HoZTV4Xh+JbgoNqbsVbGT2K8ShAnDdpmZ//n6/xS1MPcuU7s/9kfiLTTxIGooPML4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFXFUsh3xQ52mxkJQm9fKu8WP4f0Y1rE9dcABb/B8mC8FPCtap
	QF2t0RN4hNUZ4aZU/Tg887xlhkphOMoAJ5JFllcerN8sV2HESZ/Wlaz1Q4J5HmuMkPL9DR1vIbK
	whA4VW7JQYgdPetWDGhneo1/Sw1zQvA2tj751KzBDyA==
X-Gm-Gg: ASbGncu03nq6rP5HMPzT53+bOhbiu3Sy8Pe6K9HkhdydPhA//pO9lqH+DA4zD3Sfbqt
	9ELBUSJNPsyU97uGb+ej56ZpRWVSEQm8FDBC78sAv0Ajo9OxF54HwKk0a2StFsGQweGViU4zYtF
	yqOhwn6DvEbCcaqdX5/FT7up+z+8i9sZOas2YlsnOJCFFnCgmZDaYeG7pmL3aoWMDtYd0eGuz/k
	04CuCTcgMQduLgKe1M=
X-Google-Smtp-Source: AGHT+IFeh9GhwJV0/BRbDqXK1301VOv+yaAADE4wRS2wEzztzMHQXFq1Ue2WE8k5BTs1i0e0aU2GdBSeES8eqZ6R/tc=
X-Received: by 2002:a05:6830:348e:b0:74b:3422:f33d with SMTP id
 46e09a7af769-74c66acfea9mr10389569a34.0.1757579706886; Thu, 11 Sep 2025
 01:35:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813060339.2977604-1-jens.wiklander@linaro.org>
 <20250813060339.2977604-3-jens.wiklander@linaro.org> <aJ1-YpgvGt4_6CFU@sumit-X1>
 <CABdmKX2FPg+hO55qWndMajuWP0kZH=OWEh9v-d8aO6HQWyxJtQ@mail.gmail.com>
 <CAO_48GEqkf_Jm8kSTPEDZkZy-YmT56Zs1Jx9zCvzETPsCzrkEg@mail.gmail.com>
 <CAHUa44HHSKwiBYPMSY5hj6wyWc9-uvtQVx+JLx4M5yjD5AwyTg@mail.gmail.com> <CAO_48GE=FHaNzybUxjY=igyOO1oasKb9yu_yAjJEdjTQXicaJA@mail.gmail.com>
In-Reply-To: <CAO_48GE=FHaNzybUxjY=igyOO1oasKb9yu_yAjJEdjTQXicaJA@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 11 Sep 2025 10:34:53 +0200
X-Gm-Features: Ac12FXx5ebSInGSvpsrj2pSWY8lp7qtZdsTImt4o0DLikSjOCGD4PzhkPWZzq-g
Message-ID: <CAHUa44HkMNO1ONTGEKHCPXRQwg3zqYf5ZHmxEijW==vbmd1LFw@mail.gmail.com>
Subject: Re: [PATCH v11 2/9] dma-buf: dma-heap: export declared functions
To: Sumit Semwal <sumit.semwal@linaro.org>
Cc: "T.J. Mercier" <tjmercier@google.com>, Sumit Garg <sumit.garg@kernel.org>, 
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

Hi,

On Thu, Sep 11, 2025 at 10:00=E2=80=AFAM Sumit Semwal <sumit.semwal@linaro.=
org> wrote:
>
> Hi Jens,
>
> On Thu, 11 Sept 2025 at 13:20, Jens Wiklander <jens.wiklander@linaro.org>=
 wrote:
> >
> > Hi Sumit,
> >
> > On Thu, Sep 11, 2025 at 9:15=E2=80=AFAM Sumit Semwal <sumit.semwal@lina=
ro.org> wrote:
> > >
> > > Hello Jens,
> > >
> > > On Fri, 15 Aug 2025 at 05:00, T.J. Mercier <tjmercier@google.com> wro=
te:
> > > >
> > > > On Wed, Aug 13, 2025 at 11:13=E2=80=AFPM Sumit Garg <sumit.garg@ker=
nel.org> wrote:
> > > > >
> > > > > On Wed, Aug 13, 2025 at 08:02:51AM +0200, Jens Wiklander wrote:
> > > > > > Export the dma-buf heap functions to allow them to be used by t=
he OP-TEE
> > > > > > driver. The OP-TEE driver wants to register and manage specific=
 secure
> > > > > > DMA heaps with it.
> > > Thank you for the series.
> > >
> > > Could you please use EXPORT_SYMBOL_GPL_NS instead of EXPORT_SYMBOL fo=
r these?
> >
> > Sure, what namespace do you want in the argument for
> > EXPORT_SYMBOL_GPL_NS()? "DMA_BUF"?
>
> I think "DMA_BUF_HEAP" may be better?

I'll use that.

Thanks,
Jens

> >
> > >
> > > With that change, please feel free to use my
> > > Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
> >
> > Thanks,
> > Jens
> >
> > > > > >
> > > > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > > Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > > > > ---
> > > > > >  drivers/dma-buf/dma-heap.c | 3 +++
> > > > > >  1 file changed, 3 insertions(+)
> > > > > >
> > > > >
> > > > > Can we get an ack from DMAbuf maintainers here? With that we shou=
ld be
> > > > > able to queue this patch-set for linux-next targetting the 6.18 m=
erge
> > > > > window.
> > > > >
> > > > > -Sumit
> > > >
> > > > Reviewed-by: T.J. Mercier <tjmercier@google.com>
> > > >
> > > > Sorry I haven't been able to participate much upstream lately.
> > > > >
> > > > > > diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-h=
eap.c
> > > > > > index 3cbe87d4a464..cdddf0e24dce 100644
> > > > > > --- a/drivers/dma-buf/dma-heap.c
> > > > > > +++ b/drivers/dma-buf/dma-heap.c
> > > > > > @@ -202,6 +202,7 @@ void *dma_heap_get_drvdata(struct dma_heap =
*heap)
> > > > > >  {
> > > > > >       return heap->priv;
> > > > > >  }
> > > > > > +EXPORT_SYMBOL(dma_heap_get_drvdata);
> > > > > >
> > > > > >  /**
> > > > > >   * dma_heap_get_name - get heap name
> > > > > > @@ -214,6 +215,7 @@ const char *dma_heap_get_name(struct dma_he=
ap *heap)
> > > > > >  {
> > > > > >       return heap->name;
> > > > > >  }
> > > > > > +EXPORT_SYMBOL(dma_heap_get_name);
> > > > > >
> > > > > >  /**
> > > > > >   * dma_heap_add - adds a heap to dmabuf heaps
> > > > > > @@ -303,6 +305,7 @@ struct dma_heap *dma_heap_add(const struct =
dma_heap_export_info *exp_info)
> > > > > >       kfree(heap);
> > > > > >       return err_ret;
> > > > > >  }
> > > > > > +EXPORT_SYMBOL(dma_heap_add);
> > > > > >
> > > > > >  static char *dma_heap_devnode(const struct device *dev, umode_=
t *mode)
> > > > > >  {
> > > > > > --
> > > > > > 2.43.0
> > > > > >
> > >
> > > Best,
> > > Sumit.
>
>
>
> --
> Thanks and regards,
>
> Sumit Semwal (he / him)
> Senior Tech Lead - Android, Platforms and Virtualisation
> Linaro.org =E2=94=82 Arm Solutions at Light Speed

