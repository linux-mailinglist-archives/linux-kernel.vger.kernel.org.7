Return-Path: <linux-kernel+bounces-839758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CBABB2565
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 04:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E54A23BB36E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 02:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F413415853B;
	Thu,  2 Oct 2025 02:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HAz5CVLc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB774C6E
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 02:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759370753; cv=none; b=IcXxDf/ebtUSoIe5gRlbVqOJKV1Wd7TUi6ag1+Ka2dera2f0XZ6OqqTh2wnelEoXtYAx4lz6Fq4OpxxstnHmbpJTYd0R7+wS2L2a4QMDOvZK6eYaCj3wJNMnl8IPGMgSzHJ7z2GHeOPvzCR3VDmnGUO5Q3Bh1iocF74xkwm4To8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759370753; c=relaxed/simple;
	bh=l+FS39zuBet15cZverAsMFAIByn00DrueloAdz9PJpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KshyjoKa3/QDC2jhtiqCm6FmzIgrwhkgJ80oM0iKJ1AWTb+sHOefMZYYvI9bSZtC0mZN/WidIPmkCKEWtYmgBHX7NoagwL25cnLrS1vNqOvYxEr3UOVPKYa6Ie5K02/QrgNzfbOwAU0ghe8DSeTIbLF1Sq3cMK5OxAv81IBVzcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HAz5CVLc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591Ibsvk023316
	for <linux-kernel@vger.kernel.org>; Thu, 2 Oct 2025 02:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Uz1KimgaPZysBciMTXlV3quW
	2Pafl+wJkK/SdLwaPRI=; b=HAz5CVLcqd6snzgMN3wupPDdbrO9CO10y6s+mb2a
	jTBQkGCJemULnonhbChlDoh6HFUCDMXQYiK60v3mtoHxAvPq7WBMrsuCEim6pna7
	vUsSm+xhfm3C8gIkL+yBfLezbQivISIIpWPgVJatQJR3HZNL3SLAfrpo2v3MNtja
	PFMtpou+wzD6cKdg54AC79PoAtAP1UGQ98S2+HBp1YrnZFQZVGdHFYqopTHoEBwh
	S+cbtrZCw8l1Qt13eKn1yZ4n7xbXplQsZFUrd9P1UHg8gM/bgYGCaHq+at9C64/4
	tOqRel8VrUr3t/0E9GHkXB0D14RU/aI7ukeXk3BTTJGR7w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8a66eh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 02:05:49 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e1015c48c8so32587051cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 19:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759370749; x=1759975549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uz1KimgaPZysBciMTXlV3quW2Pafl+wJkK/SdLwaPRI=;
        b=CGkJgtMfmycJRtxPTmlKW/PI9RKNx9uliIJEJ+Na0TH9aJmmwfItar90wgxZaHJ/w6
         qhKcxkfUQOBNgCwlrDAg5rNtcXSLPp3vaODk17zTKV0hOWg9hSd4d00+HP66GGgGQxnD
         xlDf+Sy49SUl411dZmIRJL4WFsdfLeqf4Lf9a4bHFFMd8KLPvLAd6EMmO9IYOnTQ3uTJ
         t1j7Fr8sBnAKE1n0lYjR7D6SaaWjLohnH/cbwnV38Eq3/BiHX7bLIIuW1eSAJmPQxzji
         ufCP/W4a6k+Gd3Jq11AgmtRhrJWdyhhM2QF38c0t22XcflGJuKV5XuQu0KhTyiM4Qg62
         3mDA==
X-Forwarded-Encrypted: i=1; AJvYcCVnBYsSISi0eevTUretNvmfAR2gm5cxkvSJnup0WlE+HjeppJ/Es6Uut8x6lX8a1U1Tq2b0Zds4G9Nuj5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBzzgeB9pNO8L/hb0bbF2vwkezLmFEtOgF9m5HaJ0YkhLHmQl4
	jxcDygwxxWz6rAABCuKFRAAfCky+RE1VQio6owNgU007QUgdDOthnEVMqHoZP4ZfKwwCGr7gCpt
	FS8sT0op+c6fEbmLvA/T9Y4PbnRSh40evQ9Upomfe5ybvryvwVOYpKbojVoSm93iI76w=
X-Gm-Gg: ASbGncsraJ7w+5b0PW6m043757a0uc56Adc0LD6FMHGyv3dAk+844PWZItKjQILXaDq
	fiLEuhZkCu7hwqEBNf5zEQgCTS4vmBss1mERFfuwB1/R5nXT9Y2Jw/4asdAQR+trw+HISoa64tq
	FfEWqk9lXXkRGs8hUvN5dWqd4DUiZiFKhcqvhEc/NmNOg9dktxxxQwumkmaBnlTsGbfu83oOyfK
	GLNFnDvMWIKLs1CLwPS0qPnRdBhjLR2kGE0XtdaZOsEg/+rLOn3WAfylMtWbXVDqyXONCsx72UZ
	qyqpUzKlU5ZH7yscF8vRVyrAZvPvbE8iqfiaaDNB6aNhP2rY+/a5x09/S6ftTlpRZgA+0KMsphh
	faL5dNqzbW/7OtAzfWGQpwSaq+NChUZeQl5YJKhjDA6wS0YR6KjvCNo0WZw==
