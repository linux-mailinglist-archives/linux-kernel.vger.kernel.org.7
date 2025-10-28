Return-Path: <linux-kernel+bounces-872860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83124C123B3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 01:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9650F3B5DCB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5AA21CFE0;
	Tue, 28 Oct 2025 00:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sjzx0oFY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625931FE455
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 00:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761612172; cv=none; b=t+OE96fkXtIOEhLxCNShH7RBfA55OucLGu1wM370VUHdmGWl+4QYiVaSUfuuTE2rjrRC1gMNjv01/gMwuwoCXeAeCs1CUvPZ7JFw5wtAjrfpWuaSrqWh50eh4is7+yfVWuuIz6MzKT9kj+9PJFMWjnYtVMNpcb/CWIqi2qzErpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761612172; c=relaxed/simple;
	bh=Oaec4CMUKIqFFDe8IlwQUNfn1sis7V34LfNDLJjhz+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kcldTjVtaeIYmsiy4H159tJAnEmNnig1q8zAlzkHRdsLrTSZd26aTcBXsmUaWyo0m1jCdyZ9arXCqQ+zlkbBGfDAmOWQdeppPo+cIVghDfPIRMK9DxhsklTs1UarNmJ27a6P7PwdPiLo/WAqSuFpSLI17yqlbxjJm5g8ArYtkuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sjzx0oFY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761612167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4S4XxcpkkVefNpOn6q/1PCcyZWnz2c3jb89kMwD+Dak=;
	b=Sjzx0oFY/6d37h76Y3JUmtwP8Bwxx6O4u0L4hvc8mthDEcfV8JjA0yf/bvfqrXuo0bcP7x
	GxsMI20d1ggMPCN3JUa3uzmjKJUsap5Lax1iEeEZ47f8ceXycQpO7fXv1izhrAexg2cG2o
	YcrU86LCSu2dXU5rui3+zqF9aV4JLvQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-p3_Unw1FOr26W3RZMiJGWA-1; Mon, 27 Oct 2025 20:42:45 -0400
X-MC-Unique: p3_Unw1FOr26W3RZMiJGWA-1
X-Mimecast-MFC-AGG-ID: p3_Unw1FOr26W3RZMiJGWA_1761612164
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32eb18b5659so4256525a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761612164; x=1762216964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4S4XxcpkkVefNpOn6q/1PCcyZWnz2c3jb89kMwD+Dak=;
        b=w1gREqyD5gHrkMjrE+G3NlOSjpTzlrHvxwVM+3Yua9+6YJJbQ0PswpibP/qGv7k+b2
         aOP06DwroiokcumAc5ow1A8kqcvWPKYKEzepvHlqWPyxWHAF8Aqm1e5j3fE9VVzCWuuJ
         V8OHSsA0YmiUc1RPMTq3jn9GCKolytgsSemxydU2H07GfXnzMmptbRwREr6AQw7RCkeM
         //Lh9TgdG/UdTom6ObMAXfsCc6uU1LIdVspcxV0w1UJkZ4qdmkhTk6QggW1/Qly6eIlC
         6m+k85g7HHDcbT8vFRSDQ8NH3vTNxSZop2MPnsJx7wGB4uwkPzi++IBqb4vc9cPbNXTm
         vfsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlqYrGN9TyOjZXNAI669bsBT0793u4FULmJ3h13meIiMSDmA32OdF0M8mv2E+aK8/2kBMLyc3FutOlWJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0CSEyehfgACbJYAqKGOTfHwgGjtjlMnfUAwWLvCCtkdkXN7LE
	ndrgrHagWtkFoyoqoavMYruRdnGwoHyUi1x8/IQdXOkQDA+gjjBTW1EqEtXBANH1PRcA87RrBBQ
	A900PmnGWGgWx7bKxIFt+Lps2ArIo5Hufn+wBoKyHCgopMzCFr2UkkcUZ6smUVp2GNZM86NjGig
	T5ZO5vtTs69dNK7bUKaLnqNSND69mpN6wrwFI8L/ch
X-Gm-Gg: ASbGncvjBYrWHzrWE0ZFblcYfItUjUhDwk7H6kGHSynhZbsrgla0Ml8U0kLiXF4JlzJ
	4xPBA/qWMHILZVYmaBMGdr/MNGr0IeZ2TsqiaEPaO70kZyIyJoLNUZ6t3jSbYA5f5gbxedADo+D
	ru5tTV2bdZ0KY2fAW3p2gd8HETtO/QkK/Aug3Nt668GiTvucSIERyA89z/
X-Received: by 2002:a17:90b:56cc:b0:330:6d2f:1b5d with SMTP id 98e67ed59e1d1-34027aac137mr1890122a91.26.1761612163812;
        Mon, 27 Oct 2025 17:42:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeNHCkzvcBmGGrJKaZzXODCr5cxEfASlCJa7QDO1rQohJ+NiOJXFwAxYkL7H35SEY2hZXkIcNLNUTEFlIZH4E=
X-Received: by 2002:a17:90b:56cc:b0:330:6d2f:1b5d with SMTP id
 98e67ed59e1d1-34027aac137mr1890105a91.26.1761612163245; Mon, 27 Oct 2025
 17:42:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027102644.622305-1-nhudson@akamai.com>
In-Reply-To: <20251027102644.622305-1-nhudson@akamai.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 28 Oct 2025 08:42:32 +0800
X-Gm-Features: AWmQ_bklpkUHU7-3U6X8wKJFt2zjBDUD0EycaiSZymIdh7dZBD-GL8V0CTdBW5Y
Message-ID: <CACGkMEtyX6n9uLMmo7X08tFS-V6QZoDVTxhE53h9sLDPNBKnKw@mail.gmail.com>
Subject: Re: [PATCH] vhost: add a new ioctl VHOST_GET_VRING_WORKER_INFO and
 use in net.c
