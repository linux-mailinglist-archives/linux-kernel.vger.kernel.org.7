Return-Path: <linux-kernel+bounces-845464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EF5BC50CD
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E6F84041A8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22F2280334;
	Wed,  8 Oct 2025 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IIbl+IQD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F3225392D
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 12:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759928194; cv=none; b=fdE5JRXA7736aUJMUGgXX38Ek202tM0c1YTg7aNBEJ80J8QotRoAJR1GZHy/r2WERoDaisr/R+lBzfwO1vu5UP6z1vS0MrBMJa+KodetQeLaBg2XCWpuWQbxJVZukKve0OfZ1CVpRFlFtVjWUU845JyCcitkS1EUtcqXj+HHf14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759928194; c=relaxed/simple;
	bh=1VuEM3I+wo+gJRNNQsGhpeUty/mbEGcmXM06dhM39KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBFMUAcliHFuCAGruyBxSKX65qoCLK+1aCtX8i7Z3zYQFLzO2hVsrhfnrfLSrtTumZBpsjtobTu8w5PNaq7VpZpd3ho+D/BJaBO+eIBvITL2sEyHetMBPmVQaOeCRbv8y1h13qc64GRXDIfQ73HshkM1FL1ahA7rfN5hJSCJxhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IIbl+IQD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890aXZ026778
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 12:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hiCtiNo8qpPT2bD5wSeikfNE
	shBu8SbNM8ccn6WVAMg=; b=IIbl+IQDbyYec5n93I9xSrvDr9V6umKQqcMHSc13
	5a2OBGOWfCmrcUrGhIJSFxSCIbNzZnLOQEKbvvPVB1iCpYMHlvURQIiZJPob+/+M
	F1k0DIObpkfLrc3odcHe5u8UdXeQ62UV1Iz5wvAucXCvL/K/LVzWCD5phqquG/R5
	jN3WpE0VjMHZ342v6MsOGP/zHDtzWG1U0oEvnP4AP4zmFwQni37yxTItFsuBVfr1
	DzHbt1xUApCUM6N47IQgrhDn0GQLCEjvesQHcO5ESqe735MlaEgAnx3H0fXop64i
	K89bQJkDZhE90En1vVkrKsJKgL9Q11PkzNLKPuv86Yj0fw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49n89hjamf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 12:56:31 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4d905ce4749so154299591cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 05:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759928190; x=1760532990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiCtiNo8qpPT2bD5wSeikfNEshBu8SbNM8ccn6WVAMg=;
        b=JUwBcG5FdEhgKouc/FTh+ABhnAbvNvLfb+dp0vQdL4H/kgC66Cv485r7Nu+EkmhNm9
         gWoLIqhDdPEtA6fNBbqLTdoucQCbXgwd5dLZq/d1eFaz/FcfJUz/IfeiiPj+fVP7RwQW
         S+SXjosIa2qVizL2HsFFzmaV5DptZqjLJpGHi2xezcuP60v1pcLqJ1DtqVSMC9FWulFw
         jyyGD1yeolwWFpk36DqTs344YrSYZvWTtyg+xzM9y1LGVt0BRcJtxcY7lQ3sUJlW8QVR
         tkz3613HMeXZy+leLeP1dFJP3lVAZbGgR50rkMxZhfBRQsb8Uzt4cpjcvV/rsCvqn9MH
         y0iw==
X-Forwarded-Encrypted: i=1; AJvYcCUukbyrKl131ozYWzWhg1wJxX86fntEDVzqdwUMJ/CoW3V6qTQQtph4ARVRFzniyhDBLT3wo16k/HJ0yms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0YJ8nR5XD67R+Dr34tBeSKZOKpyoSEK5cutuuVQh8C5zHAqoz
	dGoBnjI6joXyZ07Z3XD+I47RQb5Q77unWEr6yuOwjGIwDU7P1IRXdpWCPw+g7knjTsJ5XPqM7h1
	nFQxGvggiIwGbdU2zb5c3jlnjKRabixPmwt5NGtMlG5G5C+vtFFeXz9IlYSGdHF3X2xU=
X-Gm-Gg: ASbGnculiTrLzNi8sjcuQ/uEIgYxWSY885sP9ZZQevOo4SPyKz/RlAyZDkItGSCzzkB
	7QYq+a92S29lZmVg8PRb2BrZSe8ealH4e8LcYrhD9rEsFrUMt2fnuZr6sGwM9IEi2PjS9+0PCnT
	CAc3hQDuH7IaeOOCwJyKHeWkl5hegdpGgrzgT6gcKgCkhPcnnDbX2yOeUm8mnNNfAeoxiUAUGXV
	2keijwzkXYqT4vc7nuizhCfGkp7LB+mkniKl6ROsNhNPR0FE2OAhCKMDbJJzOZDXQHKJkTDz4O4
	Q55Y0DERP1tG1fRyK66OwdLXYS6EXqWgl8mYYOzhxmgGR0IwkuP0L+O8o5YBZrvKV7b8InrHts1
	0pcCiljK044aMKRxHFX9iLayBBIpbF2uvWVoghNvRaYpCHN3FZ3HmhS4nnw==
