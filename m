Return-Path: <linux-kernel+bounces-786197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 473DDB35666
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EDCE189E342
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 08:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52CD2E1727;
	Tue, 26 Aug 2025 08:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aywOBdwV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD1D2857D2
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 08:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756195699; cv=none; b=KFM/33yHq8JYoH0eIVMJ5t6Bb+sShcj93H4zEMUECqe3AZPG68q0dwM2Z6eDjAgqLFk0JV6yoj2JP+IgmA/wdqb46CyO8M0plb/eiIRe5HAuadzM11mdnl+YTzok2oK2TL4GTcJFYlm4RQUksTrYbdm+tWo6ys352E2Z9Gqx0r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756195699; c=relaxed/simple;
	bh=m4xY56vNqg7OWd6rU9bLu84eMMVY5+d8I3Tlde9gZAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hY2y5FwU9mNg9KiceDZ5+vsPyzMRzzKneYcMm/Q48yUsYGsljnDgfaQe3+bkE85d+AdwARd1rNqv/qAoGzThTO5cv8EkhQSDFRtEHLKob6Sse1dmxygSXvTwYXcUnKb84wplFiMqnIhA8wa5siufQdc6ihUHUXKLF9e+o28Cww8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aywOBdwV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q4MQQC020705
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 08:08:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7zTBGue+tFfC+/N0pVARqF0ktl81bwdSqF8Q8sKsMsc=; b=aywOBdwVBr6WZRSG
	igv5CcH2RGPxAcMNcoXnQRIcqygdd1yXGNof/BfUzRoSjVuNf4qcUbrNkE4A3wlQ
	B+K1UFbmm7qbEYHbu6Pfh74dmT/QbxSIGLJR7i0AS+JkusNsonM7rBKQj7iVdv81
	0KX1m8RyiHJS9w9jdqd+ST78brSvzeJik4GJMQS3lO9oZeULpFZ5b0GVroBzfpSB
	llQoF/76nNOhlmbwKxgAU39T9OiTbqQuZvtLLAScllb+JWawaYFsaBTSrBmB9UrN
	y+naQBGYru02tbT4Tu0vDzJHFifadd88VFBOtaYB+IZNdcWWPJDrq6qMfLKeT8AC
	n+e/hw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6x881tx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 08:08:16 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3235e45b815so6122905a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 01:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756195696; x=1756800496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7zTBGue+tFfC+/N0pVARqF0ktl81bwdSqF8Q8sKsMsc=;
        b=QObRUJT4AngovWkcIsECI/X3YftWp4WUpyiFq2XH8msbQEKUlG93FbvHcEUjhrPokg
         datSHR274kVfggyZV4pTNZJMguH1cLwg5TuEo2wT9x67O1H5fmZd6MV8B1dQ21oLm/f1
         eYUJnji5Ix8mQH4ofgo8Tz3vpb69sDX0fTYm/B0eymiO5+WIsmKcJTQ1t4/TLzitBapZ
         wmQRyaJ7PAIRZ3FGJ+b8Xy+DJX+1PtYZ7ovfnzStPTcEFfgT37uu2dHlZTJg5Pn9Ri3j
         7BZ0DeO2MmHhpXtvicLBD21+FSeHsi4IuAOspIXfWVQ1+3XQRKRwf0DhU4CNMZVT/6oF
         EE8g==
X-Forwarded-Encrypted: i=1; AJvYcCWSEJbDKPYDRBs85WeV3hkZ2Q7ZtfJb+fS0wuJHhQknPY2hr8CDzavaFj/VaL8YxqrtQ8UTgWEJhwnKCiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHbI5vBul/UbQPS084dDJ8/7k4awvH8tYWq906neLUHWga/Hji
	nWbs5TxFoqWZdfJ84WsO8v2Brw2C89NzYT0MnkrbNKy3U4IfGn/+vR3i9Y0DReJ5pECh0D5yVbA
	dixQMRUAih/8KfbL89+Ah+tMEsR0HdzbmcXSQPVgB3mdcUMeESNbdObksPltedeWf4Co=
