Return-Path: <linux-kernel+bounces-838583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D25E3BAFA06
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 10:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E15A1941929
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 08:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B741DDC1D;
	Wed,  1 Oct 2025 08:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k5HW5zA0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB169279918
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 08:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759307410; cv=none; b=u6oCQHzmRg+mmup64pQYGR1RWRE9ywAdqQ6aq6dytloAkCGIX8deMJ1jWnnM4q50UF9h2FMwwvBmHRhOX4lqvnJwl/H2ms7GobL6swmoI3pooyH+4Bw3wuHo2n5A7BD0s3biksbeQKDtBay5gHJIA637CiUu0RE+1kjR3qBZLxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759307410; c=relaxed/simple;
	bh=UDw9fFof8/RcJ1kPbVY+sQqoq6I7U5xpbsVTYPMeEQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jd5Xh3FXPRqSg+3veqFcwWjKATbsH35lnRJDaSA0wh4gCaSDRe+53TVPnmIA0nUfFv/KcXTfAnBzd5OpkYdYZZynF+yROaSmh3eI9VIKlcDTesKLK42LAkcYt2QCaPATcR5F6uC27KUyIRrJoKPCg4b0qMVQucHVcSrVwkQ2npY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k5HW5zA0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59173mLx017551
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 08:30:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2X6tqOnkZCqc9sQ2fgf+wm6GtNt0ebr+SQzxsxlSdHc=; b=k5HW5zA0ar0TIz7i
	XbxPZoCMmoZHXcXb/R7VIRbM/3YJQPqLm9jkIJCw+aJzX9XT5I2vLeDVvBdUWPiI
	uKjz8sQqo8qs1VW6e1MwbVkNhx9Qrm99z1PY0BQUO+bWMjgtKd52L8xVCssqEEY0
	rn30RiZiDx0zMFicf+4Ooj9HZ4x56hmvSG9tDj2Rf7mX6Hvxmudyt9m9H8CmWx+t
	eTNu6emQfnv9XJ3vHeQQAM88S/VEpdbBqEXVKfpH8rsJh//JQWzZ40OfrAS09+uf
	K1MqU8XME0eldagxHn43cuc18nCzEjHXRg4jrJJLDd8kzr9Tlt2X7WwheOz+CEUg
	31tSsQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e80tv238-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 08:30:07 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-798447d6dd6so15373066d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 01:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759307406; x=1759912206;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2X6tqOnkZCqc9sQ2fgf+wm6GtNt0ebr+SQzxsxlSdHc=;
        b=nbR6v54bqrWI8nbkQGHdp/j0dGm1BrqzV6hp6eQM4f+I6d1jA9wMemIEuoRzk8ueGM
         +TedgtySyCHG1R06jtKheRiy50ZrhgzE8C0TRdxka0jJIi5OQzrx3d0UaomdmUIsNPts
         1YWFm64D2ZV+gqTTwnryn6dYoVmkhcnEYsFtUVERLJK6mXUI+GTdxNhj0l5jf4VQM0Rd
         ULVZ6PfRxTzf8vIH+UhGjLM3syLAvN0CfMoUhlAyOgf5lEG9gtSnKH8PeXkI6z6p3DWz
         4hmPENIZnDF6t3dG0POuOrWN7CZyCS6ObBVKZiHXD+nRCEi6B86YCdCkB1/MCv0bNJcI
         iXxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUatrtBOH7kHNRZMFaLHtxOfb6M06scb89PUq+u8/s+4XnvyyZjcy2izaLIN4GhxrP0TLJnY9hwyAGzSig=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRuvYavSGy8wyjElziqs87qMRuaklJUv2ATJCS2cqGqjK8snL3
	IdOaovljMX/95OC4/jTY3IkpDGQ9trC1+6/X+7VkjwPTvMJrO4xe/IABhHJXpUDivBMbiUCW1Td
	zx2f3kRmsn/TDDWozpRU3Cra2PHaYx/ggR9/mhdCxXKEOJ5sz7liP7j9LamIJq44MgpY=
