Return-Path: <linux-kernel+bounces-746715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1246BB12A58
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 14:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 086621C26131
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 12:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D2D241664;
	Sat, 26 Jul 2025 12:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o6+UkxTW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F2C21D5B6
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753531433; cv=none; b=BgLhWPIDo3rSNnmyO5gQgnCAX6vgPfmduZOnftEUNh+RgtsBaXjRXiTcDQe7RryAOoBDlWJQ5i+oCxTGHpuRQ9/hErRCqmylTxVXDQQuu1TONbb8ScrSpRrJzyDswyf573qvRXbjgoKJZLvvJ8UB23m1mjugwb72oDEa+WUhTJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753531433; c=relaxed/simple;
	bh=RxHShZlOwAJanRp5Ay0Ovd6Lx245nW7fyFNBhkmorK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+2xCbhVWfHrnqz9QbXgOCdwssDoguESVq7jEhPzUgIjqYTCwUZtaHJv/+xSKZPM8E7k2skcdJ9kH/ed7DdURu97OJrA2VBW16XmequzJKaPBgypncK+fyl+wKRjcW79+2Q/A6plMqarAcoJTRx+b/TigjxtsPhuVagAc2d8djY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o6+UkxTW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56Q9usve015710
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 12:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1D6BmR83TK96SbIkz00tF236
	OzVTpRaO1A1uvpbe2kU=; b=o6+UkxTW9yXrNwNRUGXnacOqvHp4+4zOl/lOH+rD
	eIiLIB3ZeSD0ltmuqE029Glavkd3ATJLxAJxi/1fEBNsUvQl2H206QImn/vkyEUG
	CZ7wDU/bRB0ERd2Ko+g21RL7Nb/SODcCrErqZUl3/0ulLg4dZQyvn0zagOhI3Ccy
	Bgq/FImLNqQm3rEbe/9Xq5GSrDwK0biq5ZpImS92MFZPyc1fWAs8jF/vmb/Z7qd8
	37Ah6SKo8QYGFlQ0YMn2sdVW9EIvHl2BhmWnN6iseHjFwE5bZaqeo7K4suU9+F1Y
	E1iEb5F5idMvFr6HIybVTcBWUV+hYJFc6I4iffu+GU39Ug==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q85rjak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 12:03:44 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-7073834cd71so2605736d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 05:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753531423; x=1754136223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1D6BmR83TK96SbIkz00tF236OzVTpRaO1A1uvpbe2kU=;
        b=seA8WQxTN6j7zid7zWoV56PsUjvCjOfa7fALYa2gdepTffbLLw/M08B8gs6s54dz/n
         XmouRY6QyXfM8sWn85Umum9Gklp62rsm2cOJ5VueVUjTnwG+ecPT5414pUNjgLr/DCFb
         1FQY7+WiTXQBAfeHeYnsTDwX/HsNHxBGoeHDfcEEzbh74llkZ+rlaYFlZ5iJhiMXz7Sy
         QVR4MnJ3GPaGhrIdrFYLLlmJgYhai9WJz9IxQrUdS2Rykb6NFR9cnzf1yth8XqMzK1tA
         81ttDU+OAHIGOlzlZMa7JNjnTI4ARhyhrfbUMK/HboDasUe7uVONF9IJz1KIkYfoQbYw
         qn9w==
X-Forwarded-Encrypted: i=1; AJvYcCWKhojbn3svM9SAbNiDYpyr30YcaeWmE/gW6XdnoUdczpdHfrnQ4yZ3GKuSA2ubvjdRrfAPCQVh7zc1jEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YySR0q8P7dN250qanUJZXkezvG+NuxBXR0AIRk8up3OXUImzcCQ
	4RrZM7unFyD8xVQtxGNmJMhYMBVCSYyGNJFxu+8HOrtplyCkZICD+5Isj/Z3NiWSAPhewAzKTiF
	61ENZoc5UDyYy1t0ar47xEAIlhP/cWXF0jy8vOdFENgsoFDCzjEHay1fgU2qE5lOhi9g=
