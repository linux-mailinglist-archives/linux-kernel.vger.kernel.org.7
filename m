Return-Path: <linux-kernel+bounces-819117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B0FB59BC5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CFB31888AA6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8324D3191B9;
	Tue, 16 Sep 2025 15:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d3oPnFiD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D25D30DD31
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758035452; cv=none; b=ZwehU6HxyYy4c5F2Yb2GgBpVjziIFFai2thpprdeIkJKwNNc5H+YykYYw3ruEOrC87iDCGSzMWDg5I1JFSNbZxTpDpybUb/vfKsajc+qDVds/PgmE1B/O/S8LA7JBjVKJ3Inu8QH+Edj+nI4KGjBmr0i5lKky3PQHbPPMzd8EJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758035452; c=relaxed/simple;
	bh=EQkMGw7chdf4s/ipZleWGh73O0Ryq0/JBuSJdDHibm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhL1dtPJSr7WCPXL+5bAeKV1k7gl/LEwgUaXKBEZIWC6OE2U3D2MAdYhPp5vfKtfqldPuSuXDF5mBGf2Y8PjYcwYw/G3Mb9RsAP6rUj5Yr/uQFbE42v/08HHGN867Pps7cdGR7XYQ4lmz636QbNwWPQjo4BXdxptySqeQNUNEFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d3oPnFiD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G9vlqo020041
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:10:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=g1Z+oPGXQpLxnAZpBbOZ/u5c
	mt3wM5YUAcTV6PLokuA=; b=d3oPnFiDYbzgsQw8vdiCpR76ns9JcYMBKPVaX3jd
	gApfGla58qI5RqlUdRsrwP7l4h38RQrOVWEJBaA7Bjpw152xxSpJgj6FM4j/pAdW
	E0rO56RTTKFDdrN4AJMSCnu3d6XIFwbmp0drBaztN2DdcT02u7WDNv0uGcySfcBV
	C45I9SLbYWWwgJornlsCEjUPpLm4PuJCUHjWE4cn3sIfqehMouKdlJz+68Q5G+M4
	UeZ1GIOQYwZjTl8ojT7PumN5QELIeu0C55hbDAbR5tKe+AHUkkCIJrYjy0kdXXDe
	Q2OlISo6BuWzYQ9jrBBNohaTST6pNEEygFxBgv/5BASWjA==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496h1smu46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:10:49 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-54a2e947bdbso989170e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758035449; x=1758640249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1Z+oPGXQpLxnAZpBbOZ/u5cmt3wM5YUAcTV6PLokuA=;
        b=enkigru2IO9Im6rkQr7RrRA5Zyj/MJEsT34Ij3R1mb1zehP8903igAqZmvYiv/C2c8
         xhn+EscyZtnvXMyKKby/Gs0tM/u7fr3m2ldgqRdGgg7V5ocIEDDawNfD1bZFmyImz953
         lhLFGSUnSSSEIYluYWhOUrlT63uJib3/r1e+rPkkH1hOuBX+g7MIuAg95sPs1spTn0Cj
         5NRJ6uYiDWX6mHI4xq/agxurtN+JqpFPek1qhpL8Kx0E/+jtx/gmnROppxRMDVKHhaic
         jUzRkGhwfUo8PIG4WjlbJXEKC9Y+zQjczlN56CWqCBLWK+YE34NsZUYdbst+oa7/62ch
         JRig==
X-Forwarded-Encrypted: i=1; AJvYcCUYlc8pQSTyXSOzC/WoYag/YySAtqD5oXgiL/mJUenmCoOCc3+6/CIyU1+qHROv6iO5IOzoD2Ohfb0rJoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUIM9DaQiJKyekXWlX5rsIRCJOcIkFk1t3rfdYFNKzG8HrqjFf
	JU8uFQjKIsH1Jez2KZkwqWL4oRU2Gay3CzHFTOO2T82THXNjGuwZerr4ofDESWTIy96j4kQS5JO
	ZKJ+hwgBOUJ9owJ9gB7CCgZENxVTldBrEi6KXfs5Nj+OAqb8UorX3JBZQpUxqzv0xHUg=
X-Gm-Gg: ASbGncu22gpf4DTenz+6J7ZX7UOWS70jO09dvERdLM8pFxPRXA6sLUiexSI89sYF6za
	oRkxwh7/xUAizeq7KSUZvdrIL8W439dGY3AXbBDny1QJUaeBrKa1iM1HjY/kfuYR0KrGJSe7JHp
	Oe1BR24O2252lHKZlfemhLDWbS5ZhFYcfTTBX8gnPkfy3hrtC+FDq1aNS0qCM7DztasVPDEvufS
	Abghw73UFAqOpN1dyFOBnu0OdWiSYzC8k/WJX/d8c5S6hle1Q7Qj3gIqtqEkuWYPNTFhSFcCqk5
	mrBUbpKBzsRCtGcOn3xTqQWpbO/qHH5tMELfEZy1WXKwRlWhNPLRxlnXmjCP8SwmHLm919PozLM
	doOSsG2sATVcS/ZVr0UpWtKlIOf8gfVTUxcLLjaaQMXxiJS06kWCk
