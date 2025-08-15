Return-Path: <linux-kernel+bounces-770806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 904AEB27F20
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F8FAE11BA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33342D47F4;
	Fri, 15 Aug 2025 11:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wf7M3Oz0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14E5285C8A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 11:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755256993; cv=none; b=HJHQOJ1gDL8A6W/l1ETwzmUMFczYTfclbC5KpsmbOL6LwiAxJZBkqOuf+zuueq/IYW4btg3QT3a2tr+v1FW8iqZeeYcT+BdH6Ff+/ggNcP84W0bTTsZFU24rT9amqXeVGHNd50eTAKjV/33F7zoT1quJNrDjdevhxWMNHUfLZRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755256993; c=relaxed/simple;
	bh=Y4b9RHGk5FuTwKgZo6QSS7Z99ahbeLWA4mpKEy8knmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RTOj/kZtE82HrH4besJCCqhhRrMkmswp1zisIcp+1ZH62kpGnCcPdub1q7AdWYMNw9oFq0Y5BblwDRTOIZT0mCp0vNJbZ+YfnOIs5hHgJGoWmTrzypHgvWhu8LJ7JsKKlRUrMIfCpKAHNlf/44PvM7KZadcGUO5xEHvisdLWQbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wf7M3Oz0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57F9lsT8004473
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 11:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y4b9RHGk5FuTwKgZo6QSS7Z99ahbeLWA4mpKEy8knmU=; b=Wf7M3Oz01B4Q6QOQ
	zFZCh+sT2n9qM1t8rRLAybgFUzqaNVCrnOkoCoSoHXCUADUPZrhxHjkfioLJgPEB
	sWfWLjoYAuaqsOJCS6ClZ/iP0Y5yiRPlFmlzR/Fwla5D2xBSli3ENXZtsO8ryu07
	Z075qCeXgr0owQiEMdjIT4wI/HAl1VCpfJ0KxxEnYHMXDiycf9QkrRyWxsqRllTc
	5cFpg1C2JOz3myYcxeuHSosBcAh4NGiKJw7NDRemdFvPb0NXv2pb96eWwOj5dY5M
	uvFrOR6Z7UQ/v9CIzkcB8AdWD9krK2H1m3IFcLZGbJ0acDeAoWSKpitnAhxmiZ6e
	MW0vwA==
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48eqhxh4nx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 11:23:10 +0000 (GMT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-88432e1d004so206526639f.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 04:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755256990; x=1755861790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4b9RHGk5FuTwKgZo6QSS7Z99ahbeLWA4mpKEy8knmU=;
        b=F5asAnFu8zK2vvjr01OIWjwLqOx/hVkgtbf/TVwMN5DWStK+L7u/RgfzWsJHMO8GG8
         2S6lN2PJAQ2D0Ufz9EYdQ4Q/bcRQhzuhh9zE8ctWSG4NMLehhPOwpOskKPn1T/eGq20r
         v8GspTJiWtskMYS5k8l72Sn3xT7qBAEsDVCImuiAb2hYx1PL3Fka28r3zaoiVzK+tL/g
         tiXuLSPZh5Nx8kHGhLfCaFq1fLGMkXstOtnmRZTmnAhu4cIjH4E2mGaPeAA0ZOi3xIMY
         YsNJUOBo3FGTjpFcXCEa94brkHRubEtCnxdJU0g2fGsAZnh5qf4ZvkTQgwZ8WkDl45Hs
         Uc+A==
X-Forwarded-Encrypted: i=1; AJvYcCWCnp0zyxho6iQ5PjisVBz3nlFoYF7pIrre5QWs/3Iw9MeFH8QNPAmWjS7pzvKz5WSfvgbG6dtO2Cy0cAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVdF+0KnoBzwTniC5Pg6z+kDvtxqViuKZ1TZCk+hAVljJO46hg
	LLO7LK2mY45U1yop4w45gdLf9tvd+AZXbzRnRWSLgP3kvjViqFDY2sbK0qVCuvDxNHfAiaarCW/
	nPdh1gYWUkbZ4Lyv05LhRIV50u4DdCRolr81altzOPpzAmYYU2IOrlFMEDhSl3lcOGiSiLP5wlA
	tn78AYDhCbZEetKEHP+lM9OG9amlJeKn2nWLPJCKJqBg==
X-Gm-Gg: ASbGncv2eycQ7/2x8TOXbLi+dez2fD7SdN+dhdnb1osETwe/liYvE/ADhKRCjfuGZa3
	DHxRWAfKQIVnPKF4vPf5zwrQ+XLcva09fi/OMY5sqUrQiNe3octhKlqaSsZKoRWTKvhERSoSYYx
	/1pYp/H2e+Y3mqWaKlNhPq4g==
X-Received: by 2002:a05:6602:4f86:b0:86c:f3aa:8199 with SMTP id ca18e2360f4ac-8843e495e01mr325663839f.11.1755256989751;
        Fri, 15 Aug 2025 04:23:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ+ruMJ4du6+6g0nP8YZAkSswv8epp8ueh0uj+5gCKOxs0IVlgGmW3dr6Fkri8yCflGk2TEH9pfq2BhwVZoJI=
X-Received: by 2002:a05:6602:4f86:b0:86c:f3aa:8199 with SMTP id
 ca18e2360f4ac-8843e495e01mr325659939f.11.1755256989397; Fri, 15 Aug 2025
 04:23:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250810-msm8953-cci-v1-0-e83f104cabfc@lucaweiss.eu>
 <20250810-msm8953-cci-v1-2-e83f104cabfc@lucaweiss.eu> <aJnefpETGJm_cuRY@shikoro>
 <f956eccec6b8ae2737b1e758b8357051@lucaweiss.eu> <aJ7wWDejA0KDarIE@shikoro>
In-Reply-To: <aJ7wWDejA0KDarIE@shikoro>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 15 Aug 2025 13:22:57 +0200
X-Gm-Features: Ac12FXyHLyjoE0VR2tgvZT9ZWKQ9V1qYGFU3UagVhwtyFYiZHmsAWnzbmBeXE0Q
Message-ID: <CAFEp6-3pZAt9557us4ihM3-ifrUVkYx+LneuORVafYQGeVyiVA@mail.gmail.com>
Subject: Re: [PATCH 2/7] i2c: qcom-cci: Add msm8953 compatible
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Luca Weiss <luca@lucaweiss.eu>
Cc: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA1NyBTYWx0ZWRfX15R465BcDBR0
 TOkNriOIZkp59Nji2G0mgVW1lvSc+wBjVuXrYauoMF+7tZYBFYT2W044bcOYmQQPxVBX/7TjORb
 IV81jexqvChlBFOC7bdGPXJWdaFf3TP7K1iknHTZCHUW4+wU9epm6JSFCnPgZctN8bgP05vSZSE
 Pca788gVqZl13I7p/Lj67Zo7zwzUUpIlIRssDsLdW+kyy6XS4i8331SRG00RRZDweiW1pX7MYTB
 dGLATdRJgxCvtADeJVvaqJA0K7h/MzqqF8E3D5TEUG+QAn8qpqD1GLYY6cJeHKeJH2bfbyG34CZ
 ekdGliazQj6ULwSjtqBhVD/y4CM69cSLDishe4y0rw7vfcI/DBvqa8DiCCAfOsRvEZECX6X3Vf9
 Dem1y1dW
X-Proofpoint-GUID: hSWM4ICwH_OV_g-mfjDPTbnaj3wdZ2nq
X-Authority-Analysis: v=2.4 cv=aYNhnQot c=1 sm=1 tr=0 ts=689f189e cx=c_pps
 a=uNfGY+tMOExK0qre0aeUgg==:117 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=LDBv8-xUAAAA:8 a=EUspDBNiAAAA:8 a=y0T5QYlTslmZlUxBBQIA:9 a=QEXdDO2ut3YA:10
 a=61Ooq9ZcVZHF1UnRMGoz:22 a=DZeXCJrVpAJBw65Qk4Ds:22
X-Proofpoint-ORIG-GUID: hSWM4ICwH_OV_g-mfjDPTbnaj3wdZ2nq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508100057

On Fri, Aug 15, 2025 at 10:31=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Hi Luca,
>
> > I'm also not sure what these parameters depend on, if it's CCI HW versi=
on,
> > or
> > something else. So naming it after the SoC should be a safer bet. Also =
the
> > msm8974-cci was only named 'v1.5' because it's an inbetween mix of the =
v1
> > and
> > v2 that were already upstream so arguably that one shouldn't have been
> > called
> > v1.5 in the first place either.

That's correct, this is a local version, not matching HW IP version.
The config depends both on the HW version and the CCI core clock.
As our timings are statically configured we should also ensure that
the CCI clock is correct...

> >
> > Let me know what you think. Maybe also someone from Qualcomm/Linaro can=
 jump
> > in and share their thoughts, if someone knows more what these params de=
pend
> > on.

That's fair enough.

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

