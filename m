Return-Path: <linux-kernel+bounces-815947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A5DB56D50
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 02:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 797967ACBAC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 00:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B091A254E;
	Mon, 15 Sep 2025 00:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q/VdOuRP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDDF194A59
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757895954; cv=none; b=pDEjPzlvEDRFlmw/pU0Jk7VHgvDIAP6WQrH3czYyHVcfTSMbPLRQ6sA64pFrw1J8yqL4c9hLz84OvBDhGLdTnr4nQV/dHUr/C/3QOTGZNAQg6z1ffag9w+JtCZGJE4hs3HD8P2bakF+D+S04gsVF2r/aNhJg75Gl9as9RtmjF/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757895954; c=relaxed/simple;
	bh=9JOf/x8+vDjy49a7WWpdGMIbreT3j1CYdjT28WFGevQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qu+X3sREqZROhSofAuARK8YLnfSQtJ+grSixY1dMRIyfcML0yg8tWfOxfNVspaIgn2JJIcQt+y8uGNZU1SZ0S+9/7Mvk6U1340RgHH//uk+e+5fgmjAhe1nvKCLITho6uyg8kp6D2Z21bWCN61O4isa/I5GgN0KB1pxdmqJAhYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q/VdOuRP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58EMp3K2022921
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=umfpL2GBjS9X6IOBDeqr9RDX
	8YX0yJCkvFLrjCSzMrU=; b=Q/VdOuRPJ02gOPVvbn9xqZ0rGNTbRnAuiX3RPCqG
	+gpYA/5bpaKpE5nJsUax2nxXhbQo1EVnq8aLw1H7Ssxi2OpBc3gmCJhbdzJwFKjo
	Kn6u5gp17nbfSUEaVHS/KQVkngVoLLiYkTJliLTg+EY1s6l19cFtmKHjhlN7GffA
	6RR/h9V+83nmb/aypwZLVrEt7IYRpB4CU5+Sio987VbSL3/4f91fucW+8rl+fQIU
	VHwPxLHxWAT3xxJ0DS4t5dcBIpNsAgFVWLHe6evlHClcV+tqsN4zisnekU2Mbywq
	xklXEPw8U+SE213h3VcjZNzX0A2PbNVR6qom4bnvDLjKGg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4950pv2ybh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:25:50 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5ee6cd9a3so79355971cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 17:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757895950; x=1758500750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umfpL2GBjS9X6IOBDeqr9RDX8YX0yJCkvFLrjCSzMrU=;
        b=teLfIGHdc+7TZQ49J7Vl+8CgvsCK26ApmRucpw1EBaXXrrQwg0Dd/3WWJcrfDAVpMs
         nmCjI0AybmuG8LpYLbD3/Mwb/aJmfZnZfg/HvQ4s3pEHd4PTwPJPOy9WZhDKIrz63hkp
         E69e8FNwvcVbj2Fa0D/LCDqZSM8TeLUVnghQNxLpmZTKObdhbxmOQVzY8sZybOyYURUy
         4hEWkDh2M89NUpyxlvNpnrfcTgR6TGf/zBypJ984reI8NazEKG8dhhzVcR+fNi5W2IO2
         b1jWugeNNDLU+Q92+c2JyvnCMtaEPlRSxu6OoN559AOus3J/17F6Wggx+Bp6reYWQOQ6
         0NvA==
X-Forwarded-Encrypted: i=1; AJvYcCXKFMa1X/lMbmDx/UBzxgBIOvGRbL2bCbjRTGvWXuUHvWwsYasWq2LoW+d9odFQAWGDcg6T/SpFmXOkbDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YynapfjZxuBE3nDUSpS/Yf6/s2lhwAi8Og6jJmKI5A7gAxOO8Ur
	E/cjvufX2D2bfd1F/R+E0DyTLpVWf4T/tM8E7Von1b9CttmzUwkHMTSmBaOO+tLgVRqvD6RcxW/
	O1EtOYkNm842w1AKMOq2NwO1usfXv7Ei+ip6nb/48WqRPIi77XTmUFPMD0M9DHxrjXx8=
X-Gm-Gg: ASbGncu55qcp5I0U9eR8nC66y6ufolBTOMrkkN2thcmX8EwPP7pzdAgsmgIcS4izJTj
	3eiSTUlqw5xTxKJS0txB4uwBvTsQXIESxnrUJFT7AIfrUM2sDLmsWwpLj8drXkMEOG8vNx+LWt6
	UzTqNEBDenq9KLiT4EBiYQwGdHKWkcZLIabKeSXcl1Y4C4W42CE0Gw7th4/9pz/I4qj8N3N1a0U
	wJuTiSPYH7eYAgVptRATvFEo154yBSv5rAhUNConX6WOB4oWzf7HVduvl9Zy7gOjvf5ob7rxPgj
	1GK9cH66GwUEOTeApX3W12gu2MgQ5Fo6a3xqontnO+Iq7AO9/MkhRg2qZwr7p99ckprDS4cPbNH
	jDJOEGyXCIvem3SIUnXaa+101xiT84fI/fGDmHFo57fb5/q+ZiDU9