X-Gm-Gg: ASbGncti6fQmIyH8nh3Sw9AFWq24Gj9CEiUbbNIN/mDdktD0eMjRpRRRhF4cYHiw+PW
	gFjU+ID9CWQFM+FCgZQHYK4kBBIakuj8wP3eWfg4xB7KEzLpJXU3xVCOXgue+RuVQq7Pdig3AAx
	+ezMT8iYtcJbcWBoWzjHzhFQL4VpSl+ybsDxWyLKfWe/WHWwqf4EJlutikwmo20y4z6OPrbyldW
	DcxUftoVtUWDWYvtiEPXGHdhERDnJoCgy5jzSUauM2XDhmNkyGXyQn7phyFy/xd41LmNyBxVcww
	RglMshxzR8ENK6tn1YSZG/kTCADn+esqpTfhkwg36P90u10oDhHe1sshn0rD+urkXeCdv/JuSFy
	gWecYCHc8AP1NhYBIEqFEMPt3L1Y=
X-Received: by 2002:a05:6214:f6a:b0:806:d113:3f87 with SMTP id 6a1803df08f44-873abb0222emr22127506d6.8.1759307406436;
        Wed, 01 Oct 2025 01:30:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC8KNsHxDoPXMUkX/fvgyVmTEiJDo+/TI3l8mHrrYISyzN5SbngHkWWEk4JHQhpymJZjMEYg==
X-Received: by 2002:a05:6214:f6a:b0:806:d113:3f87 with SMTP id 6a1803df08f44-873abb0222emr22127286d6.8.1759307405922;
        Wed, 01 Oct 2025 01:30:05 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3629cb2sm11171448a12.11.2025.10.01.01.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 01:30:05 -0700 (PDT)
Message-ID: <3483a7ba-7248-4358-b65f-356743648c92@oss.qualcomm.com>
Date: Wed, 1 Oct 2025 10:30:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] arm64: dts: qcom: qcm6490-shift-otter: Enable flash
 LED
To: Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        Alexander Martinz <amartinz@shiftphones.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250930-otter-further-bringup-v1-0-7fe66f653900@fairphone.com>
 <20250930-otter-further-bringup-v1-4-7fe66f653900@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250930-otter-further-bringup-v1-4-7fe66f653900@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyOSBTYWx0ZWRfX3ZwO9l8gY2tE
 r/7Dt/i+Fx6fSjZas+nzOB+Fsa78lzBVtiiA8QdKsHkFO4WClJLJ2p0SVro7d53ZClL3p1uZ6hK
 FFgXQ/qsXebel6/pim4mfseHAXWqY1QbMg9WKypuSdBkLkdqJkiQVmt5z/v4VJsAifT+yaOrrz3
 /ovxE4/AKukhp6mNf2rJW5AsRCVk7GEn7dq1l62uc/B7Bdwok1vBNvn76nH/RVZsRrca3uab4Mz
 oX3pG7EVJ2LIj2+VW+miDDQszkAP/C8lw8MvQLJ9ZqC5SnQ6qb9t+Tnv17rO+/V7dOi7ZU3p/dW
 XYpCZuP1VbJlUJgrsOO9gLKar6ffL1jC5Ed+9oZEu7U0eHGRZkBbENp4PKrSobAzc5sFh/zAAmw
 itnzMd3WkqwIK+K5l1qr71ZvTNpliQ==
X-Proofpoint-GUID: jfHCnRj0P19m-9jaP3bNsXAIoCgZtZKQ
X-Authority-Analysis: v=2.4 cv=OMkqHCaB c=1 sm=1 tr=0 ts=68dce68f cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=KKAkSRfTAAAA:8 a=6H0WHjuAAAAA:8
 a=EUspDBNiAAAA:8 a=v7dz08i6nHTDO6dUxXgA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: jfHCnRj0P19m-9jaP3bNsXAIoCgZtZKQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270029

On 9/30/25 4:32 PM, Luca Weiss wrote:
> From: Casey Connolly <casey.connolly@linaro.org>
> 
> Describe the flash LED on this phone.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
> index ce794ca724db6deb39f7fae47912c3fefe974573..36cc67469615974c193ea3a9db1b2362869d56bb 100644
> --- a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
> @@ -619,6 +619,19 @@ volume_down_default: volume-down-default-state {
>  	};
>  };
>  
> +&pm8350c_flash {
> +	status = "okay";
> +
> +	led-0 {
> +		function = LED_FUNCTION_FLASH;
> +		color = <LED_COLOR_ID_WHITE>;
> +		led-sources = <1>, <2>;
> +		led-max-microamp = <500000>;
> +		flash-max-microamp = <1500000>;
> +		flash-max-timeout-us = <1280000>;
> +	};

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

