Return-Path: <linux-kernel+bounces-852597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF31BD96B6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E10D41927BCB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F057313E05;
	Tue, 14 Oct 2025 12:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXdDlE1N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328C3313532
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445771; cv=none; b=H+hylVnu6UrBbpdpe3mL6n7zY1I8teB1ZuFyxcNyl3a0dP4E+amTwgnGT6fuy95ar2LZNUvcJFxgEIKIzWZbDF8EeeU55bRMEjt8L799Y9cZir98VZCnVp4k8VBPEt6vwdWYGkPq61Cmoc4xyJZSuD6auQlWpcX+YLSorsjOqPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445771; c=relaxed/simple;
	bh=V5w85nGmyvHtlJ6NvH7yNxTLFVw04bPLjy3aYWSD0tM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FTriUovfknoN21u+4y6DSHs/wKQLe3YVS2zpF0FwWDsLcRWj47Qp00SAIi1yPHE1OpAZT5jL+2GwQm1ulUHeyiNZN27PkXP8TXQbLDpMAHuiGyxLj7Yvb7Ou75Eksh/1CTCnV7WdFBMFMZjEh2xS52jJuQpdB+xJ5GcpJ757cCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZXdDlE1N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760445768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RsW6hgI73bAvJL304SGcdhS04XaB47CD+j5z/eIH7no=;
	b=ZXdDlE1NSEXaZf05nqrMUMGLH3JTg6TwEsoaLHtlH1RAPtqMhW1wqofivoGMIgpx9T0Piz
	kn7uAOTf6pqCs65FW3G4VfAx6ZE2akdQjXoHi0p4YXe8AIqgjPxynirNlH6M9dnVnKkKAq
	4b02/u0vqo0X2YaCI2zQvopklVdCMfw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-UmHamHQvOhWD2IqxVbKv1A-1; Tue, 14 Oct 2025 08:42:47 -0400
X-MC-Unique: UmHamHQvOhWD2IqxVbKv1A-1
X-Mimecast-MFC-AGG-ID: UmHamHQvOhWD2IqxVbKv1A_1760445766
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b4635c413a7so394547266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760445766; x=1761050566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RsW6hgI73bAvJL304SGcdhS04XaB47CD+j5z/eIH7no=;
        b=Cnq6goYX/bP4LCxJ5KrqBFCTEzovX1fJGnfiREs9WJUtKtfe8bRVbMq8TNW0rBoFd2
         /tIzk7uOAUgE1aItVpQKp3Qg8oJjQpLIbt2QQ/qJ7istRLeL/SjwP8pajlo7rX9Fkvxe
         rafWYhuhyUK97ZtHbZ6Rz11xpbWlJo1gWBFCJA59MPjuy0qNZk6dqvBG56oqN2Xv0wo1
         fI/U3AS7FZg2GRaexS05COSYlD2vXmg0dILwDHfJOmBMFUHrxPNjq2iY3nPY8RVthQE8
         4MLA06remEIfxkD8T7ECBD8yqnbptgNbSPoHoVlJrCtTe15kF5PrXzz15TK7x5oDK5a1
         IM0w==
X-Forwarded-Encrypted: i=1; AJvYcCVwtosDtZpGFL4fkVDIZ2e0AYL+Lw5cgIT9i4KC7nHJ6lIcvuCLBoPKOER3XmVyN5n9hh6lEv83F4TRzM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWA7tF8XMmOa7/P27qu03f/tC23KfKLVEm7aECuHSVmWLMN9+6
	KE2G8SG/BXmtHA2fchFnBI9ewRUOo6bRaJITMWzo131qtwW/pwF+TS4sGLKh7T0f8l15Pzyd+Rc
	RbvBwh6QqucZoNcLf2/kSyM1jsSRUfWv+3Dk1+wYJhG0FeXsk8eeYEa8rA2Yt2Vlvj3N/MXaJyF
	hkiRUij7VL3mFpnLC+GsmzfPBt5Jqf9y37mJKZc2mY
