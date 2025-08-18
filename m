Return-Path: <linux-kernel+bounces-773511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFC7B2A135
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAA9817B2DD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1149827E041;
	Mon, 18 Aug 2025 12:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OiRPyjEy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9839927B335
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755518588; cv=none; b=fN4jCWeGH0gMw0ybc9VHV1vE/Ub+Jr6ypBFNOf8bnkb8JAB7fKxu7FfY5hzkqPYnPEQu9aP0gAKKzTyoCtg4OdRejt59xTQOfvnZ2KmkEmk7GvY/WSqc2P6V7IgiqQkRAhEU4VzPDqqTlorFPYU9wT+1gk85iGtB2+q0JtFgKxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755518588; c=relaxed/simple;
	bh=aX0ppwvrxQtCilmjtLhlmGJxM/amdtR0qU3OoxYkR9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkoJPvIHous8Wna4hrgsbvhBslsDLxM94lHg20sg8xCbi4BOsZOgh3nlJoTvy2xwewsVFtrmkVzBaY2pruASHu5nDuTTuNMBbTcyLXmPzhzRUB8Bb/36QjJBn4sQdVxlRgDZHzl09QxSoIltvyL+V9DYoPAGnuL99PixoTY3UN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OiRPyjEy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755518584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oLE2lYRhrpJm9URBECoaPw5p007Ex98xqleh1QLEKQs=;
	b=OiRPyjEyzhSqhU5Jf9zbFEz53Pa6LVjUS0zCCgfeuvhu8iLxiGBL4LRCYbCgT1xjWzNOC/
	qw4SL7ChVQ9xUBuMGuExqB7yubcV70WL/XLi/pVh5eaVXwe3qOdc87iAX8G3dtRpbZTCTk
	yns+VLFi5mmGbGyU+kCIxmtbfdaIdek=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-se1eYFRPPVmrA01QMWfLUg-1; Mon, 18 Aug 2025 08:03:02 -0400
X-MC-Unique: se1eYFRPPVmrA01QMWfLUg-1
X-Mimecast-MFC-AGG-ID: se1eYFRPPVmrA01QMWfLUg_1755518581
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b9d41c1147so2766270f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 05:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755518581; x=1756123381;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oLE2lYRhrpJm9URBECoaPw5p007Ex98xqleh1QLEKQs=;
        b=bS4iMXhNtAZLJSwYY5nyFgfxw2sgsf3cL21vIvf0NJCIW+dCjDu7C9gRZ8xIJaLkE9
         mU6B9E1uCrtMkNnvp7rA8nVW6XX3jpdXs0JzCbAwgHXPeFHDohUyDLvzlmV//YsuNkeu
         J+8RSv+98wdu2go6aVJ7kkayGlbRVbVn+zQyJG5KepSr4bS36+5ADYbCNoCgLpYrdqJ3
         eMEqvH9/C3SsXegvMQpKeiZM9s6M+ZVrQn7d2Ccd2rquiCg7vAt/VI6q5XMvZ2Z2TCjE
         NpVdlc3eAVxHeR1mbwjmNyhvFNHvPlCxXMBYobNxPxniUi0oN6oHOb+h8XMLrktSaRUW
         Q/ow==
X-Forwarded-Encrypted: i=1; AJvYcCWDhhSbfAuXab7KikqXy1Ucre/TFw30uYrypfP788EV6vc1X2b/OUlqLlaYN50Nfqu9D5USXjPpgjpJWqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO1euBGth+zQ+NaIe91DlTrSg9SvXsYqEByThJM4rtdDbpMHBA
	IgUVJhqB0gmW96gSq+Lvy5R2mHmeAmr2S3lE/lrE/X8n5fBcxjTYlacCQQ6L1SJwDek+awghJYK
	Te55YyEUpV/H7JEvm9ORxXQW4fUcifCyz96tPSbfmSZcDiySxwzvxmgqTtOqRzXyPOA==
