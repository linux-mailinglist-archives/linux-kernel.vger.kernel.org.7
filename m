Return-Path: <linux-kernel+bounces-872203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EF5C0F8BD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F5E14E4EC6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F5431355A;
	Mon, 27 Oct 2025 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeUwEU+z"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD411E1C22
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761585029; cv=none; b=FFqh5OA2/orMpjNqJkliFWeWc88q7MHrbFl9ktS8UwlYdmlqf6sX0a3zHKdjCuIj2KlYgVxmiMr9KuIoKSottT/qeQ3J6hf1fDVd5x+HFa8xvgbQRRn9WPUX1El4gvTS0jSrS/75ln+GAaOszhn6she0/FEinJi/qJEt3MG2Crk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761585029; c=relaxed/simple;
	bh=aCOnbdtwre4K09MFDJlZIDS1z+3Uag2xI0DLquWZPfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hoMvwPLX74sBGuVfjedWTPt8iNmf1UCTmx2GWatnpPXrzAFFXEeAESFple/EGpealb0BAJzMn8HbTiZmRYXUIVQ6fBsgJUOf8Xfq4o02xnrkIK1GASIYL6qmeuqj4kXUxjN72Uf15UfM9t+oOlYSOFoIIOAVTjA4CyAnHgHwIl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeUwEU+z; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5d5f8e95d5eso3155468137.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761585026; x=1762189826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yg0rbfawIn1Arrvn5hPRBZqSEKlTBCbiXBwOFnHB3c=;
        b=CeUwEU+z2gfqaCosHw2VTY+DuD00483I1eoJrg/gKHxlLi9UlcVPmBJGGZK6QjTEtV
         qSFtCrtfNgjbPkpA5kQ9BFCWXe64CnkdRrmNm1L/qU39ipx7D5QD3S8XT1smPjIS9c2N
         SSdzGVVv6h9wvw91t5rztYF2N4GLhYrbxjAokS5gHpL1PXcyoZyIsUn7PKl5KRdVkpQB
         eQMx+pNtB3dbOktmha2CZRi/XzF7ROyRo7xA3HF+8XJUSWzrDk2Uz5/0MIiqXATYlviU
         4mK3Wd7c1QfhUpPtMGcf1deyWj5wg4oiKHkqWtL1COASoHnM/qVhGpCreyB8VpF5F8Si
         qWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761585026; x=1762189826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4yg0rbfawIn1Arrvn5hPRBZqSEKlTBCbiXBwOFnHB3c=;
        b=HRlt68taPjd8VcQUQEQEUeRBr+lTIIXXZxxut8i66PmVciJu8ssh76jXeo9+2VSX1D
         CAVJ/x3Fx3+EewvLm5kr7UQiOsfr455O4zCPUA3S37CSlPzL2Y+FFc/lpfZOdIHvHr+/
         lqqCjFcZm0tUHWhvYbpI1TXYsAJ6csLPyk+3v/CqC1ZMyHduX5Y4qBclfVoTMYFNxnl2
         G2seHgSLM4swQMZFHdxOWmq92IGuLPJ8vOmFqjfJdRQtASkSR2pRs/IOCB8f1VvNsa46
         jq2xG6/ah89t3CxLqRKTCF44Z28vrnm2qGD7N5wOIALY+zuNawC6jqzhKMVPcYRAsYqX
         /gXA==
X-Forwarded-Encrypted: i=1; AJvYcCUIj5K/DBGTzJ33yxoN+m9vgRem00UnjTeMAm11KqYLX4wZCmyi25qNnV+b3c2WW+6lAVAgbDku22kIeRE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8kYmnehkg5byWwoLY94yJZargqGES8cu84orkKzwzL+U0rdsB
	g4bbF/dJA2dIhJI4mH3kaRD8PXa547zX/5stxMOTXe5YUC+RTV4q3/pRpnu1SrIU5nHQkM/443v
	IeRCOezVDfyui8zNkbj1NfgW7OCWSyJI=
