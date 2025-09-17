Return-Path: <linux-kernel+bounces-820827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D42B7F63A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35B6052058B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA560332A53;
	Wed, 17 Sep 2025 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sks7Q1R/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA71A330D37
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115856; cv=none; b=QKjLU3MTWy5OurU0FFE9ZADSLru1/ZEruAHi7ATEG6sQXhqVix50bSAV9oaO2v65nPjdEM9aJQJXtEi/zj9Vu2lUC5luMGnD3DcE8AI/etL7TCSVU8LYzAIIK7UySA7Vp7NHUkUTa2wsGZJDY2AId77ul/lH+chTWkjiTSX0j70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115856; c=relaxed/simple;
	bh=nvKvYdZuF2KuOij1uNzJYqCctNXuBj+u4pDWG2C7DaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HE+HLTqJ1lxQcmq7SM+jb4UKaVN4YeFfvWs1wHUsgk1z8xowFj0VzxI7FowN5FgivL0aJl2BYpcKPIsKdMNF7Vs0HShaqfEhGyvxlnIVDDhMRjtEHrMj8rhD98iaKOmtuv89fk+QoO+M25uMUbtgoIf3RGTlEh1Dq/Byqw4C3Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sks7Q1R/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HBLfgn028290
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:30:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6F3vROBNhzZrHYgeXkrr5B6ePIdHP+GJRW3Yn7Th6js=; b=Sks7Q1R/9l20CVd6
	qlxz8kpOgPh729qw6VgACGKCQOrS3He5pUO/o3l5kpBxCotGvZ/FvzHc1fz23nbb
	XVNkwbg4b2/I58Nn5Wf6fBXpWHmMR/GD95cCBRMD/qqHcFGGSjDCdaq/782fwr0Q
	Z6aIYAcbuPdiw4HlUlWgOvCigLlWjmF+zLV6oveKBwqT+kf7TyO/v3gSU9VWyHrY
	uALtzbStm1lqAn6hRVIocImbandhOgjgaoABPrmRMpvlmezJiUVKMiSDKGZrKop2
	MIYhWegzh1dUF1EjV8nS5PbdMVErRIKilmF2jUd2B0lH9QmIpRIUfSxL0d3W3dvU
	aah4EA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497v1j8cy9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:30:52 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7725b77b795so6138543b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:30:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758115851; x=1758720651;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6F3vROBNhzZrHYgeXkrr5B6ePIdHP+GJRW3Yn7Th6js=;
        b=b9Ql8lopl22ykOyxnFHVw2xPJaTvNTYtZTGvBX+610clYryg2EImu75DCg+AqxpWoA
         jhfWG7Q1ODJUutqv0pdQE1k3O6/Zg1w+akDskVUuZmzuJro0R/WfhRfQP6IWte9Pz5lI
         CLOXk+08P33Mc1PZxcP8X5b4kcePiNluSojSmBzmuukBASTYpXXKhkJ3XnRukk9k01MT
         znckprovDckasJ/7u9OHaecVpmE+nkM9aFSRtrEPs19w8d2fty3652WHcvKIRBF1EHMC
         7IZ6xZoXesNocTl70o+gJjYmK/hZS29ZtM+z0vG9zHqg88chzTFU7Hh+XsEjhIL79M0e
         Rx5A==
X-Forwarded-Encrypted: i=1; AJvYcCVu3D254ENfoCyltA9zEBaETNrhbbIIgxZBoFT2BDXkdkfjxVOh7ck4KEsUwPn9+wMgqydypRcnAFSkDTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAE0wqINxjewjnjpq0LLV/ype/JhMXQMyOksY1CuEo4kz9pcX0
	6EqWzH4Z7KMcwuF5aBn8rDuAqIAC+FdlLQ8QRPSCHDTi7jjA1hEy8ScxN2GVurPfs2knuO4A6cY
	A5vHXvx32hNisAZJXhy+Ij5p3Dp28O48/OmxRn8YyVcWbXdV+MqyH8CmDX0dlkRQaukU=
