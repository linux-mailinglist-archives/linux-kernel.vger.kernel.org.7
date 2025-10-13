Return-Path: <linux-kernel+bounces-849889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED43ABD1303
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 04:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 29FBB4E9BCF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 02:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3452F549C;
	Mon, 13 Oct 2025 02:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIxBD0TX"
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970C42F3622
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 02:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760321356; cv=none; b=T0W0tnm8jlwBPTcR8gO9ZCO/F/ZTb60/D7wYHgzLXcDBUEwGWogUoOy5dJ3NoI6rShExuulwUb5QggvM4KPR1vqZ2fVCnrG/fWvO8g2cApkOf5QTlmYlCrR55ENp40Ep6fBmm+joCAx1n8gI9A6u5MSmkUtMvRCY0GRaystRilQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760321356; c=relaxed/simple;
	bh=zrW7WGVaRAE/uWWvySX5l8CAFEikLlMEg6cnOQdS+i8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mz7bVE3x8gvuzwDgsWeBJkv3bJr0SAhJ7Gnql7sZboY0RAddxB2gq5Vxom/9TDbpbDjNOE0/gcKnuOtT7/dzJ2MGrAqO8Dl17Gdkrm6tCapVaPQB9ZJEDLOZ5i8Nh/8jFGhQhQFOqHbxbd5uH04oW9cuxvTFDHmIQkQlyAV2jnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIxBD0TX; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-639e34ffa69so5725396a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760321353; x=1760926153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7LwVVt+oIonXpTgbR8cBIFBDId8LwLF2NsksQagWtM=;
        b=RIxBD0TX/Pruwu+fBlzzRmIpx+T+OZMQOQ62COc9Xk3qvPmfQQ0s+gcYmOSoasbNtM
         c+I4CPSDvLvLnRyshKijky/JKW+QEbUzspMuou8oO2SSVsw7MjmW+iMsYUXV3nKkZPJJ
         TSXdRCSUb9sdzvgkQiciRfIx6lZ3/RCK+RxOhZkR7lsYgh3lVJBWEeKKddFlLaTXRVgi
         voRPQfJ2lfaYcs+1tMQ48EPiEAuRj2LQ63/N8UY4jJUI+rnvy9Fc/9RvgWlnDTp45DKL
         AJxYpOx2mhVPkm+yupR5fgIhCqBbU1GnzrdcIdZH7Whb2uCq2F1x60O8jx9An7fvezTE
         bj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760321353; x=1760926153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7LwVVt+oIonXpTgbR8cBIFBDId8LwLF2NsksQagWtM=;
        b=w3H0DrAUvf65jsyldm2gwMr2DEQdCOK9UK02CudukXEK+lqQZa23pCmtOwwEz2iEg+
         wd42Uzds9RR6T3tgYRU+180fl8DReiw+7ineuFmzZpjZrzwFIBVIjtXescu8rHHAlFXm
         C2/DEjo67czFy9AqrWpbbDJCDltK/N5nfa3v0Ztq/qvzkYfiYlKBJ7+7SrzcyJsEb/nj
         d4vccRVloW7yTQwQjKfPjj94rn0vWNQF7mN+tIqumlce73/jAV1Au01ZXcDoPhXInd3/
         UjlkG206+LnwSKGiPVsWUsEEgOexJpCD9zftM9Psw72xdfN2GbGxI8vO6HDfbWBdTZWb
         kwwQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1yWNAAlp16MfDpdT1OHf+OcYG0O++GtsTFdRQmIZukvjIdWDBdB74+oR7M2udc0tiuQnqvbsQ7YwoEMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSMLgdXqK8ZSVPM4ikIeBjfhbGUumg1c4qqblxCdcDsmd6Qoli
	+bCaFzu8NFm/xOduoBriKsowXYHI/zLhec2osaLQ7c3HIqR1FFMlrtXMldEDPy46WZmk2W5tqpd
	F6vEuMQ4l4LcRse/nCyTQaSKnX0zRuxY=
