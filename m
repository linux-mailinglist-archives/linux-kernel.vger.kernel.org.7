Return-Path: <linux-kernel+bounces-759645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9C0B1E0A0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 04:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C25CD3BF6C3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 02:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85B51519A6;
	Fri,  8 Aug 2025 02:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XkCGUY5D"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548E37FD
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 02:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754620171; cv=none; b=elOKWjarqYmad/07STJi+uXa1hi9NPID41l0TvP8waxPQXd3QiKJR+Um85v8JDj232k9BAmovbYl0q0m4aWU86A1Ymoitj22UMV6r4u3+bfFQGuBUK+8Y0SU2ycLGY2W1D8sekhYGDKIAU+Nx4EMuozFGW2j/6SXGeuBuo9/g/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754620171; c=relaxed/simple;
	bh=dG5sWLSX8sbmJgwOPGxaq6tgG4UW1cPLDi5JnaittHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RvL8x6VZD+2DIFTncmm1zke71atiELjH1Ij0YyaOEUWnKYIt3AnCCt5zDF/Kg093wrmb6FLHi0doMqkKFJ5+8kS1EopWgA3gaX3sbnv9ToQVoFX+ZHVro45cAJyhnRsaazDJ6K7uCblJLLhxlElZ7IPUgl3+q6n18yWXm8e7wv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XkCGUY5D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754620168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XWO28gwYTWogzlWdvgUUvwXPL9Mg4aE3AHHmYyG+EaY=;
	b=XkCGUY5DFl+FHUOy6aoSp1Nl13ShqWVkFGLz1Z4MSqBEaH6xTrGtKYTbyJoGmgyzlWsIVG
	kDygIhUPPfnLaMwkRAFWbTbLmOcwr13qOPXmp4MIZbXkuP0F3eH+1lh7tny2R1VYDBvCZ3
	xFIc+moe3gZb05EflpElWLXOn0Gdtjw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-OshNnUw_Mz2MdiN88RrI3w-1; Thu, 07 Aug 2025 22:29:26 -0400
X-MC-Unique: OshNnUw_Mz2MdiN88RrI3w-1
X-Mimecast-MFC-AGG-ID: OshNnUw_Mz2MdiN88RrI3w_1754620165
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3323287983bso11803481fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 19:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754620165; x=1755224965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWO28gwYTWogzlWdvgUUvwXPL9Mg4aE3AHHmYyG+EaY=;
        b=BajLIYZsnHgdhJ2Nhh2cf0shNlXQt45vqm+IpUBittCPGE6JZGrAIcb/lYg2OXI+QV
         Jts3vAvLtUF+mfOIPDu4CEqHCv7Hzrjxt6beR2HeVZl4rmEt0uKQWHtMiwyxH0Cpcm1y
         g3tXTtdjY/9u1tVOp4NoW+HKL4YuJqCkDYxg2k8La4krQIQVpom0UgzikQ35CsXEchvz
         Y0gO0WIEedH/xTsk/NxoP6ZIudY+jGW8jkVLikrWAgX9TtJYzT5BZsdUXzQNwAs8fhVg
         K/+vgmk7D+YjMMVm5bJBhhPpYZ9lwyteUOK8SxianLgFrBycLZloSeiawpG6jMyjOa22
         DD9g==
X-Forwarded-Encrypted: i=1; AJvYcCVI9wC+wB6S0nYYYpzCkYZg89WTMuvCjaix7RAeP7Ix0HYh0VYwiwEL95SX0d0iat41jqHiQPz7z4fEBG0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr3ngt487yVCDPTkPqd7UFD3SzMLz4A5ggIYQeNJwr4f3GjecW
	Wj5lkoSxO9mOe9BUK5+LNBOud6Dypl8xYTyirg0f3Z1XuIl5ivHsIrGKFAUzflAijC2BfCHIePe
	Z7VZg4uY16sm1o4Cv7Dk3RuOvcjETWukOGn3a5+SgIdo6jPmpk4/FXRUduHj++67Jho8fRw1a/Y
	/WNxL8QjVqJOjJI+8Kb7Cpm7Huixp/v1MPpMIRkpWD
X-Gm-Gg: ASbGncs0YAegB3h8vdNgum/2vvEaORh03ayHsqaVPKVEknoyeDu9Bb/WVH1uxYIaJit
	Zp60wL16+6U3mr5GMX4KSW2yJpTQKXegzFutzPtzU5wxrxWgqqSxHRNyudbnVnNU1PLj381faTd
	MMgMTtmD5fHPIBjkIKCmU0eg==
X-Received: by 2002:a05:6512:4006:b0:55b:760d:c2e6 with SMTP id 2adb3069b0e04-55cc00adef4mr235695e87.2.1754620164777;
        Thu, 07 Aug 2025 19:29:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4XzQf169HOvBGe6tunaXtqLl6ZIzU+U8mV7ZNhc0nlOI9xBKSORZ4O8H7NJfMJv+z5oSK4BFm1Hcr0DNYFA8=
