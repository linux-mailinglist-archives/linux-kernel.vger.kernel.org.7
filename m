Return-Path: <linux-kernel+bounces-766789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86828B24B35
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2733D189C7F4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFAB2EA167;
	Wed, 13 Aug 2025 13:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="CYLpPAZK"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1E82E7F39
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092988; cv=none; b=K92QYJT9/aWacHif1D8oQUS+iz4n+P6lwMhhlWHDJL4QrqX1x4bLQem2mxb4hBCITsfF3G9Hj7pcT/46+3J8V/nUBw2uah2xPSl1RWFFmG1QuQnhLX+jGFEmc3J1oasbpzwRk+WydQ97Eeq1/bgsCTLSw+StuTt+1gbzu4hwJfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092988; c=relaxed/simple;
	bh=tjiy6lq7zUfoy7QhTySB92H1/vQWjMoW9kYs9mRlj60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oKrG2eSMrENi7B9eKfNGLh7ZadTGNdVHhKHXspsFJKcGIUI7H7t11lo5Mc2O2u8al8gBFvJ17Uj9V9Rv5wFyUTv7/FERNuYyCfoU9h+0JeNdrIQeWMr+40nXfI0AVEfhoQiQ/7gdyKlv8WSiQIBa16axJuqfZJ/8VsqVPQru/s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=CYLpPAZK; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b0faa6601cso9980331cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1755092985; x=1755697785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5COPJ1bhIrlUBdoMgcmCT1dlQIxGjY3lpdJsY0vxHvo=;
        b=CYLpPAZKQShpwEUsNee6RM4kJnUJPku1C/MQYNOe/wnPVA5nW2BKgAt1P1Qd8z89nW
         3UtpVGFG3IKSpUYRpGP4xEOZPpe4ziX5OZepo7criuF/tePoWvlr4yv0hTFZKmgQZI4k
         VQUSLZjp6YrmB0xiF14ed5T0A0SiZIpyA1wMp1Sds5IooxGok3m9ud2CPdLLBq6MDLhj
         KPmeuvzKihC4FqfvrU71scgVCrIzuCp9x1FTnxYbscMeB1lss3m2+En/hx6Zuqqs+k06
         9qhgvDn1hn6kcvSvreQ1PTIR+age4FM1u9iMaS0Vbc4R7zAXprlU4SM3S8Vb5iJdYS6j
         GOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755092985; x=1755697785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5COPJ1bhIrlUBdoMgcmCT1dlQIxGjY3lpdJsY0vxHvo=;
        b=pBjxzMvc/ma7vCUzx8uj9fMUbXsQ5T/3H9DnTQYnGkaQBg73qP9MeLbxec/eoFNfyO
         Txm/OMXt4XUpSRWz9cmR4bmd3+PZVMqaTuDvbx3wuyBPesVE/COAd3vBH5bL9lEROlbZ
         c1N/0059wzNswuvtnp2WBfqZK8KuNIeBH4Dwh/3YlSOu06sqw49GX5u98SfyHORFrBd0
         u7MjDGwpKymhijaI3dM684wfDiaqJfMSK6yow19Y0rFBUWb2NRlrEGP/F3H3MQTNotL+
         linBt60cshf3GZOAVQC2Uyw1oGyrmnIta2bt/tq0iquQ9SseMFzYzHIPPGyL220rMmmn
         ZATg==
X-Forwarded-Encrypted: i=1; AJvYcCUJcEmBX5Yl3axZLifzxEOS3PxpKlZfvtxnqPoMuo1SK5RII2RUZdjxrH8Xm0/Ztz2sr5rH7y0wQkDbNrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwREzlj4Scu+Ew1/1YcqIPiVd8+ulBxo9lBJMowVs+zkTU9nJG8
	wI2Yb1FMzyh3rQ62xNRGojQr2Ue846qvr6dARRjZf2T+EBHqSPGj7m6N5H/juJP8/j1S8aM5gZG
	qR8ClKWX3iVETPd7OIRbDlWVKfHSyANJUbEmLt8nMvg==