X-Gm-Gg: ASbGncsifMbn0U6W92Bv8KsDqWKGR+xizUw55B9Wt94wyDz27mWGmlynlMY8ei/OOGN
	vScXIIew4EdiznVgXULIWGe3N/1AGn7/SItyT0Az1k/mgdSY/nxFwPsD3Fu41nxOnHRYGgrXoLI
	hohmoi/jblfr51tJmHoNO6fahtYiBPf4tma1ixWysyE3Brhy3Z9I51NH43YSqLF9FKs7puFx+Uq
	/SvzJB/s/SC/UyIybAR2pUGoRNJ0UczfuG3
X-Google-Smtp-Source: AGHT+IHVNbPGb048RDwqDj3lyAGwhgF/NMREQX2ImeZH2JgNCDST+u6RIr04BMZZplROx4+MGMoD+CNhHbPvpufAoho=
X-Received: by 2002:a05:6402:144c:b0:639:ffb5:3606 with SMTP id
 4fb4d7f45d1cf-639ffb539d3mr11793727a12.33.1760321352764; Sun, 12 Oct 2025
 19:09:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001135914.13754-1-caojunjie650@gmail.com>
 <20251001135914.13754-3-caojunjie650@gmail.com> <cwgn24f6tnmytd4omr2tul4e5jjin3ijji3ff3qkumqm2xe3t3@ntayu3m5kai3>
In-Reply-To: <cwgn24f6tnmytd4omr2tul4e5jjin3ijji3ff3qkumqm2xe3t3@ntayu3m5kai3>
From: =?UTF-8?B?5pu55L+K5p2w?= <caojunjie650@gmail.com>
Date: Mon, 13 Oct 2025 10:09:00 +0800
X-Gm-Features: AS18NWC3lE60pFWwk3f8ArZQPSoc7l5pOk_MADcRyruwf3oXoyqNAhiZmduKRSQ
Message-ID: <CAK6c68jzWLYgrFXRUsYkvSWE9CRSGVmeyOp7cNhixhyBZBC=1Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/msm/dsi: support DSC configurations with
 slice_per_pkt > 1
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Antonino Maniscalco <antomani103@gmail.com>, 
	Jonathan Marek <jonathan@marek.ca>, Eugene Lepshy <fekz115@gmail.com>, Jun Nie <jun.nie@linaro.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2025=E5=B9=B4=
10=E6=9C=882=E6=97=A5=E5=91=A8=E5=9B=9B 10:04=E5=86=99=E9=81=93=EF=BC=9A
>On Wed, Oct 01, 2025 at 09:59:13PM +0800, Junjie Cao wrote:
>> From: Jun Nie <jun.nie@linaro.org>
>>
>> Some panels support multiple slice to be sent in a single DSC packet. An=
d
>> this feature is a must for specific panels, such as JDI LPM026M648C. Add=
 a
>> dsc_slice_per_pkt member into struct mipi_dsi_device and support the
>> feature in msm mdss driver.
>>
>> Co-developed-by: Jonathan Marek <jonathan@marek.ca>
>> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
>> Signed-off-by: Jun Nie <jun.nie@linaro.org>
>> Signed-off-by: Junjie Cao <caojunjie650@gmail.com>
>> ---
>>  drivers/gpu/drm/msm/dsi/dsi_host.c | 25 ++++++++++---------------
>>  include/drm/drm_mipi_dsi.h         |  2 ++
>>  2 files changed, 12 insertions(+), 15 deletions(-)
>
>Please extract the generic part, so that it can be merged through a
>generic tree.
>

Sorry, I don't get it.  The generic part, generic tree? Do you mean
the drm tree? `slice_per_pkt >=3D 2` is seen on the panels of these
tablets that are equipped with qcom chips. I don't know if these
panels are used on other platforms, and if it is necessary to do it
in drm.

>--
>With best wishes
>Dmitry

Regards,
Junjie

