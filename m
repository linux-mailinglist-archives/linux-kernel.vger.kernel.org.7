Return-Path: <linux-kernel+bounces-767819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE26EB25981
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 04:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40C807AEF28
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 02:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3548A2580CC;
	Thu, 14 Aug 2025 02:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oYjKHE0U"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BEE1EB195
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755138313; cv=none; b=il1LwNAEtM+eeSK/W2+PGbzZ6l9BL+5Pzdk0X5IO3GjoBR3nbNOAFLTQIIQqiuirHKdlIGBhUmjMbd6ZjlS2PzY5JY+wuh8P32j9uGkZvsw0cHsz+KMsMaO3/E7ei0yPX9H6tMozUP6KdSb+HI+ZoY4PypXLcJSI67O4YXlxMHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755138313; c=relaxed/simple;
	bh=9ekAH6tE9KEoiHjMTtY0qqllW77WfkxUTD1qTk3NUz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5Kl/gSeac7+kYdlLX4F8QHI1IYDhwqbt5BHEiRiGuW4DXwBtR+Uj/ud+YlBxzuoEzxm6sktQpSwzL9eXufQD2l0+sdkBFplmBKOsWrw9tHTPx5kRWUxS8qdwE7VhHw8etEqXYgGehd5BkNg/lNn14EtdHnG1MPFu4+wnox9TPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oYjKHE0U; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55cd07a28e0so4508e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 19:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755138308; x=1755743108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7f14HjxbHLnjI0goUsTnc/QoFHEcQIsr8WcK1Pbmd2g=;
        b=oYjKHE0UwM/hovC0dNDvFYIDKJABqrsquvZ16rag7PO6p6fqmj3DN974fKdEBWShg6
         woRkh4Wlnr35sq1YV2gkVZ5Dvz8zqpl7OJndbw7jkw+BTJKKy/5FoNwQW1QSv6jhV/16
         s3TYjK/qgqNtdCvvdlPNXAmfJOp33et5KzPxDlkO52CEmmucPmumMZk5+Dxt6D3m2p6n
         HXyvrnHqPkJgkc7qcnv1L+LhGAV4Ec3ZjTza5HbHalrvS7ewQsdTFcIqpMDjkPhnjoov
         FYzDBtAzzEu76zo7Y6voagdDlFZ4R8gRGzs5aSw87xcGOsq0lWeY1OW/edwG5Oe5MFCL
         1XNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755138308; x=1755743108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7f14HjxbHLnjI0goUsTnc/QoFHEcQIsr8WcK1Pbmd2g=;
        b=MHvFvIp9PccKkjY6o9zwEomBO72u4wdyX0lZzNW5EO5FhtbyDuFbmW9l8e1A0Q1eCT
         SFecDXp7SQHahwG0t6+TVX84CTE8khVk0epge3tcgPIq88ouGdieYfAm7uTWuLW3OU68
         jo+I1cqzXxkXZju6X4qedkbP76vKjUoxLzAWDu7g/jWsA44lf2PWex7kbcc76zwikGTy
         TsIXb8c/Lap2C98wazzKBKWuhAxbD2Bw0nLg8aBeO/bdq4JVZA4GE60UJDbBRsWrdwqy
         4Zmoet4yIfE3Ii0GmZbMaA3rV9MtjaKyeZnoCcI04cPEQvEn4QREkuq3TMabVy1gxTAW
         Q6kw==
X-Forwarded-Encrypted: i=1; AJvYcCUomm6IONuBEqEtOjsDy2EzIVk3qQLoa99VSKcURAYSSHPlcAd5eQlwBh5YYuvGSJDlx6A7eeDK87RXcLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdcjvlSY6BL+HKSRjh2k25eBEvIItWoKbY5lzojz2XWuq+vqz3
	jcRBgLu8Tkh4mSWY73beg4SP5ulUMlDAJroR8G9EpbqWaqkViWiXPj3uA/iY37tJqriSlavLKOA
	yW3q7KqSPDK0tiUyh8FsAc5AkD4NWjGoPOuJ3ZBYB
X-Gm-Gg: ASbGncs0N9fGgLHX4Sq45asl/ktBGCdxzmfKgnVmxmGB4uH/n+UsCFGF43SXAo4+W8U
	vTAWSGaJakoZzTKgiBTI3HdeTxpd2ERzadaEVT8EY5mKWXi6WW+tAeIrimB6rarbC82TXggKM2+
	hgd6/iPkZYilAE5Qm0ZrS1O1/YCMlhy2GdygEow/gtvQnKG8Wwlp7tTrD5Wd0nnjb6Q+UiOvfHz
	sqj+MnVGcKxBd+h7o0x+UiSem1juI5gQiAFIVIHPV8pQlYye3k9