X-Gm-Gg: ASbGncv3GIsvgzdzWKPnDMqak/w1ZN4f0zXljdVXPR0bHjygzcVj9MZpovhNrn+MsNz
	fM3yjCcqvcMHHn47fPHAYVctJBOdPskzHKgNgQf3syUS4n9SiLLGDCjpcvz03fDgcQgl72HI/Yo
	30HgAv1eURgyvoILP49RswjlAiCCfhtVfRVnRzKeQMl63d35J24TNjJ2jOL2Xder0y2yghVVk54
	LN+
X-Google-Smtp-Source: AGHT+IGct8ZeidsnGi/YbFJu4oMvwbFYwPG2diux+p27hnjphdKkPPw2dpGSZ3mXdM1D29x0JXCw0Y4/KsFGm7KlPlM=
X-Received: by 2002:ac8:5d55:0:b0:4af:4bac:e539 with SMTP id
 d75a77b69052e-4b0fdfdb678mr31989691cf.3.1755092985396; Wed, 13 Aug 2025
 06:49:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-30-pasha.tatashin@soleen.com> <20250813063407.GA3182745.vipinsh@google.com>
 <mafs0wm77wgjx.fsf@kernel.org>
In-Reply-To: <mafs0wm77wgjx.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 13 Aug 2025 13:49:09 +0000
X-Gm-Features: Ac12FXyj1CElzNmOfajT8FxAkTu6tjsBaL5e4YwqAjZVvEs1xx2b7a4U9Pkl3Fk
Message-ID: <CA+CK2bCmQ3hY+ACnLrVZ1qwiTiVvxEBCDNFmAHn_uVRagvshhw@mail.gmail.com>
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Vipin Sharma <vipinsh@google.com>, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 12:29=E2=80=AFPM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>
> Hi Vipin,
>
> Thanks for the review.
>
> On Tue, Aug 12 2025, Vipin Sharma wrote:
>
> > On 2025-08-07 01:44:35, Pasha Tatashin wrote:
> >> From: Pratyush Yadav <ptyadav@amazon.de>
> >> +static void memfd_luo_unpreserve_folios(const struct memfd_luo_preser=
ved_folio *pfolios,
> >> +                                    unsigned int nr_folios)
> >> +{
> >> +    unsigned int i;
> >> +
> >> +    for (i =3D 0; i < nr_folios; i++) {
> >> +            const struct memfd_luo_preserved_folio *pfolio =3D &pfoli=
os[i];
> >> +            struct folio *folio;
> >> +
> >> +            if (!pfolio->foliodesc)
> >> +                    continue;
> >> +
> >> +            folio =3D pfn_folio(PRESERVED_FOLIO_PFN(pfolio->foliodesc=
));
> >> +
> >> +            kho_unpreserve_folio(folio);
> >
> > This one is missing WARN_ON_ONCE() similar to the one in
> > memfd_luo_preserve_folios().
>
> Right, will add.
>
> >
> >> +            unpin_folio(folio);
>
> Looking at this code caught my eye. This can also be called from LUO's
> finish callback if no one claimed the memfd after live update. In that
> case, unpin_folio() is going to underflow the pincount or refcount on
> the folio since after the kexec, the folio is no longer pinned. We
> should only be doing folio_put().
>
> I think this function should take a argument to specify which of these
> cases it is dealing with.
>
> >> +    }
> >> +}
> >> +
> >> +static void *memfd_luo_create_fdt(unsigned long size)
> >> +{
> >> +    unsigned int order =3D get_order(size);
> >> +    struct folio *fdt_folio;
> >> +    int err =3D 0;
> >> +    void *fdt;
> >> +
> >> +    if (order > MAX_PAGE_ORDER)
> >> +            return NULL;
> >> +
> >> +    fdt_folio =3D folio_alloc(GFP_KERNEL, order);
> >
> > __GFP_ZERO should also be used here. Otherwise this can lead to
> > unintentional passing of old kernel memory.
>
> fdt_create() zeroes out the buffer so this should not be a problem.

You are right, fdt_create() zeroes the whole buffer, however, I wonder
if it could be `optimized` to only clear only the header part of FDT,
not the rest and this could potentially lead us to send an FDT buffer
that contains both a valid FDT and the trailing bits contain data from
old kernel.

Pasha

