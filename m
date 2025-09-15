Return-Path: <linux-kernel+bounces-815956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C5EB56D6C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 02:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6F09189B16A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 00:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE08C1BD4F7;
	Mon, 15 Sep 2025 00:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OZD30o+P"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950EE1A314D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757896438; cv=none; b=RqdzbwN0OepYXNCwyR2P1Dut71RpxECWluPkquU8//C5kh6NqgbZvXVyHhztqjt/IAGvFPyTVkN/lcSks0GXuQ+9WHxFYNjF9RKNjeXlp25IOImJqNJbyQeVdNXuuz36OnIHIXGMLR+FCXq82EjB+I6yEMy8wwnuCUAAESiZMJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757896438; c=relaxed/simple;
	bh=d5LJuL7DuXUvIfq5ipMR2VXHr9pFqwhZ+y8GKc/qdOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRwUdDgWjsKjxM+tyPCSnA/DLcNOfByr0FwjWenSqL1C4ttNjyav8ZMaZ4nHYiAQqZ8BgX3lqXaAJ0f7pF/vY+p4kJBXisV7Qq0VgOD3ijO9Rk87RcRJ86MYTqoMrbuYkv6BW6koS6fdBudwkqxjsHHRZofYKxv6Nj0l95r5BCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OZD30o+P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58EMBfoP023928
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:33:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6K/VpkD4TuvbK5PqWkaGNmip
	rnAsqrO40m4H2GsRV3E=; b=OZD30o+P+gMV88FOcWGpocCJqtkKmVqj6MZk3qsf
	/3LxyzdHbbxdPSLY+Dtn7OGAlsDwTxWi4IKy7x+0QaCN2wwUaK3TK5khw4mUby4+
	56TdTa5c01tz3XiRVQGj3PEbeIDbeRV8diuTj4l2WD+WI0mYdd2YxGah4hPF3LlG
	WaiqWXBRQZu8XCV8fzEkmn6dhDBXfRLEnL8REbbGZvfOOa3013aQnHgbupabNKcS
	4rayxMyPYGJg/gEpQk/Ts5RXYlRNgpcibb604W0c1NYh02EbASvMSM1DkWlpgI2z
	c5Rpw816uiKeyHf4DlYNzrRVbDEptxqZ/hrg7wtZ0wmeCw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4951wbavg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:33:55 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b32d323297so83579581cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 17:33:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757896434; x=1758501234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6K/VpkD4TuvbK5PqWkaGNmiprnAsqrO40m4H2GsRV3E=;
        b=CAKy9wzaeM7qeeQq18SQrETXZFE2Nw2NN/xkmpaQyR3Odq9vmORltIqTfQSdFXWIj+
         GsB1J1AdxPvp5//Lr2DzxuUQDmjcMqNZFfUGMglDw17Fut04m/A/b6rerNkyYUPH03da
         88PznEoHF3xidnONyzdYNgnvhNq+WpWKBjo9W8sw7D0HZN+kPLi2OjYOLr9+TwlNOYb1
         P7zffxpVi9pkzlUDlPiiVHSQTonGlkGxU8q0eXNg3UYhLsuWvuCL3Q+tzzO3pgbDtoHF
         EgwAeu1MPZDPu7uSqelk0DvJZPI+jiNYVav1HkLi2EZarsDCl8GtFofx4nWR4c/42buI
         ezsw==
X-Forwarded-Encrypted: i=1; AJvYcCU0KLbHVU2LRKFu63ZlcepLDAkn1tuFsMKMloDh9sTTHK48lWwF0aDtgTEbsYq2eMcHNp0qNHG8Wl6ZOFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJNaHR98RE2OdCB30SBWZEL8oMZfvkwwxHdhPix95rnB+mpxgS
	33hqxwYSgfVlFtBltYxB2fhfXnfLedALHMm8bjoMrul3sztcDYUvaS+20YMQZt53XFQ8Dj7lmsh
	yc1ux22JXUnW3cbxiPKpHVrVylBu7WNgnFJ5f9Lhgmg8B3GSjHLyLHveR/gSMyS1CGU7gF0sLQi
	k=
X-Gm-Gg: ASbGncuOrl7xOI6LKXvHqbT+uPRNCgKgZFRXor8IIN/rgO6h0o3SZKYM8Szkls7RiBq
	rIJBsh71Um8nXQITIBhgXy3SRswaLcZBBUfW2Awq183mFipo8NqI37sdzWnUdKIr3u2GatPPQDr
	jTXroOOGlhqiSV38pphExU9DkDkAOfaJr1Zi9Hup7kB1ziiVpsEHv6Eff7JlWtuDoSpHqbKrI0U
	zXYmTeruQldDZg9BUpkppLsQCVmLTtr4KaB7jHoQkLJuVY0PiKtLVPduyVNRXnt+gI1R2jnv7Wy
	ZO7N0/s8bOGqgzTMiveO0B6pQNL75VDuWEYXX2vusU0B4yLigVQ9T/Oh+Xg3BDM7qhrT/xq1+Sd
	YUTCPSrrZYpIz33b23afbHSjjz9H/Rj35UP4FwJww7PNGVzHG27SR