X-Gm-Gg: ASbGncs3hChXqGqnpeZiYKsjeN2XX2vebum9mBv0XbjBQwTsdUli3AtO2fObBHlkFo9
	y6ljS+0QFjEB7IEXNLoBugrk3KQCM+FPRiCeDl9019CirsIPuFyXGGpAIH4GIm9lQ9LuhoS+31P
	tKIPDkqoXB3jetxVm5yx/uA4SBw+tavtMKinpGapGWeQ3zoflFstfwg/4z8HP9vObA9PHcoaU0G
	EqFNgJlFIbge7CE12eFcELbvx/Y17GyFbUVhAO1o1g1NA7L/x6t/qTcWU9buw==
X-Google-Smtp-Source: AGHT+IHUkYAmfqsL4pfrAr2m2hdDN3o6uRLRGRxPeQNNakdfKiLHAcYIg1YSxmUZUhNXfkuM7ZRz3ojoiDUBwfP84Ao=
X-Received: by 2002:a05:6102:50a5:b0:5db:3d11:c8da with SMTP id
 ada2fe7eead31-5db7cc1d762mr254232137.41.1761585026033; Mon, 27 Oct 2025
 10:10:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020053523.731353-1-uwu@icenowy.me> <dff6216d-b4a4-4d5d-89e3-e393dc018dec@amd.com>
In-Reply-To: <dff6216d-b4a4-4d5d-89e3-e393dc018dec@amd.com>
From: Han Gao <rabenda.cn@gmail.com>
Date: Tue, 28 Oct 2025 01:10:14 +0800
X-Gm-Features: AWmQ_bm6-SMkjAfWg6AAWYb_OA35WvrpXbak9x2LihJWZchEZTCd_NTCuMVV1sc
Message-ID: <CAAT7Ki9NGDhVo1dq3R5X-Mo1g0-+MZWcQ2TfWG7CAL27Y6BvcQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/ttm: add pgprot handling for RISC-V
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Icenowy Zheng <uwu@icenowy.me>, Huang Rui <ray.huang@amd.com>, 
	Matthew Auld <matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Vivian Wang <wangruikang@iscas.ac.cn>, Inochi Amaoto <inochiama@gmail.com>, 
	Yao Zi <ziyao@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested on sophgo sg2042/sophgo sg2044/ultrarisc dp1000.

On Mon, Oct 27, 2025 at 3:57=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
>
>
> On 10/20/25 07:35, Icenowy Zheng wrote:
> > The RISC-V Svpbmt privileged extension provides support for overriding
> > page memory coherency attributes, and, along with vendor extensions lik=
e
> > Xtheadmae, supports pgprot_{writecombine,noncached} on RISC-V.
> >
> > Adapt the codepath that maps ttm_write_combined to pgprot_writecombine
> > and ttm_noncached to pgprot_noncached to RISC-V, to allow proper page
> > access attributes.
> >
> > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > Tested-by: Han Gao <rabenda.cn@gmail.com>
> > ---
> > Changes in v2:
> > - Added Han Gao's test tag.
> >
> >  drivers/gpu/drm/ttm/ttm_module.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/ttm/ttm_module.c b/drivers/gpu/drm/ttm/ttm=
_module.c
> > index b3fffe7b5062a..aa137ead5cc59 100644
> > --- a/drivers/gpu/drm/ttm/ttm_module.c
> > +++ b/drivers/gpu/drm/ttm/ttm_module.c
> > @@ -74,7 +74,8 @@ pgprot_t ttm_prot_from_caching(enum ttm_caching cachi=
ng, pgprot_t tmp)
> >  #endif /* CONFIG_UML */
> >  #endif /* __i386__ || __x86_64__ */
> >  #if defined(__ia64__) || defined(__arm__) || defined(__aarch64__) || \
> > -     defined(__powerpc__) || defined(__mips__) || defined(__loongarch_=
_)
> > +     defined(__powerpc__) || defined(__mips__) || defined(__loongarch_=
_) || \
> > +     defined(__riscv)
>
> Looks reasonable, but does that work on all RISC-V variants?
>
> And while at it maybe please fix the indentation, using a tab here is pro=
bably not very adequate. In other words make the defined() match the one on=
 the first line.
>
> Regards,
> Christian.
>
> >       if (caching =3D=3D ttm_write_combined)
> >               tmp =3D pgprot_writecombine(tmp);
> >       else
>

