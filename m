Return-Path: <linux-kernel+bounces-739497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE9AB0C6F2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D874E0224
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5D318DB2A;
	Mon, 21 Jul 2025 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hoWwoByC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A9D28A40D
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753109589; cv=none; b=pIGr6/WuKFLUDd/xqKetPJseSQjolg4nn3AP+WzR6MWoZcorQ1X+QXq6vy2GaKgDHTcAFiKYSjVJS2URLh9tukpPzOL+X1xdJl0erNF0+htp+LiXki2X1/ePLqjVkSBjXJhJ6LWbei6BoIvGqXuVRYcsAsHiQgaDYvxujLCoacQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753109589; c=relaxed/simple;
	bh=tcfwFJ4EktzzgXpSdU1DvdV/q0S1GXlOhJS5PeJEXl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLZ8nvcO1lWAwXNehOZzHSbaMi7cl3jrJtncJtrleS0D6kSVJVC9sFnxDO3mc8Z9UPDtVqkmTfrorf7cSxnudJFyZRaK+IQ66+4YHh8UaEoscuke44FTkCo3mX8eKRD0MXmSsG4cJ0PeRcOOwQv+f/iBNR0vSS4be+mrTxBExXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hoWwoByC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753109586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hKl0qlxBFtF+elpbFDCnFWXhN5Owf8cmvWXhHgmzstM=;
	b=hoWwoByCdaSrmTAzyGrdRtjc20LDyTM9GpAVLyNeM9V03nPDx1iuxGEM/cp3kYGHEQ1etD
	7FR8wSapPuoD9n2S12FUtgH6afOS+5XeU5mJQKnZ5efio4i6EWygaunRI4OoGGZw+R57CF
	/qi08/w7WXndJxb/EWdjOm0qC8+aSLo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-i434-naFPGGQwzGc_nuDjA-1; Mon, 21 Jul 2025 10:53:05 -0400
X-MC-Unique: i434-naFPGGQwzGc_nuDjA-1
X-Mimecast-MFC-AGG-ID: i434-naFPGGQwzGc_nuDjA_1753109584
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ae70ebad856so357109566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 07:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753109584; x=1753714384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKl0qlxBFtF+elpbFDCnFWXhN5Owf8cmvWXhHgmzstM=;
        b=Ps3KTbElZ3q+wfreiP/oXETAruwGw/g22N/zRWFoJRXuLUVg7jStAIB6yWS61fQuhw
         vHc7p6aTr0fFCKomepkP1vLz/zHjaLVADje4jDnXLhBdb11vSAlUeLUtFLwZn54gOkyK
         cbzGD7fUQa5p8vLCB0UAgeOxevb0FoecYHeQ0hc5F93hGOXJlIYiA7x1nyTg60q/qTzt
         S6dYgONj1nvTNQiOM9JpMggO8vdbwIcx1wHgxNmxFLJ+0znjaeH5KoarncUZMK7xc76z
         TA4gl6cE2BfWSS8ahVMgt+y9hQ1y+vb9Ld80NRAzkKJ8tKzVJwpJNo4jOHWORSqrtuVJ
         fxiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNAOR1BxGlDpvM4nf9eK9jHlLN5wF/j48j+6LYPBF35qhXXmH5MNMcClVi0tXdKG+KVGxEXzP0XrY0OxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEUE0Cv/46s/z0vEHPD8xbEzHqBU0zrnzlHKVKzQnqYfE4TW17
	SNedRRePj+WxP7ErZHN7CNNOo7IquMJNiZRROfKt8lkVV/7u+F+r6u6kS+5pv+Qi5qZVhbwrcu2
	sEXQAac7LHgRq1dN8NwhEyUe/TNyQx/qAvoHq2RXeju8oeU9/w5bsQO33szx/tKpkvhGH+fTLUL
	1Xik8sC+Q5HxxThP5/TXYAh0qSRHjW/fxJZo8U5vQj
X-Gm-Gg: ASbGncuIzJJqjNnGurJan/dG1nbjpIO4jB3GqsL4byUxOAr+sSLKgjLyYlEeknJh1vO
	nZTbJyJ9ad5WOTtbcnn3JWKKqjNDptVkxE9IfPpf5iRQj/pljkO9kVLl4qM7rslsZrIyshG4m2C
	Ykb0YxE4N4NPvr7uGE0BsL
X-Received: by 2002:a17:907:1b83:b0:ae7:1c2b:b715 with SMTP id a640c23a62f3a-ae9ce1116efmr1421066666b.49.1753109583661;
        Mon, 21 Jul 2025 07:53:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOOJUafiFo7E/wyrY3scKMXKkSfYzzMl3NxuY0FmLUADkytL9Dvho2Sh2vvfmv9jTzKOz9fVCpgCvesbMjmzI=