X-Google-Smtp-Source: AGHT+IGyH85UolQ5QdnTSYNde87J0gHIUeRynhmRlTW5ukEEoa5Rkjx6Zd23yJQLbhg26qzjEAywFS1dszriPo2ce9I=
X-Received: by 2002:ac2:5bdb:0:b0:55b:5e22:dfb2 with SMTP id
 2adb3069b0e04-55ce5221f99mr151769e87.0.1755138307978; Wed, 13 Aug 2025
 19:25:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807075745.756415-1-tweek@google.com> <CAEjxPJ5nC7s=+Os4+9XjkzhGTyaNVrCyJgx+rz5n3baRFWVrzA@mail.gmail.com>
 <CAEjxPJ7JFHs1w71qeOFYSAmReZsghAz3+XVJrTKH=v=P822yxQ@mail.gmail.com>
 <CA+zpnLeaKkXAdxUuA5kNbKwrGVX+UCf+VFLK0XbtrbovvPGUWQ@mail.gmail.com> <CAEjxPJ5otOTmP44QcYXpqcAyg1JU+CTPmS6UgPugnQbFJ_9=dw@mail.gmail.com>
In-Reply-To: <CAEjxPJ5otOTmP44QcYXpqcAyg1JU+CTPmS6UgPugnQbFJ_9=dw@mail.gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Thu, 14 Aug 2025 12:24:50 +1000
X-Gm-Features: Ac12FXxaM_88l4uD_oppAslP6gGUe8mfwUVp5eYzTa5WSceVoD0s-RwhVyclqJQ
Message-ID: <CA+zpnLfqyfw7tWLvWHO2HSzixuKMKYFCw_T7XoW-oEuF6BvVyw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] memfd: call security_inode_init_security_anon
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	Hugh Dickins <hughd@google.com>, Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, 
	Jeff Xu <jeffxu@google.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 11:09=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Aug 11, 2025 at 1:34=E2=80=AFAM Thi=C3=A9baud Weksteen <tweek@goo=
gle.com> wrote:
> >
> > On Fri, Aug 8, 2025 at 10:41=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Fri, Aug 8, 2025 at 7:57=E2=80=AFAM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> >
> > Thanks for the review Stephen.
> >
> > > >
> > > > On Thu, Aug 7, 2025 at 3:57=E2=80=AFAM Thi=C3=A9baud Weksteen <twee=
k@google.com> wrote:
> > > > >
> > > > > Prior to this change, no security hooks were called at the creati=
on of a
> > > > > memfd file. It means that, for SELinux as an example, it will rec=
eive
> > > > > the default type of the filesystem that backs the in-memory inode=
. In
> > > > > most cases, that would be tmpfs, but if MFD_HUGETLB is passed, it=
 will
