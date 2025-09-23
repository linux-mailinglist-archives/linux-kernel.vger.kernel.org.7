Return-Path: <linux-kernel+bounces-828661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14751B951F5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD0D77A97CD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB23831E89D;
	Tue, 23 Sep 2025 09:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NZeCg0Nd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7CE22097
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758618288; cv=none; b=JO1nYGlsvGgbz5smdR4a0tIBvL1/01erYSYRud6rl9H8kbgTZ/YJnoFmy5Z5mY7ezpNVwOGEw8Y0HjoZMGOc/0tgfe/x1mD2H2/kwCo23p8G0EHjFB6zerjgwyoPsspYY312z7amGMmSXe1fkGU+A6iUNDpNnI2Gu0uo03UtaPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758618288; c=relaxed/simple;
	bh=P0WFN7aRNdqftnuIi68d4HpYscCk4U0FiRNLtJtBUu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Etj1W+iuAs/i+tKqGadGQ4JqBFua5UiG6P2QzroRuf7/MwWNvROzF7GpA4MLRg7HN9p4tlqs+D2epu+UdkuSDwU8Nz6fMXAoI5+l4Se+Or+DKQxG0ThXnml9z60xapEj40htuQem2Elt89q2cig4UmkVBO6CWNIpZkDMi8oj/9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NZeCg0Nd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N8H65M014953
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fUTOfCDS+FwZcqnC0WEL6rzX
	QpWMHenFORz2Pkc0HRQ=; b=NZeCg0NdaEWIc6aVpKAcSjXkeN4NcZPTFZl0VW8C
	h+KhLltgxz1cdkCJQi3tyP3dtmbPDaYfb003ZwgzT7t8d2MMasry87edP2F+OAB4
	uk4rYCD66H3hqias6TUnOMSOsYdLqgxvDGTNl/3R6qd9/tDKCcrU1Spy+uuFqv1U
	q8NVXB5oEgj4PeruAZ53MEknQ8g2tm3Y7BpofPjztlFKMpPxuy5yDbFbmRiD8XeO
	22MlZ9rRTY2Y1V474X5nnSEEGdQ7LkO7POhPt9ZY3eVIeGMGaqiTs5JumaYwGUpQ
	7MfWyHuwlsnGMn6/l8REYd/aHefv92PewmeFPtXVNrPBJA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3kk3t31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:04:45 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4d1b3c6833bso22188681cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:04:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758618285; x=1759223085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUTOfCDS+FwZcqnC0WEL6rzXQpWMHenFORz2Pkc0HRQ=;
        b=oxzkOsWFXYJSheI8+mSr7hCYJktlpjaimd6jKUz30OyUpoS24IjdIzFVOI7MHiLWp3
         2VNSgLaNWt2KPnuy5dGsFEBF2WmaPGIrgFJFy/IsPEWoRMhWC5Ss+KlFsyrXSPLhF089
         3iWRXVXBsj8kTB6WH3qG+cd+wkvKTcAke441JJFb9qa6/RW+t8WYpvhJVi9J1Y56Nmc/
         TqGdw25NFbMxWUblrtnjeIMaHJLEhdk9nt+4BxApW16pZf5ULiOrPtcu2pISu4xb1Jz4
         UhEhnfIo0gFMpfP9lx5Yo8klUiYQzzRrhXeFuIOti3DXSFy0Fw62JCNk96o6igw+6xrD
         97pQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTiG2WmuvKykpzJ9zrG9APX8Ys7K9WwkoZEPibb8B9BKNc7ngdiYVFe0j6SK+Y1vxr8zDlnJXv7tK2VUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp0T1N7t/22eqZuD1LqzKy32+0mwlr5PtpAOe6bbOJWLd0zozh
	Vp3KrXjEvHZsHCZiFSMNcUv5fr6LPVisy1nOHURxD2i0AviJorDugkS4bTRTkN0nP8iRbUzARNS
	sJ+Z0gXS114JCLPS80YS7w+W9f3R8mS4OqO7GzCO8BYn+c7shdgjGD7BUTsgJ7CpA0ys=
