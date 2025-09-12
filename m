Return-Path: <linux-kernel+bounces-813785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B661B54AA3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAFC8680144
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576A72FF171;
	Fri, 12 Sep 2025 11:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HogY8K/E"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433E12FE59D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757675220; cv=none; b=EGqPAQzUYFwwBNB43BhPRt+3uBmytRupLOk2hrUM1JiAnb5j+FJL0rKllH4cX/4Q43PDt3itFnHcxzUNh3iFTMFAizMJqxJO4SqGbvysb1sOkvabtsUIb2cjsqkCk3pRxcIb4v71Bu1WlJ/j6aP1INdySqV4399TlOuDxTr69xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757675220; c=relaxed/simple;
	bh=CuFw3tp4Y2KS4XsNlMWcxOczBnPSe11GRIKj7TlEyko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDvWFquz749GH+JETIYJf/LYovL1a6zGmKnU0eDmM+QGACAGBQmbSuoM3+m7E/e8Js45N9LjE/OX6FrWu/Bcfa3PIEVpI+emreXSmYJJj6O5e6F8IrMmdfZNhid0pFJZwvaxdjOijXxWS++02VLj7rCYxzNq4F14eub4znGLNrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HogY8K/E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fKap014048
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ObqOUZTyrARl8ec8JgmHRIoB
	QhBr/qr+CrAYCMGQmus=; b=HogY8K/EpkV/pbnGmdiacBZ3fg5WnhBQc14tPHE8
	dGFAFY15Ke35AX8wHNIxpMICYLjk524LwDwH7+ESLvSWfHG0jX+z3POOceLoiFtd
	mtnH/kgcCGF7eD7kjQg5pV141NQ/4vaq5p1iQrVBevtotYv1dq86UHBuBdNSQITU
	+G+1vsOOMsDnwgnCFcy8uVTCL2GuIWHBcliJ2eDN96TsP1+TpiZOuRLLcJhEdxeg
	brvRfxMyhf6EKz5PpJsb8EZ8HVP7Sb4Pzxw8kqZtRJ8s8XJk4yO0IFKWn1zseqy9
	n9dvE2lcfcF9bRA1T8jAva9OKWZkM4p6WBf7GfvB3GEAUA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 493qphw4jp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:06:58 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-76485dfc1f5so41436556d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757675217; x=1758280017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObqOUZTyrARl8ec8JgmHRIoBQhBr/qr+CrAYCMGQmus=;
        b=MFZkTP+GhqkSuGUIcGMRvIxBgjXC1uX9B/YLb0Z1FSptpKkUx4gS9w9tMLYopbs7mS
         uUYbQkI3FgdUsoNJnVl6fEeP3V+HSvoNsJQbPf3O9motegU55i15xYzvDRvixSQWbV1X
         tyAFOWcyjyBIhvBbVKOrbBClFo/kAB8eLalug6jeEw0itlu4kja2V9kdcRzqVymBwZEf
         p/Davu4L7ETR4PQOE0C2Dt1ifgIvIjbb/xwIEN2JLtRR3rgAC2n1JDK+XfnAwl5ivJ4m
         6vy+CdPeaNBtliMy2VV3ZKAzD23HVQtgNPbfjHZMd1BLqm/sobuXUrBX2e/KKM8e4p5W
         0xIA==
X-Forwarded-Encrypted: i=1; AJvYcCUw2uzJ6580mwHQm6x4rYcxxyC2nH3FmyAa9I/t860OuetBruIp5mPCW+iqgDe9KUUvpNIm01K88foNBXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYbe6QUCjYkG8D2oKIK9oto/hZ+5F/SBAQb2glvzKGyK28BXDW
	4PUIalagz9lf7a1geJ+QE0VHknMr8C1RjBSJfnd2/KlnhPp4qkwoc9edKUssbkhU9czNiNoShI+
	buCT0e4UTWzs5DZ3NRC2nWwZ1UD8/Y/FgWasYLtmw8RexYPp9Vo9JJ7I+kT778FQPa2BhEKQFaP
	g=
