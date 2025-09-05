Return-Path: <linux-kernel+bounces-802744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF8FB4565C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12C334E1091
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4930B3431E3;
	Fri,  5 Sep 2025 11:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S2zS+f7d"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24950270EBB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 11:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757071736; cv=none; b=jf1Tts0Wh1Ea8EKSWjhkDim2/R1Dqg4MOpaJh3zVWn3kwmDtTaC0aMuL7Z7hSjDnO/2bEl8Iw55slVL5aqMUFokWZya2HDa4s+sHeCyveLBobKxBSu5DeCtt4B8izLM2goM7ogxHuYINNqB6uoNjnLK05vrz6gCcOuNaTG29MX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757071736; c=relaxed/simple;
	bh=3ugSzQ8mvx7yn8q1JvCBgipigbi+7LXFxjkVmnr/LK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k8nBN6h+atcDTNkq0vf7UidmiC0nTQKaEKtt3jKQFNpisHosUdPf/ChJKjfvRsTB9+I2QI9IUo1lk3Pozh76rbo2LZJlrERhfOJSzhXk+TGayMkPyDBK839gbDHRv3jrsySBDOcG0MeNTp8wlumLbnnz/wdnd87Jbpbjb9ogtGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S2zS+f7d; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58557J5X017818
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 11:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6doEwX7B7ZWbprEQ9MoiuAdrhDwCLb/kSHRWBeUn8+s=; b=S2zS+f7dm6Ryl33w
	gRwg0Dd74Ijj9Oiq3y604bxa6dXaPtSVUEl4UxRChkbrQ4BRD90kxJ5H6I8CQDR5
	sqxP/cMBUAKZFsMlTQZsoVW64GGckIBflvE4b8wGDQgW7qpIVXmp5TrLid+oQXjz
	CS0foQya7UephyMqG6d2VVD2JF0kOPMx8y2vbN6E3KJkIcG/O8LV8IUML7GBirk7
	Fd3n4D9bNiG9Bsurrp0fWDWfiAXagTM+huY8J8ULPixmkylAxnFk6L0bAf/5Mpsy
	3aYvSm9eFEDpa1qJup/E7P5Vuw7NHP0VXX5h5J4RgFwHJGX01HnVy96sSXggi8QX
	er+R1g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48yebutu9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 11:28:54 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7724ff1200eso1805704b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 04:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757071733; x=1757676533;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6doEwX7B7ZWbprEQ9MoiuAdrhDwCLb/kSHRWBeUn8+s=;
        b=I7y613S/7mgKhFi2Nkg6SsnvG3TSx3FOvXnhYiQ4thDWE5nb6/0tj2yxgNB/jyyPAf
         40Nmn9yEWe99YOY8FHE/Hk/j12XcE9w+c27FQ+vs4RHpn5EJUwbaUBuU87OER5yVIat8
         au3aAfIDnHQy/MpIdfMDxC2Xy940dTt9uGSSAwj7+ray+8W8MuTiXzmEIStBuqGLzMcZ
         ii+YJnMAl/YXJ0Yy5H5Ed+s/YxOv2TMLmJ671JPcNAA+l9VvI7yumsKv06LRW30HuGKF
         UHwAttrhMLK+XiDZ4/xdR3GsTU7HCxnP8ly9UbvwsU6+1ox1pmPzLhoj/k1U7gk0XgEk
         1RNg==
X-Forwarded-Encrypted: i=1; AJvYcCVpNRTn5hbCzK64rJtlMCz5NpclXevSCtH2iPiIqZs9Ed9SZ9LIAriLpkxUAtgzqOX5vGeMUTqfHl1O0SU=@vger.kernel.org
X-Gm-Message-State: AOJu0YypJJi53H9mT7LCNmhdR25KH0o67w4x57TGdMVwRassdXm81iwj
	rLxxdBh6qjotbotJD+38aWSvb1QnA+JqCSPpkr8K763oD+6TUg0ogc2oF6B3z3rfuXPfWHm6ON7
	453twqubJhkNVGWo/6ELh197z02OtotvL2otMFdPJpXV0uiDOSc249r+A+boyylqZ66c=
X-Gm-Gg: ASbGncuXYSLY/ZoTzj48hC0yHRHA7mbCUGbrSKp4JRW3pzaoq5o+dD38Ep6fm006tg3
	oVBAEFSIpWp7vC2sfDKli/PIY9oX/mSetc985F96g9KjhnTgvbfgTUk4sTIDrGFusQgHCLFwmG2
	pHu+Qn36est5rYVgBP7jEHk+GwODxwDTDLa5L6AJGFDp6YA+WRNX7rx3iuiD0ef0teWUjnRFPx1
	XZyMTQp6XMPlkJDfBYEIm20Os5ToOAi1gwBHhW4hAES1pXCj0Fy8bk/6zwmIdYwdVvmRrZAgBgR
	5pozTQ0JhcIBiAWGSdVRgArLb9bfFwhWOcgFWxT2js6sWwCiabNA5txPGDSQGCXBIqSmWXCh4LX
	joRc=
