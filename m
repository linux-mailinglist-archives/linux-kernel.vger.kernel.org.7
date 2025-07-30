Return-Path: <linux-kernel+bounces-750538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8563AB15DC3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601E91894AC1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8EE291880;
	Wed, 30 Jul 2025 10:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OE9t+lPD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425E426C3A3
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753869666; cv=none; b=eZqSN/ODqACDzFVJfoFI2Ir++8ZiffrfHpYHIDyHTwnXdc93QrFQ6KFIeNukb/ErhWCKSJN44lzblZjd0eT1NXbwrcjtNMFubyONYq6uZjuNPn1tpV5DEm8gA7n9WkjGUzrUB1io/PeSwFpN+nDzxXzEvyJNT3gSQxMSNqxohOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753869666; c=relaxed/simple;
	bh=/NbRkipP9VCM+Lc6lxFwKRTG405kRiihzDFyNsOsLMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HTbdJvvVtvKVKe5tK7dh5MYqPAWxyDAu5eo6dDhmSihQxji65JtmUIOrPry0ZitL1ZaEAP/d77h5QDmQi2yZQ5l2C1E2Al/paI/D2r9Ji/2jfQywFDPU2eMl8PKFM9jiO4DSxHdJlHUmOZCM+zXaLtSdDNN7hhCsr7SZWvz7tNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OE9t+lPD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U6S71b023381
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:01:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8qVYp0AZmQ8Y171B2X7YTOB0/ixgpTOlnQfewXcziPo=; b=OE9t+lPDtS4F0KFH
	BLAGtHen7/ksS9o5XXqVJZLcjjqWg+rh8AJ2TYIiYOy7mrhfjvqpTwc7/6AF0eck
	CYVvbW12dKXNl04dsYgRrzoQXMOER2xIN/ytB500jc51p1W1LoN5HCAHM0QiPvPu
	nZ2Hoy2uCON7PhNxpUzU1/Fvv7WAFpcZCWQQYTiNUDWW3pNfgxWggWNHok+2Pu4T
	C0tPKddpYMw+P9Q3PZGR3hySHs4/YhgnooZZ4yJyr6cudIKSZA0fKKB8d9V4OTpw
	FaCBWoB+ufuo8g+XqoW3CZVpvHrOZXxCvgkFaAz0pZv/a1dK2W8+ZIauTupX6eyF
	xN+fXw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q3xu8ya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:01:02 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab7406bfa1so17031781cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753869661; x=1754474461;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8qVYp0AZmQ8Y171B2X7YTOB0/ixgpTOlnQfewXcziPo=;
        b=Qvjzik7y88P3k0xwViunMoCeP6qwUI3jrHzOkL+cJB1OP+gfHNzTuHbom7lxZLRohW
         Gj22W+9XN1iTFsqI+UtFKpfDOpOqSQqVioV5BZEegCjA7yg/ukuEaPxTHyaWd5TwSna2
         ZfcWH788X5ve1H4xAmKk65dyFDzvQBMLEv3DPBrPvkzG4LL/VF7IdEyPmh3llbPXlFFg
         nO8Jp++YjxMkpZiKms06XZeI7/snPODiMdZ62YQ6EpYv393agfAQ3JCvxbxrwiDluuAg
         0yo76qC5NtC8kw8lFHSKdHgtWcosc0qjW6mkKzUzl7o4yfHIiAlsPXGsq3BUDc6fHAsS
         gzog==
X-Forwarded-Encrypted: i=1; AJvYcCX3dkfvFbJrqfIjLBed3cHXcCIxmGLHq6jNktwwtBzgTemNmk7+A0LT5Z+GvKL7+KKglRhxTLM0CYvb0N0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNVj47GkfvaFPWlKffmpRQ2RMCQGAG1d5zyk8w0am9e3jxfSE9
	7hCpB38SqMt45aDNINx5qgQncNa1GjyG15d1c2wVGIdVYuML1EuN3HZ4j6xvFNjON6QnwDvyTs0
	jTpnAUzz1BDVeB4S3wI+LEaOCHtKGpsxTq1rNpuOBTTlmTbDHBrTTVANxQ6lNxFBzqmM=
X-Gm-Gg: ASbGncuMCPRNm2zRb30tVdfEBvSkjIT81aGQaipXkuHGjfgUdn9PDtffDEo9kQb2D0f
	8iF93ISisT2NkSr5IKeoLDujeyamCioxv4knMmhs9DHW6usaVS+qAWHpiVth4BlaLIjNM2LbQOD
	ef12O7qXcKV5JIZp3yEzQgY+DGjbAFpr7NRbMq3AJ1DlKnGWyhCqDcUQQ0JyJ9eidb57eMPwLa6
	cei/v4vJ5pmFIjHLpEYGhiVNc8Pv4yguKkNdHa1jooFjYvbfEyhB0DOzKhAfLRPW/cbJavjzLOY
	3gWU7YlNIf2atmisU6yUhrvphm9O+3jHjgZXkimqspjMyb+HcNTxFzib4xc/BYmb1k5n+Zqp7VL
	CLhObfVohcSpism1lBQ==
