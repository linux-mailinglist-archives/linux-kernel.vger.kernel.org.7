Return-Path: <linux-kernel+bounces-759678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 43714B1E105
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 05:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C1484E05AE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 03:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC57192598;
	Fri,  8 Aug 2025 03:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKpLehK1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F2FDDAD
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 03:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754624219; cv=none; b=nXbUqtsu0WfCgBhmZZHqrleYrajzyXDOgfRU/T2U+haW2PIXtDTLcjshm6bsTd6KfF7odmfuP3BW81CfTbGw+63reVfFT9rEPx3jkCashPIDVaFHWwyw14HckXzSqKlLz3puxO2f7Qdtxtrh0i4Pt7aJ/XBlVDCpjsUPdpVEJiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754624219; c=relaxed/simple;
	bh=DdSoLXyFxci8lCj1B8K/vlsIG2J6Emjbk12yvW85aTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLADdKj6JrN0+IBVPxpKuDdy89qWH/MIo/RyJ/Tqx/kNyiSd0mm+hwOI1wBZ5qncoVcMOpN5B+NpxaR4XvFbBhR4ahrqiunVQrPZSSVAXhgpcxR/5u4wRkN9X1AnpCtTy9R5TI/EUPh05UzsR3vwhXelhY/qqJ0ELtqTNrY6YLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SKpLehK1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754624216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gsyp6Edg52gGxunzu47oK6lBp56ZTl6cz3Zk/uJfGaM=;
	b=SKpLehK1rNMz50RC7Bj21vQU1Nud1E5dl9tpWJnVquBXAhd9xI/t7nn/VN95DfYfDDvHpB
	mVdNQBEsCcy0LEspnfACcrpkmdo2UR0qH2NxTg/ZAdCZpaOIdYfIuI2ymO3TVSOvGhBIcI
	olu9SejaEsSbvdbtvbW9H90q7Y/GD7g=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-7B_jZHa-MWi-j30-tD1tyQ-1; Thu, 07 Aug 2025 23:36:54 -0400
X-MC-Unique: 7B_jZHa-MWi-j30-tD1tyQ-1
X-Mimecast-MFC-AGG-ID: 7B_jZHa-MWi-j30-tD1tyQ_1754624214
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4af199d0facso49894311cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 20:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754624214; x=1755229014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsyp6Edg52gGxunzu47oK6lBp56ZTl6cz3Zk/uJfGaM=;
        b=KPAmlruZ/MntEEkad4dyvordVKPVQoo17lgzSnryVnIdvtwWjv8ThyjfyC5+tFjAdA
         0Qhzen8CCpiN8JD/e26Invkua/u8Yj83SGuRHqaaKmOYJ26ssdsxu8yWUNz/ocxxqwId
         B8mMu3b7NB1+5iFmkxfSvCE3YfXWsGnKu2yp0xoP3vlzmzAV2onxCIO4Cd+aNntPlziV
         Fxb+gEwutyudnBPWeyQi3Hgy2XyQicPJrb3Jr+jMdEaPJJXsV4xhSbRef4dMef85UbT8
         Sdc5ZDQolj5o3U6uVaQsCcs0ziz70XqJOERTczh19tzngDBe3OtuCSwlNvpwqp3bBXuk
         2tAg==
X-Forwarded-Encrypted: i=1; AJvYcCX1uqA65yjRJD5eOAWyZa7bDDj1VBDY8kw42Inil4QMMZ4ujZOHqq+tzXciUIf0Q9KuBZz/4Kabwb7II+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtyZDLzUlj2y6XAOhFaiVeqR8mVzMnevifN2doesZZQm/xQe+l
	Kud395uj1iRSrUArugu85cJeVjYhyGagWwYIcOtmxG8fL47rd0dUzubNRNP1sfT+OS52KVd49Ej
	wnqz2gAWBNaq+jYXXR1zHQP0czt/Puc8STC/j7+QSMMjpcr7oc42rZkjqfape0Upoo7JlmzoWxZ
	/5pGnO4GOMpGK0t3LSQ03saH+Bi9ydlFyAN0GfW5h1
