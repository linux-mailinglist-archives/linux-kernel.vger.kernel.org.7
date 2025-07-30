Return-Path: <linux-kernel+bounces-750877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FFAB1622B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3A01AA0BA4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2492D97AA;
	Wed, 30 Jul 2025 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K8/YoZQU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE0C2D94B3
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753884137; cv=none; b=IhE/WJ4ypkuh0CWRayEE9F7ZuROwc5SZ7sfbiVqG+ZC1jkKChTZbJ3fsW8DPyD82ArYtvB9yhUG4ppfVslgwNBWfUtmIUrujoee6sGYQnAL2bJB7+gfdc0sJB3SDEWLbvpQe0mneDvLyKgz9vmqWdUyZ1MPj4cMCHU3H3OeN5wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753884137; c=relaxed/simple;
	bh=MmkWlN/uPwvX34CCCyRa4VBF+jL1KnRxT5B9XA2kXK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6xni8tPX2rQu3u015cLGt/I4GNFsr8hvfNvzVmhP3tQzEqds4yuHavuwA7VpwLTFHXTZjSkC1BhkSd7+MndflSS2b29yiuf2wPJvAETiONV6Ls63zxle1/iD0f3+akMwocmZRpz6ThJUJxo7CNEIlzghllzmhzXJD/mpKzOuoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K8/YoZQU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753884134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ackfB6DBPYTuoV1XtuNoLny2V63xhrT1Odsd3+ASSwA=;
	b=K8/YoZQUwK98Eyf7/7EClafHIdnbbwXB6ssltf7iShvGhXpLM70dxPh32YzaEPO169h7ap
	e0p1NPt5nR0HeP2HfgoY8TTI95zDK0PSB230eiFaSHY35J6e3WxHktDztvu0wQ9UlysS7n
	i4BRXYqO6YLAWm/WPhuvvcpvCSySMmc=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-2SDycXr_PKSUsF1VI20miA-1; Wed, 30 Jul 2025 10:02:10 -0400
X-MC-Unique: 2SDycXr_PKSUsF1VI20miA-1
X-Mimecast-MFC-AGG-ID: 2SDycXr_PKSUsF1VI20miA_1753884129
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-88bc4927af4so1242392241.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753884129; x=1754488929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ackfB6DBPYTuoV1XtuNoLny2V63xhrT1Odsd3+ASSwA=;
        b=Xi8kd1Yvu0/7Dvuxf22nmHFLdgZ521xoTGEmjagV5R4UHp69cCxJsFPvYXKiu1Sifc
         8d4AwncHjTNbtyBWeVQrI6I5h8hEm+HvCqYujJ0Ppm/B0yYbC53d8PQYIuvaZDuj6eWy
         7ED0LMgbEnkCx7XBjLIQvwS+KipeqzMw1SxidLuFhn16w72ojaQgfNX1xUUJDDd8AYZ6
         HeD7N+MylzheKW8utAXeFbWKUa4YAShCAK91hLG8ap1c/mVJz5LO+cXYjntU6+uG35Lh
         DGDJLjO5X8H2b+NZpACC6+kPgsZHiOBmy3x1/m8U9+2Iwc4mBFsx1ysRl9eYh/7mgugA
         Negw==
X-Forwarded-Encrypted: i=1; AJvYcCUD3/1+tA1Sq4lu9gdcDIXeDLdfFJMbgDYzcEcVDaEJWuiZENcKI0hZczoOubeNJA2zjTZWD6dx7L/xhZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+xzj0mWAffZOmH9CSG+DitnVdA3Y+DKtHMq+yIH8TQfTPFwcF
	Ttvpeby+P3vmml+ngQrgR0NRtLGYWLJQVxoqzyoeF3KCAfE8J4ryymUgMyrXIdRFpxBpbNESLaI
	Gg24MELntCsRSt2Qh+Jubt3NgMqDwlzj+GCbGWUqu2RWORrUVIOIHPn1tIPZw93Neb6UfT6g1Fq
	CwXwx+LcimMd1jPxStn6lHPyYHnV30xqozqUbc/rMK
X-Gm-Gg: ASbGncsDWgXNGgOf3ZV+SL6l4Q0HkrnMr9hP0B02LbSeVi3QxgWEEg1NBZF+x83vbRy
	C67fdiJMnwvCnCTGVgwymUX96qme3+JcXI+f6XP08HVq2NjBxPCjcLv3BagdMPozWLEgqk1KgSf
	x4PEAQL5Q8jDiuSZPBncoedik32kUO7jfCLu3h9HU=
X-Received: by 2002:a05:6122:134b:b0:531:2afc:463e with SMTP id 71dfb90a1353d-5391ceddb5emr2222497e0c.5.1753884128401;
        Wed, 30 Jul 2025 07:02:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9UpaCXloiF2L0Silo5dn/s3hztkBPLD/RFiad9HfOmHHxQjje001bqm1t58UA/YewleWPgB++VzGP1inIlZ0=
