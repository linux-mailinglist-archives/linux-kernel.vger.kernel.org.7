Return-Path: <linux-kernel+bounces-720457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2E5AFBC02
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 21:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E5F3BA758
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 19:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF9B221DA8;
	Mon,  7 Jul 2025 19:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRxhfP/6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA49D221FBC
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 19:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751918250; cv=none; b=Q1oXEHkV/idLb844HXDbjaTEbAJEm5xw0SVdZbjArbzfWT662HUxKL3UlMoFSd/cSQENKX9A3tR0qcOiqUgAeE9UusITjnW6GLSmjWgdWLmwgsz8Mva5zYMetLHnemIdw1c7X7qbs2TvQJuuWVN5ndMqeyAQ9wOskKWIoXGs1D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751918250; c=relaxed/simple;
	bh=Yi3u2pojocT6gPeIB07HFZJ7F8Y1Qjs9TbXKRB3t88k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MM7G+/GBb4Fb/9S57GJWvmYFtzg1kE04QitTi5VfyumSK71NSK4p0MGVGENnSI9JHekZeUcDoYwr9Dgml2V90slnYGPGjF/NX6k/Bzi3lFVFG/oCbxq3pfwDtYk8CGnVWOu+W4soIXLM2sXahSXItObIr0U/RMhMREYZqYwL2p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DRxhfP/6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751918246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=++us8veuh6X+PyW7l7MOpsXLwvhb4ZOoAPGoiCHgkII=;
	b=DRxhfP/6/d07LUH1HPCPSQqc3mnbuFRrb6tw9s5UOSKZEtAQs1+4/jZese6HVl9DCColI2
	YVeA6aqQwiy1pYc55zYxSurefruZRRX7YYfVfXaz85qldioO5sl3zHz1u7h4DRCTTwQPU3
	fTyP6axYUtj2FX6soJnGD0ENe2q7IA0=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-MEHT4E-GN0yAqxkoFfAGfw-1; Mon, 07 Jul 2025 15:57:25 -0400
X-MC-Unique: MEHT4E-GN0yAqxkoFfAGfw-1
X-Mimecast-MFC-AGG-ID: MEHT4E-GN0yAqxkoFfAGfw_1751918245
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-87ebf76c341so96699241.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 12:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751918245; x=1752523045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++us8veuh6X+PyW7l7MOpsXLwvhb4ZOoAPGoiCHgkII=;
        b=nvLxcDE35RlSblE1OCjcBbEZiDu92GGUZ6nuxjpvRagPJ6vHPW37wiGrenQpAT5wtk
         8d+njSvt4ldREUZTiulyhToKISLmL9iRNJV9L0T8zb6sevFCu2YeOO0av5ZD8y78NNqg
         1sHJx6+dMHFfZbK/y9Oplzt/KOzLK4Q1MK/nn8PQnMC8j6gL1LxwIk5FAZqS5iL8vlJN
         qM6hLx1UbrzENsjWhk2pUzXZtP3Ldfy1Eno3FY2meNGmHJivkGIEyad8HNaXX6txOhzJ
         DgTDDjGsKMK5NAFmY3a5vg1LjAKh7PeliCRh7oWnunefXKLylNAAoeThuV7ktf5Fk0VS
         NJoA==
X-Forwarded-Encrypted: i=1; AJvYcCURn00KUoa5HVkABYC2nN47aJ0chPxeHNCdYcHB401MI2gJ8Kzoumz0B5Y2b+E+oMVVn9tBPOQL6tksJ60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3jR+3NZWlXw6GKxZY/VAAyxwuPqiTNnBcyMuvotQbDql3d0VZ
	gEzFj42tGTKlPBfi62z15nWxTtiDr4Envb4ovWsZ6BTGfL9qV+OaD1DLRZWE+//9N3qe5KdZmJq
	ScyIU2jlX/nwE3d75tb/yg4IxDpZfUyzwTx2A8SNtJu62EZ+JUun15ptYAL+768B3qEjZjxsZHr
	7Qkd3cHVvquN1f8U0KeoQA7AOqDLv0Q7zKlrAq/caG
