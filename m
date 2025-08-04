Return-Path: <linux-kernel+bounces-755573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A1DB1A89C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 19:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38203B2AB1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4614528B7D4;
	Mon,  4 Aug 2025 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tqs9UMqT"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A9328A71D;
	Mon,  4 Aug 2025 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754328336; cv=none; b=bxmALK8ZwrnBGE18fwLG/HSuyli5rl6Ng9fCHdUErsILlbL15iXiN/P4brb7jdA2YPPqdXWkFE6sNaplMD6lQu4E1E8lrSiFSFxy9hVhJuh9fStru6OLEza7mK6WSm1b9gf+W62A6sRifZKvAxFiL2QOmOL2+cqpV2Wb0c3peWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754328336; c=relaxed/simple;
	bh=7V9qc+lSDHqzl5x/p+toLHwpMFanml2MvTsoFwPK2Jg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5xCGDzALxMA9GaPn5Jk5AwPvKI2DKuw8pWJgLJLrf5DwSqUf6duDSBjqQ3AGyIwDQREWaXfc6LkMPEySbrzWiOd7vgZo112LdymBX+MJ56GWkWu8JYe5PI0Sk6Mevz94GzTj5BgzZC0lS0DHQee7MJQo/5Ex36MjOCFuSAgyTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tqs9UMqT; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b426d4c27d6so51664a12.3;
        Mon, 04 Aug 2025 10:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754328334; x=1754933134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g690U9pQgSxTEWE6ATDJuvl7Gc0JomLmYetcHpxeY3M=;
        b=Tqs9UMqT+bDIAKbzVAafzdY4Zm6yQTmn++i1EV9rI/o4CQlLR05AIFp9ss6w612KZA
         uW7X92KTKoqdXA5qmkpdl8bzF+KEnQDFmO8564DraXgLWUTBxlMnYSkLM4T8pUXphC0Y
         x6B9Kjrd109s7xK++QepVqXWX0s8VG8CteS0+i1FvtUDfzL4Wz6Sdju9DLXEemZ44v1i
         SAzv1x0vDhXaFFkJrfGnyAMr7F45lmXviZp0kcrjOf31rzOfb3nVXEkzeILs4h5htU4U
         xaypy9Z6G56iHUlx/YAM2iZdUlhcnr9vYcSqpXWAXiJaVOK+KiECczbFb6JTuMHFmssL
         AT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754328334; x=1754933134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g690U9pQgSxTEWE6ATDJuvl7Gc0JomLmYetcHpxeY3M=;
        b=N5z5dvik+xBKthKDJWQre0QhDdUhT5RU0njjkfxBMyrRMZ+fkOQsnTKMGlIdPb4GsL
         Z9qo/1lhr2ace7Ieb0dbpn9WFejTck+p+bur8Yw+PjGAK4z3l1Nw3JRUGQjXS6Q+Ke2W
         L801kye8izCDTMLmeR0MzDMVj2gT4kKrrPgXH1mA2ek5Xjw0mpo5dvtsaoyEOevYnD91
         ZmP9zcncdZlUiuNYLhsIKu2u4D63JGHUI+bpKeuyfxpMxjpsL45dk+4MK0jtK+gYDsqc
         y+OjDynlkzS8oBssyba7E1zRkBi7hFQ+E4DAK6y0n37YFuZs0dwOu0zKNjG4InMeGfeq
         sxew==
X-Forwarded-Encrypted: i=1; AJvYcCVBdmym59kHwTFv1w0HwbTTWfRUrbNBPz1qa0bLohPUcZKePvVQHbkRN5GugJ4VTBS4Yc+G62DwfTZkT9I9bMM=@vger.kernel.org, AJvYcCXScc/1vCO86gv51xblD7IVn70P24d0yk+Ki4kTsQhf5snPgaP7ZWVRU0xYrv8AulsAhXEhY5d8NGNX1GB8@vger.kernel.org
X-Gm-Message-State: AOJu0YysP0RtKNYoOsoBJIdd2KBnamFb7ZXxy+gJOD7Zyo3k0nKX7bmS
	w2Ts5BymgRVBPqILl60j5+GR+w0x89zNMkalss7LIAbNwBDRj6+PbOSATUYPaMbK3nmKRLxVhbV
	tFd6oWWL1sZyjo06bSff4dix7rWkTvUw=
X-Gm-Gg: ASbGncsPuoxOhBB56lSSjJroAoEBoUQGZ9jbyroI9sy1B6Tfl/sqDnno9iongiTJCFP
	IdNZZRBcR29m9NkjChlEzE1TRZE+L0zqK7DOI5i5Na90XICo8joY1hPmoHVt7n8lQv7hx11awoy
	2aBJaNYONJja5zOS4/kTEuXLRwbCYzClPWdpbEx8JuEOY/21kJbZo25tzE2HzOllJ73/GTQtP+C
	0iE1ovOUJ8B3SkqAw4=