X-Gm-Gg: ASbGncsiC1XKilC6YRph4nf1nrkdbA+7hFt5Ful0yeJoSM7YFpWa6dtWhEfix893j1r
	Pp6JZLk6bCwP2QhAffdMmD2JfgLH0PkIdrenDTRv1c17jZTHAQMDQ/OtaEee6L8UeZlrDSGoTso
	CNZ3rabqQhxFhoJTIIhnRWuJZosv2AGC6OmZD2WmA12PEw/yd+9Oja55OvLK2ynH0GPyd8MTN48
	XZuCK6x9goLcrwUgqdZ0i0WX2chB4BSgIyc1a5TBXJ21tE54rUUM4r5/p/N8fBCA4MMICgMtTux
	TGOCDbGgi0SEsfUuZJU7ZDle+JXpCCl+7ZXupP2Ok3fXy3c8nuiqg7b9PrmvfX3ALbSo1Q3jmoA
	=
X-Received: by 2002:a05:6a00:2d15:b0:772:1a0:f772 with SMTP id d2e1a72fcca58-77bf94686eamr2332551b3a.28.1758115851389;
        Wed, 17 Sep 2025 06:30:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNHH4xtklKs82fBpyasVZs9Ht06BM93FkMXvT9OfwzfqSo5YpKjkN4fmWL+AhpdPnf2HK0Ew==
X-Received: by 2002:a05:6a00:2d15:b0:772:1a0:f772 with SMTP id d2e1a72fcca58-77bf94686eamr2332451b3a.28.1758115850308;
        Wed, 17 Sep 2025 06:30:50 -0700 (PDT)
Received: from [192.168.29.113] ([49.43.227.74])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b347f8sm18790862b3a.82.2025.09.17.06.30.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 06:30:49 -0700 (PDT)
Message-ID: <d2d17266-68a1-4a63-954b-9076db5315a5@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 19:00:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/10] arm64: dts: qcom: lemans-evk: Enable PCIe
 support
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-i2c@vger.kernel.org,
        Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
References: <20250916-lemans-evk-bu-v5-0-53d7d206669d@oss.qualcomm.com>
 <20250916-lemans-evk-bu-v5-5-53d7d206669d@oss.qualcomm.com>
 <h2t7ajhtyq3vivbw67tifrn73i4zisicoktsgab76zptxre6at@vl2q4d6i3lms>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <h2t7ajhtyq3vivbw67tifrn73i4zisicoktsgab76zptxre6at@vl2q4d6i3lms>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: p4PwY30-cbNtdUwkmyPJip7ESvflZDKx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDExMCBTYWx0ZWRfX2eNsa1MmKs95
 80PiijbdfHwKBq0UgH10GpptfPcvbq0E/1JKbWPwBWNHyxI+0Q7x7mD1Fikq5VycNOa4j02Q+Y7
 n41W1TXjt6JuSeNK5TnohmlULu2UxHn3Qdi0Rxu1fL2M/+GWQD/epFeNjCS7YYk0oUTDhq/oG7r
 QZRNPDgBZsOXn+vrbP0bqsvQZfWjotptrMO3SA2aPHYnZ4lslHdHhgVUMQ9KDPqfSqmSi51XSR/
 FstOx2mZAdaKvbU01Xlykrle+u++Y3CXai6C4Mj15XvZXjWbOcq4rAzeeoqKvvoK33QPpUuWcMk
 C43/pPIsCwAskJtvikmJ0LleMP1rJ5dCMlMnTIWGcje5siUTYn+AuFy4baVNarPdsWhkZBq8R/H
 LENcj1TD
X-Authority-Analysis: v=2.4 cv=AeqxH2XG c=1 sm=1 tr=0 ts=68cab80c cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=1mPCZV2InQEjkM8ljLdqcA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=nPE1BBKPTxE4yRdvQxsA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: p4PwY30-cbNtdUwkmyPJip7ESvflZDKx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509170110