X-Received: by 2002:a05:622a:95:b0:4b5:dc4f:7d67 with SMTP id d75a77b69052e-4e563187372mr23583761cf.27.1759370748766;
        Wed, 01 Oct 2025 19:05:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbsN9NaYdc9BH/Kc5pOw7R8dTTMpmEEhKeBrFOgWNN/l2YW22WBhqpVIAeq3Paja6wI0ndaQ==
X-Received: by 2002:a05:622a:95:b0:4b5:dc4f:7d67 with SMTP id d75a77b69052e-4e563187372mr23583561cf.27.1759370748314;
        Wed, 01 Oct 2025 19:05:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba444501sm3181091fa.35.2025.10.01.19.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 19:05:44 -0700 (PDT)
Date: Thu, 2 Oct 2025 05:05:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: george.moussalem@outlook.com
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Devi Priya <quic_devipriy@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Baruch Siach <baruch.siach@siklu.com>
Subject: Re: [PATCH v16 6/9] arm64: dts: qcom: ipq6018: add pwm node
Message-ID: <46ymqf46lgarsozjt23rokzoqam5xmbgt4hlz3wya5eu5fnppl@7t4ayzzkjsi4>
References: <20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com>
 <20251001-ipq-pwm-v16-6-300f237e0e68@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001-ipq-pwm-v16-6-300f237e0e68@outlook.com>
X-Authority-Analysis: v=2.4 cv=RZKdyltv c=1 sm=1 tr=0 ts=68ddddfd cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8 a=Lh10uZTOAAAA:8
 a=UqCG9HQmAAAA:8 a=HU31luCS42qLushI0i8A:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
 a=h7PWpkqlkWt1jHQZSjMD:22
X-Proofpoint-GUID: xamTmu5j38bApWt72wpjLFLuHxR3vsCm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMyBTYWx0ZWRfXz95X0izkhd2V
 kQFcF+Y85oxnesMCHWOwN1lRd4YrjsWOcKW6tdGxY9xuSLCrcxgKYhwwMIwuWyJPWePHIj48pf6
 Plc9jLeRtXz9fCf7/DH8Mbi7FB6zgkM/mcVdoF5hs7MZQGH/etgMaOXIQAKvicllv81YbrjMTdr
 nr/pPa72vrciKR5YOj1j2uOl+DKjT9uxcudZhBaWm1Msn2TPe75xs1XPd+8N3R305kwl56p7PBj
 BDU5b9mt1xUYvFIBm6DDP8OctWdTzmz2Mgs8TW8ZAhlIGmpbF8Ihe36+yYbFH2GVSUZg5VXjtLM
 ULCJYztQRyDDBi9YrM952oyRNPLvhhqSQMRqSEDlntg3ddEzILUXHOXzMXir3dIs8hUiQmMdp3F
 Vdb4NW9Q2dahPBEsgr3ihlWN8eImbA==
X-Proofpoint-ORIG-GUID: xamTmu5j38bApWt72wpjLFLuHxR3vsCm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270033

On Wed, Oct 01, 2025 at 06:04:22PM +0400, George Moussalem via B4 Relay wrote:
> From: Devi Priya <quic_devipriy@quicinc.com>
> 
> Describe the PWM block on IPQ6018.
> 
> Although PWM is in the TCSR area, make pwm its own node as simple-mfd
> has been removed from the bindings and as such hardware components
> should have its own node.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Co-developed-by: Baruch Siach <baruch.siach@siklu.com>
> Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq6018.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> index 40f1c262126eff3761430a47472b52d27f961040..84bc2dec2b22f9634d4ec926daeebb9b40cb112f 100644
> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> @@ -413,6 +413,16 @@ tcsr: syscon@1937000 {
>  			reg = <0x0 0x01937000 0x0 0x21000>;
>  		};
>  
> +		pwm: pwm@1941010 {
> +			compatible = "qcom,ipq6018-pwm";
> +			reg = <0x01941010 0x20>;

It should be <0x0 0x01941010 0x0 0x20>;

> +			clocks = <&gcc GCC_ADSS_PWM_CLK>;
> +			assigned-clocks = <&gcc GCC_ADSS_PWM_CLK>;
> +			assigned-clock-rates = <100000000>;
> +			#pwm-cells = <2>;
> +			status = "disabled";
> +		};
> +
>  		usb2: usb@70f8800 {
>  			compatible = "qcom,ipq6018-dwc3", "qcom,dwc3";
>  			reg = <0x0 0x070f8800 0x0 0x400>;
> 
> -- 
> 2.51.0
> 
> 

-- 
With best wishes
Dmitry

