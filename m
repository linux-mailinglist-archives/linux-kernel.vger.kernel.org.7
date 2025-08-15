Return-Path: <linux-kernel+bounces-770694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C22B27DE4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E85F417EFA0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0502FCC1F;
	Fri, 15 Aug 2025 10:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T6nStwk3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAFD2F998A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 10:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755252269; cv=none; b=FAhgbE3WR2Oel7pfgwKBrtkl2m9j0TP9RBF83IO7OMIGmL/Jns5IYtkbTimL4u+BqC36AtuFZXGcNnRMp82MvqW84DIJe6SeviMEpVvliuo6cf2Xwg3zogrQ6thunuEiDkQOSsa+gHoQv5r8qpqfMs+HIt1JzlR4Ia+DFRwywFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755252269; c=relaxed/simple;
	bh=I4oegnkbfcpHs/H9z0IPVadbUDUImw9xYjA1JUJPD64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJ3ZqH+0TlCf4QatVLEjRX40Fa8i70hwin6UY3oP/Wa0JM45cP0ppqvZmDsM40Ta7GSzlViWU6sJOrnN7efRTKTVxFbimsKTNRDkI7OUyMm/TbrCehqHgxfDuIcmCjqKGoR9P/N+khn+OIHER350s3TWANgyLdH/6FzG0uVCrzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T6nStwk3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755252266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QiZGjpRLBMxUiCkW55ef9RLnzwIzt+xk1Pnx/5kDTNI=;
	b=T6nStwk3vUFmO8u/lU1WbQutcoke4j8eGuMAaZpW9FzlE5FugCH4DOQh+U+Dy1i3T8IQIc
	b3cCELS3CHQyY3bLN74XjJrg1mST3y0hfODWeFONrrwQmXCCS4lvdvvSNCtXpSzdd8tY1v
	2NLT5zfA4jvdyzF2crDRP8dJ3muabnQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-N0bictWJOie5FRDtFKQ11g-1; Fri, 15 Aug 2025 06:04:25 -0400
X-MC-Unique: N0bictWJOie5FRDtFKQ11g-1
X-Mimecast-MFC-AGG-ID: N0bictWJOie5FRDtFKQ11g_1755252264
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b0cfbafso11114515e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 03:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755252264; x=1755857064;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QiZGjpRLBMxUiCkW55ef9RLnzwIzt+xk1Pnx/5kDTNI=;
        b=lH+69IQFOhcAqTZz0ExxCDX7Vt9lRgQ49Z79zQCQIsBHqs5IduNdkGcmBLX48mW1aO
         f6CdCXqaSY/tlqnlmrWDvM8euNdaqcQ+36lfIMpiXMxV0bvifcA9lmLhEuScAWm4Si1O
         RCPxVs6XF8x57A3NZ3EEwzQi3IqZ/OSOeW7RCggskl/eTHQCLaOy5RZlWdtkVnX4IZNm
         NiyCNShL9daV56EwmdioQigzQkmD58nfKuh7KtmDNcWkOx2qM05TpwYhsbmnSszNz8Zq
         LVrYiH14S0DrjpH3X/5ByYVXkfSPOtCZSsnz6dopTI7/OTeP046gWYKIihWF/4Okeg/7
         95Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWuJT2YJfmtubxyf+mq1hl/7nwhxh+X1wEzlpvIWa2EDZuC+CnowHQuSsfypkdauTiGz0lzHOl+3rtLj98=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ3zpG58UF0c32KMchXCHEVQklRXBVq2lWOd02Gu3fva+e0EUJ
	rhSaS1jDJTLZ4iZdBCqX3Wx6m7ItBJxQQ0RY1Myn0v1o2ma1G1cQwRtmEnkQ5Xw02m+wgJkbZVc
	MrzbbaPpRq5FAOO3WxUJ9ChIBInhbi0j9hEqqzMikXqAJxlo2Z1gyQtV7AmmSJ8j0bA==
X-Gm-Gg: ASbGnctvAY2sF8nGb43vYn4eJ6nAxvzf3FvUuHuh6aJWMJfixgsxBejmfz++UIJ5Led
	qc/nOm0Qtey1ZtSUgtrfiWiCVdGLs+WBLN/sgpSvZtitFkWVhsRWLOwFmBJyIxJN4jl7til2s56
	lD7+6YS2fhZlFLLn+A8DilMe7aAgR770HmV0/jrveiaH/LT5JL2ftaEuzrz+aI4vg9D2u9UqGei
	TQq/SIxsd1dvj1jc6evsPn0NhqjrAIchDdrmakj9IwXyPTYeBWcC2Z1j0DAlIJFjJdwC1ybO8SP
	Dqtn1JZhDtRbUQ3VuopC2dt/R0NgtDGfsOY=