X-Received: by 2002:a05:6122:134b:b0:531:2afc:463e with SMTP id
 71dfb90a1353d-5391ceddb5emr2222394e0c.5.1753884127764; Wed, 30 Jul 2025
 07:02:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730094123.30540-1-sunzhao03@kuaishou.com> <CAO8a2SioQ+iUgoC8+NiMkWS6Wj=2YwV7k9LWp5bfx2ZxpWJU+w@mail.gmail.com>
In-Reply-To: <CAO8a2SioQ+iUgoC8+NiMkWS6Wj=2YwV7k9LWp5bfx2ZxpWJU+w@mail.gmail.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Wed, 30 Jul 2025 18:01:56 +0400
X-Gm-Features: Ac12FXzmTccQXfizTPDEWz3XPMI0l4wu5M0WeJiqaXrq3_ESpkFyuaoYUj772T4
Message-ID: <CAO8a2Si4B3AqgfmD4-ngsSv0W-7fn_-Qm46SR4uQQ2ciUX3q2A@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix deadlock in ceph_readdir_prepopulate
To: Zhao Sun <sunzhao03@kuaishou.com>
Cc: xiubli@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've taken another look, there is a much bigger issue here I'm not
entirely convinced its safe to release and re-acquire the lock:

The original design ensures that all snap context operations, both
reading and writing, happen under the same lock, guaranteeing
consistency. The patch breaks this invariant by creating a window
where snap contexts can change between the inode creation and the
subsequent ceph_fill_inode call.
Bottom line: The patch trades deadlock prevention for potential snap
context inconsistency, which could lead to data corruption or
incorrect file visibility in snapshots.

On Wed, Jul 30, 2025 at 4:45=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> =
wrote:
>
> Hi,
>
> The patch correctly identifies and addresses the deadlock by releasing
> snap_rwsem before the blocking ceph_get_inode call.
>
> My Recommendation:
>
> Use down_read_killable: The current patch uses
> down_read(&mdsc->snap_rwsem) after calling ceph_get_inode.
> This is problematic because down_read is uninterruptible. If a signal
> (like SIGKILL or Ctrl+C) is sent to the process while it's waiting to
> re-acquire the snap_rwsem read lock (e.g., if another thread holds the
> write lock), the process will hang indefinitely and cannot be killed.
> Using down_read_killable(&mdsc->snap_rwsem) instead allows the lock
> acquisition to be interrupted by signals. If it fails (returns
> -EINTR), the error must be handled properly (e.g., release the inode
> reference obtained from ceph_get_inode and propagate the error) to
> ensure the process remains killable and doesn't hang.
>
> This change is essential to prevent potential system hangs.
>
> Best regards,
>
> On Wed, Jul 30, 2025 at 1:49=E2=80=AFPM Zhao Sun <sunzhao03@kuaishou.com>=
 wrote:
> >
> > When ceph_readdir_prepopulate calls ceph_get_inode while holding
> > mdsc->snap_rwsem, a deadlock may occur, blocking all subsequent
> > requests of the current session.
> >
> > Fix by release the mds->snap_rwsem read lock before calling the
> > ceph_get_inode function.
> >
> > Link: https://tracker.ceph.com/issues/72307
> > Signed-off-by: Zhao Sun <sunzhao03@kuaishou.com>
> > ---
> >  fs/ceph/inode.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> > index 06cd2963e41e..3d7fb045ba76 100644
> > --- a/fs/ceph/inode.c
> > +++ b/fs/ceph/inode.c
> > @@ -1900,6 +1900,7 @@ static int fill_readdir_cache(struct inode *dir, =
struct dentry *dn,
> >  int ceph_readdir_prepopulate(struct ceph_mds_request *req,
> >                              struct ceph_mds_session *session)
> >  {
> > +       struct ceph_mds_client *mdsc =3D session->s_mdsc;
> >         struct dentry *parent =3D req->r_dentry;
> >         struct inode *inode =3D d_inode(parent);
> >         struct ceph_inode_info *ci =3D ceph_inode(inode);
> > @@ -2029,7 +2030,10 @@ int ceph_readdir_prepopulate(struct ceph_mds_req=
uest *req,
> >                 if (d_really_is_positive(dn)) {
> >                         in =3D d_inode(dn);
> >                 } else {
> > +                       /* Release mdsc->snap_rwsem in advance to avoid=
 deadlock */
> > +                       up_read(&mdsc->snap_rwsem);
> >                         in =3D ceph_get_inode(parent->d_sb, tvino, NULL=
);
> > +                       down_read(&mdsc->snap_rwsem);
> >                         if (IS_ERR(in)) {
> >                                 doutc(cl, "new_inode badness\n");
> >                                 d_drop(dn);
> > --
> > 2.39.2 (Apple Git-143)
> >
> >


