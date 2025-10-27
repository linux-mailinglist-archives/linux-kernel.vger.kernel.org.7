Return-Path: <linux-kernel+bounces-872187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6584FC0F7E3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA1854EEDD8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276A130EF88;
	Mon, 27 Oct 2025 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JKsmXe3f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB04230EF95
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761584241; cv=none; b=pnAdeoaeVvrirKCvcOj37PRVDXQ0klL+oNHl4zTtBzF24kd4yuA6j/IkPPaC8HX+qS6gNUS0kC0Ehnc+akizLdVW7hNYNWOEv0Qd/MPW93g8/rGL9TGwceZdk4uwLXUPSoHWlXHCYd2LA5QpFJ19VPoDLXkpOPXWkNY6lLJZjT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761584241; c=relaxed/simple;
	bh=O8RTvMejKOvUck1n4vId5oyUBgWmMFjgNqc1s+Fjnl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1ztWrpdmn7q+sVNYWNBiA9AW3OycwvJBgEJOSMBWp6cdLPG7cxgIucTnKIiNDEH5qCVmXzugWhE83WQcnYoBx2946PHRr/myycTa10NvC2EzCoqBho2J09NSFrU0sJ4zvtqtF9UImf9/nWtpJJTJIH5BiOVfBCXzK2Vfq/QaVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JKsmXe3f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761584238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c3kLM35CIDPHOyrsjILGoJJeoXY7IzP9N8um1gdjmbs=;
	b=JKsmXe3fH5rjB8PkUeVRLyeBlLVxd8/X97n49TPgu6kghsLYchm1fLIXTb5VB1VulxGLQT
	u3hbWPrX6UZWaPWtS3LEOX73m9cpmvZoCciplg1CcGeapQVYW9YFBfgMQDd+r6ddaJTvyk
	d7gJnY0Pak9VJFNeTXuQiLAI9CThLvw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-Pu4pyH1KMTKuYsAF8Wlf0A-1; Mon, 27 Oct 2025 12:57:17 -0400
X-MC-Unique: Pu4pyH1KMTKuYsAF8Wlf0A-1
X-Mimecast-MFC-AGG-ID: Pu4pyH1KMTKuYsAF8Wlf0A_1761584236
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-63bec04b8ebso4258013a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761584236; x=1762189036;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c3kLM35CIDPHOyrsjILGoJJeoXY7IzP9N8um1gdjmbs=;
        b=umB4bMzqRRwnp2pb+vHzlcZTLvACA0igjWHDB8cjxgotZYKs1i/R9OOZZMX0GDVIgf
         Awm4KCucmMjM9/jG8sSNwN5nqSUwlHPKtl5ccPCw+mnt/P8RDi53cyUMnD1938Yu5OY+
         WPJmMx3Zt8hCy/PoVT2dcF3xkQDw3S8MsJOuHxnqH8PqxR1reiIRj27GSDnc4g1RInC+
         5MpNk+Z5lm5nlryy1eAcX86QS9jn91enSX36AbYog+v1jjkrijJmJUJPgQ50uDD1GCuL
         imbSb2Pf6Oh/O7/2sg9MerQqS1PraG+JpONLJfaneHM/WIYhr1VM1NPJ8VPCLtg4bPSp
         RuCg==
X-Forwarded-Encrypted: i=1; AJvYcCWzeaM3U/FTxZjxB4nyhiiJc66VM52BDgqU7PnO/eAWflAtrMm4AgNhestKw00s2HCqis8jH1ySozx7ZEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ5Rwk5k4Now5hBLzU2dfeI8T7rWKDw7U78WLv0PNX+1h2Q7oV
	/jIp5E6GeLSiz8r8/Bra00zt9nPIb2GPs4ItU9Kz/hLlh30BQ8bLvicIxJjXihpy6ISqxyjbivZ
	74Ifa4gRPXoNRRvhhCjVGRhH9OxsGxSAX4BdS+EQJm4ck87Li2afxYq2zaCN67TX+CA==
X-Gm-Gg: ASbGncsZOCdcB932qanRZv9RJ2Uh1c5h6RBPapnMk7udkLcORj/fGHJNdkOHP0HEAjd
	OIGgw3jYKzBxp+85DFuFQ4YXvedgmtiV4rwjkyQjp4e4uqJBfw9itC0zHyt5oaWTNm99NoffuVz
	qgizjqnN/LFZuMa7iIULW6EXjRzABfYjq31ggb9VUz2X2z3pvTJhco82oF6dkGm+1P9rSzXkAyZ
	ydBE59W3XbxT9nG1u49rZEVl3fUOCZCSQxq37wNJSTHrszvM+WE5p1DUX/Yff1WjSbmpP2j8bGX
	BbmI4AokKRS0qNuc0LW5HmUH7MiDoVXjc5jsnbfNbCrxdY9T+78kySARhR8jvdoN
