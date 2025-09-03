Return-Path: <linux-kernel+bounces-797995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B548EB41825
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB273A485E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4862E229E;
	Wed,  3 Sep 2025 08:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U9A+NcCu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A682EA46F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756887295; cv=none; b=j7VYqVk1RFPp8GZVN/BV/ivX6nE3RFf0OBRVYsabXJdMBXBnjphcxrum73vrxK2i2t4HGbmgxHQ8PijBu7nm8GYRatmLekRA1vvNZ4tEOaulGmT+8B1C1Y+zZmIIdp39yJ7yDMTImHskm7ZmjvNsCkitFmUy59RvrTlZuXDvwOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756887295; c=relaxed/simple;
	bh=QShg1gyJSv43yzcbluqIEbZ0LqjCYuvigw/kWWKPQSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2s5ZrQUlSnlHRqPMjIQcAS4MJPq84wB+FszKD9BohcLDka3bs8KeUI6cmrwVasNRwvld4OtoqPAFCRZbbaoYRVMMDUgn6LX1CrnBz4nmm2TTn6pVWDIsW0S2160hCdcsBPcj2RiNE8gi+zzWyrDmiBN5jUCI//Z8UteLWiNTio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U9A+NcCu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756887291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kmrZS7szWXEtGTN5BlNSaGdOgx0Rgy5JbXAqnKtXuXc=;
	b=U9A+NcCueMt1ewK+ksp8tOHo+D65y3ORWkokcAxmBSEaKP3exmIZ4f6tRona5uNLoUWW5Z
	4zXFreaMzTP7azRT9wM7YoWzkFMY28+DxG7yHH1rveW6nH7xzK26+8wMcbIeYxaFkEXoSO
	oIZnJ6hJrk5mgbZ9ibnjdnAFVv5LgOM=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-TGhBk1PrNluRVH8bWCv4qg-1; Wed, 03 Sep 2025 04:14:50 -0400
X-MC-Unique: TGhBk1PrNluRVH8bWCv4qg-1
X-Mimecast-MFC-AGG-ID: TGhBk1PrNluRVH8bWCv4qg_1756887290
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-544b20274deso1050216e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 01:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756887290; x=1757492090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmrZS7szWXEtGTN5BlNSaGdOgx0Rgy5JbXAqnKtXuXc=;
        b=eww/5fb8O9YeN3ZLzGIYfHz00qOiomVe99ix6AlecvWXvTL4NPATGWsyImpoQ5apPg
         Vml2IQMaBKlBJaIWf+xJ4O4Y7v8I+TucYrtNpjh5WSri+dnBYMnWVPzn1e5Fqqtgty29
         +OcdD+1W3VrANUenAgG9uPMDa/YBLikf/jIO+fPQGc3HZlvhnA+hp2Gc4c+5iqIqDsbe
         oIqBRFNgbqO7f+6bM9qlCi+3HBtN246ZNcSoFkmo6eJl12VDMXBDMqlyvVVrpA7cP0Hz
         fqNMG2ULuz6xTp8lZR2OKhuT+6685gD9ZhyAEnJ1gZLRVcP52lOGnxANajCC3mAyX9Nu
         6iQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI3M7RyUMqAE6pbZPqI7AmCoaCW/U2gHmDkYWWDCh5ABX5vBi0+e4F/eP/5r6lgXP76XpI2gY09OTqP2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp1asgmUD1Gd6o67qMOFPKjLUcT+4Pv2P9HvOAMinWoMz5lCna
	jR33dVp5kgj77wtAI5GDpl6sNvyYqw9coSkUOlSEqSMG4Dmh5m1Vo1+itRsKvBLxqbn0giQkTs+
	fYi8/Jzd4i6slFN6r9dp491GDPYtneP1q2d6rwHU1GmLHIdBDMAH8eQ3fViKzPy0DyZQbqW0t2I
	XqrlH2esJEjSqzs9QgzadCmQZJ3P8YbLUDbCE7fE05WZBrCk6vC7+XgRm3
X-Gm-Gg: ASbGnctrp1c5X9YUeEWM4LfGUdLXtWyVoPbYOYdoZwyZwwD2sq3ATncHaVKtgckZ6+D
	rZLwNyRj38APkhprqCb/77PZBYIztguTBFo2ljL7uXq2u2VWBZ+vWcEfzOfaitpcv1dORAaNaPZ
	IetClCfdqiXqpyIVKMTyim9RfSEd1sV+hltYawHgoM
X-Received: by 2002:a67:e7c6:0:b0:529:1815:ae8f with SMTP id ada2fe7eead31-52b166d9937mr5270372137.0.1756887289858;
        Wed, 03 Sep 2025 01:14:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQg9pi7C2VramjgfkXnAX50/+g90JKvUcAxrQbtvQg2VVl8u990/10NaxBGQrpeJL/cCEIpYkv0+PLhUfXMeI=