X-Gm-Gg: ASbGncuMg/zMomFaffWnYWoYuNO6Ke0FhdhdoPfIRbVw0Cf9Pg7n/6XnXVr/PnfEklc
	+M43NDSkA/TZX+bFKf0K2+IRfHypUsqRZvf8cvchjSWrI2+/YJCVxVLcDyppdhVHfzqhcVeZ21A
	05IwtyqUIwhAdi+osvTJGgni9oOiYfLCvxECfcQpkJs5/YprIRske0KNL4lAaKqOh13M9sLHdkY
	XMO+Or5/BOI1/agdbR7BAhpsyU41pVfUxWYjP0iuSIYZtEYjBDF7cHTtHodB6w7ieOsQlWfrMGz
	y22Q9BrXAmU0sv2BYLYZ+wakRecQlyX7+uqBATgjGW0SaY7uA0uBPTeSRtsUs3B7qw==
X-Received: by 2002:a17:90b:2f47:b0:31e:eff1:71a5 with SMTP id 98e67ed59e1d1-32517d1f492mr20621010a91.29.1756195695439;
        Tue, 26 Aug 2025 01:08:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqfB+pZfvTqHUF41HMHX+x0AmkewmZgHiKTej54kODMfH3nW3jwRXcNwCqB2j8DHg9fVZd+Q==
X-Received: by 2002:a17:90b:2f47:b0:31e:eff1:71a5 with SMTP id 98e67ed59e1d1-32517d1f492mr20620976a91.29.1756195694869;
        Tue, 26 Aug 2025 01:08:14 -0700 (PDT)
Received: from [10.64.16.151] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32548842931sm9091714a91.0.2025.08.26.01.08.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 01:08:14 -0700 (PDT)
Message-ID: <8243f4f2-4505-4264-91ab-3688f4f6fc6e@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 16:08:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] arm64: dts: qcom: Add display support for QCS615
 RIDE board
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li Liu <quic_lliu6@quicinc.com>, dmitry.baryshkov@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, xiangxu.yin@oss.qualcomm.com
References: <20250818-add-display-support-for-qcs615-platform-v6-0-62aad5138a78@oss.qualcomm.com>
 <20250818-add-display-support-for-qcs615-platform-v6-2-62aad5138a78@oss.qualcomm.com>
 <hlajupt4mwb27j4kbygdk5rifthnbnyv4ypcrqd2jk4vvdytoy@fef26rluqkxi>
Content-Language: en-US
From: Fange Zhang <fange.zhang@oss.qualcomm.com>
In-Reply-To: <hlajupt4mwb27j4kbygdk5rifthnbnyv4ypcrqd2jk4vvdytoy@fef26rluqkxi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: K1aJrSP06R_172kuOnUZeiyEqvG4yeXa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA0NCBTYWx0ZWRfX+PDFcffl9MzB
 cpp6zJwiytvSRJTy1Tc3U9v0Nl1F3nM225G6yPP6uXQS6/t3+PoYs23+mpojJ+vGylh7PaMp7b5
 K9r0qpChCxRzs1nrrOWfvaM3LlC2lnbWRrdL4BbTWh7xbxA8p5wbOdvWfN2T689jxJf22k6Ralj
 m6Hzt1fLjdu6QvL+kXcaNBtq3JjWIMPAvf4fzIz8ipBdsQecACDqkQ7VygCuGD5BuJireyCZX9a
 MTkp0moTQbZp/TJbjlpwI0ZdZMeemLNkSLBs8zRFX0ig5kyMfg9JPa8hUJxi7wEqN7fan4839J5
 HMl4sdYH34JVbh/Tmqe1hnyiwiVlA81BCvQTnn1dSHiyUVOiAMR1EqwILD/dk89f28X0PQFv4ll
 yLdofKxh
X-Proofpoint-GUID: K1aJrSP06R_172kuOnUZeiyEqvG4yeXa
X-Authority-Analysis: v=2.4 cv=Ep/SrTcA c=1 sm=1 tr=0 ts=68ad6b70 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=rL7T-puLNE1slI72-x0A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230044