X-Received: by 2002:a05:6402:234d:b0:63e:2d46:cc5d with SMTP id 4fb4d7f45d1cf-63ed82668a2mr574339a12.7.1761584236079;
        Mon, 27 Oct 2025 09:57:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHazDZMNTIt14q/vEvfYcAyvhYxSk9xb4dxmlkKFJ2jGm6Zydzpl6NEPCj6GTS7o2yzgjqVjw==
X-Received: by 2002:a05:6402:234d:b0:63e:2d46:cc5d with SMTP id 4fb4d7f45d1cf-63ed82668a2mr574311a12.7.1761584235473;
        Mon, 27 Oct 2025 09:57:15 -0700 (PDT)
Received: from redhat.com ([31.187.78.209])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7efb97b3sm6731026a12.30.2025.10.27.09.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 09:57:14 -0700 (PDT)
Date: Mon, 27 Oct 2025 12:57:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, Maxime Coquelin <mcoqueli@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>
Subject: Re: [PATCH v7 1/7] vduse: make domain_lock an rwlock
Message-ID: <20251027125520-mutt-send-email-mst@kernel.org>
References: <20251010085827.116958-1-eperezma@redhat.com>
 <20251010085827.116958-2-eperezma@redhat.com>
 <20251010081923-mutt-send-email-mst@kernel.org>
 <CAJaqyWeeJVM6VeYp4HUEe0ZZAi26Jgqw8WaEg6POoGcUOkk6Qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWeeJVM6VeYp4HUEe0ZZAi26Jgqw8WaEg6POoGcUOkk6Qw@mail.gmail.com>

On Thu, Oct 23, 2025 at 10:59:01AM +0200, Eugenio Perez Martin wrote:
> On Fri, Oct 10, 2025 at 2:34 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> 
> ...
> 
> >
> >
> > > @@ -2045,11 +2046,11 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
> > >       if (ret)
> > >               return ret;
> > >
> > > -     mutex_lock(&dev->domain_lock);
> > > +     write_lock(&dev->domain_lock);
> > >       if (!dev->domain)
> > >               dev->domain = vduse_domain_create(VDUSE_IOVA_SIZE - 1,
> > >                                                 dev->bounce_size);
> > > -     mutex_unlock(&dev->domain_lock);
> > > +     write_unlock(&dev->domain_lock);
> > >       if (!dev->domain) {
> > >               put_device(&dev->vdev->vdpa.dev);
> > >               return -ENOMEM;
> >
> >
> > Let's look at this example:
> >
> > So now you are invoking this under an rw lock:
> >
> >
> >
> >
> > struct vduse_iova_domain *
> > vduse_domain_create(unsigned long iova_limit, size_t bounce_size)
> > {
> >         struct vduse_iova_domain *domain;
> >         struct file *file;
> >         struct vduse_bounce_map *map;
> >         unsigned long pfn, bounce_pfns;
> >         int ret;
> >
> >         bounce_pfns = PAGE_ALIGN(bounce_size) >> BOUNCE_MAP_SHIFT;
> >         if (iova_limit <= bounce_size)
> >                 return NULL;
> >
> >         domain = kzalloc(sizeof(*domain), GFP_KERNEL);
> >         if (!domain)
> >                 return NULL;
> >
> >
> > ...
> >
> >
> >
> > Which unless I am mistaken will produce a lockdep splat and deadlock.
> >
> 
> Can you expand on this? All that code works with and without lockdep.


GFP_KERNEL can sleep and if that happens and another thread runs and
will try to take the lock, it will spin forever.


> >
> > So it looks like the previous version did not compile
> > and this one looks DOA.  What's up?
> >
> 
> In case it is useful, I forgot to enable some vendor vdpa drivers of
> HW I don't have, and that was the reason why it didn't compile. But I
> didn't send it without testing it of course.
> 
> > At this stage please include information about configs you
> > tested, and how.
> >
> > And any locking changes should also be tested with lockdep enabled
> > please.
> >
> 
> This is the text I'm planning to include in the next series, please
> let me know if you want me to expand:
> 
> Tested by creating a VDUSE device OVS with and without MQ, and live
> migrating between two hosts back and forth while maintaining ping
> alive in all the stages. All tested with and without lockdep.


