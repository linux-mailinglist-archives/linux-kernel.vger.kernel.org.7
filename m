Return-Path: <linux-kernel+bounces-827899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4917FB9361F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 042763B4C1E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5182B2BEC3F;
	Mon, 22 Sep 2025 21:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dtCN+pEV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFFB288D0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 21:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758576960; cv=none; b=KGh4LYX7g4AgKzO3QKot5Qfa2ztKtw0i389G4WehioyU1wyZ87v1h1A0WWkLO0rgn7F9i3acslV7j2JIlbuqkU8gdV+mLoAhofwvuNxXXj1VqPmQ5iZWizKwssBtloU5C/q9fztMZxQQCiObR0IKWVxcQkmKEKmJwNnzaHJuBF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758576960; c=relaxed/simple;
	bh=VbyGb0ADaJP1LnboWK9/Ki5sqHZlnzSV2T4UXWHw9/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BPd5GX7OYrSGQno54DcFONrb9qNW3wal+4VdgT+7r9DvHdMlPVwKs7rzThkWlLF8lg/E8kmk3lE4V+xowwYG5IY8B+Lf1SrjIjKmh/ot0/OSGR1P7gcaWkZk1vA36SY3BAsnlQvWcnDpkzVCXn4NTfKsgv4cg1oQH8iv2cb+W/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dtCN+pEV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758576957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1RPEUkun/q94eBr285fzSBnT9trDj+RI+RBAslAHtYU=;
	b=dtCN+pEVgdC2FcWB18fgAhRDP/9h4wfnJWO8jlZof3i7vUqVd1pLTGIFWnb4ASmxOG+Z5T
	q0NrdCQ3WIfuWxPi6VAB0VBuiL3hjqMelL+IcjKrNZi7xH9Pd1j6eSlT6pJQHc7Q2QcGZi
	2knJboyN1ytDkzgeflJlOVZUvGoChIo=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-YbUyHKT1MvqyQ9uTyH7I3Q-1; Mon, 22 Sep 2025 17:35:56 -0400
X-MC-Unique: YbUyHKT1MvqyQ9uTyH7I3Q-1
X-Mimecast-MFC-AGG-ID: YbUyHKT1MvqyQ9uTyH7I3Q_1758576954
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-267fa90a2fbso66800835ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758576954; x=1759181754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1RPEUkun/q94eBr285fzSBnT9trDj+RI+RBAslAHtYU=;
        b=Eg9JUEqvE7Bjy9iW59zTvLnD6E1aIZLJWPid3HXID0T8J+iv+Tf586khquwodEUQe5
         2836oAFtTbtjKCeW1PwDMTpPwmBOkQGJBvXMlcRDg92MgkVn0dL658c60f31DEIytx5c
         h9lcj/JXbzRmmr8nb7UmPgcs1UBHwdVQNZwdBeKcdteN0AV4z+XX1NU/bOQxbGBLsIPZ
         OnAOGx1zKuUfxkaPssz/YZELDYIwuOfvg9wZ92SFe0KnKX6ynkw0T+m3e4Xz50CkAK1Q
         d1J3Quhg3kezrgPwg8wZCRrv81S4a0fqfbWBO/QqL77tGjwX/ftDEawRLDhx1dSaiiyU
         CkDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWaD3sa10cX7W+Lo7hxEChNPueD400hxGZiE0V4Tm3zQK+Wz0o5t5iCo8vqBhttbr28EeLyr5YjBZOUds=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTOyfveMny6FvbAsiqJW9Nke0u9RhF07gUAuhT+JyzyKRQzpF1
	1eZ60Q0OIC5vRDxl+rcv/zy6TMYUfSHjFdU4l+eP1eeHWBjcRmMzXmIV7UblzMX76tE+TnbP7pD
	xLi9QH739eXaXY9Eo+lNcZnqdpX8NdF3QCDa8VcYbpEBoWvoJ2WcYerFSYr5p2cgs5GtmI8w33T
	ghxVjbRpPwKsrlERUQOangmqEI90LXEq276aXXjoF674cdl7M8
X-Gm-Gg: ASbGncsXiTjHqANe029UXwar0L3+wQjppS9WnlEt7YQ0ivpuNzgFCQh1XIXatiYFMsH
	MvWY9r/lqScIlprFcRDcoQo516D/zkqJALYrbBwaQ9FqpAzeSxhbjq3Nuffw5JGlTlJkQBAwYaB
	5z1/qiuaCxEtXgnpE1+Ac=
X-Received: by 2002:a17:903:11c9:b0:271:9b0e:54c7 with SMTP id d9443c01a7336-27cd783aaddmr2162535ad.11.1758576954179;
        Mon, 22 Sep 2025 14:35:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxbJnNy7LS1zhaed02+B0QANrc9D8VB3JxCVwMOEf2ETpnZsqXiVqB5gnwqCQu5ljt0HxTySAOL9QwmgCJxbc=
X-Received: by 2002:a17:903:11c9:b0:271:9b0e:54c7 with SMTP id
 d9443c01a7336-27cd783aaddmr2162305ad.11.1758576953749; Mon, 22 Sep 2025
 14:35:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922175237.37474-1-utkarsh.singh.em@gmail.com>