X-Gm-Gg: ASbGncvA74egYgSoFerJiWGOmBfPSpL6fBbI9wzAf/lu8YxDzGeRWvjkG9Z7rBORPwo
	dgDj38A9Sq7RZ6xTkKgahHTS6HQVGOVraEokki2W1ImmQXAiyC97Ld4dbYkoy5HkTM2bowH+Hl/
	vcC5VuYyheDcf6EPem7vqSqSU8QDKckKFHGsR9Ry7vZDaV5GX7yX4rhngQ6pYIghqp/rJPIS4q1
	HxiwX7Q4zO7Rjx4DUWmNw020v871k3xgnG4txaVinJwQ1HNWcFIKmM4CvSHlMkR82Lc+Fic96OP
	8XVoLSDrKP9O7sB/KzSt5E1uz33HDuJgHeKZc5qdcUmDMvgSitp6GCMFujkmLHr/B0Jw0pvk5Am
	FZA+ybUVDZFCYAsgU9jhgXQYZjx9xCXnEpDz4VTmiygKtvt84NKkg
X-Received: by 2002:a05:622a:14d:b0:4b5:f432:c2f0 with SMTP id d75a77b69052e-4d371eafb07mr17395101cf.69.1758618284540;
        Tue, 23 Sep 2025 02:04:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU931Kwgl5hpKElTQeOd6h1dfpDbzGg0HJJhwyeFvQPBMfFUNm8nELbdeyDcMWwCCj+6H4DA==
X-Received: by 2002:a05:622a:14d:b0:4b5:f432:c2f0 with SMTP id d75a77b69052e-4d371eafb07mr17394781cf.69.1758618283902;
        Tue, 23 Sep 2025 02:04:43 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57a9a81f52asm2892575e87.124.2025.09.23.02.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 02:04:43 -0700 (PDT)
Date: Tue, 23 Sep 2025 12:04:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Hermes.wu@ite.com.tw
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Allen Chen <allen.chen@ite.com.tw>, Pet.Weng@ite.com.tw,
        Kenneth.Hung@ite.com.tw, treapking@chromium.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] drm/bridge: it6505: skip auto training when
 previous try fail
Message-ID: <w3t4mfsc2mnv2vu2sxnklntpto6bcbqu2spesagpowdwj2ih5o@k4jtdpafqhh6>
References: <20250923-fix-link-training-v4-0-7c18f5d3891e@ite.com.tw>
 <20250923-fix-link-training-v4-4-7c18f5d3891e@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923-fix-link-training-v4-4-7c18f5d3891e@ite.com.tw>
X-Proofpoint-GUID: 884pPu4_7i3xlaXeBP7w2iu3L8-HGDT-
X-Proofpoint-ORIG-GUID: 884pPu4_7i3xlaXeBP7w2iu3L8-HGDT-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA4OSBTYWx0ZWRfX2KaDFxt4yqjR
 YAOIcSlIA6s9jCUzkMont6fbERDjmyZvpIIQKDmbLLYugk3b/bpAi1VTuc0Md7aZ/zY7CW1ux58
 CEtisCr/yEzDNFIBi99yEIeonh4iGmQ5tuFTExKo5qwwQDbI2Ur+Mg2PXHY9Pl3lwe+7v36+h0F
 9OYAAUJy5mvRUoUlslJxQzt2j9l7RRUb3F3EbB0hraH6eCnwBEQjD00s1iHPczD0vrlZzxsCkeF
 1vCrTjhVFqDFc9q6N7n/ArLdyDKpRMIb2mWTMjAVZrTJdRRDR0Ljx+YWO7RSHmAZG+5OBAzBLaS
 uzQZrHZwE5NaJ9csv1xvT3D2TzO6C1men09LJIyzybK3zc1L5bKkw/wl0f0JtIWiMg0OLuGbkL2
 K8i4AoEk
X-Authority-Analysis: v=2.4 cv=BabY0qt2 c=1 sm=1 tr=0 ts=68d262ad cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=Ns9eNvu6AAAA:8 a=EUspDBNiAAAA:8 a=-4OwpskIBBoZ0mjuRtEA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=LZLx1i01EnjtqRv10NxV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220089

On Tue, Sep 23, 2025 at 02:23:44PM +0800, Hermes Wu via B4 Relay wrote:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> When connect to device that can only training done by step training,
> skip auto training when link training restart before unplug device.
> 
> The driver performs a full cycle of attempting auto link training and
> then manual link training on each modeset. Save time by skipping the
> auto training if it failed previously for this monitor
> 
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

