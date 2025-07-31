Return-Path: <linux-kernel+bounces-752145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F82B171C8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E9E2166C99
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39982C178D;
	Thu, 31 Jul 2025 13:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxSjdYFN"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7ED43AA8
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 13:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753967394; cv=none; b=Df1t7EqwCtxJ2Bn0q7Nd31BbU75VgmxJo90H7MdK0ZwfAxwCRA38HqEW21pUigwysGsvYNrRg/q0h344ZuFE6LhEirHvgT7wtHbekFARXu3Z864MVr3YaDIP6DrBCgG86wApmy0MIhxpJc9FYedrTnlif1D7Zz+6e5qs01BiPww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753967394; c=relaxed/simple;
	bh=7GYAsq9M2AhWHVfpYtcPbAxAwiVxAVcGnd2EHki5hIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hARcjgmxiTtJn0Q1mxV7dwEYSVTxv2w4qO4XNEaX1flCEt929c2Q6Gd7LvI8qJEpRZZieEv9KPV/+Qg71kxWaI0TASLSrAp6HOH+9tq4EnZe4Z/xntovQBhZMMOZkDxS8GBUrBix/VaBkDDFA5bbIbVpxzSjL1+vhXndPf4mavw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxSjdYFN; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-31f8180e6f1so150714a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 06:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753967392; x=1754572192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skC1kpnAhX6pq9GTj4XZsHRg2fh4hLUap6aEjnJ3AFE=;
        b=GxSjdYFN4w+CDntxo+lhp51E5ZeA4/t2N18Ppw3lyRqGGuHelEHBoj65NbVW5O/VYK
         rnmlgFWClExLWF+eSbsKGWcHlBkxrmwSu8y9ARSaMtBQFLHJu48tyFQNDHj+0iVoujXU
         94fNwSxOyNi6XSFnShjsF+VUA7NJuoVzGhowEn09iyx987atiQwZalD6lMeOTCBo8Nvw
         AjpNs8mFzOyFegCbusAWVLhVQYhJSXwgxHIhb0iFL6Nz1gX9st0G1CSq7y5tGZsDqqSP
         UGYOsWUw9z0Ota4w05Ago0qRmvUB2k0eUzcRWs3SbuF18rzs+AKhSpe7eglTlrogCj7s
         Tv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753967392; x=1754572192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=skC1kpnAhX6pq9GTj4XZsHRg2fh4hLUap6aEjnJ3AFE=;
        b=iIt5lRgToIDBqfHTxh+vLTLwSQoH9k+0I4z3487WeC1ETM46zYenRoPJtVV7VB0Dly
         fVOeltR0SavHMGlmi9jd+OSHe4pFBpM9KWR5L9OdTKWZcDhfnyFaJ8FroEgAIy2OA2Qt
         DHFt9x/ZxcOOQvP8ibDUXagLPm6u92Z1kZ30moWSDkyhzDuguikUhWvHp0+mGaAov7xV
         nL+czE6ajqSSLa952J/7zGu83CTrR29h6lPjkBwGZ91NH/CQCgDUMKvyMuJ6zg9TPO1I
         4CDP+xCo04su0buXMgdrmcx7/5vi6ukKB8ThJguYvlBLjcjUeEK0QrfAnjZjxeepiEU/
         kh/w==
X-Forwarded-Encrypted: i=1; AJvYcCWQqy+bovUEXsnItaS9D6MdS5LvyGcs4pfmhbmdm+GzJ28nVaxXPOqjU8hwS+iiPE0uBo18Su+dzoU5awY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNxbNR1PHkRIWqkW8TUiZuqHEZdeYH+3m0nn2AuLiNLgrP/yax
	BcFGDYowg/pQ1AY9W+kcb7yC2FUiqcP8V/7KrerGL2PWrB8yaceJS4jfvri0e8oDCuBm4lL1dDh
	0jr3uS8DgUw+AaD1AHb7BfBsor1J8S+4=
