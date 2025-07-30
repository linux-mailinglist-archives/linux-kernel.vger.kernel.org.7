Return-Path: <linux-kernel+bounces-751010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 849AAB1640C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482691889988
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD192DCF68;
	Wed, 30 Jul 2025 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JwoG9EM1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E0F174EE4
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753891455; cv=none; b=mgeWbAIrsTd5mTM9buvP1i6IOUMjhR5UERkVDE9fETqv0IUBEfDaM+gYr36Vt96l2G9FfoV9q2NZHp5xv5ZEw3R4bs6cPI16sURg+X1YTZGR2t0AGC6ggRgondC2NdN/DqvtELUbHJITRHFJ+ZysNcriUsgWYfwT4JXUnGwJLEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753891455; c=relaxed/simple;
	bh=sr3vr86B1WN6egX5ufe1jMCAJdnTsepBNRthFxntilc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fnHLSgW0g03MINfgvikFTMW+AvUBRhLIAo7+gxe3nJbNVkUhrNfq/+3RdsWhYjh/LEYmNLN5maPI9cf6ysVnzF+jbeYadeh68CvLEZ4I/TIubbVKVDLbzcgCFphbaaWR3IAgQgVeY21kWnSnRxl2kmdz9ar1/DqdwfiDeXXzhoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JwoG9EM1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UCbAJc006526
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 16:04:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vEvv3sPokNm+5Tvls5hoRKnz9U+q/8E6FLS31sVCUzQ=; b=JwoG9EM1tZr7rcRP
	xTKJq7md72xo2IERlDEm+qAODSt59eUv5uetLd2vxYsJ0MyZrTiZl8baDLpgTW7i
	9qntRXzozf7YWEMDcz7RlN0CoqqiK0fxLge5TBRqkQdPKVjyNN/+T1liswLfU2IR
	KkPHINTmv7GRsR8HSYknlNwcZtiMBEDrZmSfNwfMkIcLG6HdJIbk4UgVOz3VN5u5
	0Oo6Xx3yUdFSmK0sP13O2grYEseeCGVRatBnj9c8SWBHL4j/iYtKnfPFxHrLtEkI
	FSgBnr09kYrFmsKsPMAE3iZn3C/+96BrjIbFX27g39X30mqO1W9YzT6J2RwTfTux
	8M+bPw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 485v1xhugx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 16:04:12 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-23fc5b1c983so13242005ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753891452; x=1754496252;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vEvv3sPokNm+5Tvls5hoRKnz9U+q/8E6FLS31sVCUzQ=;
        b=Co0fFX9evB9WYzEu+UZEN87rMj/EeNP9CluHfXo818nfk99Bm6jWSNjP/f/QcNrFZC
         J4vjBTR1gVorYYeCzjLe1jtQVax22QsDWCipLlSoDUJ6GK/YdCV+EXEfsbXeRwRCtLys
         KM6GGlOX4kz5xjpBJA3SrEDWZ7vd9nP39Xm8tL89fZDOx6S5iIpZoLXUdKmLZEKVl25O
         CGbgaTkigIfvjPl/ExeRy3b/SVH1vqdgVAWatNyx6BDNVMA5sV2CiUgWUtBI4a9Ozg7D
         Z26aMmMY9Mr1zMeC4YonZpgrqS8nMvN+QV0Yo/A+VgZnHvgDS8sZLbHQ0yrE44SCIIsI
         rshA==
X-Forwarded-Encrypted: i=1; AJvYcCVpLLwOqm6oMd2miD4YMANwULtDjgj4UIlx7aFmcO8o36cz+nkwRC+CTV/FZEMJ97CkZjMFYzkmRnHcyt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUAZnDi61SOrdVf36lFKkwndfxXWXi89WY53gRrgyDOsyrvbk2
	Wq82tEr+O1z8jOEkpZ96+OG6W1k+zsjozN3VLGECn9HhBnkilqf7KAwAs9oRfloYAB3QDnRMGgN
	Ex6yokprwTPTw3yKzOTmiuELuqTjVzNYwFjZ0fJ2MtjVR90bWXhL63u2AkzQSFYl24ro=
X-Gm-Gg: ASbGncutGDMLOp+Ue1U7VV5nAKnkR6rIwQhUrJLZztAQ4h0+kfSNpkcvsbJpjpza99z
	g/j0ZYl5UrppaCXqrqKikv5NzAradWXjdesACpXpBRMVtOhczCFbNzwpqgeiuahSHlnO3XEcKoA
	hVpXajFd1yVDdJvwssly05q1D3Tcqs2MVuUff+jCNjaiSQRpEvOtyDwho44TrTrDt10Ah4Aip4D
	OTvpeiq9eNL/cTK4mM1r0w++6JdFipAqKFT5uKtSOfeenjys40cUjCWXLJJXrMS70stxt8a+z4/
	B5Lt+5jDnBPo+kogP+hapza4vk8JaW+f3XGtUQLYeqB598m3LjW75mHS0BQiXbju
X-Received: by 2002:a17:903:22cf:b0:240:86b2:ae9c with SMTP id d9443c01a7336-24096884152mr66915835ad.14.1753891451792;
        Wed, 30 Jul 2025 09:04:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8Yb95xSZJkf9AVMlWP7JbQuzQGC5knnubldONN4jD2EOrvcArH9iLv1igJvYIL1fbR7bDCw==
X-Received: by 2002:a17:903:22cf:b0:240:86b2:ae9c with SMTP id d9443c01a7336-24096884152mr66915295ad.14.1753891451165;
        Wed, 30 Jul 2025 09:04:11 -0700 (PDT)
Received: from [192.168.1.5] ([106.222.235.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2403c96e4cfsm67345655ad.25.2025.07.30.09.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 09:04:10 -0700 (PDT)
Message-ID: <54b36b37-c1a6-4e1b-842d-a1d4872da180@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 21:34:06 +0530
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
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250729-topic-sm8650-upstream-gpu-acd-level-v1-1-258090038a41@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDExNSBTYWx0ZWRfX0RXKRzbbx8R0
 emsntVsFs+SPjTBYmBOOX1obv50gA6J1Bbha6l1fknuLYsIBaRwir5Q49Fa5ACllxPUSaY67XAn
 9G6HVFJTOudsxlczixGQpme6UVRb6p6STezVf3jUYOX3iBlbjnVGUJjY2XZQX0B+1lH4zvg+kpn
 IYbVb0t9jpjDLKul0AUrAv7uSd7mEHbEM53FL+FjDpuqU46PRF2PK5KWuSicjau9U951e/Ftxs0
 dc2ksTjvE8qDmvkzKNOvNBX1o17Pl4KygqzUFloKd9pwn/kd7iuP5fH4zjmsGRsOaeLbiqll5xg
 LFeBs8xqpsyP34HwUfzAu+gNdtbrOadK7EC+Tm1wFzOPrBbhlaTxLyY2spsMpfb+KqqoS9FSVap
 iOQnHndO6JIpdhsDIQaDp0BGs+RxwqLtSUdxGEfeNjvBAOWODFpGBszk7OSBd11yGtubipO1
X-Authority-Analysis: v=2.4 cv=JKw7s9Kb c=1 sm=1 tr=0 ts=688a427c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=HRpvt/FSzHA3SJMKks594A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=S8knCjkmKkfcu8I3GasA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: hiYobzQhDgfJ1KD0vfOPNbZDplAW9rv-
X-Proofpoint-GUID: hiYobzQhDgfJ1KD0vfOPNbZDplAW9rv-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_05,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=910 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300115

On 7/29/2025 8:10 PM, Neil Armstrong wrote:
> Update GPU node to include acd level values.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil.

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
>  
>  				opp-366000000 {
>  					opp-hz = /bits/ 64 <366000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D0>;
>  					opp-peak-kBps = <6074218>;
> +					qcom,opp-acd-level = <0xc02e5ffd>;
>  				};
>  
>  				opp-422000000 {
>  					opp-hz = /bits/ 64 <422000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
>  					opp-peak-kBps = <8171875>;
> +					qcom,opp-acd-level = <0xc02d5ffd>;
>  				};
>  
>  				opp-500000000 {
>  					opp-hz = /bits/ 64 <500000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_L1>;
>  					opp-peak-kBps = <8171875>;
> +					qcom,opp-acd-level = <0xc02a5ffd>;
>  				};
>  
>  				opp-578000000 {
>  					opp-hz = /bits/ 64 <578000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
>  					opp-peak-kBps = <8171875>;
> +					qcom,opp-acd-level = <0x882c5ffd>;
>  				};
>  
>  				opp-629000000 {
>  					opp-hz = /bits/ 64 <629000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L0>;
>  					opp-peak-kBps = <10687500>;
> +					qcom,opp-acd-level = <0x882a5ffd>;
>  				};
>  
>  				opp-680000000 {
>  					opp-hz = /bits/ 64 <680000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
>  					opp-peak-kBps = <12449218>;
> +					qcom,opp-acd-level = <0x882a5ffd>;
>  				};
>  
>  				opp-720000000 {
>  					opp-hz = /bits/ 64 <720000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
>  					opp-peak-kBps = <12449218>;
> +					qcom,opp-acd-level = <0x882a5ffd>;
>  				};
>  
>  				opp-770000000 {
>  					opp-hz = /bits/ 64 <770000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
>  					opp-peak-kBps = <12449218>;
> +					qcom,opp-acd-level = <0x882a5ffd>;
>  				};
>  
>  				opp-834000000 {
>  					opp-hz = /bits/ 64 <834000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
>  					opp-peak-kBps = <14398437>;
> +					qcom,opp-acd-level = <0x882a5ffd>;
>  				};
>  			};
>  		};
> 
> ---
> base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
> change-id: 20250729-topic-sm8650-upstream-gpu-acd-level-1c430e7f158f
> 
> Best regards,


