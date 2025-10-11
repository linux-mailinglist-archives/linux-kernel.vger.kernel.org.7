Return-Path: <linux-kernel+bounces-849054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 583EDBCF169
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 09:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8014F19A259C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 07:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB94A226CF1;
	Sat, 11 Oct 2025 07:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SstRanuV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5281547F2
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 07:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760168718; cv=none; b=th05vRELdnyTKqPzZ/PJRqp0eUt1hex/qd8N7bioqQ7EwmWGqpytizHUO9bxTr0GORHCvxr7UtsdI8dRDOXyIkYPnkUXaQXksqk/fuYweZ4qSjQ1Bi9yDw754aeKnuErqVqCyMIX3CfVKWY2tcFLeLno88JaGci3uIdhQu+3Ymk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760168718; c=relaxed/simple;
	bh=IRBVhMtnvfXCNw2+CiFz+E5fMH3uE9XUiZrv2bYozgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqLBb99ruNW1ddHL3/0m3CgPYuBTprLGYLkv2MqgkTr0wdovuspoJzafoXhzo10rIejR3IzXSEI8xCpcGc50Lr85jArNr9X5PVg6gjlm9Tr+hMevnrNT+bNZCpQjJbNhoHVbVOs42upErZyN1cZ3+8EW79d8niczLpN8izY5xfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SstRanuV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760168714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NxTjQN0BpNlhv5a09n6MH+YC+U2y/tcPRoRk2p3O6Tk=;
	b=SstRanuV+BryCDxEWAqZ7sF0jEzUxaY80YkEL92Iivtlj2cHGsD7Lp2Ryzghk7CIR2mESv
	K2EcFMLK9MjkYjZ0Tdzf/jY017IFyuBJqWNrMPWQepCM71ZbCUg276XStzEv+5Mla34E8/
	IaTYJDEJqMdxbd7Pn/LrBVDJSZYx1jc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-jHDNL737P7Wna5jR44BGhA-1; Sat, 11 Oct 2025 03:45:12 -0400
X-MC-Unique: jHDNL737P7Wna5jR44BGhA-1
X-Mimecast-MFC-AGG-ID: jHDNL737P7Wna5jR44BGhA_1760168711
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32eb864fe90so11014862a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 00:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760168711; x=1760773511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxTjQN0BpNlhv5a09n6MH+YC+U2y/tcPRoRk2p3O6Tk=;
        b=bKFKVCUhK3UZMnY3qw2AhObVT0z5ERP0JwbH1vlqGDoVwmxQluG1Wssh+gVSu9wsTy
         HcE6djf/6u86i2g0fWDNn77fqRNq42zX2EuPbkNXHLnAVUm28e1sGTEuR36qXQArlRSD
         fZDDgJXXeSGLDxZctxwx0bnJe6s0uvMSde50ppzF0H8gPXSt3RYJcqY9cqzNuu/i2RVc
         GDEMjykW6C1W+hQKw0KeO5+F6MkGOT6c7sRriNJIFqin/Hf9qNdF3RorRx6etRoqTYcu
         0r78gTezb08WYzt7WL3ai0nSVH3dEAhERqe3z8qw//0fOU4Ne48wrJ5JSmADXY7S/yRC
         Ti/w==
X-Forwarded-Encrypted: i=1; AJvYcCXghMKjPsZYnox7XzFDFRyUhfwjmaNWlwpRGGpc56cJbQLk83MZn+PZ3VISzJRIS/zrH/QfZ2TXLHMMkVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTXF3LwC2QQMcVJKC8jXI3i8Os9gwqSBle89OMo1dW97mB4AuP
	eTOpbow5xUotrh59zA1uLxSjSsFtUvyi+p3Htq9GjU3DD9bafBW5DrDTiRf2STPo/0oBsUG8Y+0
	59YHP8U2E+RGKOJMO1wSqXTsdhSy85bNN0towU2D5w0fT/7lHGVK87DkrKkFOAqnfhos1z/dC+3
	3PhHsyoDx8a/FJahdfjck6/dnQG5pjnt05TIdhrTzV
