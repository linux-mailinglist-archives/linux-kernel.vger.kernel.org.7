Return-Path: <linux-kernel+bounces-590385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D348A7D263
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 05:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23FE116BEC4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 03:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7220221323E;
	Mon,  7 Apr 2025 03:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V8Xx+SKl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077D1139E
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 03:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743995712; cv=none; b=E9XPgXr9wfTgjpdBnSlU6NH+D8rRR02oaDyI3EjEqmt3zF8av/s4FoOZTy43tDGaSYmA2ADKKuSosFsO9dSUo92H1ncoY21DYHuyxjItVXj5jMnN8U2wGAdWw2PLpXiDH0B0IppyZT1a+IInQKJwT2Fh8+WP1VknPTqWrF96KuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743995712; c=relaxed/simple;
	bh=wX/ZKePXK72L/UtT/n34Ey7iY8xqEj5FcIAkt8TcZNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s61+zExbpWN8B86knO2c6hD8VjT9aYZtZaTjVLPddftNwU4WC7drVrq/eU+qvnp6Pvct03l7eX72atnJBMO170lS5ROyoaqacru2/M82DayEH+hL2ahk3/WPdL4LYfb+1fQx9CtXpc+I07yg7NSeEFIg4dfvNUK9OE565eMr8n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V8Xx+SKl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743995708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Ow5xkC6lxFNJl1iSjbpbLR9zcHIAq3dwwWpyg5r2aE=;
	b=V8Xx+SKl9tR7iBhOgAd3gVQnOmptvdbaK7qa+W6qrBHU/L/8ZbKjjpT/ytGlM5Q6/NW1rX
	c6YYs00v+IyY10X40fM1udRvrrWxPCcew7vLDgWebj4V/5ckB3SnISmpmB0D6e3WbOUtwK
	+AjMNywZ9fqnAuRvuxtFa5XwE3Lj8lc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-xWF2ZYH9N0GiW56Y_3ZEcw-1; Sun, 06 Apr 2025 23:15:07 -0400
X-MC-Unique: xWF2ZYH9N0GiW56Y_3ZEcw-1
X-Mimecast-MFC-AGG-ID: xWF2ZYH9N0GiW56Y_3ZEcw_1743995706
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac293748694so380467666b.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Apr 2025 20:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743995706; x=1744600506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Ow5xkC6lxFNJl1iSjbpbLR9zcHIAq3dwwWpyg5r2aE=;
        b=MOrjOM+2SgAfCumTE3pULonEdBqb0HyY2GjlZUOBatV35+H3PPo9XcwDQR3tfM/xRG
         869xr41olvBWYd+ULvSbPbycMyMsrqn0V5XplvHmLU4y9z5vLmippsfG8Q/feDXwHy+N
         PtMzkLX94ol5OHqwGTgVHR2PcapYyW9/eRphWGh71kKDNsiSNLYqOPdZVEfsX7E8upqq
         5WLbwicbgXEAHhNyNSOHnew6Mvrey76yf+t4kPjjfLEilIkCu/RU4T84HaFxpDluVNzu
         kt+r51BjWUJZTP/eWCqTEoT1na/88lVLgZn1kPspdHoIj7Fje4G/dzm76ANh9yQxrv5B
         HARA==
X-Forwarded-Encrypted: i=1; AJvYcCXfuI0kO5bIoOSYGeACbeHSzMZmUFwyggnJk0QJSUyQyehWzBxdDgJFMm0wrWhZV6KKq2A7aS81WwAnSgE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhl92lbh6YkkZMzglbdx9bsc+KtsgpJgPBA+QssGgbm3Y8Nkk5
	qla7dNj/WYQz76QsTD1J1xK8Yh1rSl/mFvhrSmVPLsCDXy4qgjezkKuolqfCTusu9qN1yFhMdVS
	0rMw9X3UfGAJ3WghKOeCJRsXUgFiLjSpugDOEjWRvaqlcoktYZwMttwdfhma/FMZqN55eVNjERy
	ccpX+S8e6Eatt3PJ22HJawJeoA4nWw/b7ns1lg
X-Gm-Gg: ASbGnctD3HuMeIfYgQODUE4E5HFA3ix17dmLHUoyGyZxm3cAiL3UaP9vyrWzfREEE6/
	wSccoInWH7uP361q2MqZFiqMQcnPg3VrdYAQJO3g61m+j6FbYVNPPzoP+wXiI8l8R95qc6n7Szw
	==
X-Received: by 2002:a17:906:c115:b0:ac6:ba4e:e769 with SMTP id a640c23a62f3a-ac7d18e2570mr868140866b.35.1743995706339;
        Sun, 06 Apr 2025 20:15:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYRlpUUYxghvVFXYwcg/LT8+20dDcyivNhBMRS9F3PHtcHfy/izziM22ZkmdAcfQarnbfuAZDyUchT5xPanIY=
X-Received: by 2002:a17:906:c115:b0:ac6:ba4e:e769 with SMTP id
 a640c23a62f3a-ac7d18e2570mr868140366b.35.1743995705992; Sun, 06 Apr 2025
 20:15:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328100359.1306072-1-lulu@redhat.com> <20250328100359.1306072-6-lulu@redhat.com>
 <qtii7gazb52fuvkeiymllkapnd3l3ji6ht7y7cfegybreavmit@h6bvfhwpghg6>
