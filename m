Return-Path: <linux-kernel+bounces-833807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D9CBA31F4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E4463BC121
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C3C274FD3;
	Fri, 26 Sep 2025 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ECljYK5n"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA416266B41
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758878666; cv=none; b=Mkkf8sQmtM5+EHcwNu4FrNRaJTl6wQp9AsfCARMgRXhn6NnHVoDAV7PTLybHVunTElJCcAIRT/uZFH8sT6CeiP1Q8aivcNr+MTNzg1LMbc1z5XpbRdeEX+fI1ZB3CCGujjWEgFJqp+at5OZ6bPaorbpim/LVFMyVOTqtShfNW2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758878666; c=relaxed/simple;
	bh=KAd1J0S9oQCh720nBw3CT2g5k54ln9BvTNOHBbN5Ziw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rwtux9KqbY3Tyan0GJnnbZz7yRRXwGqJk/Ig6fupSYuG4IF3fzyRjEnX9nUn9yCMKMiT0YfwYFCMZ6gKMwd7RSfBbt1n1oE5YrEyldKGjsCOrUXj8UhYuvA6HYhYpSRgtBZj/N+YhMwJxK678fhEz55rYdjAYP78PU9qJIHjpzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ECljYK5n; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q8vwUh030943
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qVnOy2qXL2j3wLZjEIZJ3GwgAoKs3KAugAQxc5Zdx1c=; b=ECljYK5nnkoeqbzs
	ww7nSkWQp68jqCnSeeKOhoVrPuzC+Id/nBkl1jMVAAvI9swPb9sU6QdX9mRynXkJ
	6OE0azoNGuvlQ+C/lyEZnfRwH201keXcXNaqtlSovVwACNtFNlaroBiOm6p7KDb9
	8Q/acLR//OmzwSz/27pLH84DWdIyvHRkjFB09CDevB8JU/TbVocperUCIM7yQHHM
	ltBQbs7CBrKMqNeIuEyugTZ9FeNAeP3RJ3pGnn3CLDmXvkSr9foXU1avpwxzpJHS
	3lEQFmtNOQHxYApHIj1lU/08CFncRvJC3vW9Q1BiwGMdiMkVus48rrAbbYCOyNP9
	pRDE5A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0u29a9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:24:23 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76e2e60221fso2803293b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758878662; x=1759483462;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qVnOy2qXL2j3wLZjEIZJ3GwgAoKs3KAugAQxc5Zdx1c=;
        b=LRf/7psp0KEl10bpFsRMed471JQWCn9E/waShCMYni/5C6TDNcdALNjCCAnHDPofaW
         mVOLIx3I76N7ie6a8PJgvrH8fKHUc5wspgoG5ZL3XTBYJ6PQhDdu549w8827s9i8kANH
         pX3z8O7bwsPalaSzdEkTMU47MEK+giV869+STNZ4dK4XBTdKjzN9q2T00vZZERPXQczl
         oEvgyC4dD+aK2zvzH39KYCCn6uOL+/PFE4jdAeDkeRoJbOqzWStz7tAXYG15xGaN7dKf
         IOxjO6SHiFVlsOBtrSil0/21V88BxH5jAV/7bMOi3Z36MQvfu9vJyWVcPR4EFbx7tlO4
         C8oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRjC8i9mXbYHMjllYPS2cWaqMzC1FoMcesSpdU+cOnFGNTxGfUEa1nme2EtqzvIEwucYHCkVL31RvsCTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0IH9G8SQH/nT2KgBctJtH+ctR0dLUpThBpx7uajbl6yE41TJ5
	OZ6NCHVpXGIU2fMZdC84d6JvQI/gPNNP6EHEfl15TROXmDJ7gVXtxsFN+wZBccillxbBUi7/PDH
	ZKTchF/IvD8PCgrozfJLmGfSv/xdFLW1Dxmg8pWGg/7kuRWIn6iLV9AtAFRfsAfpO6OE=
X-Gm-Gg: ASbGncu/9sA7ltoAITZzA81ZhpLGPThlHCoTOubtPyfcZFoHh+huvqONOtRZVWoNT9M
	PHfLOqx92TAw06cBL6EI/WlQSNUp3l4JK5xqM9K/CjBQV3lSbltY4qEDSYuXgs6BnJo9apZTZqK
	KynrVwVKq7xccseyi4VepJOp+S7AqxsLQXr+spi3NQz7Uh3svT/2+10zDqU7+LbyR0+mdwyoPZB
	eN4ckGdkDzsOn0iEyqj09K85cjFG7DX3DdIby72rxxS3xsMC6dAJVgxSXE93Lwy3bF46EuaLiC1
	3MW8uWBy2zJDSUDG08fm+IhKx/DMzUj2IUcj+gUJt5hQOGbzn/fXoC/Lz7pgctzO6S6t