X-Received: by 2002:a05:622a:a16:b0:4b3:a2f3:47f9 with SMTP id d75a77b69052e-4b77d151f25mr148354461cf.62.1757896434164;
        Sun, 14 Sep 2025 17:33:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFplQatiVjk8b9qHlsT38sNdyQt9MMBZQrsYKu98S5KcZiwsZiUSOCDtIlLFRzby5KjL3eVpg==
X-Received: by 2002:a05:622a:a16:b0:4b3:a2f3:47f9 with SMTP id d75a77b69052e-4b77d151f25mr148354251cf.62.1757896433749;
        Sun, 14 Sep 2025 17:33:53 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-571a547ad9asm2284751e87.65.2025.09.14.17.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 17:33:52 -0700 (PDT)
Date: Mon, 15 Sep 2025 03:33:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Paul Sajna <sajattack@postmarketos.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amir Dahan <system64fumo@protonmail.com>,
        Christopher Brown <crispybrown@gmail.com>
Subject: Re: [PATCH 07/11] arm64: dts: qcom: sdm845-lg-judyln: Add firmware
 nodes
Message-ID: <yneazsozjexv4b7gvzcdecv3zdzzbbscqg2vil3czdeqtdrdbf@l73eggl6y6uc>
References: <20250913-judyln-dts-v1-0-23b4b7790dce@postmarketos.org>
 <20250913-judyln-dts-v1-7-23b4b7790dce@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913-judyln-dts-v1-7-23b4b7790dce@postmarketos.org>
X-Authority-Analysis: v=2.4 cv=XYKJzJ55 c=1 sm=1 tr=0 ts=68c75ef3 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=Gbw9aFdXAAAA:8 a=1lR73kVuVWel2aiOKFwA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-ORIG-GUID: 7BtcvmvL6YJGnTpBla_cH6mVYcHD20Hk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDA0MiBTYWx0ZWRfX7Xlpo/HnQ63h
 NlHUFdBEJQgvGnpr3jUDN64nXFZejwxik8UP15NWNr2Eu9d0m9PaYIQC3o0XEIOMrLAIPufwWWr
 W1VqPY/gdP1A4CQrYo4tKtOAfy2xoq7U4a0EZIT6NC6nFdxhqvvPHxcN6UC0skytWot7Lym6re0
 Ifel0lCNxlgnXxh5fZ7JRgVy4gzvGZsmihlIBd3ndDCpMKz9nZmc9cmrwuY/ByaZO2UJSi0yw+b
 DLi1Ej1b1iaWsD5w676TH/+esHHdJiUbhiKVMZa6TPWE1liX9GWMU8ZXR9SzZpeJbP1WU2vZG9P
 DfgKwTPRFdlBISJW7/+1V8qkI9ColN4Pnu3e8PVoblEgapWDC/ci8LTDSh802PZcV8A/5TvxvSA
 Jk2B10C3
X-Proofpoint-GUID: 7BtcvmvL6YJGnTpBla_cH6mVYcHD20Hk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-14_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130042

On Sat, Sep 13, 2025 at 04:56:40PM -0700, Paul Sajna wrote:
> Firmware nodes added for ipa, modem, bluetooth, venus
> 
> adsp and cdsp enabled

I'm not sure what is written here. Please describe the change according
to Documentation/process/submitting-patches.rst

> 
> Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi | 10 ++++++++++
>  arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts  |  8 ++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> index 585582ff4e0bbe8c994328278d5e5dd3a280ddb6..cc1c78162eedd50d30a70810ac3790efe6c0492f 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> @@ -173,6 +173,10 @@ &adsp_pas {
>  	status = "okay";
>  };
>  
> +&cdsp_pas {
> +	status = "okay";
> +};
> +
>  &apps_rsc {
>  	regulators-0 {
>  		compatible = "qcom,pm8998-rpmh-regulators";
> @@ -483,6 +487,8 @@ zap-shader {
>  
>  &ipa {
>  	qcom,gsi-loader = "modem";
> +	memory-region = <&ipa_fw_mem>;
> +
>  	status = "okay";
>  };
>  
> @@ -683,6 +689,10 @@ &uart9 {
>  	status = "okay";
>  };
>  
> +&venus {
> +	status = "okay";
> +};
> +
>  &wifi {
>  	vdd-0.8-cx-mx-supply = <&vreg_l5a_0p8>;
>  	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts b/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
> index fae85d4c1520e044d8166bb22a8f5762fda250b2..1596a3408659323d60f1b7c395098ed628782dfa 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
> @@ -70,6 +70,10 @@ zap-shader {
>  	};
>  };
>  
> +&ipa {
> +	firmware-name = "qcom/sdm845/judyln/ipa_fws.mbn";

Note: it should be qcom/sdm845/lg/judyln/.... (or qcom/sdm845/LG/judyln)
Would you mind fixing it to follow the convention?

> +};
> +
>  &mss_pil {
>  	firmware-name = "qcom/sdm845/judyln/mba.mbn", "qcom/sdm845/judyln/modem.mbn";
>  };
> @@ -190,3 +194,7 @@ bluetooth {
>  		firmware-name = "judyln/crnv21.bin";
>  	};
>  };
> +
> +&venus {
> +	firmware-name = "qcom/sdm845/judyln/venus.mbn";
> +};
> 
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry

