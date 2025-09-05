Return-Path: <linux-kernel+bounces-802921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2055B45872
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582DE3B5268
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163D527E05B;
	Fri,  5 Sep 2025 13:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KGfTKInG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2871C860A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 13:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757077641; cv=none; b=lPX2e+9L8hVB2j+Zoif+mITQPEPBelnF2RfejUCAXxxXIZqGq0pw6+5as3X2rE0+/4TlsQNZJPCw21j2aH9Z/hfnVAptG7xbSnCkw46+vw/kEnKthcjSup0iiMkPAwW/jywVYpCrAItcysyH7mfuy5QqDhqhojrIR2CRbSxgsOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757077641; c=relaxed/simple;
	bh=JsdLLPrUmGM8Tgv1FnyKp6BjjHIfVQSZbw506i21JtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AinDkTFE1vmKRi4nFn4H9OmXikyqqwq7ueKs33/Q2qhkMPIitpP6DW0uvuLoUx4B5vSVtD9yb/6y6YOjpJzeuThy1L2j215yeJmgqRfHNX6P9vYWMxfZPj7lccZI+TtZ4dkqTJOv1M8UNygRhURkU7jdOjhvz/+bGg0aw95cJ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KGfTKInG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5856tsCT032189
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 13:07:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KrQKZP3w0ewlZNuZWmqjmyoq
	dp+JRPUq5JvWfsJm8Eg=; b=KGfTKInGLH016v/bWWLBLY4d0AWU5cpjdf1TzVMT
	LlSQIhkrXp03YU/0z+2IQ+1BmyRxGELsUmBwhj9nwXtkIKjmGxJc7CWgFsDdusgx
	JX3DvgR/W0KhH9iwOqQLJ3UxkwEdMj1Tz6MBKVDTTBB1iTAQ97stY5Y/szaA8zI5
	kiaTdt5l9ITkt1eF5gTuiWSqEv2TOC3twYKNBQt2WJMqJZovXcXBKw++nNqA6qBS
	56AHOEsNm/PaEbjHIGMUCLaFovQJLwABBEmwpkIVMAi2Ba8E4uh7mQHVJBIpmQ01
	6KdhKYZUmoV1C90nxvpKB8BnjPxmYv5gpFq4YFdqS7SJkg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnpkbcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 13:07:18 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-329ee69e7deso2149474a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 06:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757077637; x=1757682437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrQKZP3w0ewlZNuZWmqjmyoqdp+JRPUq5JvWfsJm8Eg=;
        b=FHZfu8NDnoy+r02yqveufo3+LDL9uZi4+URhT5oGK463Lp5I1eL2UdaKmVo93Z+aEA
         I1IitJtzoF4kRV+DtweeWk9V7e+CwVEJG7f2P4OT9o14wrOLp/ikWWkJD95fx3XWryXv
         D046HWearHVsAnQNLD0TCD9gvIx6Ue/rMBVjKzbQFM3uK9QfR8SFOzQW0DAt91l+ZaQ2
         v7yqej0SvE2m2ejhd5IPBXO0kH3fVCksvm/USCADiLvEd6r743KSan65Bn7QKHxS/IAP
         NnNUxrDL8J9nufNor+VczF523IrnHGhQUvbSehLCSYQKK8aKHVga+uPe5OvL7d+qfApo
         2YKA==
X-Forwarded-Encrypted: i=1; AJvYcCWIVq/nGkI3NTiPwG9x4aNoecIgNr+2Icjrm/etXMOahWgAPSsfJj5OUvj4QwxSj5bZ1AV4v3CqXiOk7qg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw2xAB4wWClPTEeP0u5U+/RmqnW8pTAbGJvcWiB+mzdoI0XBEe
	6vVLWcppKcivnElWCYRDcwc3Qg6wkytatZGVK3nM+o33XfJeV0c8U1myUZqUfMZ47OQLMuNL5m9
	QKXELKdfbyuZmHXRMjBi73/hCdEYgWtseo/u/TIWzktoyd6NAFM2WfQdjIbAKastkWIo=
