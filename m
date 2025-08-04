Return-Path: <linux-kernel+bounces-755369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E5AB1A589
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F134B17DBE8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53A121A444;
	Mon,  4 Aug 2025 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIivW0sK"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28E4203710;
	Mon,  4 Aug 2025 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754320151; cv=none; b=WVQMT/x4R+qORV8HoQmSUBEPZFcXtyd6xNBJ5EAbLLD45xAgRdxHgURYpykYIWUIa4CZM3CgMKsnIdaOV0wstIHNtIlAzeD5ZEsgZbB/rDw7n51t2TJBND5N14P2LmuOK4AR6JpgQPl0jGwbPwyeAWXPled/+PfcRZjerVatPo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754320151; c=relaxed/simple;
	bh=OajX6K3v03ZP1WEjdzC28YVs8MpY5qGs8C8eCqhqJDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oXQIjZ2Kc5oZlpss3f8ihixhqPD47ppmogXthV17wxatKUmCQwhuizAJwrsQP99fvgtDhVAQ5O4gx6InqxqMiIxo3vrvtkiBUE/nJvB3wHNCGeEvg2xt3ycBTlP+aT/C2RsmUHm7TrGzSRLSCkW71eoaz3O9Zz01wM+AQzg2qP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIivW0sK; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32116dd55dcso545855a91.3;
        Mon, 04 Aug 2025 08:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754320149; x=1754924949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pWmlnlbINt5DgzqX/LhMW6Smiak/fMhtF3KImHodSQ=;
        b=FIivW0sKNSlUqZdYG9gKaMRmu1xk/ayWza81KtJbqhGodbxVtlXF8BdCjFE4ERDNU+
         zHbbS72aPX2M5rB4TRD/1+wtxt+pPawiFC5xzXJTt6B1/ZloQvk2xKDJtYrglAirgTQQ
         yrBU3RoFQpV0cIgaWGlXF+U/qD31dJGVcW9J7UDmKAR/D9wIbAb94jqlZy3JUMCASZLP
         b3EAD4OA6at+fIoulzQoRb5FsUHK70H3qWaLS8GMULOXDkM84Q7uHby9C7asUeZkwsGx
         wyirZ9VZKpQKqSaqw9i1W9JbEL9hT/Y7iArO2QltPjGAz8CBUCOvtNjDV4jx9evGfFOW
         mBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754320149; x=1754924949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0pWmlnlbINt5DgzqX/LhMW6Smiak/fMhtF3KImHodSQ=;
        b=Raz8HVgmqmpu4Xvv25NzWz3E7DRpKh3mW1ney35mIsIV0wB7VYJwMGK4xl8EJJmMWV
         E1cG3OIz81Oj9XfJMdZVfXsCO8wG4Ea67f3bPKJEI9JlJS7dSvyYagFb6/j53RZsBF8C
         YIl49xKD2CDBMkJCBYBQKR0EWRGPK4VgYQJoxFEtPS7Yp/fYtE/9njTEdNWVDMeIHEBP
         pcdo6SBTuJwIrhc5xCFzjXab4AInAITcHglFn4G1diaZwZ6DsJXXO9Uyf1Pr0ARjpMAD
         uJ3U6JgN+1bMix/Zz852s3D3SUMQwrI4mNAwfhHh18ANGuuWRCIvans6rgMjO/XKkDYl
         DmUA==
X-Forwarded-Encrypted: i=1; AJvYcCU4NLD08yCUy9IoTFadn8ZWvYqxsqqJIn61Ad/HJlvGSLk5eqNh38y/3exN7JVWcgPGfnMC7Xb/wXwpk/XS@vger.kernel.org, AJvYcCVfmhq41j1jEUACfyVmWkUB31mJrtCCyO7j5F5LAZJIngATfATpSdNh+XKCEIZvwQMexf6FWwtkAE639A67pqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8LAEres3PSUY433E8ZWhhF2At0PpnQvvdBYPioNC2XrRXWP5x
	CaaqfKuMAkVbQY8WR8fa7GpgkY6cV0hEfVneiCZky0XQv8N/S4sgkmXUxl9gTGIUjzN7+c9DglL
	d8UAorfwdpV2oproRHvhwQ5Sp9mzp+QI=
X-Gm-Gg: ASbGnctUJdZkQ5hwsT2xmnh3g11fb81imSH2pUtfBC5qePlpyw8edMODp9Grq5rK9JD
	qEL1SQ00GiPt9VmgbJokEOp/3wEfO1NbNPw3Z6TE/dLpxmf0POPODgspUyhgTw0HApJC5ors/2T
	FKoTYWmdLmN58nW8AXcwcWKNcRoDmb39uRcvEhA0zI8/5P1mJDaYXaLMv0lsW4pRm5IDY6jZBFy
	VK0i4ImyRpGhNRQTNo=
X-Google-Smtp-Source: AGHT+IHMFTyHef6/XrO0koXR/RYvYL+mNs96k9z60jF3FuBiwe69QFy4KV4xUVhlsAx611Q1Vntkh6D2HZ+92HzrCTY=
X-Received: by 2002:a17:90b:1d05:b0:31f:3d6:6d98 with SMTP id
 98e67ed59e1d1-321162cd943mr6369334a91.5.1754320148948; Mon, 04 Aug 2025
 08:09:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801-amdgfx10-v1-1-e1dcbe18d84e@ethancedwards.com>
 <CADnq5_N+bQppUAD-qR8QC8M6nW+oRF8+7z=Qakcxc=a6Z8q4Gg@mail.gmail.com> <c82931b5-0de2-4e45-a80b-3a90b0cc98a2@suswa.mountain>
In-Reply-To: <c82931b5-0de2-4e45-a80b-3a90b0cc98a2@suswa.mountain>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 11:08:57 -0400
X-Gm-Features: Ac12FXzrs51YUGCsmGY-ztatDva8cn8ius8nZTcTZJWx1B0F2phV965iupSHQcc
Message-ID: <CADnq5_Mk3FO_tvxFo+fJgqskVc7qtGv74VM6EStx_BcVpahXEQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx10: remove redundant repeated null checks
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Ethan Carter Edwards <ethan@ethancedwards.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 10:49=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> On Mon, Aug 04, 2025 at 10:32:43AM -0400, Alex Deucher wrote:
> > On Sat, Aug 2, 2025 at 4:22=E2=80=AFAM Ethan Carter Edwards
> > <ethan@ethancedwards.com> wrote:
> > >
> > > The repeated checks on grbm_soft_reset are unnecessary. Remove them.
> > >
> >
> > These are not NULL checks and they are necessary.  The code is
> > checking if any bits are set in that register.  If not, then we can
> > skip that code as there is nothing to do.
> >
>
> It's not a null check, but it is a nested check and it's a local
> variable so the patch is correct enough.  At this point we know that
> grbm_soft_reset can't be zero.

It can be 0 as far as I can see.  If none of the GRBM_STATUS bits are
set, then we never set any of the bits in grbm_soft_reset.

Alex

>
> regards,
> dan carpenter
>

