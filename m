Return-Path: <linux-kernel+bounces-781630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64722B314DA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3903C3AC9D9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24F52C028E;
	Fri, 22 Aug 2025 10:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aRLhTNmw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8181822DF9E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857359; cv=none; b=COixnF252wHXT7z8EtZmYGObwyLiFhEUHb6roGmeH0eN3/Jd8+K+5iP8/tFf3fhXb0lslQLDcqdhT76uDnQept1ZpIhk8Wy3Pj+fatghbLB4it4/pDSF3GQUeLpgXYlCGmmoDengaydybr3T28SIXDagJ/n00rQDJCcTToxS80s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857359; c=relaxed/simple;
	bh=1+cEJqEPnMhs0VGIKCr+QdXiw1/UgnnBPrisveWge2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGGuUjFyOxfpyNKW5Jw7X4Fd3w3jaJ0VpMjxhquOG5z4SabE9TNQxuNsnDBoijNw6pA5CdhhMOSI0tjzi/AZwZz8jRt9q2c+ZXUwmlHAv6syU4euVY1e+lyQ94UlDOIeQaca+F5jhKOClcIy4pzaYYzBVd7pcdUg0REIzd10IFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aRLhTNmw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UH0J005806
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:09:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/CUwk5QH1ZSt+M+5NuLxUaiWmoXIPaE8loSJYuZG5tk=; b=aRLhTNmwMlgE6JQe
	tWwNf2M2oC4oojXabs2KKGwrhhStri5fyzPV+aU3lhp7Jbi3ypNE+l6O+n77w+Tp
	2+SNiqs/0+tfPliih6suw9tHpp0ffs+9zMvXNPDnj13DW/s9SKKdCdxxzOJF/6Cd
	2+pirkH5OE53jNtRqWAYvIT1QB/WQS/5kyUqK+EvwumVYk4v3hTDqjc62miMMSj0
	4B14/XgwMenyqdYSqstlznouGEBuD2xxAJJ9JnOfdMzbsleFWKK2Nn9Ue5BS1F8s
	y7j3e5mNRCzD09dwMDo+M9AcSE5/u8Ow4n4rCDWtFLgLegNNY5i3RDJyrHH0ucW+
	tyuQBg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5290tfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:09:16 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70d903d04dbso29933976d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755857356; x=1756462156;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/CUwk5QH1ZSt+M+5NuLxUaiWmoXIPaE8loSJYuZG5tk=;
        b=lyhNl8j2iGY2nZLNds5+uA23scdRVAz63oKv7BnaoGx6GC27ER6MRAYcBF2J2iyDGU
         3bPKEnj3SFAppcOLQoQLOjOPn+PsvmmkYf5aTxOJBFRWr4DNBbnEDaKffdSkPIUk+ReZ
         xmKNtsYCiPAaumPgvQe+t6xbtQs7oOHu89oJ0afPYTJ2Ojf419MbNxHS7ulxXfQt55NE
         jCbPkODjyv5JhE+Nh26T2v9YdKgrxo/z842eZ3LSpWuaLRsDhzHaEetHC13GUQ5zTnIF
         /Q5wRN1GChBzN19VZy5G9WT4rcaakERJVW80Rq8IJs8SM6wao9kJw4yto/ztsyWF+pA1
         8DJA==
X-Forwarded-Encrypted: i=1; AJvYcCV+2eMpq9YdYZK6GVbPw8tAGaiW3fQTR36JkrE4ja+4KeqsfSgMbSwxL4Lf0FOffXY2f+89CthWbWDbxjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqQ8MCDMbJvnq0D2wcPiDjYIRJRvIXFh5iVA8cKLvcupifmzii
	q3eM1A/CgqQcFO3qZufSyy6MO4b1NIIjjLYA6dOLhzdC3XSUA0xU1d9zKWkobZNd3SL8ZFXZhxF
	PaH4ST1ZHqLOmv0rZ5KjuVl3jxEoGsdLZf9iggoeIFHZQ58HxHDGDvv/9k94nxv9dkRE=
X-Gm-Gg: ASbGnctPZy5TNgNkfAgFK7RxbcBYew2iQyzoW/ckgaCyeOfO1R2n+irIYkGEdYVcI07
	pLAiH6M5LeU/P3YJmEu+Vi5hWgQkY8efNRLmvE0kJCikAjFoc42lgZOxr8Uwpdc4y0C/R4xHc+A
	0Ob1VVqqFJ4VTicMUJ1u0iRA5VCDC1XWHKJ3+VSdRV98i23SO2RDrF4OmF/2W1ysyp6j/ly5zJj
	nxzD4QlNiWeMlkv3EKQwYUDsKuqvEpHWA6LbV965Qcu3qedONjMI0CK82HtgfcpSka5UuhcVf0j
	teejvirshrRoi3A/mEiReE6rjKEncRszTMRWW8HSLgPPlNB8gVRywNhIiQATTh5NLuGESiIvdxi
	K3zj5lKgtOCwlx0J2DdkxsXUUSVpJf9wfkvlPhbX0aFSO82DIRkDi
