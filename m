Return-Path: <linux-kernel+bounces-756378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE6BB1B346
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200071892BFD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C4327056B;
	Tue,  5 Aug 2025 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dww+5siG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7F713E02D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754396663; cv=none; b=tGb/MhupPkc+xSujLaxROz4OlwFdMNt+ce46sTAuMquPHyYR9NYqegGYnE9CnubbR7Ws897sOi8wJSGPM9LCakDf/kihlnzYhYYahfmggFpLyhWrJ1ya7Qw0YY60KW4mavPDvLyCT0VOkc8UVSsCCIcWcFGTp6OLIj13kmYeOZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754396663; c=relaxed/simple;
	bh=r43bh0V6thcvEMRBP7uiBSj2mvfPyvWe6UvyV+75yF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ify4DwyW7QklGGXBT2rPXTyJNWrAaWzcSXl1UNXDuW4NyC8EmyHJ++6EXXiixOOoGMH8+V9vGeOMw2w9MuqYy8/9ULfiIEIAokFU1AzBY1FlqRdWFHYchQ9bYbOobg7LXrex5lbTTQXD9QKhEhfc5W+1fV30t31WMQyeYBd27jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dww+5siG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575C7Z6A023987
	for <linux-kernel@vger.kernel.org>; Tue, 5 Aug 2025 12:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zakc/kpl+pcymVtBZ5JqlHHlVTDZoYtg/mhLwZJ2HUs=; b=Dww+5siG6JioDz0l
	u8O3Hx5ToGQpPtmmVQue0NnE0vOuWLUVZUod5tXKLAXiZDe4vYM09eGIl+DEjhH+
	pLsshW97GYFj3+u1WmjYMXz6kVaW87nvqijvJEp7hrDVKVSiCy+gKCfpgO1Qtxay
	cRSuNqJMP4G6y1Xy3mmY4gCc30QbTrj+nVIdHhqqPGLpkGBUYSM92bAJum03qJCx
	OOYUpXtUq8JFC9rGoMFjUP8nWgPaSyiD6G2kBSa2UovQEm4j0uKP6JchBRmOfZa1
	fcmu4G052uloKSn6LqLGcjqNlRgmxQWm7bTxz2UhmIsiXuk/4M1Wv7j6QNZXzka8
	SAFt1w==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48981rrmcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 12:24:15 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b4227538a47so3777547a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 05:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754396654; x=1755001454;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zakc/kpl+pcymVtBZ5JqlHHlVTDZoYtg/mhLwZJ2HUs=;
        b=GlTsB0MbPmF8+Rk+Nt2tQLKAfpOE7pR7YpUmw7CmXeJn2CsoNWu3G1xW3fxnLdDYPb
         N01WXVGqI3kg8gg9d4UXm2ChML1ErTrbhg7uMXAFF3v0Hi+rxFyWCPhTCw6Lht7QR1l8
         khw+wcl8OpvAIfUEN7Q3h3DE+IOy8Dkk81WSOyPi4CvGXm8nFkzl/WUAo6g+S1a03Zka
         1WxW+1Cc5ZOKuNN5fPu9FxjQUhb0p95KhS1yFu40LI2uiXjyesGd1CXAd6KHZel1s4mU
         Ynuo1tWbXY5UYaNIuNGWiM5FXSeGqLwbLHY66Nkn9Wbuh45z+jy1F+M5Zu+F9SDIFTjO
         iiWA==
X-Forwarded-Encrypted: i=1; AJvYcCXNk3M4EOCF49dm2MjzTA9V0lzp/tj9pkKHLMK++kcqoa1YIeX4hLa35y9TqT7LzJ+8E46Zosjv0E2gGmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrSr96BV37sBqjp2o0slyQJSKeSLdTcXRTGwi1JsA26+fV++2P
	y9kulcWtYkfOno5hwRkJJJQCW77yVA79cBCN7Kz1/7sXTr4Jz1Qy+G5GAeNdygbfY26bR98h9gL
	+qhUrJKYy6Zz6SLSodOLQaGKxnFGzxuvayP7fhp5oLTAc7uxx9N8h/kwjq/72sAPBnbk=
