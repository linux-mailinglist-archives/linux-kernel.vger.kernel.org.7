Return-Path: <linux-kernel+bounces-877844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AEAC1F2E8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C69AA3ACA73
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C0733B961;
	Thu, 30 Oct 2025 09:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WnN+qUfS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IRgSGyKZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F15F33B6D8
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815216; cv=none; b=d86qwz+KkiwvLYtc5knYR1TYLrs4ehqIEH7RXLmAzkIesZvooYqny8JgmuTM9P/16Gr0qOgUICs+J+r5FEnNP8Q0QhGUQY3PygI0rNp0xvuzey8migM2vlcVjyJrlM2wo5x+JPrPxn5tnBVO2UnQAWC8JqgFmE2hDmrjqsvi6LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815216; c=relaxed/simple;
	bh=X7ILzCECf3H8UUnRWySC0tpXkeSAn5oZR3ZqEfON2eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tiWtaFncXIgZkmRiqMb1ztRuG9v3a9Kjz1ZB+AFC4f6hPSVcUdSKldqA8cLeSYddbDzgzMgFt9BrVD0FT2IoKJuZjl4IhWYWG+Dyl+l8sMatcTtM1W9p1k2ANf34skWW9SHnpOl2ddzUP1tkNIogj22+AG9voBNO4WG8tcuXF58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WnN+qUfS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IRgSGyKZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U4xg3G2622985
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HIb99wMfqBRmzqLt4TerM4AEHn1832mxc0+HjrXIUdQ=; b=WnN+qUfSPIP6UeXT
	XHylrDpOJWAK8vNluPmyt7e0oEK3LktbOMK9udQuwKuPwyrHW2SYRiv+jl90Lt98
	Da2bAH/mr+yeVdJMQeUvXDoHBTCmHxrHGX8fdtpVQlKrjnTWewsOqu5u30tivxxs
	vVKdv9/tQx9eU8sd5OYkxL71Qcci2nvSTKoxSDa7OfulVxNxuLvWXukvlhiS1W4I
	arueGt5BgazcxUgxj30gcycYuFgMdMicW33TTLn89ziW4edtKYJry3qKQLQEsB4S
	rmPQySyMF4GVWBvNlYw5/3wfhIiNoVy9YGcqEjKwM71M7/FJgz8ZiI5CXg2ib2LJ
	DULE9w==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a41fxgnda-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:06:53 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8800dd3de99so2157956d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761815213; x=1762420013; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HIb99wMfqBRmzqLt4TerM4AEHn1832mxc0+HjrXIUdQ=;
        b=IRgSGyKZDvHIkMoKrp2ODheCoVq82VI+zC3afcmsfRdv7g8xuEnehnhH8q6A+BXseF
         cbgt/AKXUGrXjHoI58vcLP7KGnJt3fD1z5cii2eQer7iHgUKis3gpa3XCwwYTtZW5nys
         FJWen0z5Khkp6AxSqAjNSP9f1IGaQy4jsRmmN3EuLLukPRUdkbbX5xNiCsBBxITDhswt
         75V+JoUiwtxFY39xvmY/3QqtQbm+8G0FwgKcvHLWzkloD+2t8q31AclKeWwd11zmQ0xu
         QBadhKLdu2JWv1q4bvfgeBmqGfoKwkQDdzUpDy0QYcndWFeI1+vBx6B4DBFgXn0EcWq9
         5JQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761815213; x=1762420013;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HIb99wMfqBRmzqLt4TerM4AEHn1832mxc0+HjrXIUdQ=;
        b=RoAUnuH8/wvVnBOkt9XNhinS+88TsrXGDmKRwBstTOYRk44XCEETIUSAX+yP1UAZEO
         3spArtyip3SMPZdftMt2137tgz/vjALW6Fi4QK0WjEF5wcCtZb2lApD0dJOTScE5rutH
         z8HjbNugCfp4yqe5hdVwG5j0N6RR7AUWcxWafEy9oAulN4cF5ze2E76YBu/lrSiDjH6S
         T3iLYNAWwvFC3XP/PCBKA/LaKXFQ0b+vh8Xj+tGISEU3rVespunVyUfmMMAEdrXvwYig
         Dnay3IAM4jIdoeCveFFzt8auq55ek9+iR4TA0Gn5AZSNCcmHXf1CtbGMRnQ5tMg4qUI8
         ke4g==
X-Forwarded-Encrypted: i=1; AJvYcCVmXlmALqujMQnIds/x4op7RVln0HKYjalTyS4FAwX4+Ip+/kfcpNuvPK2YLZ53PbxS4c2rM5mmjWHIBKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ82JIguGswKmcFmneFByQ1Xf7oHrib5JoxrggBY0saCi3YAFv
	8CY6CCO5snRT2CluXF6M98/zCtGqrV0q2MYdFz9ef1oMHHCTKOgYWPuG6l/27pjqNEFxrUqFsCt
	HwupsKRa/10zoID4ummViNR0POJ2M9hKMOYEA7aOtNUgOyOPdAY9kPHW0WO03PVx9KLc=
