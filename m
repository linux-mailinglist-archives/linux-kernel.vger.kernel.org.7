Return-Path: <linux-kernel+bounces-845353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F0895BC48D4
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 13:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 732243511DB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 11:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1702F6593;
	Wed,  8 Oct 2025 11:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KKhtng6U"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60E32F6180
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 11:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759922785; cv=none; b=TlUzUB42w4KMEMAnB14fJ0/QNrb1hpVUfa1rbixE+vNZugC3TNibm28RwIbLThmg/RpQbNH45iL4RPE/X4obQpF4fzahAHNhjVsHbM1AOzU71aTd1mwCCsVpWCFXWeXgj9LuRw9q5RXb+AUcESAdDTiUMB8d1jDAuJLLTrnWXfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759922785; c=relaxed/simple;
	bh=zmQqrvSLVyGIszXxsV+9QQQ1xfgpsxVe2UdDesppq8U=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gDme3UPVc4Eg4IKk4UYbVrDg+IcyAK1FnPouOnHjAFhy9nsT2HrTDQNcPlcUUfbBIfLySjP30Q1I69x+BAJbU/bMURM22Q72Vn97vmaCWoh914Iwk5M/PLBk7LquOdCMiLCyEaU6YSHhV2VJs1W1KOSgut8OmgdUq0M6Kkog484=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KKhtng6U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890OVZ028852
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 11:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9bAEHpLRtg7/7iLS6JiIyW6dZF5yK9pmMVgvxBMFriQ=; b=KKhtng6UJp/9yUUa
	OUR4iMwhNJmqwqxN+uSTFbU4u1SGQAdOSwBgZ1pBca9+Rkhoillod9cwkLya+y61
	jmn7NBH0Cz023FZIe5xmierHyfXLYdyzpDaxixVrp8oi8Inndq/1oR/8JtZnHXAt
	QypxdZBrdofa1t5B2/RUaWNypaxvvgwbvmGEIgjq5droyrPgvq1ASwnvMg4GoWmP
	qVMdTxSbT0J/oN3iTUh0FPSH86GztFa0D/DTYbZhDB3ymhJlbVwUNLhaRPYplO0O
	NlSJ/z1EfYHuxlfTSBT5f5k5Cuyrx75wxduacfIOlsLks9dFMKU8Sx/Ssa7LmdZb
	2bQxyw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49js9e2dqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 11:26:23 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7810e5a22f3so12895979b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 04:26:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759922782; x=1760527582;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9bAEHpLRtg7/7iLS6JiIyW6dZF5yK9pmMVgvxBMFriQ=;
        b=KTYyUWOmdx8KJOfIVuqkrkrWfeypZ4M4zGhwAJnhg9lpLrYDhn9dtIBkItbbhzbYPh
         kZySXNmGuxNdQeoZnl5Y575vYJ3WxDQBwdNM2URBfDDCaardmW8RL+arTRGEp1JAa+Tq
         H/HlYauKmb7QHtX+49y+HzZI/8MKV1Q4i2Hy07NnhjbI9AHUipBaPDbn8dq+E1LGM2Qo
         9oF5Gaqi2EYzlt60e/MJ98ObsdCroEbAa4C2fFhKr8hfKHNRRRwexPZsmmr3IW5EcX6/
         rGEkWXebvy20TG9cAm94rhzlMN32GxCcXsHB/zUsZrtSDObR0M/O0Tr3iScrlk/c6z2t
         UU1g==
X-Forwarded-Encrypted: i=1; AJvYcCUbDPeDZ3wZXNqb1HFSy9Yoqru1oD4JeR6tzwKTV21gi7QsIvS5q2sQnHIQJc+Ato/Bu2MWzBS3+vdRvng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvCkxRQYmilN83Du3D6Qi83njOCy3eYL064B2GpuLq2NzKU+1I
	ZGuXarR3NUXy+r4W27vxu1hqBkzTaE5cWfve3v2d79oMmp7pzkzvlowIPldWapX+v+KHALsMVRN
	lWafQQNusbq4UMKcsGdbLvBZ6F/MSF05f2Qo4Uzdki+KCopOMM70VfeidyaFnD20fNs4=
X-Gm-Gg: ASbGnctGwIXrKYHToQTOQiqWfedpgAYEbDzEHgIxaaf/NqFwDzz0jwrCiIu08HUHpyq
	/uP8GrySS5MTTzgVbp/aiD8WZWKPNq2ja/dcu7fqH/reC2aJPTeRWi95Tm60MMPSo17elmYVP4Q
	Kc69x/Se7Yt7zxMB4/f81p/HSMywsTq0tTlvt5GphvSWcy9fjRYwhh7hJ/x+N8cQxNiJTXEEHiG
	NgdfPDi/bIViw4VAug16wAdghpOiRKd9tF323fXdAjCFOahXtf7QBPV2Xjs0rhlP1c7y5scOyF9
	eFJc6sWMn0wY5+BfHyLmtisD+cGuw1I1GX0/JfqFjrwjd4nAFo8EwWOGqgqPjIyPVeSGTK25Qwo
	aeSk8NvlFBXAX8pbqrfQl2qR4n8t973TXDECPmTCJWH4/zoOYWNfJDtoW15t1o+U=
X-Received: by 2002:a05:6a00:2e96:b0:781:2290:e7e7 with SMTP id d2e1a72fcca58-79387146b8dmr4069704b3a.18.1759922782020;
        Wed, 08 Oct 2025 04:26:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwkCALuNVCYFwP3XEP4gTbIwLjt69B5Q1k2f0+ktcAs8HwYgmPvg3v5458J4vNacVtt7Pg6A==
