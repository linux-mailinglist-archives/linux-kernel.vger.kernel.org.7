Return-Path: <linux-kernel+bounces-796439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5F2B400B4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE0997B9570
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3850D22D4DE;
	Tue,  2 Sep 2025 12:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rwj9RDUg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF22231A41
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756816475; cv=none; b=uOkfcwGV0H49F3iQr1txuUIRrY99BlRBsvLac2cmD4w6QrYg7tWfb6LBAKxqUwVxA4dYjaoiRBlhAMasIV5oMaG2Ru4UT5WHMiScVWj0n1Do28qMTxc3+cvHsvwClDX0S2szuf+WuaGEqFdpgKyfIhp9wIwfG7UXWpU1FH2YjxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756816475; c=relaxed/simple;
	bh=2VkunjB8a80+phnGTl7LNxUUS2cg5su4nZDfppC7mhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KYD8/SfgBJPwTan9I6Km68BgTSR4LJFp9e85SjaK/D8teacjrREq2CYlB++sDBQYEntXQm8Xb81fmlswuo1YXhD9HDG0XvhFb3J08ZeHDcbgb0SYSaxHOJbVUtZPo6OxaQR7ejaDk1ZQXTTj62janBrN/sr907++4BR0wVtlEcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rwj9RDUg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756816472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ha2JHE9mQgm+rthgNaELv4EMnR5aPkfNOf7BeyLfdcw=;
	b=Rwj9RDUg6U+soZ1hI25Dnd3omhTFmkRTkJwBBvXyNtikJ97KZqQmaV1YT7S4+KqvGIFTS7
	bH03xcsLPAvsT8/AkPsnk0wX0+MneUwp+5tdh2S+qY5gNswh81yWLpB/y38P55F/EONvY2
	Y04R4s0l5T+94/pY3Dfc/XPTWIa5kfk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-09qWgqc0NiSpEtwzhFt3KQ-1; Tue, 02 Sep 2025 08:34:29 -0400
X-MC-Unique: 09qWgqc0NiSpEtwzhFt3KQ-1
X-Mimecast-MFC-AGG-ID: 09qWgqc0NiSpEtwzhFt3KQ_1756816468
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-244581ce13aso106062935ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 05:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756816468; x=1757421268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ha2JHE9mQgm+rthgNaELv4EMnR5aPkfNOf7BeyLfdcw=;
        b=uKfJ72kHnWEqlyNI2/5FbyifZO7bmXA+pzjBE8tMacWOeVnRZd7c78guucDrr5dp2D
         D//y55Y3YUSJMJzuBxen5I+637yJcvyTBD8RJcbZfI1t+fBapdRKoMU5shaK0ul6ndqs
         R4mco9dyA/m5Lh1ldTETdtrdUckMA+nfQ0TfnxSe9BwNYs5Go9HfJn5WFkRfiv8wLHzY
         xzGKUigHcgIviEms7QkxsjDCOYTvz/64RYrJ3pM9VzzPJY9zXdWNBclHLdo204gg8ZX7
         BeyWHroMZk/N4Mc6KZxvh9a4qRAUrkYQ2GvPYaw12AM4sKugG6+XdaBHIr5c8P5JXDG3
         KfDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXThHczksrBOCVs+zGII/AnqXxPmqs46ubyn5sqvVJ+I8sniCLZ7ayFWVHh9xZJJRz7X6QAAFg0iamk0Jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV39J+Lrk8bd/M8GmD2uKCM9/RD3jOxopN945lwZman3Tk3bep
	0+50cVEsOXp45MBhfN98KQ1ATqBTt6U+L9Amrr0YytJA3WFzZrW3APHyIUsXIr3doB6jUJBJqwC
	Qj88evJfyun986ZkNt01zpSvYLNXiRZryfQx4ngbuMB+MumHf9q8S/HF91n+WkF231BqMJPko1G
	uBkJo3b8F0qvXGJr13R3w31KNKUiouvHsE9nS7DFk0
X-Gm-Gg: ASbGncu99wZ3BLaYzBZcCHLLO4GmnUI+YJdjTas9Kk98/Uhmad/maU9naxvpXt+3m4a
	kHOGyvIw5jC2/w/Q3OON0vaqXIgLqqFbEyimH1jAbS27izPtEST/I4kJXiQnEsa0ZOiw6I2fBti
	KP5Y+sJ/teQYx/2yvVyQs=
X-Received: by 2002:a17:903:41d1:b0:246:ae6e:e5e5 with SMTP id d9443c01a7336-249448744b8mr134647145ad.8.1756816468156;
        Tue, 02 Sep 2025 05:34:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCN5Dna2Yp8TYSDb+TUsfK66i8SK5iFQPVbZuu23hVbHf0NqGK7VSz4SAdTl9KrvE4loIkE3bT4PyidPyehXw=
X-Received: by 2002:a17:903:41d1:b0:246:ae6e:e5e5 with SMTP id
 d9443c01a7336-249448744b8mr134646905ad.8.1756816467742; Tue, 02 Sep 2025
 05:34:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902115341.292100-1-lorenzo.stoakes@oracle.com>
