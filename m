Return-Path: <linux-kernel+bounces-613495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 464C3A95D50
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 07:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A5E174B18
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 05:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8360B1E5B66;
	Tue, 22 Apr 2025 05:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MVKaUbsg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7911913541B;
	Tue, 22 Apr 2025 05:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745299753; cv=none; b=sb2IuxPS/qxlcDn+E/Ngh5pI0jlGelIO8qw/pX/8KmJfls8MHVjzc6ylqWSUc/kbFCxqqC9zm2JUFWU+A7Mf5aTA6xsTOe0sAhKmM7JY0BfzU2V3cTJuxM3Hst0/XMXrrPJkRGu8Qb6J/+gpuCJd3+gELMxYwAfymYfGB+qcQO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745299753; c=relaxed/simple;
	bh=UiVkfFLo8rqwxy97qc/BuLHfWyb96rKKOjclnQ94cno=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hIwGjYuWlWoT1EJzss4UNLEmGoMCExftSWQ5N7j+Y03GczHt9Kyl9cXdGvA/nfvHhyz+s0OurqWwR9AeUT5nms72N1ejVsiqbzxxHyzrmHhqEGhWIcakHmBfB4aVvPYPvb8Jx+W1xwmPxA5guVpKALEMhJE9QbKNOD+WlOuCATU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MVKaUbsg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M4OsP4011415;
	Tue, 22 Apr 2025 05:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SGo+5kHX90davWHoF4JP27rYZAn0DXVkykLLUqXlGDM=; b=MVKaUbsguomy7AYB
	QhsdsPWfyJhE7r7YruI1ViLDMqX83sv9P1HUipzNO6EBZx4iIODSk+qnmpQ971KU
	RZbaam/z4UxL9zL33HXShqNgGHsSXd5gX+tQcoMc+I0NdO/Fq/NkkIwRybPZwKEj
	J9vzgPtYgIlyIO/TzWyiMQi702Zjr0EecxFC3s1KZpiDwKRo89JX9VhOXGEiAx7A
	fO8iYCCbIZRMTbFEdsCrhzaGVaRwQa3hjCN6u7L017nDMbTIEfk/dXQZ7RGjA/hY
	w+dorfJpoyab6xBLVyq+zzzmolMY7jQYxb68xrQjZm4PHTSeTvDOgNtrtjYaJDF0
	BaYsBg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46450pe32s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 05:28:56 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53M5StYH003021
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 05:28:55 GMT
Received: from [10.204.66.137] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 21 Apr
 2025 22:28:49 -0700
Message-ID: <cadaeb59-9f6a-4132-8570-212c3817efa9@quicinc.com>
Date: Tue, 22 Apr 2025 10:58:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/11] arm64: dts: qcom: sa8775p-ride: add anx7625 DSI
 to DP bridge nodes
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Ayushi Makhija
	<amakhija@qti.qualcomm.com>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <marijn.suijten@somainline.org>,
        <andersson@kernel.org>, <robh@kernel.org>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>, <konradybcio@kernel.org>, <conor+dt@kernel.org>,
        <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
        <rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>,
        <quic_abhinavk@quicinc.com>, <quic_rajeevny@quicinc.com>,
        <quic_vproddut@quicinc.com>, <quic_jesszhan@quicinc.com>
References: <20250417053909.1051416-1-amakhija@qti.qualcomm.com>
 <20250417053909.1051416-8-amakhija@qti.qualcomm.com>
 <qnhfnxvdsgnw5jh4xxaqz3p2x67qcrr7kn3vwdnyz5huchdtzy@aagflznjrvly>
Content-Language: en-US
From: Ayushi Makhija <quic_amakhija@quicinc.com>
In-Reply-To: <qnhfnxvdsgnw5jh4xxaqz3p2x67qcrr7kn3vwdnyz5huchdtzy@aagflznjrvly>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=Hd0UTjE8 c=1 sm=1 tr=0 ts=68072918 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=174sz1Ju-uvedw1KsVAA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: uGDgHQO1p69jAn046d_FxfeytHtXYAZ1
X-Proofpoint-ORIG-GUID: uGDgHQO1p69jAn046d_FxfeytHtXYAZ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_02,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504220040

On 4/17/2025 4:10 PM, Dmitry Baryshkov wrote:
> On Thu, Apr 17, 2025 at 11:09:05AM +0530, Ayushi Makhija wrote:
>> From: Ayushi Makhija <quic_amakhija@quicinc.com>
>>
>> Add anx7625 DSI to DP bridge device nodes.
>>
>> Signed-off-by: Ayushi Makhija <quic_amakhija@quicinc.com>
>> ---
>>  arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi | 180 +++++++++++++++++++++
>>  1 file changed, 180 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
>> index 175f8b1e3b2d..d5b2dabe927d 100644
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
>> @@ -519,7 +550,107 @@ &i2c18 {
>>  	clock-frequency = <400000>;
>>  	pinctrl-0 = <&qup_i2c18_default>;
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
> 
> No reset-gpios? Is the expander being used by something else so that we
> don't want it to be reset during the bootup?
> 

Hi Dmitry,

Reset-gpios is optional for tca9539, because of which it is not throwing an error.
After adding reset-gpios = <&tlmm 97 GPIO_ACTIVE_LOW>; it is working. Will add it in next
patchset.

Thanks,
Ayushi

>> +
>> +		pinctrl-0 = <&io_expander_intr_active>,
>> +			    <&io_expander_reset_active>;
>> +		pinctrl-names = "default";
>> +	};
>> +
> 
> The rest LGTM
> 


