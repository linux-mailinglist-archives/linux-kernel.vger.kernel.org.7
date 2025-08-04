Return-Path: <linux-kernel+bounces-755576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1044EB1A8A5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 19:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA2B624447
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB63214209;
	Mon,  4 Aug 2025 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYvq+o5H"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2E54204E;
	Mon,  4 Aug 2025 17:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754328625; cv=none; b=WzvbXhYWcL4fDB33Rb+JTVH0LoVblSMDThkUDSkJMVbZeYRw6zb8kfCH+LmwEs2+jIUUBM0OoKw7iN8AD8yGcwtB6xBp/KushBVXTZkXf8KyETXtMF84Z56fuJrTQO4fdM9qM0qEabw2m4S1Xs4+CrV+HzCLimeEc0qSrukAego=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754328625; c=relaxed/simple;
	bh=nytwA9w2dECjtARvK2J+pUrQQ0jNCR99EtrRnpqR0CM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Up+oL252AWGiSAtcGtDhv8zIL1XOuYmsHMslsxH1/EcnyZnS/d5OMxHytmG6MOfPD/kWC67U2SzkC3uRa9r4U9ArE730+jMmGEBRK65riE/qlwbNFn3sioLZ6pB6VuG2Z9ItxF5x/cepD/s9ZRAxM19sr9VkLZs/vLeHzNFdJoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYvq+o5H; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2420c9e3445so7177745ad.2;
        Mon, 04 Aug 2025 10:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754328623; x=1754933423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLzSdAQKIpitpeuYQXseME87py2KuxJucUYdGOZhU5Q=;
        b=JYvq+o5H1BsKZs+Ec+d1rkgmM8zOOOhGZKBLaEHQCFrf5culcrVwTP9chsa2wuQycF
         agenj2x927Ub3Kh7scKNVbN7Yd0sP0VohO64T/CiyCmqPCrF+4LEJUqG+YQkO2oCTTlC
         j1h99uZ9wBNpLXyINLjXEFSZi67wcFsWt03fWDEXLURSYsq3B3OxcS1b6JXAyPiK2GJa
         HgxKEx253yLM3aKBx9ECNiuA0yGmtQZ9cKOX2DNFVbQxEBXa3Eg21UINvgcdJ5XqJ4n8
         i1ink0fXLyUc3KnfZjjnovEF9yzPzFOAqOhfChG46QaIwOh3JBXgMrbOdjLT6BYBep1l
         miIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754328623; x=1754933423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SLzSdAQKIpitpeuYQXseME87py2KuxJucUYdGOZhU5Q=;
        b=vEOyGZnpck9+9m4sXr0QbzEI0ScysT2AFeodadHmdtbCGkk1g80qNEdXcGT+ICgIsA
         rWBSRsEWwFWXtrOApZvR9B5fEmsilFGPptk5rH6PpHYVNTdk20s5ga2cHjpTONfOgTDt
         HTs8thVqVZrUnAKyRht84o5iVSaKJDDBlmo11w8Uatlaz0pK52gEVpu2cDVGSP7vz5mY
         Ask9zxUSpxzGt5rsh5MBNtDCQ9Z0RysmIAHFBBg4z8n7RKarDzSKOtKC6ZbFt2tsizXP
         LHPMWx/qD6Ho3ztWO0RZ85OwKBLDrde67RVofGgtu4D8tFHKanXuImdHn4haX+NZuHeQ
         gGmw==
X-Forwarded-Encrypted: i=1; AJvYcCUyW25Yj7q+EjZThPDq6kUIJPGn2b+HWOx9zVfOm9dWAkM6IXL+pgAYsbbH2AdetEfFR8qZBXDl6+GeeoI/@vger.kernel.org, AJvYcCVIB3y4cxoiGrUeKqB5ZhMWlAFZtLVFmkgJ4sODCeAHo2NEk1I/M9iCVuqkiGd5SFidLBl1tpMymk8rcT7pA0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoyegf2LYcWHQweZn/eaW/ZG/x3bbJlnnAPub682/HP/i7KyAR
	h27/pAHWjFI5LTaVwuTqvXs8Bwn6KAR2XjCDsYTkBHqjOutFOWnv9OvGJgur6I41NoZVv8NsekM
	OKYhkddUk7YYlVKr+nXmhR9njY1V5+/8=
X-Gm-Gg: ASbGncvNi6AT00DZZYYxyMBbF67yBZ0WlJip+OsAJGJzjCAjRoaAMJdwzFBcQs31e79
	lTuN2krYCRhWofu4y2nB7SkhKyAwKrGCTcwOwcpj4UPXWp/VqB+ge2ZrYjxy7OcGqR2k2rfRKuA
	CKjzaZLE+RgvtJbkesewmLe+N0tS3e2QGDk+qHwIIPNOpxAqRqvn3+8oB82qCNAU2HUn4td5V4c
	pjXHDkx
