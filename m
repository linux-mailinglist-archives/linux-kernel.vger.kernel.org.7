Return-Path: <linux-kernel+bounces-836646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F051BBAA38C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 239B37A673D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD16A221FC6;
	Mon, 29 Sep 2025 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="jc9FD4NV"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E8E14A60C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 17:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759167979; cv=none; b=kzx8N9iC4tujp4H0go90yjHZQ0AU6gAKKTYV0FO2T3hYc4WbYuas8Aio2M+9uDdnU42wOoH1uDqq2NNNoTb0WcluR+NEAY9lIW/bQ2ceujz3ew2j187Jlw3YS9OjRMIYNzkiRtUSzmwFznWsqHIkJ7XZ4jhMpFQriN9GOefixVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759167979; c=relaxed/simple;
	bh=eXmObNrvqTREabEVoaPfipK3nhi82p1Oorr9WTbWpS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=urKreDperbTSmyh2qmrM0K/ckzU7ZoQwTFPI/7ZLgieuDOMKmsXez/smcdMZr1qscOv5GOOxwNnSDhFLqOlIZ3CiqWgrmTZ1GG22se0Ouj7xXvNksaRtY3PbAwVBW1E2ffR/ajwmZfUHcaKO44U0kmuqn4tWcFBMG6Ca7S5u1Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=jc9FD4NV; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4d9f7a34daaso43000161cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 10:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759167975; x=1759772775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mp5nx4TC/38dVlnjuJTLG0gnQNJPQsJ2h6t5725+5tw=;
        b=jc9FD4NVtqi1g1dy/GzRFaT8Z494GJHEz5wiBYwqtzp1o+urxM3VhQM5jxh7f0Fsje
         VuSH2mqlohJsb+LPLc6owBHODcFBH05OEiyh+J1lgm7nobBKnlwr/6Y1weTxJDzlAEkp
         v8w6y/O3j0ZXNuYPFbXkIUAfbq0BINZxlwgvkoLsQoP/c1kZ3JQCmaPQ+4Z94J3oanXS
         GdJk9zVvpPRb250ZX6kJLSDw9YZ27Hh2LQUm4C+GRTitxaZ/R4GibbJ/Lp95G7vWaesE
         WnF1zF+lImEPP/bhZKh/KnCqoLKoTZEhS7DDtiZ1ucqh3OLj5IgnkvBYAJRsikVxwinR
         mKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759167975; x=1759772775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mp5nx4TC/38dVlnjuJTLG0gnQNJPQsJ2h6t5725+5tw=;
        b=jCUoRE7dpPurS8II8dNzuQi3ayEIGeRuvm7J3zwriiBY9mFP4GYY2pBOqD8ZKgixcg
         7JzzOtEisfwzWCkN8GMUp9mx0SuSY34QgyFSlb87kzPLAuq2UEQnzYX0DuoColkhID6a
         feTteFQaIqwlY+QAyXPRB8E6FQ+1Hl8cia6TI06KXhCJ5iUiril+eXliFyFGW6C4ZwUY
         MgQovuRRUE3KJQLFiePAkqamYizY/hLm32Ak26hnUTQwc0Nmh4v4eUzky1CfHCdbJwFm
         Hn48fTT2Ch9L9sZ5y1T0zP2+vMuvA/NVP5ajP2EDx5yKMn0ypjceiJu1PiPs2zGKLN6u
         /gnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlLgt/8NI8qdOfZQy/j70W/b2zsFI9OaxKSIugQY4RVYE5jU6q6+WDeAr0gfQ421GhEiWy2xXe/7GylTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz162OnxEVLTSM3Mka66jOETxvxVV8K4N62UU0mtzfiY5/+udco
	IKMkiLjc+PVDVfYOTlmUXP2PAL5DhmagawOWH/n8oLaHgjT+TnjMvdGq7SdWI1ANdleLkDhuqhj
	BbIydJporicm3mgGSq4XiNzhAdXHTqp4j2c0XnI55Ig==