X-Received: by 2002:a17:907:1b83:b0:ae7:1c2b:b715 with SMTP id
 a640c23a62f3a-ae9ce1116efmr1421065066b.49.1753109583268; Mon, 21 Jul 2025
 07:53:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718110355.1550454-1-kniv@yandex-team.ru> <20250718230356.2459-1-hdanton@sina.com>
 <20250720121256-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250720121256-mutt-send-email-mst@kernel.org>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 21 Jul 2025 22:52:25 +0800
X-Gm-Features: Ac12FXxplqk-i8a6XMwuR5LTrYQ5xXpv4vZNeT7esH9BtgJxmgO_jrGFoDJGq4M
Message-ID: <CAPpAL=whwmwGqoxZ3M8y+fpnOXEHum+z9-Krs6ZOBLu4o8COZw@mail.gmail.com>
Subject: Re: [PATCH v2] vhost/net: Replace wait_queue with completion in ubufs reference
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio Perez <eperezma@redhat.com>, 
	Andrey Ryabinin <arbn@yandex-team.com>, Andrey Smetanin <asmetanin@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this patch's V2 with the virtio-net regression test, everything
works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Mon, Jul 21, 2025 at 12:13=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Sat, Jul 19, 2025 at 07:03:23AM +0800, Hillf Danton wrote:
> > On Fri, 18 Jul 2025 14:03:55 +0300 Nikolay Kuratov wrote:
> > > When operating on struct vhost_net_ubuf_ref, the following execution
> > > sequence is theoretically possible:
> > > CPU0 is finalizing DMA operation                   CPU1 is doing VHOS=
T_NET_SET_BACKEND
> > >                              // &ubufs->refcount =3D=3D 2
> > > vhost_net_ubuf_put()                               vhost_net_ubuf_put=
_wait_and_free(oldubufs)
> > >                                                      vhost_net_ubuf_p=
ut_and_wait()
> > >                                                        vhost_net_ubuf=
_put()
> > >                                                          int r =3D at=
omic_sub_return(1, &ubufs->refcount);
> > >                                                          // r =3D 1
> > > int r =3D atomic_sub_return(1, &ubufs->refcount);
> > > // r =3D 0
> > >                                                       wait_event(ubuf=
s->wait, !atomic_read(&ubufs->refcount));
> > >                                                       // no wait occu=
rs here because condition is already true
> > >                                                     kfree(ubufs);
> > > if (unlikely(!r))
> > >   wake_up(&ubufs->wait);  // use-after-free
> > >
> > > This leads to use-after-free on ubufs access. This happens because CP=
U1
> > > skips waiting for wake_up() when refcount is already zero.
> > >
> > > To prevent that use a completion instead of wait_queue as the ubufs
> > > notification mechanism. wait_for_completion() guarantees that there w=
ill
> > > be complete() call prior to its return.
> > >
> > Alternatively rcu helps.
> >
> > --- x/drivers/vhost/net.c
> > +++ y/drivers/vhost/net.c
> > @@ -96,6 +96,7 @@ struct vhost_net_ubuf_ref {
> >       atomic_t refcount;
> >       wait_queue_head_t wait;
> >       struct vhost_virtqueue *vq;
> > +     struct rcu_head rcu;
> >  };
> >
> >  #define VHOST_NET_BATCH 64
> > @@ -247,9 +248,13 @@ vhost_net_ubuf_alloc(struct vhost_virtqu
> >
> >  static int vhost_net_ubuf_put(struct vhost_net_ubuf_ref *ubufs)
> >  {
> > -     int r =3D atomic_sub_return(1, &ubufs->refcount);
> > +     int r;
> > +
> > +     rcu_read_lock();
> > +     r =3D atomic_sub_return(1, &ubufs->refcount);
> >       if (unlikely(!r))
> >               wake_up(&ubufs->wait);
> > +     rcu_read_unlock();
> >       return r;
> >  }
> >
> > @@ -262,7 +267,7 @@ static void vhost_net_ubuf_put_and_wait(
> >  static void vhost_net_ubuf_put_wait_and_free(struct vhost_net_ubuf_ref=
 *ubufs)
> >  {
> >       vhost_net_ubuf_put_and_wait(ubufs);
> > -     kfree(ubufs);
> > +     kfree_rcu(ubufs, rcu);
> >  }
> >
> >  static void vhost_net_clear_ubuf_info(struct vhost_net *n)
>
> I like that.
>
> --
> MST
>


