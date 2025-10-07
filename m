Return-Path: <linux-kernel+bounces-844095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54267BC0FE4
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 12:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F1653B65E0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 10:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987F22D8776;
	Tue,  7 Oct 2025 10:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hKE2394Z"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B12126C1E
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 10:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759832352; cv=none; b=c4pUnf+Fkz3kZFjlu0GMimF7hyjxUO8RTYxlc0LCli7o2WJ8E5hL527mF/unsSrXGkcEYb0KDI6HA3eR7tdjfrIMZfSJe4k2EDLm3gFlXlMGpuLVzUUgVEdhXVBlsl/GyAXcap0l8O1JbXn0lrUxq/iflNW8G2N1zbN9YPo1hHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759832352; c=relaxed/simple;
	bh=f+IeccJmVNga2AILl1qN2cEOujm+nc2RdTjaS5M1sWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O/H+1R+oMq60N0ISEbRNlAfDDw87zAZFbqLvSoPBRZ2OBqSxtqdi8MAdbkaUXoMLm7nfvGYjt4vH782MOVucvy/SoFCrafJ39nlqoAOEDng4P5U6anmC9wO9EqsFiFdYm/BgZdn9NLRBHtby8v0VOeBRftCeaXw9wSdBhckwuL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hKE2394Z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5977oFtO018135
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 10:19:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KYl9okkq0B42q222w2hbCFPa5Da9FkjQY+ECn6X4ea0=; b=hKE2394ZTv0/gvyG
	XxcOxDDnByqSoCSfBKS92gOR7vXdltx+KVLnwKTeo1ecvXIhj50UAhM42v7MziO5
	xswhLIOboF93kcWOAn684dwSzrw+2eTg71hAIZLyMcBZ+Et4NnDF2v/wXO+yVcUz
	4Tr9q6JIYXR3qMGB9AVnuJx+GpP1F9WkwlhXFewJOkPdSvLJLxm+ic3/UwuvbFwn
	3/3JQ6nWAFoZBE+nR9mqDgQwKT9i6EWZl28XgamGU6NiwadiuiIe0e0N14D9o3zR
	momEitGtwT+56y6DUGmaNOHpzWkWRb7RjoTz+5lWzeW+qc0/nB74AHSZv/GrbQml
	XmmqWg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49mnkpsqva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 10:19:10 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-85e23ce41bdso136374185a.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 03:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759832349; x=1760437149;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KYl9okkq0B42q222w2hbCFPa5Da9FkjQY+ECn6X4ea0=;
        b=uNp8fbah3TcnnBwPt+s7d7jWJxxAAbqvwGaUwITTd5XCg8kI8EIotWxFK0FTyk8BTV
         C2+Ri8OrA3bislpNGFdbp7U+IcUw7+10V7zHPPOkUwzFKUatQZpPbKjeq2nosjj/IA0R
         KprPp1EQoq/G614X3pza9eSO+Fkn360shoJovZPjaI9QA0mjY+gKIUVg6AlrJcrOP3fd
         wlW1ex63wLCOKjt7qFiE7AInyWuhECsoaXVdXukPq3ZRnSUFmY7mMrxF0U4iixIFS9LT
         9ELe5Fo+z0iaBYFfGYebnLTVg18a3eYUI7hX4Uk1VDO0LVEu9AHX6MIOMmq//J3ABOqq
         FTyw==
X-Forwarded-Encrypted: i=1; AJvYcCVfDRvvW4bCfPjxQwAoC6ZuV+ukqFtT0zFgI5Vq9W9Nl+zcI1evjgPoJ01soS9+WVPep/hyGjLR6rS8Uuk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2bvhE28nd45YMz78nNMmX5kyYoxxvbjR2cMoDNLvHYU6VXPOP
	wUfjO4Dwpgso2bGzB0sNQaDlUbl6PYQEsSwIg5nARMHCwEmVcTwHyT4bNBlBbzF39HfFtBMQgvj
	sDxf0mBOmxkXh6odRvEAYQ7RLmJiBBApSKwgpge94AKptKPmmG6P9mjwhXV8Ikkd2EhY=
X-Gm-Gg: ASbGnctx6g0DKeUvEwZtrb/biSC4ZASorTcCnXZQDetWzhyaXEso3zsDbO/GMdMikEq
	5Jcbr9ivn4IL8v2bVsfF88hhZwXGQyRgCd5i5TUg+xMIUcKeJr0z8KI3ehApFIYVYAjY3Yl/33K
	2SO/Lvz7gKNICFWUW+6ju/KG2xmQLl7MQf1ivCvcEEBDuRxXX0XWIokYF3A5BfhbKBkd60S6+aO
	5/benPIBjCzzQCTRjgLPyRglRaOQ5khxK2LakRd7aT6ptK2I5dsPYjqbwW85RfXqjGBlV5W8+6F
	J6WQeOE5vLtOGOHxIWHiyxMhvKRv2ftQmXz+kmjBX3NKJygA/DZAWPW0Zytsbup62jNTE9O2coT
	3M9lzLZKdfbTk6FLU3mr+DSs8218=
X-Received: by 2002:a05:620a:28cd:b0:866:6f75:5928 with SMTP id af79cd13be357-87a396bde94mr1282649985a.10.1759832348724;
        Tue, 07 Oct 2025 03:19:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7oK77CadVtU5NBMC6cv+bqw+nawnX8wVpYFSFkL3EIFnPkTvcFgfYb8qaCxAqZcQCHACdtg==
