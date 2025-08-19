Return-Path: <linux-kernel+bounces-776340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 001E7B2CC28
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A2C3B05CB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCD230C345;
	Tue, 19 Aug 2025 18:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b6VzpCZf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776C630DECD
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755628565; cv=none; b=fSEXeHsz2pRNKoOUUVIrdL/HbiMAY1G6NH59Ai0b6KvVq5wFx/sxH4aiaBzXqddlNsQNJwqB4qhdhRRX+9kebJgAzDs08HevUWZWDKKoS+pz/pQEqC88TSLV+gTGv9069T9ZkzItmYsx3y/LtB1kWTEBWbCiawMLW+uDvOcm2Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755628565; c=relaxed/simple;
	bh=sTgf/CNCkxGhEaAwMV5unINPuICI+staVH3F5LIk2ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVVk94ce+SKY/BWmp2/Bnmydk5bI9f8bC7MIoqg71jhZELDLX6vqm+HAbCkHl6Zj+euV5I3qoFtglMO00MNw3KViCcIRawmCRKK6eIn0yvXJQ7gMm9wYsn4ErU4fBw8pzkXpGRC84JlfvbTtLx+WfOKBWR0lx3RkMCifN7VryH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b6VzpCZf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JH8V6W023948
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:36:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=o240rpXb1npe1ccsIe0LIiBv
	/L8C+NSjEqGnuz2YrN8=; b=b6VzpCZf/0uYO01WP/f9h+p02aXCBYd+sRRaZtT3
	C7YQEOhHbR0zykWWrlqAOKk0UZ4UbaP0XQIUDgxf1D5g8MCP7QK0qtrgxldGqMFc
	VT5Ywg8FHXTLEvcsUh4+jUYU5+B1rETKver+48vO3KuLqZbEmcJDS5ftHSC4GgPZ
	bKCIhEOGiIcoYt7E2iEJ58RUkMgrdNGaIDNQXkYTIJxoKQrOsKSelhz3dAvxLESm
	gBW/3n2e5NfC+95lKeMb+yQ+Me+E3909Mb5cOMnPCttWMOOVizhYdmCCZF/B2dv/
	4SQ4SJ/lvBrO1wSsfMj9Pz6tKssgpOPPIj2ejj63nnPk0Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48mca5kb7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:36:00 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70a928dc378so133962406d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:36:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755628559; x=1756233359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o240rpXb1npe1ccsIe0LIiBv/L8C+NSjEqGnuz2YrN8=;
        b=TawX/QEuXb5Y4BwwwNvlPVdvXz8W60+fQGQyojcVDfamyap9ZM9c/7fEgIpjR9gPja
         Bo4rgRJgFiRI1eFs0uvFbNXCRUBS4LCbGUKQ4ReN/bQqqeotTBxjaPbtphZ3lQ1I6wCT
         LQlJodnEbBVIQdqUDpfbChXYjbPQa+3U/QBg4sQ7qa2riiYFVpM98HJZpo0J2gLixjRr
         lVsEl5/ANes9MH0tBMJDWPCzJhsNimkMoijD+YeVRaNQF3w1EwxlhnlI4FUb1CWfG6ag
         0/RJOv4XBWk3HSwDAjTV8szBnCLHx9ht231zhWbN/rfRy1bZmjzncRKQD8mXBvAH7dRx
         Qddg==
X-Forwarded-Encrypted: i=1; AJvYcCUTTHSi2SConFsf9ai3SCOn5s1S9wvGesyXHONvKKXGAOpInVwIafIhehMxwgpwm4Cc/wJ7qzdK2JTco5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsdvGa2aipNadOWjlOYFdxsdaUjPfGTllg47cFhgH2DfkGqSMW
	5B5Z67TjjJEpSY+WJ/oSZmeUc948fopbyutJtFCLvBb7EuLq9dhGY6u9TOZWTjiRo4ebFqqMVHw
	RFQz4NiNinFoUROq006NBEwYwuv94oudUl9Ps6OeK9AOZzMJdzGm05Z3k3iACkQ2C1N4=
X-Gm-Gg: ASbGncuP5+w1DGLDlzD9V4cWxcIgdv8M+QBpXoFYxHebpaISbB6GXF9uIU050F3q2QS
	wVrgzzSeMiUE0baTGfdgzez2Ghd1bt57ek52l9Vu2YHBntprkPVfiDxHzdf7bHomQknt9HLLt2l
	IzpM8RXDp9VIbUvpZFQEZwagFxvN9UtVPzJzzFJOBfzXkNKj5T4exxQvupqVlK8mMSrAbCghvfI
	o0EyujcVKsk1efPGkwJ4kMHYL7Ir9GsYQvlpk8BiplN6V+hp8hTMCVtOcq2U8jpx9sBwpQoYJb6
	R4vLMarV5h2Tm6EKCywoaw6d2+iwWhfTuTzBcqhnbp/9N6oZt+T5ON0sPQDelyIOUPObKtNvUSG
	9Q+ddyR7dUZTy2IQ64S52xqfVIO36YanF77OlEfVVc/2iuLD6gwTJ
