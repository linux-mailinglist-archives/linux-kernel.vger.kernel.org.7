Return-Path: <linux-kernel+bounces-798486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3538DB41EA9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0AAB17AB8E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E0B2E7648;
	Wed,  3 Sep 2025 12:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KYU+xiYt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DCD2BE65B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 12:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901822; cv=none; b=bWdilWqWTaTBovKiKMCpzxTVtEeJMdAZTj1ZglKFC35h5vnGhXd9MxaCAIH1D0XWRL1AC10W21H10TJcHW8wGl6QES2zW80IgY9TAsMUvKnJCdMYjvFQW4gi5Nlxm2b/e0CHDj7EC2UvHpaM6zEzke77ssrhuaa8KC/+dPwta7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901822; c=relaxed/simple;
	bh=T9zMBVSfXXkcPKE4WZiFLlE4rfzCAascmEHlP0GQHuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yh6LbBa12ESvOsZ5SHRv3JWBsfcXHSLMWPUworvZ4dymmIAmHzagBaKIJCMUPE33x+83g4sqxNIhpAFBYVSdT9OvH5O0UHIvLv/jnhWKXErdcd4xKgzipahKKQBKY6C3zRa+YmfmV6OoLp2XLVZNtEwjFjhdwBDJqTuZKd/+5Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KYU+xiYt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BFA82004795
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 12:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ylMxvgn2/5WfIAh5ue+ghLhJ
	nilgf124w34Bfp/g+Q0=; b=KYU+xiYtbGF16ZrnYQ30qSyxDrDHePo4wS4BDehd
	xZDa7FuTtBmztCwX2/BxLelgs45bcCSAdA9j42JfwuSLoG+3ivRmYQB/HjkJ9Ohw
	8oTsN1MEN8qm7wn9Y6qbX/JpDM9S3myjJzAzJCurU/iAqH9TbTI/wIVhfvC4dfke
	FSNwgdcwi39udkw7U9+6Nk2FpYj7vhBK5ooRoy6kXtrIvHDJYTDV5hYdIhstXQTZ
	jw78iRxKqKTRKZk9gzjbpC+43PhVF6MpICFQjkZG6jQHsmnK3gsuLVKp8+CHyHvU
	swMRUtp9telc5Ol7FfWNZVUdkkHhD9Qh2+nJASDzg7YOrw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnpbrps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 12:17:00 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b3aac677e1so14214451cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 05:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756901820; x=1757506620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylMxvgn2/5WfIAh5ue+ghLhJnilgf124w34Bfp/g+Q0=;
        b=AkEFvyigz7wzlfZSWeM8MiAmZpQB4279QhIikbRSLgCprt+UpwpT5Al2MkcMaExSUf
         r7CY0U11vGK70BgF6f5luEyzaD0j/N54FQqgviYllBsGFKv8nxdAvSjQEwU/QyHrXD5o
         ZV+HxRkCmgruvJDc2av2M5n1NGeVVAETIkWcpmeR5iIEbduKg4o7/9Dy/aHThyKf8GVk
         gw3ga69o7BIWqHw36nq2w8rF2iESNvPsaXvIh/pzTKXWCHR2c6SX+G76BnIvyGeWGan/
         6y3QPfl5AqvByIMqDyVg1k3np/2ITGhpqWqkvRiNhgnAUBe2PC1Olk6vNmhaDMtF4iQz
         dZEg==
X-Forwarded-Encrypted: i=1; AJvYcCW+vnfGIMZnnRP9VJrVNOrSJDg+kZMGxEQbuOnmA5+BprKmEPA/Xc8zHtT2kz+bM9Q2ky6J1bSAvXA+GxA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Te9KwJwdnAxsLX+pEjH+yt1yzoB6KaxLlF8c5aI5rj8lAld6
	ii+8YxQbvQP+ix1OT7p6iduNsBuY901dLtRqD62/MOdfQ1a0pB1LRXDWwATGQBtfkLnSKYwuPMv
	bS6IQ6eJzxkk+eRhJ6uv8oeUFbWfXgO0QWLXICnME6XAE65PLmOJsp+/qEh4ejbW3vYo=
