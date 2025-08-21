Return-Path: <linux-kernel+bounces-779546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B30B2F577
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9686B6055A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56153054E7;
	Thu, 21 Aug 2025 10:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j1pcpAk1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF53020D4E9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755772633; cv=none; b=oBnq6crmo9jXnqQgqYTukEyYHztnxvVrUtHDZrX+kfeaqguK2daYjVsZ50nCZ5IhXYPFYjMZxyYWwmJ7mbUEJSGgZg0OC5XZXHvAIn0G3NBhgVkdp50PRk74Fgt49TGo4PL0UlOnZrE4/irOp/J/9ATSwoyVvLkTge0ntEdilk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755772633; c=relaxed/simple;
	bh=3A6M0mjid7CMv3T/gzr6PbDZciNbA5GGzLT3i2GHg6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWhrsGtEVACOyeZhanyvIVVjAtmIQOj11EpwktbwnpoV0PniCP+JfqUPay2UdbBSafa3iPYirjgpEaGtfEZANiKQpQOUR/M8GPQm2wMjC30d04ekzxl5smE59n+fy4b1wtkAIL3zLCQOkdMMGmFhMPwxPHLSqXZl3aqN7CvOOcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j1pcpAk1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9bCaW012935
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:37:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=IjYBFLC3rhWAS79Puqp89OqI
	o8iXMrnfMumh6vVeal4=; b=j1pcpAk14aDD5FXuN6xNIXAdB+Kk4kbul3yJK/Rt
	ZQvelm3btu1rstKmLdUT+pHQSNll9LutMTLrJP72fEvVoALrXOwzcr7a3IfaOa6I
	LUYnjgVtflGDZfje39jT6tYwfav+Q7ryHd7sjT7/KKSt9ng5AZ1/lqZW7kYsTxN2
	2urR/C8IYjWKtQN6NoQDP6b7I1yMzFWgnO57VZ+fY+QMC7FsEcvdlVbC6jPtqTFx
	QXz384KV2jrh6Qd8fU45+rdGmLRgwbZEpD0mXFrBuL52Np+A47aPWqxjoEXX5XfA
	JsechO5Vij3cYGIg0+/bewoZe8TeisRFV9gF/kT6F+KFMg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52dn16n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:37:10 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b0faa8d615so53250311cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755772630; x=1756377430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjYBFLC3rhWAS79Puqp89OqIo8iXMrnfMumh6vVeal4=;
        b=B6HNtjmKSfhn1+Ppp7mERVUv4zO7awVzNqFgbFTvOw8BAkr29Lu9CTGpHIf5PwZ8iR
         VTSd7BFHSxsPA5T2SrbXIbuYSYDYb0TAe7v9eaz16C+Utq5LuHEAok/JWEQ14Hq9yBql
         CsnQrLTxGGjEq1NwkCBSl/lG4+IIruW8hdXbM71jSR+HO/sEe/rirDtizsK1IoLzqVxU
         q9dOmxe9IrRIvbHnXEyCsQLreWYiUspXaIucY+1jTbxVMzVAmo7yZmmch+enm+hEDxRa
         Pp8RB70uui+n+vCZB4Bl9k7NLzm69uZ3d9YAkcc+il3g57tszm141ZaUfAh7TY7jMrAS
         NL5g==
X-Forwarded-Encrypted: i=1; AJvYcCWdS0ghsTithfUKPs2edG1uW9ZSigCeaOOqz03owyQuGbIoCtOYYrUd6xyGZLIziqbw9ltpf7QLOXwCCaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/fzf4eQyxilSsrXXeGPqsvu/ywUJebOyvy0/3Twf/NaXuf1TK
	wEiausARq5MvNDMBh1Q3OS8046hLrEadSgup0NHI0OKTy855Het+9rHLr67R2sWnKcUmOba/jCQ
	7tjYkTMxjugoxqUAOXkXiOwEDPyhyYoL1aWeaRmYmNsH+LJBRoyMF/w4TXrLxujlhMK8=
X-Gm-Gg: ASbGncsZ4CGkY+xsIIelKvSKLfftaShOZyPoYlvn8ZvUWNhatGsbyN6K7WtOg2ilHBA
	GbWGYs1cnmfEt5QqTFi7sQKyN9myZ37WIRWd8mX6w2X3vyrrMRJxCSg+cHczsJQF4p6Xhx7rG9b
	t4XsUaq+huxgJLndHfCkszTU/nzaC9o4JPE4soaKerV0OTiK5wOICSp/BCdFeRdrP0xG+WjooH1
	yKEGc3OYCW3UQw8qVe3xW8Y1n33QEG78KXn/vYatD8k77iLJ+XFFGksKki0AlH8rvgZ1SVmO51A
	uHzze/Uf+wRDYYJQEY0+4dMPLs2xB8y4TzbnxQmAnsere2F0Mj+ZqWo9Rx7uRQ/n4JGVEOzYAUm
	tUr5l4K+Ma0dojsDAbnclyDFTzWQQzWcnt7Y8eP/l+ycAU3NwwTZx
