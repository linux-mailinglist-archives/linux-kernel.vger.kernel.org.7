Return-Path: <linux-kernel+bounces-756751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6E3B1B8CF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0289F18A6B68
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4A71552FD;
	Tue,  5 Aug 2025 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pCAT0AcO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA95721A928
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 16:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754412713; cv=none; b=rvRI0btPx2KXmO+we4niSR2IL/Ot0+l1be3BHy9gV1zHTSVkZGOXHJyXDhpKZ2gp3GfluApiNsvoe7V/LReDjWhn80kUea3Lk8h6074/CggX9RFPv76a6Kzy99uDLxdLlUkfDT4Uf2YeuFGEHd2rzJ0DRCBK2v+dVR/SO0ZZcFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754412713; c=relaxed/simple;
	bh=9HuhvcVgcVWA8vrm4ARyM9LsZ5rPP/+FsBZiP8MsXi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nKxpnDLLNjdKy0goMTv9L0EbED1hXavblEJWwEkPLjVbUOGqPseSiInpU6rYbP8xl0PagRl5DEdmdIM2Hvp9dFuhFRXGd3xutSwKjDpQzDyx1zS0nYrZa3hO3fvB51J/B2jP3kIE3WkMW6HaeA+Ddo9rbRzE7RiPHcST+GSjXDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pCAT0AcO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5758O8iG031930
	for <linux-kernel@vger.kernel.org>; Tue, 5 Aug 2025 16:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OrW1DzUyVVmeukVpqBYLRBGHiHi6hAxmrlXRAz69Tg4=; b=pCAT0AcO0mia2Krn
	I5LdhZKGCdJhYIpHxXpH//mQqwhzDd1SuRsAm8+r3L0kU2A5sPIwaREWyg7O5+vE
	V6VO/yX6j8x0dL36xOKSon9f4dMuXYroUovwSc+te9rqlDfDn37q/JRjU4TIrTEo
	KVvLFYopbObI5IjIab/JM2vz+V9gI93DFVKhbgENPjfcRgEXuhcbvrfZl47NrenQ
	zvLa5DZ5PHEpG/ICyvleB85odDupRjAQXwNRnRlfsjHGz8rE8myWwj0tNa63fmiU
	EJwU0iCYpHOb7XgaQZiUD8Bfp5VDSAJPU8GMm4JZyLV4t++AjTOvZC1qzJcUPbDb
	/EXP+Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ak5a5wwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 16:51:50 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e800094c82so52017185a.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 09:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754412709; x=1755017509;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OrW1DzUyVVmeukVpqBYLRBGHiHi6hAxmrlXRAz69Tg4=;
        b=be5/crwCLeFX5yBfCyK+kQaYbzGXrmjID9G74IS5qU7xQhjdX0x5MaZgtJlXjxsWcN
         Aq2bxIaz2XddODv4tzHZNBwGEFHx1DzmjgYyOuxvp7LK1YgZI2zX5PQ4fBSuW61VA9MU
         MSl0RCOZKfRflHC708jfzA2xKefYQBHKt9bJzTT9mCfVo4xZ5Vjvhtgn1VaxnEx/0ICG
         3hKtinhn4T55ZD4/MTbgINei2jM7LlG5dNMyiPprqbiPmBunjVVMsnKAgZxIqBDsAI86
         RqseK/cZXKTd0QMzsE8V+FKxwQE55lwiFe4wZOzCacHrF3HA8pFfHdV4gzfDlaMxWJup
         Gx9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7UbyJ1NszzUbTZ6ps9GxEu5xMWTr53KzgkYb4lIrxkM2h9UhhCA3VbmmAMD/UGQzvbhW/8nqWy3aox8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMTpuiNoFB9KibVDVznlNesScRe1VAtPYWKg2En9NITqp7jhBL
	9LuN0Z55ojZIXJufEkKqlhnJcYXvucJd0RqBPHrZZsIC41UgnK7Sgi6Q4HQI1pdHgmrN1Or4YfF
	3le76LW/OqRiq14H6GQpM+7exrTt+RQzSdi/pmKDAaQDL+3iFjRbsOmYf6ARTuJkpdAo=
X-Gm-Gg: ASbGncuQJf+N+7uPiTZ9OxmCP2KoLXkGWR1uoTbnFkqdDLcyRPI19BpXciL1oVClDJb
	LmK0kheNyHfvuUqsXpMYLHTpDpu3is0Nf+ZUvgc3NU53u7vltcah935gmxrmzwcpkRZaXxURVzB
	xyOFf8Zvp1W3Yk6RXwI7FFJwRjm1LSI3yMQRPDB6/R1cIsxTLg2tLtX6DTtY6xEwyXdhVuH3C3g
	XBz31nzAdbM3FgSeMWZgVEasKIn34xvhqor5k+2nCgJzPCvyiXxGE1cchZmy6G+1ymNMJH/+72c
	HJM+Sv1CTOpCfnLg9YZ6rxGhLGBw3oyO36hrreo22GM9eyD6OdrRskmKN4M43uFUR2B6raH+4CA
	JVJjX4ROGy+9AZorW+Q==