On 8/24/2025 11:15 AM, Bjorn Andersson wrote:
> On Mon, Aug 18, 2025 at 12:39:21PM +0800, Fange Zhang wrote:
>> From: Li Liu <quic_lliu6@quicinc.com>
>>
>> Add display MDSS and DSI configuration for QCS615 RIDE board.
>> QCS615 has a DP port, and DP support will be added in a later patch.
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Signed-off-by: Li Liu <quic_lliu6@quicinc.com>
>> Signed-off-by: Fange Zhang <fange.zhang@oss.qualcomm.com>
> 
> Running dtb checker after applying your patch gives me the following:
>> $ make qcom/qcs615-ride.dtb CHECK_DTBS=1
>>    UPD     include/config/kernel.release
>>    HOSTCC  scripts/basic/fixdep
>>    SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>> Documentation/devicetree/bindings/net/snps,dwmac.yaml: mac-mode: missing type definition
>> Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml: ti,rx-gain-reduction-db: missing type definition
>> Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml: fsl,phy-pcs-tx-deemph-3p5db-attenuation-db: missing type definition
>>    DTC [C] arch/arm64/boot/dts/qcom/qcs615-ride.dtb
>> arch/arm64/boot/dts/qcom/qcs615-ride.dtb: clock-controller@100000: 'clock-names' is a required property
>>          from schema $id: http://devicetree.org/schemas/clock/qcom,qcs615-gcc.yaml#
> 
> Taniya is looking at this one.

Got it. Since the patch appears to be accepted, should I still wait for 
mm clk version 7?
https://patchwork.kernel.org/project/linux-arm-msm/patch/20250814-qcs615-mm-cpu-dt-v6-v6-1-a06f69928ab5@oss.qualcomm.com/

> 
>> arch/arm64/boot/dts/qcom/qcs615-ride.dtb: gpio@3e: $nodename:0: 'gpio@3e' does not match '^(pinctrl|pinmux)(@[0-9a-f]+)?$'
>>          from schema $id: http://devicetree.org/schemas/pinctrl/semtech,sx1501q.yaml#
> 
> This is from your patch.

got it, will change "gpio@3e" to "pinctrl@3e"

> 
>> arch/arm64/boot/dts/qcom/qcs615-ride.dtb: bridge@58: 'vdd10-supply' is a required property
>>          from schema $id: http://devicetree.org/schemas/display/bridge/analogix,anx7625.yaml#
> 
> This is from your patch.

got it, will add this part like 
https://lore.kernel.org/all/20250604071851.1438612-3-quic_amakhija@quicinc.com/

@@ -51,6 +51,64 @@ dp_dsi0_connector_in: endpoint {
};
};

