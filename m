Return-Path: <linux-kernel+bounces-840244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB5FBB3ED8
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 14:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDBC63ABA03
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 12:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B6230FC3E;
	Thu,  2 Oct 2025 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EwxJL9PQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AB8285047
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 12:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759409157; cv=none; b=i9nSwEnKAdKj7XF4vlRRx9hvLgTEIcCNwMgoxUP/6PxvXUiwyCJsp+X2I74QlMCxWtNBrT6GEZuiVBWuczh/2bgOw8iLKyv0aTaqcTQzi+e0TXdeCWL1YZKNR9r3q1GTJLtPvI+GDKonnAZO6XOAiXAx3U3DjbDYhEIEbS28o00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759409157; c=relaxed/simple;
	bh=OzzFAPU7JWZ8TpzU3HuOCxPSNDtVN3f9jsR9IwNrpvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MrGdtVanFs5UeW62vcXHtO/gb2CayJ4R240ZDh/5rxX2B44xu5g7dO6qsYU8oJZ2TC1zhJwh6xFoLHCdGHtCgGTG/w2dNHBF65AwAqWIjcMB6z5zUBX4lfZ40DX3kdWStPpDIBNQ5r8hH93F/8Kg786PxV5o/eyA7LDyAVB4T7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EwxJL9PQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5929HgHd005988
	for <linux-kernel@vger.kernel.org>; Thu, 2 Oct 2025 12:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YY2yji4SSSuA6J/yxS5x4trG7A7YFsSGcBCsY+ncM5o=; b=EwxJL9PQC7aJuoqn
	LdT9BOUTUxKZRh2dmiDMqqKRZ1wK9Dty8AkT/SPyPw52V+Ty9WWSu7KezbR6s6nP
	HsNY902d1nePKn1WyA75BO2DOMlvpUl+5scfZNG6LbO4m1G5s66rly/8/iTjfYc7
	g/Z10GXWozFzm/bMIpTQGwR3RP/S7dmXvqm3yhW2Tjd30Xfct8IOMp7KezoPfADJ
	PGZY0yBK0YXIbJeG35boExCos6Rs4fgbd+yMAWkWAwi127PvkuPY5SK77/CEtjYF
	T26fCu3re4msgHrScgex0SE0Fz6Ypa+nalasGcdK64pp3c39dyjZVKZqNOnoEcvR
	NYdrhg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e851qrwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 12:45:54 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ddf2a2d95fso3058651cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 05:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759409153; x=1760013953;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YY2yji4SSSuA6J/yxS5x4trG7A7YFsSGcBCsY+ncM5o=;
        b=tASDqOj0+xZcRZCNjFpJZEWwavoascaB+q8XkdKjyvLZqgqNscXHkT6NQSevE0WxBK
         glpukgz4m/fKVaOzqBOhpQAVCCzQkZHvEiOuIzyd4zaNJAn9IdWR3A1ZlacwCfoKhoXV
         XTC61qXU3bLpR81gJqlbSeX4hKp++LLRtFITCjURxbp2NE3uuxOk9lnof9eddbHSIuRg
         lqJPvS3npGvsOFL+PHdwZkbDfAyEz167GdGaxiqi4YBWuJoEtRVy2D3EbDHaNsE2nGZa
         IJpE3WLsCUq0PqgOkMXte/ge7PIU559Y4lNVHZvACT2zFkvu5hX6KQeZ3EiH8S7STstd
         y1EQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4a3CHPho1zApnYrX9R7K4HfLPZIWjL0vHde5+j80Fjk2RXwKaeeVb6k3LITLgIrjQRpjPBUgRKqUrMzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDxs7XAHLOpJc5ozvOJSQvkC9zZUK4OxEfr9e3M3wM7NKGhjWB
	A6+xwApzzG4xw/Imlkazm35lw4d+It8/2FW82ENaiS6a5r8zrKn67/NrbadD+YXxf/lKja+Pypa
	457o9cNuR2E4O57jeSJqDtWIDETqEsZdUDxTe6yrl06jl98fOD0jhe8Ew/aaCvU7sO+0=
