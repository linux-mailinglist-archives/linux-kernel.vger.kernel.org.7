Return-Path: <linux-kernel+bounces-839762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E369BB25AC
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 04:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A7E19C6585
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 02:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB74523373D;
	Thu,  2 Oct 2025 02:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CqOkk8UG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E172C78F2B
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 02:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759371723; cv=none; b=flRq8//SD15pj59elFXCu/NiC5HfShPKzxlPMJYl8Jw0l0AMfOXwdaLYh8ioBHm3sA3bX1HS47suen6DAqfMCnMC1Z1ebzUTnSvKBDcADC8fLZT4nN8JW++6a2Q9vs815eMLQnfRZDUdS6tLUtzXjFEuw4xB1XeSmKACRhQlAOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759371723; c=relaxed/simple;
	bh=R3u8F58rHAEljzf5ieZ6tcvDjFtjotWzcbHKvmj19zI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAqZ9AyvVpUluJk9yl7FXsmwE6LrkCOcbi80FJZo3Bi4uYxhUxLAVTy0PYK/A84ZdVXo7x4TqBIqk32nERRZMiIisgTCo3FN/F21HNdL58DHPEL6X9/R7JdYelpFipm7Y76+lJ/SE3MaA/TQfGpI3iHHz/ZXrXljvm8UHTNWOW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CqOkk8UG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591IbsGV018665
	for <linux-kernel@vger.kernel.org>; Thu, 2 Oct 2025 02:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=umdUQf4R0bGWG14YfjuqrsBl
	GIQNCMb9Bi3W4Jjo4VM=; b=CqOkk8UGOVZjHDAo5OEEm2yojmelwRa9YLKhHRNI
	yKKve87kzZUSbm15C7SS+aQe+qAyeIb50mpRsa+sMUQyZu2SwuX3BhoJbXFtu4eE
	Hu6aIL3TdBo+Wy38U9EY4m/sKvURXXDQJi//LU//Jm6WhEYuLy7trQsOJgw0xngJ
	eXPgupHR57fkIWwHgy1MW1AmUYunzmR8aSslaeWpLt16FmrjKf4Vzz0fQwiOogCq
	aE2wd1moYRH6mh8Q3FRnRO+PVENhUqLXDUCpZY4lMHiu6mw8fvWby5X7NKWmpeDy
	oMMFGUJ0mKyozSlao8Z+EWjJ+Ncqtswo/HiZyhfT6/3b2g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49gyu1arc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 02:22:01 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4df7cdf22cbso44725601cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 19:22:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759371720; x=1759976520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umdUQf4R0bGWG14YfjuqrsBlGIQNCMb9Bi3W4Jjo4VM=;
        b=moPMTd8CJro5yhFWqXFXKNRMz70E7G6FIgdbkAAJAWo1Xt1iaEdC5UmB7hgbXUvOW2
         XRUnkzLLhGYjBc02v3ErDfDSV3U5vhMfr/gdNGcrenOJOS9swXckHymNMLSWcULaPQxE
         RzGTuRv6LIX042aRRTYIGkaEjm7BSIXgsu0H1Qfv2YzVPuCH9hLWVa2NsM2i6/9y5EE/
         /BdTkq6ciSmfmPzj7PT9+3fZddeffN06NHeGFjElgBJlDKvSbjWVn6z5x2f2oAOKatW2
         7CunFpU1XEGBvfdQCvaa+UZoaKNwj/GZ56GXGlhGATMAsEHBPYDwksLGBRBw3lhYo5uD
         PqEQ==
X-Forwarded-Encrypted: i=1; AJvYcCX39hIjZVG3bCzR8/ld15IXjU51OTfkFGeduOBGcrd8rWmw8mEReF0wQ9Hh9lYoGGCj+HivcSQCtSPphE4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5BOo5drLKSIZSWuO07EfNvUiB/KwzwEJXmCz/u79SWJj3g5sX
	LwPq3Smx5qn0568ki4MG3nG4gWjeLM4tuh+si1V57tY+CoaJ55cXgW3huSQkiQwrzN3quZaz75b
	31d/cDJydWBaDBlOk1EnsDRK+64Fxj/H1r3FNYJM4FQl3ZzEoXylqWleCyB3tCxJdKfo=
