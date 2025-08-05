Return-Path: <linux-kernel+bounces-756387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 772D8B1B362
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312293A6924
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5CF26D4DD;
	Tue,  5 Aug 2025 12:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E0NVDGqP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FE413E02D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 12:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754396925; cv=none; b=ZhpmLHrC2fTrY7VYx4AaTdyOL1f5QlQpRlC2EuRIM5eBDsrBNlqHIrWSBWK2NxeBB2TC9lwlVzGWmh1xGRRHqEPOolUAPYEpotjRo4AYMoFNuxLsX3e8kJWuJztYqKERNNKQYw7y7x26a+GdilEUtRWGwyeo69PcO3j97IwIm28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754396925; c=relaxed/simple;
	bh=asYVyDcUesUYhvQMINnDDiQBfsilf+wdaFi2gVIt9gI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eepX5bAt0C+GdN/Kw6INoroxwj9YjcdBFj57vrrU8wrnmG8b2iIAMZI/udBQTO64xKifiH95VLiZO6VoyE6iyRB6aolozSD2W/PxH7MWt9+l6hKGbXEpYCNdxcGh970ULhXjzk71c06OSoCpntgMEZD7pu7ReGek1eKCpo0fNaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E0NVDGqP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754396922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MdAzXHrmEgIxrEidw9LeN07oPIrixWYEdSsrPm4g0aA=;
	b=E0NVDGqPJKv6h9pPhoPwoa9GVELi6Cinc7gR+r6TA+nmhpd/JogIak8oaO224/+Q1Clka1
	FTCRAPgkTZmMqwACMr/GOJDwLb+wqfnfNY7wnM7rtY0hTC8fGBGMlSmJgwt6ZIhpCk8mtA
	o5QomzeAt+qAhabtedFphIy0FPwlEN4=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-dHqoqWKqMJ2DGQrNrJd4Xg-1; Tue, 05 Aug 2025 08:28:41 -0400
X-MC-Unique: dHqoqWKqMJ2DGQrNrJd4Xg-1
X-Mimecast-MFC-AGG-ID: dHqoqWKqMJ2DGQrNrJd4Xg_1754396921
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-4fc5fe7e675so1388557137.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 05:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754396921; x=1755001721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdAzXHrmEgIxrEidw9LeN07oPIrixWYEdSsrPm4g0aA=;
        b=qU+1RncNHyKaMhpUMuJoCSAUaE22Kliex2gxlrKA2KDsAEZyoTekmb6tV4BsOPvFCB
         gwYqpaA8FV/6eRkQ8KG+6Cxek8vK9Q3TCkytCl3aHw5Odw4ySdYybMFE5YfR0mf80lkB
         BvdMtrkL9cHrU27Q28fyjke5wHZ9Zf/9AcUfvwqJcL9dxCv/owENv+Kfk32kDS7DPRJv
         jZEvVx016WhrRUEzliljijQHPVU25VRxA4u6GrSKhub8UmikV/V6FPQjAHGhUiumyVBC
         rKT16p0B5jUuRCLuxs0OHqZmm5QSpNaBN3GBdEtcCTXtU/v+xa8cU4pXGOPdKs8ddRFG
         E23g==
X-Forwarded-Encrypted: i=1; AJvYcCXMiLdbfiWVSIqBjC0eLtp63+mPtOElHzDxqJpq5crtmPzE9DQEGuWUbA2WJMPoGZ0vFr9+UTIZnd7LAWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi7gCNr0zQGl+N6tnmVaTf11YVJF9gZgiTIT8MHJ67AKkLU29k
	OLhAHuVnscnnnuCzSn552O9zoTB2c7/HUAC/bhPy5RqLtrFfnIR9/G9YzeM9nR/hJCPbN91uccQ
	cqTkvxPMoGvPEoJFxzCQlj/oGKoswiV9oGdZw7qqC0jgzgBLcGfQqjFmhSKamsxPKnQ/8hsYUX5
	w3fOg4iW9wq47no+nsuw7IUAR41tJEDVs82+Vze1yU
X-Gm-Gg: ASbGncsXP3NeCVULNkTn2T5FsUzwqLLS/3RyvDJB4leEBqxHNjWEwekOE96E7HwxrDs
	rBybRqUriHYA58nOh42W6zCkcGT+HvbwM4ovVVOfhIqLKhdq7UF3bqU91ff2uzdd26or0/qXMMn
	ozd0/eJk657tNFadP/bu19Xx34KeLhnritNYiFfQ==
X-Received: by 2002:a05:6102:942:b0:4f9:69a9:4ec5 with SMTP id ada2fe7eead31-4fdc4c036b6mr5365015137.27.1754396920898;
        Tue, 05 Aug 2025 05:28:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFL0P2wXp4JQW74rzvmVlOGK27HSNIxNeZANocAUkC3Rym4vHHE9Z5Jk6QPjbtGTT3d6VxAA49+tnoEjFzUNHQ=
X-Received: by 2002:a05:6102:942:b0:4f9:69a9:4ec5 with SMTP id
 ada2fe7eead31-4fdc4c036b6mr5365008137.27.1754396920531; Tue, 05 Aug 2025
 05:28:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804095942.2167541-1-amarkuze@redhat.com> <20250804095942.2167541-3-amarkuze@redhat.com>
 <0d4ffc45c292005a65ca244b013a313f7d35e607.camel@ibm.com>