X-Received: by 2002:a05:622a:1991:b0:4d0:fbd5:4cd5 with SMTP id d75a77b69052e-4e6eacb3cc6mr46909211cf.11.1759928190346;
        Wed, 08 Oct 2025 05:56:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhF0fqQEIszukwundy9NKl7UcbsMGK/tT9v7Zk57QUPhf5ki+jTRUeEtc46h45Talc6F2Zbw==
X-Received: by 2002:a05:622a:1991:b0:4d0:fbd5:4cd5 with SMTP id d75a77b69052e-4e6eacb3cc6mr46908921cf.11.1759928189856;
        Wed, 08 Oct 2025 05:56:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b011a7e5asm7195676e87.113.2025.10.08.05.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 05:56:28 -0700 (PDT)
Date: Wed, 8 Oct 2025 15:56:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/24] arm64: defconfig: Enable Glymur configs for boot
 to shell
Message-ID: <d3nyfefrqactlma56wt2kjmb2zj7tvul6hlphjtxcide5szshw@omnsdj7eqxrm>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-2-24b601bbecc0@oss.qualcomm.com>
 <wzhfv4v5urehjjlldsdznrnv244pdzpuolofalvj3cerscipch@7gkb5dvjwl4i>
 <d7125f03-ae6e-4907-a739-840b68593804@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7125f03-ae6e-4907-a739-840b68593804@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDE0NiBTYWx0ZWRfX72EpZl3n3DWc
 pcveuU7kocWjvY+7TbeQnxzcPzsVYvOEzrNz3AUzvflUB6yHe5wuq1mHbfXkxl1ziYEDyvf1gSo
 2UeA4/Y5XmwGDoI2Rw865GltDA3lg3QB+21zZtK0mPHEiMfEjWrg0PKWw/oK/jbJn13jQJvaBRm
 IY8meQ12JlpEpMeHREGFPA92BafaSv4y7yL+0kyryCPKaXfLRCtfxHpQBoQ0a9tgnYfZMSkvhtb
 lza1nuAlhXZXgKkV35NGIkI0q7Mi63RNjBx7lDr4O2VvycqDSLX50Nbzm7D/teINzPzUhFmsrQA
 jhLToqXTaXx+NLLAGhymSo4bQIwGfgdELPX2NjUo2CKL5aW03i9nESxzesuNbKeRQ8+kVsheztj
 JKmKknWvI/1geD1lJRUrZQEGJ0pcMg==
X-Proofpoint-ORIG-GUID: ureFQc7QWA5swCaYPOfr5Ybr32QN_YYN
X-Proofpoint-GUID: ureFQc7QWA5swCaYPOfr5Ybr32QN_YYN
X-Authority-Analysis: v=2.4 cv=cKbtc1eN c=1 sm=1 tr=0 ts=68e65f7f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=HAf9aL_hb54jzGR_yskA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510070146

On Wed, Oct 08, 2025 at 04:56:17PM +0530, Pankaj Patil wrote:
> On 9/25/2025 11:01 PM, Dmitry Baryshkov wrote:
> > On Thu, Sep 25, 2025 at 12:02:10PM +0530, Pankaj Patil wrote:
> >> The serial engine must be properly setup before kernel reaches
> >> "init",so UART driver and its dependencies needs to be built in.
> >> Enable its dependency clocks,interconnect and pinctrl as built-in
> >> to boot Glymur CRD board to UART console with full USB support.
> >>
> >> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> >> ---
> >>  arch/arm64/configs/defconfig | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> @@ -1641,6 +1645,7 @@ CONFIG_PHY_QCOM_QMP=m
> >>  CONFIG_PHY_QCOM_QUSB2=m
> >>  CONFIG_PHY_QCOM_EUSB2_REPEATER=m
> >>  CONFIG_PHY_QCOM_M31_USB=m
> >> +CONFIG_PHY_QCOM_M31_EUSB=m
> > Is this also a dependency for UART?
> 
> No, it's a dependency for USB, commit message mentions
> full USB support being enabled

Please rephrase the commit message to make it more obvious (yes, I
missed the USB part).

> 
> >>  CONFIG_PHY_QCOM_USB_HS=m
> >>  CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=m
> >>  CONFIG_PHY_QCOM_USB_HS_28NM=m
> >> @@ -1718,6 +1723,7 @@ CONFIG_INTERCONNECT_IMX8MN=m
> >>  CONFIG_INTERCONNECT_IMX8MQ=m
> >>  CONFIG_INTERCONNECT_IMX8MP=y
> >>  CONFIG_INTERCONNECT_QCOM=y
> >> +CONFIG_INTERCONNECT_QCOM_GLYMUR=y
> >>  CONFIG_INTERCONNECT_QCOM_MSM8916=m
> >>  CONFIG_INTERCONNECT_QCOM_MSM8996=y
> >>  CONFIG_INTERCONNECT_QCOM_OSM_L3=m
> >>
> >> -- 
> >> 2.34.1
> >>
> 

-- 
With best wishes
Dmitry

