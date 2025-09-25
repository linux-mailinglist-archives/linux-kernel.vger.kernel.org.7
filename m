Return-Path: <linux-kernel+bounces-833242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1493BBA17E4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 578775629CF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036AC2E6CBE;
	Thu, 25 Sep 2025 21:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cTFdw3tn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63FF32128D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835009; cv=none; b=E3h6sEkoO6Y7BkdB4IzzeSFQ89X8QRmHdj96YsvawOw6CSW5B9reX1ip2eYQiPTEP+3Uj7bmsPjJJs2dfm1I9WJvfGF0DjvFSVTt4IaGH+yA3NqJxTs9SvS1sBIY5iExsq4IJJCat/BDfSahxLp7oGSB+TnHo46PMqtgays+o/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835009; c=relaxed/simple;
	bh=RglpZ36kxS+z5qVy144dZ5rbhB8eMHcCR9GOuwDPVBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0TvobztcmG6v/smDL4nNAT8qIbnMa0SJf3andOBsP659cHMqJgdRMzi/JkefeuwJNDywGUhbAnYLjM+wQcyowLykIhYNosuCEu2j6rABBUJvcDwl+WA3B8uSdAnne+AEQDgCbfvMvZDhCESvOnG8mUVxtaEBJ5g29J709NNGkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cTFdw3tn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIPpnY025387
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=at38ec/t9CkX0+S+1EyG2jd6
	TX3Gl2UwrmZ9Ict3FUc=; b=cTFdw3tncju9PH/vdqLZIZXQrSnVtqlvO9+fDXbk
	8G1MjF6OOFZNwsYzcDzmmYjvZQNDNr95wFLkLYmFEWKztLtJukCFoUo6Dg5bsFdf
	zbzvdMFUb8YKCP2qsXHPj7WRgXJKs44XOqkFFAJ3ESc+rVOZsMquI8lNdOM+CVYl
	1GDtItPGQfNc4wVzR9FXssXO6L2/Dz5IipdpplscS5XM29jPaq0jPPlRfgvJvQ7j
	bTEP1gdy2s//1HtrvHlzxOMr+LeR8pUK6ZHwTANEGlAPzHWEsKLvQ+OWz7k+61O2
	WuB64iEewSNkgR0GTev7668k8F8Efqk3d5iZwfz73l3R7w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0u0ebx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:16:46 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4cce66e91e3so47168021cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758835006; x=1759439806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=at38ec/t9CkX0+S+1EyG2jd6TX3Gl2UwrmZ9Ict3FUc=;
        b=OuontQ7b0qqA5OckKzYtF6oTjtFYhUZSSrMXHRPU7OTqWrWMSNIdLkxvLm0AslnopT
         OONyGZpmroRu/c/mU0PeTeClac6cU2wnVR65Ou2oC0stUEjonUQfe2x/Q41N9WYwE3lY
         RCh4H2TE1Ky04gDweGzbP2azU6kZTJ8+MWHep1xJ6jCsSAUH56tRnoa6secYgo0HZKs9
         zB2RP0qeKJA+Bvh2bwO3DiMUeMWOSDDKAI3ow5TFoeiwbNTHEWbfzCvnS0JE3hiYL+mi
         fyt9U8C4gTaPT4RZe/M2OcJWHtKnzT0nlddVhr1Fi43ux45FhElVO++HtnAMqS7DJiNg
         kbfw==
X-Forwarded-Encrypted: i=1; AJvYcCWyySQeDQlOLmQmq8wlLDm3XRa61xwLS5TlMHKUWL2LgF9l/25OCvRGzA6fMopvI8/898h4qg+I04MhsTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWbBwef4PpuRG8ulbjXvfjOka30ye1FdSfy/aXZqJRf33i6qof
	pQW7ie5oFpOhgpFv41c6Kz3oyL3po35Clpgn+GFT30ZZKfNSIdJiWu4YYQ8zsU2y4SVxhdxuwai
	krEpq+UJ/I5j99PznT6azxaTuyp2+POhBWpUitwUBPQ6cqBiwkD+Q3pcJyxYDz15cxGM=
X-Gm-Gg: ASbGnctD1cjEAE9WVNj5QRx8rV+46w/ZewG88e+tKZ381CD0zHfLQ/+vXNGa8/Ft+rA
	AnFvovaTqedLbH3EK2m5h0e7GuwniscUCZJtmLiF2IedKAoyHRylQyOWS2rkiCo/IECBdQNxndl
	jzL4gIb2wm94E6f9NDFUpugOS29v5dd9on9J6wdRHDExzOB4OjFc/aUOgoWt+9t71KsiWvu2wLF
	CWHovOWtSYVKcEszAsuBYmZfnrQ8q5gGbRfCOOxmgMEPr/845XK+JoTaj5KRUBWwzmsP9yARi3H
	s5SwOX4jWAvaAM3uVBzxO0cWxs4YxaWqILjFlIKXMbYQT2bZyjV2JqQpzzm2ZFydKZH8hgi1npd
	19vMSV01C635q120V0NwHQ0I7XUFFJbIVwu9fsMI6bdSNG5tLoYol
