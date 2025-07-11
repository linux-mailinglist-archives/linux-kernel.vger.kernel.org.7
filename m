Return-Path: <linux-kernel+bounces-727011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6F3B013E2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8C595A48B3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5321B1DE8AE;
	Fri, 11 Jul 2025 06:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVwHIZcs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7695E2110E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 06:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752216571; cv=none; b=FTF4Zs5fbj49XM5ptSlH4QjUmo30ZYekLbBApcx7I9UL3NBUH35aD/2lONC2SfOQmiDNgBL/7w6h3UYxvv7vwva3LrkPtO7Z0j0kCdgxv3gKLsmGi0aVuZtk+DlLbEzsRymS0lojuATuHb3IDwdWj3HBTrXwECQn5mdIyOowFas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752216571; c=relaxed/simple;
	bh=8WjKZo/Tzc+89ScV1HU0cXSdTevhkck7mFPn4y7/ZAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iAvhEEHxHHlQSUW/G+W0GFhA1dJLaH7Xmzkhe0hmSbVx1bKolbASiUdY0c4BjOPv0hGen4isV+NrVoCb/Bb8yEJGxIzIMluNfW1mOAiOhjf8NxWHpCNXnbQCCnjzvnhZtjVOplTHw/cx3c3CHzYuOph4750U6IhdsZwCVYbYRx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eVwHIZcs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752216568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BxbG4JFSAtZVQEjQXI+wWXnxQA/cXn+OA4Z+OMpKyu4=;
	b=eVwHIZcs41r3nSKwXtY2urVZWC32sMykNziXDwhZMqgd62IfG57Gb7yDAfaVUdu015kJG2
	uizJr+mQMhlJ24nlXXDQduN2RspglplpGWmLV9CkRmPy37xnQl3DXwz+ka9rlm/SYaLUdY
	/wd3xHGwIkkGLSvbPg/jYmBpmuhLym8=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-qpEdgc2UMkOg8IzPscbNVA-1; Fri, 11 Jul 2025 02:49:27 -0400
X-MC-Unique: qpEdgc2UMkOg8IzPscbNVA-1
X-Mimecast-MFC-AGG-ID: qpEdgc2UMkOg8IzPscbNVA_1752216566
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-53159085185so645167e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 23:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752216566; x=1752821366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxbG4JFSAtZVQEjQXI+wWXnxQA/cXn+OA4Z+OMpKyu4=;
        b=gqUmjAmsstjXoAfnqs7VPxWNz/Y5fOOTu1rMaRvA2W7Aua4nHfnngsyeSveCYsWrdD
         EHJYsiJjYEQaU4P8YoH6trJg5RSo9B6cmrNWsb83A649F7sybBX9pKSFSvCwcy/NcPpe
         +fBsGdU7zN3D0+JImMi7MyfZMHcKN+gOKX+T/AH7s8ygLGM9tFAIUNwKSjlTMT4uSe5u
         oKSquKOJPQxNZjlHAFJDcR4wspPgcQNXecWlYxYfcylZLYHpz0EDwyuC2HiC000FrhQj
         jSxpoPtZh5ifQ8O+sURUN26uTxiQfMZF5FxBjci+0Uq5yemZDimXqvrAYSvSV8OKgRLA
         QByw==
X-Forwarded-Encrypted: i=1; AJvYcCUWzrvovWsROAaC/Y1NGL2sTjD+AjbIcnfR9DhPejRCMbdvWeGNlEuUvIUHb7KcoY8c/uUadwR+05kREMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh6HSzwIwye/8P9X5wu9Eo+RrQ5GfxQ3IiyGLEafeVK5g1KQyN
	10YDpQZROkmshhb161RS25gTPHWDYVrsS5L74a6Cj7Ou259fB+VKsPPW6+zlJLqBDnuJVSaos9y
	Yzxqsf5DDyIEtk9yG6sr6Z7YBxwQ54FwoBZ12f0nCl+WJkbmpfEnzvTHmUXH7BATe1k4RCRIZwR
	w0iFhlQDp085+km0QBEpDrQt+icsn2frxRynVyAiyw
X-Gm-Gg: ASbGncs/abVlZhFtZn3i/CSVMew7PcaBtxCT+2QYak567WW7BjdXwLAdOTzJmlobrVQ
	My1Z1X+HIVaMlKjliU+XdxtyLKF8X3pvWJnZzlC2iPynNet82RwPFRczj7SZrKQkiNgN6u6Q/zd
	rD7HMW7ZGbBr/EYrX6NikBBw==
