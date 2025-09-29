Return-Path: <linux-kernel+bounces-835766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAEDBA8020
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABB317B1A92
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 05:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BB629C325;
	Mon, 29 Sep 2025 05:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q8AlYXXd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC4A34BA53
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 05:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759124556; cv=none; b=cgCZOwgDDNfJ0ogmlne6CfIWnzeY7a9lofPtLs7OOmCBnK8HUuaSsNGZUf2uvE7HNAJdbsn1I9/d9Y3NyA4FAouD4h8BsoQ3aU32x55RRN0vF8Qi7ZniYJ2USpuFqmCFSEnexYB7ukwAsMtIzWLmDbOOsjKiXfG2oWm2V3zw8T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759124556; c=relaxed/simple;
	bh=djbdttzWVeZdtdcCBQG2ls7rum6/KDgqWatmSRYyy9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lFa6gHoqh/s9Cw6omg+aHPeTwslKmlRJMvtwL4OcCLxOVTE/F8o5pRzrDLTdT7Bqten1ZuQst4D8I8ULpwTV/c3xWtERlPr9lfztDi027bQWq/EaZeHZJDIeIzjFZw/GKRk+wF4qeyVA+U0Np7kD2Iy1SIPMzOpLj72hoiqcPnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q8AlYXXd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SMuYpl009061
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 05:42:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rfBzbpwct3yDDq36E8SAQ+hFmXrqjfgGSlZ22u0SUWo=; b=Q8AlYXXdoNZAjB2q
	TEw+Ewb9XF31iytwBx8jZKR3L4h+xeL2pVn8rUmUwIk52sxlPtTL2ppJ6MIO0tsA
	pM2ZpaR7XomqPrculQZd8FYRUtavCio+xHdB5VFXgpaZRPB4RgWzgXJ3cz2YDZJk
	pY6U02VJK4YlXk6Kh0BPl3CFdRslagBhrQzLI9Zlj/Ks5aOBUDp1XNrpxAqchKnr
	pqQYXiDcyigt1JmKqz6A+2MHx0DGm3QKTdXwNL6x137Ih3PXPHUlDBRiEZw2rTp3
	FNBjCJrRX32OgDQy5ifUrXrvH82UaoEHCUZB+KqynpdaRqN1aakmfOc3T5ZSrBAP
	y+wnnQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e7gxkyug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 05:42:32 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3307af9b55eso3693947a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 22:42:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759124551; x=1759729351;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rfBzbpwct3yDDq36E8SAQ+hFmXrqjfgGSlZ22u0SUWo=;
        b=UTp2Vyw0Tuczc+JoapT1+1t2EifYiNvL81DZgYK3qj0Vj0axgKiYtI8i2PhGYEnuu1
         h1sL1tAXhd6UQv3ZxhOZ98xY5KpgZiDh9jkIPZE5xM8vbEi8tQxmNrSh09Mb+76QscHC
         37gPUvDX17t8mwBYSxoXYNermc89ji00jglyJSU+XHGHueMfUM70WfUmRkYRXOHNV2kd
         YrjDdlQUG3RV3yUnl5bYRVv5Kq2Fu1Clg2hHeAmjc7LeD15EpvDYPPMeUqT4rBmcVkaC
         U1qsLwgP1OWXBRpLLVrVq9DWszhxSmtfjzXWYxvABjyKXALBJEViO9KiiWnNZ6YGFbUO
         0CVg==
X-Forwarded-Encrypted: i=1; AJvYcCWwNAA3/vlcXVJ2CqcjnivYVlwZRaog7GkdriZlbqao6VsFTCjjEPmI6uDJ2vH/yTQG//VjjKJXr2aSTE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcXy5bxuEacTOQilyHbmdxulq4dlkGcprR0U3pZHCqQ2SH8AmJ
	YZKr2636XDuAwJRZYd4kOLjgdj0jrhauA+RCOu5WSaWlzVHCfL2WiZfVYxnc8DvfINKQWRPIfgG
	RdcuENIoHlKaD7UD7xiaK4yNHq1NQwZD+IHir+jgXYbyzQfGdG20q/EN6OmmKQHEiKu8=
X-Gm-Gg: ASbGncsCN52FugfbuozZgY+vRzFlib6T+3vxIKACqBjuXLBS2VP+yyj47cBXRgw8OSq
	YXzhHQrJfl18iHvFrAD9NUafLrVoHZLHPHg0UZxJFDe+8iAigKc2ivi/8sXm533a4xFmIbwL+vy
	pJnVxNHzbanKtWuBor8hpVzkcOs2OyWjlqP1XkO/FYsTFnSTiV4orPEUxHCTAaSliN9hF1o6Q1p
	M4DJFpU0QtOD14pIyQMGDm2dhLbD4/AfvPh8LQEGq17gs/WhHaet170VCIodiF3CmxWLrp+yw15
	VnuQ3tf+SpkThhELnP0ixEqon7V3hJ2i7KJVGieU0Ep1kNpqTx0f+kU25ylIrE1m6M/DN1YB/Cl
	KxR5vZfmKumQxUKLw1JoD0S7eMhXa0+hwS7Y=
