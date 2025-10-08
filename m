Return-Path: <linux-kernel+bounces-845214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B27EBC3EA6
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 10:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B33419E2DC2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 08:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F814A33;
	Wed,  8 Oct 2025 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k2UcBihO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB0F1DF247
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759913346; cv=none; b=a+UnblOBVrSuZN9ZZJmRsLzDycvxVN5uvcoZol5dEpErppvU4xN8/YbOxzwU92JDvW0oQOZ0jsmmr2Dtx8hkdq3gSX0ThWA16YTwOAlOe5udDlu+IoWKlKR5/dWuqSdUrMCYESwUd0He94yg569ujm9DHSGkMssBO7n1+R8VoI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759913346; c=relaxed/simple;
	bh=7BfBSZDHZvPKSGJGNS64jbWWiaNwxlYfIpEdJGGrQ1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ktl/0uWbNWt0dETbgT8qoUCI8aIxtrrpx3u94y0S8UMWoGzK8XlmbbwDbHB1xGuPuagUX2+c7tm49TbMwC+NOuen2lRoZtB7W66MFYGBXk9sjmkPVzooIkyOQEnEiwLkxPUh1jBqP9FT/FEHEQwH0IOi6clAqrpe5DOEowG75Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k2UcBihO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5987aWku010437
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 08:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G8wKJs7k8BdJDa4iq/XFnFxcY6LibnKFgudA7DP6ZS0=; b=k2UcBihO4PqnesT3
	sSz1/2a3iHudoAPCGKDARqi9bfhATtseXK0z2QUEiMqOdkDKEHm3xtR8Fpb4VgHp
	KHGYJNHejTCAkPLgzVinwzaZLeY7VdST4aflq6iJimvJCzHZRvndwoViGGaSMB6k
	qUEvQ8s2IB4J8QPX1CTe+cQHKUa/CxqbJpJvijFmWuaRL9u2j02YjNfj7mUBIOIX
	HWF/x7NudT25g75tp4RU7+/oHfJXq2tlWrIm37Oy+Qp1HqW1AfWdXlD6E/RaY9zU
	BBqlypWjLALsagUyeRTwoqpx9UqaaqPjTgrGynsZ6M3byrZCD8qMJdY+/tg9iaqT
	+gp+uA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49junu9un9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 08:48:57 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4dc37a99897so18468771cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 01:48:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759913337; x=1760518137;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G8wKJs7k8BdJDa4iq/XFnFxcY6LibnKFgudA7DP6ZS0=;
        b=Ir6zaWX4lfAUN65qSPapkHxS7wKGwDj0t/zag3yfnLTdJDruPvQcu5adgrWkRTYS7r
         G3GQxj3ueEyFFdl2v0Xpul8qW7MjdG6JcyZYsNqa+H/JeygdApITDbmB1T9HMVrfhVAR
         DorTpBn0a3T9LKv7w5nxitwGIXoHucLtU4RmvpqLj+SMeno639a1qDWVZqQqgNSKEVEm
         FaOwNbAHCSJisY3jO8Fla174xr2oG5zuXtxPRztvtsepI1NQZz9PKNkL4JOUgGkPpP3h
         vSGo4wsKQIGBd5nCEoiA/JQ+KAMccZ36OZiMO9DLJH0hZrP0WU/de6PD43PmTBFDEpmt
         ofmw==
X-Forwarded-Encrypted: i=1; AJvYcCWyakYL9y9Nacj652WUW3jZfWTAvzznncOR6ofJyd8YHqa84AqvwfFwug/o3tPsVrJ67P/nGKnl3wZP/os=@vger.kernel.org
X-Gm-Message-State: AOJu0YwozXFp69vwkRWLrpAgAXnJa7YqkYiBH4jDpdUogbpsnU/yQpR+
	GV7wdMCKTh5ZYLYrlDqSR4t8Qkqnsp/0w7doyy8+atyKAVWX49DZ3Q9mWJ4m4ahr/XAoOZuEhT0
	6BbywrkxU0yEtEoULHbZvKnfeuNVIHkiVCYiZ44YRPQe5MIGTAVV2ok4Oi3H7Y4LrpPw=
X-Gm-Gg: ASbGncvZ9dvbxibld34XUuweiat/KcO7f0AlA3NFHESCZjVuKs9rSWaaQNHDfvDouSF
	CGrcJd9Zb1hm4gR7iQ1kNx2bgFC1qQssy574nB2Bqhf5zSFw1/iG5x2i8wVKQ4VF5QRffiXKzBV
	o1CDY/0/TmjAtOyQrcuwXvc0vnUIn4BvAkfWJ84viMRHhue7lYDAb9jxPfH/ahyfEH3nravQ1eT
	pdcLHCxcWuIkK2Gniel7lBO3QXaUd75J7cYO9G6r2t73TINbZd7nzcQP4238l6hrAd7jxyQ6Slj
	gHyqDgnp2Q10d5XLwfIYg54aAf+XZB9M9D3iieX0wD75thy+OunFRk/XayD/Ztfls9unmuYBtMl
	wbtbDP5rVXr19RIl/x5nPhLh8qSI=