X-Received: by 2002:ad4:5cad:0:b0:709:e1d5:2470 with SMTP id 6a1803df08f44-70d76fd26bamr413936d6.20.1755628559296;
        Tue, 19 Aug 2025 11:35:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGmlAw5ivpCYe8dKVhVWxeKp6uuPutspQzTTRywH6aArEi8XXmLCe1KM8UMGq0ZEI0zbNZ8Q==
X-Received: by 2002:ad4:5cad:0:b0:709:e1d5:2470 with SMTP id 6a1803df08f44-70d76fd26bamr413576d6.20.1755628558770;
        Tue, 19 Aug 2025 11:35:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3516bcsm2227934e87.24.2025.08.19.11.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 11:35:57 -0700 (PDT)
Date: Tue, 19 Aug 2025 21:35:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Glymur SoC
Message-ID: <phbil4fflttlcp7s4nxyceyb2a277eablveozggloufowwzplu@c4a2mrtnfunf>
References: <20250814-glymur-icc-v2-0-596cca6b6015@oss.qualcomm.com>
 <20250814-glymur-icc-v2-1-596cca6b6015@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814-glymur-icc-v2-1-596cca6b6015@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=FdU3xI+6 c=1 sm=1 tr=0 ts=68a4c410 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=pDoijQcVg5aKu1OD8A4A:9
 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: mALVSArIHyy6Aposg3v639hhQg2S6OU-
X-Proofpoint-GUID: mALVSArIHyy6Aposg3v639hhQg2S6OU-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDIwMiBTYWx0ZWRfX7g1RH5yzAB7/
 oDYB3j7sr9wRluAjoUntgQEUyyoqdnYmzMOb+ljMLBbBciShfGto1oErrma9yBZ/NcdeTILFPrq
 ez09AcEZxNbQZXJN9gERdE9UB84We8qCyEBbXGxpL3oy3H4OcDJjIsk4Sdqy+8O+70jkGklRjOs
 yO6D0RR1rLYRY4l8R60DxsDSGNeYj8J1cHLpy4ZrolhsUV0TbDabzPuOLBF57AgVCuRhVcmG8+P
 R8oFEqgfw5H0XPnxTMABOrooH76WhAn2r14EW+qo2caFFLq7ojufPPhbcFVFfvPPGWEKfK6TZLy
 RbzVV7CcdDiAwy+79LvFrPtsKTKZHq5+kj9G7d7jTSrL8wQzaBtgmm+dJNPS4cVqUbU9FsR6sOd
 zv4hrAEE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508180202

On Thu, Aug 14, 2025 at 02:54:19PM +0000, Raviteja Laggyshetty wrote:
> Document the RPMh Network-On-Chip Interconnect in Glymur platform.
> 
> Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> ---
>  .../bindings/interconnect/qcom,glymur-rpmh.yaml    | 172 +++++++++++++++++
>  .../dt-bindings/interconnect/qcom,glymur-rpmh.h    | 205 +++++++++++++++++++++
>  2 files changed, 377 insertions(+)

> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,glymur-gcc.h>

Please drop this header and use ephemeral clocks in the devices below.
We don't need to point out particular GCC clocks, using
<&gcc_foo_bar_baz> is more than enough.

> +    clk_virt: interconnect-0 {
> +      compatible = "qcom,glymur-clk-virt";
> +      #interconnect-cells = <2>;
> +      qcom,bcm-voters = <&apps_bcm_voter>;
> +    };
> +
> +    aggre1_noc: interconnect@16e0000 {
> +      compatible = "qcom,glymur-aggre1-noc";
> +      reg = <0x016e0000 0x14400>;
> +      #interconnect-cells = <2>;
> +      qcom,bcm-voters = <&apps_bcm_voter>;
> +    };
> +
> +    aggre4_noc: interconnect@1740000 {
> +      compatible = "qcom,glymur-aggre4-noc";
> +      reg = <0x01740000 0x14400>;
> +      #interconnect-cells = <2>;
> +      qcom,bcm-voters = <&apps_bcm_voter>;
> +      clocks = <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
> +               <&gcc GCC_AGGRE_USB3_SEC_AXI_CLK>,
> +               <&gcc GCC_AGGRE_USB4_0_AXI_CLK>,
> +               <&gcc GCC_AGGRE_USB4_1_AXI_CLK>;
> +    };

-- 
With best wishes
Dmitry