X-Received: by 2002:a17:90b:1c04:b0:332:2773:e7bf with SMTP id 98e67ed59e1d1-3342a2b9566mr15491882a91.18.1759124551530;
        Sun, 28 Sep 2025 22:42:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcs/k3kR5lOsN+V9n/ODodNKvmnVPplyVbFJ8XSQZMHLdp/E45BWmNDfJA1eXIMQW/p9GKdw==
X-Received: by 2002:a17:90b:1c04:b0:332:2773:e7bf with SMTP id 98e67ed59e1d1-3342a2b9566mr15491859a91.18.1759124551062;
        Sun, 28 Sep 2025 22:42:31 -0700 (PDT)
Received: from [10.133.33.234] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3350256d403sm11124204a91.14.2025.09.28.22.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 22:42:30 -0700 (PDT)
Message-ID: <70241129-1e08-41f8-b60c-b72ec079702a@oss.qualcomm.com>
Date: Mon, 29 Sep 2025 13:42:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/20] arm64: dts: qcom: kaanapali: Add QUPv3
 configuration for serial engines
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-13-3fdbc4b9e1b1@oss.qualcomm.com>
 <9685e29d-bff3-4188-b878-230d0f161ce3@oss.qualcomm.com>
Content-Language: en-US
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <9685e29d-bff3-4188-b878-230d0f161ce3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: vBA7V6IsO6b41CXpxEg4JAFqn8zSmo-0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX6aMUZ/xvpvVq
 33HXFFELi/FlJXDWtwWrovEQudzZb+nswJDFtcZYP7FgvPoyOZE+7J9cS7ft8vq03vNkgGFbMhv
 mSlczMBhitEqoy0sMBcfZcmsxUFXv1sqXPnRVsFSqoJRhPUIa7Ttx1Usw69wDnQMchK6XAQB5+d
 aPwmwPQirFpX9QGTf2v3nV4ZxKwu5bdk2nSrYp9Z4JKEoi1DUg4hefuxC+NirtOX+ch+OnbVdRU
 IxjslfHSfWPi6ndGcMhIpLeyKLWjf0Ad4m25oIbpgdv25N7msAy0Za3w0w0+TwYZqEUx8O3aHqh
 s5hW46cILbJlZuDKvzfI3zKh3MofJ/8Ea4BXHiOaoCHZbjF1XMYMX+xpLbj6sgwQh+1tuSRW3Ft
 6TLzCgG9Mod8DAYgfxlHM+fBIMm1Pg==
X-Proofpoint-GUID: vBA7V6IsO6b41CXpxEg4JAFqn8zSmo-0
X-Authority-Analysis: v=2.4 cv=dP6rWeZb c=1 sm=1 tr=0 ts=68da1c49 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=_ltKwtvy-Tbn6v8TjEMA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_02,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270025



On 9/25/2025 8:28 PM, Konrad Dybcio wrote:
> On 9/25/25 2:17 AM, Jingyi Wang wrote:
>> From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
>>
>> Add device tree support for QUPv3 serial engine protocols on Kaanapali.
>> Kaanapali has 24 QUP serial engines across 4 QUP wrappers, each with
>> support of GPI DMA engines, and it also includes 5 I2C hubs.
>>
>> Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
>> Co-developed-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +		gpi_dma2: dma-controller@800000 {
>> +			compatible = "qcom,kaanapali-gpi-dma", "qcom,sm6350-gpi-dma";
>> +			reg = <0x0 0x00800000 0x0 0x60000>;
>> +
>> +			interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 848 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 849 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 850 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 851 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 852 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 853 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 854 IRQ_TYPE_LEVEL_HIGH>;
> 
> odd indentation (on almost all gpi_dma instances)
> 
> [...]
> 

will fix

Thanks,
Jingyi

>> -		remoteproc_soccp: remoteproc-soccp@d00000 {
>> -			compatible = "qcom,kaanapali-soccp-pas";
>> -			reg = <0x0 0x00d00000 0x0 0x200000>;
>> +			i2c22: i2c@1a8c000 {
>> +				compatible = "qcom,geni-i2c";
>> +				reg = <0x0 0x01a8c000 0x0 0x4000>;
>>  
>> -			interrupts-extended = <&intc GIC_SPI 167 IRQ_TYPE_EDGE_RISING>,
>> -					      <&soccp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
>> -					      <&soccp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
>> -					      <&soccp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
>> -					      <&soccp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
>> -					      <&soccp_smp2p_in 9 IRQ_TYPE_EDGE_RISING>,
>> -					      <&soccp_smp2p_in 10 IRQ_TYPE_EDGE_RISING>;
>> -			interrupt-names = "wdog",
>> -					  "fatal",
>> -					  "ready",
>> -					  "handover",
>> -					  "stop-ack",
>> -					  "pong",
>> -					  "wake-ack";
> 
> Please try to use git format-patch --patience
> 
> Konrad


