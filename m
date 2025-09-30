Return-Path: <linux-kernel+bounces-837699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C99BACF9A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D3057A368C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4E62D3237;
	Tue, 30 Sep 2025 13:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="g28c2ui+"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D2714A4CC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759237709; cv=none; b=oFWFz7xIX3WuOdqFgTDQ/vVvAhsX0jOoKUdiBXnrrIR+WLcKd0nu9Eby2QkhSjzad5lqoYWlj9MMmRHBncia9W9KRFU7VsIjNni6XeDBeYE/8ct0SqpVQGlKJl0DodIIdbGvGvA7jspyueVlUhnDsM3S52iQv3hYnP0nu8+3IQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759237709; c=relaxed/simple;
	bh=QMo/NLhsSftlgF3+wcn015ZLW7Keu0wGP7s46oyS4Tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IJN9FIFWlUOirdVeXguQoVSyg2Xi6tmYbCDOjY+16QKedVuQguFYWqQO6/2IMdUiBfYUVPep0Od6ELhMvZ85ZpcwfVMBIwUArF9cqHzczEv59sxuGwgL/C++c0qaAvsxvHUvaqyxY80+qq8s8tPF9NQpAQ8cr8+RcnXEfvFOK9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=g28c2ui+; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4dce9229787so53360351cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 06:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759237707; x=1759842507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRcDoRpxowwRXdHrfG07NYS9MxX7g9BwMVASN54W7s8=;
        b=g28c2ui+qL3dKbIL6vmvxlTPAmZ0XbOgQyH8ZoL+0JTZfMHBC0E5eEmHcittFF3p39
         E3rFKKje8H/ORZopMSvncEx1qSvQbqAxtX2uUOxminO8yV3bsC9u+9EYmEMdzvuZVq/y
         j2CGqQ2Yslb9dbrlNhWLo8oKK5rk65Ma/79Eu3AAbQizaGnftZDOcYIfJF7cw7Io3U0v
         FpCY1pDzPX/s7kc4RMWEXe0IWmqnc+H8t/q8eLsYrTui81X6ls9IhSk/fqe3llChUIWR
         nixud6Pz2Bxg5yQvCbvONdA/W4HmjKelWV8C+ztU4ntC3aEezItLea70qjuLk3MdLFF9
         BUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759237707; x=1759842507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRcDoRpxowwRXdHrfG07NYS9MxX7g9BwMVASN54W7s8=;
        b=NY1RBWL8dOLigJcVyqjrV4CI5ykACHn8CzdyPhWalEiV6NqHINSrjL6TBnYBd7n6Rs
         GGEY/DbI41QsJhwMa+s43hkJB4JZXe+9VopWMbyb6GdpZonyQinelmB9QDRVnuJRpRpY
         6mWZBzmsy3qmMOMZOZabBa2IYvjviR6j90u6uTDswm3SwXKb8zoWFjEB2GjK96SR6/fy
         C7aDjZoX2gzrsKiHXAIunkdLQtHC9rWsc4UziWMNuBO+cKzMDI9XnHc9Be7MCN2y3YpS
         QtXIb5wUeN2vPDjPnMoZnkohk0ak31WpNdsGTjU5lrf9VhXFvz52pvw5Dwb1QCCZQt8k
         qynQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4p1TUnZNKL5aFX9oSF0cQM7zXfmZWHFC97TxemtwgnrotMxUseVRB7/Jvaas0PbaKbTIiHDweebknvOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+QyO/0LLRIdaegP9ci6tIBOWJzCTzpMw4T00dFVzi1YIxLSDP
	GN1hLmCffM+QRTDIQv3w/Y3mDsI5tx0PfrGLDBh0JfVBgVpyVNWBBC9a5OSVwC24Kk6sXAJEPH6
	Nqy87Bl8NGG1FfBVWtiEo9yBHP0dGc1T8hH/uOcwG9w==
X-Gm-Gg: ASbGnctTInS3mMfQg0u7A53T/+M6a4jFyMFAjww2J2XpiSsSIGJgJMpX6dL/03ziyV3
	2IphTYdrJVZAzrFqc9eDMKSlrKxDrmAiB6hqkYiakMLORo+9oQmUNWNb+bIhW1ZB4wtc9Hhnsrw
	+s127a2bENhXntuxJYoaJfO/dhs3GKR3Puvl6VWwU+BLYjkRUyTV0NrLQ5DpNdxdRwrpkozU3EG
	xaZ+iXsXMiit0Ddiz+2VJ33iPP60163hjCa8aveqmeuoPMzrg==
X-Google-Smtp-Source: AGHT+IFcMihqlPG0r/0rax5NoPUqvU2KK1RnwmX3J74Q6jm2qArxP58LY1QIdRkFSghRH0CiBSZeHf0F2FZ3n2h/HKU=
X-Received: by 2002:a05:622a:212:b0:4b7:a8ce:a419 with SMTP id
 d75a77b69052e-4da486b7062mr313238641cf.26.1759237706520; Tue, 30 Sep 2025
 06:08:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com> <20250928190624.3735830-14-skhawaja@google.com>
 <20250929160034.GG2695987@ziepe.ca>
In-Reply-To: <20250929160034.GG2695987@ziepe.ca>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 30 Sep 2025 09:07:48 -0400
X-Gm-Features: AS18NWAN9frLXrJzwwTE-jqpam-hhSqeSv7aVqzTjHPfUwbIPaE3h_RH3XbXIJo
Message-ID: <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>
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

On Mon, Sep 29, 2025 at 12:00=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Sun, Sep 28, 2025 at 07:06:21PM +0000, Samiullah Khawaja wrote:
> > +static int iommufd_save_ioas(struct iommufd_ctx *ictx,
> > +                          struct iommufd_lu *iommufd_lu)
> > +{
> > +     struct iommufd_hwpt_paging *hwpt_paging;
> > +     struct iommufd_ioas *ioas =3D NULL;
> > +     struct iommufd_object *obj;
> > +     unsigned long index;
> > +     int rc;
> > +
> > +     /* Iterate each ioas. */
> > +     xa_for_each(&ictx->objects, index, obj) {
> > +             if (obj->type !=3D IOMMUFD_OBJ_IOAS)
> > +                     continue;
>
> Wrong locking
>
> > +
> > +             ioas =3D (struct iommufd_ioas *)obj;
> > +             mutex_lock(&ioas->mutex);
> > +
> > +             /*
> > +              * TODO: Iterate over each device of this iommufd and onl=
y save
> > +              * hwpt/domain if the device is persisted.
> > +              */
> > +             list_for_each_entry(hwpt_paging, &ioas->hwpt_list, hwpt_i=
tem) {
> > +                     if (!hwpt_paging->common.domain)
> > +                             continue;
>
> I don't think this should be automatic. The user should directly
> serialize/unserialize HWPTs by ID.

Why not?  Live Updated uAPI is handled through FDs, and both iommufd
and vfiofd have to be preserved; I assume we can automatically
determine the hwpt to be preserved through dependencies. Why would we
delegate this to the user?

Pasha

