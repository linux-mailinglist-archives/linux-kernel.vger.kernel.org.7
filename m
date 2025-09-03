Return-Path: <linux-kernel+bounces-798169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21150B41A41
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C26E7A1F35
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59AF2E2DC4;
	Wed,  3 Sep 2025 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cJTt2uvl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B412B2E8B85
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 09:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756892390; cv=none; b=RHTljulDziAfaKi7QGzSsn41BPbb9ndCG9XdwszHxwbBqo7Z/UKJAWlWpNZHRBLT6yj0nR/LfsUaclS2Z2LOexuv6k7ezZCYUMr8aEdISRcdFHWgKnBrCS5j/Fo15oU5oGfZPgcVgCvB57hvParH5APyA888UzpOmiitaS9b3UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756892390; c=relaxed/simple;
	bh=Iod6MVqSTEvTZBDL2mvodsSb964W4mjOh9p5Hpm6SDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvzI3IHpKx6GBhQvUqZURNVAlnWHq8XMFfMYX9nWV2r3Q36u+QVGCG+JJLDxVki4GyGRJoh/Nk0IMq/k3pvFuMV94ZOoGnhdvcQ4BRp66VgHsJNKeWmZjDxrFxOo8B6RDD5kN3dcCVjq47JdzINa2cQAl8gVUFabB7F4mSvWwvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cJTt2uvl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5832ESqI019593
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 09:39:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=PnA1zrsRSyNw0gMpmXgq+WAu
	GqVrfq31mjMEHuIgNIs=; b=cJTt2uvlRhcLEXPM50l2Nn1iHr+jDECvtViTFnZf
	UGu+lRvLDRrZWQoQI9v/YU3qR0UtoofPamSPNvmZq7hrUqAPunqKTQSzrMaJzfW0
	PlQ5lMQdE9XAmVrgfXZCtqFker+/f7kGTYOBeK8kx+DJhbuL3XKYxKbWdleTdCtP
	vbYK+SyOklxkLHFpMi/OZ126Apr6olaG9MrZIJKWDaF+d0TK0Kt3G2zHZskOXHpu
	rVN2LbjTGH++paxBTKcuDOiW0TYHaXtlZfW63T7F7oRBdRZ/08t4CStSOwM4MeEq
	m0glasTpCw+2/MPZtFWellcbpHmLxakH9BUpNyMSaLfwpA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw03433-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 09:39:47 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b34c87dad0so29339061cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 02:39:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756892386; x=1757497186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnA1zrsRSyNw0gMpmXgq+WAuGqVrfq31mjMEHuIgNIs=;
        b=aGp0V4NBU4T5ZBI/94u7xeFfWr5X3YotZxoTWZ8nsJ/wCCy/YCo4Yh0OygSRXWvdjN
         uKhshnIdlquGbLI81O4kuXC8lsAvCaw0h5nBzJeo0VkAyLe3S/rAx6d8Rn0dKgUyXu44
         DzETMVQgI+7ikzgIMeNo7Q7reVZfTecNZa+oIjyeSBvxjUgaHel2w+m9PoVlyUmOv1lu
         bWSJPMCW92vj55ivfM4Xb+pZ9iHzN1JsdoaFguDBcwEg/kuef2Yt3SCuYaeIsPR2VH1H
         pCI9bBI9hTqQLCjPpRQCdsO72Il/qZFJ9RP34xLxpHI1YoGHlFyKiv6ZfOlBPRRjOgO6
         jCoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd1+aNeC2/v7cASXOXYarWbAD5K49gpk2wyXvoZ5jsvUOOruIncBt/9kO4dUWT+gw0waI+WNuLPk4KMZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxveJpoPxcNntkEWj1QfVHUfMi0Q0Xht4/rl1XWUmee/6rxPGkc
	hRfWxWcXFXdlmKFzSixrnSiR00OwA9AlKtWDUL5qLfgtsol7aAMNci6NnEM5lNdIu1rO5SxJ4zo
	tyPMBhO8MDww4QpzwTzjH32D4NUawZeXVha09N/MS4ZEi77eQui8KkMH31OUib0wlVqtkshWZPN
	0=