X-Received: by 2002:a05:6a00:3d55:b0:772:260f:d7b1 with SMTP id d2e1a72fcca58-7723e3604bcmr25696924b3a.16.1757071732598;
        Fri, 05 Sep 2025 04:28:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmc040gyAr2RK4dN/YRekXNfa1QiCwtAj8aUqPxAsXMK2YDB2EQlpTKgbizPwP+r6FMgGAKQ==
X-Received: by 2002:a05:6a00:3d55:b0:772:260f:d7b1 with SMTP id d2e1a72fcca58-7723e3604bcmr25696900b3a.16.1757071732064;
        Fri, 05 Sep 2025 04:28:52 -0700 (PDT)
Received: from [10.219.49.245] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26abd1sm21340180b3a.8.2025.09.05.04.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 04:28:51 -0700 (PDT)
Message-ID: <0ecedbbf-4c08-416c-9ce4-64af42f3e215@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 16:58:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] ASoC: qcom: sc8280xp: Fix DAI format setting for
 MI2S interfaces
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        prasad.kumpatla@oss.qualcomm.com, ajay.nandam@oss.qualcomm.com
References: <20250905104020.2463473-1-mohammad.rafi.shaik@oss.qualcomm.com>
 <20250905104020.2463473-4-mohammad.rafi.shaik@oss.qualcomm.com>
 <b321019f-3ff6-4c6b-8285-77ca291492a2@oss.qualcomm.com>
Content-Language: en-US
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
In-Reply-To: <b321019f-3ff6-4c6b-8285-77ca291492a2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: CdH2t4Pr0g1iXHVcrUpCmuN87Wp2n8CS
X-Authority-Analysis: v=2.4 cv=X+ZSKHTe c=1 sm=1 tr=0 ts=68bac976 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=drAcfRgjDz_GiM-E-9oA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDE2MyBTYWx0ZWRfX9cCYF7/o7aGy
 YrYGBeGw8ppSuVfgwDhF2SWrre8Ix0cgt39B5Szb4MrYp/YP9chChJD36xvSG9ZnV34pXrtn63u
 q7OQEB+RZkHF3OeeSP8pGrCzeN/yHHFrMjYJuV6s5yn79pga2z34dCLsc6ADw5Oyo7TNV3/OkAn
 pa/XSOVmH/9NAeZYcmao2VgUs6JRn0sOT636+ZjNf/ryLZo9N5BwB5Gzj0GvmEVaaGN9fu9Ysar
 vLT49uxRCkpY/MgpGLzNf4GQZOLPVqyIUadYPTMVn/fd8GeNxH7nr8PaGMGpXBHm+Okx9rPCYqp
 tC5w9mWVgii2tYC2OmmWRIUtpcbXDXi5HXBMfpjSxBx6T076h7hRFwTYen4V7YGKNWw/cN7Fc2k
 9an9mdAT
X-Proofpoint-ORIG-GUID: CdH2t4Pr0g1iXHVcrUpCmuN87Wp2n8CS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509040163



On 9/5/2025 4:16 PM, Konrad Dybcio wrote:
> On 9/5/25 12:40 PM, Mohammad Rafi Shaik wrote:
>> The current implementation does not configure the CPU DAI format for
>> MI2S interfaces, resulting in -EIO errors during audio playback and
>> capture. This prevents the correct clock from being enabled for the
>> MI2S interface. Configure the required DAI format to enable proper
>> clock settings. Tested on Lemans evk platform.
>>
>> Fixes: 295aeea6646ad ("ASoC: qcom: add machine driver for sc8280xp")
>> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
>> ---
>>   sound/soc/qcom/sc8280xp.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
>> index 73f9f82c4e25..2fd06354923a 100644
>> --- a/sound/soc/qcom/sc8280xp.c
>> +++ b/sound/soc/qcom/sc8280xp.c
>> @@ -32,6 +32,9 @@ static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
>>   	int dp_pcm_id = 0;
>>   
>>   	switch (cpu_dai->id) {
>> +	case PRIMARY_MI2S_RX...QUATERNARY_MI2S_TX:
> 
> there's a discontiguous (i.e. asking for another 'case') QUINARY MI2S
> 

Ack,

it can be handled with another case because discontinuous id's.

> there's also a SENARY MI2S, but that we don't define upstream today
> 
yes.

As for SENARY_MI2S, since it's not defined upstream yet no need handle now.

Thanks & Regards,
Rafi.> Konrad