X-Gm-Gg: ASbGncunDQhUPOwjiUUo269+Y38vScUXul6sEMWVD+VQhPjuQStKtqRwW4+k4/pRRnd
	1QG6DeQ1x9aNSUOXUMzYfRz6TQoYHBjAax/5cMRlgaFRzMG/NkQvtgwP5wYloKL0+aqDcIBsUdP
	YOl6aiNKTbaTzZ3+kL9bdQ+FpaumseROGiiNh0JI6T2nJDWkR25x7ns55OgLY07rg919tLM6Tfm
	xNqR5E72/IhnS0YsdUFZyaXnm8uD6jcICONKDEqB2j+3pTukCYqbeFKBC+5MvdwKgjA6V2gFZIm
	VuzHla01xHQWfILk/WTxoNJ39QjwcjJry2C04kp20keI13uAY3LeoKYXZZjRiOeJ1MfqQTt5ab2
	mjGz/F785AZJ8lSI+IcQZXwSiiA9oGZDq4IfItlxWtf5Iqhy1arCFXhm1
X-Received: by 2002:a05:6214:23c5:b0:87c:cec:70c8 with SMTP id 6a1803df08f44-88009c19ccbmr49168646d6.7.1761815213109;
        Thu, 30 Oct 2025 02:06:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgvsyWzB5+BObIPZCH/c4u0+NukSV+lTB2L5w6KrqKL76+JE7wKJWY/APuk/ewwXv5qVpOQQ==
X-Received: by 2002:a05:6214:23c5:b0:87c:cec:70c8 with SMTP id 6a1803df08f44-88009c19ccbmr49168366d6.7.1761815212685;
        Thu, 30 Oct 2025 02:06:52 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85413b88sm1669495266b.55.2025.10.30.02.06.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 02:06:52 -0700 (PDT)
Message-ID: <312b62d9-c95e-4364-b7e8-55ebb82fd104@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 10:06:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ASoC: codecs: lpass-tx-macro: fix SM6115 support
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        robh@kernel.org, broonie@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alexey.klimov@linaro.org,
        Stable@vger.kernel.org
References: <20251029160101.423209-1-srinivas.kandagatla@oss.qualcomm.com>
 <20251029160101.423209-2-srinivas.kandagatla@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251029160101.423209-2-srinivas.kandagatla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 5UY7XI_Euo2q1swY2jFk4RzLnK-od6rK
X-Authority-Analysis: v=2.4 cv=UJrQ3Sfy c=1 sm=1 tr=0 ts=69032aad cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=jFCpiT4AGmqPEWX61NoA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: 5UY7XI_Euo2q1swY2jFk4RzLnK-od6rK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA3NCBTYWx0ZWRfX0f/282zyOZtk
 xExd2KcMzYI7uc5O1EvB6ImaZaWznOjpwXS8EQQFRb+sP5M8PglHx9EYPv4EH07yVRTrUlM3r04
 Gy+tLbm0UOhXKnTYy4e6RXjvLBoW1SSRu2v3MfYOlRWY63e1tZQfrRWyvXqPIo+yUN9zkn5II4t
 txbNyM/VFHkbwTFOF2EcmuRyzSFNydacYaHWcWTFlsAOTzf3OTRmu5aqcJ4a08yF0W5NAUa/MUt
 mUJVpFrAL0AoWryaOAntC3boP9OdZ3RHWxv1qtnJ30SVnobQWsOTNa338fV88SANnc3n/uf1NeY
 FvGkvmr4gGB1tWPHi08A429sQt9klP8YjM63ImswSMgh2pSHVWP9d5wg21cIvGhk+bFjFTDiSGB
 U2uQ3mU7/c2YoUfypzNtcaK/8YPIlw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300074

On 10/29/25 5:00 PM, Srinivas Kandagatla wrote:
> SM6115 is compatible with SM8450 and SM6115 does have soundwire
> controller in tx. For some reason we ended up with this incorrect patch.
> 
> Fix this by removing it from the codec compatible list and let dt use
> sm8450 as compatible codec for sm6115 SoC.
> 
> Fixes: 510c46884299 ("ASoC: codecs: lpass-tx-macro: Add SM6115 support")
> Cc: <Stable@vger.kernel.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  sound/soc/codecs/lpass-tx-macro.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
> index 1aefd3bde818..1f8fe87b310a 100644
> --- a/sound/soc/codecs/lpass-tx-macro.c
> +++ b/sound/soc/codecs/lpass-tx-macro.c
> @@ -2472,15 +2472,6 @@ static const struct tx_macro_data lpass_ver_9_2 = {
>  	.extra_routes_num	= ARRAY_SIZE(tx_audio_map_v9_2),
>  };
>  
> -static const struct tx_macro_data lpass_ver_10_sm6115 = {
> -	.flags			= LPASS_MACRO_FLAG_HAS_NPL_CLOCK,

8450 has | LPASS_MACRO_FLAG_RESET_SWR here
> -	.ver			= LPASS_VER_10_0_0,

and the version differs (the driver behavior doesn't)

Konrad

