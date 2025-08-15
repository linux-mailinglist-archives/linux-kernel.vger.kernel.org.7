Return-Path: <linux-kernel+bounces-769858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA4BB27480
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7993A5E43E1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 01:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148BE1F9EC0;
	Fri, 15 Aug 2025 01:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i32OIvEk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7472E23CE
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755219752; cv=none; b=J98lzVZmqUGIQ5gzhc53bA5SiNUDJFfaK3QCjGsg/rjtYPgCcNzttiBhwAcFQrYXgIl2R2ZCwVpCwkghsN+wrnSyJ++/3DHqmsTAgjIMZV9QuT1LzAfNuk234M7Q9IkhARHWeLydYEicNFgQOb3VJyto9QAwleCLhUl7NmFyPAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755219752; c=relaxed/simple;
	bh=KNK3zkzlYeQURhbykPL7rMXuHpVvC/2reo8CVxG8SEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gx4ciwnh63UEf3Y1/ilVJStrj8qQU4wpi7bd+X6ZqhdMontypwwdLB9uAT5AuJPQE1H1zdoJ/3xmQM+ndZ05Dh7dOOeSMV9W+LODL8bp1j/5VPg1bVbtPcnNG987IXoJTYwRsPFgiQ5IXr6GB/GrNzOTWflcRpMPFlt2eWatUg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i32OIvEk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755219749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=REs1hd81lcpd2RRYo/GLQMvx3INCy7uWiXpRXUWQwtA=;
	b=i32OIvEk4uL4qq+KXZ5Z4Lv9YvZjDh6FVe5DJ02zFz8gGKNZ05+PTTtR0E/L5dkl3OcBK0
	Sq08oJwshZX4N0MLGKYT7/1vxhhaRomUegFhpx0xHRKD60qyGr6n47aWy6m5WHI212IPq6
	6REO3ypbrHAjgK2imjrFI85J5dXx6eM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-8i2g50LpN-6kyT8Syv4KXQ-1; Thu, 14 Aug 2025 21:02:22 -0400
X-MC-Unique: 8i2g50LpN-6kyT8Syv4KXQ-1
X-Mimecast-MFC-AGG-ID: 8i2g50LpN-6kyT8Syv4KXQ_1755219742
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32326789e09so2830575a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 18:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755219741; x=1755824541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=REs1hd81lcpd2RRYo/GLQMvx3INCy7uWiXpRXUWQwtA=;
        b=RPBNAHkQ055BdG54Rf5U3KmSUvvfO3Wnux6XltRHcK3QIT31K8Xp2wkD5T1/kZvjQF
         0f+EcXYsUN/8CcVup3uJKGqG7WKJM2DcLKIvZttzwC8zgZoyc3XD7etUm8PHP4bWXnDE
         J+TczuGV2yBhkFADUSKnBTGDcyuMvd4CrRlY2F/2PPraTOLbA1J7e61MdHdzN1w3jU2j
         U4VkEk6j3UmfoRF9Q+Lre0SaLjYiia4RqQn8HSYusWGtZg54WF6NsEfhYrEQUPoXyUeL
         xj/KWxDZheMshQNaBOJgpm/QDQHqdKMldYxmtOktnVZBhm/0/TDgUTtJVlE34/s2TZVS
         VsBA==
X-Forwarded-Encrypted: i=1; AJvYcCVc8FgenZLWwWalXL/AZSISnfJsM+mHinlO+up6qOv+Kpung2EZqJWL1IKyNDBDgzDltkSoGOx7Z3tSEVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZbt1tqnvvcwMOKpeg7eYE/bPRsV5XD4jzNs84ddXakxLhcX3T
	T10AGaandPV++XKrXFeOeLkVu/7wseB9W1crHrkbYW7+Z7Kwq+PxoA3w/EW8GU0L4aB+JEIZ70J
	NQf2lEsL39Qfol5cBkgC5NWF9hQ/N8e2tY7Sw6/QLeJIV4Qx2oEQgF3jaw3QlM1ZEC/zMqrSK+i
	Gk7cZZB+JG4g+snGjDXHbLBgkCEliwu43tenjfbjnj
X-Gm-Gg: ASbGncsa9QO0nKCcRcZ5Y76KyMZ1wE6Cy12strMkm01lXBz/vNMe4mKdchcjUxMUOvA
	1OVFjEdOwSkbdOmsuXeXGEHtPCm9VGQP9TvgZK7l76q7pOBawToWeHGRsjr44upmyp0JE9pYji/
	FtBawE9mMjIblxPWvmUuXc7Q==
X-Received: by 2002:a17:90b:50cc:b0:311:da03:3437 with SMTP id 98e67ed59e1d1-323421557f4mr421457a91.27.1755219741468;
        Thu, 14 Aug 2025 18:02:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnmvdLeEbq4CYattZMZKLRfd79cqwxtEizDRLbN8w9zteHxjjUj9ZgT3lfmEOMLCb2WfO3WZLlN5vBjVVGYc8=
X-Received: by 2002:a17:90b:50cc:b0:311:da03:3437 with SMTP id
 98e67ed59e1d1-323421557f4mr421403a91.27.1755219740995; Thu, 14 Aug 2025
 18:02:20 -0700 (PDT)
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
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 15 Aug 2025 09:02:09 +0800
X-Gm-Features: Ac12FXxg3jkxZdNEzAcMz4isY4tTKK8O9XaTLPy8ZJOqQd7gBqWZn3-5oI92tcA
Message-ID: <CACGkMEuOnDavQNw2113TWY-cziSpHWxLnL1isNTf9HcW+kmFBQ@mail.gmail.com>
Subject: Re: [PATCH V5 4/9] virtio: introduce vring_mapping_token
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 6:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
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
> So I think for now we can just make it vduse_iova_domain *.

It requires exporting VDUSE's internal data structure to the virtio
layer which is a kind of layer violation. And the iova domain will be
soon replaced by virtqueue group in Eungeio's series that support
multiple address spaces

> If we see
> it's getting out of hand with too many types, we can think of solutions.

Considering we've already at it, I think it's better to have a
solution now if it's not complicated:

I can think of two kind of solutions:

1) Stick to the current void * pointer which is simple and straightforward
2) Eugenio's suggestion of having a virtio_map_head and let the
transport/device get the container struct which is the real token.

E.g

struct vduse_iova_domain {
      struct virtio_map_head map;
      ......
};

If you don't like void *, can we go fo 2)?

Thanks


>
> --
> MST
>


