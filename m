Return-Path: <linux-kernel+bounces-836806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C4EBAA9A3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 22:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A05E1920998
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 20:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD88D2561AA;
	Mon, 29 Sep 2025 20:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QLkuzcxK"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1BA13A3F7
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 20:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759178564; cv=none; b=ios+/5dd+kCPWdOTx+anrFVd03T1k3LIBKE8URh3dz12ZDk64Qi7yKjttaSAG3BHby/kEQnvaKr/n3Wf3G/10f6hAUTYai86vZlqEJDqpvELmHt+sHffsheQWFZD4qn4LSTI2wU16G6w6v6BiPCEDYR+nEKaA5K4RZRDpjpnmuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759178564; c=relaxed/simple;
	bh=oXJgIjEe3L2FI9kbI9ch0+g3fkejnXAUjmTtn7Kifx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gs/zuobY+dXRw5K1mA5EOAk9LMOl5f8S92QW3Jf5jy/Aqx98cqbxFaAqY0AG121txhIT6nu/zqIZllL0arTPV90WUWI5Yjmpis7fUECW/iNDY0+9dmdpk+/pyVATT5GUUVXWqk5fsopsowfz8LZ45kqugCY1B6kg+5qurjF5hrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QLkuzcxK; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4df3fabe9c2so25211cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 13:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759178561; x=1759783361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEC74i6THPBvyxToCwC/1HpM1gtTzCHhQKVMM5vaV7E=;
        b=QLkuzcxKa7R3ra7VcZvRbqf+IRYTNSHwo6DPMzGBxjSshkMk8C0NFJcGMzYI9RIxVE
         /373bMtODBHD+SdRwTGNtSs4de+DsJ+pav1hHtuqGMvfNSZcnt79RYden9R51KA+zbvm
         W7l8t7gf5HQCV2Bd2XyEZ/RGwb2WobeimiWSJEBJtTRyXCROmWQtYpWBGUCC9IF4cB7y
         lGZ4+cyO/dp1qVRRIb3BijapR2Lxvj43BTLrqQsyK8M3Om+6Tjr1JV3WjIzFCp5thorQ
         fPf8SZPgCyQwAnp8Fv57z6En1CZJgzxeqs12pSL5m48T2WPMl/g+H4LOmti6jJiGs9tp
         IxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759178561; x=1759783361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEC74i6THPBvyxToCwC/1HpM1gtTzCHhQKVMM5vaV7E=;
        b=Eq/NqvsMPl0bOoegTBk6ze3td/md/y7+EbOT+ZrFhSa7f1ztlQZpoHvrD1qCwXZP3K
         FT9mKlYwC412H59RZNXq8ZaCjvseEOPc7B1KHLBMKQuV6GwMUMKHUKHVFvc+QDyDdmY6
         6foBh4NZR5Q8Il8MBnDhVLPYrCiE8dsN/2eBbMhHhdhqe4mKHnE9UNf2lo8oJfV20n5P
         zevBFHnWoNqbzJIGiyFoHYGV2zWh7ZiXJJjvoWxalEODr29h9/ZJu+HD76gneqhdU1zq
         2QwbsCcSu7w2ngNjZaeWD5nM8HrfK3sOh/bzpZYQHlppyCclqhVp3xwUojxnB5jzMZG4
         JCVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgm7yji6pLMyXHiEslarxAoEW2XdorcBw/o06U6RBnpfVQaL2NBXIxtjrw6fhrVVd6mX2+AoNz8a+aPbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGw7oo4Ik3ZR0U1dINrxNrcg2kvxa4zdroUDS2XoQz0fXglHLT
	R4PjRyVIz/yFSII2Ird7Efge+nfWRfLvLD6FN8eIJCMpqSWHx3DbuF4Ldff0O6FJDEYtakonEZz
	VjrRXHyJke0iLIUJzSjzTqFYbNrdKCZBxFO0/bMmg
X-Gm-Gg: ASbGncsHSdqw/filIr+ISA4yvIoCjQv1Oe0t7WibpvYCPIIvgEUiyK+3taruS21o7RO
	74dn5WjRboQ+yBtn9Hkve8d05evZkIwQnPmgfsKljJeOHPUklos3FoeM9j5FHqMze7DZUjjxfzk
	V+j73o74SKPR0OEPU/LotV0O0SQNAD5TybwFwvkbj0VcWt98+YmfE1E41drwWwxifbcSUYyMIMr
	Mwsw6WLv20=
