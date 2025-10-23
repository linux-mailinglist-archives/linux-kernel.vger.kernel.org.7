Return-Path: <linux-kernel+bounces-866681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44877C006DB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 741BC4E8F29
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E037303CB2;
	Thu, 23 Oct 2025 10:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="blfamD2V"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0642F6919
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761214708; cv=none; b=BwWCcHkNT1MSyPagMxFozrW77icG0wrawhXb8tnN0zttLhrJo/BRzKoQ5mQn8J6L4wyTlL4rCOA8bE4v/RuXH7TfTmWqYreo30lXQUNmeras5zKu6b14lqXgBIx4b2rt+6JwY/AxbEzDLxU70nvifdjdKpwERJkt5PHTUlfWoWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761214708; c=relaxed/simple;
	bh=1RnLQ3v5S/1nsTAmNc4jlYHFj6K1Jk58trMvxEAtJEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GFFHAJWOCZOPEOKXA2EtRfR9eLYV2KZlWJWa22Yfs9i+I3LrQZb7syU/9vsV/BBlhjjZAGcBOM+gcGmqFwo/Bini4+vdkjXve9+RpN+pZB5jAvU3n6y6o4uC65CegCSlPrn9f93jjakHclo+JJUKhx0anInr7ByibEulSaccJe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=blfamD2V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N78RIp026360
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JXQvqOCIifU70x6E5l/eBJ77oOljySsiWz1sAln6OEo=; b=blfamD2V0K6KFvxb
	KtyyNqCrw1doC2aSK8SH3SNG9hRhDkw5nyy47f9wMKb9WOIVSGuOX6vw6ykhAdlP
	J0wmSOXouYECU6ax/zN2h1wGVNzrC05nt89moMyGJh4IpoTVesnP1jqfoMmhniL9
	3V/IQf17jSYCd6CKvTuXx9IB2Qj6RNmvlYM1vDxYsd9XXWQg1d9Qh35+gPxSaSwY
	wc8B+FjDPtlVX/8ULr8OIPjHHffYkGQWxwtxlBowSYDG38ufYFe9pnWX6Snn6CXH
	4+5m3a8cXw7ngeLRfhvwPEkzoConjWu1GgQr11/x6kvJWgIR2qbte0DODJDxr7zN
	2Botkg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v42kftce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:18:25 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2728a359f2aso2410395ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761214704; x=1761819504;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JXQvqOCIifU70x6E5l/eBJ77oOljySsiWz1sAln6OEo=;
        b=hIO0ZOZAD2GSLYQmyiOeHy+1r3TIonQ8b6j90p1kXlmcopTZmviwJUuCcOiUVp0Mqo
         uzIS4VX5VcbAoJpl5ijCiySf/pvex7zC3dXc7BRHPCd+LIhNwEx7INPHSCI1F4695TDO
         1WjUrDvmvAbnkshsapI/hN2cY4PZZD4PBNjmmuOdtNH+Yzc3CgVeSSe9wKqisPWiGKNq
         QnajhHSjBUrADi+UIEmKopORtH07xjO/T4sGJTHV4zVyV8pxrMhLJI2tS3tgYuWmdvJV
         ZNshSiWV3wVESQqlv+pfzZNHoMtxS0C5qdK+hPWHVekPjx0ikgUWvSXHSGQHBQ6y//Tf
         PllQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwFfxVLiS4zskie+phydncYJoTvqp7RDPxv1o1fTOmzltL5E+lAuv9gtZCsob7VSQ1zKtpmFSc+Y8B0z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOixB8S7zcRA9b3mzO2sq9N2IHDI8WupxECAc2BR4IXbyVlZ/S
	AAatBET/ZN+nD3Fhaq6dUET1nZHOsUzvwnW0V9oL0KLlti0xhSMr23adUMHsJPflA2nR6ebfnSL
	/u6OU5Lg6g8G/DQlCtzVGzzVUHqc4BmMSb59TJNrDUilBqt/+dFfEgg2lPaD5fVVfNw==
X-Gm-Gg: ASbGnctkidN9SzQ3mgsZpEwrfD42zpIuk2S1x+SpaSPmwmbFYKsM8JgzszMdPM648fA
	6J242V4R9s5uGYkDQzHuD3H9UvvEty6DsF0F462fp8YUzFnLVUwqIY2nUWs32oHv8rGLWBcwdhN
	yJJtLZuJlNKHEZbLAGsjaxmvwPRFa+Sw3X6JaQnjAiE1PlF5t+EKnYYh41DbsxRwsCymqcCfcpV
	38fdYNtWBtwJzqlEuEZynVzl7QxO4sM0ycy38gJGtrXJ03OK4yeeyrBcRujSdf7LcolYyLesPCI
	NahYv0LHf42dzweO37CoqY5U1J9hjOBpz/gVTOySWdzIanZxyZkFr8H6usSKr2VERoc1a3661Ha
	p0QQ9UyQs1xS+krIkPiQpu8gXt0KW
X-Received: by 2002:a17:903:8c8:b0:277:c230:bfca with SMTP id d9443c01a7336-292d3e57324mr66629655ad.4.1761214704430;
        Thu, 23 Oct 2025 03:18:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTvHNcr2Q4NEwC8d4MLm5CmnKWQFx1aJoWBr0IhgqiAMI6t5IKZWuVUChlyP0voh0nbGgtMg==
