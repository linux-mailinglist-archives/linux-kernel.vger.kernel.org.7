Return-Path: <linux-kernel+bounces-799015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD54DB425DB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BAABA4E5220
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910F028BA83;
	Wed,  3 Sep 2025 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PDzCgIi3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F30328469D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756914543; cv=none; b=SkUl14aE/lB0+r6kRVgmuCr1buUFGpuEdN8SLLkVFKAHjyddXbCHIkEI5yJfgSsvjpaGiCW9TDkgl+KrixTIpd/4cOd0YhUQu3Ewu0HirsW3MSg/T2qNDts+PLpuWmeU1iftNWZ+SaqhOnSIcIXhiK4LlzyfIHlHPMQX75pLm4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756914543; c=relaxed/simple;
	bh=2ULE5Uv18O/K63JtWkZrrT0etatA9GQnGwfHqCmI78M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IzOaywJpQtXXrCO00y3mAAW1q9WO80DzXYSVOkQTBYAP1y+MfBw6kKlt+yxARWboLFbAuqC6WfLptum4IiJMnk81YzPCeCn2/2rKN9LGjYgalIj05D1d73Bh8DeckiKxUTBSv3bYI+KphSbWFAg/ajMXPSuFP/mXuZTdttAYLoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PDzCgIi3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583DwqNt016607
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 15:49:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3Ggl7DnvcqKYKRzEbo61Lin5r472AwZUwG2xdc4arsw=; b=PDzCgIi3Qd/Vy9Az
	A8maAscO7Q86iAzljoe0zUekiLoqjN7lglPGAna3zEQVRqpTy/KgeDUTZ1vCwYkd
	GC0tyEIfjTikDJq0v8nalCcEZf6fEEAv0doheJVHKL35Tqmto9Oc9onIcLTeE2qp
	ZGQOEImLc8Ud1dvlDVJ6aAiBpYsRkwBbDW2T9K8EfAnpZy8xqetkw/6nWJUNyStE
	DnIeJiZDA6CLxzmn4UAlzLVPmnK4uOXmsEoLL3Y+5un8d/Vlxe9VJhpmxojudApr
	1a+QiNwEqiM0HIQ7m5giF1oLaWhYnxuirjplFr1lnEmk+aL2KY/U7cFNTY8Prdo9
	O3RXTg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48xmxj0t8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 15:49:01 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b32dfb5c6fso132731cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 08:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756914540; x=1757519340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Ggl7DnvcqKYKRzEbo61Lin5r472AwZUwG2xdc4arsw=;
        b=MLZcHabusMpRKCLPUUYR9ri07kECoikdqL8BN7yujMFr3jWtFYGBuwxRi8D37cVNO6
         kZ1eSnLT4y8CXhwM4QbPK2gttxlA9RoaKrOboXSjAD68Yy1Q+gZ22e5SpAb8GoSIrP0y
         OWJk8Zi0P2gryi+2qb+LSLhYWdxyWqXjGMBxJ9pNyEhTxlmYKn3UihHWqndVja5fSNqC
         M318JcVGkMNaYjvQ6D5djGl2jdqEL/hd0gP7R6jqSFDtGIn5sdgeZmpSGKxMYgM5SRnB
         P6GZg7sws/JnzbtBZb+g0rTGgCDcy2psm1C4o9cDRIaTbu2Hk5lZflkLnIWwjB/HRzUS
         Tw7A==
X-Forwarded-Encrypted: i=1; AJvYcCWOF8LZKDNF97Qr691+TlKJBqoIADw0P7CQwmTIq7ziqfNGKDWS1hjg0lWeuhZqXpHVxImIH1x/NKfr14o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPEejt4oKG1G6n3BElKLHYj+SsLQESPeS3++2V8ewHTizRmn/y
	07qup3bgXZyLOUekFlahL29MMf4is1+EyTgKVPKVVJUX1tyke254XDPuBwUqdxJeiSiuNsqHy6C
	k7Syb+EEoF98p4aKnH3RqXY8HB+u5F9VghtnRjX5GiZycszVQU3w05RsqxVdudAvEktxlRGagyT
	Y=
