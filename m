Return-Path: <linux-kernel+bounces-793672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88978B3D6A6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 04:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083D41894FAA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 02:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB641C3306;
	Mon,  1 Sep 2025 02:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g0Vw0Uw5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8D52A1C7
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 02:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756693572; cv=none; b=bXXhC0GlRZ1VvE4ewVbjBlRzIj77k9wqBtDPKMmwHk/DSwujfgcMZ5WWznubqbbiiU3oQHeknVGhehrrz6MlOO2zNOxrNmJAhTRcYF+cOvzmJ9wT5CzBZ8ZUIrCLyvgyrMHoaLcH2dUYhZXvv1SvqG20UfKDtWICILcfMO2UowY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756693572; c=relaxed/simple;
	bh=6Oshq/yJ1fHBl5xl2XzHzCQOf1h3ROLhFP38peDQ2mU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OgFB2nW8FNyswLKzCbFqj6ya9JWGYv8al2uSh1iKx5EWA3VVB9YdN0kczkVC4SI3IqY3O3xo1GxRC36Uk8VsJBwwBuzI8kuw02kcBjZ3XH3vrYnrPdTLwLFe1GaMF8Uj7LcNcof0rka3heMevNv1JCpT0Bbe4aJ2UCGSs51ubWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g0Vw0Uw5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756693569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5pEQF/BwSM3dQ3hEjpIbD+T80xvw1+fXTShbhLh8tNo=;
	b=g0Vw0Uw5u7iv+0w1Y0QQUFFkMN3+cMtb3pfySDDZzh171E3c0tzmU6stgQd9Cdzwkb1bf+
	w0Kt3bKG75nOmWUrV+lLSmLmTuaDZdrFXWXgRJuyVMrsJ8X0+pmkCMq9ZCoKg6oZWwfXKe
	18cE6O7s066Vph+YYL1cfUbvaOhvE8Y=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-R2ZoDgMmMeKetbw6Ta-qmQ-1; Sun, 31 Aug 2025 22:26:07 -0400
X-MC-Unique: R2ZoDgMmMeKetbw6Ta-qmQ-1
X-Mimecast-MFC-AGG-ID: R2ZoDgMmMeKetbw6Ta-qmQ_1756693566
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32801263789so2413622a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 19:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756693566; x=1757298366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pEQF/BwSM3dQ3hEjpIbD+T80xvw1+fXTShbhLh8tNo=;
        b=p3K2eX4uvDq7qDBFTGE4CRryMJh/DFTp+OG00tptBWWXcdYbzZw+oOUWph4xeBhLIS
         lZzTyjKi4/ffPwtsNEeA1iD8rtn/Lk1L4xmBOhSdQajp1ZVb7/cEP7/c5snWVadxmjLb
         IbQe2p2aUo3CXgBUIpGUGyEYXsQwka4t1wpmL2sgqGTYW+hQ+nMUnQ5YEGVvgDf5wja3
         sukR7Bo/OpfF5vZ1yn7ZbEn+BwK984kCrLsESw1E3Fa/cM7IKrRIuxCDbYnVL/tKk7au
         xM5+Jb+jkB1bSQw2buKQr8/D5m3SmyfW12A7kRwk5bksR/Bs/SqegL6EuJWOYv/L3Suo
         6CNw==
X-Forwarded-Encrypted: i=1; AJvYcCVWBz5Afjq+jucDuL0+T/DbtTMZ1be26fcBRbS17jdbfrp0NJoeMnL1gBoJhq6l5NnADEMpxhs4NPekOVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrLv/MjtEEwIuhe0VwuPY7dGkMG87ngmaeN5bRFuPmrGP5Eu7u
	YTS92GhymLWFjzoPA0vsNqpmBdwgq2L0opHSQzQAmrLhikT52jAAjQBUvoOZIhxXROHWwmqG5ce
	7LCMbcbThwxPsZ+6sd8L4bFpOzdexyGz3sMDivJcuHHRsVIsxCSV5XEFmXoNMW91BMXOvj4f2hm
	/c8hUjU2ztnv5GyXqL85dBFr+znoOpfDqiu+PskRS/
X-Gm-Gg: ASbGncsiHaOat+lZJXH1IbkZGY0RrBwoquoAqOaXKX6zU0IZ9fC77Yk0k7h/bz3a5/l
	lyeAIScqOQKOoWQJnbc4DCgRFKRN3UOK7VrPFTb9y47Ri5mqEoplfPoZvBJtHJDLbLuzlWrtU3r
	hq65IVs0Qpbxrvb7r2T7/ncQ==
X-Received: by 2002:a17:90a:d446:b0:327:d4e9:c4ea with SMTP id 98e67ed59e1d1-3280d2b934amr9612695a91.4.1756693566382;
        Sun, 31 Aug 2025 19:26:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFG04L+mSZQxDAgSndTWXpyd5tyWz7U7JM0QivfjSOHhWazWspQAo9CicjuR8nY9/rBKXoNCJFORwKsWHjouZM=
X-Received: by 2002:a17:90a:d446:b0:327:d4e9:c4ea with SMTP id
 98e67ed59e1d1-3280d2b934amr9612666a91.4.1756693565990; Sun, 31 Aug 2025
 19:26:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826112709.1051172-1-eperezma@redhat.com> <20250826112709.1051172-4-eperezma@redhat.com>
In-Reply-To: <20250826112709.1051172-4-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 1 Sep 2025 10:25:54 +0800
X-Gm-Features: Ac12FXzepgUZC6sPZxvYAfiYbM5Kr5AXV_an7YFO7Nm-RiV0EW6x4wQYznXQpbM
Message-ID: <CACGkMEvUQeA8bgvMthjSAa4u0o3u7Sq3PDoRXTADa9e=c8G7uw@mail.gmail.com>
Subject: Re: [PATCH 3/6] vduse: return internal vq group struct as map token
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yongji Xie <xieyongji@bytedance.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 7:27=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Return the internal struct that represents the vq group as virtqueue map
> token, instead of the device.  This allows the map functions to access
> the information per group.
>
> At this moment all the virtqueues share the same vq group, that only
> can point to ASID 0.  This change prepares the infrastructure for actual
> per-group address space handling
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
> v3:
> * Make the vq groups a dynamic array to support an arbitrary number of
>   them.
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 52 ++++++++++++++++++++++++------
>  include/linux/virtio.h             |  6 ++--
>  2 files changed, 46 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 0f4e36dd167e..cdb3dc2b5e3f 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -22,6 +22,7 @@
>  #include <linux/uio.h>
>  #include <linux/vdpa.h>
>  #include <linux/nospec.h>
> +#include <linux/virtio.h>
>  #include <linux/vmalloc.h>
>  #include <linux/sched/mm.h>
>  #include <uapi/linux/vduse.h>
> @@ -84,6 +85,10 @@ struct vduse_umem {
>         struct mm_struct *mm;
>  };
>
> +struct vduse_vq_group_int {
> +       struct vduse_dev *dev;
> +};

Nit: I don't get the meaning of the "int" suffix.

Thanks


