Return-Path: <linux-kernel+bounces-598273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFAEA84466
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 15:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D4DF4C5329
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 13:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D15728FFC5;
	Thu, 10 Apr 2025 13:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bqnsJ6s2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7075A28C5D3;
	Thu, 10 Apr 2025 13:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744290522; cv=none; b=eJ/aOuJLJ52ySnYpudFwFIooQpQR7TH6L8CZ3ii4JZVbts6zOPZbH7H8/UHbS2Bu1EGsan9U/9/H1WM9CjJqzXrqsHF3rWrKO0CuB+GkSXK7sM7z8AR3g7mQAaJlR4uNQBjVGKn90Ysf5ZalwXfhZxVvt+jnDu0uJpJ+oOkwCt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744290522; c=relaxed/simple;
	bh=IRpptOiKFrmHAhXBkMvL+moUnHRIzNyCQ9OIUGR3TUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=I3huoja+89t2tYLW3vKWzhHgZx55EJFBPXGvMSIBQR20G1Z0x/kzC9tjPSsZzyfc1txraWg9qEIuIZW3a3z8B/SCFzk3jVXWv9m5x6NmroJKnnTEFFUsLSjvY1xiifKl8h0HCYaqILvJooVGkGNhQ5ax6oo+z4/Rf7VJ5BBAjb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bqnsJ6s2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A75aKN018319;
	Thu, 10 Apr 2025 13:08:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C0lS2+7VSOL0SIGZcpKjdnDb9d67WgyN16/wLnthOpw=; b=bqnsJ6s2atv0917k
	jG+3SXVTxD6aJUTJpgtQhtlzpZYEK+LRGffmOYi9FrTonuPnDjJHyqd9+pIIxWN4
	PzBQ3CZoJJ5VX/DPd48umgdupTyQPfQHTLQgJl4BmGsLsKC3O1c4Di8dIOfSpnAr
	PqYdxS4uSpPuBK3HZo3lF3BruLBkf2/M75Z1YCzU/UYXp2gVuPX43sVa1DyERJKd
	hoGoCCWpCnBrxF6Uv/YC03N/Li9zqrONLyzRO+f9pe/amtEmeVgTrXDADrdqtrYn
	ufAg0tWRy+hrjnX1TcDr2DMNTC94xJv+lixiDi+hB3VcEAK6vSq3e9nT/KDm1wDP
	URzTQg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twtb73ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 13:08:07 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53AD86rA014610
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 13:08:06 GMT
Received: from [10.216.14.182] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 10 Apr
 2025 06:07:57 -0700
Message-ID: <0f4eca6c-67df-4730-88b3-a277903deabc@quicinc.com>
Date: Thu, 10 Apr 2025 18:37:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] arm64: dts: qcom: sa8775p-ride: add anx7625 DSI
 to DP bridge nodes
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        <konradybcio@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robdclark@gmail.com>,
        <dmitry.baryshkov@linaro.org>, <sean@poorly.run>,
        <marijn.suijten@somainline.org>, <andersson@kernel.org>,
        <robh@kernel.org>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <konradybcio@kernel.org>, <conor+dt@kernel.org>,
        <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
        <rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>,
        <quic_abhinavk@quicinc.com>, <quic_rajeevny@quicinc.com>,
        <quic_vproddut@quicinc.com>, <quic_jesszhan@quicinc.com>
References: <20250404115539.1151201-1-quic_amakhija@quicinc.com>
 <20250404115539.1151201-8-quic_amakhija@quicinc.com>
 <nxnqwh2mzvnxv5ytwjsyulxr6ct6mhv3z3v6q4ojrjhhclwv2i@55nb56hnwi3y>
Content-Language: en-US
From: Ayushi Makhija <quic_amakhija@quicinc.com>
In-Reply-To: <nxnqwh2mzvnxv5ytwjsyulxr6ct6mhv3z3v6q4ojrjhhclwv2i@55nb56hnwi3y>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: u6cLcpuCQZXqIApBuHPMYAggNJBvecAZ
X-Authority-Analysis: v=2.4 cv=LLlmQIW9 c=1 sm=1 tr=0 ts=67f7c2b7 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=zjBtcsmdu44VOzoy24MA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: u6cLcpuCQZXqIApBuHPMYAggNJBvecAZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_03,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504100095

Hi Dmirity/Konard

On 4/7/2025 1:42 AM, Dmitry Baryshkov wrote:
> On Fri, Apr 04, 2025 at 05:25:36PM +0530, Ayushi Makhija wrote:
>> Add anx7625 DSI to DP bridge device nodes.
>>
>> Signed-off-by: Ayushi Makhija <quic_amakhija@quicinc.com>
>> ---
>>  arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi | 208 ++++++++++++++++++++-
>>  1 file changed, 207 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
>> index 175f8b1e3b2d..8e784ccf4138 100644
>> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
>> @@ -28,6 +28,13 @@ chosen {
>>  		stdout-path = "serial0:115200n8";
>>  	};
>>  
>> +	vph_pwr: vph-pwr-regulator {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vph_pwr";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +	};
>> +
>>  	vreg_conn_1p8: vreg_conn_1p8 {
>>  		compatible = "regulator-fixed";
>>  		regulator-name = "vreg_conn_1p8";
>> @@ -128,6 +135,30 @@ dp1_connector_in: endpoint {
>>  			};
>>  		};
>>  	};
>> +
>> +	dp-dsi0-connector {
>> +		compatible = "dp-connector";
>> +		label = "DSI0";
>> +		type = "full-size";
>> +
>> +		port {
>> +			dp_dsi0_connector_in: endpoint {
>> +				remote-endpoint = <&dsi2dp_bridge0_out>;
>> +			};
>> +		};
>> +	};
>> +
>> +	dp-dsi1-connector {
>> +		compatible = "dp-connector";
>> +		label = "DSI1";
>> +		type = "full-size";
>> +
>> +		port {
>> +			dp_dsi1_connector_in: endpoint {
>> +				remote-endpoint = <&dsi2dp_bridge1_out>;
>> +			};
>> +		};
>> +	};
>>  };
>>  
>>  &apps_rsc {
>> @@ -517,9 +548,135 @@ &i2c11 {
>>  
>>  &i2c18 {
>>  	clock-frequency = <400000>;
>> -	pinctrl-0 = <&qup_i2c18_default>;
>> +	pinctrl-0 = <&qup_i2c18_default>,
>> +		    <&io_expander_intr_active>,
>> +		    <&io_expander_reset_active>;
> 
> These pinctrl entries should go to the IO expander itself.
> 
>>  	pinctrl-names = "default";
>> +
>>  	status = "okay";
>> +
>> +	io_expander: gpio@74 {
>> +		compatible = "ti,tca9539";
>> +		reg = <0x74>;
>> +		interrupts-extended = <&tlmm 98 IRQ_TYPE_EDGE_BOTH>;
>> +		gpio-controller;
>> +		#gpio-cells = <2>;
>> +		interrupt-controller;
>> +		#interrupt-cells = <2>;
>> +
>> +		gpio2-hog {
> 
> This needs a huuge explanation in the commit message. Otherwise I'd say
> these pins should likely be used by the corresponding anx bridges.

Thanks, for the review.

Previously, I was referring to the downstream DT and misunderstood the use of gpio-hog.
After reading the schematic, I realized that gpio2, gpio3, gpio10, and gpio11 are all input pins
to the IO expander TC9539. We have already configured gpio2 and gpio10 as interrupts in the
ANX7625 bridges, so the gpio-hog is not required. It is working without the gpio-hog configuration.

Thanks,
Ayushi