X-Gm-Gg: ASbGncvvxKQntE/I2pqUougVkmx11pwZB7xF6TyozvPPlDMDfZ6TqaWZzx2KH4eEwHn
	r63eWI39x2dJa7WIxrap6ao/5rhppXlIYNq0pPMKDkjPQAK+Qvzq9stLhyX2v+HSfvgSoZIbuX2
	qw4iLCSWLMEmL9sIexebHDvDgO2RxiZts/Pzulz1MGMpDvp+HmfWsCF1rbYV/eAH096TiGY9GDd
	1d96+SUCrq2SnTM58b4kKuRxS9b8caX/sK0HxXb+G7KrF69U2rgNx1sD2eEItJoA9dD2gSkv/ls
	xB0kujM8DXskh81NuA+5q4I2YPoR+UF0RkUmKgaNmAg6wkpg91XxoQkDLjLCH/TkL9FxSkL8lag
	z+KzOG1DnXWcvZA+f4LvM5MCXyng=
X-Received: by 2002:a05:622a:547:b0:4b7:a9cf:91f with SMTP id d75a77b69052e-4e41db8694cmr60789661cf.8.1759409153128;
        Thu, 02 Oct 2025 05:45:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbmbyMEl5laym4ZtpLS7VwZdkHI9TTQtdN0M0ejOF2Wn4yjL/VQhmP9xk0GUaubrnM6JYvaA==
X-Received: by 2002:a05:622a:547:b0:4b7:a9cf:91f with SMTP id d75a77b69052e-4e41db8694cmr60789321cf.8.1759409152494;
        Thu, 02 Oct 2025 05:45:52 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865e7c47fsm203494966b.37.2025.10.02.05.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 05:45:51 -0700 (PDT)
Message-ID: <1be80052-3ba5-46de-804a-de995f8db5d4@oss.qualcomm.com>
Date: Thu, 2 Oct 2025 14:45:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: qcom: qcm6490-fairphone-fp5: Enable CCI
 pull-up
To: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        =?UTF-8?Q?Andr=C3=A9_Apitzsch?=
 <git@apitzsch.eu>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Wolfram Sang <wsa@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20251002-dw9800-driver-v1-0-c305328e44f0@fairphone.com>
 <20251002-dw9800-driver-v1-3-c305328e44f0@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251002-dw9800-driver-v1-3-c305328e44f0@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OJoqHCaB c=1 sm=1 tr=0 ts=68de7402 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=6H0WHjuAAAAA:8 a=Q18OPwUwxCoJDF6_gJkA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMiBTYWx0ZWRfX5hz8NRb4Qltc
 4x93Md8wD7f/jDvdub+PxkVnxoULB/bGxOiWBHbrrHPCH/x86XV9UCQ9k6Nvj+GDvLgbhbvkN1w
 yjA++SngWaPgCpfKBcgSFbwflB2u4eT8uMnfO6y9cFlDJFNZ6n1i5TcxpWF3TN04cS3cigw9kan
 lY3tVzYrYJV/9ygfl4FK7+4bUWWbTX6BSAKYs0PRm8qgMVSenm/d1+3SveF4hR94gZr3ffDBKxb
 AC5cSEfTXYi9AMdHpmfPxmu4f2NF6gTTrsua5ebKBY5gzFFl0EsjqWuiVDwUvQVSK2AOMHI5S7A
 /LyKnxEdtgW3LPZg86INj55YqrnbsJ5giJ+i7KXz5rHQLrkj42S80TVDiXQvqLngDat8xpEse7v
 Zb8+IgYeD4pyL64WUmQKc7xmJ4hKzA==
X-Proofpoint-ORIG-GUID: sYH_V5N-jbL4xH2lumT2PAMPAfTIvoGW
X-Proofpoint-GUID: sYH_V5N-jbL4xH2lumT2PAMPAfTIvoGW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_05,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270032

On 10/2/25 12:15 PM, Griffin Kroah-Hartman wrote:
> Enable vreg_l6p which is used as a pull-up for the CCI busses, to make
> sure I2C communication works as expected.
> 
> Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
> ---

Makes me wonder if we should maybe extend the CCI definition
(or maybe the common i2c-bus binding?) to accept an external
pull-up supply, as this is a common problem.. (+Bryan, Wolfram)

We could then shut down the regulator when cameras are not
in use, preserving some trace amounts of power.

Or maybe L6P is already used as a pull-up supply for more things
onboard and should be always-on either way? Could you please
check that, Griffin?

Konrad

>  arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> index e115b6a52b299ef663ccfb614785f8f89091f39d..2dd2c452592aa6b0ac826f19eb9cb1a8b90cee47 100644
> --- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> @@ -749,6 +749,8 @@ vreg_l6p: ldo6 {
>  				regulator-name = "vreg_l6p";
>  				regulator-min-microvolt = <1700000>;
>  				regulator-max-microvolt = <1904000>;
> +				/* Pull-up for CCI I2C busses */
> +				regulator-always-on;
>  			};
>  
>  			vreg_l7p: ldo7 {
> 

