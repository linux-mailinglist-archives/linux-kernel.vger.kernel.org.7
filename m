Return-Path: <linux-kernel+bounces-811574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6961B52B0E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E2CE1C83A7C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892E92DF12B;
	Thu, 11 Sep 2025 08:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tfG+cA9t"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81D52DECD3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757577650; cv=none; b=II8v00FmrBPtG+O5IfoK/JC2JjbtN/NXULdRVQIMPUG6lFV70AsyPsOG3jSO3Hlve/SigaRHy2Du+DgcEEVbENb1xmAgmxMiMieCkq6o+G1TdWMpYiwNl1uFr6tFSjMmlBgHB8P/4tuma7Q6hF4spRkbjuvTXZ6KxhJ1JJsUwM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757577650; c=relaxed/simple;
	bh=eUdC1JzLkUkKUWQ7l9Z2x2mvMYhblzkZezjhtg7zWA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VGIU6LWOcPVFMOSa/rSULIrlsc54/jMov0duVp7B6JSmDkofBDV+EYPTdZD08eoiLFAZwazTWsgEGfsxg0kwoFoYY1GS96Oc3C/2cA+EhG9KXpTsI2406ZQgLamvNtdK4+Hl3EFpj6aeY0tx/SGRJfygAVxLqtSEjkMDr5dUi4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tfG+cA9t; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b042cc39551so67094866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 01:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757577647; x=1758182447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1PODi6H2K7+3LlGxoQuwHZt3UE/qkC9ZdWrwkyFJNM=;
        b=tfG+cA9ttr5vG1l+62PPfCxXax3JFZKz2/lG4bVKn7jqkiLROUPnQdpsfgd/mIhO00
         bsmr2KLR0X1SWU2VGqElryWHqyzvmJtB2UyS9oaeZ3PJQXD73w4etlLg2IpZDC2ezctD
         rHS/HRZntAISeMLatENfm0UlqHKUiYE0X7IU/Fj7ENdrY+hfTnSynm4dApgUYDJ4YMwn
         RkElMTlUG+V4vGi1RU5Er2Hyvm4gBfBnkUblErDAbsvjUfyo7LvAdYmKXimIZnRm/VC4
         nEo8oVvbHpexEoK8gLmAzI0cj5Wukt+g5qKwoqzMt9VgVmWbsBmHIU7qWA7b+fFC2vtS
         ibRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757577647; x=1758182447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1PODi6H2K7+3LlGxoQuwHZt3UE/qkC9ZdWrwkyFJNM=;
        b=jiYlc5kwKV/ox89TWGnFQa5u3JIl1W88x9zhXomC3ghRbRkXLRMt9MbXDqB3dLb2rV
         8xgOf9H1zJHpr6wg62YRW8d0Hplrf5AYQ0r+UrwG67c4uDPQ2XnmR3ttMzpLBvEs6ljq
         RG44sEfdmgMX30ueBz9bAc0DmxPNuoVmGFFO3XjQ6tE1of02wVZsA02oEDqSrhQ4PB0f
         UHaiePgI2UvHK0bWogJXF04b95UBMMs2bRnxuUNw7cGb75RdxeYXdhXdpeB3t8N6KD2W
         RTQmzKplpbLLi39TnpFUOj+2wgSpKVQZNk/VTussJI2lRQQ5UjEL2xsSvzRmoCi2OuWq
         VqzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5ACsRGMD5mHhObLQ2BVdNpKySXfqUIQYqHw4WQYhtA0y/1kUdXEv5QvSkTyT1/lPLNvQXYXWqKC6w/WU=@vger.kernel.org
X-Gm-Message-State: AOJu0YygE5+8zzBmhfjrpELIJGJsS1zzyWNHaOL16FxU6kHjkTac07If
	rl7SRNWmXG3EyoZfnMVlku5mdvV+HA/ohPp9MT4WigB/GWKD2lIjdJgyoFN4NF3Fyyo40gMSPm1
	Xn2c9x85oxh8t2qwy9g50U4dPE7qgqSlr9Cox0oLBcg==
X-Gm-Gg: ASbGncueZ70yiOJG1r1G9HMAzLiGNNRhsPN6ebf1iMl8J0Rt5JHUvddJ9UJXSYX6GGE
	HBx71NcBIpmMMxsq6K03nO3o1eSIrv19beS96+6ctITH9pOwQIQ/8yVx/73kRyi5vArwRV7kj4Q
	mH5bb0u6vyJO37H5HZPvN9c+z5op4OkuEXqOIpdEZWjeH31OwjMvSRyk5pHR6vfpDU7+IqMQTUY
	ouVwJ/1zp7IAxp4lB8ClVd2XpneyH/uWcHQ2QeLqkd0dPGIUw==