In-Reply-To: <20250902115341.292100-1-lorenzo.stoakes@oracle.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 2 Sep 2025 14:34:15 +0200
X-Gm-Features: Ac12FXz98W_t9ILV-_IT6ezCbhIE6zwQ_72FfTs2Xhipir90U7Uo_Cdjg4YnIrU
Message-ID: <CAHc6FU4=L+PU5i6j3cH2KjA+PtvBk-56=CaWN3+yHqHrGX=VrQ@mail.gmail.com>
Subject: Re: [PATCH] gfs2, udf: update to use mmap_prepare
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Christian Brauner <christian@brauner.io>, Jan Kara <jack@suse.com>, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 1:53=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> The f_op->mmap() callback is deprecated, and we are in the process of
> slowly converting users to f_op->mmap_prepare().
>
> While some filesystems require additional work to be done before they can
> be converted, the gfs2 and udf filesystems (like most) are simple and can
> simply be replaced right away.
>
> This patch adapts them to do so.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  fs/gfs2/file.c | 12 ++++++------
>  fs/udf/file.c  |  8 +++++---
>  2 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> index bc67fa058c84..c28ff8786238 100644
> --- a/fs/gfs2/file.c
> +++ b/fs/gfs2/file.c
> @@ -577,7 +577,7 @@ static const struct vm_operations_struct gfs2_vm_ops =
=3D {
>  };
>
>  /**
> - * gfs2_mmap
> + * gfs2_mmap_prepare
>   * @file: The file to map
>   * @vma: The VMA which described the mapping
>   *
> @@ -588,8 +588,9 @@ static const struct vm_operations_struct gfs2_vm_ops =
=3D {
>   * Returns: 0
>   */
>
> -static int gfs2_mmap(struct file *file, struct vm_area_struct *vma)
> +static int gfs2_mmap_prepare(struct vm_area_desc *desc)
>  {
> +       struct file *file =3D desc->file;
>         struct gfs2_inode *ip =3D GFS2_I(file->f_mapping->host);
>
>         if (!(file->f_flags & O_NOATIME) &&
> @@ -605,7 +606,7 @@ static int gfs2_mmap(struct file *file, struct vm_are=
a_struct *vma)
>                 gfs2_glock_dq_uninit(&i_gh);
>                 file_accessed(file);
>         }
> -       vma->vm_ops =3D &gfs2_vm_ops;
> +       desc->vm_ops =3D &gfs2_vm_ops;
>
>         return 0;
>  }
> @@ -1585,7 +1586,7 @@ const struct file_operations gfs2_file_fops =3D {
>         .iopoll         =3D iocb_bio_iopoll,
>         .unlocked_ioctl =3D gfs2_ioctl,
>         .compat_ioctl   =3D gfs2_compat_ioctl,
> -       .mmap           =3D gfs2_mmap,
> +       .mmap_prepare   =3D gfs2_mmap,

This ought to be:
  .mmap_prepare =3D gfs2_mmap_prepare,

>         .open           =3D gfs2_open,
>         .release        =3D gfs2_release,
>         .fsync          =3D gfs2_fsync,
> @@ -1620,7 +1621,7 @@ const struct file_operations gfs2_file_fops_nolock =
=3D {
>         .iopoll         =3D iocb_bio_iopoll,
>         .unlocked_ioctl =3D gfs2_ioctl,
>         .compat_ioctl   =3D gfs2_compat_ioctl,
> -       .mmap           =3D gfs2_mmap,
> +       .mmap_prepare   =3D gfs2_mmap_prepare,
>         .open           =3D gfs2_open,
>         .release        =3D gfs2_release,
>         .fsync          =3D gfs2_fsync,
> @@ -1639,4 +1640,3 @@ const struct file_operations gfs2_dir_fops_nolock =
=3D {
>         .fsync          =3D gfs2_fsync,
>         .llseek         =3D default_llseek,
>  };
> -
> diff --git a/fs/udf/file.c b/fs/udf/file.c
> index 0d76c4f37b3e..fbb2d6ba8ca2 100644
> --- a/fs/udf/file.c
> +++ b/fs/udf/file.c
> @@ -189,10 +189,12 @@ static int udf_release_file(struct inode *inode, st=
ruct file *filp)
>         return 0;
>  }
>
> -static int udf_file_mmap(struct file *file, struct vm_area_struct *vma)
> +static int udf_file_mmap_prepare(struct vm_area_desc *desc)
>  {
> +       struct file *file =3D desc->file;
> +
>         file_accessed(file);
> -       vma->vm_ops =3D &udf_file_vm_ops;
> +       desc->vm_ops =3D &udf_file_vm_ops;
>
>         return 0;
>  }
> @@ -201,7 +203,7 @@ const struct file_operations udf_file_operations =3D =
{
>         .read_iter              =3D generic_file_read_iter,
>         .unlocked_ioctl         =3D udf_ioctl,
>         .open                   =3D generic_file_open,
> -       .mmap                   =3D udf_file_mmap,
> +       .mmap_prepare           =3D udf_file_mmap_prepare,
>         .write_iter             =3D udf_file_write_iter,
>         .release                =3D udf_release_file,
>         .fsync                  =3D generic_file_fsync,
> --
> 2.50.1
>

Thanks,
Andreas