X-Google-Smtp-Source: AGHT+IEajlMeD6NqO5b1/eXYB83OKLA2Za5F+Hq1oKtZSBKe86RBYLYjaIscUGuv7UBB/vwGN7icLu9m0Gh4yj7DzII=
X-Received: by 2002:a17:90b:1d03:b0:31f:ea:ca84 with SMTP id
 98e67ed59e1d1-321161e12c3mr6481614a91.2.1754328334511; Mon, 04 Aug 2025
 10:25:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801-amdgfx10-v1-1-e1dcbe18d84e@ethancedwards.com>
 <CADnq5_N+bQppUAD-qR8QC8M6nW+oRF8+7z=Qakcxc=a6Z8q4Gg@mail.gmail.com>
 <c82931b5-0de2-4e45-a80b-3a90b0cc98a2@suswa.mountain> <CADnq5_Mk3FO_tvxFo+fJgqskVc7qtGv74VM6EStx_BcVpahXEQ@mail.gmail.com>
 <fda8103d-cac8-4c00-a78e-6eb27141d9ea@suswa.mountain>
In-Reply-To: <fda8103d-cac8-4c00-a78e-6eb27141d9ea@suswa.mountain>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 13:25:23 -0400
X-Gm-Features: Ac12FXy5S9_TzHUM3Kpfu9ojzbDCloPuhMA2gBarDK5IhPP2L8syh5vot1HwA9Y
Message-ID: <CADnq5_PdgH7yPZ9UNw3iXvuQAAUmuKpMh-E8NLri_q5Zn8deWQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx10: remove redundant repeated null checks
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Ethan Carter Edwards <ethan@ethancedwards.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 1:15=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> On Mon, Aug 04, 2025 at 11:08:57AM -0400, Alex Deucher wrote:
> > On Mon, Aug 4, 2025 at 10:49=E2=80=AFAM Dan Carpenter <dan.carpenter@li=
naro.org> wrote:
> > >
> > > On Mon, Aug 04, 2025 at 10:32:43AM -0400, Alex Deucher wrote:
> > > > On Sat, Aug 2, 2025 at 4:22=E2=80=AFAM Ethan Carter Edwards
> > > > <ethan@ethancedwards.com> wrote:
> > > > >
> > > > > The repeated checks on grbm_soft_reset are unnecessary. Remove th=
em.
> > > > >
> > > >
> > > > These are not NULL checks and they are necessary.  The code is
> > > > checking if any bits are set in that register.  If not, then we can
> > > > skip that code as there is nothing to do.
> > > >
> > >
> > > It's not a null check, but it is a nested check and it's a local
> > > variable so the patch is correct enough.  At this point we know that
> > > grbm_soft_reset can't be zero.
> >
> > It can be 0 as far as I can see.  If none of the GRBM_STATUS bits are
> > set, then we never set any of the bits in grbm_soft_reset.
> >
>
> You're missing the first check...
>
> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>   7657          if (grbm_soft_reset) {
>                     ^^^^^^^^^^^^^^^
> Checked.
>
>   7658                  /* stop the rlc */
>   7659                  gfx_v10_0_rlc_stop(adev);
>   7660
>   7661                  /* Disable GFX parsing/prefetching */
>   7662                  gfx_v10_0_cp_gfx_enable(adev, false);
>   7663
>   7664                  /* Disable MEC parsing/prefetching */
>   7665                  gfx_v10_0_cp_compute_enable(adev, false);
>   7666
>   7667                  if (grbm_soft_reset) {
>                             ^^^^^^^^^^^^^^^
> Unnecessary.

Yes, sorry, my brain processed this as the first check.

Alex

>
>   7668                          tmp =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT_R=
ESET);
>   7669                          tmp |=3D grbm_soft_reset;
>   7670                          dev_info(adev->dev, "GRBM_SOFT_RESET=3D0x=
%08X\n", tmp);
>   7671                          WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tm=
p);
>   7672                          tmp =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT_R=
ESET);
>   7673
>   7674                          udelay(50);
>   7675
>   7676                          tmp &=3D ~grbm_soft_reset;
>   7677                          WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tm=
p);
>   7678                          tmp =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT_R=
ESET);
>   7679                  }
>   7680
>   7681                  /* Wait a little for things to settle down */
>   7682                  udelay(50);
>   7683          }
>   7684          return 0;
>
> regards,
> dan carpenter
>