In-Reply-To: <qtii7gazb52fuvkeiymllkapnd3l3ji6ht7y7cfegybreavmit@h6bvfhwpghg6>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 7 Apr 2025 11:14:29 +0800
X-Gm-Features: ATxdqUG01pIff8m5dVw96x7LgjcZq_jPbv4VBtiZxNFVk_1QG_IUK7TQQCscFHw
Message-ID: <CACLfguWAMYBU4rFtFbjhLkL9P0jvN7w1ZU4-r630kS3GZBaqMg@mail.gmail.com>
Subject: Re: [PATCH v8 5/8] vhost: Reintroduce kthread mode support in vhost
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 9:51=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Fri, Mar 28, 2025 at 06:02:49PM +0800, Cindy Lu wrote:
> >This commit restores the previously removed functions kthread
> >wake/stop/create, and use ops structure vhost_worker_ops to
> >manage worker wakeup, stop and creation. The function
> >vhost_worker_create initializes these ops pointers based on
> >the value of inherit_owner
> >
> >The old function was remove in
>
> nit: s/remove/removed
>
> >commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> >
> >Signed-off-by: Cindy Lu <lulu@redhat.com>
> >---
> > drivers/vhost/vhost.c | 48 ++++++++++++++++++++++++++++++++++++++++++-
> > drivers/vhost/vhost.h |  1 +
> > 2 files changed, 48 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index c162ad772f8f..be97028a8baf 100644
> >--- a/drivers/vhost/vhost.c
> >+++ b/drivers/vhost/vhost.c
> >@@ -734,11 +734,21 @@ static void vhost_task_wakeup(struct vhost_worker =
*worker)
> >       return vhost_task_wake(worker->vtsk);
> > }
> >
> >+static void vhost_kthread_wakeup(struct vhost_worker *worker)
> >+{
> >+      wake_up_process(worker->kthread_task);
> >+}
> >+
> > static void vhost_task_do_stop(struct vhost_worker *worker)
> > {
> >       return vhost_task_stop(worker->vtsk);
> > }
> >
> >+static void vhost_kthread_do_stop(struct vhost_worker *worker)
> >+{
> >+      kthread_stop(worker->kthread_task);
> >+}
> >+
> > static int vhost_task_worker_create(struct vhost_worker *worker,
> >                                   struct vhost_dev *dev, const char *na=
me)
> > {
> >@@ -762,6 +772,41 @@ static int vhost_task_worker_create(struct vhost_wo=
rker *worker,
> >       return 0;
> > }
> >
> >+static int vhost_kthread_worker_create(struct vhost_worker *worker,
> >+                                     struct vhost_dev *dev, const char =
*name)
> >+{
> >+      struct task_struct *task;
> >+      u32 id;
> >+      int ret;
> >+
> >+      task =3D kthread_create(vhost_run_work_kthread_list, worker, "%s"=
, name);
> >+      if (IS_ERR(task))
> >+              return PTR_ERR(task);
> >+
> >+      worker->kthread_task =3D task;
> >+      wake_up_process(task);
> >+      ret =3D xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_=
KERNEL);
> >+      if (ret < 0)
> >+              goto stop_worker;
> >+
> >+      ret =3D vhost_attach_task_to_cgroups(worker);
> >+      if (ret)
> >+              goto stop_worker;
> >+
> >+      worker->id =3D id;
> >+      return 0;
> >+
> >+stop_worker:
> >+      vhost_kthread_do_stop(worker);
> >+      return ret;
> >+}
> >+
> >+static const struct vhost_worker_ops kthread_ops =3D {
> >+      .create =3D vhost_kthread_worker_create,
> >+      .stop =3D vhost_kthread_do_stop,
> >+      .wakeup =3D vhost_kthread_wakeup,
> >+};
> >+
> > static const struct vhost_worker_ops vhost_task_ops =3D {
> >       .create =3D vhost_task_worker_create,
> >       .stop =3D vhost_task_do_stop,
> >@@ -773,7 +818,8 @@ static struct vhost_worker *vhost_worker_create(stru=
ct vhost_dev *dev)
> >       struct vhost_worker *worker;
> >       char name[TASK_COMM_LEN];
> >       int ret;
> >-      const struct vhost_worker_ops *ops =3D &vhost_task_ops;
> >+      const struct vhost_worker_ops *ops =3D
> >+              dev->inherit_owner ? &vhost_task_ops : &kthread_ops;
> >
> >       worker =3D kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
> >       if (!worker)
> >diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> >index 98895e299efa..af4b2f7d3b91 100644
> >--- a/drivers/vhost/vhost.h
> >+++ b/drivers/vhost/vhost.h
> >@@ -37,6 +37,7 @@ struct vhost_worker_ops {
> > };
> >
> > struct vhost_worker {
> >+      struct task_struct *kthread_task;
>                            ^
> nit: I'm not a fan of tabs, but here all the other fields have it, so I
> would put it in.
>
Sure,will fix this
Thanks
Cindy
> >       struct vhost_task       *vtsk;
> >       struct vhost_dev        *dev;
> >       /* Used to serialize device wide flushing with worker swapping. *=
/
> >--
> >2.45.0
> >
>
> The patch LGTM:
>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>