In-Reply-To: <20250922175237.37474-1-utkarsh.singh.em@gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 22 Sep 2025 23:35:42 +0200
X-Gm-Features: AS18NWBRPoK2cK1D6IHxCDq1KCuIosAbx4R9u3PG5dUF71-5tH5KkSxGfyVxq4o
Message-ID: <CAHc6FU5C3n2wyO91gcDVLGr643d1Y5e4xPmM1d9rw18A=fod9g@mail.gmail.com>
Subject: Re: [PATCH v2] gfs2/sysfs: Replace sprintf/snprintf with sysfs_emit()
To: Utkarsh Singh <utkarsh.singh.em@gmail.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, rpeterso@redhat.com, david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 7:53=E2=80=AFPM Utkarsh Singh
<utkarsh.singh.em@gmail.com> wrote:
> Documentation/filesystems/sysfs.rst mentions that show() should only
> use sysfs_emit() or sysfs_emit_at() when formatting values returned
> to user space. This patch updates the GFS2 sysfs interface accordingly.
>
> It replaces uses of sprintf() and snprintf() in all *_show() functions
> with sysfs_emit() to align with current kernel sysfs API best practices.

I've applied that part. I'm not pushing this into the upcoming merge
window anymore, though.

> It also updates the GFS2_SHOW_UINT macro to use sysfs_emit() instead
> of snprintf().

Huh, what's that?