X-Received: by 2002:a05:620a:3908:b0:7d4:5cdc:81e2 with SMTP id af79cd13be357-7e66f372189mr195218285a.13.1753869661074;
        Wed, 30 Jul 2025 03:01:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK729sglyzfLvdcMWb65qyWQ1Lwoe8zYZPYieFqzmCOYEfteuWti2wa+QHRti968wjTGVNhg==
X-Received: by 2002:a05:620a:3908:b0:7d4:5cdc:81e2 with SMTP id af79cd13be357-7e66f372189mr195212785a.13.1753869660444;
        Wed, 30 Jul 2025 03:01:00 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635aa4494sm717711666b.97.2025.07.30.03.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 03:00:59 -0700 (PDT)
Message-ID: <63da4872-2365-40eb-9b2e-d3393ddd9b68@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 12:00:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm8650: Add ACD levels for GPU
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250729-topic-sm8650-upstream-gpu-acd-level-v1-1-258090038a41@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250729-topic-sm8650-upstream-gpu-acd-level-v1-1-258090038a41@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=JovxrN4C c=1 sm=1 tr=0 ts=6889ed5e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=qC_FGOx9AAAA:8 a=KKAkSRfTAAAA:8
 a=uJl3NGG0jz6E0JRZAr4A:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=fsdK_YakeE02zTmptMdW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: jPfLQLktaZe2DD-v7FlJEe1SLtYD_6f8
X-Proofpoint-GUID: jPfLQLktaZe2DD-v7FlJEe1SLtYD_6f8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA2OCBTYWx0ZWRfXzCKzxRol7CXy
 2IcSbm1ocm/hAtREVBL+ogtw1Pr+EHNTixsEFDBip3WbINPnzsu6ltYl0KtUYnSRfIdy/YZUHWq
 kmxrH39IJDD9mAuk/a4DgNl4DBPpadgFhP7YrK7JIlf6+5nlVnLxEYOVb8jYK4b2smJ+oRO/jn4
 9RxW2m02uoAoAriSVJmuzOjyjSnCsGnPKpSaA25ZwS8sxxSrn+alnXXqkdnPj2o/4FDcx1F6Ghn
 BLL1shRAdASRIwE1O06AP9nH+w1IojHi6gpSYCTqJhTsoDaVJvR8opOlY1eQX8mucztpNFbOOHU
 3nYrNdX/X1SeIntl/5IBI/cSdygjURUeGDLoBCsiSBRdp8c7Pd1hV/bfj0OcumBeR2bpaXPyQmY
 DEGpB5TvhAw4n6i3/cQ/RFDmZ/w/3gjGi84p2afV1B76HhqGQohSDf34d/FmvRnyZE5mM1GS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300068

On 7/29/25 4:40 PM, Neil Armstrong wrote:
> Update GPU node to include acd level values.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index 495ea9bfd008500dd2c9f46ceca94cf5f972beca..4cd933219ce008bd1c603c87778e210b6332e29c 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -4127,72 +4127,84 @@ zap-shader {
>  
>  			/* Speedbin needs more work on A740+, keep only lower freqs */
>  			gpu_opp_table: opp-table {
> -				compatible = "operating-points-v2";
> +				compatible = "operating-points-v2-adreno",
> +					     "operating-points-v2";
>  
>  				opp-231000000 {
>  					opp-hz = /bits/ 64 <231000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D2>;
>  					opp-peak-kBps = <2136718>;
> +					qcom,opp-acd-level = <0xc82f5ffd>;
>  				};
>  
>  				opp-310000000 {
>  					opp-hz = /bits/ 64 <310000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
>  					opp-peak-kBps = <2136718>;
> +					qcom,opp-acd-level = <0xc82c5ffd>;
>  				};

https://git.codelinaro.org/clo/la/platform/vendor/qcom/opensource/graphics-devicetree/-/blob/gfx-devicetree-oss.lnx.1.0.r1-rel/gpu/pineapple-v2-gpu-pwrlevels.dtsi?ref_type=heads

doesn't set ACD for D1/D2

>  
>  				opp-366000000 {
>  					opp-hz = /bits/ 64 <366000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D0>;
>  					opp-peak-kBps = <6074218>;
> +					qcom,opp-acd-level = <0xc02e5ffd>;

And other values differ too

What release did you grab these from?

Konrad