X-Gm-Gg: ASbGnct5vmiMMHQcWRbVCN9R2s5vCpPaFYEWlYJtj88v7JGJ/g6389hL2rhYvXi/Tot
	0V7AtFmr7hGZ9rKoB/RWsgh3hTIsLnwC6bB3kiGSKnLaiVeisecXcxuIeg27zbaviMxeSzAk6r0
	ZqsUxpG2OoA63h0+hYqABKLG9ucnBokN0wbeNarHHaNw++2HiNU+wQts4oObtvH7PfOB1w36JCG
	ActQ9vbwR5whucr0xlc2xAydhloVfTUT6MllqW4lj87noU46OiJYHCiF2coJj0OGBtU31RnR9UD
	Rayeu76WKygg8g5ac5xrHoqXXxCperjMd5aQ9Ck9qe1l0l44GbzjMfprRLm4Gz5sACHsQ4JD6FR
	mVn9waz3WVzjM7rtHNq2hzvIOnHwDp4bnunWPu60R4Xqo64a0OMKI
X-Received: by 2002:a05:622a:1898:b0:4af:af49:977f with SMTP id d75a77b69052e-4b31d843106mr158036051cf.30.1756901819530;
        Wed, 03 Sep 2025 05:16:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf1JntwKpKDnqktzqn0jP9DtdNKaSUHktaQ51gxNmKUeO36CmdMwvJ8YX8+atEfF8/F8jfpw==
X-Received: by 2002:a05:622a:1898:b0:4af:af49:977f with SMTP id d75a77b69052e-4b31d843106mr158035581cf.30.1756901818930;
        Wed, 03 Sep 2025 05:16:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ace9c89sm482916e87.91.2025.09.03.05.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 05:16:56 -0700 (PDT)
Date: Wed, 3 Sep 2025 15:16:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: Re: [PATCH v2 05/13] arm64: dts: qcom: lemans-evk: Enable GPI DMA
 and QUPv3 controllers
Message-ID: <olv66qntttvpj7iinsug7accikhexxrjgtqvd5eijhxouokxgy@un3q7mkzs7yj>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
 <20250903-lemans-evk-bu-v2-5-bfa381bf8ba2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903-lemans-evk-bu-v2-5-bfa381bf8ba2@oss.qualcomm.com>
X-Proofpoint-GUID: MTngz_lavDh2KDFJx4D2_L5HpjF0z8j2
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b831bc cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=DESvhSBXdVqio9EQXHkA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: MTngz_lavDh2KDFJx4D2_L5HpjF0z8j2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX1wnfQsNf1kzb
 IBK7c9vl6NWCe/ivbXmXiuvzHM8UBI5Ln7pTdzuMaMDg3qWkiMBpdPO1B4EVQh42W1tPgEvIBM5
 4U6MetC4V0EdTkoskBDRgSvNocMBhbpokybYR46LuQj+ECHtkGRlgskgZX314XpvQy/cX0nlNKi
 LRA6ec8pA5sKYoLaX1ILKOKFcCyDquBCPgUGfsdBVjv64ubJBoGLyAP9Gh68+Lmj6te95Fezzo2
 GLncZYztuTGXDVCzpSHsKpmyboMg7suCPABl344MNs3tYRBrhIatNRf5yWa7qKhsu5fAyXlkUAi
 donx1HY5idFkTCw8FBFtj+YiPSoi8UiOBMhDfzrgytVXEUnjytsxL/LSvlBgoILvAtAtxzuadW2
 AskkUyzX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

On Wed, Sep 03, 2025 at 05:17:06PM +0530, Wasim Nazir wrote:
> From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> 
> Enable GPI DMA controllers (gpi_dma0, gpi_dma1, gpi_dma2) and QUPv3
> interfaces (qupv3_id_0, qupv3_id_2) in the device tree to support
> DMA and peripheral communication on the Lemans EVK platform.
> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> index c60629c3369e..196c5ee0dd34 100644
> --- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> @@ -277,6 +277,18 @@ vreg_l8e: ldo8 {
>  	};
>  };
>  
> +&gpi_dma0 {
> +	status = "okay";
> +};
> +
> +&gpi_dma1 {
> +	status = "okay";
> +};
> +
> +&gpi_dma2 {
> +	status = "okay";
> +};
> +
>  &i2c18 {
>  	status = "okay";
>  
> @@ -367,10 +379,18 @@ &mdss0_dp1_phy {
>  	status = "okay";
>  };
>  
> +&qupv3_id_0 {
> +	status = "okay";
> +};
> +
>  &qupv3_id_1 {
>  	status = "okay";
>  };
>  
> +&qupv3_id_2 {
> +	status = "okay";
> +};

You've added i2c18 device in patch 1, but it could not be enabled before
this one because it's a part of QUP2.

> +
>  &sleep_clk {
>  	clock-frequency = <32768>;
>  };
> 
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry

