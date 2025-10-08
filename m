Return-Path: <linux-kernel+bounces-845359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C17FBC4926
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 13:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F1EE3B5646
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 11:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD7A2F744B;
	Wed,  8 Oct 2025 11:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cav5u0+G"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003DA2F39C9
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759923061; cv=none; b=F3UrdV7m9IwPTHBELIsFH66oHDgeI80N7cB5L3henJyEV1tVwUN2pRHAQJtW/3eZzd62DdAk4jVl2Uy4upkblqR+DEJRq5EEz541hMhaWTuJ63NeEanoP0yXgLK3Y9KhU/flZwfkJFUutp/E2i0o9Gjikt5zuH98JlFzRIX3NDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759923061; c=relaxed/simple;
	bh=zu8srtjs/VvDHGLC2NU4E6Rl5RoR5FKBFQQLdfu8gKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHncaRQrdsbNMuAHJrv3ts6niDPpX7mw0GJZMWB6uWPkjRDlH7go+jh++cUjgVXolzao2kFthpmHY1PPMZT8jBjVmkfzVcyrr3bRhwNy1/FUbmsr3ueIKdptv6E2pCs6NRIU8mkMxXvEqF114rKcljK0JgVxrYRge1sxdQmACHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cav5u0+G; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890OND031357
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 11:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oeyjEDktIox9UBLyHqazReHxq3mp8y+F8tUeuGtBHUU=; b=Cav5u0+GM3KmIWYD
	wkaWInk/R/COwo1MmoHFo0qKXFhEKaNl0Tt8B+/9VU8T5sZnjecKg+5o/nmYOlTu
	bT/+9l2gFbf8RgcQe4r96ZenrQMe2Ohe7e1K6Gil22sLJ4VwCB85RpFdx1429g49
	eheqb9OrYFH5ORTn8Sp7rBtwJuEd4gPS/pvEq7vIJAkrC6acz4B86OEidb1Gk8Es
	OfSNFM8wXlcX9Fekf+LIiy0wiXJJaIdjllohi9shM7JswfxflftUJVpCzzXMUhAA
	7dV7KEl4PB+Rg2fh1aBo4Q8CMsuEpLx3cE7WljrJuZnux424TZwrHzKRva/3dHWW
	vr2JGQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jvv7t48f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 11:30:59 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7900f597d08so3388441b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 04:30:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759923058; x=1760527858;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oeyjEDktIox9UBLyHqazReHxq3mp8y+F8tUeuGtBHUU=;
        b=g9RZbUPnaJB1bTsC+1/O7tR/N18FcbQUVVYz9dpV+SHZvwJEB3qWfLD4yYGDiiT0oq
         iZ38VzTf0R1IuTWxeAYYKUYK20NPANct9lPrt7IfAo2vp/XLTjO+sW5ELB+Gxw40XQ0K
         w+AsLFDyGJ4P3AvKlZ6KKZFNPKWqetRtrjnq7P8F0UQkC3nR8WZv9zHDxBGdRBgtgt+a
         cZAitSj5wiEiebq2/jU3xdxE4fB1fUJpXeFDYya0QyILCOlz3xHGlinS2Buc1Qdobs8D
         /wbar0QyJeEYy6Qab7Q9uKB1rhcmzZmYGbkMspMGisYZ5I5RKpHrk9oZP2E9b09cFTrA
         /VzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/YS0/zMd3wYIf78AcQB602eonHnsyHOYK1O4tCi+fAGGayFAIX6yNyYMJx+eUS/FF6Q7SyKdUvbI6Kmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC9XOZ8VELl6f90WX3p6+qoZYzSjzoAu+tGB4/ARV6rzvmo54H
	OXMUN01MXoSYdiMwVqUUUlgYc3Pr0QcZf9Jtk565CnZNpfKY3vamNx9S8jc88hqbTwnGzvPaZhv
	/CU2Fr3V4fbLyoAI0PJ/1Ba3NZML2jjAxwMzZy9JBi6OLK42RIp4Yp5yEvcXQVXAv7pE=
X-Gm-Gg: ASbGncv6+fwnq8gHNJDApWn7k4Jg+ejhQ1RGPBPvgLierXCCcfVLXP70Uh7KP50g7jc
	soECB34GBzrM559ZxZagjHf8QIjv56i7sVkwDHE63rmBzmsjHySw8QzGmFzPAqD+C3qggMhNc9J
	Kj20ByL2HQR5e/tFzUk+064DprunbCfUYPVV7MVE/8D6vgGpuxwQlW1zc3PF/WCtqIimZJZpeuc
	IRQQ2bvp8yTMhKA5pceE6sSrcyUMNtoywGi8zo6+0kxkxUw7MYfCjVocZGc/BXfIUBKTG3Cf5ze
	UepDyWre4sSHfHHU8hXMyzya7R5GpOLtZUt54vPKmbLauCMj19nWGALG5mAD4Axyp5P4ZIpGPQD
	Crb0Z8ADv4VGhy2Xl7KnqolVNaPnJpkFjoNLfDM+WDXf6TVrWgqt9gpAEhkOszsM=