X-Gm-Gg: ASbGnct8b+hAAxzb0r5t71vKS5HLt5d11knYmGfsshP9LKalsINIQW9fEGBNiPIYAz3
	13fn2KwMnCnaIi6p+NMT96dMlRgjJL90ovP66lf0hDwl6+45MMOnPjYR1wiM6pRjxcV2N2pR8z/
	BLjcjNu22g9APd3GtDAL/BtI58GYTCV4fCNXCeaiLwi5mh2RKo9uA5fl02+Yoocwg0LWRCYZQ5b
	1VrbKABo42JYAZYmE6SWMtMKyYw2XFACBOLCRCdJDnK2mKsd0ib4qKk6I69qGGY4K38q0fXyMGy
	DxeRbCULQRBuU33qM00CoVMjYsVyvbt2WFzzs1XF9itGhTzapnBPq7OiCaALzDqnMFcJrXjtObN
	rdvrXM7QSicyh7450XBBqcBLLDcKX/L7yK20eRxE1dtT761jHvIno
X-Received: by 2002:a05:6214:4e06:b0:707:2230:b6af with SMTP id 6a1803df08f44-7072230be23mr48057996d6.44.1753531422894;
        Sat, 26 Jul 2025 05:03:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXvFtpJkzYIeiG9nyGHhRK7mR3gLP3VEEBXF+lBE97EG8zozjWb6VOoTWSf2I5TC70nhrV3g==
X-Received: by 2002:a05:6214:4e06:b0:707:2230:b6af with SMTP id 6a1803df08f44-7072230be23mr48057536d6.44.1753531422345;
        Sat, 26 Jul 2025 05:03:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-331f40b339bsm4061511fa.23.2025.07.26.05.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 05:03:41 -0700 (PDT)
Date: Sat, 26 Jul 2025 15:03:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, jingoohan1@gmail.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com, krzk@kernel.org,
        alim.akhtar@samsung.com, hjc@rock-chips.com, heiko@sntech.de,
        andy.yan@rock-chips.com, l.stach@pengutronix.de, dianders@chromium.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 09/14] drm/bridge: analogix_dp: Add support to find
 panel or bridge
Message-ID: <kulhumudepz3lqm6c36wbqtc4gv35pyqki7el63bovnvxcsjkk@nbxijrujm2vz>
References: <20250724080304.3572457-1-damon.ding@rock-chips.com>
 <20250724080304.3572457-10-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724080304.3572457-10-damon.ding@rock-chips.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI2MDEwNCBTYWx0ZWRfX3oq0ekKC6xNf
 FzV9c1XBvgKjkB8Usd6XiBX2jgo4pBZB3PkdWeKSw0A2/yhFLGSybtXqBqNfUSDr37vHyXubz3L
 DMBeVUiaFpQHwWrXm3MwYd9YknekPomN0AlPL/RIAfGIhmrOOBm+nl4T/+aKkdAt2fuuj8s3m8N
 Aa7n+9fdUakrftRp3U4ss1oxyoZ3vrGhsDVK4XvcsXI3PDMsNjEGR339UJ5WMfAOfeucaoKpC3t
 COGCzcfXzvxfGJLgBexuAyjtxeVnsHuMQpsQ6jOGozIvy1RbbwjX/O1zg+OTdLJ2Q1xah1C/4sI
 +6TSaptdh2l+dpg3+FDxZP4PPtID+iw3hDOHmX9gPTZ99M+x9ficG+GTbSzvzBt8VAHMNQBdTFI
 IkAczSJM3sZAxxCJnM+CpxJaM6x9pD9e3e+KDYW4jD4x0lluaj91t+CHDdLdLtiJwuThmgpf
X-Authority-Analysis: v=2.4 cv=TqLmhCXh c=1 sm=1 tr=0 ts=6884c420 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=s8YR1HE3AAAA:8 a=cGmNtDV8R6BPqPJYracA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-ORIG-GUID: h12_-VJ8m2XteMLStVSAtXrqxmSVtfjr
X-Proofpoint-GUID: h12_-VJ8m2XteMLStVSAtXrqxmSVtfjr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-26_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 mlxlogscore=997 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507260104

On Thu, Jul 24, 2025 at 04:02:59PM +0800, Damon Ding wrote:
> Since the panel/bridge should logically be positioned behind the
> Analogix bridge in the display pipeline, it makes sense to handle
> the panel/bridge parsing on the Analogix side.
> 
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> ---
>  .../drm/bridge/analogix/analogix_dp_core.c    | 48 +++++++++++++++++++
>  include/drm/bridge/analogix_dp.h              |  2 +
>  2 files changed, 50 insertions(+)
> 
> +int analogix_dp_find_panel_or_bridge(struct analogix_dp_device *dp)

Nit: the API does more than just finding the panel or bridge. Also the
drivers use it in a more of 'analogix_dp_finish_probe()' manner.

> 

-- 
With best wishes
Dmitry

