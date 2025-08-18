Return-Path: <linux-kernel+bounces-773251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA61B29D51
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97DB81886C81
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A292630DD1D;
	Mon, 18 Aug 2025 09:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqdUyRkz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213692EE5FB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755508228; cv=none; b=RaAfOWruMdoG0YK6cdvCS8xtsZFqKQQeY7YJkOfR3pciCdhpGfAue2FOFWMLAPq1wgGFwXm4e2PJDUa9asPxix8ezSt6y6UZz8kzOoMNdDFE11SxZ/d45VKh3itW5J8xnvV0/NiQdU+qZE8lo8fTOOeaIubeWuHHIh05iSqnSVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755508228; c=relaxed/simple;
	bh=OoxFyzWMN9IiJadvJ63P+IvmvwWMqWQXae/OyA1JJCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXh2Z9Italn1wCtauyWpUwi6P49XU/i2SPbS+M3cLWL5WX5L3eXPvDDfE1L3jGeNgwCTKdYndtEFO0SNwEH8H8uJJFRtrS2XxKvOJTQTO1+m4b/o/l9X50v+4uDVaKVpoADRsAbBmoWI5jICmjzw6Ng1qAq9nBxJpQxyDpWT2vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eqdUyRkz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755508224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JbqfCfcRPkiPSf4BnJf27P0ti29xxEnyI41pHA552G0=;
	b=eqdUyRkz/KthtScv4so5tn7FUaUaTJk751bdekuuNnN9ENxix0q9ldiSkttw2c5ttvoNSJ
	eaientCa3B2xwfVhUbDtBetfUCwCsXupYsqC8loc/3ldLRv9CRTUmP1WmVUZcUr4gMXah4
	Yw2awutzL89V9FBDVfldJ9Miqiz6Ylg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-nTa1eA-gNuONU-_rwUDtFw-1; Mon, 18 Aug 2025 05:10:22 -0400
X-MC-Unique: nTa1eA-gNuONU-_rwUDtFw-1
X-Mimecast-MFC-AGG-ID: nTa1eA-gNuONU-_rwUDtFw_1755508222
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32326de9d22so3905690a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755508221; x=1756113021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbqfCfcRPkiPSf4BnJf27P0ti29xxEnyI41pHA552G0=;
        b=PKdYJ5qXyuUH0zd2rgRV57wQjlYTpcgtnA/BgBG6dVB3X+CIxyTiaRQIP48U84rm9I
         wtmyYCqvV7vd7Um6aaWS6ZcvtqG8GPZEQZYo2yBtw5jwPuBfbpdiA21T5MDOU6RHfAqA
         aSOTxfiVctUEA7wIUU1ThJLWNLkJCLIC2Au3Rj97ACN3HfHrF1swWtb0W/GhtKhQgTjV
         lKPmBs+Zspoa6PxPAwHy/lqTFmwIWmBCkv+R1SPDLaWsvzmump6FkRIoM89Y/bwtnyue
         /DNiVTRBV2L7tC3o6BL8FQDH/15Xq1FQPFKqZ2zTXgFwSi1UYWkRdKaO3o/v/CUlA4/m
         MF/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWp4uCR+zyFQ1jDsU7Uqai1NVBbQApBKrB+q5r08x5ophWpt0NRSImXS5LMz8hFnVUNjIynlYQoJi7DByE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLZSxG+NXgdHuGAdHQL9A7RMC2UJCZ+if50cdGRRzyGevJneNN
	4+cvvse9NvuAZA08ORmG70aB7mbZfeyAHSW7AWY38ZPcSfaxQPm/SC8Pxe7ewkF01FfyzNdGi7V
	WXKqGQzQ+T6/xRQJ3Tj/kgxInuzXRGLKU/9J23AUOupPaeYMgjcocbIwWYBqgJdejpc50HdpZ7h
	9HlPQ9VPsTnQo2bk6U1CX53GQSXtJIfxYtsby3roKg