X-Gm-Gg: ASbGnctLzChIg3hz/OUWl80uxcOM+ZD1wzzXCUj5N3zHpxATv5CEWE8TpEYMYeuyZed
	xJeUzrjfOu3IHWdM/dZ43Q+8jHA3Tzyn8BJUa+GYCFQ6ikJM4vgcSRZP7fgsZCM9fAuqyml32yS
	9+uAnZAYISe/HyDXU+H87uc69vSiy2aKVbmq8v2vOXV7fmVAYAwULK
X-Received: by 2002:ac8:5d04:0:b0:4b0:6a31:163a with SMTP id d75a77b69052e-4b0afd827f0mr18021901cf.4.1754624214260;
        Thu, 07 Aug 2025 20:36:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh1M25upIO8yP24fBcslf6iFMfxnENdkySk6wSIBZZPvvKaFt0DZ6Carbxl/kgYDKYoZ7WIqT4DSAxq/3ahpg=
X-Received: by 2002:ac8:5d04:0:b0:4b0:6a31:163a with SMTP id
 d75a77b69052e-4b0afd827f0mr18021761cf.4.1754624213751; Thu, 07 Aug 2025
 20:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808015134.2875430-2-lichliu@redhat.com> <CALu+AoTGwZqB28Z+sJ4KW7esNHx8=5kJ6nrMpoQ_rogzSDGwxA@mail.gmail.com>
 <CALu+AoTGY0wKubVgR_EF5BZmYvh180fjP1AsLvp8cJ447WFGaA@mail.gmail.com>
In-Reply-To: <CALu+AoTGY0wKubVgR_EF5BZmYvh180fjP1AsLvp8cJ447WFGaA@mail.gmail.com>
From: Lichen Liu <lichliu@redhat.com>
Date: Fri, 8 Aug 2025 11:36:42 +0800
X-Gm-Features: Ac12FXwg4eabeUdRCinwQOjZemEW_hV9jM2hO2Z7nLNQw6zNDks5tnGEToJNyYA
Message-ID: <CAPmSd0OQfSHBqDSpFLNAddk-f_aDcjzKt_VBzLWjNqvMAXgzkQ@mail.gmail.com>
Subject: Re: [PATCH] fs: Add 'rootfsflags' to set rootfs mount options
To: Dave Young <dyoung@redhat.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, rob@landley.net, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	weilongchen@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 10:46=E2=80=AFAM Dave Young <dyoung@redhat.com> wrot=
e:
>
> On Fri, 8 Aug 2025 at 10:30, Dave Young <dyoung@redhat.com> wrote:
> >
> > Hi Lichen,
> >
> > On Fri, 8 Aug 2025 at 09:55, Lichen Liu <lichliu@redhat.com> wrote:
> > >
> > > When CONFIG_TMPFS is enabled, the initial root filesystem is a tmpfs.
> > > By default, a tmpfs mount is limited to using 50% of the available RA=
M
> > > for its content. This can be problematic in memory-constrained
> > > environments, particularly during a kdump capture.
> > >
> > > In a kdump scenario, the capture kernel boots with a limited amount o=
f
> > > memory specified by the 'crashkernel' parameter. If the initramfs is
> > > large, it may fail to unpack into the tmpfs rootfs due to insufficien=
t
> > > space. This is because to get X MB of usable space in tmpfs, 2*X MB o=
f
> > > memory must be available for the mount. This leads to an OOM failure
> > > during the early boot process, preventing a successful crash dump.
> > >
> > > This patch introduces a new kernel command-line parameter, rootfsflag=
s,
> > > which allows passing specific mount options directly to the rootfs wh=
en
> > > it is first mounted. This gives users control over the rootfs behavio=
r.
> > >
> > > For example, a user can now specify rootfsflags=3Dsize=3D75% to allow=
 the