X-Google-Smtp-Source: AGHT+IEwLQc5fvRUVGPyGy8NV0Qi19qFJZstfSg+2T66md9AyC2s/4sHLcp2+Hx+syyTPDNwiHIA8qqIMcHvs2IsWFw=
X-Received: by 2002:a05:622a:1486:b0:4d1:b2d0:2e2b with SMTP id
 d75a77b69052e-4e2d0df3039mr1922061cf.6.1759178561226; Mon, 29 Sep 2025
 13:42:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927223953.936562-1-danielmentz@google.com> <aNrks8eXTfHyVhKl@google.com>
In-Reply-To: <aNrks8eXTfHyVhKl@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Mon, 29 Sep 2025 13:42:29 -0700
X-Gm-Features: AS18NWClVxUbv-JzilVwbpc6ZKlxzRQDsp7pvXXSKlzjb8hhrBGe7HxydTOUiSs
Message-ID: <CAE2F3rCZhgLOPKMmAqvNaQt3mUdj0kez9_MDxM3nGVOpgr5wuA@mail.gmail.com>
Subject: Re: [PATCH 1/2] iommu/io-pgtable-arm: Implement .iotlb_sync_map callback
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Will Deacon <will@kernel.org>, Mostafa Saleh <smostafa@google.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Rob Clark <robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 12:57=E2=80=AFPM Pranjal Shrivastava <praan@google.=
com> wrote:
>
> On Sat, Sep 27, 2025 at 10:39:52PM +0000, Daniel Mentz wrote:
> > +static int __arm_lpae_iotlb_sync_map(struct arm_lpae_io_pgtable *data,=
 unsigned long iova,
> > +                           size_t size, int lvl, arm_lpae_iopte *ptep)
> > +{
> > +     struct io_pgtable *iop =3D &data->iop;
> > +     size_t block_size =3D ARM_LPAE_BLOCK_SIZE(lvl, data);
> > +     int ret =3D 0, num_entries, max_entries;
> > +     unsigned long iova_offset, sync_idx_start, sync_idx_end;
> > +     int i, shift, synced_entries =3D 0;
> > +
> > +     shift =3D (ARM_LPAE_LVL_SHIFT(lvl - 1, data) + ARM_LPAE_PGD_IDX(l=
vl - 1, data));
> > +     iova_offset =3D iova & ((1ULL << shift) - 1);
> > +     sync_idx_start =3D ARM_LPAE_LVL_IDX(iova, lvl, data);
> > +     sync_idx_end =3D (iova_offset + size + block_size - ARM_LPAE_GRAN=
ULE(data)) >>
> > +             ARM_LPAE_LVL_SHIFT(lvl, data);
> > +     max_entries =3D arm_lpae_max_entries(sync_idx_start, data);
> > +     num_entries =3D min_t(unsigned long, sync_idx_end - sync_idx_star=
t, max_entries);
> > +     ptep +=3D sync_idx_start;
> > +
> > +     if (lvl < (ARM_LPAE_MAX_LEVELS - 1)) {
> > +             for (i =3D 0; i < num_entries; i++) {
> > +                     arm_lpae_iopte pte =3D READ_ONCE(ptep[i]);
> > +                     unsigned long synced;
> > +
> > +                     WARN_ON(!pte);
> > +
> > +                     if (iopte_type(pte) =3D=3D ARM_LPAE_PTE_TYPE_TABL=
E) {
> > +                             int n =3D i - synced_entries;
> > +
> > +                             if (n) {
> > +                                     __arm_lpae_sync_pte(&ptep[synced_=
entries], n, &iop->cfg);
> > +                                     synced_entries +=3D n;
> > +                             }
> > +                             ret =3D __arm_lpae_iotlb_sync_map(data, i=
ova, size, lvl + 1,
> > +                                                             iopte_der=
ef(pte, data));
>
> I think we must check the returned value here and break the loop on
> error. Otherwise, we might burry a failure by continuing the loop.
> We should add something like:
>
> if (ret)
>         break;
>

Now, I'm realising that __arm_lpae_iotlb_sync_map always returns 0, in
which case I could change the return type to void. Would that work for
you?

