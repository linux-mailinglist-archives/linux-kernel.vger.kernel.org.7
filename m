Return-Path: <linux-kernel+bounces-836621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D07BAA2E2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80B8F169DAB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797A3221546;
	Mon, 29 Sep 2025 17:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tTMy1Lrf"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F2C21FF4A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 17:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759167156; cv=none; b=d6pEuO4ZkGEnaSlCNDyDCdHRgHuWclXpC6Du5M66uoSlGufYx0zFBaORSvIT1+tqvTzBnF0pIYGGVmNRixj2T2KV1A59fAUcm5OEWPmS8/qjDKjdD4fbSmbyKV/GM2L6lI6hig7VTcDm1dk114eNQM6s0BqX4QTy1h5QtoyAsE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759167156; c=relaxed/simple;
	bh=i26tWblqD2kj5kZi8jIbcdu+RsfecXi35c3q7jgCbYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=prjwbSnDVtjENh+mLdlZ4wm7d+XJF/vqyvvjuMIxI2cbuNYRNAGuqixy/v4HvldbsO6SPutIsiIC4KFlFSBqHCkIlcrShR929tCAqkwhYySt02btrkaD5wxu1DPE7LH8hs3hjLz9bh3jeXgsbOuurcjfWANH5B1b3MgklufCjcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tTMy1Lrf; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4de66881569so43171cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 10:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759167154; x=1759771954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gP+FkFVxk3JmNmEBDG5is95S5Rx3sgEp0E99zIUcCU=;
        b=tTMy1Lrf3li7rtWOm3RCfUyaP4shb19XE17JN944nlz8W5FxNnd2PRZ0Gix9bI8nEW
         x9fcuRwpHoxueJtAoIzl9ViV6NAlpvfIDhO6+IxbgSj/nun1r9c9Phded3qZSctXSk5+
         X6mDj+WP06l4ODxRSwbtmiRHF5wE1qjFD6qKcdO8q/m5E461nugtsCQSpKx5XF6otzXa
         m5ozCpmfpSb35PfYHC6OZXN0BUDM5x+3TYzf4RTJYfgPKdTRagq7ArXqXkWso+tPPDZW
         iVQvRyfFoCvlpNfIwtIolXES2y+4jWi3s9oetfx3yo+mCSoRM40omPC6jEBLOJaRdruA
         Y0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759167154; x=1759771954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8gP+FkFVxk3JmNmEBDG5is95S5Rx3sgEp0E99zIUcCU=;
        b=Nn5ufVz/114c1nOqRj+EZeZpnfcu6bcioOZsSJEwuO8s7pixxBRJ8kP3Faxfujg1AH
         Nzsf8Ii/gklvXvPB999TM01enyvmx2M2xgnxdxYeBvB1F6jZOE8jyMw0GXzC7NIR9wM2
         1hmJn4v25Wm2y9PETFORCmUXTMnQsJXElF6f2oOXkD/fSqnbtvUip/OBlbZsaSVpaLDf
         lJ4UCVT3VAJUWKpPC5sMsNH3HGBggXTzIamawcGjprFfDOmcScQZcRY3e1MzTawrMvqO
         /hxyiU0XO31zuNcS16iEERNl8YgLpETchhchLOnZrsaTyRQrXtf3ib2tGIc35s5kThyA
         yo4w==
X-Forwarded-Encrypted: i=1; AJvYcCWVZFdqMwyZ3MgfWit4tpVpDoOKQfIV6CKEZ8I99dsYpjZiEowlDgLaeTQ2S9dhyBqxDvdUH9wg3q0n5ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnTUaj7Fu3JBxClbsF149psNYF89JFHaJUfeXE62VN1KmmLSAk
	pyW1a0CxUvIMe6uIEfc5zEQh2iHMpsgT1GlFWf8Rbsq/tD2+Gw/JivH6TaCsAzFhqOklAcQTZBZ
	6YYsX8WrjzpWzUgIR2/c2VZrPkJ+cv04io/wPAcMT
X-Gm-Gg: ASbGncs69BpOLkrWMy/4VW6FrLOu9/LApBXz0KIWyrTL8DkZFrXhdYbSNltft1ahv81
	Qk4NWZlpUAHRVIKGmuh3fzOFDwswNVq0HwGnOWDnWc+1m9svVFFhmt/KutqcjrSvhOwHK97K4os
	m2Z3TL2ovQsGRWY0AiFM68qRtq0j4eVXcovtlGDijOZ4UFKdGC/qp5Zh/XvKI5AVtKjrIm7j6zt
	Jh5Np2MSSl7lXDJ0iNKHaRDVy4tIRpUnJodubyVQglIuucZKxPLn+E=
X-Google-Smtp-Source: AGHT+IHmyRBJY+NPLhPm23O0UZCfrf2ty1VXXgGY40TDiyTQytPHueYBQlcuVku1ppOvYkhHsF7stqBYU8Ees7G0Jj4=
X-Received: by 2002:ac8:58cf:0:b0:4b7:a72f:55d9 with SMTP id
 d75a77b69052e-4e2d46ddeb5mr513761cf.13.1759167153615; Mon, 29 Sep 2025
 10:32:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com> <20250928190624.3735830-14-skhawaja@google.com>
 <20250929160034.GG2695987@ziepe.ca>
In-Reply-To: <20250929160034.GG2695987@ziepe.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Mon, 29 Sep 2025 10:32:22 -0700
X-Gm-Features: AS18NWBCZ7IARsZC6horuFBUsx85Jwy5drEC5yooq70AqjTNeQNiRqk_f-hjdnM
Message-ID: <CAAywjhS+X5o3B60hKZiioTCqT_7cYThRTz09fHmi4WnSr3ceYA@mail.gmail.com>
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, iommu@lists.linux.dev, 
	YiFei Zhu <zhuyifei@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, Chris Li <chrisl@kernel.org>, 
	praan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 9:00=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
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
Interesting. So the user should be able to serialize/unserialize HWPTs
before the Live Update PREPARE event? But what if a device was marked
for preservation but the user never serialized the attached HWPT,
would that be considered an error during LUO PREPARE or should iommufd
serialize the remaining HWPTs here?
>
> Jason

