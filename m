Return-Path: <linux-kernel+bounces-801220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE90FB4424D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B1D73B3B7E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CCC2D46D9;
	Thu,  4 Sep 2025 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wa4jLwVi"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CEA2264BA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002207; cv=none; b=ENmdVVSx6cxABQvS/7pNuV1WGGlNlk94yLjja6wykQbx6dgYV8BJ6zikthr2TcD5uxMt29wq5lyRZuXrR83wkgt5Qyj377jOXiPbOmceSpCEr7aYRxPbx65ziZ5GFeZiU3U/VXMRlwEqR87lriLyrSP2UTsi57bsUkIdTrUw1mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002207; c=relaxed/simple;
	bh=4B1WDqfUq2D6wUhHvf0RYUUm0YDiTX9CuzgLwCT63hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rK4onM8HrZsS160ghaoUkmezr/FVk2ceJFXzge8h/+Gc0niSqMR4OxQi/dgR5U1S7RfgWAP+DjMgPx7O3ruQH745Q+oRfLZL0bvM/W3f50VSZvIE1Im6+nFbJjkcTVE/DZfAu2fVhioSWYDegtRvkhM6GOGtw19sI6ikc/WKaZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wa4jLwVi; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d60504788so12415717b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 09:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757002204; x=1757607004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0WjAIlRtq73jqXFwWJ/YWFSrK/kill+F6JVs0WrJkQ=;
        b=Wa4jLwVipnWtcJ3cPVPE5Obr3BZVxjTHMugwXYlJfJ5r4++RKsRhiUj31KICutrVST
         AVxREnuSidurkqNhC+JyHFP6V8qLHKxb7jZfufIthRZB3xhYd0Pjqtxmifby4NVlx7el
         ctUffwp8fusc8+XbcbqMmB5/5DMIUVdshNv00IBq3IMl7L8NQTci3Tcy1XrUgEbFHtpr
         JHvZ6zXO6YF0tzkoOfEuAu+vwj4twZ1PmeFZXxv+EYs3FBP3G9PJnVjQ8Sif9B3YW0Nw
         Q7HL0Bpm/qCKkMdrGs0AIIHCr8WmZtVZ0kac/fariYB4wWHYdYGRtB0KVn844Yx205Cy
         Wm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757002204; x=1757607004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0WjAIlRtq73jqXFwWJ/YWFSrK/kill+F6JVs0WrJkQ=;
        b=O6NIwjyaXYbA0IiiJfr75e+W5XDJE60ugP5aGsiol4cRhIhF37SscY4A7i5mAsGFA0
         8gf551/+lojerMwbnvl62cD2ujB28D0LyHZAGw+tJeJw8l6r5E/nmqxZicqElmCCve1h
         5rSLVBjlnvaoL0kgzU1JRPa03cAJwaUWRGkm7mb3Vzw6c9QrFGv9w7HJgRyTDUb6koBL
         uU0vfpEOpBDjHl/45q8X+0v72eiWACB83jnQY16zCN+Paql/H5ERcRysPmK4VtbX59Dv
         9WuUQEmYWjBbtQyvUhxcUd5uOObvg+4rxv+cMqb08ptzalocQVDo6xP6GCe7jPFvrGrN
         0i0w==
X-Forwarded-Encrypted: i=1; AJvYcCXJkQYaAvWHPgsj7m/zTjWiMPWIrZABNGKdGH0VNBWSprU5kk8+Jhc1FoXc3BWlfjXWfrBt1BwB16YSsPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6lIYmImbKnW7TNOZWn+MYxr4Jx/Qha9nzpDR5ekNfr7JF2coT
	R2i9hKQSYSaYOZfafqBXiXtKUj4UsPLRTudqb4MukUdn6KlNQeAWFVX8lr3YeMjZIHPivDVz0h/
	8hyD61I8OSNmKLBFGY+8qljieijDMmnUteYj1q4fCa6al3wWVl9F25yM=
X-Gm-Gg: ASbGncsbN6NxmZy8iXpbsno5b2/ttzQgH6zAeVehHsy0hExoPQ9pLnGOoCSkQ8tMIX1
	o4aw1p2miZSFA8Wb6KV03EmP5DGD+N/byyYlgEkWrytUEvarFP8TtAmon2iZpuBn0Bp38Ui2wKp
	D2lAnpXOK8zKeyfsqH3/ZxstFLlmYUMonsQLFP8zBWR5cuBc93o4WNXECjutGcPLMC43jvayQcc
	ziDYwyctmmdV7Ho5hEIPo6yyVs1ag==
X-Google-Smtp-Source: AGHT+IEkDrp/iAHP7LO1Blxb93ohjQvbbpujHX05sJO9KR7HZ0IPMJaCz6DrlDT+Kc+vE46+lITVA2uee5pwGcRyfs0=
X-Received: by 2002:a05:690c:7446:b0:723:b0e1:af82 with SMTP id
 00721157ae682-723b0e1b035mr107641407b3.30.1757002203809; Thu, 04 Sep 2025
 09:10:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-v6-16-rc2-quad-pipe-upstream-v15-0-2c7a85089db8@linaro.org>
 <20250819-v6-16-rc2-quad-pipe-upstream-v15-12-2c7a85089db8@linaro.org> <xcq25wmw7roelcmoljypn3ozt7kqvylgibz2cloxghaeurcwvs@jjay7hton6md>
In-Reply-To: <xcq25wmw7roelcmoljypn3ozt7kqvylgibz2cloxghaeurcwvs@jjay7hton6md>
From: Jun Nie <jun.nie@linaro.org>
Date: Fri, 5 Sep 2025 00:09:52 +0800
X-Gm-Features: Ac12FXxuR9VMKn0d2kpIG3AfgErZjwj23I8v-YMzsr0ZIo5YsvdKfiRaZSKyFmA
Message-ID: <CABymUCNXVfZyhCbkiqzJ-K2zGe=bofD82OD20d-CG+a-KkgN5Q@mail.gmail.com>
Subject: Re: [PATCH v15 12/13] drm/msm/dpu: support plane splitting in
 quad-pipe case
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2025=E5=B9=B4=
9=E6=9C=883=E6=97=A5=E5=91=A8=E4=B8=89 17:39=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Aug 19, 2025 at 09:31:06AM +0800, Jun Nie wrote:
> > The content of every half of screen is sent out via one interface in
> > dual-DSI case. The content for every interface is blended by a LM
> > pair in quad-pipe case, thus a LM pair should not blend any content
> > that cross the half of screen in this case. Clip plane into pipes per
> > left and right half screen ROI if topology is quad pipe case.
> >
> > The clipped rectangle on every half of screen is futher handled by two
> > pipes if its width exceeds a limit for a single pipe.
> >
> > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
> I've run several CI workloads. This is the first commit which breaks IGT
> tests. See https://gitlab.freedesktop.org/drm/msm/-/pipelines/1503075

Thanks for the work! I did test locally with all my patch set on sm8650 and
did not reproduce the issue. The baseline is not aligned with msm-next-luma=
g
yet because I need to port my platform patches to it. I will do it tomorrow=
.
 Do you think this issue is related to difference of sm8650 and sm8350?
Regarding all failure cases are write back related.

- Jun

>
> > ---
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c  |  11 +++
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h  |   2 +
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 137 +++++++++++++++++++++-=
--------
> >  3 files changed, 110 insertions(+), 40 deletions(-)
>
> --
> With best wishes
> Dmitry