X-Gm-Gg: ASbGncusphXigqEhNk5+c6NQdE9z1L5MbPp496fmc1hIIFwiP5e8TOhIS2yH1aD7HB3
	58HbhMcURH9NQq3LNYhD2XhIVLY6wNf3EuFlWyjPx/WutFE1FwZ6/BO39muN7IxU8SOZ9zqEz+e
	dWxCr2gdxspZl1GgIcX5Y80M7AGNBt8qApJk9fQzLVj5fl/qp4MoBs/Rx+A1WrdggxCCO8MRV5k
	/wA3PQgjuiCNuSD2jR1uNhj73/opfC4equ5ffa7GEAQNZfCO/wo2qEsbBmkpg5FauMJdN8/1Y2R
	1H880dO/6+ItKYmhO39WMu03s/xHHd9emgZO3lL4mKh90Dq4f1UQHOJR9SgQne/sZtBuNUuzNUw
	rptsh4uC+skQ1oKYOU3EmG/apG5iQbxSBmnh0zJrbZCIWL9d6eMhL
X-Received: by 2002:ac8:5d87:0:b0:4a9:c2e1:89c4 with SMTP id d75a77b69052e-4b31da3d038mr175175281cf.47.1756892386372;
        Wed, 03 Sep 2025 02:39:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8btfB/NeOOnX7chjqs01CjROAGySEXXXx2uoY7nlmZ3PqyzGxeauLl8pu/1CkaS6/4jaPqA==
X-Received: by 2002:ac8:5d87:0:b0:4a9:c2e1:89c4 with SMTP id d75a77b69052e-4b31da3d038mr175175011cf.47.1756892385878;
        Wed, 03 Sep 2025 02:39:45 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad5027esm397058e87.149.2025.09.03.02.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 02:39:45 -0700 (PDT)
Date: Wed, 3 Sep 2025 12:39:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 12/13] drm/msm/dpu: support plane splitting in
 quad-pipe case
Message-ID: <xcq25wmw7roelcmoljypn3ozt7kqvylgibz2cloxghaeurcwvs@jjay7hton6md>
References: <20250819-v6-16-rc2-quad-pipe-upstream-v15-0-2c7a85089db8@linaro.org>
 <20250819-v6-16-rc2-quad-pipe-upstream-v15-12-2c7a85089db8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819-v6-16-rc2-quad-pipe-upstream-v15-12-2c7a85089db8@linaro.org>
X-Proofpoint-GUID: 9pM6YCPLuuLYmkvC4yh-7KCoPxvvcpc5
X-Proofpoint-ORIG-GUID: 9pM6YCPLuuLYmkvC4yh-7KCoPxvvcpc5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfXxL+jmUwi490A
 TAfYD/hbo89ZcZAhOOOdB1uWg4Q5LI3L2xvyCEUAzxFL7Pf636sZYDog52ZA7kAdxzzwZYiCSNG
 sIce9wMI4fB/ie3ii2yYpNB9cHR3PJH9wF2R249v4eVhGSn0ijcl3VFZIpYM4vkUmkvBymf7Y//
 dzdtveMH/z7QcbPIVXSslLbuMweP3Xkm0ueQ3iAXuYftCE7F1TJW8CapTFgS0A3hb6d9mthMB5u
 xScW3U4IqkbYgEP/2HC9YkODDL42WD/jvwH4slGTa97IWbUkSkPdO22AwH5l4FdKSexUeiBc+9h
 0dK9Q0n9vgoUmqYG/vmLVcRXA5wMAn7MZNytcAvIXTvTRtk09hrhiivSV2IIPtkYAmvMrXClRb9
 0HLbSS3l
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b80ce3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=sWKEhP36mHoA:10 a=e5mUnYsNAAAA:8 a=KKAkSRfTAAAA:8
 a=n0UrGh5Us5r51zfKeZkA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027

On Tue, Aug 19, 2025 at 09:31:06AM +0800, Jun Nie wrote:
> The content of every half of screen is sent out via one interface in
> dual-DSI case. The content for every interface is blended by a LM
> pair in quad-pipe case, thus a LM pair should not blend any content
> that cross the half of screen in this case. Clip plane into pipes per
> left and right half screen ROI if topology is quad pipe case.
> 
> The clipped rectangle on every half of screen is futher handled by two
> pipes if its width exceeds a limit for a single pipe.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

I've run several CI workloads. This is the first commit which breaks IGT
tests. See https://gitlab.freedesktop.org/drm/msm/-/pipelines/1503075

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c  |  11 +++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h  |   2 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 137 +++++++++++++++++++++---------
>  3 files changed, 110 insertions(+), 40 deletions(-)

-- 
With best wishes
Dmitry

