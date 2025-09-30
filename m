Return-Path: <linux-kernel+bounces-838120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC1FBAE7CE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 22:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9F4C1925430
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39562288C89;
	Tue, 30 Sep 2025 20:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lG2h+PbT"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E9E285C90
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759262568; cv=none; b=bc0DCvauXIkvWZBhfNb7qAgoAXm3V/Zcx9N/yXIBk9VakHaZ9CkDnKoVE+9uTeHT6g3RXvRNEJ/vADJc5j3+K9OTkpy1FGYZNtbcVLzMOh2f8w5V4ocwOfmlMU347f+XzM61gX/XyCOoBXFFjD/kzBgdKCZ3u4jKnoTMfj3c26M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759262568; c=relaxed/simple;
	bh=b4Yne0Qw6q2ZXPRXF3jBjLK4x5kjmQpjIHFFtEPHqCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D0vKaxNUnaLG9/MLhBzMTyy6jW+nEn9ibYX15qbJJmvdtJHOO8iMGux56nVebFhAT5nTYpwPXkC8X4qCKozjBC71UJf4tLDOYbv5EilwYbdABbyqyqVimhrizQ+bXWSYakV40fE+Lk5olIQ7lkX9BiRETSCWJFwfSR4G5aUX+Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lG2h+PbT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2731ff54949so1945ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759262566; x=1759867366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmjWU3TtlONkR58FzLBdx1M37tT6PGpX+MejoGqz+FU=;
        b=lG2h+PbTY2rW1yU8QXMS1vUp1yTCefg1cjn2u22OYYFw4tybexeRxSHIyBQoHEQ+5J
         HaqnH0scvG8EclV6HXa982jiJ76zs8BwccWX++W72FRX0VuBIJm+kEjlWE8xlxrmkgbd
         8eDz8hQRu6dugaaSQRVcVyd2ZpW6Mz/Nu6vL3WG1Es0+3Uqi09lZWxLYZjL5vW+XZocK
         Sh3hlWPKXNvM1TQc6RcbDOuoq/TPXD5Y7Kmyl24Q42hjDycsqur1t+SvLsVfBGIZiMkJ
         CWj0De/gj8Mm4SAp/u6S2Lm1xNvNTRfNbw/5aVazxYSZ6vzybkC+3t7UF6MF3j6dO8GK
         962A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759262566; x=1759867366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmjWU3TtlONkR58FzLBdx1M37tT6PGpX+MejoGqz+FU=;
        b=cU2AE3Qn3T4Z2EkZb3lj+8DXC8oX+CP+rRKUnwTccxX2KiyFLblzFWPWQG07Qrk6vD
         jxzFBABPX8MPy3HGYJQkQWbs4CyNgq23Ki3oW4XbVjiELREZWmNRzYhR503bEIm6kNST
         QBs/jLS3PD9ld/JYBkC3q6vw/l0bqoETuZDbiJ8kEkpWk2mgYmF6cqzBzpDRaddpqv0I
         hEVXC+Gb4l93MRPrpb+jFY16g09eGCP6ge78SRLSeSG09Mwu/08I3IGBSYttAf9Ppu7S
         99hxcZvKuLuBDOKV0T6nYgPTtmYTTwxFZPbGeiwUb8ByryPV/q+s86GPzSQiEj+9PpoP
         yheQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNRLFLz5LP9gm0gIAxqlO0nxdVgPR56XdEaS9G7v4RWoUIOr89efPrdADcoBz4WpYMOsuuKbPwrKaGnDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzqznOAu/pq+V/U6lZ7B0sbXvFsGRxYQ6hh4CRQHqqrDEIP7ES
	ROALrEOKhgojSfECkFVvoZ5Mg+TkEdU/dpzblrwir1mmQ11pyacVaAuhhbMs3bYYnBBc3fZKDRv
	9ntozGTEtohi8r2nfrhxUgayZ4AeTB697x28L3UPk
X-Gm-Gg: ASbGnctqkEtD7kADIPwxDqsXQbWGIDwaz11oO2a/2XQ9qaavoEM8Us9a60IcqPzM38p
	x8QI0apt158k1db9VTzJdjiw5uJCNzGkzzyZUlrg4VOiTtZ6SWR2iH41UGX466XLgqp5B2Y2lqO
	pyDxzvGDyHuin+1qY8gjcdcTK7vbD0TRQ6OM1weDLYOZoHGCg9+VjQmsnbU4H38n3OWEzEhTD+8
	rOpbOZgfwbgzwnqFh+nuir2taC6+uhIBr7u3q2d5Dins4wLn4CqdVDJ62hOa3+5jcA=
