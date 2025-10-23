Return-Path: <linux-kernel+bounces-867193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50125C01D8D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14EC13B86AB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B5E32D42B;
	Thu, 23 Oct 2025 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MjibQu7S"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473B1324B39
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761230026; cv=none; b=nT4BrDK6vxE0o21X5wh2HFxKqmYzJNs8EcDBjVYfYKHIlWyfaRwcec4rU8MR5kzbNfOfEw6glmxrkvChjJsDtuYA1qmLMmyK7D4NFHtv2wicLOWgs2z4AuoS6fUgdQPrgpXA6gFkPgctFnr6zdhgOLa6WpGIyoEXrjp1OgvfAxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761230026; c=relaxed/simple;
	bh=a9zQnr1U/qDAlP9ZQNBclzAJC9hezB8uCMOARh7yL1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ORozUeyV41DrH0JwcSw4LGkqknyVWtUbgGNRW9R4x9XMHqB3gOW9dsh8WsV005wvCt3LLA8qEC0uX5pJ5oQ85LSyaqjz1ZiAZKG6WMncEf+OAsAAHqvka8BHRkS79DoYoXd4L0pI7/wC4zkwR5RoeWHO0JOzHZ9cf/muxKxztHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MjibQu7S; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N76TTj029864
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:33:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cAZU2ni0iRL+hjBDIOqvgHG1OUScWl3zzw0/P027wq8=; b=MjibQu7SnOSqIJhw
	b2KRd7Y/1MVog5z09DjhnaEUP8Zj+3a9EBrBBfI1WLetNT+RTz/5fwuKOnoHbM9a
	mlagnuAjHVmaQBCEcD73IfjUzRYgvdPzdgwRhHbjMu9mq47ywGlU6ra3+ATPKY51
	RUZWEgcakb3B6K5Tw7A7kPt/P8t69jRN8BoKAk21U2VMK3e5n0rmPhFcAhCIyEM/
	tolbQXq+ACPidfvCylBKLD2E2MnQM4cxtoaGd09BgFFNf3Tzph4BnXnyX171ejyx
	49r+mHn1HldIhpMki8tXJM/JP0JIToEeUIOy2vG/1OKB3dpQZWlTcTP6GWnH0HMp
	n18Onw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2ge8qmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:33:43 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e892b1c102so3358271cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761230022; x=1761834822;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cAZU2ni0iRL+hjBDIOqvgHG1OUScWl3zzw0/P027wq8=;
        b=DJ67t6pBg3I7MQVcNB6H8cN0DxbuoCUlYqqhzprl7XsXOtKOMEE8ArtPBKCefWz5uP
         xhYRPcbmtOx0YEjOqkGgJPMS4ppQmj1bGdkMA+T1wYh1ysQ3A4w9h/il6xl7jdTqtla0
         mvudYYQmPUEJcMAaHzjKB0Cym7OWS3yuHWye7cdcJUT+IN6o7/XqsvTtOykW0b6sfMjY
         US+7r+tW2oIrH8vYnt41uzhERDUsr6AMyDypMaug1AsciRzhMFQHXdbihnsNmpA0MhvM
         OQ1KJQn+p3enK/DJD/g2Lb4pQ59rouASMHhzVL4s2yHFcJLExS2eL2HQ4agGjrlPK8Bc
         mAEg==
X-Forwarded-Encrypted: i=1; AJvYcCW1sQnHbIcOiRXixxFjL+Ppd8rrezqpvNz/0u5cX8MbfDBZCXFWtPuKraJgu1UQ8XvjY+K+MdUWDEsoGIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/sYGvelnIok2Nvv0xtqR3ssUFIFUjErfkpxneAH+Iog637Fxr
	+kCVnhSddgwByk4qNZ+vAmuQf4bkny/bRyoWlhhiaz9zJVqkThRfaRmEiEHhrvAAp4NdEBUymuy
	FHxZ3A+kvlbR25jRHUe4HnRkweMF/Ltctzu4iZkpHZ+aiyOrX2qk48gD82x6KIyYnQjg=