X-Received: by 2002:a05:620a:198b:b0:7e8:c4f:614b with SMTP id af79cd13be357-7e80c4f6500mr234284385a.7.1754412709479;
        Tue, 05 Aug 2025 09:51:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsRfnZFgHHEyQmRgmvW0pHpImAXIwU7QUOWWa17SPxgdAKAosD77jO4lD+OvVYYq1NIsK+5A==
X-Received: by 2002:a05:620a:198b:b0:7e8:c4f:614b with SMTP id af79cd13be357-7e80c4f6500mr234281985a.7.1754412709002;
        Tue, 05 Aug 2025 09:51:49 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a076aecsm933342866b.9.2025.08.05.09.51.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 09:51:48 -0700 (PDT)
Message-ID: <5590fdab-0fa3-4ac0-bcbf-d2cb41be16dc@oss.qualcomm.com>
Date: Tue, 5 Aug 2025 18:51:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: sm8750: Add adsp fastrpc
 nodes/support
To: Alexey Klimov <alexey.klimov@linaro.org>, andersson@kernel.org,
        konradybcio@kernel.org, linux-arm-msm@vger.kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        srini@kernel.org, quic_ekangupt@quicinc.com,
        krzysztof.kozlowski@linaro.org, dmitry.baryshkov@oss.qualcomm.com
References: <20250805162041.47412-1-alexey.klimov@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250805162041.47412-1-alexey.klimov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDExNiBTYWx0ZWRfX97guqnjsBA3S
 zn3fQuATYHuXjN3OIZ9GpTgS8oy/5vbpPuVF0Mczee7o2QvM7bIWLCLwDZisswHGg+LTofQPfaJ
 X4zwELjcNyfmyPrbyjIOU3gHUMbimICBrnczrHWnoFfnZce1SrH2X5evX8bDNjZ/CTY/a5jV+WB
 vAFyhoD1E2UHbW9kpSF/RsqqnwxUYQnihfnh1cuL73uu2u8Ysjj957X0C/6Fyvekqk2EDutXhcW
 tNP8Llv+nRW24bdfHwdgbFsaZKtP8u+D5O8Ul0d1//qeQBARXCQ156YIgn8FMGPOs0uLafoKu6H
 7CFczCANMwzMbFo5bYcgyYr33pEbS3jnFwJ8CnRXnata8n3895oWxzLbuyqMxPGZjAZyK2Z/yUw
 N4fhXsCKjEVUw2edgptMLaJr6EZlsUtkXs50wVPBZiQlsYZEFxvk/7FYBlMEX9IkcEMj/lCx
X-Proofpoint-GUID: VZqrzdAyAPMvohMQTvyc6_btToK95NFj
X-Authority-Analysis: v=2.4 cv=LP1mQIW9 c=1 sm=1 tr=0 ts=689236a6 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=i5LmXQDNGShexaeZTkYA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: VZqrzdAyAPMvohMQTvyc6_btToK95NFj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050116

On 8/5/25 6:20 PM, Alexey Klimov wrote:
> While at this, also add required memory region for adsp fastrpc.
> 
> Tested on sm8750-mtp device with adsprpdcd.
> 
> Cc: Ekansh Gupta <quic_ekangupt@quicinc.com>
> Cc: Srinivas Kandagatla <srini@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---
> 
> v2:
> - removed qcom,non-secure-domain flag as requested by Srini.
> 
> Prev version: https://lore.kernel.org/linux-arm-msm/20250502011539.739937-1-alexey.klimov@linaro.org/
> 
>  arch/arm64/boot/dts/qcom/sm8750.dtsi | 69 ++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
> index 4643705021c6..cc74fb2e27de 100644
> --- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
> @@ -7,6 +7,7 @@
>  #include <dt-bindings/clock/qcom,sm8750-gcc.h>
>  #include <dt-bindings/clock/qcom,sm8750-tcsr.h>
>  #include <dt-bindings/dma/qcom-gpi.h>
> +#include <dt-bindings/firmware/qcom,scm.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interconnect/qcom,icc.h>
>  #include <dt-bindings/interconnect/qcom,sm8750-rpmh.h>
> @@ -523,6 +524,14 @@ llcc_lpi_mem: llcc-lpi@ff800000 {
>  			reg = <0x0 0xff800000 0x0 0x800000>;
>  			no-map;
>  		};
> +
> +		adsp_rpc_remote_heap_mem: adsp-rpc-remote-heap {
> +			compatible = "shared-dma-pool";
> +			alloc-ranges = <0x0 0x00000000 0x0 0xffffffff>;

perhaps size=<0x1 0x0> (1<<32) is what we really want, unless the hw/sw
is allergic to accessing the very last byte in the 32-bit space

Konrad

