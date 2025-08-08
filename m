Return-Path: <linux-kernel+bounces-759647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D48D3B1E0A6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 04:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D7AC7A9AA8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 02:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D209A149C4D;
	Fri,  8 Aug 2025 02:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OyOetvKj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695E98F54
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 02:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754621196; cv=none; b=rInBPcxR+D1XtZ4zHo4JzmMqu28X5vTD4WHqR+M3Vz7Lfb9Te1OMMMpqDkpNSgEDiIq0r2rmZm3JoBNsqQ8vVO8WEaYpUtmdwCTn2f4WmBPWdZvglp85Sh7Tog46KDTyI6d+A2r5U4WZ0Vu85NCBefMh0juJhnag54miUkH3Q1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754621196; c=relaxed/simple;
	bh=g+WBatSN1qROpBOFqso4X6zWtAVxTg2RObQBEohtQnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uvwk9+4dulyJ4k8zH20mKKVKvx0+u4YoQwQene7gZzgcGG409UonMvtWtQjTl1aJzDHGxXn9aIZkxIQapGAMyZzyNNKgrrrYj83KUhYWbJc2+fonIKRNQbtNINoL383yH+N1ea4RH2p/8rUZ0q/2uwbnij3rMgvEwD/5zXGG2xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OyOetvKj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754621193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jmALfAD79Sc2v/slqMGPnz9hxOoyvuPzjTOCA6rHq8s=;
	b=OyOetvKjsy/WbfIcRnrxmn4G0D6iTHlDA4CiirdVCQ0/2zHE5MeKErYpCcd2ErLX8j4sEg
	smEciV72RoHql+k4cxEhgnl5lbXmn3daG4CATh3T0/PN/sUfoqYAnuv/FWZeq3IzO2pvpq
	uRhla57x3tlE73cz9x5NOVoHzKAYVzs=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-BUVxd9j_PTKuZ3w6ReZdNA-1; Thu, 07 Aug 2025 22:46:31 -0400
X-MC-Unique: BUVxd9j_PTKuZ3w6ReZdNA-1
X-Mimecast-MFC-AGG-ID: BUVxd9j_PTKuZ3w6ReZdNA_1754621190
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3322b98b1a6so8731291fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 19:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754621190; x=1755225990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmALfAD79Sc2v/slqMGPnz9hxOoyvuPzjTOCA6rHq8s=;
        b=iL42qo9x6wb5ABm741BDdIkPJPfXQyo3JdBk6nEA3cH3ywskOAd4RKv8QQBhWtGxBT
         6mwI0HeroA48N8GA6oUNOadkWSL5WQcJu2ZXgke6hYzslgEa/AGm0rUkSLA+GihnluHB
         plbTeo9JaSJmheXg0Wc/qlNT2CbES9m17Co2x+WuTj88zCEKVnpS3UtUhavYFdj343bU
         m8nCCRrPEm9BzZ5YZkjNSNzG0d8k/BNL5RUloNqcaSOcEMa45W67BTGRoQgSEWMO7TaR
         BVxFvx1RK3FX/nPdbHmg/QTQtYOVd/TRO6gKwWGIPQULko7Mswvo6SFvg6l7+xdR4UBu
         7ixA==
X-Forwarded-Encrypted: i=1; AJvYcCVXcBXG36Qizm1lhag7hJsbwx66obDnnBImlUl50/HfEOoZy5TyDq7T4ZmhvXiYK8vfxx11Zy5EkR4xGoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/vXzUfqEFtxJgXY+5tsGIIYxL6dDTHej2gM3oW+GxA8pYCMGu
	HjsZtCZrjTi5MRTO/s8EPpyoXxcVJUxoXEryAm10iHCu+vIeDB0N2hdRAifsJxJvxhJGlLWPSO4
	YUXSlJUUhGQR5YTTf7C6uZdfSVbhKjfFpkfJ74dZpLVY3Fov8so1C4YknZgoNSxpP633IzWpWx3
	yJKn0lgIBte7po5VH+mBih5OMVd4aj+e19Lf08pZYO
X-Gm-Gg: ASbGncuEDqin8R/P22bRjqAgJURuykjSAWqB6YDQQkiE+BK1JRnd1O0+2ZVU7oY6P1+
	IWDiFtIeXpwqsTwZmZjcvxqOxmcnCgPVjlo0NrzjXdmsuCgUo4ZR7Rzgzqwg31F7phNiWxWcUh0
	13J8PEgIq3P7jPEAKmIn9dnQ==
X-Received: by 2002:a05:6512:3996:b0:55b:7e31:c13f with SMTP id 2adb3069b0e04-55cc00b7471mr216424e87.19.1754621189641;
        Thu, 07 Aug 2025 19:46:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPl9MPWvi4vw2YfJW296tcWJT8TkRErAZcJZQzg9MhhbuF/GdVGhnXuvrRQn6Mbz1APgoTDbYgXvUw4Gf6gGU=
X-Received: by 2002:a05:6512:3996:b0:55b:7e31:c13f with SMTP id
 2adb3069b0e04-55cc00b7471mr216410e87.19.1754621189089; Thu, 07 Aug 2025
 19:46:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808015134.2875430-2-lichliu@redhat.com> <CALu+AoTGwZqB28Z+sJ4KW7esNHx8=5kJ6nrMpoQ_rogzSDGwxA@mail.gmail.com>