X-Received: by 2002:ac8:7d01:0:b0:4d7:f9bc:2057 with SMTP id d75a77b69052e-4e6eabf42dfmr24908621cf.0.1759913336790;
        Wed, 08 Oct 2025 01:48:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsCSe7n0ysQoCqxTpSE7/nf5Ci/mBlv5y0BJyPNF55pdASGC5ln6HklotZH+fpGWKqoE/HYw==
X-Received: by 2002:ac8:7d01:0:b0:4d7:f9bc:2057 with SMTP id d75a77b69052e-4e6eabf42dfmr24908391cf.0.1759913336234;
        Wed, 08 Oct 2025 01:48:56 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63788110de2sm14260231a12.35.2025.10.08.01.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 01:48:55 -0700 (PDT)
Message-ID: <39d07bf1-cead-449f-85c8-4651e5296cd8@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 10:48:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm64: dts: qcom: r0q: enable hardware clocks
To: =?UTF-8?Q?Eric_Gon=C3=A7alves?= <ghatto404@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250920014637.38175-1-ghatto404@gmail.com>
 <20250920014637.38175-5-ghatto404@gmail.com>
 <d16e8c07-6c10-4c91-9bbe-a260f0497d29@oss.qualcomm.com>
 <99D0B281-03A5-447E-A6BF-892C99829D0B@gmail.com>
 <c21a408b-ec4f-4de8-a9b6-ca25410ace6a@oss.qualcomm.com>
 <CC2BFAA0-7E61-4D91-B369-88EC9AD4A315@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CC2BFAA0-7E61-4D91-B369-88EC9AD4A315@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Q1KhSBSiLWQ48kFLb2bbGup9ZzwhWhcp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMyBTYWx0ZWRfXzhnNsOvYkli3
 4+WDAWKEFXwnVmHfYJuhMf/zbP99r/HIVH7/VY8DLjmwKbUlMDWC+TRPBlv+zL6TWyDi0TVo274
 tYT+ixPLPcNRo8yc2fzEM9dnBO7sLITomj55C4X3pi7lq/qE9LZjanZCU4j6KRTrf7XtSBYDEL7
 sLWRKFgYTtBAzxzZXuAiUdz+4VcoJpkJC5fYJP2OHQsUaBPHrPu6op0j1KxfWmbqOLrpR8uxh1f
 SW4BPGn5S3VL4iO5dKNsDprJBnQOwyv5h3LSbLcDaJ4FEr6lshuK0Ez9OjTOPGCMtg0ldaMJGEI
 KIxyc3K7J68+pSZmcue9SMaI5UMNuNkRCmqC0/INuFcFMVAUovLB5WPHsML2q73wK00UgX6WI81
 qFWENiqpiiHd1pJ5A0HXKU917ZS5HA==
X-Authority-Analysis: v=2.4 cv=CbIFJbrl c=1 sm=1 tr=0 ts=68e62579 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=wKFhJIuLoAScDjwq2nEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: Q1KhSBSiLWQ48kFLb2bbGup9ZzwhWhcp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040023

On 10/6/25 5:49 PM, Eric Gonçalves wrote:
> 
> 
> On October 6, 2025 9:31:42 AM GMT-03:00, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> wrote:
>> On 10/5/25 5:50 AM, Eric Gonçalves wrote:
>>>
>>>
>>> On September 25, 2025 10:09:48 AM GMT-03:00, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> wrote:
>>>> On 9/20/25 3:46 AM, Eric Gonçalves wrote:
>>>>> Enable the real-time clocks found in R0Q board.
>>>>>
>>>>> Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
>>>>> ---
>>>>>  arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts | 15 +++++++++++++++
>>>>>  1 file changed, 15 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
>>>>> index c1b0b21c0ec5..c088f1acf6ea 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
>>>>> +++ b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
>>>>> @@ -225,6 +225,21 @@ vol_up_n: vol-up-n-state {
>>>>>  	};
>>>>>  };
>>>>>  
>>>>> +&pmk8350_rtc {
>>>>> +	nvmem-cells = <&rtc_offset>;
>>>>> +	nvmem-cell-names = "offset";
>>>>> +
>>>>> +	status = "okay";
>>>>> +};
>>>>> +
>>>>> +&pmk8350_sdam_2 {
>>>>> +	status = "okay";
>>>>> +
>>>>> +	rtc_offset: rtc-offset@bc {
>>>>
>>>> Is this an offset you took from somewhere downstream?
>>>>
>>>> Generally you *really don't want to* poke at random SDAM cells,
>>>> as they contain a lot of important settings (incl. battery/charging)
>>> From another sm8450 device, I'm sure it's okay.
>>
>> That as an argument alone doesn't sound convincing to me, since vendors
>> also sometimes repurpose unused-by-Qualcomm SDAM cells
>>
>> I actually found a data source internally and this cell you're trying
>> to use is reserved for PBS (see drivers/soc/qcom/qcom-pbs.c), meaning
>> you already fell into this trap..
> Interesting, in this case then why does rtc still work? And
> how can I find the real cell? It's not in downstream DT.

Well if nothing accesses that cell between your last write and your first
read, it will of course work, because SDAM is just a means of storage

As for downstream/Android, it does not use SDAM at all

Konrad