X-Gm-Gg: ASbGncs/1d6NKHSzB8UlgeZ512Uc8upixdU3FxHw1SYEZhZgTRmOVdGSQ1t7/GpzJTN
	zsgs+Xb15W3xh/dFXOcjEfzaUr7e+NvStrbIwNHZf9Gz0ka/CEN6EKUdbjr7t+SKZBwvDByhuOa
	CLk99dD5GfH/WXJ3VMklV8aWOoElUgoam0sg4GYonQGmdZZ19rCeeqbxE1M5efxZg7SQRhkqBtF
	pP6kesoJdJKdoliqZdTdxgk/rI15a+CD6EOtLznCDz7VMM/q+zDsE4V0/ImaAUdtDQFvd9c8+Hd
	/lqIjPIMSqfgmAxC0ZUq0fZCSiDNVgPbofxyyCRD9M1w1uXRn/gKnxjU3xdGwjWy0Gps
X-Received: by 2002:a17:90b:384c:b0:329:e708:c88e with SMTP id 98e67ed59e1d1-329e708c9fdmr18453340a91.20.1757077636179;
        Fri, 05 Sep 2025 06:07:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOWdaNrn1TEaOULcrKSkZdESm8pCYoEw9CzGYfoVI1gFXNQjbHfv1K5YlHjOSkq90MCHN1Fg==
X-Received: by 2002:a17:90b:384c:b0:329:e708:c88e with SMTP id 98e67ed59e1d1-329e708c9fdmr18453243a91.20.1757077635494;
        Fri, 05 Sep 2025 06:07:15 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32bab2022afsm3689920a91.2.2025.09.05.06.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 06:07:14 -0700 (PDT)
Date: Fri, 5 Sep 2025 18:37:07 +0530
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH v3 08/14] arm64: dts: qcom: lemans-evk: Enable remoteproc
 subsystems
Message-ID: <aLrge0QLmApr881B@hu-wasimn-hyd.qualcomm.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
 <20250904-lemans-evk-bu-v3-8-8bbaac1f25e8@oss.qualcomm.com>
 <055bb10a-21a6-4486-ab0f-07be25712aa5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <055bb10a-21a6-4486-ab0f-07be25712aa5@oss.qualcomm.com>
X-Proofpoint-GUID: OFONDEf-CUqahn6Vt_C4sppGnLLAw7hw
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68bae086 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=CfLhDO45pqEqRx8ihX8A:9
 a=CjuIK1q_8ugA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: OFONDEf-CUqahn6Vt_C4sppGnLLAw7hw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfXylDNo4NUJcpB
 MBRdekiYAc52/r7j9hhGtGJcEH+T3YHiA8ya6P0Njrz2vy5sTD+DSBItLSGrX6D7Yacxay4Mj5F
 01awBJA2wKp7NlNVdXQP0CLD3xWyo6mJjCfBW7IM4IBs6l4hSzN8+B/qSHk4S5eg8py2SM9Xmz9
 YT/J0PVRQld5ZO2qI8J/eXNoaDNHelYhHJTTncwyaVWZk91H7PrQhq5poGLLL6XsQqJOY0y15HF
 wCRvSc615CprpiH5KZJFfx6j7POPezIiX4dG5o+fXT6nRytMlXulkdBxZo6ukBccPkns8L30Rwf
 39vUPKlfVmlbTu4TDSo3Sxlg6qY3MAQWJb1KDpZPz+xi6GVKgc4LbYjQ5MgdIo6IpJB5AZx43xh
 GRNzk6vv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

On Fri, Sep 05, 2025 at 02:46:46PM +0200, Konrad Dybcio wrote:
> On 9/4/25 6:39 PM, Wasim Nazir wrote:
> > Enable remoteproc subsystems for supported DSPs such as Audio DSP,
> > Compute DSP-0/1 and Generic DSP-0/1, along with their corresponding
> > firmware.
> > 
> > Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/lemans-evk.dts | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> > index 17ba3ee99494..1ae3a2a0f6d9 100644
> > --- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
> > +++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> > @@ -425,6 +425,36 @@ &qupv3_id_2 {
> >  	status = "okay";
> >  };
> >  
> > +&remoteproc_adsp {
> > +	firmware-name = "qcom/sa8775p/adsp.mbn";
> 
> Are the firmwares compatible? The current upload seems to have
> been made with Ride boards in mind by +Dmitry
> 

Yes, these are compatible.

-- 
Regards,
Wasim