X-Received: by 2002:a05:6a20:7f9d:b0:2c8:416:6470 with SMTP id adf61e73a8af0-2e7ca214561mr8039391637.24.1758878661940;
        Fri, 26 Sep 2025 02:24:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEf3xeG/lORUyevxAy1/n4CTalckBAz9JKsfJobNuVQZ9c5XJom6g/A9a5nv12tT/rxgxXhxw==
X-Received: by 2002:a05:6a20:7f9d:b0:2c8:416:6470 with SMTP id adf61e73a8af0-2e7ca214561mr8039357637.24.1758878661419;
        Fri, 26 Sep 2025 02:24:21 -0700 (PDT)
Received: from [10.204.79.108] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b27ae1sm4081410b3a.65.2025.09.26.02.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 02:24:21 -0700 (PDT)
Message-ID: <d451f8f0-d2ab-44eb-bfcc-ec1e9dbba060@oss.qualcomm.com>
Date: Fri, 26 Sep 2025 14:54:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: lemans: add DT changes to enable MDSS1
 and DPU
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250925-lemans_dual-v1-1-9c371803198d@oss.qualcomm.com>
 <nnvjazbxpywrmjnt67isba6m3ld6rqdaiid4qeczunmuablntz@vlbrjnxj5r2k>
Content-Language: en-US
From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
In-Reply-To: <nnvjazbxpywrmjnt67isba6m3ld6rqdaiid4qeczunmuablntz@vlbrjnxj5r2k>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 3bUUk4KzqJqLxClkdmliuJk1tvBwiwTO
X-Proofpoint-GUID: 3bUUk4KzqJqLxClkdmliuJk1tvBwiwTO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX0RQYibbovHTG
 Pwdt9rA1Nb/ac7qjrH9LcVmW8c+bpReE2NhzEJ1STm8b9VG9iYvL0tT4jZShx0+MCv+uapydpwy
 6B4Nxr0tgllCI0KIXw4VKzkhEDmppu7vj22I/L+tsyS9G5OZ6F+DDisNiemZhcAQmx2nOs4AtUS
 7E40CxgXiZThugCcopMR0hBjKGhI7GofnzsN7kVxEIT7ZU81js5MbEoqdPCt7AwJVBNfCfdOtmy
 jMTD5G96/Gq5Occ+jzE4hPiUcXo1RGgQbuibokjsvctkTFxbW5lF3FWCfmo7g69cpJ8sBVDWPEZ
 c4CCOX6jCdzU/VArNzJQANuASljIwtuoN4+zZ5tDiZ8D15ixtrOCPQSl+mZha0JTow7CpuKdv7b
 CWDffvCFvftO/XPaeuijH7vKlME9IA==
X-Authority-Analysis: v=2.4 cv=ZsHg6t7G c=1 sm=1 tr=0 ts=68d65bc7 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=qwUjrA7DuB2iKsSbT94A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_02,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171


On 9/26/2025 3:11 AM, Dmitry Baryshkov wrote:
> On Thu, Sep 25, 2025 at 02:28:07PM +0530, Mahadevan wrote:
>> Add devicetree changes to enable second Mobile Display
>> Subsystem (MDSS1) and its Display Processing Unit(DPU) for
>> Qualcomm LEMANS platform.
> No outputs? Should it be enabled on any of the devices?

Outputs  and enablement are include as part of this series:
https://lore.kernel.org/all/20250926085956.2346179-1-quic_mkuntuma@quicinc.com/
I will update the commit message to use the phrase "to support" for 
better clarity.