X-Gm-Gg: ASbGncvd1svSB/jBtpjdLdz6u6q8YDLaM/f7ji6ZQTVj5UVZZ3g/x1Xwihi69haoB6d
	BdogQsvFbHxx7hnk+j/skLHRHYBbOflh4uRke9hACM+PlljDefoaLNQymsIgyfhR9aEt6o3kEAM
	VHtVeqlDz1X1xEjZkV4E7OsFwoCREkHQIdYJd7dIPSkXy3JT9Wv5J2qQ==
X-Received: by 2002:a17:907:7213:b0:b41:a571:21b0 with SMTP id a640c23a62f3a-b50ac1cc421mr2467599166b.39.1760445765529;
        Tue, 14 Oct 2025 05:42:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAQUG+Awn1RSZW+vlzgHmi39cV1+nYyteZSCwB0AYafTqiHsBlJPee6BvXRZsm1OJKaeyAAaBVW0H40qH+cXs=
X-Received: by 2002:a17:907:7213:b0:b41:a571:21b0 with SMTP id
 a640c23a62f3a-b50ac1cc421mr2467596666b.39.1760445765057; Tue, 14 Oct 2025
 05:42:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904165919.3362000-1-rrobaina@redhat.com> <afae09deb55bcbfabe607fc2ee7997bc@paul-moore.com>
