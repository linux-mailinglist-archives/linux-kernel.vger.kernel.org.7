Return-Path: <linux-kernel+bounces-865021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3335ABFC098
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5039563140
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAAA34B41E;
	Wed, 22 Oct 2025 12:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ehg0E8IK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A1E34B185
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137761; cv=none; b=txhxFBfP/x01/Xc1ULnAxPZTzH8NJuOXQQMdflOi8bCVjI6NJ/mSaevVgzP/BFQ585Bs3DFbov492Ju8n3nU2SvHL1Vc5JAgYyaW2TR1U7AdoJaU3kv6It64GhSd7aVpGbMxA6aFJ4Fk9LvJ/h2uwnQAQNStxWwahnYXccYhyYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137761; c=relaxed/simple;
	bh=agmGfZLcCAQsl7JXQisFrg8u4h/rd1PShHvnrkyj1c8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1jz9U70M7xswNElUgc6xcDSjMUrV9G9P3DNOYSoObPJtvg1/nqUeQjgRRAPNHDhdI5zgz2bXllYPTl56vpgFy04uG6cGXaU53SHN4Pk5nRs9W5iq8q3snUmAkFaM7EJfxo4N6tZDjonQcKay9IHZT07Vm65O/HyOV2ptfwFoCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ehg0E8IK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761137758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=agmGfZLcCAQsl7JXQisFrg8u4h/rd1PShHvnrkyj1c8=;
	b=Ehg0E8IKO0x3aLhrhCdM+ycYDJWDmX7lxuN0urw4YxJkelK4HiSyCJ74cAg/XMJWvXO8WJ
	xby/cS9+yu8jmRccke6tBh0Ih1BZpLUTi297fh/9mtA/M6LO7YrWjYkJZmSXjpE1SHcwM8
	lvEyCDqV/OnUW6DhhxSzmpasqxfVx/E=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-OY3xfbDgOH-C_vRvEYqN-g-1; Wed, 22 Oct 2025 08:55:57 -0400
X-MC-Unique: OY3xfbDgOH-C_vRvEYqN-g-1
X-Mimecast-MFC-AGG-ID: OY3xfbDgOH-C_vRvEYqN-g_1761137756
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-63e24653538so6038148d50.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761137755; x=1761742555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=agmGfZLcCAQsl7JXQisFrg8u4h/rd1PShHvnrkyj1c8=;
        b=SXuBpkhso4L7AQPAf0aSIDps2/mUzNEVQvj006t8n2K3FTZrWa+hqjUi+bPu72C+BP
         FSNBdtyS280a3hrkuHP2/SSdAh5/9L12AB6ye6Uef+kIfshGDqzKsF8VJXLCrKg6bWC6
         wKzKM7X0QAzZsiMkejFHBWxAYtJdfKepx6NxN4qsHJ+OhXnnEroATxR7jhg0QQyj04G1
         OEP8PLoRig/XMpbanaB51ZqEJtkr+0IGMAnCcuw9VO9ZkGclRqqH/9TAtqP/NIVbN38s
         ufYLWTbJ3jTXpBlb3AXP0JBeNO54SmS9G35fNfU8OdQ0etP3qeNgpTttw3vFVHYYvpBP
         gEvg==
X-Forwarded-Encrypted: i=1; AJvYcCU5ccAC431ajlzvrpUkntVtFS9vZLM71A2/jc41jkKjz2SGUofSSuxAX+YzuXk6XuwBQ0kJF1Kre7cpuFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl2KsSwjO9tfjyxfE01AlCTE6xIsbrowGuuceOMBqC9UtDtI9+
	7CKqNsj5xoMp9dX376Fh4ddRuZjmRW+LAMTb6WbTGvtoGiCIHzrEO5CV0HWnXo7jCudZgik1eIp
	6tWb+0v4xnmvjJhrqMRPBVPPa6VMRcd3KI3t783kLQ5tGwxEv2EPkCLyQUlD8JDIu3t1IREjNHd
	ZaeWal5OK4Kev+49al/MC6xL+6vDMGjp+qYRJwOLtan/tlWsl8
X-Gm-Gg: ASbGnctGR+/OnDxDv5YCKXtS1GW7GzIbDuvms84DKrzqp27sASqILwWpng8xyKga9HR
	SXrMDyQoF5JombgtXmgkajaxCtcwLR8cGc5bQV9wBQPHxiNP9YS6sstMY+1ylNwEkbFFkP+2dgZ
	GQpYFNKzKvbuL5PtpGzXF43F9HnLczInGlhiWL3jvr9ClQAmT9c3eBuPHPNX5CnOvT8bU2XO3Qb
	RHYvNOV1GQewaSNrCX8S1tDYkanozaeYSh8Dx5JHOyIsOc6L1J2FtKc50n3WqNWwXQZA/nIZAqy
	D90=