X-Gm-Gg: ASbGncu23TtZDXjjJLiL6mS2YU8gtNRfV5wlnz02/rkNpc+JgPHduvU4iub/80lA+O5
	+kdSsulJ2Lu1gfEkSCwUmxm+cwNwHw9AF50v2XUBxkaRU5w5Tvs7LMi1Qc7NTSoi3UP8Av7Jpmr
	9H+T3H
X-Received: by 2002:a05:6102:390c:b0:4eb:502c:569a with SMTP id ada2fe7eead31-4f340172e66mr624021137.9.1751918244640;
        Mon, 07 Jul 2025 12:57:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEH/wCcdT3AXi3hvIwA+BlrpWQRCUTUy84Amk9TcHG1DKyLMaooc6PHy48eI7upZfFuagziGHFbrw5CRnLuxjY=
X-Received: by 2002:a05:6102:390c:b0:4eb:502c:569a with SMTP id
 ada2fe7eead31-4f340172e66mr624015137.9.1751918244250; Mon, 07 Jul 2025
 12:57:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250705155422.802775-1-abinashsinghlalotra@gmail.com>
 <CAO8a2Shw=pkQN21+nzHWQyfF5ygGMtHG1uVn2Cqqi6Bhm8Mhfg@mail.gmail.com> <75e7fa30828fdde8b122a6627881a1d9c6bbdcdd.camel@ibm.com>
In-Reply-To: <75e7fa30828fdde8b122a6627881a1d9c6bbdcdd.camel@ibm.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Mon, 7 Jul 2025 22:57:11 +0300
X-Gm-Features: Ac12FXxfagzeaYBJw1qkuEjol2TC_T40Z8PnEVaYHoP8WQDOIKmzEn3gnwMNrmA
Message-ID: <CAO8a2Sg9bDYu8PQvZrB_pZ6Y7xZk8Di6=pQjc+7EAfZU0H89cw@mail.gmail.com>
Subject: Re: [PATCH RFC] fs/ceph : fix build warning in ceph_writepages_start()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "abinashlalotra@gmail.com" <abinashlalotra@gmail.com>, Xiubo Li <xiubli@redhat.com>, 
	"idryomov@gmail.com" <idryomov@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	"abinashsinghlalotra@gmail.com" <abinashsinghlalotra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Well, kmem_cache is a bit faster AFAIK. TBH, I would use a magazine
allocator here which would bridge the two, but that's a different
discussion.
We already have an allocation of a big struct in the read path as well
where we just kmalloc and it should change as well to
kmemcache/mempool.