In-Reply-To: <afae09deb55bcbfabe607fc2ee7997bc@paul-moore.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Tue, 14 Oct 2025 09:42:33 -0300
X-Gm-Features: AS18NWATTIh_chHA6nGcUZoYV_vPm8eMPWatDE0AcRLTRcdseEbKMbZPOxB9tb0
Message-ID: <CAABTaaBZfcoHTHKAEKtYv5no_52LpjCGpJg-6g+_=Wo9ftGi5g@mail.gmail.com>
Subject: Re: [PATCH v1] audit: merge loops in __audit_inode_child()
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, eparis@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 4:17=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Sep  4, 2025 Ricardo Robaina <rrobaina@redhat.com> wrote:
> >
> > Whenever there's audit context, __audit_inode_child() gets called
> > numerous times, which can lead to high latency in scenarios that
> > create too many sysfs/debugfs entries at once, for instance, upon
> > device_add_disk() invocation.
> >
> >    # uname -r
> >    6.17.0-rc3+
> >
> >    # auditctl -a always,exit -F path=3D/tmp -k foo
> >    # time insmod loop max_loop=3D1000
> >    real 0m42.753s
> >    user 0m0.000s
> >    sys  0m42.494s
> >
> >    # perf record -a insmod loop max_loop=3D1000
> >    # perf report --stdio |grep __audit_inode_child
> >    37.95%  insmod  [kernel.kallsyms]  [k] __audit_inode_child
> >
> > __audit_inode_child() searches for both the parent and the child
> > in two different loops that iterate over the same list. This
> > process can be optimized by merging these into a single loop,
> > without changing the function behavior or affecting the code's
> > readability.
> >
> > This patch merges the two loops that walk through the list
> > context->names_list into a single loop. This optimization resulted
> > in around 54% performance enhancement for the benchmark.
> >
> >    # uname -r
> >    6.17.0-rc3+-enhanced
> >
> >    # auditctl -a always,exit -F path=3D/tmp -k foo
> >    # time insmod loop max_loop=3D1000
> >    real 0m19.388s
> >    user 0m0.000s
> >    sys  0m19.149s
> >
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  kernel/auditsc.c | 40 ++++++++++++++++++----------------------
> >  1 file changed, 18 insertions(+), 22 deletions(-)
>
> Thanks Ricardo, that's a nice improvement!  I saw a few additional things
> that could help simplify the code and possibly speed things up a bit
> more, see my comments below.
>
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index eb98cd6fe91f..7abfb68687fb 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -2437,44 +2437,40 @@ void __audit_inode_child(struct inode *parent,
> >       if (inode)
> >               handle_one(inode);
> >
> > -     /* look for a parent entry first */
> >       list_for_each_entry(n, &context->names_list, list) {
> > -             if (!n->name ||
> > -                 (n->type !=3D AUDIT_TYPE_PARENT &&
> > -                  n->type !=3D AUDIT_TYPE_UNKNOWN))
> > +             /* can only match entries that have a name */
> > +             if (!n->name)
> >                       continue;
> >
> > -             if (n->ino =3D=3D parent->i_ino && n->dev =3D=3D parent->=
i_sb->s_dev &&
> > -                 !audit_compare_dname_path(dname,
> > -                                           n->name->name, n->name_len)=
) {
> > +             /* look for a parent entry first */
> > +             if (!found_parent &&
> > +                 (n->type =3D=3D AUDIT_TYPE_PARENT || n->type =3D=3D A=
UDIT_TYPE_UNKNOWN) &&
> > +                 (n->ino =3D=3D parent->i_ino && n->dev =3D=3D parent-=
>i_sb->s_dev &&
> > +                  !audit_compare_dname_path(dname, n->name->name, n->n=
ame_len))) {
> >                       if (n->type =3D=3D AUDIT_TYPE_UNKNOWN)
> >                               n->type =3D AUDIT_TYPE_PARENT;
>
> We probably don't need to check 'n->type' first, as we want it to always
> be set to AUDIT_TYPE_PARENT regardless of it's current value.
>
> >                       found_parent =3D n;
>
> We can probably 'continue' here since a match can't be both a parent and
> a child at the same time.
>
> Similarly, if we add move the 'if (found_parent && found_child)' check
> up to here we don't need to run it on every pass through the loop, just
> when we find a match.
>
> Taking the two comment above into account, I would imagine something like
> this would good:
>
>   found_parent =3D n;
>   if (found_child)
>     break;
>   continue;
>
> > -                     break;
> >               }
> > -     }
> >
> > -     cond_resched();
> > -
> > -     /* is there a matching child entry? */
> > -     list_for_each_entry(n, &context->names_list, list) {
> > -             /* can only match entries that have a name */
> > -             if (!n->name ||
> > -                 (n->type !=3D type && n->type !=3D AUDIT_TYPE_UNKNOWN=
))
> > -                     continue;
> > -
> > -             if (!strcmp(dname->name, n->name->name) ||
> > -                 !audit_compare_dname_path(dname, n->name->name,
> > +             /* is there a matching child entry? */
> > +             if (!found_child &&
> > +                 (n->type =3D=3D type || n->type =3D=3D AUDIT_TYPE_UNK=
NOWN) &&
> > +                 (!strcmp(dname->name, n->name->name) ||
> > +                  !audit_compare_dname_path(dname, n->name->name,
> >                                               found_parent ?
> >                                               found_parent->name_len :
> > -                                             AUDIT_NAME_FULL)) {
> > +                                             AUDIT_NAME_FULL))) {
> >                       if (n->type =3D=3D AUDIT_TYPE_UNKNOWN)
> >                               n->type =3D type;
> >                       found_child =3D n;
>
> Similar to the parent case above, let's check to see if both a parent and
> a child have been found.  We can probably skip the 'continue' here are we
> are at the end of the loop.
>
>   found_child =3D n;
>   if (found_parent)
>     break;
>
> > -                     break;
> >               }
> > +
> > +             if (found_parent && found_child)
> > +                     break;
> >       }
> >
> > +     cond_resched();
>
> The 'cond_resched()' call was located between the two loops to help avoid
> a soft lockup caused by running through both loops; since we are now
> condensing that into one loop we can probably drop the 'cond_resched()'
> call ... which is definitely a good thing as it was a bit of a hack, a
> necessary hack, but still a hack :)
>
> >       if (!found_parent) {
> >               /* create a new, "anonymous" parent record */
> >               n =3D audit_alloc_name(context, AUDIT_TYPE_PARENT);
> > --
> > 2.51.0
>
> --
> paul-moore.com
>

Thank you for reviewing this one, Paul! And thanks a lot for your
suggestions, I'll work on a v2 addressing those shortly.


