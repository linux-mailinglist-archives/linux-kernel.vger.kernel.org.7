Return-Path: <linux-kernel+bounces-879625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4433EC239AB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1377F3AE2BE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F56A2E62B5;
	Fri, 31 Oct 2025 07:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I+zic/XK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZnZ8p63t"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F1F2868B0
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761896848; cv=none; b=Pe0VEms799+mjgD0EdlUKOxiVbqj4NO/4flXt93BMbvShsDJZLwbXGIIheo+nBYPL9KHc/xpoyVlrI7im7FWDY0zj4cZwoWteOeWGXWfKdsFoDKC/yegjImse1WwT3ahGF9E7gQIqhDZ6hQCN8nN65nom94jfJseaQI8Cslck+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761896848; c=relaxed/simple;
	bh=/8TrqVOKuqZOnd4iu/m6xVRRaU9USAIqMhVGeVGdvJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nEqBMgLKWTTfS5AbxG7THNn68vylwDA+eDHxaivWVSXX1dMejHJ2aps3agXnV323XC3V78oPNqqM8xsmlJ/whta3q1TaD7JleD8F15Rt1C43C2D8exSO2SFaiDHXuATSJoIYuh1mMuWs3pIAzTI0xSdY3gufPXYdAUMn2fH2nsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I+zic/XK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZnZ8p63t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V73HAK2058259
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ElQX51HCLZGHK8sK6/6r6fFyIPtOhGLYhgQkqsOGOoc=; b=I+zic/XK/3Dch8UO
	bMe/e9MaOWivZEwS8p2lmAwYyR6IzzajSdcS3/ll2Up7ojOGinvHDdKo6BnP7uQx
	sR5Cx7mQjSgyJHL1onxABIkRO8fVoyp9sJmXEwQzI1iU2ggQFZKvlvXyOywg2zc3
	W37Y0LnlSyIfr++jbrdf+2iqst1RC4AnIPGzoZjdZi5GxLkk0cUTGQTGCeZF2/li
	usO9JEVXHM6e2StJ5ur2pxbNQiSkutL+iUTg38r/Knar+ti+2LmrY3YOs7/I1913
	zQvkAAVJOKS5hMIV+6qg4ig2UZ52pX7n12PFTszZEcAkjZ1XmCeAkG7wMAcG3mJZ
	gi9wTQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4rcvg3cr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:47:26 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-340299e05easo1892999a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 00:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761896846; x=1762501646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ElQX51HCLZGHK8sK6/6r6fFyIPtOhGLYhgQkqsOGOoc=;
        b=ZnZ8p63tj0ZJlDomD2VUhCZXwWdxAHHS4yuCpD/Cv5nqNnPbNafo5ie6KT5zPHjX76
         alzqyBQMJSv8dtntrfnzxP1RZbSM9iRlRNTDPOqeaZ0649EA44dMIJ5wLa+HGgmdqgCP
         mtd8GWAD+NlzuegGJbdJTaTJRVcAPWa292EBEQvGiv/LNAuy5WouxI1zy/f610QjckTX
         eAEcQ90AMGeNwl/wG7sSK7E++8Nmwd9/wfMCGihhY6gxH3up6vq0x3TwNvZ4mxf3el7o
         3qjINIatY0bxI807XkXJoax1M4EWQH4eH2RkTmMf+0M96h6yGRaX159xMaQrYgwlm8it
         5WJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761896846; x=1762501646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ElQX51HCLZGHK8sK6/6r6fFyIPtOhGLYhgQkqsOGOoc=;
        b=sW7ZfOuDoyJoGWVNaJdV2s1ZLIdr+PWIpMViyu1yYG4Z2GDydG59REg7iT0bZpcRo3
         Denqjvn+fuV0QvMCjKF4bmLlHsWz+yORLkXM31EHusEzOhjN/NqGwW3gTasPSQHD1IBM
         dMiUmMwqM7mGxSuPtRtqCFtXiLyVwnwABw59dNsIPZMKtAYQZCP9rOG/gZ8MJUYjSTPe
         CkdGBB9wzURl2Qf8Dbf4nX0kwChtaw67E+UIUmkhPJgPniw98BZUP0bcweBksOFCzgma
         hVg3PbrpfdqNvKsGHSVGlpXDfgoW0lmtQ8rm2Lgh72AlHk+1KaPA9Mns4SqQTcCBF2Qc
         nSDA==
X-Forwarded-Encrypted: i=1; AJvYcCUroDCJytqcmInG+2V1BrC0oDJflcTgYwFlKXV+Pz4dKuSRXdxhv5fcxWJ7iNDbec8CntTaQjwkLAaOCq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqUBMyET5KuxGDFE0Q7dtr1K/8QFtWb+hR3tkI3u3sjm7GeJg5
	qsst4yBwJ7ikTaMyve8oJyiBgiWjp1zcZg0OuPXCCmzJF4rGHW1i0/+qPDbmQ4hvUJAWQb0VNuJ
	3hQ4TBkBPOA22FdExv6uJkcfuJ0wj2+NVsfHl55TqnFbs9yfScAwL/nmVCKZtZkyyAFY=