X-Received: by 2002:a05:622a:4247:b0:4b2:8ac5:2590 with SMTP id d75a77b69052e-4b2a04313b1mr18043301cf.35.1755772629849;
        Thu, 21 Aug 2025 03:37:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbbSb4CFmrzy1hyw0AdQ/ZOf9Jk5dx/46GPLRHV672EzsRWtz67iHEj1Hbr1BZW+3F7Q0VBw==
X-Received: by 2002:a05:622a:4247:b0:4b2:8ac5:2590 with SMTP id d75a77b69052e-4b2a04313b1mr18043041cf.35.1755772629344;
        Thu, 21 Aug 2025 03:37:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3cc9f5sm3074582e87.75.2025.08.21.03.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 03:37:08 -0700 (PDT)
Date: Thu, 21 Aug 2025 13:37:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8750-mtp: Add speaker Soundwire port
 mapping
Message-ID: <wbjvk52opr574rlmsd7whmtfcrubsbcufsthqpmxdejbcjhtv5@mbz4hj6ronwl>
References: <20250820141233.216713-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820141233.216713-2-krzysztof.kozlowski@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX+nC75Q6yfKqA
 mXOg/UAgwm2oEwazKha/vSRV2SIl9zBmCqJV/sL8jYSdcU/8G1ZZdiBpQ2n4SslXluyOeMB7riI
 D05q1/A+ykSroF+RCn3D5flb1TwJezVOuaB5BsOdoaXPSwBzQ0zRspA1inWYckYuqmFM9317FEg
 tfkXt3Y34hTfPi3gWcFv63yASVtsPU3tZ8/YDc9NETWkLZ/1smdhjY7vvTYbzcQfyPYPFcAeTQ7
 uQAAQMvnZgvDF4vM4VyGUI79Tp8LQJlDmyfzVuawSCjeUVpxtu2SB7klQeYQdNX5hmVR+A6xj0f
 fwPjMKqnVJtpYvw6Exk3UyXllKaQQRPBLKu8WCszNnbZjMuiHlA3NCFX9VfLIL2GKTKHXb+0Nf/
 BYDUCtwPd7Fl0EAyI2sJgRgulZosIw==
X-Proofpoint-ORIG-GUID: x4P73Tw7hc08rSfFaeCKBi_9-cIqjL25
X-Proofpoint-GUID: x4P73Tw7hc08rSfFaeCKBi_9-cIqjL25
X-Authority-Analysis: v=2.4 cv=SoXJKPO0 c=1 sm=1 tr=0 ts=68a6f6d6 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=E_llh0YH3YGsFUW4RUgA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Wed, Aug 20, 2025 at 04:12:34PM +0200, Krzysztof Kozlowski wrote:
> Add appropriate mappings of Soundwire ports of WSA883x speaker
> to correctly map the Speaker ports to the WSA macro ports.

Would it make sense to define constants for these values?

> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
> index 75cfbb510be5..946ba53fe63a 100644
> --- a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
> @@ -938,6 +938,13 @@ left_spkr: speaker@0,1 {
>  		sound-name-prefix = "SpkrLeft";
>  		#thermal-sensor-cells = <0>;
>  		vdd-supply = <&vreg_l15b_1p8>;
> +		/*
> +		 * WSA8835 Port 1 (DAC)     <=> SWR0 Port 1 (SPKR_L)
> +		 * WSA8835 Port 2 (COMP)    <=> SWR0 Port 2 (SPKR_L_COMP)
> +		 * WSA8835 Port 3 (BOOST)   <=> SWR0 Port 3 (SPKR_L_BOOST)
> +		 * WSA8835 Port 4 (VISENSE) <=> SWR0 Port 10 (SPKR_L_VI)
> +		 */
> +		qcom,port-mapping = <1 2 3 10>;
>  	};
>  
>  	/* WSA883x, right/back speaker */
> @@ -951,6 +958,13 @@ right_spkr: speaker@0,2 {
>  		sound-name-prefix = "SpkrRight";
>  		#thermal-sensor-cells = <0>;
>  		vdd-supply = <&vreg_l15b_1p8>;
> +		/*
> +		 * WSA8835 Port 1 (DAC)     <=> SWR0 Port 4 (SPKR_R)
> +		 * WSA8835 Port 2 (COMP)    <=> SWR0 Port 5 (SPKR_R_COMP)
> +		 * WSA8835 Port 3 (BOOST)   <=> SWR0 Port 6 (SPKR_R_BOOST)
> +		 * WSA8835 Port 4 (VISENSE) <=> SWR0 Port 11 (SPKR_R_VI)
> +		 */
> +		qcom,port-mapping = <4 5 6 11>;
>  	};
>  };
>  
> -- 
> 2.48.1
> 

-- 
With best wishes
Dmitry

