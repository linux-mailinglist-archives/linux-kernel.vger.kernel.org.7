Return-Path: <linux-kernel+bounces-808396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4B6B4FF3E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A7E1647B7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A439931B82D;
	Tue,  9 Sep 2025 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YbFniPHI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75427231836
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757427787; cv=none; b=F0tJLNNkbD6vp+G+gLKct6BGyeVTcY93y5NeYLekulHbmO3PAsEWTdvzsppuretmB038ij9tCcCa+C+W5ucKayoQr6Ky2g6hi5/xiP9q5hg3cX9ESHWxGFjECrhjkUsTST7Qo6cO2d2ll/FjdKcwXO28YMqVvdekDIcwxULrKpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757427787; c=relaxed/simple;
	bh=mKWsNQPoATLy+KepXv37LhfBwPbT7GZrQkYC3ZjqgpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrVampUAFws3eYyWnbvNVSzB9ZprkV4rDGz3HTcFEp/5GAYIrQyVhtWp0krnglC50PaNmp6kO1hn0/A6+g13vuYd53L1SRhrKSC+Cgs7I7x8wtusC/elfIcjcpZdSHHMMiKuSbrn0RIMN8sZzYNSffI+1LLzNJcAJy4+h8ErSt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YbFniPHI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899M15I000993
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 14:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=h2X4u/C0hT0ZnsZtZ5WLCYHT
	XPjaXvBzP3cbcDi/Cho=; b=YbFniPHIo9davfYh/UqJaVAPE3OtZ3Tmf1oVQHjl
	8XHy2m84sdYjmVEqBiN+4A/chC1w40DaU3jMIxVZAjmpEfoUCX1xEAB6k1kLq7Qa
	R3eLZB8jCXjDcaoGWeWHY4imbBdWc6a+bXjX3LtiWsMZvdjOVIo0t4DfZrVGqg8Y
	SiWlU928L5tuqx+8zu7MA9kmOeRTZ86zSG/yZLz+hBsoAKKDeTeVgizt4XnIkqT8
	eabIomDAS8PW64huugCjt0r//isipB0vOvPQO6AzdZshMnD1OrT5X0qtfOTwWfwX
	IHu2D0qeD4f59RMScc+eY0UD2+9d2/Vwo5/W0oaGsyu/0Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e4m0ck9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 14:23:05 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70ddadde46bso117304396d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 07:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757427784; x=1758032584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2X4u/C0hT0ZnsZtZ5WLCYHTXPjaXvBzP3cbcDi/Cho=;
        b=JoHt4y/UtNRpiOotYTEJVwXu6gz4BhePeRisXPaSrNIKj9gcxl8WuxyJdn4UPtEBYu
         xU6PelQiEdWMYshYsOQ4zriBMxx1xGvw9FxHZF3YZFK9NA6jLxAh1pJ78n705SLMmW3A
         Teb5gSPebtmilKnRZcTbcGx0phpsCsKkobBnsxE/V/GTBIcwTBSXPsVvvYWUNGnSM1b8
         IEiBGgPWtpzVHz+XYBO7UwqahMIjT7RL+Wt8TQELwWgWyi6+MLgycKUDlctJj16ZPxST
         mK1vVlgjMrLbO4m7FkTbMiv/vnak08Xadx27MDb2Ai1KMl09gE1rH5T2sdDuSpKktnsc
         MMiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaFnsTFnnvsWSbf3MfLl/oInmP6t3RG9M1AveeEpyt3k5H0gcI6zHLQpWX3zZ0ssLccnncv/vrQygwps0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMufHZBcDAx74QhRLibocV+Rw5t+UhW/FI/ifKzAA74OUT9jUg
	xKihrM7Owm113QOtVb3d+E8jHNvwzI/YshzWVZftyJAodxI1FrihDIW9fM81WW/PyBUsAx/W5b9
	1ROhZyABXAZpH/uf+U4hJee5Iv7YITGm+SsUo8Kgq8kCTh39ODUmTHP8pMVUErD9ctxU=
X-Gm-Gg: ASbGncsnYGmMf4yXEGpNN+0lCPeCPqJFUP0UqedZBc4KXrxpO/SyGriSwaXXcU1xJLD
	NKeZYNb+m9L0xI9Tawv3z/nYFUYUwLxBVv4FMrgYw22hdyuBslrWflaqRLkJU3FNIyV3J5ztbar
	ntAtb8Z2XQjtFs14aUtB30RmcWAYjR58ILnjgJxXeOkEP186272V6fm/ki0xdEdbzfy1q9y8cRg
	Ww4aMGQ718LwOFZFWT6aML+iHHI2ETJNbfQUrY83HPFPf4tgZInybmtCll8m6S0C7YvLMooQAmZ
	80CPvBq6O3hhq8IkiNkUG1OCVjMICCGTjjFO2PVqKHdShkhYPiJGCIwX4/q8ClAs8El3oV9TPtL
	rj+5KOhB1tdMDU7KWQZplnqimsCP2jId7/Z3l5LBvAGt5ySMjFZ6o
X-Received: by 2002:a05:6214:f63:b0:70e:d82:703c with SMTP id 6a1803df08f44-73941de3724mr124936786d6.49.1757427783974;
        Tue, 09 Sep 2025 07:23:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+8if6eNbTpzHKsyNkm+8kJ+WHyQl9Ap4iWvgtn+1Z4Nqh0b/WPPZlhr5A1An/PL5BbFnfIA==
X-Received: by 2002:a05:6214:f63:b0:70e:d82:703c with SMTP id 6a1803df08f44-73941de3724mr124936256d6.49.1757427783207;
        Tue, 09 Sep 2025 07:23:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f4c934besm39228031fa.24.2025.09.09.07.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 07:23:01 -0700 (PDT)
Date: Tue, 9 Sep 2025 17:23:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] drm/msm/dsi/phy: Fix reading zero as PLL rates when
 unprepared
Message-ID: <xkzlobhynrw3ylelnzwh7u5chigtytizy6vyc7gp4un5du4lcb@nssqq3f5pv7s>
References: <20250908094950.72877-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908094950.72877-2-krzysztof.kozlowski@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOCBTYWx0ZWRfXysEZaibHcX5f
 bbntV7AFCZTd8Fcz+KIsyRxqYNygyIoNwbUSP2F9sTBPJ5JQ44nx0i1d/2TdK9CAgyTeIWQY2jW
 GKs8zolSincSSi91czyXAxeJqrDceMunZeH0buJo5y/QPs0AMozAuo4QE/EyoMEqBrDsdEz/auE
 r4SHYAVzXlhazO1jxbxot8kCaTolqVBLJMr9PL0ifBGcsQKGi+s2P8/EUlfajU9H2wqpMowVN57
 1DoEw6xH5+yQ7o39RxQ2ZMowymVf7UxM4MkSgPDPXQOvk8xpqIr5cW2JQtbq91J9NS91iinjuy2
 55Z/9dITnGtPld0gdolDX1+dNJPfFNtfYymnJOrpqc4uVvqTRumzsxD2JQjsJ+fXIokkh2HGcef
 Map6yXba
X-Authority-Analysis: v=2.4 cv=J66q7BnS c=1 sm=1 tr=0 ts=68c03849 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=p65op6kECmbMoyNqUPAA:9 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: UICnoQaywTHMqkzZFR-X9HCiKcnW_t-6
X-Proofpoint-ORIG-GUID: UICnoQaywTHMqkzZFR-X9HCiKcnW_t-6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060038

On Mon, Sep 08, 2025 at 11:49:51AM +0200, Krzysztof Kozlowski wrote:
> Hardware Programming Guide for DSI PHY says that PLL_SHUTDOWNB and
> DIGTOP_PWRDN_B have to be asserted for any PLL register access.
> Whenever dsi_pll_7nm_vco_recalc_rate() or dsi_pll_7nm_vco_set_rate()
> were called on unprepared PLL, driver read values of zero leading to all
> sort of further troubles, like failing to set pixel and byte clock
> rates.
> 
> Asserting the PLL shutdown bit is done by dsi_pll_enable_pll_bias() (and
> corresponding dsi_pll_disable_pll_bias()) which are called through the
> code, including from PLL .prepare() and .unprepare() callbacks.
> 
> The .set_rate() and .recalc_rate() can be called almost anytime from
> external users including times when PLL is or is not prepared, thus
> driver should not interfere with the prepare status.
> 
> Implement simple reference counting for the PLL bias, so
> set_rate/recalc_rate will not change the status of prepared PLL.
> 
> Issue of reading 0 in .recalc_rate() did not show up on existing
> devices, but only after re-ordering the code for SM8750.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Continuing changelog from "drm/msm: Add support for SM8750" where this
> was part of.
> 
> Changes in v7:
> - Rebase
> - I did not remove ndelay(250) as discussed with Dmitry, because:
>   1. Indeed the HPG does not mention any delay needed, unlike PHY 10 nm.
>   2. However downstream source code for PHY 3+4+5 nm has exactly these
>      delays. This could be copy-paste or could be intentional workaround
>      for some issue about which I have no clue. Timings are tricky and
>      I don't think I should be introducing changes without actually
>      knowing them.
> - Add Rb tags
> - Link to v6: https://lore.kernel.org/r/20250610-b4-sm8750-display-v6-0-ee633e3ddbff@linaro.org
> 
> Changes in v6:
> 1. Print error on pll bias enable/disable imbalance refcnt
> 
> Changes in v5:
> 1. New patch
> ---
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy.h     |  1 +
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c | 53 +++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