>
>> Signed-off-by: Mahadevan <mahadevan.p@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/lemans.dtsi | 88 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 88 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
>> index 48f753002fc459a3e9fac0c0e98cbec6013fea0f..45c11c050d3f8853701fd20cf647aef5c6a9a8c9 100644
>> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
>> @@ -6751,6 +6751,94 @@ compute-cb@3 {
>>   			};
>>   		};
>>   
>> +		mdss1: display-subsystem@22000000 {
> Why do you need this label?

display-controller@22001000 is using mdss1 as interrupt parent.

>
>> +			compatible = "qcom,sa8775p-mdss";
>> +			reg = <0x0 0x22000000 0x0 0x1000>;
>> +			reg-names = "mdss";
>> +
>> +			/* same path used twice */
>> +			interconnects = <&mmss_noc MASTER_MDP_CORE1_0 QCOM_ICC_TAG_ALWAYS
>> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
>> +					<&mmss_noc MASTER_MDP_CORE1_1 QCOM_ICC_TAG_ALWAYS
>> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
>> +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
>> +					 &config_noc SLAVE_DISPLAY_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
>> +			interconnect-names = "mdp0-mem",
>> +					     "mdp1-mem",
>> +					     "cpu-cfg";
>> +
>> +			resets = <&dispcc1 MDSS_DISP_CC_MDSS_CORE_BCR>;
>> +
>> +			power-domains = <&dispcc1 MDSS_DISP_CC_MDSS_CORE_GDSC>;
>> +
>> +			clocks = <&dispcc1 MDSS_DISP_CC_MDSS_AHB_CLK>,
>> +				 <&gcc GCC_DISP1_HF_AXI_CLK>,
>> +				 <&dispcc1 MDSS_DISP_CC_MDSS_MDP_CLK>;
>> +
>> +			interrupts = <GIC_SPI 865 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <1>;
>> +
>> +			iommus = <&apps_smmu 0x1800 0x402>;
>> +
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +			ranges;
>> +
>> +			status = "disabled";
>> +
>> +			mdss1_mdp: display-controller@22001000 {
> Why do you need this label?

will remove.

>
>> +				compatible = "qcom,sa8775p-dpu";
>> +				reg = <0x0 0x22001000 0x0 0x8f000>,
>> +				      <0x0 0x220b0000 0x0 0x3000>;
>> +				reg-names = "mdp", "vbif";
>> +
>> +				clocks = <&gcc GCC_DISP1_HF_AXI_CLK>,
>> +					 <&dispcc1 MDSS_DISP_CC_MDSS_AHB_CLK>,
>> +					 <&dispcc1 MDSS_DISP_CC_MDSS_MDP_LUT_CLK>,
>> +					 <&dispcc1 MDSS_DISP_CC_MDSS_MDP_CLK>,
>> +					 <&dispcc1 MDSS_DISP_CC_MDSS_VSYNC_CLK>;
>> +				clock-names = "nrt_bus",
>> +					      "iface",
>> +					      "lut",
>> +					      "core",
>> +					      "vsync";
>> +
>> +				assigned-clocks = <&dispcc1 MDSS_DISP_CC_MDSS_VSYNC_CLK>;
>> +				assigned-clock-rates = <19200000>;
>> +
>> +				operating-points-v2 = <&mdss1_mdp_opp_table>;
>> +				power-domains = <&rpmhpd SA8775P_MMCX>;
>> +
>> +				interrupt-parent = <&mdss1>;
>> +				interrupts = <0>;
>> +
>> +				mdss1_mdp_opp_table: opp-table {
>> +					compatible = "operating-points-v2";
>> +
>> +					opp-375000000 {
>> +						opp-hz = /bits/ 64 <375000000>;
>> +						required-opps = <&rpmhpd_opp_svs_l1>;
>> +					};
>> +
>> +					opp-500000000 {
>> +						opp-hz = /bits/ 64 <500000000>;
>> +						required-opps = <&rpmhpd_opp_nom>;
>> +					};
>> +
>> +					opp-575000000 {
>> +						opp-hz = /bits/ 64 <575000000>;
>> +						required-opps = <&rpmhpd_opp_turbo>;
>> +					};
>> +
>> +					opp-650000000 {
>> +						opp-hz = /bits/ 64 <650000000>;
>> +						required-opps = <&rpmhpd_opp_turbo_l1>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>>   		dispcc1: clock-controller@22100000 {
>>   			compatible = "qcom,sa8775p-dispcc1";
>>   			reg = <0x0 0x22100000 0x0 0x20000>;
>>
>> ---
>> base-commit: 846bd2225ec3cfa8be046655e02b9457ed41973e
>> change-id: 20250923-lemans_dual-c03ad5c84a84
>>
>> Best regards,
>> -- 
>> Mahadevan <mahadevan.p@oss.qualcomm.com>
>>
Thanks,
Mahadevan