X-Gm-Gg: ASbGncs+5ExH8HvCH52gstv5rhK4zQV+h0sNGhiyQgw/Y9U3QQJEzxxU8U0bUVv0SZr
	eZBnAphT3YXVlE5ylFC8FuKSRVZZaqOtSvGx/+LfOtmY47eLFud4VlTMKVLNZdVID3BAjTauGzs
	hFMg71OfQgyClOoqGEu/Fgi/3wTkw6v4P70g3roTjo4f1JSTuE9lCqp8cizIk+iSEIQ72dITOMX
	Pe/7Bzi4Rk1jLbOv1En7lYhWX20SSGblx0776B5NiOi8SROTWmG93T9XMGKGsMyL+Isc4TZ0ExD
	3ApLiG4K95ZrlZZJl3vmF79JqPoOegX5OHggY3L3lzTuXPIjE98MpRGtuCQIWjmvW0AwdauA4o1
	/fhQrWsNW7/l9928SByANbzCAW4lP7+dcKiXB6tcPAG11sw092oEF
X-Received: by 2002:ad4:576e:0:b0:70d:81ce:ec1f with SMTP id 6a1803df08f44-767bd2881a8mr34381606d6.12.1757675216782;
        Fri, 12 Sep 2025 04:06:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzL4AO8dNGPWgFHm6qvxn4ogauEObB1TwGr9YSH5AEOx8Q+cb9zElyfiMXPvqBFGwT80wJCA==
X-Received: by 2002:ad4:576e:0:b0:70d:81ce:ec1f with SMTP id 6a1803df08f44-767bd2881a8mr34381126d6.12.1757675216206;
        Fri, 12 Sep 2025 04:06:56 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f15a5834esm7432661fa.10.2025.09.12.04.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 04:06:54 -0700 (PDT)
Date: Fri, 12 Sep 2025 14:06:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, jingoohan1@gmail.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com, krzk@kernel.org,
        alim.akhtar@samsung.com, hjc@rock-chips.com, heiko@sntech.de,
        andy.yan@rock-chips.com, dianders@chromium.org,
        m.szyprowski@samsung.com, luca.ceresoli@bootlin.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v5 16/17] drm/bridge: analogix_dp: Remove bridge disabing
 and panel unpreparing in analogix_dp_unbind()
Message-ID: <zt2kyoq4rnn5gbb22vvpphqwmbbv4vecjvc2iepa6t5iljhpgu@xckynlkyyjiz>
References: <20250912085846.7349-1-damon.ding@rock-chips.com>
 <20250912085846.7349-17-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912085846.7349-17-damon.ding@rock-chips.com>
X-Authority-Analysis: v=2.4 cv=aPDwqa9m c=1 sm=1 tr=0 ts=68c3fed2 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=s8YR1HE3AAAA:8 a=EUspDBNiAAAA:8 a=0i7CoW_5q_0ZA8A6Ya0A:9
 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-GUID: hhXtjN4iEOpqa5axaw443n-W2Wf0u7LV
X-Proofpoint-ORIG-GUID: hhXtjN4iEOpqa5axaw443n-W2Wf0u7LV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTExMDA0MCBTYWx0ZWRfX26lwpJ/3yEfl
 /Mah4h1Twipis17A8NXPk7yl8X1sFs2eFIGyw5ln4hA/hGF+3CHSX2Tik5BkH4vnIAoOZFmCd3V
 xAh4WhC9eSxm2g9edhTqkNu9NkeiZCZZup41r2Q4uBseBWbFe9/HH3Frqb+I5LDoHd2I+Gavws7
 1dojb1pt5ny/Pyro+UWQXkmxWNfh3xuMhgO7tv3N9LIdg01vj6EQIbFUXwkqDtt0KgK2ph8duio
 de+7Is9sHIdVsIze2Wq/4g4Nq018mlRr6Xsodfl8pItxb86qONAQmSZDkb4Gs18JhdCOYaS7OGk
 TFXvY2U3au7nGtNZTX6Gm4W4q8SzZ+LARNYT5aqcofP39/qdxmd08hSu1xFD8hr25wruDYApQ8W
 931CBLA9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509110040

On Fri, Sep 12, 2025 at 04:58:45PM +0800, Damon Ding wrote:
> The analogix_dp_unbind() should be balanced with analogix_dp_bind().
> There are no bridge enabling and panel preparing in analogix_dp_bind(),
> so it should be reasonable to remove the bridge disabing and panel
> unpreparing in analogix_dp_unbind().
> 
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> ---
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 4 ----
>  1 file changed, 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