On 9/17/2025 1:36 PM, Manivannan Sadhasivam wrote:
> On Tue, Sep 16, 2025 at 04:16:53PM GMT, Wasim Nazir wrote:
>> From: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
>>
>> Enable PCIe0 and PCIe1 along with the respective phy-nodes.
>>
>> PCIe0 is routed to an m.2 E key connector on the mainboard for wifi
>> attaches while PCIe1 routes to a standard PCIe x4 expansion slot.
>>
> 
> Where did you define the supply for M.2 connector? We don't have a proper
> binding for M.2 today, but atleast the supply should be modeled as a fixed
> regulator with EN GPIOs as like other boards.
> 
> - Mani
Hi Mani,

This board doesn't have any power supply for m.2 connector they are
always powered on.

- Krishna Chaitanya.
> 
>> Signed-off-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
>> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/lemans-evk.dts | 82 +++++++++++++++++++++++++++++++++
>>   1 file changed, 82 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
>> index 97428d9e3e41..99400ff12cfd 100644
>> --- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
>> +++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
>> @@ -431,6 +431,40 @@ &mdss0_dp1_phy {
>>   	status = "okay";
>>   };
>>   
>> +&pcie0 {
>> +	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
>> +	wake-gpios = <&tlmm 0 GPIO_ACTIVE_HIGH>;
>> +
>> +	pinctrl-0 = <&pcie0_default_state>;
>> +	pinctrl-names = "default";
>> +
>> +	status = "okay";
>> +};
>> +
>> +&pcie0_phy {
>> +	vdda-phy-supply = <&vreg_l5a>;
>> +	vdda-pll-supply = <&vreg_l1c>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&pcie1 {
>> +	perst-gpios = <&tlmm 4 GPIO_ACTIVE_LOW>;
>> +	wake-gpios = <&tlmm 5 GPIO_ACTIVE_HIGH>;
>> +
>> +	pinctrl-0 = <&pcie1_default_state>;
>> +	pinctrl-names = "default";
>> +
>> +	status = "okay";
>> +};
>> +
>> +&pcie1_phy {
>> +	vdda-phy-supply = <&vreg_l5a>;
>> +	vdda-pll-supply = <&vreg_l1c>;
>> +
>> +	status = "okay";
>> +};
>> +
>>   &qupv3_id_0 {
>>   	status = "okay";
>>   };
>> @@ -447,6 +481,54 @@ &sleep_clk {
>>   	clock-frequency = <32768>;
>>   };
>>   
>> +&tlmm {
>> +	pcie0_default_state: pcie0-default-state {
>> +		clkreq-pins {
>> +			pins = "gpio1";
>> +			function = "pcie0_clkreq";
>> +			drive-strength = <2>;
>> +			bias-pull-up;
>> +		};
>> +
>> +		perst-pins {
>> +			pins = "gpio2";
>> +			function = "gpio";
>> +			drive-strength = <2>;
>> +			bias-pull-up;
>> +		};
>> +
>> +		wake-pins {
>> +			pins = "gpio0";
>> +			function = "gpio";
>> +			drive-strength = <2>;
>> +			bias-pull-up;
>> +		};
>> +	};
>> +
>> +	pcie1_default_state: pcie1-default-state {
>> +		clkreq-pins {
>> +			pins = "gpio3";
>> +			function = "pcie1_clkreq";
>> +			drive-strength = <2>;
>> +			bias-pull-up;
>> +		};
>> +
>> +		perst-pins {
>> +			pins = "gpio4";
>> +			function = "gpio";
>> +			drive-strength = <2>;
>> +			bias-pull-up;
>> +		};
>> +
>> +		wake-pins {
>> +			pins = "gpio5";
>> +			function = "gpio";
>> +			drive-strength = <2>;
>> +			bias-pull-up;
>> +		};
>> +	};
>> +};
>> +
>>   &uart10 {
>>   	compatible = "qcom,geni-debug-uart";
>>   	pinctrl-0 = <&qup_uart10_default>;
>>
>> -- 
>> 2.51.0
>>
> 