X-Gm-Gg: ASbGnct1IGmQwwrlQ7rav79QMyP1fJ1/fzKvW7q9zqgj1opQ9PmJz+UD9RBmbffulJq
	1x8DdmKylR9xOSCMF5XQfCf9dDbDk6EfCKB6tpSoollb7EknbBSexh6HGUmYlkbTZQTTrzibEIj
	gGgfRXQmhYw4n3cZSnrDdbbQHcjzygTXi/M1QFO5uBcuKgiKDs8L3SrZH48R6Ck+X6ARBLIM27x
	z+onbwI9g7P0K0ykHaG6MUaz+XKqiT0QtKJdPAwuGq/e1MeN4iD0XcklTMZFzzpweJsVFw9kwoh
	FrJ+P3H2QzJXqkxoTRfiZxprWCJR/MoK
X-Received: by 2002:a05:6000:1a8e:b0:3b8:d115:e6c7 with SMTP id ffacd0b85a97d-3bb68a167c4mr8471599f8f.33.1755518581071;
        Mon, 18 Aug 2025 05:03:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYzqZmffMklSj2Qi5PMXTUCEGdHYiVCyTvHGGQFSd6yY3SKyObBGhysM4csYFePqDKpPJBQw==
X-Received: by 2002:a05:6000:1a8e:b0:3b8:d115:e6c7 with SMTP id ffacd0b85a97d-3bb68a167c4mr8471575f8f.33.1755518580568;
        Mon, 18 Aug 2025 05:03:00 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb7f02578dsm12845133f8f.62.2025.08.18.05.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 05:02:59 -0700 (PDT)
Date: Mon, 18 Aug 2025 08:02:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	hch@infradead.org
Subject: Re: [PATCH V5 4/9] virtio: introduce vring_mapping_token
Message-ID: <20250818075749-mutt-send-email-mst@kernel.org>
References: <20250813054831.25865-1-jasowang@redhat.com>
 <20250813054831.25865-5-jasowang@redhat.com>
 <20250813043151-mutt-send-email-mst@kernel.org>
 <CACGkMEuKmn4f9spFT1YxjVPxBFkdGVCTQEUpNG=xHd6hcL-a8w@mail.gmail.com>
 <20250814063927-mutt-send-email-mst@kernel.org>
 <CAJaqyWcxV+f6dhKLscGGy0bw2YWJ8NaJ4QN+Qe3Ax7C+Lf4X-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWcxV+f6dhKLscGGy0bw2YWJ8NaJ4QN+Qe3Ax7C+Lf4X-g@mail.gmail.com>

On Mon, Aug 18, 2025 at 11:09:44AM +0200, Eugenio Perez Martin wrote:
> On Thu, Aug 14, 2025 at 12:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
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
> > So I think for now we can just make it vduse_iova_domain *. If we see
> > it's getting out of hand with too many types, we can think of solutions.
> >
> 
> I've sent my series of adding ASID to VDUSE, which uses this series'
> token on each vq group, on top of this version of the DMA rework.

But then I see it drops it from vduse_iova_domain. So it does not
look like they union is going to keep growing in an unmanageable way.

> This patch [1] and the next one are the one that reworks the token to
> an empty struct, so virtio can handle it in an opaque way and VDUSE
> can convert it back and forth in a type safe way, skipping the void *.
> Please let me know if you prefer to import a VDUSE header into the
> virtio config header or to make a VDUSE forward declaration instead of
> going through the empty struct to preserve layer boundaries.

Personally for now I'd be happier with just a forward declaration.
I just like seeing things at a glance: "it's a union, and
can be one of two types", is better for me than
"it can be anything grep the source to figure out what it is".
And a forward declaration is opaque by design.


> There is one usage I've not been able to convert though. Jason, could
> you take a look? It is marked as TODO in my series. I'm not sure if
> that's also an abuse of the void * in the DMA rework to be honest, but
> it should be easy to correct.
> 
> [1] https://lore.kernel.org/all/20250818085711.3461758-4-eperezma@redhat.com/T/#u