+       vreg_12p0: vreg-12p0-regulator {=
...
@@ -338,7 +396,9 @@ bridge@58 {
                                 interrupts-extended = <&io_expander 0 
IRQ_TYPE_EDGE_FALLING>;
                                 enable-gpios = <&tlmm 4 GPIO_ACTIVE_HIGH>;
                                 reset-gpios = <&tlmm 5 GPIO_ACTIVE_HIGH>;
-                               wakeup-source;
+                               vdd10-supply = <&vreg_1p0>;
+                               vdd18-supply = <&vreg_1p8>;
+                               vdd33-supply = <&vreg_3p0>;

> 
>> arch/arm64/boot/dts/qcom/qcs615-ride.dtb: bridge@58: 'vdd18-supply' is a required property
>>          from schema $id: http://devicetree.org/schemas/display/bridge/analogix,anx7625.yaml#
> 
> This is from your patch.

same as above

> 
>> arch/arm64/boot/dts/qcom/qcs615-ride.dtb: bridge@58: 'vdd33-supply' is a required property
>>          from schema $id: http://devicetree.org/schemas/display/bridge/analogix,anx7625.yaml#
> 
> This is from your patch.

same as above

> 
>> arch/arm64/boot/dts/qcom/qcs615-ride.dtb: bridge@58: 'wakeup-source' does not match any of the regexes: 'pinctrl-[0-9]+'
>>          from schema $id: http://devicetree.org/schemas/display/bridge/analogix,anx7625.yaml#
> 
> This is from your patch.

will remove it

> 
>> arch/arm64/boot/dts/qcom/qcs615-ride.dtb: phy@ae94400: Unevaluated properties are not allowed ('vdds-supply' was unexpected)
>>          from schema $id: http://devicetree.org/schemas/display/msm/dsi-phy-14nm.yaml#
> 
> This is from your patch.

will change "vdds-supply" to "vcca-supply"

> 
> 
> Am I missing something? Is there any reason why these 6 new errors
> should be added?

Sorry, I missed those parts earlier. I've re-tested and confirmed the 
changes. The patch can pass after refine.
Would it be appropriate to send v7 now, or should I wait until the mm 
clk v7 is ready?

> 
> Regards,
> Bjorn
> 
>> ---
>>   arch/arm64/boot/dts/qcom/qcs615-ride.dts | 90 ++++++++++++++++++++++++++++++++
>>   1 file changed, 90 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
>> index 59582d3dc4c49828ef4a0d22a1cbaba715c7ce8c..39c757b66f47579d9bc7cc5c4d703f7af4434df4 100644
>> --- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
>> @@ -39,6 +39,18 @@ xo_board_clk: xo-board-clk {
>>   		};
>>   	};
>>   
>> +	dp-dsi0-connector {
>> +		compatible = "dp-connector";
>> +		label = "DSI0";
>> +		type = "mini";
>> +
>> +		port {
>> +			dp_dsi0_connector_in: endpoint {
>> +				remote-endpoint = <&dsi2dp_bridge_out>;
>> +			};
>> +		};
>> +	};
>> +
>>   	vreg_conn_1p8: regulator-conn-1p8 {
>>   		compatible = "regulator-fixed";
>>   		regulator-name = "vreg_conn_1p8";
>> @@ -294,6 +306,84 @@ &gcc {
>>   		 <&sleep_clk>;
>>   };
>>   
>> +&i2c2 {
>> +	clock-frequency = <400000>;
>> +	status = "okay";
>> +
>> +	io_expander: gpio@3e {
>> +		compatible = "semtech,sx1509q";
>> +		reg = <0x3e>;
>> +		interrupts-extended = <&tlmm 58 IRQ_TYPE_EDGE_FALLING>;
>> +		gpio-controller;
>> +		#gpio-cells = <2>;
>> +		interrupt-controller;
>> +		#interrupt-cells = <2>;
>> +		semtech,probe-reset;
>> +	};
>> +
>> +	i2c-mux@77 {
>> +		compatible = "nxp,pca9542";
>> +		reg = <0x77>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		i2c@0 {
>> +			reg = <0>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			bridge@58 {
>> +				compatible = "analogix,anx7625";
>> +				reg = <0x58>;
>> +				interrupts-extended = <&io_expander 0 IRQ_TYPE_EDGE_FALLING>;
>> +				enable-gpios = <&tlmm 4 GPIO_ACTIVE_HIGH>;
>> +				reset-gpios = <&tlmm 5 GPIO_ACTIVE_HIGH>;
>> +				wakeup-source;
>> +
>> +				ports {
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>> +
>> +					port@0 {
>> +						reg = <0>;
>> +
>> +						dsi2dp_bridge_in: endpoint {
>> +							remote-endpoint = <&mdss_dsi0_out>;
>> +						};
>> +					};
>> +
>> +					port@1 {
>> +						reg = <1>;
>> +
>> +						dsi2dp_bridge_out: endpoint {
>> +							remote-endpoint = <&dp_dsi0_connector_in>;
>> +						};
>> +					};
>> +				};
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&mdss {
>> +	status = "okay";
>> +};
>> +
>> +&mdss_dsi0 {
>> +	vdda-supply = <&vreg_l11a>;
>> +	status = "okay";
>> +};
>> +
>> +&mdss_dsi0_out {
>> +	remote-endpoint = <&dsi2dp_bridge_in>;
>> +	data-lanes = <0 1 2 3>;
>> +};
>> +
>> +&mdss_dsi0_phy {
>> +	vdds-supply = <&vreg_l5a>;
>> +	status = "okay";
>> +};
>> +
>>   &pcie {
>>   	perst-gpios = <&tlmm 101 GPIO_ACTIVE_LOW>;
>>   	wake-gpios = <&tlmm 100 GPIO_ACTIVE_HIGH>;
>>
>> -- 
>> 2.34.1
>>