On Mon, Jul 7, 2025 at 9:24=E2=80=AFPM Viacheslav Dubeyko <Slava.Dubeyko@ib=
m.com> wrote:
>
> On Mon, 2025-07-07 at 13:11 +0300, Alex Markuze wrote:
> > Hi Abinash,
> >
> > Thanks for your patch, you=E2=80=99ve correctly identified a real conce=
rn
> > around stack usage in ceph_writepages_start().
> >
> > However, dynamically allocating ceph_writeback_ctl inside .writepages
> > isn't ideal. This function may be called in memory reclaim paths or
> > under writeback pressure, where any GFP allocation (even GFP_NOFS)
> > could deadlock or fail unexpectedly.
> >
> > Instead of allocating the struct on each call, I=E2=80=99d suggest one =
of the following:
> >
> > Add a dedicated kmem_cache for ceph_writeback_ctl, initialized during
> > Ceph FS client init.
> > This allows reuse across calls without hitting the slab allocator each =
time.
> >
>
> I had discussion with Ilya several days ago related to this issue. :) I
> considered namely to add the dedicated kmem_cache for ceph_writeback_ctl.
> However, Ilya mentioned that CONFIG_FRAME_WARN defaulting to 2048 on x86_=
64. So,
> you even could not see such warning on x86_64 systems. But, yes, this rew=
ork
> makes sense from my point of view.
>
> By the way, do we need to consider mempool here instead of kmem_cache? Th=
e
> writeback is pretty intensive and critical code path.
>
> Thanks,
> Slava.
>
> > Embed a ceph_writeback_ctl struct inside ceph_inode_info, if it's
> > feasible to manage lifetimes and synchronization. Note that
> > .writepages can run concurrently on the same inode, so this approach
> > would require proper locking or reuse guarantees.
> >
> > On Sat, Jul 5, 2025 at 6:54=E2=80=AFPM Abinash Singh <abinashlalotra@gm=
ail.com> wrote:
> > >
> > > The function `ceph_writepages_start()` triggers
> > > a large stack frame warning:
> > > ld.lld: warning:
> > >         fs/ceph/addr.c:1632:0: stack frame size (1072) exceeds limit =
(1024) in function 'ceph_writepages_start.llvm.2555023190050417194'
> > >
> > > fix it by dynamically allocating `ceph_writeback_ctl` struct.
> > >
> > > Signed-off-by: Abinash Singh <abinashsinghlalotra@gmail.com>
> > > ---
> > > The high stack usage of ceph_writepages_start() was further
> > > confirmed by using -fstack-usage flag :
> > > ...
> > > fs/ceph/addr.c:1837:ceph_netfs_check_write_begin        104     stati=
c
> > > fs/ceph/addr.c:1630:ceph_writepages_start       648     static
> > > ...
> > > After optimzations it may go upto 1072 as seen in warning.
> > > After allocating `ceph_writeback_ctl` struct it is reduced to:
> > > ...
> > > fs/ceph/addr.c:1630:ceph_writepages_start       288     static
> > > fs/ceph/addr.c:81:ceph_dirty_folio      72      static
> > > ...
> > > Is this fun used very frequently ?? or dynamic allocation is
> > > a fine fix for reducing the stack usage ?
> > >
> > > Thank You
> > > ---
> > >  fs/ceph/addr.c | 82 ++++++++++++++++++++++++++----------------------=
--
> > >  1 file changed, 43 insertions(+), 39 deletions(-)
> > >
> > > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > > index 60a621b00c65..503a86c1dda6 100644
> > > --- a/fs/ceph/addr.c
> > > +++ b/fs/ceph/addr.c
> > > @@ -1633,9 +1633,13 @@ static int ceph_writepages_start(struct addres=
s_space *mapping,
> > >         struct inode *inode =3D mapping->host;
> > >         struct ceph_fs_client *fsc =3D ceph_inode_to_fs_client(inode)=
;
> > >         struct ceph_client *cl =3D fsc->client;
> > > -       struct ceph_writeback_ctl ceph_wbc;
> > > +       struct ceph_writeback_ctl *ceph_wbc __free(kfree) =3D NULL;
> > >         int rc =3D 0;
> > >
> > > +       ceph_wbc =3D kmalloc(sizeof(*ceph_wbc), GFP_NOFS);
> > > +       if (!ceph_wbc)
> > > +               return -ENOMEM;
> > > +
> > >         if (wbc->sync_mode =3D=3D WB_SYNC_NONE && fsc->write_congeste=
d)
> > >                 return 0;
> > >
> > > @@ -1648,7 +1652,7 @@ static int ceph_writepages_start(struct address=
_space *mapping,
> > >                 return -EIO;
> > >         }
> > >
> > > -       ceph_init_writeback_ctl(mapping, wbc, &ceph_wbc);
> > > +       ceph_init_writeback_ctl(mapping, wbc, ceph_wbc);
> > >
> > >         if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
> > >                 rc =3D -EIO;
> > > @@ -1656,7 +1660,7 @@ static int ceph_writepages_start(struct address=
_space *mapping,
> > >         }
> > >
> > >  retry:
> > > -       rc =3D ceph_define_writeback_range(mapping, wbc, &ceph_wbc);
> > > +       rc =3D ceph_define_writeback_range(mapping, wbc, ceph_wbc);
> > >         if (rc =3D=3D -ENODATA) {
> > >                 /* hmm, why does writepages get called when there
> > >                    is no dirty data? */
> > > @@ -1665,55 +1669,55 @@ static int ceph_writepages_start(struct addre=
ss_space *mapping,
> > >         }
> > >
> > >         if (wbc->sync_mode =3D=3D WB_SYNC_ALL || wbc->tagged_writepag=
es)
> > > -               tag_pages_for_writeback(mapping, ceph_wbc.index, ceph=
_wbc.end);
> > > +               tag_pages_for_writeback(mapping, ceph_wbc->index, cep=
h_wbc->end);
> > >
> > > -       while (!has_writeback_done(&ceph_wbc)) {
> > > -               ceph_wbc.locked_pages =3D 0;
> > > -               ceph_wbc.max_pages =3D ceph_wbc.wsize >> PAGE_SHIFT;
> > > +       while (!has_writeback_done(ceph_wbc)) {
> > > +               ceph_wbc->locked_pages =3D 0;
> > > +               ceph_wbc->max_pages =3D ceph_wbc->wsize >> PAGE_SHIFT=
;
> > >
> > >  get_more_pages:
> > > -               ceph_folio_batch_reinit(&ceph_wbc);
> > > +               ceph_folio_batch_reinit(ceph_wbc);
> > >
> > > -               ceph_wbc.nr_folios =3D filemap_get_folios_tag(mapping=
,
> > > -                                                           &ceph_wbc=
.index,
> > > -                                                           ceph_wbc.=
end,
> > > -                                                           ceph_wbc.=
tag,
> > > -                                                           &ceph_wbc=
.fbatch);
> > > +               ceph_wbc->nr_folios =3D filemap_get_folios_tag(mappin=
g,
> > > +                                                           &ceph_wbc=
->index,
> > > +                                                           ceph_wbc-=
>end,
> > > +                                                           ceph_wbc-=
>tag,
> > > +                                                           &ceph_wbc=
->fbatch);
> > >                 doutc(cl, "pagevec_lookup_range_tag for tag %#x got %=
d\n",
> > > -                       ceph_wbc.tag, ceph_wbc.nr_folios);
> > > +                       ceph_wbc->tag, ceph_wbc->nr_folios);
> > >
> > > -               if (!ceph_wbc.nr_folios && !ceph_wbc.locked_pages)
> > > +               if (!ceph_wbc->nr_folios && !ceph_wbc->locked_pages)
> > >                         break;
> > >
> > >  process_folio_batch:
> > > -               rc =3D ceph_process_folio_batch(mapping, wbc, &ceph_w=
bc);
> > > +               rc =3D ceph_process_folio_batch(mapping, wbc, ceph_wb=
c);
> > >                 if (rc)
> > >                         goto release_folios;
> > >
> > >                 /* did we get anything? */
> > > -               if (!ceph_wbc.locked_pages)
> > > +               if (!ceph_wbc->locked_pages)
> > >                         goto release_folios;
> > >
> > > -               if (ceph_wbc.processed_in_fbatch) {
> > > -                       ceph_shift_unused_folios_left(&ceph_wbc.fbatc=
h);
> > > +               if (ceph_wbc->processed_in_fbatch) {
> > > +                       ceph_shift_unused_folios_left(&ceph_wbc->fbat=
ch);
> > >
> > > -                       if (folio_batch_count(&ceph_wbc.fbatch) =3D=
=3D 0 &&
> > > -                           ceph_wbc.locked_pages < ceph_wbc.max_page=
s) {
> > > +                       if (folio_batch_count(&ceph_wbc->fbatch) =3D=
=3D 0 &&
> > > +                           ceph_wbc->locked_pages < ceph_wbc->max_pa=
ges) {
> > >                                 doutc(cl, "reached end fbatch, trying=
 for more\n");
> > >                                 goto get_more_pages;
> > >                         }
> > >                 }
> > >
> > > -               rc =3D ceph_submit_write(mapping, wbc, &ceph_wbc);
> > > +               rc =3D ceph_submit_write(mapping, wbc, ceph_wbc);
> > >                 if (rc)
> > >                         goto release_folios;
> > >
> > > -               ceph_wbc.locked_pages =3D 0;
> > > -               ceph_wbc.strip_unit_end =3D 0;
> > > +               ceph_wbc->locked_pages =3D 0;
> > > +               ceph_wbc->strip_unit_end =3D 0;
> > >
> > > -               if (folio_batch_count(&ceph_wbc.fbatch) > 0) {
> > > -                       ceph_wbc.nr_folios =3D
> > > -                               folio_batch_count(&ceph_wbc.fbatch);
> > > +               if (folio_batch_count(&ceph_wbc->fbatch) > 0) {
> > > +                       ceph_wbc->nr_folios =3D
> > > +                               folio_batch_count(&ceph_wbc->fbatch);
> > >                         goto process_folio_batch;
> > >                 }
> > >
> > > @@ -1724,38 +1728,38 @@ static int ceph_writepages_start(struct addre=
ss_space *mapping,
> > >                  * we tagged for writeback prior to entering this loo=
p.
> > >                  */
> > >                 if (wbc->nr_to_write <=3D 0 && wbc->sync_mode =3D=3D =
WB_SYNC_NONE)
> > > -                       ceph_wbc.done =3D true;
> > > +                       ceph_wbc->done =3D true;
> > >
> > >  release_folios:
> > >                 doutc(cl, "folio_batch release on %d folios (%p)\n",
> > > -                     (int)ceph_wbc.fbatch.nr,
> > > -                     ceph_wbc.fbatch.nr ? ceph_wbc.fbatch.folios[0] =
: NULL);
> > > -               folio_batch_release(&ceph_wbc.fbatch);
> > > +                     (int)ceph_wbc->fbatch.nr,
> > > +                     ceph_wbc->fbatch.nr ? ceph_wbc->fbatch.folios[0=
] : NULL);
> > > +               folio_batch_release(&ceph_wbc->fbatch);
> > >         }
> > >
> > > -       if (ceph_wbc.should_loop && !ceph_wbc.done) {
> > > +       if (ceph_wbc->should_loop && !ceph_wbc->done) {
> > >                 /* more to do; loop back to beginning of file */
> > >                 doutc(cl, "looping back to beginning of file\n");
> > >                 /* OK even when start_index =3D=3D 0 */
> > > -               ceph_wbc.end =3D ceph_wbc.start_index - 1;
> > > +               ceph_wbc->end =3D ceph_wbc->start_index - 1;
> > >
> > >                 /* to write dirty pages associated with next snapc,
> > >                  * we need to wait until current writes complete */
> > > -               ceph_wait_until_current_writes_complete(mapping, wbc,=
 &ceph_wbc);
> > > +               ceph_wait_until_current_writes_complete(mapping, wbc,=
 ceph_wbc);
> > >
> > > -               ceph_wbc.start_index =3D 0;
> > > -               ceph_wbc.index =3D 0;
> > > +               ceph_wbc->start_index =3D 0;
> > > +               ceph_wbc->index =3D 0;
> > >                 goto retry;
> > >         }
> > >
> > > -       if (wbc->range_cyclic || (ceph_wbc.range_whole && wbc->nr_to_=
write > 0))
> > > -               mapping->writeback_index =3D ceph_wbc.index;
> > > +       if (wbc->range_cyclic || (ceph_wbc->range_whole && wbc->nr_to=
_write > 0))
> > > +               mapping->writeback_index =3D ceph_wbc->index;
> > >
> > >  dec_osd_stopping_blocker:
> > >         ceph_dec_osd_stopping_blocker(fsc->mdsc);
> > >
> > >  out:
> > > -       ceph_put_snap_context(ceph_wbc.last_snapc);
> > > +       ceph_put_snap_context(ceph_wbc->last_snapc);
> > >         doutc(cl, "%llx.%llx dend - startone, rc =3D %d\n", ceph_vino=
p(inode),
> > >               rc);
> > >
> > > --
> > > 2.43.0
> > >
> > >
> >