X-Gm-Gg: ASbGnctzLlD3ZjtHXPsNFVEgGowlmKuOeTisia92hddg/50wZEChveYoCrWIxRuyyLg
	v46wx+Q8cJWCx7wk2i1EUlCoxQmqbsjexM/wPYeYXuS9gXRA0Cf6sKVJcn2otRlbggvDoHZFz9D
	Uk0RxXI1QWm1Vc+r5hpYKoG7TeO3NiTlX2phHDYnazmSvwCPbN5u4rF5CtKKNZz/qywc48verzJ
	egjsqS6pAJiy656GqDqdzZzPGmnyeaTD0vVHGLFSAlJbQJTUi6DRPKQJWZ8dep5ev/OSkL2AteD
	B85iuWMjEOsPYUnuKK7De25PmDtsQn6aVIu6Hc4QOLQpIHARV2qzshQe/64gpSYHvde+xK+gZaW
	qoF75TXwzYzstXJZIEso2fw==
X-Received: by 2002:a05:622a:f:b0:4b3:d28:c94 with SMTP id d75a77b69052e-4b313f91b70mr146098451cf.12.1756914540055;
        Wed, 03 Sep 2025 08:49:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8vnUHPJqOH0REja14CHlT+z31FOaCWS7wMTdIEIxmuSsVShd2Q0XwbPMpBWacrkr5+rw7kQ==
X-Received: by 2002:a05:622a:f:b0:4b3:d28:c94 with SMTP id d75a77b69052e-4b313f91b70mr146098141cf.12.1756914539620;
        Wed, 03 Sep 2025 08:48:59 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc4bbbd1sm12231373a12.34.2025.09.03.08.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 08:48:59 -0700 (PDT)
Message-ID: <bbf6ffac-67ee-4f9d-8c59-3d9a4a85a7cc@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 17:48:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/13] arm64: dts: qcom: lemans-evk: Add TCA9534 I/O
 expander
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
 <20250903-lemans-evk-bu-v2-3-bfa381bf8ba2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250903-lemans-evk-bu-v2-3-bfa381bf8ba2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDExNyBTYWx0ZWRfXx1TqYAspjjQs
 hEzbEHSs574Vf+DmtOSi9iJQNeK//ooX5XsdCG8DuGyT9gfwNbUbVmGCC5pOWS7XVuSakqgU7IQ
 DdT/FeT2dWRUHLWPhQNbt1AjoNqq0y8EynP3NET0zu/Ppg1bUlXtmM3FSd3HHLskUhVl7ovFW9F
 802lHfbAq6SpdtxEnFN/WnNHbjBu09pwwM/bZhe6h3qYEXSfTfmfnY3ZvLzmO6DAvipoGbBrXD8
 H5PDqjnoiUgxo/5xuyt0ljKVwuR3lo6zo3co0SBg9i93sKqEphAFNHjleQhjL+ZlFgs7pa2nLts
 XPgnVgKDJq5NGTgiMPnB77vCucYcLceSbTQ1RrNvAZuyrfW2HeM4uI4YM909Wje1oBgoPR8QUIX
 uHH+gtvA
X-Authority-Analysis: v=2.4 cv=a5cw9VSF c=1 sm=1 tr=0 ts=68b8636d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=nLpcdTFfG50SK1Npur4A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: sXUe3U_lSciE-2vsrbcJ9XH1ND6faR1r
X-Proofpoint-ORIG-GUID: sXUe3U_lSciE-2vsrbcJ9XH1ND6faR1r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509030117

On 9/3/25 1:47 PM, Wasim Nazir wrote:
> From: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> 
> Integrate the TCA9534 I/O expander via I2C to provide 8 additional
> GPIO lines for extended I/O functionality.
> 
> Signed-off-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> index 9e415012140b..753c5afc3342 100644
> --- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> @@ -277,6 +277,38 @@ vreg_l8e: ldo8 {
>  	};
>  };
>  
> +&i2c18 {
> +	status = "okay";
> +
> +	expander0: gpio@38 {
> +		compatible = "ti,tca9538";
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		reg = <0x38>;

'reg' usually comes right after compatible

Konrad

