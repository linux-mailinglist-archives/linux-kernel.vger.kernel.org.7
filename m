Return-Path: <linux-kernel+bounces-660664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D0AAC20A8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 12:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DADE7BED9E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 10:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AC5227E86;
	Fri, 23 May 2025 10:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bLKsUaTP"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4B022576E
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 10:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747994634; cv=none; b=WEo3VypRL03wuw3V5uzRqfVHTJTTbIvdVqk8kD+ZQQqtNjH2AxNPdbAm564riSIR8RICkyldXv8R1w3d5jFrT56LayoqREiuy88qw+FcBCba28ZWTQIPjgSHxkJrWRklA9q3gMET5eC78+wuQyGhpvJMGyaU2kmHA/434gP399g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747994634; c=relaxed/simple;
	bh=nSyy6F6LK0lnXl6EFJ91Tp2akvoleZ9nkVxTo4FlKQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uO90JI17fKTg8hbtiKJKsAtp5I6J5xDZaEF8AOm1N1FouYw6EwSqzCBWLOHFwMYuhMWMBO3tmxA5a3sDnJISopMX6ehsysq7mXJJtlViKxlWkmhz0uVgvcPRW43lZCJumNt48/gtXQC00hRawnBn9ow18U0bT+24jgpWjirJzLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bLKsUaTP; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70df67e1b17so27220007b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 03:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747994632; x=1748599432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSyy6F6LK0lnXl6EFJ91Tp2akvoleZ9nkVxTo4FlKQE=;
        b=bLKsUaTPQwFXIqFeyqVcgxvw3aRmSivdHcb11fMev9IfXzi3oKLg+xEFIolUscgtT6
         l02Bf24giZN35UqBeeL91h4eLuD3bU8fORaxZi0fx2PTSix6Y4xBhGG+bSr/hwi49bC4
         NWTL26EHv2XpUN/0aAqrof+u7R4GnoTkNwsLddGmP/0hycxSdFpqzWpu76eLBPOhcT9n
         0BdYDwQg4lk+tslUfAVlqjE4EXq2ZkxMw8UX3gRARSL6GQ4ssT7Caz3rLMdmx6Yq1Hl4
         O37/LPZfqXmcYBslojPLYJIrrlDPafb+KEck5i1CFWB4Q8oUSKsVYWFhkIyzOWrChtO2
         kqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747994632; x=1748599432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSyy6F6LK0lnXl6EFJ91Tp2akvoleZ9nkVxTo4FlKQE=;
        b=LYiLYrq1wx464vyvt31bgrY8bnPWBSty6dbG/ZVD1omFe/ajbhHw64of6qTTfIarab
         m28a7wmnQ6FX0zp7fUEcPQ57IvxNCO4L+zWvt9Pbs5vl6GgepHHjRlKg4FaCIqmn5rEf
         vHJ/O4j014xPGnJlP0nYDECNpAcyZ40S3DRcf/ywCidbGb+TvoDVWD4vTmFop8TokmjF
         S9e7asc+VoP1m6mt7dUe10B9hH2CKa65L0axh2JH5vcPEnIba2OhDVw+oVNOxuB2fqop
         5OmF72FB8oNSBSlNvfajxUAfK6RsuDf6G/8ALb8j/ABzs/qdtaUCxfEsS0d4h4rSnabL
         UrhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0DbY77ekd0psGY4qKu2puuaVRTmcu36Wzw8hnVARBXQo43Di+B7j1Zy9wRlFfcKKNx558KJyBvDkFO68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcl9TjC6c+C054RyVg945RxeJhYWCfreWjm6Tg9AKTRHrB64Vt
	gdraQyFdUO3qLkflE5mGohgypWyKAyx+KtZM2xDo7KqELEPkPKJ2bbwQRvAWe5wVVBvMepBFqpN
	RIX7puWys0w7jGRcjbCdOzhBZMEniszZghI5nXFkqyw==
X-Gm-Gg: ASbGnct/J1nUaqbM/Uyx1Q4/uvxpv3Xheoke7naKQscrn7JjrcZiFptmldkIxf+c4lh
	UKJQ9BytZm627VKqJWpdvR7nn+UOn3Xe6v1LAXjwrNxhmKJg4dBHqK10tBYG7a6Xk6kqSXcdUqH
	PxpJtqHUhk/NcuYzdLxpIwMP2rMviqnZxvVIV+trO5tw/e43ZQTTd0+wfiItpm0Tn2P2E=
X-Google-Smtp-Source: AGHT+IHMOhW87yFnNkOzjQbF5lt7pbwsLfpvr6K8p94xBG86k8PuM3wB1MN6LYFWzC8LZIK5hH5M2DO7rvHYJxhdvTg=
X-Received: by 2002:a05:690c:6704:b0:70e:142d:9c56 with SMTP id
 00721157ae682-70e198da98bmr30145427b3.26.1747994632204; Fri, 23 May 2025
 03:03:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506-quad-pipe-upstream-v9-0-f7b273a8cc80@linaro.org>
 <20250506-quad-pipe-upstream-v9-9-f7b273a8cc80@linaro.org>
 <0dace5ee-8c81-4181-ae0d-7f317b7f5ac9@quicinc.com> <0fcad5ac-e1b3-41ef-9d29-0c801aa4fc51@quicinc.com>
In-Reply-To: <0fcad5ac-e1b3-41ef-9d29-0c801aa4fc51@quicinc.com>
From: Jun Nie <jun.nie@linaro.org>
Date: Fri, 23 May 2025 18:03:41 +0800
X-Gm-Features: AX0GCFt8U5tJbB_Frbkc2UDuQKbexsfWNiEDvHL2UT7JPw5PMyVZFKL3Z9TN9lk
Message-ID: <CABymUCMYSj=3LaA8Hw4se57_4xV+G33DLrYkGRR5z6DjDeypCA@mail.gmail.com>
Subject: Re: [PATCH v9 09/14] drm/msm/dpu: split PIPES_PER_STAGE definition
 per plane and mixer
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Dmitry Baryshkov <lumag@kernel.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jessica Zhang <quic_jesszhan@quicinc.com> =E4=BA=8E2025=E5=B9=B45=E6=9C=889=
=E6=97=A5=E5=91=A8=E4=BA=94 04:55=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 5/8/2025 1:42 PM, Jessica Zhang wrote:
> >
> >
> > On 5/6/2025 8:47 AM, Jun Nie wrote:
> >> The stage contains configuration for a mixer pair. Currently the plane
> >> supports just one stage and 2 pipes. Quad-pipe support will require
> >> handling 2 stages and 4 pipes at the same time. In preparation for tha=
t
> >> add a separate define, PIPES_PER_PLANE, to denote number of pipes that
> >> can be used by the plane.
> >>
> >> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> >> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >
> > Hi Jun,
> >
> > I think the comment from v7 about propogating the PIPES_PER_PLANE chang=
e
> > to _dpu_plane_color_fill() got dropped in this version [1].
>
> s/propogating/propagating/
>
> >
> > Also, any reason PIPES_PER_STAGE was kept for
> > dpu_plane_danger_signal_ctrl()?
>
> I have the same question for _dpu_debugfs_status_show(). It seems to me
> both helpers should be using PIPES_PER_PLANE.
>
> Thanks,
>
> Jessica Zhang
>
Thanks for pointing this out! They both should be changed to PIPES_PER_PLAN=
E.
Will fix it in next version.

Jun