X-Received: by 2002:a05:6512:4006:b0:55b:760d:c2e6 with SMTP id
 2adb3069b0e04-55cc00adef4mr235680e87.2.1754620164280; Thu, 07 Aug 2025
 19:29:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808015134.2875430-2-lichliu@redhat.com>
In-Reply-To: <20250808015134.2875430-2-lichliu@redhat.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 8 Aug 2025 10:30:04 +0800
X-Gm-Features: Ac12FXzXPcQuckbFIXVF4do131vQN15Llc9s99Q_ea3julL0PWC3EGzx9j_wJRQ
Message-ID: <CALu+AoTGwZqB28Z+sJ4KW7esNHx8=5kJ6nrMpoQ_rogzSDGwxA@mail.gmail.com>
Subject: Re: [PATCH] fs: Add 'rootfsflags' to set rootfs mount options
To: Lichen Liu <lichliu@redhat.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, rob@landley.net, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	weilongchen@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lichen,

On Fri, 8 Aug 2025 at 09:55, Lichen Liu <lichliu@redhat.com> wrote:
>
> When CONFIG_TMPFS is enabled, the initial root filesystem is a tmpfs.
> By default, a tmpfs mount is limited to using 50% of the available RAM
> for its content. This can be problematic in memory-constrained
> environments, particularly during a kdump capture.
>
> In a kdump scenario, the capture kernel boots with a limited amount of
> memory specified by the 'crashkernel' parameter. If the initramfs is
> large, it may fail to unpack into the tmpfs rootfs due to insufficient
> space. This is because to get X MB of usable space in tmpfs, 2*X MB of
> memory must be available for the mount. This leads to an OOM failure
> during the early boot process, preventing a successful crash dump.
>
> This patch introduces a new kernel command-line parameter, rootfsflags,
> which allows passing specific mount options directly to the rootfs when
> it is first mounted. This gives users control over the rootfs behavior.
>
> For example, a user can now specify rootfsflags=3Dsize=3D75% to allow the
> tmpfs to use up to 75% of the available memory. This can significantly
> reduce the memory pressure for kdump.
>
> Consider a practical example:
>
> To unpack a 48MB initramfs, the tmpfs needs 48MB of usable space. With
> the default 50% limit, this requires a memory pool of 96MB to be
> available for the tmpfs mount. The total memory requirement is therefore
> approximately: 16MB (vmlinuz) + 48MB (loaded initramfs) + 48MB (unpacked
> kernel) + 96MB (for tmpfs) + 12MB (runtime overhead) =E2=89=88 220MB.
>
> By using rootfsflags=3Dsize=3D75%, the memory pool required for the 48MB
> tmpfs is reduced to 48MB / 0.75 =3D 64MB. This reduces the total memory
> requirement by 32MB (96MB - 64MB), allowing the kdump to succeed with a
> smaller crashkernel size, such as 192MB.
>
> An alternative approach of reusing the existing rootflags parameter was
> considered. However, a new, dedicated rootfsflags parameter was chosen
> to avoid altering the current behavior of rootflags (which applies to
> the final root filesystem) and to prevent any potential regressions.
>
> This approach is inspired by prior discussions and patches on the topic.
> Ref: https://www.lightofdawn.org/blog/?viewDetailed=3D00128
> Ref: https://landley.net/notes-2015.html#01-01-2015
> Ref: https://lkml.org/lkml/2021/6/29/783
> Ref: https://www.kernel.org/doc/html/latest/filesystems/ramfs-rootfs-init=
ramfs.html#what-is-rootfs
>
> Signed-off-by: Lichen Liu <lichliu@redhat.com>
> ---
>  fs/namespace.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index ddfd4457d338..a450db31613e 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -65,6 +65,15 @@ static int __init set_mphash_entries(char *str)
>  }
>  __setup("mphash_entries=3D", set_mphash_entries);
>
> +static char * __initdata rootfs_flags;
> +static int __init rootfs_flags_setup(char *str)
> +{
> +       rootfs_flags =3D str;

I do see there are a few similar usages in init/do_mounts.c, probably
it is old stuff and it just works.  But I think making rootfs_flags as
an array and copying str into it is the right way.

> +       return 1;
> +}
> +
> +__setup("rootfsflags=3D", rootfs_flags_setup);
> +
>  static u64 event;
>  static DEFINE_XARRAY_FLAGS(mnt_id_xa, XA_FLAGS_ALLOC);
>  static DEFINE_IDA(mnt_group_ida);
> @@ -6086,7 +6095,7 @@ static void __init init_mount_tree(void)
>         struct mnt_namespace *ns;
>         struct path root;
>
> -       mnt =3D vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", NULL);
> +       mnt =3D vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", rootfs_flags=
);
>         if (IS_ERR(mnt))
>                 panic("Can't create rootfs");
>
> --
> 2.50.1
>
>
Thanks
Dave


