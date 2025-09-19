Return-Path: <linux-kernel+bounces-823903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45384B87B1F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 04:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 549AC3B3DF7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B561C25784A;
	Fri, 19 Sep 2025 02:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QdUiw7Gd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD0722173D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 02:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758248132; cv=none; b=AV/3ZF4Piond3QnId/CbVf8FdhEOSC/OoFOKUgo3PFdLMNPK2Onl+gARIXMjWnnA0QDxKhl+5Ctpl2apvz0zfR+Ls6O0oyIJ/i0ywYq3ZAJNWLvQu5p7AUBRmmo4UXIAqIDcPxrmNM4oLtPK4WJ2qpQiEI946pjD2Vzjydo7wU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758248132; c=relaxed/simple;
	bh=16NKYgPcMTINaMZY744fmCRIxnMIIUCbOqQySGmcWGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LjysVVD+XWnB/bWsCpgqOTwbsbAQKuA/pmDXZ7FlE0/QxPy8sDnKyWhZqH8RbYmSJeLcO6dH/DmgCipZj2ErtVZcd69eo05u5BvVFtShERyXoEbXbWT11kUBcOkk2fGOAjU/QhcKqfuGZWlToULAvpgMJ3pFrxyeT7tT3CoqKEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QdUiw7Gd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758248128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hon/WG0O/o4tQziEvEdouvMxGkU4PNeofyIC4EEXTHE=;
	b=QdUiw7GdL/8sBHtdVflq632vEVNdWgnwWbu93WG195rUWmV6Big12BjNMaHGOni98egwHL
	ZlKFV5QrfMKLkD+K7EXziq53UDwDiulkGZuQqIvSgayFBSNUU0KhcP6g38DIaWei5a41rc
	2x3jQ2v5iy8wq7OESSgBZ0qPXpuYQc0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-IRiAoD88NZu7UXuK-OzNIw-1; Thu, 18 Sep 2025 22:15:26 -0400
X-MC-Unique: IRiAoD88NZu7UXuK-OzNIw-1
X-Mimecast-MFC-AGG-ID: IRiAoD88NZu7UXuK-OzNIw_1758248126
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-329dca88b5aso2870446a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 19:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758248126; x=1758852926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hon/WG0O/o4tQziEvEdouvMxGkU4PNeofyIC4EEXTHE=;
        b=UmU0dCZBX0+G3EAE+du8mO66Tn3i54g4MtQOjAcxm3H8eFgmoHKeAEdz3UNlI2LT1R
         Hj1vPRJUTzmbbWF+DGqoReMd1vqLskGEPVBr1JaiKUFSFFDZaBQ1QhC1nWv1+NYJLeJI
         aXJjjuTMM38qA6CwCiqknq+WIIBi/W7+BuNGY4IY/40HWBVW9cRkp/Ct3s6RkiSpUTyW
         gQHiXCfIY+k896FS1+Wj68McJcu/oi7QM/vwfs5dZwuPJgrSf4R0K5V+jELZy1mco9QY
         Z/JNxOvvFEy5rXUOBPaEdZGd9NaeFKoZlPHtx46UP0q4vIjJgsQZ2yBWBlhMkeQ8BBHY
         Yflw==
X-Forwarded-Encrypted: i=1; AJvYcCWWuXvDHo9JVrx7AxwnaUbFSa7Zed2lpgK99GBOxSGYJp/8KSlN6oATOTDnFhvnN2FwCcCfty1RNSh1xQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFD/igvceeUWEyvhap6rD7GxLIsfYo7WHUqfEXruMUGBFsfZGf
	IbkY1Uy+weo9Xz2ZviKZlN+wdRDXwBJoUJUUVucDXsY7J/UcWLl8YT0hzbwitWR2M8YKyY+ff55
	xH2H23O2EOe0J0kVCzT0/DZ9JwF68+LhdAnmu75RWhpoaKIq5fyz0uHj1qZodVdtgqTNwvwhxEa
	QYcNJfd5jZGvlTL2GjdtE99jHu9QEy+eoKoUkrk7v/
X-Gm-Gg: ASbGncsoR80PSGkPRISsYfZPVFpoLSRgb+3K5pYvXirLSaKQVdkP3xEmuJOyV0n/KdP
	2Wvkh4ozT/T018DEeyCjJLaM8CNsY3pJ9lMTJ9CZ8sYMBMMY01B88XOyjXkdNV7WXAWVSVrnfL3
	TvsFChpdV3i/lHrljOiQ==
X-Received: by 2002:a17:90b:3ec6:b0:32e:3592:581a with SMTP id 98e67ed59e1d1-33093d5630bmr2200616a91.17.1758248125850;
        Thu, 18 Sep 2025 19:15:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU3QigVP/CkFU0DUFTM5LxGNMjxHyqcwQHsW8IDna9AM7xjUdtB1ux6vI0hHWIZ2a8eLexcJHVSHpoHkdDW44=
