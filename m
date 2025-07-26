Return-Path: <linux-kernel+bounces-746538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CC2B127E2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 02:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE02E7A7ADD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F71363CF;
	Sat, 26 Jul 2025 00:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c/Pg0FhZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7123FE7
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 00:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753488868; cv=none; b=ECxoHAmBtljJAki6fljFOoA8YCfa8pK1t5zA037Ej15G/GA+4Z5WcaNZ2o9rnfWJs5Ogyc8jqHDaAs6naFTfXob8MT5OZUf9+SJQuvgl2m7z6ER8S/A+/87kvC4XrdfOecnJkd2YBEPcEhtg03zRJTas6a66+c0Sy4U/bbuOK2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753488868; c=relaxed/simple;
	bh=pfyxo2L9fxXdUPIRR7R634kUEqbtFvfEmbWXEz0aSYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fu/MTSzaNm4EqlmrsQ63GgCzK/6xjovvjHn8D/Yz+BROPowABcEF++ML/cYoOw+xr7mQopACmyde0vBypZH3xgDCMTPjpNqgzxhaIwfm5brY2t6XCrOFdMXyHX/iGD+63sKXkb7kFCdalzT5yrj1E8RT8CrtB7Edt9XDwcg/xHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c/Pg0FhZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56Q0A82K011953
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 00:14:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fVtEWHvXvUc+qGfFc/Ohqisr
	YtRe8clpA4PwpwpT79k=; b=c/Pg0FhZcPNLb4l+6MQw3GZodRoQJwCs+p0WPYs3
	E4EDW7a2S8tEI6QbhZK2/bP1jkrWrqQVZlxftkJ4GMKATN5tvnYAwM6GoWuhNcnz
	Pe2cjgsabm/NCyhtILNPbSqnlsBkRvUD172jyVcdFOyQw91a5gDmbjYlRbeDzQiK
	ZjunzAkUPbf3NVUlvbRY99+pn5IhRbCaAw6whsDUMAfsiM7nIT5hQ6VgC49Lw2fv
	vP7Tn7l5As55LNfW7T60MNTesDn7ByXWuSvES6zKUW+z4o+7mlEn9H+uQwEc52sG
	POS7p3tykbzveuFwypm8whHqLvxkRMAQIypWApAT34JXUg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484m7wg077-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 00:14:26 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7073140087aso578526d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 17:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753488865; x=1754093665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVtEWHvXvUc+qGfFc/OhqisrYtRe8clpA4PwpwpT79k=;
        b=j5g0JvtDPcKxJePeJoibVceUrKNFBSeVE/dvE9tOY4y7mi3IpjMf5MFOPippzKnPwc
         1wRpQHBjvEjOBHQu4gM6XF8jOq2Snc9faPHTZPM5+L63zZO/dpvjzyWH+888GpwncNRM
         HkCblVW5wsBDj/hlJ0RgOyiNPIJIzYw9vEXKHE6KCKVIpJ2HWK969INoTWwqlDLLmqD3
         0Pb2WMx/OwCVyuSuCe2rBMKtjU8wg30G+67pOp/6MqkR84/quU0oSFhBccDJqYh9Y7dD
         XY5Oj2uZHVNCVgJRpMFfF4cxeyi+sr5CSfGXf2mxHXwJfo9oTUq5R1tzIGukLKpbH65k
         Ousw==
X-Forwarded-Encrypted: i=1; AJvYcCXsFQ27sB/iK7x1hPVbMKwbwdM0C+OanBjO1Yhlnf7wDEIrpWxIRhZ+lwyJRLlyg1zhHh4U/pDTjGRXNmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeSwbTR/C5HvAMPywdCMVFHkNoqDngfygi61czJ3rlUmo3IHrX
	Od6AwoaBuZm+KKext3cNnSEkbyGFswR2RMOWs91HdgsCsuXsjw1DGfQW6r6kyZ0QoZfFHyNbqwZ
	ohc0GU2UBeYeSxeN5gkL18lfhf04QAjxpfdUIaveuIr2SAT1EPsm+f2xMAzPIm56OYf4=
X-Gm-Gg: ASbGncvt19MS9e+0gzVv/qAEP8Zw2SoNSe87F1WMX56xif/6XL6W7OqfDeCE/4fOVYK
	srHWfEEMAYvYwAqGT39BMqKFEvavi+meppz2uHvT7OUXm7Z8R8rYjuMIW0LsjdHWSdKk1JKJKD+
	9J6cG5pHqgBjAGyfiiKi76Xp4jfQ3V8mbbizKrg2A81TzCbOZh9sFd0pYw80/HpTvmkgtFGQboj
	Ejp4t25smfjJYDK0oPYftwundteKpEPGNt26ehjbhN9t5N/4znulwMiIBG93TLAXU9o7DaMxnhW
	KFmzgCghjdkvjigV/DTMvXHnsrlyYAaGJKu/zt825RaRPteNcia24oO8sAO7xZLS1xf5ZQ3+tDj
	Gc7RRt05Y7VbHAPQUfwofCnJUzEIA3uwtaAI5fLKlSRY2qgTd2FnA
X-Received: by 2002:a05:6214:519a:b0:702:afa1:b2d2 with SMTP id 6a1803df08f44-70720519109mr48479076d6.4.1753488864850;
        Fri, 25 Jul 2025 17:14:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8LMLBA6RRSlqAfWuEkNfbGOnD0mlhKsga/BysfgtQevo2p5uY8FU1lkB1NoIIU1STSJSTJw==
X-Received: by 2002:a05:6214:519a:b0:702:afa1:b2d2 with SMTP id 6a1803df08f44-70720519109mr48478786d6.4.1753488864339;
        Fri, 25 Jul 2025 17:14:24 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b63391f37sm190687e87.170.2025.07.25.17.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 17:14:23 -0700 (PDT)
Date: Sat, 26 Jul 2025 03:14:21 +0300
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
Subject: Re: [PATCH v3 07/14] drm/bridge: analogix_dp: Remove redundant
 &analogix_dp_plat_data.skip_connector
Message-ID: <b7szam2wjxhbwnz2bpnejyppek5ag6vxibw7wmlwzdajc46dnv@xh5lc5bymg3d>
References: <20250724080304.3572457-1-damon.ding@rock-chips.com>
 <20250724080304.3572457-8-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724080304.3572457-8-damon.ding@rock-chips.com>
X-Proofpoint-ORIG-GUID: 52fv0Km6avQZsoi8zG_Fv597xYHW3VQn
X-Proofpoint-GUID: 52fv0Km6avQZsoi8zG_Fv597xYHW3VQn
X-Authority-Analysis: v=2.4 cv=F4tXdrhN c=1 sm=1 tr=0 ts=68841de2 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=s8YR1HE3AAAA:8 a=EUspDBNiAAAA:8 a=r8lg0YXQRZsV-nIv6pAA:9
 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDIwOCBTYWx0ZWRfX2NusG5DJY6FR
 Bk8QDl+JxayUr/vOoPvpVA6oBL2rQwUwNxkYE7DVM+FP1XmVnhubp+dHzpopv5ur+8CUSKk1fBV
 AUOcQ2r1zu7BLlF6pQ0zLmC9+ZNM4KJl1FwAbkFPJjQ6IGSW5+gW+7kSklTeL8nMTZoDcvhusLb
 opeFRlUDHRSKiQQgd5MiWf9E9QbraFhDbhM8Wp2md0aoGfctTkpAAGSPzODl9pngxxrQV/rogKo
 dd/ZY9jXsovgsUvpBUIWadCDn4eUzen1Jkwp2QdwBGZ3eyh2I2AqpNkJVB7ODI8H2P9o3V69yx2
 UEhWNHbw1nvrLJlNgPJhLha+eE/9fEydEHNjvz+Gs88G2Pl+noHCE/H40hduHEM+3/UNhHdW2XE
 FQkUOx/i0/IXvjVIfJaznX8gf3RxCWR1MDjLcQEAg/elx+k82BQnfvYoJH/KUSWCn45x4dGi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_07,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250208

On Thu, Jul 24, 2025 at 04:02:57PM +0800, Damon Ding wrote:
> The &analogix_dp_plat_data.skip_connector related check can be replaced
> by &analogix_dp_plat_data.bridge.
> 
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> 
> ------
> 
> Changes in v3:
> - Squash the Exynos side commit and the Analogix side commit together.
> ---
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 2 +-
>  drivers/gpu/drm/exynos/exynos_dp.c                 | 1 -
>  include/drm/bridge/analogix_dp.h                   | 1 -
>  3 files changed, 1 insertion(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