X-Gm-Gg: ASbGncs+La5CKr4+XRznXuC9jFTsm2xEbSBhOZfV1mzxgX7ILfhZefwLcDewcr0SzG1
	wiARr1T7gpiTGrl3U4706AUasTDuIcZIavOllADY7946IR3AKCdq1z0rCQ5iZ0PurZClTSgTd5O
	Q6pKP7kpUJYzVPzcrftWDMcllDbTY5rbFxvMVTt5vYpUOt7nA3XD1YeQQSK1Km+99ACP+dInszF
	2YKtBdcjvinzOc=
X-Google-Smtp-Source: AGHT+IGOnelXZkDUZzjTRtovwRCe00xrTA+7vjG5Tw/7+5pwFeMcBzkyq8GKQCfm3J+xlHW1Nz5fVVpGOss9mnAfAYg=
X-Received: by 2002:ac8:5d56:0:b0:4cf:1eba:f30e with SMTP id
 d75a77b69052e-4da482d41d6mr58945371cf.24.1759167975081; Mon, 29 Sep 2025
 10:46:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com> <20250928190624.3735830-14-skhawaja@google.com>
 <20250929160034.GG2695987@ziepe.ca> <CAAywjhS+X5o3B60hKZiioTCqT_7cYThRTz09fHmi4WnSr3ceYA@mail.gmail.com>
In-Reply-To: <CAAywjhS+X5o3B60hKZiioTCqT_7cYThRTz09fHmi4WnSr3ceYA@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 29 Sep 2025 13:45:37 -0400
X-Gm-Features: AS18NWBt_WgC2Y8Hsnai8qifkqT_eI5rwr_YhDjsltDobqYe3Ir-FVVNbB0ht3U
Message-ID: <CA+CK2bA7LK2i-AOyTwx1KNUoF5fUWEWBA49i8T_wYXBApKkUBw@mail.gmail.com>
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, David Woodhouse <dwmw2@infradead.org>, 
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

On Mon, Sep 29, 2025 at 1:32=E2=80=AFPM Samiullah Khawaja <skhawaja@google.=
com> wrote:
>
> On Mon, Sep 29, 2025 at 9:00=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wr=
ote:
> >
> > On Sun, Sep 28, 2025 at 07:06:21PM +0000, Samiullah Khawaja wrote:
> > > +static int iommufd_save_ioas(struct iommufd_ctx *ictx,
> > > +                          struct iommufd_lu *iommufd_lu)
> > > +{
> > > +     struct iommufd_hwpt_paging *hwpt_paging;
> > > +     struct iommufd_ioas *ioas =3D NULL;
> > > +     struct iommufd_object *obj;
> > > +     unsigned long index;
> > > +     int rc;
> > > +
> > > +     /* Iterate each ioas. */
> > > +     xa_for_each(&ictx->objects, index, obj) {
> > > +             if (obj->type !=3D IOMMUFD_OBJ_IOAS)
> > > +                     continue;
> >
> > Wrong locking
> >
> > > +
> > > +             ioas =3D (struct iommufd_ioas *)obj;
> > > +             mutex_lock(&ioas->mutex);
> > > +
> > > +             /*
> > > +              * TODO: Iterate over each device of this iommufd and o=
nly save
> > > +              * hwpt/domain if the device is persisted.
> > > +              */
> > > +             list_for_each_entry(hwpt_paging, &ioas->hwpt_list, hwpt=
_item) {
> > > +                     if (!hwpt_paging->common.domain)
> > > +                             continue;
> >
> > I don't think this should be automatic. The user should directly
> > serialize/unserialize HWPTs by ID.
> Interesting. So the user should be able to serialize/unserialize HWPTs
> before the Live Update PREPARE event? But what if a device was marked
> for preservation but the user never serialized the attached HWPT,
> would that be considered an error during LUO PREPARE or should iommufd
> serialize the remaining HWPTs here?

Users ~can~ serialize their sessions before system-wide prepare event.
During prepare event all unserialized sessions and their FDs are going
to be serialized anyways.

Pasha

> >
> > Jason