X-Received: by 2002:a17:90b:3ec6:b0:32e:3592:581a with SMTP id
 98e67ed59e1d1-33093d5630bmr2200587a91.17.1758248125372; Thu, 18 Sep 2025
 19:15:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916130833.329087-1-eperezma@redhat.com> <20250916130833.329087-7-eperezma@redhat.com>
 <CACGkMEu4F8Spw-=ve0w45CmJhEkBMtDdRCYNDorA6NxunkuDaw@mail.gmail.com>
 <CAJaqyWfqNX6E89Z4Yz373V6r1xLzJVNon5A_fCdU=79nAk6CRQ@mail.gmail.com>
 <CACGkMEurRDttMmrKzA8Wc4afBZi7T8wbLMfFS1wAEgabbVbAtA@mail.gmail.com> <CAJaqyWc725Ep6MJR8=7jJdqSnJs25X++qPx0tRfGOnQr=5H2yw@mail.gmail.com>
In-Reply-To: <CAJaqyWc725Ep6MJR8=7jJdqSnJs25X++qPx0tRfGOnQr=5H2yw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 19 Sep 2025 10:15:14 +0800
X-Gm-Features: AS18NWAYT-A4iOYLtH4jVpcpuIQrEeDENxE4N0RAkJxW5WeUNBPhrPNLezEW-8I
Message-ID: <CACGkMEsUXQEVZK52yEnD0rUumb4Sqeia=JGSjP0KnKX3=d0=1A@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] vduse: add vq group asid support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 2:58=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Thu, Sep 18, 2025 at 8:07=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Thu, Sep 18, 2025 at 12:41=E2=80=AFAM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Wed, Sep 17, 2025 at 10:56=E2=80=AFAM Jason Wang <jasowang@redhat.=
com> wrote:
> > > >
> > > > On Tue, Sep 16, 2025 at 9:09=E2=80=AFPM Eugenio P=C3=A9rez <eperezm=
a@redhat.com> wrote:
> > > > >
> > > > > Add support for assigning Address Space Identifiers (ASIDs) to ea=
ch VQ
> > > > > group.  This enables mapping each group into a distinct memory sp=
ace.
> > > > >
> > > > > Now that the driver can change ASID in the middle of operation, t=
he
> > > > > domain that each vq address point is also protected by domain_loc=
k.
> > > > >
> > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > ---
> > > > > v2:
> > > > > * Convert the use of mutex to rwlock.
> > > > >
> > > > > RFC v3:
> > > > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a=
 lower
> > > > >   value to reduce memory consumption, but vqs are already limited=
 to
> > > > >   that value and userspace VDUSE is able to allocate that many vq=
s.
> > > > > * Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
> > > > >   VDUSE_IOTLB_GET_INFO.
> > > > > * Use of array_index_nospec in VDUSE device ioctls.
> > > > > * Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
> > > > > * Move the umem mutex to asid struct so there is no contention be=
tween
> > > > >   ASIDs.
> > > > >
> > > > > RFC v2:
> > > > > * Make iotlb entry the last one of vduse_iotlb_entry_v2 so the fi=
rst
> > > > >   part of the struct is the same.
> > > > > ---
> > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 324 +++++++++++++++++++++--=
------
> > > > >  include/uapi/linux/vduse.h         |  51 ++++-
> > > > >  2 files changed, 284 insertions(+), 91 deletions(-)
> > > > >
> > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vd=
pa_user/vduse_dev.c
> > > > > index b45b1d22784f..06b7790380b7 100644
> > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > @@ -93,6 +93,7 @@ struct vduse_as {
> > > > >  };
> > > > >
> > > > >  struct vduse_vq_group_int {
> > > > > +       struct vduse_iova_domain *domain;
> > > > >         struct vduse_dev *dev;
> > > >
> > > > This confuses me, I think it should be an asid. And the vduse_dev
> > > > pointer seems to be useless here.
> > > >
> > >
> > > The *dev pointer is used to take the rwlock, in case the vhost driver
> > > calls VHOST_VDPA_SET_GROUP_ASID (or equivalent) at the same time
> > > vduse_dev_sync_single_for_device (or _for_cpu, or equivalent) run.
> >
> > Ok, but having it in a group seems odd. A better place is to move it to=
 the as?
> >
>
> If we move to the as, we need to take the lock this way:
>
> read_lock(vduse_vq_group->as->dev->domain_lock)
>
> But the lock is protecting the vduse_vq_group->as change itself, as
> other ioctls (SET_GROUP_ASID mainly) can modify it concurrently.
>
> We can assume that *as will always point to a valid as, its change
> will be atomic, and all the as->dev points to the exact same
> vduse_dev. I can buy that, but it is a race anyway.
>

I see, let's keep the struct vduse_dev *dev pointer as is.

Thanks


