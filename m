Return-Path: <linux-kernel+bounces-837847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4510BBAD95C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92C68323C19
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E73306B35;
	Tue, 30 Sep 2025 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="KTxa04hv"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93030217F55
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759245041; cv=none; b=rfNRN9Vbkrimbns0d8eskrzplmD5VQ21MFAoLa30JZPE4TebBNlZqO7M0bprzJX/w92raeFdCILwWOBy+wZd0kxR/b1N2FV8bZWPVuIpR+JwYi3w0U3O7fyvlG/tc/nUbiFiOgB+C2j8Ef3+SGYmYNRgEGIAUALfSi6gGAmy300=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759245041; c=relaxed/simple;
	bh=/oRJeb7DGkI5trDZKieCsAvs0tLoEkJKE9QVEtLyRXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hFDpZNzYRBZilGZwCGTM9C3XUMN6airL8M8m1WPZaRWyhdl2OLRvJWdL85iGJPHA8sGntT86LDqyg0uo/GpXwuYFfSsCVFJ3fA9HW3ypOa/dliBm2OUPae3AUNeVPTTOWvjyYb+TY2QDKBKqv/Gunrk1Ll3WvEt0K5O79Y06HtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=KTxa04hv; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4da7a3d0402so75893811cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759245038; x=1759849838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1xb6a+2PpfbKKBMnFwliVMTG3PqkR2AO+nTXR03sac=;
        b=KTxa04hv2VmrpjKofruzpEeQQDkYb/EtdzJEOC4zc7KIyw3t3DjVIHzQgBE5vzkUXH
         crfvDbvh3Z1XCEZSpefNvTg3BukYwA/kxsoiUzETdpx2R1mlPAH+FKE1Sz9GCkXz6/O5
         4iBy7CFHlYtCGjLv9f/34IxJQdOWug14WJG0iVzRgvsSFp4SL7CPZ90skTijmgSBaZoZ
         DW+G/RRmYo4iYJMSGTYxa0PDcjCkyqnUSIEuOL+i9b/gMySDJge9bkeOZb7CEFRfDhz8
         6mb/W1peHlMmA7/aSTlxTyQRnNxKib241cUydsoqxmxcwX5UBjtlgJ8AKMD9didfzgDB
         6vcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759245038; x=1759849838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n1xb6a+2PpfbKKBMnFwliVMTG3PqkR2AO+nTXR03sac=;
        b=fxLNC01uesSTn/sLfbWrIis8KQIAjM/iz8LQddmiFM2+pTjXThy9t8FJpFk1BAyhUS
         +OmdWy95LeQsBqCuXNz3lKpdQr2c/GbMg5BQ9fO2ppmZCcDaNHjX5nh5NtASvIBsV1V5
         NSN73BVllLl4wdXAWcVEyWh+rkBaM3028KDNW0NVlUDpcuN2Ci3i5el0poIxoBh1shDc
         PUylp3VY+FQbIaDvryaunOIGVTom+VckVdyJa5a47Nw7Q1VAJy2iAHpBVVVMZJddkmEO
         SvT+lmcm7yxwhLKKATx6FIYqqHyd8VBQkGc0/Hu6F8Y+VfeDVvSRT+SONWPK13Ksd3Zk
         AavQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRNf5FQ/8TpWUew/l10UMPfx/+gVcntFW1QGM/zv3CBqg/xxeQChz9dEJ7yStFQzzFrNeX8ImcYeLbaR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCrfyu+wmWOpwGQXmuTCO1QTN3NczqI1h5cPrRHd2bmFugIaOF
	GIivFGWj0KCDZzYHFcfGB7LZz1kvjJ+Dtf6WXkxzhJ5W8qgRI0HYzOJbwhDAQ5mS2J84OhgYDxU
	2JU2vxsK3EFi7aY/eE8I5S2DLzFNZImwTqhHFTTAqtQ==
X-Gm-Gg: ASbGncv4Dvun5IBCiVIxXzIFbRjFGADaj5h3mBOs/eiHbDSjZPpKi0Lrl0CU2gy5yOR
	iFDywbN2TLD7tqfBLYZrYQ34zQ1qIeYTWI3rIm07ZsH5tliDBZhLW9r0bpqKJDtdD2klHahAn3x
	JDt+JkoMxQnn4nYC/raT7Bujle0BFZ2HUpfpeuK5NuclckElNhBmAUyKR+fTK5eKoMkQA/EO6QG
	tSG+np5aLnCY7A9hj9Rpsfg+DlO
X-Google-Smtp-Source: AGHT+IGiV3j5LpiB9kffux66sQ9Mdg2TUQqos6qaVH2bgGa+tmWH25t6LFAZuJa6A12b7cKlewiqaB+wKEcJg4qlmLk=
X-Received: by 2002:a05:622a:2512:b0:4cf:6b60:8813 with SMTP id
 d75a77b69052e-4e4046b4c5amr3806051cf.2.1759245038318; Tue, 30 Sep 2025
 08:10:38 -0700 (PDT)
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
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 30 Sep 2025 11:09:59 -0400
X-Gm-Features: AS18NWCblimmsvYOgaNy7fesTvLr6J5LauXbqD7JnLPAapSwlA-9Rw_VkQ7GVVI
Message-ID: <CA+CK2bAtChLRVyQftBMN18SKt2o7FcV0q-YUcPS9ZKn2qD87mg@mail.gmail.com>
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Woodhouse <dwmw2@infradead.org>, 
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

On Tue, Sep 30, 2025 at 9:59=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
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

The way LUOv4 is implemented, "LUO sessions" are always participating
LU. Once a user adds file descriptors to a session, that session and
its contents are automatically carried across multiple consecutive
live updates. The user only needs to act if they explicitly want to
remove an FD and opt-out of preservation, or close session. This is
consistent and convenient for long-running VM that should survive by
default.

I was hoping for a similar "preserve by default" or "opt-in-once"
model for iommufd objects that are put into the LUO session to avoid a
flurry of IOCTLs to re-register before every single live update.

On the other hand, userspace still has to issue IOCTLs after retrieval
to bring the restored FDs and associated objects back to a workable
state. Perhaps, we could do something like "Yes, I'm actively using
this object again, so please preserve it if another live update
happens." ?

Pasha