X-Received: by 2002:a05:6122:8c1e:b0:545:f023:ac1d with SMTP id 71dfb90a1353d-54a1699578cmr4957844e0c.0.1758035449047;
        Tue, 16 Sep 2025 08:10:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOjBcIPt0evZtEawDOU4ceL65KWW429XS23INAGRqTzAWor5/oJYp5i4nvKOrZ/npWDeBcWA==
X-Received: by 2002:a05:6122:8c1e:b0:545:f023:ac1d with SMTP id 71dfb90a1353d-54a1699578cmr4957779e0c.0.1758035448483;
        Tue, 16 Sep 2025 08:10:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-35e8957bc07sm411231fa.18.2025.09.16.08.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:10:47 -0700 (PDT)
Date: Tue, 16 Sep 2025 18:10:45 +0300
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
        Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com
Subject: Re: [PATCH v3] dt-bindings: display/msm: dp-controller: Add SM6150
Message-ID: <av6zvj7civjycnj7vsdfufdlnpcq4mlpz5cwpamtapzkdqoe6h@rqfea46xs2r6>
References: <20250916-add-dp-controller-support-for-sm6150-v3-1-dd60ebbd101e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-add-dp-controller-support-for-sm6150-v3-1-dd60ebbd101e@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: NQQJ6J0w6k2gb-o5v6uHCOVnNuulOb_8
X-Authority-Analysis: v=2.4 cv=A/1sP7WG c=1 sm=1 tr=0 ts=68c97df9 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=kjV3pKRppw1HhCH-an0A:9
 a=CjuIK1q_8ugA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-GUID: NQQJ6J0w6k2gb-o5v6uHCOVnNuulOb_8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA5OCBTYWx0ZWRfX6ldeus4GzTL2
 ZE37A/l4gaEr0xIt792o40EREmumnydaIG0BW5XvZq9M9uEPUSjI1jUw+DxXLH8cl3MAN+Bgztv
 U4mEAnqoaW3rtXtu3ta7tyBPiVFQpSFnKjN/Pz5GijIlIa1iFYmXQFEZSG46ubjsd6tiKQ85xXK
 +fs68uPtN+y92XIdxJh0iYHGi/QLHnjZBs9R8VaGRJIhdj4byL6t5pLutYdzssNRGTH/SOydwww
 GFgijJnmctt8zAXAXM/SxVdkMYCwWOonR0rshSasrqr0PLerzD0JjgNG8UMld5Ty13iYxIiQG/s
 A6xmlj2A1+uVP6S66O1yoop/0h2G8Urr/pedk42ycUQWksJW1pQ5RbTMmznwcr/SjK2H136FYwa
 QuJONGjw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150098

On Tue, Sep 16, 2025 at 08:11:03PM +0800, Xiangxu Yin wrote:
> Add DisplayPort controller binding for Qualcomm SM6150 SoC.
> SM6150 uses the same controller IP as SM8150.
> Declare 'qcom,sm6150-dp' as a fallback compatible to
> 'qcom,sm8150-dp' and 'qcom,sm8350-dp' for consistency with existing
> bindings and to ensure correct matching and future clarity.
> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
> This series splits the SM6150 dp-controller definition from the
> '[v3] Add DisplayPort support for QCS615 platform' series and rebases
> 'dt-bindings: msm/dp: Add support for 4 pixel streams'.
> 
> The devicetree modification for DisplayPort on SM6150 will be provided
> in a future patch.
> ---
> Changes in v3:
> - Update binding fallback chain to "qcom,sm6150-dp", "qcom,sm8150-dp", "qcom,sm8350-dp". [Dmitry]
> - Link to v2: https://lore.kernel.org/r/20250916-add-dp-controller-support-for-sm6150-v2-1-e466da9bb77d@oss.qualcomm.com
> 
> Changes in v2:
> - Update commit message and binding with fallback configuration. [Dmitry]
> - Drop driver patch since SM6150 is declared as a fallback to 'qcom-sm8350-dp'.
> - Link to v1: https://lore.kernel.org/r/20250912-add-dp-controller-support-for-sm6150-v1-0-02b34b7b719d@oss.qualcomm.com
> ---
>  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

LGTM

-- 
With best wishes
Dmitry