X-Received: by 2002:a17:903:8c8:b0:277:c230:bfca with SMTP id d9443c01a7336-292d3e57324mr66629485ad.4.1761214703961;
        Thu, 23 Oct 2025 03:18:23 -0700 (PDT)
Received: from [10.217.216.168] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946de10b53sm18460375ad.23.2025.10.23.03.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 03:18:23 -0700 (PDT)
Message-ID: <c83d3438-2baa-4c93-b8cb-5109d2ad84a3@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 15:48:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 2/3] arm64: dts: qcom: sm8750: Add SDC2 nodes for
 sm8750 soc
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
        kernel@oss.qualcomm.com
References: <20251007054445.4096630-1-sarthak.garg@oss.qualcomm.com>
 <20251007054445.4096630-3-sarthak.garg@oss.qualcomm.com>
 <d0e2b0e3-4e32-4cff-81c8-fe943084c570@oss.qualcomm.com>
Content-Language: en-US
From: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
In-Reply-To: <d0e2b0e3-4e32-4cff-81c8-fe943084c570@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: mrsDFVQDdeqbFJsciWrdV_A7ThKE79qL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMSBTYWx0ZWRfX9iYefWIP3uJ0
 ZyeQQcAZYgDMGYjO91zNDJTfFvAxzF/VKl3YxPvfc/N9QL5x2Y/IArkyVY0jy84LG6/fQnvYeGX
 tJbbPDQVsYcvPRyPOFSHACE2751BszHy67HNWwyj3/Wv2iKUFjKvIitvMUW8CDgm/xFwVjT9Td+
 /kaz0jHGcPbdox954PlJH/v8beiF5Ub6YMA+eRsZBM3EARZMJvhaZdb5eBh9U484Yh+krRjKSWM
 tLJ1girHrRJkX8kH8OttjVWxGB1U6uHLECL5vyVE4In1yVv9YpPS+Jjooy6/iGkiiCUwo/sWVgU
 Q1HhiqWr7g2x/IxVziCre/72pAijsTAGxBojPwmOcyUlLA59U5rs31QcVoa/hw3UJz/296MUNXS
 XvKXR8D29+PmRmzeB+4k0gsP5nOLUQ==
X-Authority-Analysis: v=2.4 cv=QYNrf8bv c=1 sm=1 tr=0 ts=68fa00f1 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=DMDGrHW2khae0FuLqQAA:9 a=hK1Zo0tywebNB7qn:21
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: mrsDFVQDdeqbFJsciWrdV_A7ThKE79qL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180031


On 10/8/2025 5:47 PM, Konrad Dybcio wrote:
> On 10/7/25 7:44 AM, Sarthak Garg wrote:
>> Add SD Card host controller for sm8750 soc.
>>
>> Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
>> ---
> [...]
>
>> +		sdhc_2: mmc@8804000 {
>> +			compatible = "qcom,sm8750-sdhci", "qcom,sdhci-msm-v5";
>> +			reg = <0 0x08804000 0 0x1000>;
>> +
>> +			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "hc_irq", "pwr_irq";
> One a line, please
Sure will update it in V2.
>> +
>> +			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
>> +				<&gcc GCC_SDCC2_APPS_CLK>,
>> +				<&rpmhcc RPMH_CXO_CLK>;
> Please align the '<'s
Sure will update it in V2.
>> +			clock-names = "iface", "core", "xo";
> One a line, please

Sure will update it in V2.

>> +
>> +			interconnects = <&aggre2_noc MASTER_SDCC_2 QCOM_ICC_TAG_ALWAYS
>> +					&mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
>> +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
>> +					&config_noc SLAVE_SDCC_2 QCOM_ICC_TAG_ACTIVE_ONLY>;
>> +			interconnect-names = "sdhc-ddr", "cpu-sdhc";
> and here
Sure will update it in V2.
>
>> +
>> +			power-domains = <&rpmhpd RPMHPD_CX>;
>> +			operating-points-v2 = <&sdhc2_opp_table>;
>> +
>> +			qcom,dll-config = <0x0007442c>;
>> +			qcom,ddr-config = <0x80040868>;
>> +
>> +			iommus = <&apps_smmu 0x540 0x0>;
>> +			dma-coherent;
>> +
>> +			bus-width = <4>;
>> +			max-sd-hs-hz = <37500000>;
>> +
>> +			resets = <&gcc GCC_SDCC2_BCR>;
>> +			status = "disabled";
> A \n before 'status' is customary
Sure will update it in V2.
>
>> +
>> +			sdhc2_opp_table: opp-table {
>> +				compatible = "operating-points-v2";
>> +
>> +				opp-100000000 {
>> +					opp-hz = /bits/ 64 <100000000>;
>> +					required-opps = <&rpmhpd_opp_low_svs>;
>> +				};
>> +
>> +				opp-202000000 {
>> +					opp-hz = /bits/ 64 <202000000>;
>> +					required-opps = <&rpmhpd_opp_nom>;
> This can work at SVS_L1
>
> Konrad

Sure will update to rpmhpd_opp_svs_l1 in V2.


Regards,
Sarthak