X-Received: by 2002:ac8:7d92:0:b0:4b7:a709:fd37 with SMTP id d75a77b69052e-4b7a70a011dmr16759471cf.2.1757895949597;
        Sun, 14 Sep 2025 17:25:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSFctYddLyvI4rFUAowjI9dGidDYhUfC2/597iRwVg8EfqOz4vn10TnEsSVnUIZT+CZiziHQ==
X-Received: by 2002:ac8:7d92:0:b0:4b7:a709:fd37 with SMTP id d75a77b69052e-4b7a70a011dmr16759161cf.2.1757895949113;
        Sun, 14 Sep 2025 17:25:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e661dbc29sm3255796e87.147.2025.09.14.17.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 17:25:48 -0700 (PDT)
Date: Mon, 15 Sep 2025 03:25:45 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Paul Sajna <sajattack@postmarketos.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amir Dahan <system64fumo@protonmail.com>,
        Christopher Brown <crispybrown@gmail.com>
Subject: Re: [PATCH 04/11] arm64: dts: qcom: sdm845-lg-common: Add camera
 flash
Message-ID: <hzqsdhqvgw2cp4xnxocyddhz246ovicwaml2n3qqdooohscyis@3uo2qjlrapr7>
References: <20250913-judyln-dts-v1-0-23b4b7790dce@postmarketos.org>
 <20250913-judyln-dts-v1-4-23b4b7790dce@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913-judyln-dts-v1-4-23b4b7790dce@postmarketos.org>
X-Proofpoint-ORIG-GUID: 1CwaTHEVzPYkGJ-WEVSOkcoZ7YQ22A1D
X-Authority-Analysis: v=2.4 cv=PsWTbxM3 c=1 sm=1 tr=0 ts=68c75d0e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=sfOm8-O8AAAA:8 a=Gbw9aFdXAAAA:8 a=INp5xvtxXxILuIktMPQA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=TvTJqdcANYtsRzA46cdi:22
 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-GUID: 1CwaTHEVzPYkGJ-WEVSOkcoZ7YQ22A1D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyOSBTYWx0ZWRfX9M2yLAcnLXxJ
 PmykUjAEFGbRvKE5PR1/igiuPXFQMmXLzdcN/xTgousuNaOCA0x+O7JKEv/CvuHfazgT2ylqZVt
 uqxDyr7XryrVq5asXeDcscOxcCPo3WKYxihpLTkMSg2f0N58nZunyEZnHpIQvXksaJPo96Su9BI
 SaO5+8trjZDJbLvwDBVJGji4AZyBqz7oThhzvtOzjpAJzK9VzCWjhq6rwm5DoC4mISm53TPtX+z
 +IQmpAgZhpynZe5U53nCfW634HF84Jg6m96oB9NKMSwu5ymcu8SCanTO2JA3MIeCFKpFnUj1y68
 kztTzEV0vUZH2uo6skmwXo48owwuZFtbNx6/xQV3dKa3b3QvcuktF9NeNkFmM/JUCSUl10aTTdy
 lsa67mPk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-14_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130029

On Sat, Sep 13, 2025 at 04:56:37PM -0700, Paul Sajna wrote:
> Add the camera flash so it can be used as a flashlight
> 
> Co-authored-by: Amir Dahan <system64fumo@protonmail.com>
> Signed-off-by: Amir Dahan <system64fumo@protonmail.com>
> Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> index d6129ce03f537f0c8c78c2ae5f39be6146cab7dc..df826bca2bef5e3f85cf49708020a47b8d6bd8bb 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> @@ -604,6 +604,20 @@ vol_up_pin_a: vol-up-active-state {
>  	};
>  };
>  
> +&pmi8998_flash {
> +	status = "okay";
> +
> +	led-0 {
> +		label = "flash";

Not allowed, please drop.

> +		function = LED_FUNCTION_FLASH;
> +		color = <LED_COLOR_ID_WHITE>;
> +		led-sources = <1>;
> +		led-max-microamp = <850000>;
> +		flash-max-microamp = <850000>;
> +		flash-max-timeout-us = <500000>;
> +	};
> +};
> +
>  &pmi8998_lpg {
>  	status = "okay";
>  
> 
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry

