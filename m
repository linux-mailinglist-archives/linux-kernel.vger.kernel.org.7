Return-Path: <linux-kernel+bounces-754681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D2AB19ADE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 06:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37ADA1896EE4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 04:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341B61C860B;
	Mon,  4 Aug 2025 04:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GocBDvj5"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F3D86359
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 04:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754282869; cv=none; b=P5BWollLnvM92cEGKZqSnYLWpjcrwWZ1dxBdfcKkBmO4uSauoA4b8kzmKJXdAmHylCuGgmKH4Hy1v90qYo4LacEzfdXd3mC+rFDTi1ixd336qqdJSGu0mGcPbJToCHKVqxTBGqzErIs4Us3Iub9rahDmuqbY8faERsY80d8dpFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754282869; c=relaxed/simple;
	bh=BDxJSgSRH4keRk0Fg9Fh3kQGq5lMmCw/wfaUL5w0mqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PwqTEX39fS2lyh7ViUKFwfmP0mJNlWcziqdi0m0MZaEeyBrukdhhh+ALAZ/6aCvlANr0fBx47N0l3/Ac7V7tWdcx8oed7ja3VRmTiACUunYGLMlLmalETdm9lfpZhTdf5ZCaAymjwUWoIKmwy8t1KEQ0/lxglOe8/ysyV3oWG8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GocBDvj5; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-53960818e9fso1526291e0c.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 21:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754282867; x=1754887667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDxJSgSRH4keRk0Fg9Fh3kQGq5lMmCw/wfaUL5w0mqw=;
        b=GocBDvj5bQ/VbbSr0q0HHcmUj+U8d1ijB/aNPy/a4svdPG7vYkOjs4QVJCk0IiKViY
         OjI/55pgHhjWfHG3qqK7oqe9I2CxI5ptuvQsCszAcz5IPOrjLAXtHD4ksdaTw9LYRBzU
         80HPcxVxZGpE4GAB2E6Y7BCM1MtF2kuncJRrEIqZtUPrTha+z6u7gpsfZ44jSzWIj4FT
         SBZZfnauzgWouwHPe/hvz01QvOfYHxR/xkPHt2ag/hATBygRBflxsVrZh+B8xOSDdLKW
         k9jnT4lLDXScoiJrGja3FVzBaizgIrVa176bnYfgcpk6QdWcpp2MFJtw/r3VoFgdRyAk
         JOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754282867; x=1754887667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDxJSgSRH4keRk0Fg9Fh3kQGq5lMmCw/wfaUL5w0mqw=;
        b=POxJSpzABO2q/VxWSp7xEtRMCQN6h0RMRIaTSJT0kgbGIgI1f3mtqCmFkuBbsFmlyR
         WXCIs+euGszTUNYvrFYTHSx/zcvLkp3BDXKvPupCXRszRbsvNU9Lf3e19LR9fUvn4AGN
         9SZtLCMANpHysv/FpQzZLySGbRtXS6b6wo9BDixSnsSVZRRHulZwEKUOCI0oKB/097x/
         FkErs8b4LXs+pPbTTs4k7NZ38UdUsgnrjBMkU3cGd8peWtuW1iRTGBCeu/YbbQrBJ7hy
         txoc6aRZn50foS17CXin+uzBFg6EjCa+4LEYPB+l/7rPHX94fkutRdPGQHBqt7oVh7Xd
         AlCg==
X-Forwarded-Encrypted: i=1; AJvYcCXCZi1TEOIEqMFnuyS5z+ymOjmo+KjxbutxaQ9M4im9AD6QWGwG73mIn1ew8fq7TWoS5HT/TCjQCKtga7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhVhuZ34uMpCwjPBb7gI9hSNIhY59PNM0Y6KcgI832Lat7ybLe
	qz7itLZ3PEBcRzZQOt8BAlSATaRia09rLt9SbOyXLrVS6gEilUa/M/vUjyBSU5zsyGvPWnTo0jb
	bnYgxC4ATDtHsFDC1VEUN3uKw1CvPNrgonnPq
X-Gm-Gg: ASbGncv2iMLTtp8DNQFy+mFyuEAqGki24b6io9oqeQNpdfTwXRTxHSqLN+xOgC8tGlp
	dpbAsHQ3qaBa+wC2SpCOUXY2sDFhM3hZO18kKex2dCdWBrpKstnTuhTrIWMflNBumaAfDX633ST
	ulJlmxWXucMfbF1gfdDyYBVg3plgBhqNCRS0+hzsw6/cavSvUC5tTKd39FOqz+0mql6IIyLx5bu
	Lmi6MgGiBF78tex0A==
X-Google-Smtp-Source: AGHT+IHqYM/KFdH9TSLDrogRF00/leasxHpcVOGzCepnD1Fdo9qSl8/RXPv2S+CcEk8TDBdbWgBJipfApFgWW+h5OrE=
X-Received: by 2002:a05:6102:6447:b0:4c3:64bd:93ba with SMTP id
 ada2fe7eead31-4fdc22436a9mr2892411137.11.1754282866732; Sun, 03 Aug 2025
 21:47:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724085600.4101321-1-xiaqinxin@huawei.com>
 <20250724085600.4101321-3-xiaqinxin@huawei.com> <CAGsJ_4zVR3R7erGP57vxM8vKBARG8BttA=FsCVFjy4QtswcsQw@mail.gmail.com>
 <c7f7d9b3-2ab3-4ebd-99fb-071733573291@huawei.com> <CGME20250724094224eucas1p13a911259338ac1890d4baed8b9998fb0@eucas1p1.samsung.com>
 <CAGsJ_4zSw57DMyRZM24BUdDpbi4+BRfgWUqxSKurCsAVC7Kptw@mail.gmail.com> <f8c0cbdc-9c68-46bb-8dad-1d7c80f3f741@samsung.com>
In-Reply-To: <f8c0cbdc-9c68-46bb-8dad-1d7c80f3f741@samsung.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 4 Aug 2025 12:47:35 +0800
X-Gm-Features: Ac12FXwC2QgKuJTJX69JLqTW3lt_irVikO6kS_bcR7G_jczX3yoMEbyFmccG3as
Message-ID: <CAGsJ_4zs8=n+J4Xtd=Un8+p3c=FCOTji9qMfBsOKcc8sFG0v9A@mail.gmail.com>
Subject: Re: [PATCH 2/2] dma-mapping: benchmark: Add padding to ensure uABI
 remained consistent
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Qinxin Xia <xiaqinxin@huawei.com>, robin.murphy@arm.com, jonathan.cameron@huawei.com, 
	prime.zeng@huawei.com, fanghao11@huawei.com, linux-kernel@vger.kernel.org, 
	linuxarm@huawei.com, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 8:32=E2=80=AFPM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> On 24.07.2025 11:42, Barry Song wrote:
> > On Thu, Jul 24, 2025 at 5:35=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.co=
m> wrote:
> >> On 2025/7/24 17:07:08, Barry Song <21cnbao@gmail.com> wrote:
> >>> On Thu, Jul 24, 2025 at 4:56=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.=
com> wrote:
> >>>> The padding field in the structure was previously reserved to
> >>>> maintain a stable interface for potential new fields, ensuring
> >>>> compatibility with user-space shared data structures.
> >>>> However,it was accidentally removed by tiantao in a prior commit,
> >>>> which may lead to incompatibility between user space and the kernel.
> >>>>
> >>>> This patch reinstates the padding to restore the original structure
> >>>> layout and preserve compatibility.
> >>>>
> >>>> Fixes: 8ddde07a3d28 ("dma-mapping: benchmark: extract a common heade=
r file for map_benchmark definition")
> >>>> Cc: stable@vger.kernel.org
> >>>> Acked-by: Barry Song <baohua@kernel.org>
> >>>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> >>> I don=E2=80=99t think these two patches should be part of the same se=
ries. This
> >>> one is a bug fix and should be handled separately=E2=80=94ideally pic=
ked up on
> >>> its own and backported to stable.
> >>>
> >>> Also, the subject should not say "Add"=E2=80=94it should be "Restore"=
. I assume
> >>> Marek can handle it?
> > ...
> >> Ok, I will send a new version to fix it.
> > If Marek can help fix it while picking it up into the dma-mapping tree,=
 you
> > might not need to send a new version.
> >
> > Honestly, I hope this gets merged soon=E2=80=94it feels like it's been
> > overdue for quite a while.
>
> I'm sorry, I wasn't aware that this need to go via dma-mapping tree. I
> will take it after this merge window.

Thank you, Marek! I also noticed that Xiang Chen=E2=80=99s email has been i=
nvalid
for quite a while, likely he moved to another company some time ago. It loo=
ks
like Yicong has volunteered to take this on:

https://lkml.indiana.edu/2408.1/08865.html

I'm not sure if that's still the case. If it is, would Yicong be able to
resend the email with my ack?

>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>

Thanks
Barry