X-Received: by 2002:a05:6102:dca:b0:4e9:c773:dca1 with SMTP id ada2fe7eead31-4f6411e36c2mr1621595137.11.1752216566342;
        Thu, 10 Jul 2025 23:49:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8pdr64dQhCGFiGndp3QqJ4OXoQVOVXjcmO3HV7h3AAPJDmNsRuoLhWIcxZByOZsvaufxvkGWZod21F8kL+T8=
X-Received: by 2002:a05:6102:dca:b0:4e9:c773:dca1 with SMTP id
 ada2fe7eead31-4f6411e36c2mr1621586137.11.1752216565960; Thu, 10 Jul 2025
 23:49:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616062922.682558-1-lulu@redhat.com> <20250616062922.682558-2-lulu@redhat.com>
 <6107dcb2-51a3-42f8-b856-f443c0e2a60d@6wind.com> <CACGkMEsJdfeNuHdKu0OH=sT4RYhN3d_VOnDcu4_-FquRXo24Xw@mail.gmail.com>
In-Reply-To: <CACGkMEsJdfeNuHdKu0OH=sT4RYhN3d_VOnDcu4_-FquRXo24Xw@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Fri, 11 Jul 2025 14:48:12 +0800
X-Gm-Features: Ac12FXxIsX9kCA8tu7rmOHAy5cYEuocqulMU9XdacIEoFSZMPVCORVJXY4Z54Eo
Message-ID: <CACLfguWqF62MMY3Y45GCRnh=5J75q6ebAqhFgOmhsAAsoyYXew@mail.gmail.com>
Subject: Re: [PATCH v12 1/1] vhost: Reintroduces support of kthread API and
 adds mode selection
To: Jason Wang <jasowang@redhat.com>
Cc: nicolas.dichtel@6wind.com, mst@redhat.com, michael.christie@oracle.com, 
	sgarzare@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 9:02=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Jun 18, 2025 at 8:06=E2=80=AFPM Nicolas Dichtel
> <nicolas.dichtel@6wind.com> wrote:
> >
> > Le 16/06/2025 =C3=A0 08:28, Cindy Lu a =C3=A9crit :
> > > This patch reintroduces kthread mode for vhost workers and provides
> > > configuration to select between kthread and task worker.
> > >
> > > - Add 'fork_owner' parameter to vhost_dev to let users select kthread
> > >   or task mode. Default mode is task mode(VHOST_FORK_OWNER_TASK).
> > >
> > > - Reintroduce kthread mode support:
> > >   * Bring back the original vhost_worker() implementation,
> > >     and renamed to vhost_run_work_kthread_list().
> > >   * Add cgroup support for the kthread
> > >   * Introduce struct vhost_worker_ops:
> > >     - Encapsulates create / stop / wake=E2=80=91up callbacks.
> > >     - vhost_worker_create() selects the proper ops according to
> > >       inherit_owner.
> > >
> > > - Userspace configuration interface:
> > >   * New IOCTLs:
> > >       - VHOST_SET_FORK_FROM_OWNER lets userspace select task mode
> > >         (VHOST_FORK_OWNER_TASK) or kthread mode (VHOST_FORK_OWNER_KTH=
READ)
> > >       - VHOST_GET_FORK_FROM_OWNER reads the current worker mode
> > >   * Expose module parameter 'fork_from_owner_default' to allow system
> > >     administrators to configure the default mode for vhost workers
> > >   * Kconfig option CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL controls wh=
ether
> > >     these IOCTLs and the parameter are available (for distros that ma=
y
> > >     want to disable them)
> > >
> > > - The VHOST_NEW_WORKER functionality requires fork_owner to be set
> > >   to true, with validation added to ensure proper configuration
> > >
> > > This partially reverts or improves upon:
> > >   commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> > >   commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xar=
ray")
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  drivers/vhost/Kconfig      |  17 +++
> > >  drivers/vhost/vhost.c      | 244 ++++++++++++++++++++++++++++++++++-=
--
> > >  drivers/vhost/vhost.h      |  22 ++++
> > >  include/uapi/linux/vhost.h |  29 +++++
> > >  4 files changed, 294 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> > > index 020d4fbb947c..1b3602b1f8e2 100644
> > > --- a/drivers/vhost/Kconfig
> > > +++ b/drivers/vhost/Kconfig
> > > @@ -95,4 +95,21 @@ config VHOST_CROSS_ENDIAN_LEGACY
> > >
> > >         If unsure, say "N".
> > >
> > > +config VHOST_ENABLE_FORK_OWNER_CONTROL
> > > +     bool "Enable VHOST_ENABLE_FORK_OWNER_CONTROL"
> > > +     default n
> > Why disabling this option by default?
>
> I think we should enable this by default.
>
> Thanks
>
Thanks jason,  I will send  a new version
Thanks
cindy
> >
> > Regards,
> > Nicolas
> >
>