X-Received: by 2002:ad4:4ee2:0:b0:709:d518:74fe with SMTP id 6a1803df08f44-70d972f905dmr28317876d6.38.1755857355607;
        Fri, 22 Aug 2025 03:09:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjLDedc3TEHaa5fOfhQL6JH2lzExRdfVuK/adJjjF/AbJ1wFTlhwvAYsjorze1ggX8bWHyRw==
X-Received: by 2002:ad4:4ee2:0:b0:709:d518:74fe with SMTP id 6a1803df08f44-70d972f905dmr28317336d6.38.1755857354860;
        Fri, 22 Aug 2025 03:09:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-33650ea5f6asm3013591fa.53.2025.08.22.03.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 03:09:13 -0700 (PDT)
Date: Fri, 22 Aug 2025 13:09:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, fange.zhang@oss.qualcomm.com,
        yongxing.mou@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v3 08/14] phy: qcom: qmp-usbc: Add DP PHY configuration
 support for QCS615
Message-ID: <tdmjo5et4ohwg3g5z7wr4dhvvlqbd4z6nfo2hbzpyo77e6okdp@z5f7hlvyovx6>
References: <20250820-add-displayport-support-for-qcs615-platform-v3-0-a43bd25ec39c@oss.qualcomm.com>
 <20250820-add-displayport-support-for-qcs615-platform-v3-8-a43bd25ec39c@oss.qualcomm.com>
 <su3zkeepxaislh6q5ftqxp6uxsyg7usxmc5hkafw7yn2mgtqeu@wua72odmy7zp>
 <2e3c1559-7da2-4c6e-bcef-eb1e8dfd4c31@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e3c1559-7da2-4c6e-bcef-eb1e8dfd4c31@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=fpOFpF4f c=1 sm=1 tr=0 ts=68a841cc cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=VDbBU9HbQ_CCQpQHtSwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: CjL-ugYtn5a8SrAcj_9YOSHJ0yol4Bw0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXxh//avDDLFC3
 AjYLDoJbFQ27vi+xIyiPKeos0hFpjHzwJBaUQ8UHOxNWcLGG5SHXN8jVJCySRafkcU+B7vrkDwY
 LGDvXcm+uDpNzlTCl10et0GPZdoNGUma/4Z0KdE6P9mmfNLnuW08LYgjs/acZ/e+ru1glUTI3qM
 mQT0L5SJYDgl8ziCpa4CFazOR8EOeHZwy5Kfa2nkaKA2sLF+Ie9snZoWql6zikxzH3Jp53x/UNr
 9JkjVcR0AqNE1OPzIlewrcXWQk0dVsMll/HoJexvfxhqkDIcZ2RnK8UeUaQ0d+YKHV7jwj9/PLw
 p9nMRuXmjb9f7UR+lv82ssVQlrzLreTrvMjudU3gBJzRf82984aTW/lkvutnot+hQ2FNStq0MzC
 zxYNQpRDenavfGnTqJawxGnusWR/Og==
X-Proofpoint-ORIG-GUID: CjL-ugYtn5a8SrAcj_9YOSHJ0yol4Bw0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Fri, Aug 22, 2025 at 04:43:11PM +0800, Xiangxu Yin wrote:
> 
> On 8/20/2025 7:16 PM, Dmitry Baryshkov wrote:
> > On Wed, Aug 20, 2025 at 05:34:50PM +0800, Xiangxu Yin wrote:
> >> Introduce DisplayPort PHY configuration routines for QCS615, including
> >> aux channel setup, lane control, voltage swing tuning, clock
> >> programming and calibration. These callbacks are registered via
> >> qmp_phy_cfg to enable DP mode on USB/DP switchable Type-C PHYs.
> >>
> >> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> >> ---
> >>  drivers/phy/qualcomm/phy-qcom-qmp-dp-phy.h |   1 +
> >>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c   | 251 +++++++++++++++++++++++++++++
> >>  2 files changed, 252 insertions(+)
> >>
> >> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-dp-phy.h b/drivers/phy/qualcomm/phy-qcom-qmp-dp-phy.h
> >> index 0ebd405bcaf0cac8215550bfc9b226f30cc43a59..59885616405f878885d0837838a0bac1899fb69f 100644
> >> --- a/drivers/phy/qualcomm/phy-qcom-qmp-dp-phy.h
> >> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-dp-phy.h
> >> @@ -25,6 +25,7 @@
> >>  #define QSERDES_DP_PHY_AUX_CFG7				0x03c
> >>  #define QSERDES_DP_PHY_AUX_CFG8				0x040
> >>  #define QSERDES_DP_PHY_AUX_CFG9				0x044
> >> +#define QSERDES_DP_PHY_VCO_DIV				0x068
> > This register changes between PHY versions, so you can not declare it here.
> >
> > Otherwise LGTM.
> 
> 
> Ok.
> 
> This PHY appears to be QMP_DP_PHY_V2, but there's no dedicated header for it yet. 
> 
> I’ll create |phy-qcom-qmp-dp-phy-v2.h| next patch and define |VCO_DIV| and shared offsets with V3 will be redefined accordingly.

Nice! Thanks.

> 
> 
> >
> >>  
> >>  /* QSERDES COM_BIAS_EN_CLKBUFLR_EN bits */
> >>  # define QSERDES_V3_COM_BIAS_EN				0x0001

-- 
With best wishes
Dmitry