> > > tmpfs to use up to 75% of the available memory. This can significantl=
y
> > > reduce the memory pressure for kdump.
> > >
> > > Consider a practical example:
> > >
> > > To unpack a 48MB initramfs, the tmpfs needs 48MB of usable space. Wit=
h
> > > the default 50% limit, this requires a memory pool of 96MB to be
> > > available for the tmpfs mount. The total memory requirement is theref=
ore
> > > approximately: 16MB (vmlinuz) + 48MB (loaded initramfs) + 48MB (unpac=
ked
> > > kernel) + 96MB (for tmpfs) + 12MB (runtime overhead) =E2=89=88 220MB.
> > >
> > > By using rootfsflags=3Dsize=3D75%, the memory pool required for the 4=
8MB
> > > tmpfs is reduced to 48MB / 0.75 =3D 64MB. This reduces the total memo=
ry
> > > requirement by 32MB (96MB - 64MB), allowing the kdump to succeed with=
 a
> > > smaller crashkernel size, such as 192MB.
> > >
> > > An alternative approach of reusing the existing rootflags parameter w=
as
> > > considered. However, a new, dedicated rootfsflags parameter was chose=
n
> > > to avoid altering the current behavior of rootflags (which applies to
> > > the final root filesystem) and to prevent any potential regressions.
> > >
> > > This approach is inspired by prior discussions and patches on the top=
ic.
> > > Ref: https://www.lightofdawn.org/blog/?viewDetailed=3D00128
> > > Ref: https://landley.net/notes-2015.html#01-01-2015
> > > Ref: https://lkml.org/lkml/2021/6/29/783
> > > Ref: https://www.kernel.org/doc/html/latest/filesystems/ramfs-rootfs-=
initramfs.html#what-is-rootfs
> > >
> > > Signed-off-by: Lichen Liu <lichliu@redhat.com>
> > > ---
> > >  fs/namespace.c | 11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/namespace.c b/fs/namespace.c
> > > index ddfd4457d338..a450db31613e 100644
> > > --- a/fs/namespace.c
> > > +++ b/fs/namespace.c
> > > @@ -65,6 +65,15 @@ static int __init set_mphash_entries(char *str)
> > >  }
> > >  __setup("mphash_entries=3D", set_mphash_entries);
> > >
> > > +static char * __initdata rootfs_flags;
> > > +static int __init rootfs_flags_setup(char *str)
> > > +{
> > > +       rootfs_flags =3D str;
> >
> > I do see there are a few similar usages in init/do_mounts.c, probably
> > it is old stuff and it just works.  But I think making rootfs_flags as
> > an array and copying str into it is the right way.
Hi Dave, thanks for your comments!

I will check how to make it better.

>
> Another question, may need fs people to clarify.  If the mount is
> tmpfs and it is also rootfs,  could it use 100% of the memory by
> default, and then no need for an extra param?    I feel that there is
> no point to reserve memory if it is a fully memory based file system.
>

I think rootfstype=3Dramfs will use 100% of the memory.
For kdump only, there might not be much difference between using ramfs
and tmpfs size=3D100%. But I think it might provide more flexibility
since rootfstype=3D and rootflags=3D can be used with root=3D.

https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html

> >
> > > +       return 1;
> > > +}
> > > +
> > > +__setup("rootfsflags=3D", rootfs_flags_setup);
> > > +
> > >  static u64 event;
> > >  static DEFINE_XARRAY_FLAGS(mnt_id_xa, XA_FLAGS_ALLOC);
> > >  static DEFINE_IDA(mnt_group_ida);
> > > @@ -6086,7 +6095,7 @@ static void __init init_mount_tree(void)
> > >         struct mnt_namespace *ns;
> > >         struct path root;
> > >
> > > -       mnt =3D vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", NULL);
> > > +       mnt =3D vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", rootfs_f=
lags);
> > >         if (IS_ERR(mnt))
> > >                 panic("Can't create rootfs");
> > >
> > > --
> > > 2.50.1
> > >
> > >
> > Thanks
> > Dave
>