To: Nick Hudson <nhudson@akamai.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Max Tottenham <mtottenh@akamai.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 6:27=E2=80=AFPM Nick Hudson <nhudson@akamai.com> wr=
ote:
>
> The vhost_net (and vhost_sock) drivers create worker tasks to handle
> the virtual queues. Provide a new ioctl VHOST_GET_VRING_WORKER_INFO that
> can be used to determine the PID of these tasks so that, for example,
> they can be pinned to specific CPU(s).
>
> Signed-off-by: Nick Hudson <nhudson@akamai.com>
> Reviewed-by: Max Tottenham <mtottenh@akamai.com>
> ---
>  drivers/vhost/net.c              |  5 +++++
>  drivers/vhost/vhost.c            | 16 ++++++++++++++++
>  include/uapi/linux/vhost.h       |  3 +++
>  include/uapi/linux/vhost_types.h | 13 +++++++++++++
>  kernel/vhost_task.c              | 12 ++++++++++++
>  5 files changed, 49 insertions(+)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 35ded4330431..e86bd5d7d202 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1804,6 +1804,11 @@ static long vhost_net_ioctl(struct file *f, unsign=
ed int ioctl,
>                 return vhost_net_reset_owner(n);
>         case VHOST_SET_OWNER:
>                 return vhost_net_set_owner(n);
> +       case VHOST_GET_VRING_WORKER_INFO:
> +               mutex_lock(&n->dev.mutex);
> +               r =3D vhost_worker_ioctl(&n->dev, ioctl, argp);
> +               mutex_unlock(&n->dev.mutex);
> +               return r;
>         default:
>                 mutex_lock(&n->dev.mutex);
>                 r =3D vhost_dev_ioctl(&n->dev, ioctl, argp);
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 8570fdf2e14a..8b52fd5723c3 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2399,6 +2399,22 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned=
 int ioctl, void __user *argp)
>                 if (ctx)
>                         eventfd_ctx_put(ctx);
>                 break;
> +       case VHOST_GET_VRING_WORKER_INFO:
> +               worker =3D rcu_dereference_check(vq->worker,
> +                                              lockdep_is_held(&dev->mute=
x));
> +               if (!worker) {
> +                       ret =3D -EINVAL;
> +                       break;
> +               }
> +
> +               memset(&ring_worker_info, 0, sizeof(ring_worker_info));
> +               ring_worker_info.index =3D idx;
> +               ring_worker_info.worker_id =3D worker->id;
> +               ring_worker_info.worker_pid =3D task_pid_vnr(vhost_get_ta=
sk(worker->vtsk));
> +
> +               if (copy_to_user(argp, &ring_worker_info, sizeof(ring_wor=
ker_info)))
> +                       ret =3D -EFAULT;
> +               break;
>         default:
>                 r =3D -ENOIOCTLCMD;
>                 break;
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index c57674a6aa0d..c32aa8c71952 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -101,6 +101,9 @@
>  /* Return the vring worker's ID */
>  #define VHOST_GET_VRING_WORKER _IOWR(VHOST_VIRTIO, 0x16,               \
>                                      struct vhost_vring_worker)
> +/* Return the vring worker's ID and PID */
> +#define VHOST_GET_VRING_WORKER_INFO _IOWR(VHOST_VIRTIO, 0x17,  \
> +                                    struct vhost_vring_worker_info)
>
>  /* The following ioctls use eventfd file descriptors to signal and poll
>   * for events. */
> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_=
types.h
> index 1c39cc5f5a31..28e00f8ade85 100644
> --- a/include/uapi/linux/vhost_types.h
> +++ b/include/uapi/linux/vhost_types.h
> @@ -63,6 +63,19 @@ struct vhost_vring_worker {
>         unsigned int worker_id;
>  };
>
> +/* Per-virtqueue worker mapping entry */
> +struct vhost_vring_worker_info {
> +       /* vring index */
> +       unsigned int index;
> +       /*
> +        * The id of the vhost_worker returned from VHOST_NEW_WORKER or
> +        * allocated as part of vhost_dev_set_owner.
> +        */
> +       unsigned int worker_id;

I'm not sure the above two are a must and exposing internal workd_id
seems not like a good idea.

> +
> +       __kernel_pid_t worker_pid;  /* PID/TID of worker thread, -1 if no=
ne */

Instead of exposing the worker PID, I wonder if it's simple to just
having a better naming of the worker instead of a simple:

        snprintf(name, sizeof(name), "vhost-%d", current->pid);

> +};
> +
>  /* no alignment requirement */
>  struct vhost_iotlb_msg {
>         __u64 iova;
> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index 27107dcc1cbf..aa87a7f0c98a 100644
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c
> @@ -67,6 +67,18 @@ static int vhost_task_fn(void *data)
>         do_exit(0);
>  }
>
> +/**
> + * vhost_get_task - get a pointer to the vhost_task's task_struct
> + * @vtsk: vhost_task to return the task for
> + *
> + * return the vhost_task's task.
> + */
> +struct task_struct *vhost_get_task(struct vhost_task *vtsk)
> +{
> +       return vtsk->task;
> +}
> +EXPORT_SYMBOL_GPL(vhost_get_task);
> +
>  /**
>   * vhost_task_wake - wakeup the vhost_task
>   * @vtsk: vhost_task to wake
> --
> 2.34.1
>

Thanks