X-Received: by 2002:a05:6a21:9999:b0:32b:7001:6601 with SMTP id adf61e73a8af0-32da814f674mr3981166637.25.1759923058246;
        Wed, 08 Oct 2025 04:30:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKUu9FJQdAllcNJOPLYlAIk3iB9sIRFpyX5MjL+2NG5pT1aPZFr8VldEU2DqxpUxZzi+Cjkg==
X-Received: by 2002:a05:6a21:9999:b0:32b:7001:6601 with SMTP id adf61e73a8af0-32da814f674mr3981116637.25.1759923057714;
        Wed, 08 Oct 2025 04:30:57 -0700 (PDT)
Received: from [10.79.195.127] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b510ff9a8sm3107175a91.8.2025.10.08.04.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 04:30:57 -0700 (PDT)
Message-ID: <6563611c-b7da-49b2-822b-79c5c5c67237@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 17:00:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/24] arm64: dts: qcom: Introduce Glymur base dtsi and
 CRD dts
To: Marc Zyngier <maz@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-3-24b601bbecc0@oss.qualcomm.com>
 <867bxm1y8j.wl-maz@kernel.org>
Content-Language: en-US
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
In-Reply-To: <867bxm1y8j.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAzNyBTYWx0ZWRfX7QmqDCuC0ejp
 vOMqeAeE5vFhiBGydgDe7FpElfk/sOxxL4iJfA2xTq3uoomPJ3jTmTiS9nmvJtWUpTv/LDqJTZj
 mwN8/sG66OVyDIXKvhylJTzsf2tnaZSHXJLwDcPoOEqgqOVSodGCImll5hXPHKmNRTXqG9zTKBA
 6rU1A1FF56X+YPCUMOOFC0P1FJ64whHPktuVw4jK0RtJhB0jCieL4v8hpZIXVuf3JiWZqh8sf4q
 AiGrR3kjhO78jwTGSe6YFrp6VSpBO4NMmmw5Zf4nanWSGfQy0Bz6u6+2B5VERC/Ima0M1X2MKwh
 HstH7alQNEwZlQuWlb2XYLRuWBnMgk42VMyrMbdpjWtwD/tb3hxwXu2qK5vHXgLBE93jrfuFcvC
 bnE4yF5kqGoGnOvvKuU9GCObrdFBIw==
X-Proofpoint-ORIG-GUID: qzGTrsSk15msqsRhJhAhsP07AVTDy7I4
X-Authority-Analysis: v=2.4 cv=WIdyn3sR c=1 sm=1 tr=0 ts=68e64b73 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=mQOHZLyPYVvQyi9y9SsA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: qzGTrsSk15msqsRhJhAhsP07AVTDy7I4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 bulkscore=0 spamscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040037

On 9/25/2025 6:32 PM, Marc Zyngier wrote:
> On Thu, 25 Sep 2025 07:32:11 +0100,
> Pankaj Patil <pankaj.patil@oss.qualcomm.com> wrote:
>> Introduce initial device tree support for Glymur - Qualcomm's
>> next-generation compute SoC and it's associated Compute Reference
>> Device (CRD) platform.
>>
>> The dt describes CPUs, CPU map, GCC and RPMHCC clock controllers,
>> geni UART, interrupt controller, TLMM, reserved memory,
>> interconnects, SMMU, firmware scm, watchdog, apps rsc, RPMHPD,
>> SRAM, PSCI and pmu nodes.
>>
>> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/Makefile       |    1 +
>>  arch/arm64/boot/dts/qcom/glymur-crd.dts |   25 +
>>  arch/arm64/boot/dts/qcom/glymur.dtsi    | 1320 +++++++++++++++++++++++++++++++
>>  3 files changed, 1346 insertions(+)
>>
> [...]
>
>> +		intc: interrupt-controller@17000000 {
>> +			compatible = "arm,gic-v3";
>> +			reg = <0x0 0x17000000 0x0 0x10000>,
>> +			      <0x0 0x17080000 0x0 0x480000>;
>> +
>> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +			#interrupt-cells = <3>;
>> +			interrupt-controller;
>> +
>> +			#redistributor-regions = <1>;
>> +			redistributor-stride = <0x0 0x40000>;
> Drop these two properties. I assume that your GIC implementation is
> compliant with the architecture, and doesn't need hand-holding.
>
>> +
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +			ranges;
>> +
>> +			gic_its: gic-its@17040000 {
>> +				compatible = "arm,gic-v3-its";
>> +				reg = <0x0 0x17040000 0x0 0x40000>;
>> +
>> +				msi-controller;
>> +				#msi-cells = <1>;
>> +			};
>> +		};
> [...]
>
>> +	timer {
>> +		compatible = "arm,armv8-timer";
>> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
> You are missing at one interrupt here, as the CPUs have both secure
> security state and FEAT_VHE (hint: the EL2 virtual timer also has an
> interrupt, usually on PPI 12).
>
> 	M.
>
Will fix both nodes