In-Reply-To: <CALu+AoTGwZqB28Z+sJ4KW7esNHx8=5kJ6nrMpoQ_rogzSDGwxA@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 8 Aug 2025 10:47:09 +0800
X-Gm-Features: Ac12FXwMHdYPLNUSBIVRDOIQo0wLGhwEoVcSzCO_3Te7legG5opEYpuIRQTyYUM
Message-ID: <CALu+AoTGY0wKubVgR_EF5BZmYvh180fjP1AsLvp8cJ447WFGaA@mail.gmail.com>
Subject: Re: [PATCH] fs: Add 'rootfsflags' to set rootfs mount options
To: Lichen Liu <lichliu@redhat.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, rob@landley.net, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	weilongchen@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 8 Aug 2025 at 10:30, Dave Young <dyoung@redhat.com> wrote:
>
> Hi Lichen,
>
> On Fri, 8 Aug 2025 at 09:55, Lichen Liu <lichliu@redhat.com> wrote:
> >
> > When CONFIG_TMPFS is enabled, the initial root filesystem is a tmpfs.
> > By default, a tmpfs mount is limited to using 50% of the available RAM
> > for its content. This can be problematic in memory-constrained
> > environments, particularly during a kdump capture.
> >
> > In a kdump scenario, the capture kernel boots with a limited amount of
> > memory specified by the 'crashkernel' parameter. If the initramfs is
> > large, it may fail to unpack into the tmpfs rootfs due to insufficient
> > space. This is because to get X MB of usable space in tmpfs, 2*X MB of
> > memory must be available for the mount. This leads to an OOM failure
> > during the early boot process, preventing a successful crash dump.
> >
> > This patch introduces a new kernel command-line parameter, rootfsflags,
> > which allows passing specific mount options directly to the rootfs when
> > it is first mounted. This gives users control over the rootfs behavior.
> >
> > For example, a user can now specify rootfsflags=3Dsize=3D75% to allow t=
he
> > tmpfs to use up to 75% of the available memory. This can significantly
> > reduce the memory pressure for kdump.
> >
> > Consider a practical example:
> >
> > To unpack a 48MB initramfs, the tmpfs needs 48MB of usable space. With
> > the default 50% limit, this requires a memory pool of 96MB to be
> > available for the tmpfs mount. The total memory requirement is therefor=
e
> > approximately: 16MB (vmlinuz) + 48MB (loaded initramfs) + 48MB (unpacke=
d
> > kernel) + 96MB (for tmpfs) + 12MB (runtime overhead) =E2=89=88 220MB.
> >
> > By using rootfsflags=3Dsize=3D75%, the memory pool required for the 48M=
B
> > tmpfs is reduced to 48MB / 0.75 =3D 64MB. This reduces the total memory
> > requirement by 32MB (96MB - 64MB), allowing the kdump to succeed with a
> > smaller crashkernel size, such as 192MB.
> >
> > An alternative approach of reusing the existing rootflags parameter was
> > considered. However, a new, dedicated rootfsflags parameter was chosen
> > to avoid altering the current behavior of rootflags (which applies to
> > the final root filesystem) and to prevent any potential regressions.
> >
> > This approach is inspired by prior discussions and patches on the topic=
.
> > Ref: https://www.lightofdawn.org/blog/?viewDetailed=3D00128
> > Ref: https://landley.net/notes-2015.html#01-01-2015
> > Ref: https://lkml.org/lkml/2021/6/29/783
> > Ref: https://www.kernel.org/doc/html/latest/filesystems/ramfs-rootfs-in=
itramfs.html#what-is-rootfs
> >
> > Signed-off-by: Lichen Liu <lichliu@redhat.com>
> > ---
> >  fs/namespace.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index ddfd4457d338..a450db31613e 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -65,6 +65,15 @@ static int __init set_mphash_entries(char *str)
> >  }
> >  __setup("mphash_entries=3D", set_mphash_entries);
> >
> > +static char * __initdata rootfs_flags;
> > +static int __init rootfs_flags_setup(char *str)
> > +{
> > +       rootfs_flags =3D str;
>
> I do see there are a few similar usages in init/do_mounts.c, probably
> it is old stuff and it just works.  But I think making rootfs_flags as
> an array and copying str into it is the right way.

Another question, may need fs people to clarify.  If the mount is
tmpfs and it is also rootfs,  could it use 100% of the memory by
default, and then no need for an extra param?    I feel that there is
no point to reserve memory if it is a fully memory based file system.

>
> > +       return 1;
> > +}
> > +
> > +__setup("rootfsflags=3D", rootfs_flags_setup);
> > +
> >  static u64 event;
> >  static DEFINE_XARRAY_FLAGS(mnt_id_xa, XA_FLAGS_ALLOC);
> >  static DEFINE_IDA(mnt_group_ida);
> > @@ -6086,7 +6095,7 @@ static void __init init_mount_tree(void)
> >         struct mnt_namespace *ns;
> >         struct path root;
> >
> > -       mnt =3D vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", NULL);
> > +       mnt =3D vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", rootfs_fla=
gs);
> >         if (IS_ERR(mnt))
> >                 panic("Can't create rootfs");
> >
> > --
> > 2.50.1
> >
> >
> Thanks
> Dave