X-Received: by 2002:ac8:7dce:0:b0:4d4:4a2e:531a with SMTP id d75a77b69052e-4da48d793d5mr67769621cf.30.1758835005727;
        Thu, 25 Sep 2025 14:16:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5xlKRssdgPLBp/mVDcyq87qqnlkucZFhvWb7yeGXI6WmTeu/PYEaxkEmHz66PV1TGrfpY7g==
X-Received: by 2002:ac8:7dce:0:b0:4d4:4a2e:531a with SMTP id d75a77b69052e-4da48d793d5mr67769151cf.30.1758835004978;
        Thu, 25 Sep 2025 14:16:44 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58313fc1640sm1139215e87.61.2025.09.25.14.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 14:16:43 -0700 (PDT)
Date: Fri, 26 Sep 2025 00:16:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Subject: Re: [PATCH v2 04/24] arm64: dts: qcom: glymur: Add QUPv3
 configuration for serial engines
Message-ID: <dmuhltvj5shmysyjmzjhf6q6nvng45odpwbxsi7frmziunxtgq@xppf6cpyqt2r>
References: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v2-4-8e1533a58d2d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925-v3_glymur_introduction-v2-4-8e1533a58d2d@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: rSQGLPl7gsuzsckBu5NUb-3aXqepLbrk
X-Proofpoint-GUID: rSQGLPl7gsuzsckBu5NUb-3aXqepLbrk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfXzeMcNEQ3QAqB
 plOBjldwB9FDb7mx3dgctb2VtfEAVA4Hl0EFujUOvlTGLmvd4qv1QW9q5u6zqRoSF/r2+jJQVqn
 jD4plEeetpXExUCUdmVIywWGVaL0vtblW3iIevWyZplT9cjvs+lUHSHHXaIO/iXpcFZtbpjGpZU
 FVkQ/Qo4at4Dwpx7GNfviNk1f3MeUZUmWujyCL9NVMqL40rGKT4zeJUGXyLaq3K0EssZ7Y7JRvc
 1ZSz3VmRtgwqIIZK6J7QfCJazgr56RR9PViop2m0YF6N8r5vOoT03EwOUKYKI/WVc6Nq4nu5TG5
 xv8BSmdabtpEA6DVYz15gCexOGHq9cmQ2XSRFIcFGkrDG/Ngbhp83hhazdKykrcEVMGguK04/+3
 YyKd0QKC+t7S0/JVlmF63gWIgi214w==
X-Authority-Analysis: v=2.4 cv=ZsHg6t7G c=1 sm=1 tr=0 ts=68d5b13e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=wkpnFKx4ilImXzAVKykA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_02,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On Thu, Sep 25, 2025 at 11:58:10AM +0530, Pankaj Patil wrote:
> From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
> 
> Add device tree support for QUPv3 serial engine protocols on Glymur.
> Glymur has 24 QUP serial engines across 3 QUP wrappers, each with
> support of GPI DMA engines.
> 
> Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/glymur-crd.dts |   43 +
>  arch/arm64/boot/dts/qcom/glymur.dtsi    | 3041 +++++++++++++++++++++++++++++--
>  2 files changed, 2936 insertions(+), 148 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/boot/dts/qcom/glymur-crd.dts
> index a1714ec8492961b211ec761f16b39245007533b8..4561c0b87b017cba0a1db8814123a070b37fd434 100644
> --- a/arch/arm64/boot/dts/qcom/glymur-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
> @@ -13,6 +13,49 @@ / {
>  
>  	aliases {
>  		serial0 = &uart21;
> +		serial1 = &uart14;
> +		i2c0 = &i2c16;
> +		i2c1 = &i2c17;
> +		i2c2 = &i2c18;
> +		i2c3 = &i2c19;
> +		i2c4 = &i2c20;
> +		i2c5 = &i2c22;
> +		i2c6 = &i2c23;
> +		i2c7 = &i2c8;
> +		i2c8 = &i2c9;
> +		i2c9 = &i2c10;
> +		i2c10 = &i2c11;
> +		i2c11 = &i2c12;
> +		i2c12 = &i2c13;
> +		i2c13 = &i2c15;
> +		i2c14 = &i2c0;
> +		i2c15 = &i2c1;
> +		i2c16 = &i2c2;
> +		i2c17 = &i2c3;
> +		i2c18 = &i2c4;
> +		i2c19 = &i2c5;
> +		i2c20 = &i2c6;
> +		spi0 = &spi16;
> +		spi1 = &spi17;
> +		spi2 = &spi18;
> +		spi3 = &spi19;
> +		spi4 = &spi20;
> +		spi5 = &spi22;
> +		spi6 = &spi23;
> +		spi7 = &spi8;
> +		spi8 = &spi9;
> +		spi9 = &spi10;
> +		spi10 = &spi11;
> +		spi11 = &spi12;
> +		spi12 = &spi13;
> +		spi13 = &spi15;
> +		spi14 = &spi0;
> +		spi15 = &spi1;
> +		spi16 = &spi2;
> +		spi17 = &spi3;
> +		spi18 = &spi4;
> +		spi19 = &spi5;
> +		spi20 = &spi6;

This is a very weird numbering. Could you please add a comment,
explaining it?

>  	};
>  
>  	chosen {
-- 
With best wishes
Dmitry