X-Gm-Gg: ASbGnct3vMfCbZRYrZRZERBuMlyiyf2HnQzMK77fwqj8klUzbGU9DCkoftISbLoU8Gn
	LAnCBPd1O7uPx4aNVehJI8KYkmZ1xFozDy5+Kx76Xu2D2v/pg6NGTFy3+Q0Ab3YPjHn3TXPRzcV
	NIERCDJQCVttpqv7Xdy7MZOY97ZuY4Y7/eXx0YQW/O5vDNcoNa2S0Poi4v+xb/yqBLlbDOUHX0e
	oSPecjaFrji6xObnFTgKc/yWO+Vfw8JthdrrEPbl7CrvJjPWVy4SHti8Q/zZmVYTW+DpzXYiu4V
	u9qMfTOp2s1GJq2ztkO3JDOnltoCshdzMg3Z11JI+BDbDGBOr/p4QJ9VVQBMD0WI3sscYCV7epF
	YxLwnwFCMh6Qk+cWvU3903g5bK4PEWyIn0XgEOc2uvJRUe9hUgn/nLt5h
X-Received: by 2002:a05:622a:8c03:b0:4e8:a54d:cce8 with SMTP id d75a77b69052e-4e8a54dcd9fmr169633751cf.4.1761230022388;
        Thu, 23 Oct 2025 07:33:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJNFwNiX8mrBllU30A59G91vBsOifSuLRksl6K7fNrpM1xj2wDRVEAhFx96cud4Ytjso9xZQ==
X-Received: by 2002:a05:622a:8c03:b0:4e8:a54d:cce8 with SMTP id d75a77b69052e-4e8a54dcd9fmr169633411cf.4.1761230021946;
        Thu, 23 Oct 2025 07:33:41 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e3ebb3743sm1848497a12.7.2025.10.23.07.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 07:33:41 -0700 (PDT)
Message-ID: <cb166706-af7d-40e7-84d5-57c028755cdf@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 16:33:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: qcom: ipq5424: add gpio regulator for cpu
 power supply
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com,
        kathiravan.thirumoorthy@oss.qualcomm.com
References: <20251023040224.1485946-1-quic_mmanikan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251023040224.1485946-1-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfX/3lyopsL/LX3
 s91hKRO/SikRy8ZyDGGI3PxAuwHdBiruPAep5qPhJikRX9hp1iU/YZ9Fdk80kJ8JPLFR9XLn+Lo
 qnB8abOLfkCCNxuwj5E3zJP94TXz18kZAxASYjq92k4L2q/DI+bQEUytXqmrP+2RrgJy9cj2/OD
 wAr026JIlfSFxeddDzaz3HdAxti2q8T66FsYrX79wqvhAQdrURKxTOLUXrF4XVRlmWH3J8fNQEr
 vOgVgyE5IkkE59RHw0hka31fGhvuTDR0CPcGgV+ItPCwlO5vNfxvQuYuyl/5ji9jv9KcKQOBy51
 TvVm6YQPJzAf6cy0swhwquUiKC4e+gk6cH9deTI7SzBIjL3GwsU58s03c1G6RDu+3e3uFr3do+3
 F9H8rg1ArmckwbAGFegrm9lbZnCQjA==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68fa3cc7 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=J-FVny67hWSXZtLCYe8A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: g36_HmixWK0ofW8upjM4rxx231swzhaw
X-Proofpoint-ORIG-GUID: g36_HmixWK0ofW8upjM4rxx231swzhaw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020

On 10/23/25 6:02 AM, Manikanta Mylavarapu wrote:
> Add a GPIO-controlled regulator node for the CPU rail on the
> IPQ5424 RDP466 platform. This regulator supports two voltage
> levels 850mV and 1000mV.
> 
> Update CPU nodes to reference the regulator via the `cpu-supply`
> property, and add the required pinctrl configuration for GPIO17.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts | 24 +++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/ipq5424.dtsi       |  4 ++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
> index 738618551203..6d14eb2fe821 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
> @@ -46,6 +46,23 @@ led-0 {
>  		};
>  	};
>  
> +	vreg_apc: regulator-vreg-apc {
> +		compatible = "regulator-gpio";
> +		regulator-name = "vreg_apc";
> +		regulator-min-microvolt = <850000>;
> +		regulator-max-microvolt = <1000000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +		regulator-ramp-delay = <250>;
> +
> +		gpios = <&tlmm 17 GPIO_ACTIVE_HIGH>;
> +		gpios-states = <1>;
> +		states = <850000 0>, <1000000 1>;

Atop Dmitry's comment, please make the states entries 1 a line

Konrad