X-Gm-Gg: ASbGnctxlLb1VP0zImsqEsIbpP4LxjG2qMTWM+CA1HkerViosWQxLFoFW4ZAw+MTB4N
	sLF8bJ6eyugXnUVqVHg477qkiseE5LKpo4f/MReR830k7a6QVhxzIDZyB2gpZkQXvXTsg2r5ZWe
	cuzINWI55zci5qG26PJw1js0rToPyh2fvc1gx8+emFlurICfVMFzEAzyuTdHlLTvW2d+PUla3UQ
	m53GCW3HtusTNzMhAQJrSxZdOrwk3sx5zVddqYEtHp85fA8UouqY6GrpgkV/ptzIzZ2Fh63ZCMN
	1Dg9TM7nL9qN1Uj+Gb8jCLGPnVTFKND/MVAfncB60c8qxbMYEZHXkKed2Rq36ObRK3vxAVF6cAe
	1aDhEJsEgBfpNmOY1uqFHLBvNBqyMldv6mg==
X-Received: by 2002:a17:90b:3fce:b0:32e:52aa:3973 with SMTP id 98e67ed59e1d1-34082fc932fmr3833635a91.8.1761896845580;
        Fri, 31 Oct 2025 00:47:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQVBJuvCo5/hatKTvNGJuLoUUgkps0P3BQUlziGGX4u7kohcIQyss6ZSPki1VFt+9IvtDaWw==
X-Received: by 2002:a17:90b:3fce:b0:32e:52aa:3973 with SMTP id 98e67ed59e1d1-34082fc932fmr3833614a91.8.1761896845117;
        Fri, 31 Oct 2025 00:47:25 -0700 (PDT)
Received: from [192.168.1.3] ([122.178.56.191])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34091b48934sm1244591a91.0.2025.10.31.00.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 00:47:24 -0700 (PDT)
Message-ID: <125f4812-e333-4245-af54-f693d01bd534@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 13:17:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/3] arm64: dts: qcom: sm8750: Add USB support to
 SM8750 SoCs
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20251024151521.2365845-1-krishna.kurapati@oss.qualcomm.com>
 <20251024151521.2365845-2-krishna.kurapati@oss.qualcomm.com>
 <eczsb4xsrfowfalgjaoy7azkrriitaietkjjkl2smceeasie3j@uc5ynursx3ot>
Content-Language: en-US
From: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <eczsb4xsrfowfalgjaoy7azkrriitaietkjjkl2smceeasie3j@uc5ynursx3ot>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=bJYb4f+Z c=1 sm=1 tr=0 ts=6904698e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nBTQbq2h+7tEuhtSPO5ERQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=RHaVzu8l3JqjrsztCWoA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA3MCBTYWx0ZWRfX5xXp/JiYjS+z
 JwC/hZXaTTGDsJiFpKCVcy4d4KQw6Yg1I6MnGt1ojpLgD8e498cskBovj8GANfkkZF+svNxMsJO
 YvKS5wy1S1EL25byGPW8mw+s/o9eQz/d6ia118btkOARWG3ewoiEGkCWkxLIPA5Ez6K8PyJe1wR
 bQvNkvfGilKvsgffpvxBbHlwmblMoQeluSsVOCIkfC5NXdwBjikyuRL9wfA9h+Rra5M8mz1hU8N
 0LZ8XtuhyKID1AoHASpdI5IPUu/n9nW71hlSc7YRFQQnJCgD/JGCsqKFiG05BwGnRdVpYBiE16b
 fWqPlUmAE5fEtIb0QOnU9QbCuWw9eNT73A+gwYvM27zZpde8l1XSxV7E8GgkyCJdDuT3OjARnNp
 oA8HXM4FsjTonLo0QG7FBx2hw6OtAA==
X-Proofpoint-ORIG-GUID: F6ruZ88CzJBbpZaMea6KD3p2_-lCuKTe
X-Proofpoint-GUID: F6ruZ88CzJBbpZaMea6KD3p2_-lCuKTe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 malwarescore=0
 spamscore=0 suspectscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310070



On 10/29/2025 2:44 AM, Dmitry Baryshkov wrote:
> On Fri, Oct 24, 2025 at 08:45:19PM +0530, Krishna Kurapati wrote:
>> From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
>>
>> SM8750 chipset contains a single DWC3 USB3 controller (rev. 200a), SS
>> QMP PHY (rev. v8) and M31 eUSB2 PHY.  The major difference for SM8750 is
>> the transition to using the M31 eUSB2 PHY compared to previous SoCs.
>>
>> Enable USB support on SM8750 MTP and QRD variants. SM8750 has a QMP combo
>> PHY for the SSUSB path, and a M31 eUSB2 PHY for the HSUSB path.
>>
>> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
>> [Konrad: Provided diff to flattened USB node]
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8750.dtsi | 158 +++++++++++++++++++++++++++
>>   1 file changed, 158 insertions(+)
>>
>> +
>> +		usb_dp_qmpphy: phy@88e8000 {
> 
> You also need to update gcc clocks properties.

ACK.
Will add the qmp pipe clock in the last entry of gcc properties.

Regards,
Krishna,

> 
>> +			compatible = "qcom,sm8750-qmp-usb3-dp-phy";
>> +			reg = <0x0 0x088e8000 0x0 0x4000>;
>> +
> 