X-Gm-Gg: ASbGnctlxb7h25oAAhDG2PPyz1iqaeFbr3qKWLjkke+OqWFyDC2Oy0VWmFpXdf1uCef
	U3X+Suc3aYRVZ4fG/Sophva9QCOTEzO8imwPn7wRkE9RChL/vPQw8KJf64L9wBI/E+oGC8mchLC
	6xVW66zMmezzLT9+f8xw==
X-Received: by 2002:a17:90b:3b86:b0:329:ed5b:ecd5 with SMTP id 98e67ed59e1d1-33b5127bf42mr20371387a91.19.1760168711087;
        Sat, 11 Oct 2025 00:45:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGPAupPV9/mFzX/1qNB5oaR43M4dJqgeJ/r/PkgJa/5EI7TRbK3laPSK2RhrFUHnAdF6FOQPBTCE8eV4xl3g0=
X-Received: by 2002:a17:90b:3b86:b0:329:ed5b:ecd5 with SMTP id
 98e67ed59e1d1-33b5127bf42mr20371361a91.19.1760168710623; Sat, 11 Oct 2025
 00:45:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007130622.144762-1-eperezma@redhat.com> <20251007130622.144762-2-eperezma@redhat.com>
In-Reply-To: <20251007130622.144762-2-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sat, 11 Oct 2025 15:44:57 +0800
X-Gm-Features: AS18NWCJuDEIdQcOLxJka21_V13mq6YSX8QzoVc4a0nUJ7-xdjg7EtcTcqY06a0
Message-ID: <CACGkMEvJwcTFmDTXyXvMM1dP0OginF-FKZsksFO1DamRQJP1TQ@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: mst@redhat.com, Yongji Xie <xieyongji@bytedance.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Maxime Coquelin <mcoqueli@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dragos Tatulea DE <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 9:06=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat.=
com> wrote:
>
> An userland device implemented through VDUSE could take rtnl forever if
> the virtio-net driver is running on top of virtio_vdpa.  Let's break the
> device if it does not return the buffer in a longer-than-assumible
> timeout.
>
> A less agressive path can be taken to recover the device, like only
> resetting the control virtqueue.  However, the state of the device after
> this action is taken races, as the vq could be reset after the device
> writes the OK.  Leaving TODO anyway.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  drivers/net/virtio_net.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 31bd32bdecaf..ed68ad69a019 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3576,6 +3576,7 @@ static bool virtnet_send_command_reply(struct virtn=
et_info *vi, u8 class, u8 cmd
>  {
>         struct scatterlist *sgs[5], hdr, stat;
>         u32 out_num =3D 0, tmp, in_num =3D 0;
> +       unsigned long end_time;
>         bool ok;
>         int ret;
>
> @@ -3614,11 +3615,20 @@ static bool virtnet_send_command_reply(struct vir=
tnet_info *vi, u8 class, u8 cmd
>
>         /* Spin for a response, the kick causes an ioport write, trapping
>          * into the hypervisor, so the request should be handled immediat=
ely.
> +        *
> +        * Long timeout so a malicious device is not able to lock rtnl fo=
rever.
>          */
> +       end_time =3D jiffies + 30 * HZ;

The problem that 30 * HZ is probably long enough to trigger the
warnings like hungtask?


>         while (!virtqueue_get_buf(vi->cvq, &tmp) &&
>                !virtqueue_is_broken(vi->cvq)) {
>                 cond_resched();
>                 cpu_relax();
> +
> +               if (time_after(end_time, jiffies)) {
> +                       /* TODO Reset vq if possible? */
> +                       virtio_break_device(vi->vdev);
> +                       break;
> +               }
>         }
>
>  unlock:
> --
> 2.51.0
>

Thansk