X-Google-Smtp-Source: AGHT+IGzEzYwQLiPc3IcgYMCTY8qsO9y3WwakWS4JOu30bLWGh1BqDh6LLf50f7d7Tw863clhJFa4G2RQKg6ioIUUPY=
X-Received: by 2002:a17:907:d16:b0:b04:568b:8a42 with SMTP id
 a640c23a62f3a-b04b14bbbf0mr1838289166b.29.1757577646906; Thu, 11 Sep 2025
 01:00:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813060339.2977604-1-jens.wiklander@linaro.org>
 <20250813060339.2977604-3-jens.wiklander@linaro.org> <aJ1-YpgvGt4_6CFU@sumit-X1>
 <CABdmKX2FPg+hO55qWndMajuWP0kZH=OWEh9v-d8aO6HQWyxJtQ@mail.gmail.com>
 <CAO_48GEqkf_Jm8kSTPEDZkZy-YmT56Zs1Jx9zCvzETPsCzrkEg@mail.gmail.com> <CAHUa44HHSKwiBYPMSY5hj6wyWc9-uvtQVx+JLx4M5yjD5AwyTg@mail.gmail.com>
In-Reply-To: <CAHUa44HHSKwiBYPMSY5hj6wyWc9-uvtQVx+JLx4M5yjD5AwyTg@mail.gmail.com>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Thu, 11 Sep 2025 13:30:35 +0530
X-Gm-Features: Ac12FXxwSUSxE1PNcza1ZTKnBgiGX0FqXLDfvqSE4P5WPQr00OaAEtYCSrcigho
Message-ID: <CAO_48GE=FHaNzybUxjY=igyOO1oasKb9yu_yAjJEdjTQXicaJA@mail.gmail.com>
Subject: Re: [PATCH v11 2/9] dma-buf: dma-heap: export declared functions
To: Jens Wiklander <jens.wiklander@linaro.org>
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

Hi Jens,

On Thu, 11 Sept 2025 at 13:20, Jens Wiklander <jens.wiklander@linaro.org> w=
rote:
>
> Hi Sumit,
>
> On Thu, Sep 11, 2025 at 9:15=E2=80=AFAM Sumit Semwal <sumit.semwal@linaro=
.org> wrote:
> >
> > Hello Jens,
> >
> > On Fri, 15 Aug 2025 at 05:00, T.J. Mercier <tjmercier@google.com> wrote=
:
> > >
> > > On Wed, Aug 13, 2025 at 11:13=E2=80=AFPM Sumit Garg <sumit.garg@kerne=
l.org> wrote:
> > > >
> > > > On Wed, Aug 13, 2025 at 08:02:51AM +0200, Jens Wiklander wrote:
> > > > > Export the dma-buf heap functions to allow them to be used by the=
 OP-TEE
> > > > > driver. The OP-TEE driver wants to register and manage specific s=
ecure
> > > > > DMA heaps with it.
> > Thank you for the series.
> >
> > Could you please use EXPORT_SYMBOL_GPL_NS instead of EXPORT_SYMBOL for =
these?
>
> Sure, what namespace do you want in the argument for
> EXPORT_SYMBOL_GPL_NS()? "DMA_BUF"?

I think "DMA_BUF_HEAP" may be better?
>
> >
> > With that change, please feel free to use my
> > Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
>
> Thanks,
> Jens
>
> > > > >
> > > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > > > ---
> > > > >  drivers/dma-buf/dma-heap.c | 3 +++
> > > > >  1 file changed, 3 insertions(+)
> > > > >
> > > >
> > > > Can we get an ack from DMAbuf maintainers here? With that we should=
 be
> > > > able to queue this patch-set for linux-next targetting the 6.18 mer=
ge
> > > > window.
> > > >
> > > > -Sumit
> > >
> > > Reviewed-by: T.J. Mercier <tjmercier@google.com>
> > >
> > > Sorry I haven't been able to participate much upstream lately.
> > > >
> > > > > diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-hea=
p.c
> > > > > index 3cbe87d4a464..cdddf0e24dce 100644
> > > > > --- a/drivers/dma-buf/dma-heap.c
> > > > > +++ b/drivers/dma-buf/dma-heap.c
> > > > > @@ -202,6 +202,7 @@ void *dma_heap_get_drvdata(struct dma_heap *h=
eap)
> > > > >  {
> > > > >       return heap->priv;
> > > > >  }
> > > > > +EXPORT_SYMBOL(dma_heap_get_drvdata);
> > > > >
> > > > >  /**
> > > > >   * dma_heap_get_name - get heap name
> > > > > @@ -214,6 +215,7 @@ const char *dma_heap_get_name(struct dma_heap=
 *heap)
> > > > >  {
> > > > >       return heap->name;
> > > > >  }
> > > > > +EXPORT_SYMBOL(dma_heap_get_name);
> > > > >
> > > > >  /**
> > > > >   * dma_heap_add - adds a heap to dmabuf heaps
> > > > > @@ -303,6 +305,7 @@ struct dma_heap *dma_heap_add(const struct dm=
a_heap_export_info *exp_info)
> > > > >       kfree(heap);
> > > > >       return err_ret;
> > > > >  }
> > > > > +EXPORT_SYMBOL(dma_heap_add);
> > > > >
> > > > >  static char *dma_heap_devnode(const struct device *dev, umode_t =
*mode)
> > > > >  {
> > > > > --
> > > > > 2.43.0
> > > > >
> >
> > Best,
> > Sumit.



--=20
Thanks and regards,

Sumit Semwal (he / him)
Senior Tech Lead - Android, Platforms and Virtualisation
Linaro.org =E2=94=82 Arm Solutions at Light Speed