X-Gm-Gg: ASbGncvTpwwKIso0wvCdhFcv1IxoMb6/D39KM+e1RrM8x3LrQRkrWK0ROpq6Z7w38Di
	HxCHArtzf32Xnke3Ec8cRzPvFP9m9hqWQDHaCXZkFT001ysSIHIwHSVQA9AGgDt5wusstpEyp1h
	77IYrbzQwg4/B6lnhgc8ZM
X-Received: by 2002:a17:90b:3f85:b0:31f:35f:96a1 with SMTP id 98e67ed59e1d1-323407b888fmr17497495a91.15.1755508221453;
        Mon, 18 Aug 2025 02:10:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkbIi8hMym2IDFiQZsok2ZF14sb98uoPQT+I2UMlsCLp+g2zYDDJHRmmtJoXScx/v9hOzXO0IqsunBpLjVMGs=
X-Received: by 2002:a17:90b:3f85:b0:31f:35f:96a1 with SMTP id
 98e67ed59e1d1-323407b888fmr17497455a91.15.1755508220998; Mon, 18 Aug 2025
 02:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813054831.25865-1-jasowang@redhat.com> <20250813054831.25865-5-jasowang@redhat.com>
 <20250813043151-mutt-send-email-mst@kernel.org> <CACGkMEuKmn4f9spFT1YxjVPxBFkdGVCTQEUpNG=xHd6hcL-a8w@mail.gmail.com>
 <20250814063927-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250814063927-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 18 Aug 2025 11:09:44 +0200
X-Gm-Features: Ac12FXwWauHktoes46vJLvSCJWNDiN_iFDjd86oNm9bmlCrp2KcPLKWq_c4Jgu4
Message-ID: <CAJaqyWcxV+f6dhKLscGGy0bw2YWJ8NaJ4QN+Qe3Ax7C+Lf4X-g@mail.gmail.com>
Subject: Re: [PATCH V5 4/9] virtio: introduce vring_mapping_token
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 12:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Thu, Aug 14, 2025 at 11:36:22AM +0800, Jason Wang wrote:
> > > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > > index addbc209275a..37029df94aaf 100644
> > > > --- a/include/linux/virtio.h
> > > > +++ b/include/linux/virtio.h
> > > > @@ -40,6 +40,13 @@ struct virtqueue {
> > > >       void *priv;
> > > >  };
> > > >
> > > > +union vring_mapping_token {
> > > > +     /* Device that performs DMA */
> > > > +     struct device *dma_dev;
> > > > +     /* Transport specific token used for doing map */
> > > > +     void *opaque;
> > >
> > > Please just declare whatever structure you want it to be.
> >
> > It's an opaque one and so
> >
> > 1) the virtio core knows nothing about that because it could be
> > transport or device specific
> > 2) no assumption of the type and usage, it just receive it from the
> > transport and pass it back when doing the mapping
> >
> > It should work like page->private etc.
> >
> > Does this make sense?
> >
> > Thanks
>
> I fully expect most devices simply to use DMA here and no weird
> tricks. vduse is the weird one, but I don't see us making it
> grow much beyond that.
>
> So I think for now we can just make it vduse_iova_domain *. If we see
> it's getting out of hand with too many types, we can think of solutions.
>

I've sent my series of adding ASID to VDUSE, which uses this series'
token on each vq group, on top of this version of the DMA rework.

This patch [1] and the next one are the one that reworks the token to
an empty struct, so virtio can handle it in an opaque way and VDUSE
can convert it back and forth in a type safe way, skipping the void *.
Please let me know if you prefer to import a VDUSE header into the
virtio config header or to make a VDUSE forward declaration instead of
going through the empty struct to preserve layer boundaries.

There is one usage I've not been able to convert though. Jason, could
you take a look? It is marked as TODO in my series. I'm not sure if
that's also an abuse of the void * in the DMA rework to be honest, but
it should be easy to correct.

[1] https://lore.kernel.org/all/20250818085711.3461758-4-eperezma@redhat.co=
m/T/#u


