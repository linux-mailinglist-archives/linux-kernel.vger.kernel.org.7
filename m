Return-Path: <linux-kernel+bounces-738296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE07B0B6DE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 18:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5CC3BDB6F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 16:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3997621E08B;
	Sun, 20 Jul 2025 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JnDhFWoF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802DF1A08A3
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 16:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753028003; cv=none; b=DEkz2Br9mgWImFfTrzpQo5C7SlEtvgOhArwfOU7wv21qpzXT03NE3izv6NQ3vF9dzgqTMs2bxlMI2Z1CRn7tuczEEeDy4KOKqd08ghNXBPUwOu57QhBy8+OxWFM97PGI+TX65193oZkKnf73j602VdJ8mwO4781QxCydSUcsPvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753028003; c=relaxed/simple;
	bh=waHBK/dHOhY61lgCppPc1hC3CKS8KkMfCExvaN3qBfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGDRB5gqpLWdT4YqKZIYHYY4dIsPP7t+tXsw/zPuwrjgwU3iTsRL7O3ZSGTM4Q0VEqSwNXXWwFS53O/09Rr7slmAe5Vgh8sjmQdWksoQxQ+6VL6SPzaVcpH+duNZZJg3g/NEboxZKYAmQmRIF1THZZBXc/G/g8JVyExXuwtTY9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JnDhFWoF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753028000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Jj3apqxe+kr9fcNoPVcjrR+Gq4Oua7cDA/qKij4XC8=;
	b=JnDhFWoFpB1LQgegSDbzQB4oQThem0qd6xOU3ROiKfJBaXd/7t2IWvJbU5DVr064cDbatg
	DjPCHyHSjzrSn/hUAWChnI7Ejk7WAZIR9oPx3+w13qI/s+Cig71k41a8fgoSe7gPTB/sb7
	QBZ6a8qNb90XvDPUyKIm+2LSOhPUNHE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-Wj-rO7QhPvGhAGVFAGWiNQ-1; Sun, 20 Jul 2025 12:13:18 -0400
X-MC-Unique: Wj-rO7QhPvGhAGVFAGWiNQ-1
X-Mimecast-MFC-AGG-ID: Wj-rO7QhPvGhAGVFAGWiNQ_1753027998
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6fd0a3f15daso134069916d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 09:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753027998; x=1753632798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Jj3apqxe+kr9fcNoPVcjrR+Gq4Oua7cDA/qKij4XC8=;
        b=Yo6Mam7uTfpQ/kuKr1EVZN1TeIbGIDpck1XPnprLll5c/Rwi97k3dZLjAlFYEYYNYi
         YcNQChJqMVgMvLDkl5RBGCD49acaFZ3QPuFs+AM8RCRTG06qrrsscZ+SG7wwFublLXDL
         vdmUv5LbrXmKSuVtLdzvC7lcI7fwuf7lubznxTBvrI4CY2HKRKMzHQ7MogKsXjDgP5t+
         n10mkmUCanj0J/vv0yesUiSSfCk5JfcaFKpTQ9Qf/fqmg5KdfIdC2Fv4wDaD/JWAVnlb
         X6QOPpIDohJDRCBufrZJIrCl7emGXV//Aqya3WSXu8/B0GPezUT+XtnAMHneSh4HpfnK
         0XMA==
X-Forwarded-Encrypted: i=1; AJvYcCUtB7gjqiwxTMOkOonCcczVKusRcntgBWBo/ho1OqxVmusN/foQUqJo9Je/LvSwfWuxICVr2+WF8fDte6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj9300znKeA1G7FSUv7FdaaUzQEHuWYUmeXRKkMlMLK6Rz8qNa
	V4wL8P+7FRy+Gm02p2Vnxati7dDexeujx/8EJz76pYPPjByTinUSctjjLlmjKRwBAzFxecUnX1J
	QsBdYhAmUkZERK5fj0z+/tCj5ZcsuI/Ti1UhhXEUVyWtPjh6+2iQcnrYRU87nNmpgcw==
X-Gm-Gg: ASbGnctK/6Dv3eyzVt1ym3SAIwuhAyyAXEm/M2VQhmP4OlLGmVNNmnoE/ccf4GC97ME
	SzT5M5Xw8QRRTidNRuF7s2O+KpdtWWSk1gVPz0/2J9P4072T0PcAaIeWKf16qxTnMPrVFZa3XDO
	vDg1SMVWM/8RebytB3e/MPJB2LSCAcWWG2FCevKIAhlBvXrnGLlLgObfiOLdJIQk/Dk7n5hLVsf
	5mjmgd1nolptzij+uvj6T1CaRQ4W7R8K4HxUJOB4OZhgreN8GnAkjN/WkLGJeQd7vRqRWI3al/T
	Te58a6DLOp3zeobbmZ9h1F3IJh0QU38=
