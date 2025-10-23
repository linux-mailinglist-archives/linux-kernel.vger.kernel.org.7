Return-Path: <linux-kernel+bounces-866544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D24FBC000DE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87AEF3A2B3A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706593009DD;
	Thu, 23 Oct 2025 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CJMfnzXL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CBF3009EE
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761209982; cv=none; b=D+ido4Uj912GOa7n/9UBc1g1u8p/3WKHNo9LG1ZGRfVyWVv2lYzzTr9FzBPhWAxU8L+NineJpllWMlheyQ9RrxjceoBH0tmqK99iS4gTe9PhIv//CTAe6xDEED0YEwzMzkXCYNT+bW6sgScE8IOnOWzPyntCXmJ/6VXxd+3oyiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761209982; c=relaxed/simple;
	bh=1yh7dz9RMEY07pnAV8bIXHBaBIdaX34BtyPuiHNKE4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dCW1nfMo3yYCrPYP64jT8fvwwu6PZc7HWL+Zj4cUSzsiyvlLy+muzHeTbODBEZBDX5azU4YicISTlSuAtaXMCpZlYZFVh1OJuqzo8LKo4WsNdutebuaav/4Rehmnokn6nL38K04qkortHOzOQXf+PdsK9gOpuxPNTs9ig7XSX84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CJMfnzXL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761209980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sSotLUDJ8zQ7Y8qeJ4UDmz0iyr64rlT9tToeWdRyEWE=;
	b=CJMfnzXLDfvnpqdcU5N2emvHer60BsAiAxERka/IHKPdCRsXTn0nQ/IEOKOWPSbX8b+abN
	H2QZNw9/LkzOQ4HuhdimK6DBleDqB/wQNAG/R/94XAsiPSekhWyKqjR/Y52avmxNATHzx7
	cxv9ab/ptMlKID5DHphmacADAqqGU18=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-4Hvdm653NBuQ2f5iAk9rBg-1; Thu, 23 Oct 2025 04:59:38 -0400
X-MC-Unique: 4Hvdm653NBuQ2f5iAk9rBg-1
X-Mimecast-MFC-AGG-ID: 4Hvdm653NBuQ2f5iAk9rBg_1761209978
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-63b6da1b30aso650862d50.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761209977; x=1761814777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sSotLUDJ8zQ7Y8qeJ4UDmz0iyr64rlT9tToeWdRyEWE=;
        b=My50JCp48clkWsirp6AU56oWwmEsiSXUO2gaKYcbyPyNlmdwY0x5ZGu4McMW/coe1V
         mqglpzJGJzTFl4SlmsV1y5cz6chapSSyWihwVFvqGMtl2P1qfvVgS/ZW/yy1WCFqqlTg
         3SCBDFfgSdbi/9UJcIgP9LNq7aYXbNbuQqlY5j8pClId54h4/P80eO9L3q4173APsbpF
         lkkILc4uqVquesMm8+otNs07TiseBmh5rCqRQbuXTJvP1HAjFxeLOVVqzYFN2pry/t59
         cLRWvXDeCTV6fWfWGu3wRBBplpZ89zn8CVaj4/AIoM7UT82ZGl4tgfhL3acGjUrr2z+L
         sEOA==
X-Forwarded-Encrypted: i=1; AJvYcCW725vvw7vQUmOVjaY1ekrLBw2TMPBlPOwDsSCCZA6Fyq3TFZLe4mLXJnv5maf1WadVMXXD7oLCocOEcsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxazPhNmG0nfB7pIWQFNfZUGI/d8AFE3zGU5Z4U/uXB8TUIVJXi
	M2+FeDNhBNAUrcVpB43uhXWwdTcc9tdLcI8I99Jbk89CvPKAH4nlAVhMcnTo6cIwfbQbkzOwl6H
	NJFASbhlexo4SrLngGv/rt+aUdXJq4yur4R6GpYccbacudbR4+DEO6fZxEen8E/SY/sAQhuCAad
	6TqHfqbE1vTGY2Sa6wGglCu4m5qyhA5r4LHPxCKREjrNyTJhE7abs=
