Return-Path: <linux-kernel+bounces-583781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D78EA77FCA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 18:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9F03B2487
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 16:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC8920CCE4;
	Tue,  1 Apr 2025 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XJCV28WY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1384F205512
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743523246; cv=none; b=JR1AJ1TgbjciWdaUmM58hAni5dhoLkZd3XZeaSwdZWdz2+cyIpoojMTMxi6AYzr+A5toK1PjqhGezsa06vksx3qXXAaXr17d2WjUCVonzBue/3Nhpd3M0x/2KriamCjfXItbwzeN5tVNEQS/c5LmR6gxpuLbZnS9rULVqvDNBZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743523246; c=relaxed/simple;
	bh=/LM8H4ISofW5iS4fWCpEdxbc5ynRsTwY7+ZDFXlYDrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q5BWySG/1IxPrDryH4qDpdyF8eJkTYOhB7q6d8d7X9/Nq5wiCdpRwzd342OInIgruKbi3ifRqh5G4qfnv0svpIdbOt4XYw/gdY6wpsxDsA4AjNpX0VaaIWmRTFrOflP7DSedhxU4CzwCGSga2uzHeS7nXWKUWps53rb7tPnjcN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XJCV28WY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531EKwjC024635
	for <linux-kernel@vger.kernel.org>; Tue, 1 Apr 2025 16:00:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E8fTZlY2FTPTBgviWZBS2FnhOavhB0dACv9PHWteTzI=; b=XJCV28WYrpJNw0H+
	oY+GbBzeQ8IPoprH9H9wPa7KJpZG9x/jxDO46ZLxeTUhA8QhKs+rD2U+YdBmsxRo
	V4m2iMxmYzqDnu2ty58u894gXzZlghfu8ScMlLt3rxPPtLJDQia7Rm7oJkcJjLdD
	VERNKx37U+Io8h9rdGgTqvGpUW0Zq9/pXy979WcdtgyOnnZnZb/JmNRxsKf1cMKe
	LQ1TffmKnLzqaAguzZiF6yOI4SO8s7ZsL4WESTJ9eYaKEOW9a+yOi58qcgWL0F0w
	ZGYkqobtoRyfgQ1+pTWvmUshLOoiFX+t95ReyV69rb/NyzHj+TBQcZfnD3/skgSN
	cUTAdA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45rbpysm0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 01 Apr 2025 16:00:43 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c547ab8273so29052585a.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Apr 2025 09:00:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743523227; x=1744128027;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E8fTZlY2FTPTBgviWZBS2FnhOavhB0dACv9PHWteTzI=;
        b=j6XsmL/MD+CIJ8QMG53glVOKgKHkAoccwYbOJEofTObI08X23sNQdDtaKgaK9Fk4Es
         mXz++dL46T4LGRLs2z+Zx5qSvFU7OIlnW0JynyokF/am65oOyXDrPBRp6HLBDyhahYP8
         /s7d8iIRCNZgQuNBT+xmyoAA4L85Qoj+eiqRIiC9mgjoHy1tC1xEOloei+V697ue6ou6
         5fyNCrEuHtvxLivzCJLXAHtAUW28yN+KFmS9Oel4lEQYr5AfEWzUk0EJ52FMUAcp0Sw7
         9LLBDz/hF+4cTFrl+pUp8Np24hmd+ROzuUHxD5iJ+a6KvyGNF++WMUCNr/rsrdwOytB6
         RzKA==
X-Forwarded-Encrypted: i=1; AJvYcCVN0XUz8FawnCmee6BpO9RySABBvS8prvAaquq75MTCu1llFPGf4Cy6UsHPp9cIWJbo3zcbksmi6t8c2ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YxayfjAoClYEdJbByyj4/qsfcN5sNJ1ggsiwa4rGygxH+f/OYzW
	m0tk0YYY8CSN/4G96DBUaKfGkwWadM3/J1Jqwag7NQioestJoZAC7TiYxgNs6rfNOxW1E88wOKI
	g8/eD5zOTYueXDLi3IGvIzEgqmg4+1r3uSWxTou/YpsMP+J+JByRse/u57bYrqBQ=
X-Gm-Gg: ASbGncujRVr8oCB7+zMyykWIXazmPXoM4d48oT+HeUfYUl/jraBgdgRwDZ+J8LLMLQ4
	euvcK7YeRZwAm4Mz5qbOUinbOfPmDEkwAAeEq2AawPUCuHQeKvNxBiyzw/qjwL06Xa4HtxHr0ad
	GRfjEGAHygkUqgz1nPkTqfJufyJAKaz+7Dfthky7dOzUbfrQMrjCI0zK5HQeD43UCa1RnrX2Tw1
	vY4D/mkuRKn+BEwiRZwBrNFcj1kW8KmuEMVajwKoyUs1lpbXH/bzDZoIIUsN3WyAaSygNohf6fh
	P8MI6tnLLHKeQy/XtU1qTGSWnK/k4boWo8yIqdIdc5bdGnp44b21Tj4KBKl6C90PIIFjXQ==
X-Received: by 2002:a05:620a:4491:b0:7c0:c2ec:e560 with SMTP id af79cd13be357-7c75cbf574cmr160051685a.15.1743523227102;
        Tue, 01 Apr 2025 09:00:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWPKkqXsYoXi+SD/mNf0LhMLx5EF89OKxRG79X0GRYasz/yOgGPHK/1puUyPh6CDB3BzPe6Q==
X-Received: by 2002:a05:620a:4491:b0:7c0:c2ec:e560 with SMTP id af79cd13be357-7c75cbf574cmr160043085a.15.1743523225210;
        Tue, 01 Apr 2025 09:00:25 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc17dff0bsm7187903a12.70.2025.04.01.09.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 09:00:24 -0700 (PDT)
Message-ID: <4d23b54e-93eb-4c1c-86d9-a70f29c23ec4@oss.qualcomm.com>
Date: Tue, 1 Apr 2025 18:00:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/18] arm64: dts: qcom: Add MXC power domain to
 videocc node on SM8650
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Dmitry Baryshkov <lumag@kernel.org>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20250327-videocc-pll-multi-pd-voting-v3-0-895fafd62627@quicinc.com>
 <20250327-videocc-pll-multi-pd-voting-v3-15-895fafd62627@quicinc.com>
 <12986cda-99eb-4a1b-a97b-544ea01e2dbb@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <12986cda-99eb-4a1b-a97b-544ea01e2dbb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: imnUVDeGqKPMAU3tPTTWpZgQX0zbhWDh
X-Proofpoint-ORIG-GUID: imnUVDeGqKPMAU3tPTTWpZgQX0zbhWDh
X-Authority-Analysis: v=2.4 cv=ZNLXmW7b c=1 sm=1 tr=0 ts=67ec0dab cx=c_pps a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8 a=unI4K08xUKBPFJxB_jMA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_06,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 adultscore=0 mlxlogscore=938
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504010099

On 4/1/25 5:27 PM, Konrad Dybcio wrote:
> On 3/27/25 10:52 AM, Jagadeesh Kona wrote:
>> Videocc requires both MMCX and MXC rails to be powered ON to configure
>> the video PLLs on SM8650 platform. Hence add MXC power domain to videocc
>> node on SM8650.
>>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
>> index 818db6ba3b3be99c187512ea4acf2004422f6a18..ad60596b71d25bb0198b26660dc41195a1210a23 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
>> @@ -4959,7 +4959,8 @@ videocc: clock-controller@aaf0000 {
>>  			reg = <0 0x0aaf0000 0 0x10000>;
>>  			clocks = <&bi_tcxo_div2>,
>>  				 <&gcc GCC_VIDEO_AHB_CLK>;
>> -			power-domains = <&rpmhpd RPMHPD_MMCX>;
>> +			power-domains = <&rpmhpd RPMHPD_MMCX>,
>> +					<&rpmhpd RPMHPD_MXC>;
> 
> So all other DTs touched in this series reference low_svs in required-opps

actually "all" is wrong on my side, please also consider and if necessary apply
the same change to patch 18

Konrad

> 
> Is that an actual requirement? Otherwise since Commit e3e56c050ab6
> ("soc: qcom: rpmhpd: Make power_on actually enable the domain") we get the
> first nonzero state, which can be something like low_svs_d2
> 
> Konrad