X-Google-Smtp-Source: AGHT+IHx+YJ6OoU2Vttd31DlFqYP5qTmJncBxyHWUS5OUKKuJ74sIZfzXDXkPor8ehJoA623CmmYP8vJePvPpHHmT/U=
X-Received: by 2002:a17:902:ce07:b0:266:b8a2:f5d8 with SMTP id
 d9443c01a7336-28e80054fc2mr915285ad.14.1759262565821; Tue, 30 Sep 2025
 13:02:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com> <20250928190624.3735830-14-skhawaja@google.com>
 <20250929160034.GG2695987@ziepe.ca> <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>
 <20250930135916.GN2695987@ziepe.ca>
In-Reply-To: <20250930135916.GN2695987@ziepe.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Tue, 30 Sep 2025 13:02:31 -0700
X-Gm-Features: AS18NWDlBEef52YzHXVxaMZeX4cRlUtI0dF5L6bXYHvYPPunK-J_lTtDOKzdu1o
Message-ID: <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev, YiFei Zhu <zhuyifei@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, Chris Li <chrisl@kernel.org>, 
	praan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 6:59=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, Sep 30, 2025 at 09:07:48AM -0400, Pasha Tatashin wrote:
> > On Mon, Sep 29, 2025 at 12:00=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca>=
 wrote:
> > >
> > > On Sun, Sep 28, 2025 at 07:06:21PM +0000, Samiullah Khawaja wrote:
> > > > +static int iommufd_save_ioas(struct iommufd_ctx *ictx,
> > > > +                          struct iommufd_lu *iommufd_lu)
> > > > +{
> > > > +     struct iommufd_hwpt_paging *hwpt_paging;
> > > > +     struct iommufd_ioas *ioas =3D NULL;
> > > > +     struct iommufd_object *obj;
> > > > +     unsigned long index;
> > > > +     int rc;
> > > > +
> > > > +     /* Iterate each ioas. */
> > > > +     xa_for_each(&ictx->objects, index, obj) {
> > > > +             if (obj->type !=3D IOMMUFD_OBJ_IOAS)
> > > > +                     continue;
> > >
> > > Wrong locking
> > >
> > > > +
> > > > +             ioas =3D (struct iommufd_ioas *)obj;
> > > > +             mutex_lock(&ioas->mutex);
> > > > +
> > > > +             /*
> > > > +              * TODO: Iterate over each device of this iommufd and=
 only save
> > > > +              * hwpt/domain if the device is persisted.
> > > > +              */
> > > > +             list_for_each_entry(hwpt_paging, &ioas->hwpt_list, hw=
pt_item) {
> > > > +                     if (!hwpt_paging->common.domain)
> > > > +                             continue;
> > >
> > > I don't think this should be automatic. The user should directly
> > > serialize/unserialize HWPTs by ID.
> >
> > Why not?  Live Updated uAPI is handled through FDs, and both iommufd
> > and vfiofd have to be preserved; I assume we can automatically
> > determine the hwpt to be preserved through dependencies. Why would we
> > delegate this to the user?
>
> There are HWPTs outside the IOAS so it is inconsisent.

This makes sense. But if I understand correctly a HWPT should be
associated one way or another to a preserved device or IOAS. Also the
nested ones will have parent HWPT. Can we not look at the dependencies
here and find the HWPTs that need to preserved.
>
> We are not going to reconstruct the IOAS.
>
> The IDR ids of the HWPT may not be available on restore (we cannot
> make this ABI), so without userspace expressly labeling them and
> recovering the new IDR ids it doesn't work.
>
> Finally we expect to discard the preserved HWPTs and replace them we
> rebuilt ones at least as a first step. Userspace needs to sequence all
> of this..

But if we discard the old HWPTs and replace them with the new ones, we
shouldn't need labeling of the old HWPTs? We would definitely need to
sequence the replacement and discard of the old ones, but that can
also be inferred through the dependencies between the new HWPTs?
>
> Jason