X-Gm-Gg: ASbGncsxZl8gI7dRV2qOKUS+QMD0smxbZoogyU7zIAOXVUR4TPxrgTUq7fi0sHWGU6e
	zcl6g4K/djE1HMWjMGktEbf4W07anpOa9oek2fEVsxoh1E4Sz6LTSERTUac0hDLb1m9j4oSlDcZ
	91G2XKoZkqBqmU+7oZj+hxI613JQKWfW4k53lRGqFrJlEkB19MW5HVGVcLmTV+ICrp0z4TiyDzL
	CjO8/kJnaa4Jl4PvfNyHR+iB90601A2CBlR4KoT4wkuHA9MqCU5GHIXm46FjhTbf1T8iBBKc41D
	NXArIJbI7Saz/Tve6rnVSzrDJ3wZT3Su2FX3j2NX2/MjnWZjy5DYPPr6U4Ykdtg=
X-Received: by 2002:a05:6300:218e:b0:21f:4ecc:11ab with SMTP id adf61e73a8af0-23df8f93cd1mr16966219637.9.1754396653974;
        Tue, 05 Aug 2025 05:24:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmAtlyoCkBTucfFzqAePs0iFp/iqsO9db8iSLJTshnWRKP8i368ShtTr8e0T6Hm+SHVmEG2g==
X-Received: by 2002:a05:6300:218e:b0:21f:4ecc:11ab with SMTP id adf61e73a8af0-23df8f93cd1mr16966180637.9.1754396653534;
        Tue, 05 Aug 2025 05:24:13 -0700 (PDT)
Received: from [10.253.39.156] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bb0570bsm11090730a12.54.2025.08.05.05.24.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 05:24:12 -0700 (PDT)
Message-ID: <7e4d9dfe-428f-4374-9be7-97123cf36e5a@oss.qualcomm.com>
Date: Tue, 5 Aug 2025 20:24:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] arm64: dts: qcom: Add display support for QCS615
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>,
        Li Liu <quic_lliu6@quicinc.com>, Dmitry Baryshkov <lumag@kernel.org>
References: <20250718-add-display-support-for-qcs615-platform-v5-0-8579788ea195@oss.qualcomm.com>
 <20250718-add-display-support-for-qcs615-platform-v5-1-8579788ea195@oss.qualcomm.com>
 <1f6fc7ce-5826-4f59-89d7-ac691a3ae785@oss.qualcomm.com>
Content-Language: en-US
From: Fange Zhang <fange.zhang@oss.qualcomm.com>
In-Reply-To: <1f6fc7ce-5826-4f59-89d7-ac691a3ae785@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: tf6h7tzuu5enoPAcl1P0hawAQI7W4u2E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA5MCBTYWx0ZWRfXzHrxK2MKy8nN
 /ENiL6xwFFH1A+VfCa73pzOfBhi2m0l3di5WAND9f4UVpxOdBScQ31moqS4GCk12tm50czHIc0M
 iFqPjnAgvQhmijHStOtiZEt33TJGXrv1qApSFTFeNVwDL4rV9Pt1pcxaF3yVC09ZNOVD2SEG6aH
 Zk6KgmHmCaWb7Rs8DrEfI4XrkEJN6pIu2coBUv5i8Q9/sk9mDzdIMDP+ezvihlHfO5pl/n6uBwc
 tK3u+odU4vuyUC4P8VVWVvCWEp5lN+J248gtiEyZDeIoUdASKZ34coQb6xtI0YBMnYLyP3Wk0SY
 chBG5O78EF70e6ykTdWGF+IkzFXufmUzEqzSdUCTs6tmWEARgAoUGgkmtYRahAs5/4gdGHS23oL
 Jx+f0OjNBBPbHSeqEZbGHYikMCPqkPrIH4/6mOmxiMoN8SR6+/7rErh8vTJ+kY1Ock0e2y/k
X-Proofpoint-GUID: tf6h7tzuu5enoPAcl1P0hawAQI7W4u2E
X-Authority-Analysis: v=2.4 cv=a8Mw9VSF c=1 sm=1 tr=0 ts=6891f7ef cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=oI82J1t3JKGWbxmVtl0A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050090



