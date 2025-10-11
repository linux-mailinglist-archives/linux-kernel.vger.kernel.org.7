Return-Path: <linux-kernel+bounces-849003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A435BCEFF7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 07:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B349407359
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 05:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9A41F63FF;
	Sat, 11 Oct 2025 05:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJwEhIhA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE551EA7F4
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 05:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760160138; cv=none; b=DlNC2HL0yF0OaDSt7AIQ0vd79GHwtkkpEIiwns1YLvDyCvhULN28W4sB9TZgLaEU7POszjoq8f31QLqI8EVkljvY++SaOo3F0jy3yHCT7fAIJu3xt6TJqO1EEECbllz5xrr6s2H81kjou25q/7bcJCDXHRnQ1/KFltp0KZ9FroE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760160138; c=relaxed/simple;
	bh=/3LzOtv8dJtC1ktenpnEogrud/DtztmjtxJadmmjkyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWqY8z0pArSoqHB/1lN4VRQ6G9byVdrQKjSxmixvcUXuOdBqPcti7n5Zsa54ffDbJdfp3mLPt4unxSOO1Jdp/xEvIItJ+M3yA/4/a0TpKll42gkRn3lysCTW6bivx8Cbks4Qua+CFGucpHLisn5WrwEa45jPNDkF2HIJRW9WDW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eJwEhIhA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760160135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oKJe1f/npSv+cn4k13IGSW6Z3J78wAl5KpQfDooVFR8=;
	b=eJwEhIhA93nO9+wOcJq7IhckH+xuy2FTklEAVjdaWF8NPxrCNvXc+wifcWowmisqPSzLQV
	ufF1dHtoSYT/8a23hteYMkuMUwAeHrcVveuE7JZdX7dNRvKPx2cm8eTgEso4VMY3M2UFws
	R/9snFLGxluWvQdMl4bPo9bZAaQHCnM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-Y9j5nMllO1SoNIVBG05R3g-1; Sat, 11 Oct 2025 01:22:14 -0400
X-MC-Unique: Y9j5nMllO1SoNIVBG05R3g-1
X-Mimecast-MFC-AGG-ID: Y9j5nMllO1SoNIVBG05R3g_1760160133
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32eb2b284e4so10429496a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 22:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760160133; x=1760764933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKJe1f/npSv+cn4k13IGSW6Z3J78wAl5KpQfDooVFR8=;
        b=q2xLnixqEKrXV0+APDPpVNVJQMyCTE1DaOVBo7tYv3YwGAHA/oBCB/H8cppfC+4Zsq
         nMYLbdemwl2cte7bxpWYSxEBnMg4bBu6VN6lUdgBxmiUQ0xIGJiGj86wdDeFVhb9BclJ
         J3CThLkO9Y4sNXLiM0AOIAs6FixXbdcW0oditmyq/ksD2LsxE+k8PH/mPIsI+CUVjPJA
         /es72wx8FbwnVHbeUQ3s5t4uu3OGT8zlVRAyFEqx6+37z/qH7LUUYkuBiDajoZG3LF/Y
         Pho2+BeSsilRoKRf6gzdnkEcFnn5Ct5Z0WVMW68mI+f8UzqI1yomv0feFzN+ec7hAPxi
         tDNA==
X-Forwarded-Encrypted: i=1; AJvYcCUHOgsg7JPYYIKovO5dVi/luXqBVt8YVYVesJonVyxsZO/ibZFzzA4haqVYT+PLI5eyPK7ZWd4o7xJaPuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0SjvA3fwi8q4wXktB/B7VTpcYBdzegfJxOhhXEmhRamNpWf4b
	lmp2peUZ5o3dfQehvLKGfy3smlOVs3h6ce8BV13BpsssOJfMgROILgHgoVuAx1olN5XotIA/t5i
	M+O2xJRC8vC7lmFdoXVbfWMMziyn6bWvrl/01cFis5cb/jWkPIwwxn+9yWlFlqzlCCeaSpYBBrX
	oceo9JJtbIsVtN5Jzs+X8ZLk2AzuA4siGVQJ8zSn5v
X-Gm-Gg: ASbGncue31m966h8TUv5BRvmJ1/rVs3+LGiQP5/vc9lMgjFm6Dqr05oomb7e5rUWlxF
	oo1qOWYu3/x9TFvRAh3rFZ77fsoOLb1FnJDyYZ+gj2m7AIcBh5+nceNkdySCQjqWz10ZyEJkZKD
	kfCp/0duk4nDfvdEqN/A==
X-Received: by 2002:a17:90b:17c2:b0:339:a2c1:7014 with SMTP id 98e67ed59e1d1-33b513ced34mr20732318a91.29.1760160133242;
        Fri, 10 Oct 2025 22:22:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/JD09ViFdPNqcboD87jMMMQVF/bSya9yD9MAkoy488ZtLUSNmpZ4bsRcbDyKKAOxchl7DKt9FKGg+9jJMlNg=
X-Received: by 2002:a17:90b:17c2:b0:339:a2c1:7014 with SMTP id
 98e67ed59e1d1-33b513ced34mr20732292a91.29.1760160132813; Fri, 10 Oct 2025
 22:22:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010085827.116958-1-eperezma@redhat.com> <20251010085827.116958-4-eperezma@redhat.com>
In-Reply-To: <20251010085827.116958-4-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sat, 11 Oct 2025 13:22:00 +0800
X-Gm-Features: AS18NWCstKUrE7ls-cyuYLB0dmOpFt6xWYANcsj8p4ighsnVT_EbI8zLz4sUvHw
Message-ID: <CACGkMEtKm0WhbGSLaHreAga7r_=fX2mrG3s+-hORYW5it-NpYg@mail.gmail.com>
Subject: Re: [PATCH v7 3/7] vduse: add vq group support
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 4:58=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> This allows separate the different virtqueues in groups that shares the
> same address space.  Asking the VDUSE device for the groups of the vq at
> the beginning as they're needed for the DMA API.
>
> Allocating 3 vq groups as net is the device that need the most groups:
> * Dataplane (guest passthrough)
> * CVQ
> * Shadowed vrings.
>
> Future versions of the series can include dynamic allocation of the
> groups array so VDUSE can declare more groups.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