X-Gm-Gg: ASbGncs5PbU/onqa8ywi1zhQbIMHs++vprQC4dDG4G7CpvLTBdxcTDBwwgoFo20J5Fh
	T2O0xGtzBruZWBnCxHQ+oBb5Yk8Wdc1poX/KFfquinRyWySEtTEO4X2pot2dFrkQqGF+NMgbW4c
	oUnHLyMrIjD5bVelosGEB7jS5erfKqrGZ0johDokzdxjWeUdk2V82gMTSaIKwHrCbU0/HFt+fI4
	AfTWj6e
X-Google-Smtp-Source: AGHT+IGb2h0p7tSKQCZxOROO7pa1QVA+WZ2y7Gt2WN+euz6liPbWeX4GsFFQgC/3PsoKMwRtpcrcu00V27Ky75dQf9w=
X-Received: by 2002:a17:90b:3ecd:b0:31f:3d6:6d98 with SMTP id
 98e67ed59e1d1-31f5dfad39amr4892346a91.5.1753967391953; Thu, 31 Jul 2025
 06:09:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzVm80-v6_5nt6kko3nR+aQLZ7R98i419FV8f4-ayQWUw@mail.gmail.com>
 <CAHk-=wirxHy+KU6jmtO2dzmGQ1BwaOdd5Mjtrc40fGvZVULQQg@mail.gmail.com>
 <CAHk-=wjn5Pg2Gp=o2NVv-nRKqE=E75AxUypWCCpQ7MDXuHx+YA@mail.gmail.com>
 <CAHk-=whnuRuQEky2GsCDRQSf1dZbpoqnK+puw=qdR-D7aap9SQ@mail.gmail.com>
 <CAPM=9tygJqtbmYzB5gktxp-7fBfv_9gNq9p9+SdZ6wiYE2-6PQ@mail.gmail.com>
 <CAHk-=whB1X1c6rWbY34wZVGcnaY=yfPGLOtjd5h3mMDGV9Lbkg@mail.gmail.com>
 <CAPM=9tyb1mELymOJv62KJom4mGF0UBifbVqLJUFdS1C7Eeu3jg@mail.gmail.com>
 <CAPM=9tzDWmYBKQGB0ybDzhYHkg0p98_6PJA8OuPahRep8+QPvQ@mail.gmail.com>
 <CAHk-=whOb_ebQQbnXeqb8uXf32WA32nrL3=HQ2y8hBm9hFgVOw@mail.gmail.com>
 <CAHk-=wh+79KkMXsNqyPxeU+c5U2h-n13ko6J_QzwtjyYCKhrSw@mail.gmail.com> <CAHk-=wgEGn0azq0n5BfWg4ZStrZYanLCX1a+quug7HKmjimhpw@mail.gmail.com>
In-Reply-To: <CAHk-=wgEGn0azq0n5BfWg4ZStrZYanLCX1a+quug7HKmjimhpw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 31 Jul 2025 09:09:40 -0400
X-Gm-Features: Ac12FXw0EmQRRt1MKRO5jLab_Wal8G61JFd3QmymsPrv7WznOlUpDyX09UypSiQ
Message-ID: <CADnq5_NBM1Kso==+N=1xCjF+xiS7Vy4g47uvUN7sSWs8bontZQ@mail.gmail.com>
Subject: Re: [git pull] drm for 6.17-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Airlie <airlied@gmail.com>, Dillon Varone <dillon.varone@amd.com>, 
	Ivan Lipski <ivan.lipski@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 3:03=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 30 Jul 2025 at 21:58, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > d7b618bc41ee3d44c070212dff93949702ede997 is the first bad commit
> >     drm/amd/display: Refactor DSC cap calculations
> >
> > Let me go see how painful it is to just revert it from top-of-tree.
>
> So with that reverted (didn't require a lot of fixing, only minor
> unrelated context added nearby later), current top-of-tree works for
> me again.
>
> The revert I used for testing attached just so people can see exactly
> what I did.
>
> It's late here, I wasn't getting any more work done today anyway, so
> I'll leave it like this for now.
>
> I can continue to do the merge window with this revert purely local
> for a while, so if somebody comes up with a proper fix, I can test
> that out.

I think it may be fixed here:
https://patchwork.freedesktop.org/patch/663973/

Alex

>
>             Linus