> Signed-off-by: Utkarsh Singh <utkarsh.singh.em@gmail.com>
> ---
>  v1 --> v2: Code style cleanup and maintainer updates
>
>  fs/gfs2/sys.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
> index c3c8842920d2..487fff098465 100644
> --- a/fs/gfs2/sys.c
> +++ b/fs/gfs2/sys.c
> @@ -59,7 +59,7 @@ static struct kset *gfs2_kset;
>
>  static ssize_t id_show(struct gfs2_sbd *sdp, char *buf)
>  {
> -       return snprintf(buf, PAGE_SIZE, "%u:%u\n",
> +       return sysfs_emit(buf, "%u:%u\n",
>                         MAJOR(sdp->sd_vfs->s_dev), MINOR(sdp->sd_vfs->s_d=
ev));
>  }
>
> @@ -68,7 +68,7 @@ static ssize_t status_show(struct gfs2_sbd *sdp, char *=
buf)
>         unsigned long f =3D sdp->sd_flags;
>         ssize_t s;
>
> -       s =3D snprintf(buf, PAGE_SIZE,
> +       s =3D sysfs_emit(buf,
>                      "Journal Checked:          %d\n"
>                      "Journal Live:             %d\n"
>                      "Journal ID:               %d\n"
> @@ -140,7 +140,7 @@ static ssize_t status_show(struct gfs2_sbd *sdp, char=
 *buf)
>
>  static ssize_t fsname_show(struct gfs2_sbd *sdp, char *buf)
>  {
> -       return snprintf(buf, PAGE_SIZE, "%s\n", sdp->sd_fsname);
> +       return sysfs_emit(buf, "%s\n", sdp->sd_fsname);
>  }
>
>  static ssize_t uuid_show(struct gfs2_sbd *sdp, char *buf)
> @@ -150,7 +150,7 @@ static ssize_t uuid_show(struct gfs2_sbd *sdp, char *=
buf)
>         buf[0] =3D '\0';
>         if (uuid_is_null(&s->s_uuid))
>                 return 0;
> -       return snprintf(buf, PAGE_SIZE, "%pUB\n", &s->s_uuid);
> +       return sysfs_emit(buf, "%pUB\n", &s->s_uuid);
>  }
>
>  static ssize_t freeze_show(struct gfs2_sbd *sdp, char *buf)
> @@ -158,7 +158,7 @@ static ssize_t freeze_show(struct gfs2_sbd *sdp, char=
 *buf)
>         struct super_block *sb =3D sdp->sd_vfs;
>         int frozen =3D (sb->s_writers.frozen =3D=3D SB_UNFROZEN) ? 0 : 1;
>
> -       return snprintf(buf, PAGE_SIZE, "%d\n", frozen);
> +       return sysfs_emit(buf, "%d\n", frozen);
>  }
>
>  static ssize_t freeze_store(struct gfs2_sbd *sdp, const char *buf, size_=
t len)
> @@ -194,7 +194,7 @@ static ssize_t freeze_store(struct gfs2_sbd *sdp, con=
st char *buf, size_t len)
>  static ssize_t withdraw_show(struct gfs2_sbd *sdp, char *buf)
>  {
>         unsigned int b =3D gfs2_withdrawing_or_withdrawn(sdp);
> -       return snprintf(buf, PAGE_SIZE, "%u\n", b);
> +       return sysfs_emit(buf, "%u\n", b);
>  }
>
>  static ssize_t withdraw_store(struct gfs2_sbd *sdp, const char *buf, siz=
e_t len)
> @@ -397,7 +397,7 @@ static struct kobj_type gfs2_ktype =3D {
>  static ssize_t proto_name_show(struct gfs2_sbd *sdp, char *buf)
>  {
>         const struct lm_lockops *ops =3D sdp->sd_lockstruct.ls_ops;
> -       return sprintf(buf, "%s\n", ops->lm_proto_name);
> +       return sysfs_emit(buf, "%s\n", ops->lm_proto_name);
>  }
>
>  static ssize_t block_show(struct gfs2_sbd *sdp, char *buf)
> @@ -408,7 +408,7 @@ static ssize_t block_show(struct gfs2_sbd *sdp, char =
*buf)
>
>         if (test_bit(DFL_BLOCK_LOCKS, &ls->ls_recover_flags))
>                 val =3D 1;
> -       ret =3D sprintf(buf, "%d\n", val);
> +       ret =3D sysfs_emit(buf, "%d\n", val);
>         return ret;
>  }
>
> @@ -437,7 +437,7 @@ static ssize_t wdack_show(struct gfs2_sbd *sdp, char =
*buf)
>  {
>         int val =3D completion_done(&sdp->sd_wdack) ? 1 : 0;
>
> -       return sprintf(buf, "%d\n", val);
> +       return sysfs_emit(buf, "%d\n", val);
>  }
>
>  static ssize_t wdack_store(struct gfs2_sbd *sdp, const char *buf, size_t=
 len)
> @@ -459,7 +459,7 @@ static ssize_t wdack_store(struct gfs2_sbd *sdp, cons=
t char *buf, size_t len)
>  static ssize_t lkfirst_show(struct gfs2_sbd *sdp, char *buf)
>  {
>         struct lm_lockstruct *ls =3D &sdp->sd_lockstruct;
> -       return sprintf(buf, "%d\n", ls->ls_first);
> +       return sysfs_emit(buf, "%d\n", ls->ls_first);
>  }
>
>  static ssize_t lkfirst_store(struct gfs2_sbd *sdp, const char *buf, size=
_t len)
> @@ -492,7 +492,7 @@ static ssize_t lkfirst_store(struct gfs2_sbd *sdp, co=
nst char *buf, size_t len)
>  static ssize_t first_done_show(struct gfs2_sbd *sdp, char *buf)
>  {
>         struct lm_lockstruct *ls =3D &sdp->sd_lockstruct;
> -       return sprintf(buf, "%d\n", !!test_bit(DFL_FIRST_MOUNT_DONE, &ls-=
>ls_recover_flags));
> +       return sysfs_emit(buf, "%d\n", !!test_bit(DFL_FIRST_MOUNT_DONE, &=
ls->ls_recover_flags));
>  }
>
>  int gfs2_recover_set(struct gfs2_sbd *sdp, unsigned jid)
> @@ -550,18 +550,18 @@ static ssize_t recover_store(struct gfs2_sbd *sdp, =
const char *buf, size_t len)
>  static ssize_t recover_done_show(struct gfs2_sbd *sdp, char *buf)
>  {
>         struct lm_lockstruct *ls =3D &sdp->sd_lockstruct;
> -       return sprintf(buf, "%d\n", ls->ls_recover_jid_done);
> +       return sysfs_emit(buf, "%d\n", ls->ls_recover_jid_done);
>  }
>
>  static ssize_t recover_status_show(struct gfs2_sbd *sdp, char *buf)
>  {
>         struct lm_lockstruct *ls =3D &sdp->sd_lockstruct;
> -       return sprintf(buf, "%d\n", ls->ls_recover_jid_status);
> +       return sysfs_emit(buf, "%d\n", ls->ls_recover_jid_status);
>  }
>
>  static ssize_t jid_show(struct gfs2_sbd *sdp, char *buf)
>  {
> -       return sprintf(buf, "%d\n", sdp->sd_lockstruct.ls_jid);
> +       return sysfs_emit(buf, "%d\n", sdp->sd_lockstruct.ls_jid);
>  }
>
>  static ssize_t jid_store(struct gfs2_sbd *sdp, const char *buf, size_t l=
en)
> @@ -626,7 +626,7 @@ static struct attribute *lock_module_attrs[] =3D {
>
>  static ssize_t quota_scale_show(struct gfs2_sbd *sdp, char *buf)
>  {
> -       return snprintf(buf, PAGE_SIZE, "%u %u\n",
> +       return sysfs_emit(buf, "%u %u\n",
>                         sdp->sd_tune.gt_quota_scale_num,
>                         sdp->sd_tune.gt_quota_scale_den);
>  }
> @@ -679,7 +679,7 @@ static struct gfs2_attr tune_attr_##name =3D __ATTR(n=
ame, 0644, show, store)
>  #define TUNE_ATTR_2(name, store)                                        =
      \
>  static ssize_t name##_show(struct gfs2_sbd *sdp, char *buf)             =
      \
>  {                                                                       =
      \
> -       return snprintf(buf, PAGE_SIZE, "%u\n", sdp->sd_tune.gt_##name); =
     \
> +       return sysfs_emit(buf, "%u\n", sdp->sd_tune.gt_##name);          =
     \
>  }                                                                       =
      \
>  TUNE_ATTR_3(name, name##_show, store)
>
> --
> 2.43.0
>

Thanks,
Andreas