In-Reply-To: <0d4ffc45c292005a65ca244b013a313f7d35e607.camel@ibm.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Tue, 5 Aug 2025 16:28:28 +0400
X-Gm-Features: Ac12FXyH_DUahWpI0xqGQs6BOP5JU-fSqViKpkZX-hnYyF1Ju6M1j8DZrS-OxFg
Message-ID: <CAO8a2ShMmC6kRTiVmRG54xb7N8-cQe45ecJYMhOcECjPy9wvTg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ceph: fix client race condition where r_parent
 becomes stale before sending message
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "idryomov@gmail.com" <idryomov@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

That's the BUG, we are fixing here. If a mismatch happens the update
if not fixed can cause a mess. A full WARN may be an overkill I agree.

On Tue, Aug 5, 2025 at 1:58=E2=80=AFAM Viacheslav Dubeyko <Slava.Dubeyko@ib=
m.com> wrote:
>
> On Mon, 2025-08-04 at 09:59 +0000, Alex Markuze wrote:
> > When the parent directory's i_rwsem is not locked, req->r_parent may be=
come
> > stale due to concurrent operations (e.g. rename) between dentry lookup =
and
> > message creation. Validate that r_parent matches the encoded parent ino=
de
> > and update to the correct inode if a mismatch is detected.
> > ---
> >  fs/ceph/inode.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 50 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> > index 814f9e9656a0..7da648b5e901 100644
> > --- a/fs/ceph/inode.c
> > +++ b/fs/ceph/inode.c
> > @@ -56,6 +56,51 @@ static int ceph_set_ino_cb(struct inode *inode, void=
 *data)
> >       return 0;
> >  }
> >
> > +/*
> > + * Check if the parent inode matches the vino from directory reply inf=
o
> > + */
> > +static inline bool ceph_vino_matches_parent(struct inode *parent, stru=
ct ceph_vino vino)
> > +{
> > +     return ceph_ino(parent) =3D=3D vino.ino && ceph_snap(parent) =3D=
=3D vino.snap;
> > +}
> > +
> > +/*
> > + * Validate that the directory inode referenced by @req->r_parent matc=
hes the
> > + * inode number and snapshot id contained in the reply's directory rec=
ord.  If
> > + * they do not match =E2=80=93 which can theoretically happen if the p=
arent dentry was
> > + * moved between the time the request was issued and the reply arrived=
 =E2=80=93 fall
> > + * back to looking up the correct inode in the inode cache.
> > + *
> > + * A reference is *always* returned.  Callers that receive a different=
 inode
> > + * than the original @parent are responsible for dropping the extra re=
ference
> > + * once the reply has been processed.
> > + */
> > +static struct inode *ceph_get_reply_dir(struct super_block *sb,
> > +                                       struct inode *parent,
> > +                                       struct ceph_mds_reply_info_pars=
ed *rinfo)
> > +{
> > +    struct ceph_vino vino;
> > +
> > +    if (unlikely(!rinfo->diri.in))
> > +        return parent; /* nothing to compare against */
> > +
> > +    /* If we didn't have a cached parent inode to begin with, just bai=
l out. */
> > +    if (!parent)
> > +        return NULL;
> > +
> > +    vino.ino  =3D le64_to_cpu(rinfo->diri.in->ino);
> > +    vino.snap =3D le64_to_cpu(rinfo->diri.in->snapid);
> > +
> > +    if (likely(ceph_vino_matches_parent(parent, vino)))
> > +        return parent; /* matches =E2=80=93 use the original reference=
 */
> > +
> > +    /* Mismatch =E2=80=93 this should be rare.  Emit a WARN and obtain=
 the correct inode. */
> > +    WARN(1, "ceph: reply dir mismatch (parent valid %llx.%llx reply %l=
lx.%llx)\n",
> > +         ceph_ino(parent), ceph_snap(parent), vino.ino, vino.snap);
>
> I am not completely sure that I follow why we would like to use namely WA=
RN()
> here? If we have some condition, then WARN() looks like natural choice.
> Otherwise, if we have unconditional situation, then, maybe, pr_warn() wil=
l be
> better? Would we like to show call trace here?
>
> Are we really sure that this mismatch could be the rare case? Otherwise, =
call
> traces from multiple threads will create the real mess in the system log.
>
> Thanks,
> Slava.
>
> > +
> > +    return ceph_get_inode(sb, vino, NULL);
> > +}
> > +
> >  /**
> >   * ceph_new_inode - allocate a new inode in advance of an expected cre=
ate
> >   * @dir: parent directory for new inode
> > @@ -1548,8 +1593,11 @@ int ceph_fill_trace(struct super_block *sb, stru=
ct ceph_mds_request *req)
> >       }
> >
> >       if (rinfo->head->is_dentry) {
> > -             struct inode *dir =3D req->r_parent;
> > -
> > +             /*
> > +              * r_parent may be stale, in cases when R_PARENT_LOCKED i=
s not set,
> > +              * so we need to get the correct inode
> > +              */
> > +             struct inode *dir =3D ceph_get_reply_dir(sb, req->r_paren=
t, rinfo);
> >               if (dir) {
> >                       err =3D ceph_fill_inode(dir, NULL, &rinfo->diri,
> >                                             rinfo->dirfrag, session, -1=
,
>
> --
> Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>