X-Received: by 2002:a05:6a00:2e96:b0:781:2290:e7e7 with SMTP id d2e1a72fcca58-79387146b8dmr4069667b3a.18.1759922781561;
        Wed, 08 Oct 2025 04:26:21 -0700 (PDT)
Received: from [10.79.195.127] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9dadbsm18532948b3a.18.2025.10.08.04.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 04:26:21 -0700 (PDT)
Message-ID: <d7125f03-ae6e-4907-a739-840b68593804@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 16:56:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Subject: Re: [PATCH 02/24] arm64: defconfig: Enable Glymur configs for boot to
 shell
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-2-24b601bbecc0@oss.qualcomm.com>
 <wzhfv4v5urehjjlldsdznrnv244pdzpuolofalvj3cerscipch@7gkb5dvjwl4i>
Content-Language: en-US
In-Reply-To: <wzhfv4v5urehjjlldsdznrnv244pdzpuolofalvj3cerscipch@7gkb5dvjwl4i>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Hrl72kTS c=1 sm=1 tr=0 ts=68e64a5f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=oJttokzAQODEBWIVO_QA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: txjtiDzwYXn-pMn8sggODDZkwmspCvD4
X-Proofpoint-ORIG-GUID: txjtiDzwYXn-pMn8sggODDZkwmspCvD4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwNCBTYWx0ZWRfX8H82kkBvOhP1
 01028WhbrmiGxe6NhEtRvKsORBl27vg0VTkhA7okNcPJGz0UV5qOlGkMlzkrQAQ8ZAKkYZvZ38J
 HNUhlL5HZ3dObhFtnf/hjiqypcN7mB06yB/fybWDB6U6mX/01fci40ZIjDLuWLNhfA7d4Pfv2MF
 qYOYljSPQu7EA/FSWy6Xi61JtyC+igqLOFotJP0CcBv/uGmnozpgO3/wgLnTumRMuFCioqd3sxx
 HmstrcX4pAvqtaZnX3WsPVTL1tumrMnvnLj7sWTWVxXqM6A6hAdeFVGbtdfkbguCdHUGdfA+MME
 eo6QKz/LIOQvOiayYa3Y5HjNrodppwwhKkI29JAESJJd+dQbq//nfebnOr92Mg3CB9ywDFkiuPN
 PidJ31uOYjcZf9AUR24Rhki+SGpVIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040004

On 9/25/2025 11:01 PM, Dmitry Baryshkov wrote:
> On Thu, Sep 25, 2025 at 12:02:10PM +0530, Pankaj Patil wrote:
>> The serial engine must be properly setup before kernel reaches
>> "init",so UART driver and its dependencies needs to be built in.
>> Enable its dependency clocks,interconnect and pinctrl as built-in
>> to boot Glymur CRD board to UART console with full USB support.
>>
>> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
>> ---
>>  arch/arm64/configs/defconfig | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index e3a2d37bd10423b028f59dc40d6e8ee1c610d6b8..9dfec01d347b57b4eae1621a69dc06bb8ecbdff1 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -616,6 +616,7 @@ CONFIG_PINCTRL_IMX8ULP=y
>>  CONFIG_PINCTRL_IMX91=y
>>  CONFIG_PINCTRL_IMX93=y
>>  CONFIG_PINCTRL_MSM=y
>> +CONFIG_PINCTRL_GLYMUR=y
>>  CONFIG_PINCTRL_IPQ5018=y
>>  CONFIG_PINCTRL_IPQ5332=y
>>  CONFIG_PINCTRL_IPQ5424=y
>> @@ -1363,6 +1364,9 @@ CONFIG_COMMON_CLK_MT8192_SCP_ADSP=y
>>  CONFIG_COMMON_CLK_MT8192_VDECSYS=y
>>  CONFIG_COMMON_CLK_MT8192_VENCSYS=y
>>  CONFIG_COMMON_CLK_QCOM=y
>> +CONFIG_CLK_GLYMUR_DISPCC=y
> DISPCC should not be required for the UART, it can go to =m

Sure, will mark it as =m

>> +CONFIG_CLK_GLYMUR_GCC=y
>> +CONFIG_CLK_GLYMUR_TCSRCC=y
>>  CONFIG_CLK_X1E80100_CAMCC=m
>>  CONFIG_CLK_X1E80100_DISPCC=m
>>  CONFIG_CLK_X1E80100_GCC=y
>> @@ -1641,6 +1645,7 @@ CONFIG_PHY_QCOM_QMP=m
>>  CONFIG_PHY_QCOM_QUSB2=m
>>  CONFIG_PHY_QCOM_EUSB2_REPEATER=m
>>  CONFIG_PHY_QCOM_M31_USB=m
>> +CONFIG_PHY_QCOM_M31_EUSB=m
> Is this also a dependency for UART?

No, it's a dependency for USB, commit message mentions
full USB support being enabled

>>  CONFIG_PHY_QCOM_USB_HS=m
>>  CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=m
>>  CONFIG_PHY_QCOM_USB_HS_28NM=m
>> @@ -1718,6 +1723,7 @@ CONFIG_INTERCONNECT_IMX8MN=m
>>  CONFIG_INTERCONNECT_IMX8MQ=m
>>  CONFIG_INTERCONNECT_IMX8MP=y
>>  CONFIG_INTERCONNECT_QCOM=y
>> +CONFIG_INTERCONNECT_QCOM_GLYMUR=y
>>  CONFIG_INTERCONNECT_QCOM_MSM8916=m
>>  CONFIG_INTERCONNECT_QCOM_MSM8996=y
>>  CONFIG_INTERCONNECT_QCOM_OSM_L3=m
>>
>> -- 
>> 2.34.1
>>