> > > > > be hugetlbfs. Both can be considered implementation details of me=
mfd.
> > > > >
> > > > > It also means that it is not possible to differentiate between a =
file
> > > > > coming from memfd_create and a file coming from a standard tmpfs =
mount
> > > > > point.
> > > > >
> > > > > Additionally, no permission is validated at creation, which diffe=
rs from
> > > > > the similar memfd_secret syscall.
> > > > >
> > > > > Call security_inode_init_security_anon during creation. This ensu=
res
> > > > > that the file is setup similarly to other anonymous inodes. On SE=
Linux,
> > > > > it means that the file will receive the security context of its t=
ask.
> > > > >
> > > > > The ability to limit fexecve on memfd has been of interest to avo=
id
> > > > > potential pitfalls where /proc/self/exe or similar would be execu=
ted
> > > > > [1][2]. Reuse the "execute_no_trans" and "entrypoint" access vect=
ors,
> > > > > similarly to the file class. These access vectors may not make se=
nse for
> > > > > the existing "anon_inode" class. Therefore, define and assign a n=
ew
> > > > > class "memfd_file" to support such access vectors.
> > > >
> > > > To provide backward compatibility, I would anticipate that you will
> > > > need to define a new SELinux policy capability and make this change
> > > > conditional on it being enabled, see:
> > > > https://github.com/SELinuxProject/selinux-kernel/wiki/Getting-Start=
ed#adding-a-new-selinux-policy-capability
> > > > for instructions and links to examples.
> > > >
> >
> > I agree. Thanks, I'll add this to the next patchset.
> >
> > > > Otherwise, see below.
> > > >
> > > > >
> > > > > [1] https://crbug.com/1305267
> > > > > [2] https://lore.kernel.org/lkml/20221215001205.51969-1-jeffxu@go=
ogle.com/
> > > > >
> > > > > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > > > > ---
> > > > >  mm/memfd.c                          | 16 ++++++++++++++--
> > > > >  security/selinux/hooks.c            | 15 +++++++++++----
> > > > >  security/selinux/include/classmap.h |  2 ++
> > > > >  3 files changed, 27 insertions(+), 6 deletions(-)
> > > > >
> > > > > diff --git a/mm/memfd.c b/mm/memfd.c
> > > > > index bbe679895ef6..13bff0e91816 100644
> > > > > --- a/mm/memfd.c
> > > > > +++ b/mm/memfd.c
> > > > > @@ -433,6 +433,9 @@ static struct file *alloc_file(const char *na=
me, unsigned int flags)
> > > > >  {
> > > > >         unsigned int *file_seals;
> > > > >         struct file *file;
> > > > > +       struct inode *inode;
> > > > > +       int err =3D 0;
> > > > > +       const char *anon_name =3D "[memfd]";
> > > > >
> > > > >         if (flags & MFD_HUGETLB) {
> > > > >                 file =3D hugetlb_file_setup(name, 0, VM_NORESERVE=
,
> > > > > @@ -444,12 +447,21 @@ static struct file *alloc_file(const char *=
name, unsigned int flags)
> > > > >         }
> > > > >         if (IS_ERR(file))
> > > > >                 return file;
> > > > > +
> > > > > +       inode =3D file_inode(file);
> > > > > +       err =3D security_inode_init_security_anon(inode,
> > > > > +                       LSM_ANON_INODE_MEMFD,
> > > > > +                       &QSTR(anon_name), NULL);
> > > >
> > > > Since the anon_name already indicates that this is a memfd, so can'=
t
> > > > you already distinguish these via name-based type_transition rules?
> > > > Why do we need the enum argument?
> > >
> > > On second thought, I see that you are distinguishing not just the
> > > security context/type but also the security class, but the question
> > > remains: can't you compare the name to make this determination?
> > >
> >
> > I definitely can. My initial thought was that a string comparison
> > would not be adequate here (performance-wise), but I guess calls to
> > this method are infrequent enough that a strncmp would work here?
>
> Open to data showing otherwise, but would think that a fixed-size
> small string comparison would be in the noise here.
>

I agree.

> >
> > On the option of just relying on name-based type transitions, this has
> > an impact on the size of the policy: for Android, the transition from
> > ashmem to memfd means that virtually all domains will rely on such a
> > file. It means that we would need to define a type transition and a
> > new type for all our domains. (This is an argument on top of the need
> > for execute_no_trans, as I described in the commit message).
> >
> > > >
> > > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > > index 8d36d5ebb6e5..49742930e706 100644
> > > > > --- a/security/selinux/hooks.c
> > > > > +++ b/security/selinux/hooks.c
> > > > > @@ -2367,8 +2367,8 @@ static int selinux_bprm_creds_for_exec(stru=
ct linux_binprm *bprm)
> > > > >         ad.u.file =3D bprm->file;
> > > > >
> > > > >         if (new_tsec->sid =3D=3D old_tsec->sid) {
> > > > > -               rc =3D avc_has_perm(old_tsec->sid, isec->sid,
> > > > > -                                 SECCLASS_FILE, FILE__EXECUTE_NO=
_TRANS, &ad);
> > > > > +               rc =3D avc_has_perm(old_tsec->sid, isec->sid, ise=
c->sclass,
> > > > > +                                 FILE__EXECUTE_NO_TRANS, &ad);
> > > >
> > > > Here and below I am a little concerned that we could end up reachin=
g
> > > > this code on an inode with an isec->sclass that does not define the
> > > > execute_no_trans and entrypoint permissions. We should do something=
 to
> > > > make that never happens, or check for it and always deny in that ca=
se.
> >
> > I agree. I can add a condition to make sure only these 2 classes (file
> > or memfd_file) are used here.
> >
> > > >
> > > > >                 if (rc)
> > > > >                         return rc;
> > > > >         } else {
> > > > > @@ -2378,8 +2378,8 @@ static int selinux_bprm_creds_for_exec(stru=
ct linux_binprm *bprm)
> > > > >                 if (rc)
> > > > >                         return rc;
> > > > >
> > > > > -               rc =3D avc_has_perm(new_tsec->sid, isec->sid,
> > > > > -                                 SECCLASS_FILE, FILE__ENTRYPOINT=
, &ad);
> > > > > +               rc =3D avc_has_perm(new_tsec->sid, isec->sid, ise=
c->sclass,
> > > > > +                                 FILE__ENTRYPOINT, &ad);
> > > > >                 if (rc)
> > > > >                         return rc;
> > > > >
> > > > > @@ -2997,6 +2997,13 @@ static int selinux_inode_init_security_ano=
n(struct inode *inode,
> > > > >
> > > > >                 isec->sclass =3D context_isec->sclass;
> > > > >                 isec->sid =3D context_isec->sid;
> > > > > +       } else if (type =3D=3D LSM_ANON_INODE_MEMFD) {
> > > > > +               isec->sclass =3D SECCLASS_MEMFD_FILE;
> > > > > +               rc =3D security_transition_sid(
> > > > > +                       sid, sid,
> > > > > +                       isec->sclass, name, &isec->sid);
> > > >
> > > > Again, name-based type_transitions ought to be able to distinguish
> > > > memfd based on the name argument IIUC.