X-Received: by 2002:a67:e7c6:0:b0:529:1815:ae8f with SMTP id
 ada2fe7eead31-52b166d9937mr5270363137.0.1756887289503; Wed, 03 Sep 2025
 01:14:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901151448.726098-1-amarkuze@redhat.com> <ae2a652559e30aaea925fc2dfe28602f7216f5b0.camel@ibm.com>
In-Reply-To: <ae2a652559e30aaea925fc2dfe28602f7216f5b0.camel@ibm.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Wed, 3 Sep 2025 11:14:38 +0300
X-Gm-Features: Ac12FXylN-Nms0FwMK6dE6U4rKE-xYDe_pQHkFHWdc8MAtTSxgYQ-WKL47AQM84
Message-ID: <CAO8a2ShM3yar0g83z=aC9VLuPz5bEpBAN8FxRqEqQfSnkgZGUw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ceph/mds_client: transfer CEPH_CAP_PIN when updating
 r_parent on mismatch
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "idryomov@gmail.com" <idryomov@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

These patches apply to the testing branch. They update the r_parent race fi=
x.

commit a69ac54928a45ad66b6ba84f9bd4be2fd0f9518e
Author: Alex Markuze <amarkuze@redhat.com>
Date:   Tue Aug 12 09:57:39 2025 +0000

    ceph: fix race condition where r_parent becomes stale before sending me=
ssage

    When the parent directory's i_rwsem is not locked, req->r_parent may be=
come
    stale due to concurrent operations (e.g. rename) between dentry lookup =
and
    message creation. Validate that r_parent matches the encoded parent ino=
de
    and update to the correct inode if a mismatch is detected.

    Signed-off-by: Alex Markuze <amarkuze@redhat.com>
    Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
    Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

commit 7128e41a490709c759fde32898eade197acd0978
Author: Alex Markuze <amarkuze@redhat.com>
Date:   Tue Aug 12 09:57:38 2025 +0000

    ceph: fix race condition validating r_parent before applying state

    Add validation to ensure the cached parent directory inode matches the
    directory info in MDS replies. This prevents client-side race condition=
s
    where concurrent operations (e.g. rename) cause r_parent to become stal=
e
    between request initiation and reply processing, which could lead to
    applying state changes to incorrect directory inodes.

    Signed-off-by: Alex Markuze <amarkuze@redhat.com>
    Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
    Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

On Tue, Sep 2, 2025 at 9:42=E2=80=AFPM Viacheslav Dubeyko <Slava.Dubeyko@ib=
m.com> wrote:
>
> On Mon, 2025-09-01 at 15:14 +0000, Alex Markuze wrote:
> > When the parent directory lock is not held, req->r_parent can become st=
ale between dentry lookup and request encoding.
> > The client updates r_parent to the correct inode based on the encoded p=
ath, but previously did not adjust CEPH_CAP_PIN references.
> >
> > Release the pin from the old parent and acquire it for the new parent w=
hen switching r_parent, ensuring reference accounting stays balanced and av=
oiding leaks or underflows later in ceph_mdsc_release_request().
> >
>
> I cannot apply the patch on current state of the kernel. I assume that th=
is
> patch is improvement of previous patch set. If so, then it will be better=
 to
> send another version of previous patch set. Otherwise, it's hard to revie=
w and
> impossible to test it.
>
> Thanks,
> Slava.
>
> > Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> > ---
> >  fs/ceph/mds_client.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index ce0c129f4651..4e5926f36e8d 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -3053,12 +3053,19 @@ static struct ceph_msg *create_request_message(=
struct ceph_mds_session *session,
> >        */
> >       if (!parent_locked && req->r_parent && path_info1.vino.ino &&
> >           ceph_ino(req->r_parent) !=3D path_info1.vino.ino) {
> > +             struct inode *old_parent =3D req->r_parent;
> >               struct inode *correct_dir =3D ceph_get_inode(mdsc->fsc->s=
b, path_info1.vino, NULL);
> >               if (!IS_ERR(correct_dir)) {
> >                       WARN_ONCE(1, "ceph: r_parent mismatch (had %llx w=
anted %llx) - updating\n",
> > -                               ceph_ino(req->r_parent), path_info1.vin=
o.ino);
> > -                     iput(req->r_parent);
> > +                               ceph_ino(old_parent), path_info1.vino.i=
no);
> > +                     /*
> > +                      * Transfer CEPH_CAP_PIN from the old parent to t=
he new one.
> > +                      * The pin was taken earlier in ceph_mdsc_submit_=
request().
> > +                      */
> > +                     ceph_put_cap_refs(ceph_inode(old_parent), CEPH_CA=
P_PIN);
> > +                     iput(old_parent);
> >                       req->r_parent =3D correct_dir;
> > +                     ceph_get_cap_refs(ceph_inode(req->r_parent), CEPH=
_CAP_PIN);
> >               }
> >       }
> >