X-Gm-Gg: ASbGncvyJlYD0RRLGEvzvCfPOWYZ/GGDvyP0qnzE4v9AjwdH9UeWsLlNESK4mjoVgfa
	Rc+8As0nJvK/O0QhQk3diRXZaPeONvLlHPjI8KKIody2HQlJPINFKXRK5r8SqXNsW4qnEcQnSOH
	SA0Gdu1ll3vUwoXxMzqcRVgRPNeNhUnrgkN0crk/bqoVWDKBpc+1/U4YOig0KdGHXwFXf0TXFO/
	TOd1Q1vx9Y0KvnJjbhXka9x2cNA3izKs5Lyh1t9jSJuYtd9ugL24CG10DRM+C5G+Edj60PdoZer
	6EEdfIZ62xdT6MPXlRymf1M6RFBkICwjRbi9z6Er3MiKScfo40D86wpPNjmlCwLdjLBQUsD6uJ7
	GZbiyOPJki0khkU/JprNdPz2+79sAXUeY5RYJbeKlWFpYTW793SdZbqygVQ==
X-Received: by 2002:a05:622a:178f:b0:4b7:acab:852b with SMTP id d75a77b69052e-4e563187a7dmr27245361cf.26.1759371719975;
        Wed, 01 Oct 2025 19:21:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFF+2h4rkzuB2BpRC2eqoMde/6sr1BdY4uOvzdxbbodL/mbH7Y0U3lM8GVcw4rutLwD5Ck66Q==
X-Received: by 2002:a05:622a:178f:b0:4b7:acab:852b with SMTP id d75a77b69052e-4e563187a7dmr27245051cf.26.1759371719534;
        Wed, 01 Oct 2025 19:21:59 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b01140c6asm390391e87.56.2025.10.01.19.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 19:21:57 -0700 (PDT)
Date: Thu, 2 Oct 2025 05:21:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: george.moussalem@outlook.com
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 9/9] arm64: dts: qcom: ipq9574: add pwm node
Message-ID: <zrpmbwytu4szqpwrko5jy2kk7uafabaq2lhxrwqs6g4qnfrr6h@34qy47zjmddw>
References: <20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com>
 <20251001-ipq-pwm-v16-9-300f237e0e68@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001-ipq-pwm-v16-9-300f237e0e68@outlook.com>
X-Authority-Analysis: v=2.4 cv=RfGdyltv c=1 sm=1 tr=0 ts=68dde1c9 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=UqCG9HQmAAAA:8 a=EUspDBNiAAAA:8 a=THxROjQVSa7aAfmVI-MA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: -FjbVodiX41hqOojiqj1ruGzOASOsF1Y
X-Proofpoint-GUID: -FjbVodiX41hqOojiqj1ruGzOASOsF1Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAxMDA1OCBTYWx0ZWRfX62zzRfecOdrT
 NLuonWtujS7Ory+/V7H56wA5FiGoPKrFglcebCJaFs/OqVhz37ssFOlmgFlkiIkQX30BYrmHA2B
 nbhWEURVyO01sRlylAp/TdWE5YS2bT65MBgnGGiX9ppztLYHL1QrXvUGSUob+XDMgYucQBTrcVV
 N7r1zjky4j2pabpxX7mahGSaDWB2UX8Y2Tz2yK3xR1425VXMb7KQmfVGE5xa5e+CqqtPnuP4j8F
 YukUSZNR1Tkn32OU+vWIsl7MD+iI0Y5VKZuT2ER8YzPDbK7fLQQa3lGHUFtt8rc2GqcCsF8M4Vw
 NeMT00E8VnCip9Y+J+E5y60fzh/8U/ocui1sE4536jOsH1e2hFfmD1mNWnrARq06s706wdI48/c
 egYlI1fwN6cLglRcdn9YV6ZHVPxvMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510010058

On Wed, Oct 01, 2025 at 06:04:25PM +0400, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> Describe the PWM block on IPQ9574.
> 
> Although PWM is in the TCSR area, make pwm its own node as simple-mfd
> has been removed from the bindings and as such hardware components
> should have its own node.
> 
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


> 

-- 
With best wishes
Dmitry