X-Received: by 2002:a05:620a:28cd:b0:866:6f75:5928 with SMTP id af79cd13be357-87a396bde94mr1282648785a.10.1759832348230;
        Tue, 07 Oct 2025 03:19:08 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa04bsm1365138066b.6.2025.10.07.03.19.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 03:19:07 -0700 (PDT)
Message-ID: <4aa81228-9b25-4b7a-8fd0-7e51e7d77824@oss.qualcomm.com>
Date: Tue, 7 Oct 2025 12:19:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/6] ASoC: qcom: qdsp6: q6prm: add the missing MCLK
 clock IDs
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20251006-topic-sm8x50-next-hdk-i2s-v1-0-184b15a87e0a@linaro.org>
 <20251006-topic-sm8x50-next-hdk-i2s-v1-1-184b15a87e0a@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251006-topic-sm8x50-next-hdk-i2s-v1-1-184b15a87e0a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: lMajath8knzFKe7d7NNFI4kilBkMkBS9
X-Proofpoint-ORIG-GUID: lMajath8knzFKe7d7NNFI4kilBkMkBS9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDE2OCBTYWx0ZWRfX7tdLaU0lPQMD
 7dk8fRXT464g0JXVcPvjzbx0n2wV16K7Y5agrG/OJWfC4yfK5isxHKG6ODRJhDooEev7Jk1vWcu
 EA+515Z5EyvAJFWYgT42JKdnRMs0yy9hL+qNsvruRG1DYgdqLWFaPr8JqqwHg9Bu4ejrZz+Anxz
 4frHTHvJa1C4kOzAW2UEJ4XbfLxZQlMxLLX6nR+I77RM7nItk2el70nRYEbDAp7yQP9bpjah3gK
 LM3pbpIbSwHiJpwh0lUzLtHVjttr5Q31kZ/d4p9hENgwgaAf40whBxwXviHqBxLk9QIPEoNkqT7
 xwYlqChrva8r+9Vm56qYmLSNbVgdZiXB2zK+80csIv/p9tcw1SUI7YdRdRvUPTy9LoQvnGvTWgG
 yr92YpiFE+kBro7fzfx4rNWSjX+j8Q==
X-Authority-Analysis: v=2.4 cv=BuCQAIX5 c=1 sm=1 tr=0 ts=68e4e91e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=KKAkSRfTAAAA:8 a=7KAZrCPtG2FJr_zfUZwA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510060168

On 10/6/25 8:37 PM, Neil Armstrong wrote:
> Add the missing MCLK ids for the q6prm DSP interface.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  sound/soc/qcom/qdsp6/q6prm-clocks.c |  5 +++++
>  sound/soc/qcom/qdsp6/q6prm.h        | 11 +++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6prm-clocks.c b/sound/soc/qcom/qdsp6/q6prm-clocks.c
> index 4c574b48ab0040bc39ae16ec324b41dfc152b408..51b131fa95316cff50342ff60bfc9e3608939d6c 100644
> --- a/sound/soc/qcom/qdsp6/q6prm-clocks.c
> +++ b/sound/soc/qcom/qdsp6/q6prm-clocks.c
> @@ -42,6 +42,11 @@ static const struct q6dsp_clk_init q6prm_clks[] = {
>  	Q6PRM_CLK(LPASS_CLK_ID_INT5_MI2S_IBIT),
>  	Q6PRM_CLK(LPASS_CLK_ID_INT6_MI2S_IBIT),
>  	Q6PRM_CLK(LPASS_CLK_ID_QUI_MI2S_OSR),
> +	Q6PRM_CLK(LPASS_CLK_ID_MCLK_1),
> +	Q6PRM_CLK(LPASS_CLK_ID_MCLK_2),
> +	Q6PRM_CLK(LPASS_CLK_ID_MCLK_3),
> +	Q6PRM_CLK(LPASS_CLK_ID_MCLK_4),
> +	Q6PRM_CLK(LPASS_CLK_ID_MCLK_5),
>  	Q6PRM_CLK(LPASS_CLK_ID_WSA_CORE_MCLK),
>  	Q6PRM_CLK(LPASS_CLK_ID_WSA_CORE_NPL_MCLK),
>  	Q6PRM_CLK(LPASS_CLK_ID_VA_CORE_MCLK),
> diff --git a/sound/soc/qcom/qdsp6/q6prm.h b/sound/soc/qcom/qdsp6/q6prm.h
> index a988a32086fe105e32c4fd713b8e0a3d17b83bca..7a3f2ad7bbd465a6950568af1ff3839e5cbe4f62 100644
> --- a/sound/soc/qcom/qdsp6/q6prm.h
> +++ b/sound/soc/qcom/qdsp6/q6prm.h
> @@ -52,6 +52,17 @@
>  /* Clock ID for QUINARY MI2S OSR CLK  */
>  #define Q6PRM_LPASS_CLK_ID_QUI_MI2S_OSR                         0x116
>  
> +/* Clock ID for MCLK1 */
> +#define Q6PRM_LPASS_CLK_ID_MCLK_1                                 0x300
> +/* Clock ID for MCLK2 */
> +#define Q6PRM_LPASS_CLK_ID_MCLK_2                                 0x301
> +/* Clock ID for MCLK3 */
> +#define Q6PRM_LPASS_CLK_ID_MCLK_3                                 0x302
> +/* Clock ID for MCLK4 */
> +#define Q6PRM_LPASS_CLK_ID_MCLK_4                                 0x303
> +/* Clock ID for MCLK5 */
> +#define Q6PRM_LPASS_CLK_ID_MCLK_5                                 0x305

0x304

Konrad