On 7/29/2025 7:17 PM, Konrad Dybcio wrote:
> On 7/18/25 2:56 PM, Fange Zhang wrote:
>> From: Li Liu <quic_lliu6@quicinc.com>
>>
>> Add display MDSS and DSI configuration for QCS615 platform.
>> QCS615 has a DP port, and DP support will be added in a later patch.
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Signed-off-by: Li Liu <quic_lliu6@quicinc.com>
>> Signed-off-by: Fange Zhang <fange.zhang@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +
>> +			mdss_mdp: display-controller@ae01000 {
>> +				compatible = "qcom,sm6150-dpu";
>> +				reg = <0x0 0x0ae01000 0x0 0x8f000>,
>> +				      <0x0 0x0aeb0000 0x0 0x2008>;
>> +				reg-names = "mdp", "vbif";
>> +
>> +				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
>> +					 <&gcc GCC_DISP_HF_AXI_CLK>,
>> +					 <&dispcc DISP_CC_MDSS_MDP_CLK>,
>> +					 <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
>> +				clock-names = "iface", "bus", "core", "vsync";
> 
> 1 per line please, everywhere> +
Got it will fix it in next patch>> +				assigned-clocks = <&dispcc 
DISP_CC_MDSS_VSYNC_CLK>;
>> +				assigned-clock-rates = <19200000>;
> 
> Is this necessary?
test pass without this, so will remove them in next patch>
>> +
>> +				operating-points-v2 = <&mdp_opp_table>;
>> +				power-domains = <&rpmhpd RPMHPD_CX>;
>> +
>> +				interrupt-parent = <&mdss>;
>> +				interrupts = <0>;
> 
> interrupts-extended
Got it, will change it as below in next patch
interrupts-extended = <&mdss 0>;>
>> +
>> +				ports {
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>> +
>> +					port@0 {
>> +						reg = <0>;
> 
> Please keep a \n between properties and subnodes
will fix it in next patch>
>> +						dpu_intf0_out: endpoint {
>> +						};
>> +					};
>> +
>> +					port@1 {
>> +						reg = <1>;
>> +						dpu_intf1_out: endpoint {
>> +							remote-endpoint = <&mdss_dsi0_in>;
>> +						};
>> +					};
>> +				};
>> +
>> +				mdp_opp_table: opp-table {
>> +					compatible = "operating-points-v2";
>> +
>> +					opp-19200000 {
>> +						opp-hz = /bits/ 64 <19200000>;
>> +						required-opps = <&rpmhpd_opp_low_svs>;
>> +					};
>> +
>> +					opp-25600000 {
>> +						opp-hz = /bits/ 64 <25600000>;
>> +						required-opps = <&rpmhpd_opp_svs>;
> 
> This and the above frequency are missing one zero (i.e. you
> have a 10x underclock)
Got it, will fix it in next patch>
> [...]
> 
>> +			mdss_dsi0_phy: phy@ae94400 {
>> +				compatible = "qcom,sm6150-dsi-phy-14nm";
>> +				reg = <0x0 0x0ae94400 0x0 0x100>,
>> +				      <0x0 0x0ae94500 0x0 0x300>,
>> +				      <0x0 0x0ae94800 0x0 0x188>;
> 
> sz = 0x124
Got it, will change 0x188 to 0x124 in next patch>
>> +				reg-names = "dsi_phy",
>> +					    "dsi_phy_lane",
>> +					    "dsi_pll";
>> +
>> +				#clock-cells = <1>;
>> +				#phy-cells = <0>;
>> +
>> +				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
>> +					 <&rpmhcc RPMH_CXO_CLK>;
>> +				clock-names = "iface", "ref";
>> +
>> +				status = "disabled";
>> +			};
>> +		};
>> +
>>   		dispcc: clock-controller@af00000 {
>>   			compatible = "qcom,qcs615-dispcc";
>>   			reg = <0 0x0af00000 0 0x20000>;
>>   
>>   			clocks = <&rpmhcc RPMH_CXO_CLK>,
>> -				 <&gcc GCC_DISP_GPLL0_DIV_CLK_SRC>;
>> +				 <&gcc GCC_DISP_GPLL0_DIV_CLK_SRC>,
>> +				 <&mdss_dsi0_phy 0>,
>> +				 <&mdss_dsi0_phy 1>,
> 
> #include <dt-bindings/clock/qcom,dsi-phy-28nm.h>Got it, will add the h file and change as below in next patch
				 <&mdss_dsi0_phy DSI_BYTE_PLL_CLK>,
				 <&mdss_dsi0_phy DSI_PIXEL_PLL_CLK>,>
> Konrad