X-Received: by 2002:a05:600c:3b09:b0:459:d408:d890 with SMTP id 5b1f17b1804b1-45a218646damr10823555e9.33.1755252263920;
        Fri, 15 Aug 2025 03:04:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoYj18UC8X1yoShsQNdmiBKvxfPbz7hgJI6IRwBN4v3CHMkvtV96lAG5uOXuRIZ6XgJoKFgQ==
X-Received: by 2002:a05:600c:3b09:b0:459:d408:d890 with SMTP id 5b1f17b1804b1-45a218646damr10823355e9.33.1755252263447;
        Fri, 15 Aug 2025 03:04:23 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73cf:b700:6c5c:d9e7:553f:9f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a22328b5fsm13094175e9.20.2025.08.15.03.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 03:04:22 -0700 (PDT)
Date: Fri, 15 Aug 2025 06:04:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	hch@infradead.org
Subject: Re: [PATCH V5 4/9] virtio: introduce vring_mapping_token
Message-ID: <20250815060320-mutt-send-email-mst@kernel.org>
References: <20250813054831.25865-1-jasowang@redhat.com>
 <20250813054831.25865-5-jasowang@redhat.com>
 <20250813043151-mutt-send-email-mst@kernel.org>
 <CACGkMEuKmn4f9spFT1YxjVPxBFkdGVCTQEUpNG=xHd6hcL-a8w@mail.gmail.com>
 <20250814063927-mutt-send-email-mst@kernel.org>
 <CACGkMEuOnDavQNw2113TWY-cziSpHWxLnL1isNTf9HcW+kmFBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuOnDavQNw2113TWY-cziSpHWxLnL1isNTf9HcW+kmFBQ@mail.gmail.com>

On Fri, Aug 15, 2025 at 09:02:09AM +0800, Jason Wang wrote:
> On Thu, Aug 14, 2025 at 6:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Aug 14, 2025 at 11:36:22AM +0800, Jason Wang wrote:
> > > > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > > > index addbc209275a..37029df94aaf 100644
> > > > > --- a/include/linux/virtio.h
> > > > > +++ b/include/linux/virtio.h
> > > > > @@ -40,6 +40,13 @@ struct virtqueue {
> > > > >       void *priv;
> > > > >  };
> > > > >
> > > > > +union vring_mapping_token {
> > > > > +     /* Device that performs DMA */
> > > > > +     struct device *dma_dev;
> > > > > +     /* Transport specific token used for doing map */
> > > > > +     void *opaque;
> > > >
> > > > Please just declare whatever structure you want it to be.
> > >
> > > It's an opaque one and so
> > >
> > > 1) the virtio core knows nothing about that because it could be
> > > transport or device specific
> > > 2) no assumption of the type and usage, it just receive it from the
> > > transport and pass it back when doing the mapping
> > >
> > > It should work like page->private etc.
> > >
> > > Does this make sense?
> > >
> > > Thanks
> >
> > I fully expect most devices simply to use DMA here and no weird
> > tricks. vduse is the weird one, but I don't see us making it
> > grow much beyond that.
> >
> > So I think for now we can just make it vduse_iova_domain *.
> 
> It requires exporting VDUSE's internal data structure to the virtio
> layer which is a kind of layer violation.

It's just a forward declaration. You do not need the structure.

> And the iova domain will be
> soon replaced by virtqueue group in Eungeio's series that support
> multiple address spaces
> 
> > If we see
> > it's getting out of hand with too many types, we can think of solutions.
> 
> Considering we've already at it, I think it's better to have a
> solution now if it's not complicated:
> 
> I can think of two kind of solutions:
> 
> 1) Stick to the current void * pointer which is simple and straightforward
> 2) Eugenio's suggestion of having a virtio_map_head and let the
> transport/device get the container struct which is the real token.
> 
> E.g
> 
> struct vduse_iova_domain {
>       struct virtio_map_head map;
>       ......
> };
> 
> If you don't like void *, can we go fo 2)?
> 
> Thanks
> 
> 
> >
> > --
> > MST
> >