X-Received: by 2002:a05:6214:5195:b0:704:7dbd:5d90 with SMTP id 6a1803df08f44-70519fc9cf4mr124408986d6.9.1753027998171;
        Sun, 20 Jul 2025 09:13:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6LiE8pkS62bIaBTVjt45PmxaYTrc0y1TsJte7EO3rbVHjyeTl3+MgHQg0Hafie3fbwQjvdw==
X-Received: by 2002:a05:6214:5195:b0:704:7dbd:5d90 with SMTP id 6a1803df08f44-70519fc9cf4mr124408646d6.9.1753027997715;
        Sun, 20 Jul 2025 09:13:17 -0700 (PDT)
Received: from redhat.com ([185.187.243.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051b90616asm29643326d6.35.2025.07.20.09.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 09:13:17 -0700 (PDT)
Date: Sun, 20 Jul 2025 12:13:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Nikolay Kuratov <kniv@yandex-team.ru>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Eugenio Perez <eperezma@redhat.com>, Lei Yang <leiyang@redhat.com>,
	Andrey Ryabinin <arbn@yandex-team.com>,
	Andrey Smetanin <asmetanin@yandex-team.ru>
Subject: Re: [PATCH v2] vhost/net: Replace wait_queue with completion in
 ubufs reference
Message-ID: <20250720121256-mutt-send-email-mst@kernel.org>
References: <20250718110355.1550454-1-kniv@yandex-team.ru>
 <20250718230356.2459-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718230356.2459-1-hdanton@sina.com>

On Sat, Jul 19, 2025 at 07:03:23AM +0800, Hillf Danton wrote:
> On Fri, 18 Jul 2025 14:03:55 +0300 Nikolay Kuratov wrote:
> > When operating on struct vhost_net_ubuf_ref, the following execution
> > sequence is theoretically possible:
> > CPU0 is finalizing DMA operation                   CPU1 is doing VHOST_NET_SET_BACKEND
> >                              // &ubufs->refcount == 2
> > vhost_net_ubuf_put()                               vhost_net_ubuf_put_wait_and_free(oldubufs)
> >                                                      vhost_net_ubuf_put_and_wait()
> >                                                        vhost_net_ubuf_put()
> >                                                          int r = atomic_sub_return(1, &ubufs->refcount);
> >                                                          // r = 1
> > int r = atomic_sub_return(1, &ubufs->refcount);
> > // r = 0
> >                                                       wait_event(ubufs->wait, !atomic_read(&ubufs->refcount));
> >                                                       // no wait occurs here because condition is already true
> >                                                     kfree(ubufs);
> > if (unlikely(!r))
> >   wake_up(&ubufs->wait);  // use-after-free
> > 
> > This leads to use-after-free on ubufs access. This happens because CPU1
> > skips waiting for wake_up() when refcount is already zero.
> > 
> > To prevent that use a completion instead of wait_queue as the ubufs
> > notification mechanism. wait_for_completion() guarantees that there will
> > be complete() call prior to its return.
> > 
> Alternatively rcu helps.
> 
> --- x/drivers/vhost/net.c
> +++ y/drivers/vhost/net.c
> @@ -96,6 +96,7 @@ struct vhost_net_ubuf_ref {
>  	atomic_t refcount;
>  	wait_queue_head_t wait;
>  	struct vhost_virtqueue *vq;
> +	struct rcu_head rcu;
>  };
>  
>  #define VHOST_NET_BATCH 64
> @@ -247,9 +248,13 @@ vhost_net_ubuf_alloc(struct vhost_virtqu
>  
>  static int vhost_net_ubuf_put(struct vhost_net_ubuf_ref *ubufs)
>  {
> -	int r = atomic_sub_return(1, &ubufs->refcount);
> +	int r;
> +
> +	rcu_read_lock();
> +	r = atomic_sub_return(1, &ubufs->refcount);
>  	if (unlikely(!r))
>  		wake_up(&ubufs->wait);
> +	rcu_read_unlock();
>  	return r;
>  }
>  
> @@ -262,7 +267,7 @@ static void vhost_net_ubuf_put_and_wait(
>  static void vhost_net_ubuf_put_wait_and_free(struct vhost_net_ubuf_ref *ubufs)
>  {
>  	vhost_net_ubuf_put_and_wait(ubufs);
> -	kfree(ubufs);
> +	kfree_rcu(ubufs, rcu);
>  }
>  
>  static void vhost_net_clear_ubuf_info(struct vhost_net *n)

I like that.

-- 
MST