X-Google-Smtp-Source: AGHT+IFZ20MgIBvuCvlifETgR+OlOWEtQA0X/jTfhalbOjDjtuNoHqO373XlhluQ8kwPZ5qeVUlUBHY2ymIKIu2w3O8=
X-Received: by 2002:a17:902:dad0:b0:240:9dcd:94c0 with SMTP id
 d9443c01a7336-24246f2d73bmr66352445ad.2.1754328623188; Mon, 04 Aug 2025
 10:30:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801-amdgfx10-v1-1-e1dcbe18d84e@ethancedwards.com>
 <CADnq5_N+bQppUAD-qR8QC8M6nW+oRF8+7z=Qakcxc=a6Z8q4Gg@mail.gmail.com>
 <c82931b5-0de2-4e45-a80b-3a90b0cc98a2@suswa.mountain> <CADnq5_Mk3FO_tvxFo+fJgqskVc7qtGv74VM6EStx_BcVpahXEQ@mail.gmail.com>
 <fda8103d-cac8-4c00-a78e-6eb27141d9ea@suswa.mountain> <CADnq5_PdgH7yPZ9UNw3iXvuQAAUmuKpMh-E8NLri_q5Zn8deWQ@mail.gmail.com>
In-Reply-To: <CADnq5_PdgH7yPZ9UNw3iXvuQAAUmuKpMh-E8NLri_q5Zn8deWQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 13:30:11 -0400
X-Gm-Features: Ac12FXxD2PpS4lnNplG4DQJ0xJ3EfdL5wo8BVjrF54ogM83r4Sh11WcvrG_W1eo
Message-ID: <CADnq5_NMdi2=H8JBO-R249UhOWPeQ-_+syCq99XECDbV8iDhFA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx10: remove redundant repeated null checks
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Ethan Carter Edwards <ethan@ethancedwards.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied all three patches with a slight tweak to the commit messages
to make it clearer what is changing.

Alex

On Mon, Aug 4, 2025 at 1:25=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com>=
 wrote:
>
> On Mon, Aug 4, 2025 at 1:15=E2=80=AFPM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
> >
> > On Mon, Aug 04, 2025 at 11:08:57AM -0400, Alex Deucher wrote:
> > > On Mon, Aug 4, 2025 at 10:49=E2=80=AFAM Dan Carpenter <dan.carpenter@=
linaro.org> wrote:
> > > >
> > > > On Mon, Aug 04, 2025 at 10:32:43AM -0400, Alex Deucher wrote:
> > > > > On Sat, Aug 2, 2025 at 4:22=E2=80=AFAM Ethan Carter Edwards
> > > > > <ethan@ethancedwards.com> wrote:
> > > > > >
> > > > > > The repeated checks on grbm_soft_reset are unnecessary. Remove =
them.
> > > > > >
> > > > >
> > > > > These are not NULL checks and they are necessary.  The code is
> > > > > checking if any bits are set in that register.  If not, then we c=
an
> > > > > skip that code as there is nothing to do.
> > > > >
> > > >
> > > > It's not a null check, but it is a nested check and it's a local
> > > > variable so the patch is correct enough.  At this point we know tha=
t
> > > > grbm_soft_reset can't be zero.
> > >
> > > It can be 0 as far as I can see.  If none of the GRBM_STATUS bits are
> > > set, then we never set any of the bits in grbm_soft_reset.
> > >
> >
> > You're missing the first check...
> >
> > drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >   7657          if (grbm_soft_reset) {
> >                     ^^^^^^^^^^^^^^^
> > Checked.
> >
> >   7658                  /* stop the rlc */
> >   7659                  gfx_v10_0_rlc_stop(adev);
> >   7660
> >   7661                  /* Disable GFX parsing/prefetching */
> >   7662                  gfx_v10_0_cp_gfx_enable(adev, false);
> >   7663
> >   7664                  /* Disable MEC parsing/prefetching */
> >   7665                  gfx_v10_0_cp_compute_enable(adev, false);
> >   7666
> >   7667                  if (grbm_soft_reset) {
> >                             ^^^^^^^^^^^^^^^
> > Unnecessary.
>
> Yes, sorry, my brain processed this as the first check.
>
> Alex
>
> >
> >   7668                          tmp =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT=
_RESET);
> >   7669                          tmp |=3D grbm_soft_reset;
> >   7670                          dev_info(adev->dev, "GRBM_SOFT_RESET=3D=
0x%08X\n", tmp);
> >   7671                          WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, =
tmp);
> >   7672                          tmp =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT=
_RESET);
> >   7673
> >   7674                          udelay(50);
> >   7675
> >   7676                          tmp &=3D ~grbm_soft_reset;
> >   7677                          WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, =
tmp);
> >   7678                          tmp =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT=
_RESET);
> >   7679                  }
> >   7680
> >   7681                  /* Wait a little for things to settle down */
> >   7682                  udelay(50);
> >   7683          }
> >   7684          return 0;
> >
> > regards,
> > dan carpenter
> >