X-Gm-Gg: ASbGncuvjhFD35CX1DLmuPxSzcwPJIVHqp1Zw+mA1oP73S8ga5yMzrLwxAnb4JKouFC
	kfkjYpa7jszwU+OlYDFZWMl63XWw+n39Raa8L9MIkXnNOZUFG8mo0cibgJ9OF/Vw5aY4wZUS6gb
	a47+ojQ5c/+RKUdm7eJuBpavbyv+WFyryp8mJrGwfuFdmZdDayqzqi9MBDYbglvsf+6YHa1E481
	qhsoMmjiJ5lmlRjchgPfuwSnlUO4UDYul2b4jfUW+c=
X-Received: by 2002:a53:e03a:0:b0:63c:f0a0:d2b3 with SMTP id 956f58d0204a3-63e16191c9bmr14720508d50.32.1761209977663;
        Thu, 23 Oct 2025 01:59:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0wNsY0SpvLnxlePtE50ekByNXXN+BJMJDYzluYqiIyg9NsgvCz9tfdqcONap/vZPf8NLrMzM1lW1oyL54W3A=
X-Received: by 2002:a53:e03a:0:b0:63c:f0a0:d2b3 with SMTP id
 956f58d0204a3-63e16191c9bmr14720497d50.32.1761209977337; Thu, 23 Oct 2025
 01:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010085827.116958-1-eperezma@redhat.com> <20251010085827.116958-2-eperezma@redhat.com>
 <20251010081923-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251010081923-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 23 Oct 2025 10:59:01 +0200
X-Gm-Features: AS18NWDXz0Atkh7F9Php1dpfKRFwMMy-_YZuCG3P0gsh7Sj928Na5Lf7nD8kKCs
Message-ID: <CAJaqyWeeJVM6VeYp4HUEe0ZZAi26Jgqw8WaEg6POoGcUOkk6Qw@mail.gmail.com>
Subject: Re: [PATCH v7 1/7] vduse: make domain_lock an rwlock
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, jasowang@redhat.com, 
	Maxime Coquelin <mcoqueli@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 2:34=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>

...

>
>
> > @@ -2045,11 +2046,11 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *m=
dev, const char *name,
> >       if (ret)
> >               return ret;
> >
> > -     mutex_lock(&dev->domain_lock);
> > +     write_lock(&dev->domain_lock);
> >       if (!dev->domain)
> >               dev->domain =3D vduse_domain_create(VDUSE_IOVA_SIZE - 1,
> >                                                 dev->bounce_size);
> > -     mutex_unlock(&dev->domain_lock);
> > +     write_unlock(&dev->domain_lock);
> >       if (!dev->domain) {
> >               put_device(&dev->vdev->vdpa.dev);
> >               return -ENOMEM;
>
>
> Let's look at this example:
>
> So now you are invoking this under an rw lock:
>
>
>
>
> struct vduse_iova_domain *
> vduse_domain_create(unsigned long iova_limit, size_t bounce_size)
> {
>         struct vduse_iova_domain *domain;
>         struct file *file;
>         struct vduse_bounce_map *map;
>         unsigned long pfn, bounce_pfns;
>         int ret;
>
>         bounce_pfns =3D PAGE_ALIGN(bounce_size) >> BOUNCE_MAP_SHIFT;
>         if (iova_limit <=3D bounce_size)
>                 return NULL;
>
>         domain =3D kzalloc(sizeof(*domain), GFP_KERNEL);
>         if (!domain)
>                 return NULL;
>
>
> ...
>
>
>
> Which unless I am mistaken will produce a lockdep splat and deadlock.
>

Can you expand on this? All that code works with and without lockdep.

>
> So it looks like the previous version did not compile
> and this one looks DOA.  What's up?
>

In case it is useful, I forgot to enable some vendor vdpa drivers of
HW I don't have, and that was the reason why it didn't compile. But I
didn't send it without testing it of course.

> At this stage please include information about configs you
> tested, and how.
>
> And any locking changes should also be tested with lockdep enabled
> please.
>

This is the text I'm planning to include in the next series, please
let me know if you want me to expand:

Tested by creating a VDUSE device OVS with and without MQ, and live
migrating between two hosts back and forth while maintaining ping
alive in all the stages. All tested with and without lockdep.