X-Received: by 2002:a05:690e:1598:10b0:63d:bfd0:5031 with SMTP id 956f58d0204a3-63e16191e4amr13783816d50.39.1761137755399;
        Wed, 22 Oct 2025 05:55:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBThLL/CDEifOBjmgpwLAX6oowmGdmpckH0U0YYgejlBayo5T+YJPbfD4MrrYiIYTzwBSSG3y9DhXU8dQQH+M=
X-Received: by 2002:a05:690e:1598:10b0:63d:bfd0:5031 with SMTP id
 956f58d0204a3-63e16191e4amr13783801d50.39.1761137755003; Wed, 22 Oct 2025
 05:55:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJaqyWe-mn4e+1egNCH+R1x4R7DB6U1SZ-mRAXYPTtA27hKCVA@mail.gmail.com>
 <20251015023020-mutt-send-email-mst@kernel.org> <CAJaqyWeiX1Tc77NcYoBbeVfKTeuKHK6hw=n_9Mk4y52k7Djr-g@mail.gmail.com>
 <20251015030313-mutt-send-email-mst@kernel.org> <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
 <20251015040722-mutt-send-email-mst@kernel.org> <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
 <20251022060748-mutt-send-email-mst@kernel.org> <CAJaqyWdRN3C1nOHQjWroBPWKjc5efNfVbecpruL=Cgsk6i1FXg@mail.gmail.com>
 <20251022073231-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251022073231-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 22 Oct 2025 14:55:18 +0200
X-Gm-Features: AS18NWAUH_f342K_ZMx6R3lW2cujGDSAHLzCd_wu_8uGgqhEaiKKLDFfVlyNY4Y
Message-ID: <CAJaqyWeDcyKKOvVdqUkpTuH3d-Tb9rBHG3ym+LC0fcmhrN_FJA@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 1:43=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Oct 22, 2025 at 12:50:53PM +0200, Eugenio Perez Martin wrote:
> > Let me switch to MQ as I think it illustrates the point better.
> >
> > IIUC the workflow:
> > a) virtio-net sends MQ_VQ_PAIRS_SET 2 to the device
> > b) VDUSE CVQ sends ok to the virtio-net driver
> > c) VDUSE CVQ sends the command to the VDUSE device
> > d) Now the virtio-net driver sends virtio-net sends MQ_VQ_PAIRS_SET 1
> > e) VDUSE CVQ sends ok to the virtio-net driver
> >
> > The device didn't process the MQ_VQ_PAIRS_SET 1 command at this point,
> > so it potentially uses the second rx queue. But, by the standard:
> >
> > The device MUST NOT queue packets on receive queues greater than
> > virtqueue_pairs once it has placed the VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET
> > command in a used buffer.
> >
> > So the driver does not expect rx buffers on that queue at all. From
> > the driver's POV, the device is invalid, and it could mark it as
> > broken.
>
> ok intresting. Note that if userspace processes vqs it should process
> cvq too. I don't know what to do in this case yet, I'm going on
> vacation, let me ponder this a bit.
>

Sure.

>
> > And, what's worse, how to handle it if the device now replies with
> > VIRTIO_NET_ERR to the VDUSE CVQ?
>
> this part does not bother me much. break it, probably.
>

To "successfully break it" we should implement NEED_RESET, or would it
work to just stop forwarding messages?

> > > > If we wait for the device to reply, we're in the
> > > > same situation regarding the RTNL.
> > > >
> > > > Now we receive a new state (A, B, E). We haven't sent the (A, B, D)=
,
> > > > so it is good to just replace the (A, B, D) with that. and send it
> > > > when (A, B, C) is completed with either success or failure.
> > > >
> > > > 2) VQ_PAIRS_SET
> > > >
> > > > The driver starts with 1 vq pair. Now the driver sets 3 vq pairs, a=
nd
> > > > the VDUSE CVQ forwards the command. The driver still thinks that it=
 is
> > > > using 1 vq pair. I can store that the driver request was 3, and it =
is
> > > > still in-flight. Now the timeout occurs, so the VDUSE device return=
s
> > > > fail to the driver, and the driver frees the vq regions etc. After
> > > > that, the device now replies OK. The memory that was sent as the ne=
w
> > > > vqs avail ring and descriptor ring now contains garbage, and it cou=
ld
> > > > happen that the device start overriding unrelated memory.
> > > >
> > > > Not even VQ_RESET protects against it as there is still a window
> > > > between the CMD set and the VQ reset.
> > >
> > > Timeouts should be up to userspace. If userspace times out
> > > and then gets confused, kernel is not to blame.
> > >
> > >
> >
> > I meant the virtio-net driver will be confused.
>


