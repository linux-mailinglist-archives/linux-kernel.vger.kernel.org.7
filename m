Return-Path: <linux-kernel+bounces-818106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E83B58CBB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694083208BB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9C425F7BF;
	Tue, 16 Sep 2025 04:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LASI0Gdm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A2A218AAB
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757996389; cv=none; b=tImpFrRb1oxY81VP5h8NMe45iC3/t1xfCkb/B6+c8RdedCDH3syIcLgw7CEx7k1rwSS4W7nL8BylggUCpSCwkAgiyD5bXAATDoFKh+dl8dLc7JyXgPSYy1MjjkKfRBHpwDD4TDhnYPuyogAnrRQwT83bUpI1LKkmVFOrVkdq4so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757996389; c=relaxed/simple;
	bh=ZkhiQNS/ERWY+DeFuB3R+OOmnmRfw0gdxl5NPoVNeNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgRkwMiQSK2JV8nEXhUbzv0VDDAl3ZQ1AzEvZkzrSUpvyslhpjhTE0XsrZ/uLPNq5eldicWQtiTGzmDfAzYD1lqsXYlUivwgCG6f0kNnK8oJVJL++uLkXjQle0XeC5LK0K2WAcmJfBlsiiVJJtzVGmwdNnRKqrnau7oHBELr5pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LASI0Gdm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G3pudt020302
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:19:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1MNr2Oj/tB1HY5U5Py6BYHrc+/3H8dyW7TLhuRk0Sr0=; b=LASI0GdmddYWyaqP
	MD5f4hJd1DZI0gfl9JtKVuYM+H6vUYnls353z7XCon6HfO/zH06O4knR8k01X8hC
	C/I17RSEKQxDGePj3yW+FEFd+bF3ZH5DIb3+uULEybgLyH78tfDiuYLDRmgjB0JP
	SnpUboorfJ9G/ADfMeYshnskZG1DoVAkBN9okNBG/xA6EB9EKySXnxSur7+AUKWC
	GQegr6Jcc1AB9xZPt/Cf0avrcPdHhj+C5W265sgXaq1szBHR+e48Q/qO6eU/RLz6
	oeJUk5J05twNyQRgRyVYGFONPXeLCSjEuMzJ519zyQ69MA6p8AvJvNl8ZVWS3xtO
	vaP2kA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496h1sjucc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:19:45 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b521995d498so3664557a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 21:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757996384; x=1758601184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1MNr2Oj/tB1HY5U5Py6BYHrc+/3H8dyW7TLhuRk0Sr0=;
        b=X0IJngrXx59+E5UeCOp1bXDcLECo9oSclc58oqkxBknrkl/JtD0wzvz0Fs4jMUH30x
         pWENg30QxYN3Lq9yUwEWQHnqJ6nbnL4i652amKtoP5RVD/nLtnecmUhaEwAUzTKrk52N
         rka3LsohTNsBSWGBYzK0Az9FU8fKEfyr93XQ8tGHzSiGV3MsG+Njwh+m11ZiRia1GWT+
         uPtgliKKrCqLLUAes3OTISsMAgQg+8L39fcyGU61C/inIjKweQMRXERpmhNxQ47ykgGV
         lwYLzchYKRBfoiCCKr5cG+hgDopP7CEYD24XqY5qukYeg/w9ERDmcMpsvrYQRQAKwGYZ
         6+hg==
X-Forwarded-Encrypted: i=1; AJvYcCWa6Kv+a0rEcDPsj4zfQGvZJtBNKqXgiJIzsgGh/4dkOKNaE7DBKf+bCJ0aDSRq7vftjwCCAE4rdSShvpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLzfL/cs0xtpuSkd0KK+R6NdwqIQGsVCnJgt1TRprXuG2OToTF
	ZzVXBjcaJtBiCVLh5q+2YZXM77QNdac+o8FzpgSTGwEdqL6dcNyyQurtNodfr+LpksaXl4Ugl4/
	PCXGwRU6G1HyMRevsU2j7yx7I1naPLz9fMMjxojeWbK/98Ky4TMLJSFD4iuQqn7sc03qwoExaZ2
	GILA==
X-Gm-Gg: ASbGncucP2tsLhgWlFlPLHWs4KKFMAG933DoLwmGn+6nu6tc2d+q9GQmkReqQSGraTn
	1DxzxbzRmXeRSHq1ZGqFHeDX7LTmKmxi23hEargaGpdssjIRQyCiOQcumeEVxPshkMqawn635Yg
	0P/8eB0EAgO0rqBa+KgOYFrwA2TYGHcOQirQzQ6VNCKp0QJS32Jb9MDZH+N37PwCNwATuxMoXuT
	4mWSxy+w14hQmmIorh/klQQrLX/4f0EdnjE9eF5yiTyx+fDwa2wHXOB0htn1LJLLbEQ53wv76lN
	2dJ+afxm4bM+2fMk4vKsphaQXmg04t440RMstlM2kY41D1ZOS2kFF5/oExjNv5ymqyMuZM1iFGU
	Co1gyaFG3DP5DpiHEl+iOj+alXcnQWcwtvw==
X-Received: by 2002:a17:903:22c9:b0:246:76ed:e25d with SMTP id d9443c01a7336-25d26a59647mr179877635ad.50.1757996384190;
        Mon, 15 Sep 2025 21:19:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEV2LGxyMNtHNxIrsEsX9rK5fGWOmHILbA5HtUYr+apFXMFMtF4naZaW43tFzS64M44vPJAxg==
X-Received: by 2002:a17:903:22c9:b0:246:76ed:e25d with SMTP id d9443c01a7336-25d26a59647mr179877275ad.50.1757996383660;
        Mon, 15 Sep 2025 21:19:43 -0700 (PDT)
Received: from [10.133.33.244] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25e2fb546f9sm111530415ad.127.2025.09.15.21.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 21:19:43 -0700 (PDT)
Message-ID: <254d7d75-fa02-4bca-accf-4567b9dbf673@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 12:19:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 4/4] arm64: dts: qcom: Add base HAMOA-IOT-EVK board
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250910-hamoa_initial-v11-0-38ed7f2015f7@oss.qualcomm.com>
 <20250910-hamoa_initial-v11-4-38ed7f2015f7@oss.qualcomm.com>
 <aMPhEm8PuhEofHP7@linaro.org>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <aMPhEm8PuhEofHP7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Z8H7CMIhvKw0qE_0-fCWkgzMMo0syswi
X-Authority-Analysis: v=2.4 cv=A/1sP7WG c=1 sm=1 tr=0 ts=68c8e561 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=BKfv3jXuzfWu8byZeJgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Z8H7CMIhvKw0qE_0-fCWkgzMMo0syswi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA5OCBTYWx0ZWRfX2UWsXcYOynd9
 oB5VXl0a/ze8V6sUwuEmY2IKwCK0IY4K0z0kWQnAMQt9F3ng1J71tmTe1QQx5+F2+hITrXP6Tmz
 yacQYil479hhfec9Qh7vho84Ulj9igksS6zLfMfUAncRHYPbs6jkrp2/l4jz/45iVlyHXMZNK/u
 oXfwVYKDqkGeQbv63aZQ6vj5KppuAhSJ5TdpUeSFnZEJNVKLM5+0V9zyuIAhG+Y0sDUTVwd7wKL
 Ss4PDIwDDKA1vKDyHjjO/E3ENVXJYjR85piJNCCruqSB0OpGovYoN5kAUMx48SpSWC8Ct4wMXq7
 zv7458EdtwjgdGyWc7fb0dTfDAkhh577QtlrUjblD9qD5TlesH2DwrPAsn9J41YSI7I+oLAJYAM
 g8CFAWWy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_01,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150098



On 2025-09-12 17:00, Stephan Gerhold wrote:
> On Wed, Sep 10, 2025 at 05:02:12PM +0800, Yijie Yang wrote:
>> The HAMOA-IOT-EVK is an evaluation platform for IoT products, composed of
>> the Hamoa IoT SoM and a carrier board. Together, they form a complete
>> embedded system capable of booting to UART.
>>
>> Make the following peripherals on the carrier board enabled:
>> - UART
>> - On-board regulators
>> - USB Type-C mux
>> - Pinctrl
>> - Embedded USB (EUSB) repeaters
>> - NVMe
>> - pmic-glink
>> - USB DisplayPorts
>> - Bluetooth
>> - WLAN
>> - Audio
>>
>> Written in collaboration with Quill Qi (Audio) <le.qi@oss.qualcomm.com>,
>> Jie Zhang (Graphics) <quic_jiezh@quicinc.com>, Shuai Zhang (Bluetooth)
>> <quic_shuaz@quicinc.com>, Yingying Tang (WLAN) <quic_yintang@quicinc.com>,
>> and Yongxing Mou (USB DisplayPorts) <quic_yongmou@quicinc.com>.
> 
> This looks like you should have Co-developed-by: tags together with
> their Signed-off-by: tags.

Same with 3/4.

> 
>>
>> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/Makefile          |    1 +
>>   arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 1221 ++++++++++++++++++++++++++++
>>   2 files changed, 1222 insertions(+)
>>
>> [...]
>> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
>> new file mode 100644
>> index 000000000000..6eedad7e858a
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
>> @@ -0,0 +1,1221 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "hamoa-iot-som.dtsi"
>> +
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. Hamoa IoT EVK";
>> +	compatible = "qcom,hamoa-iot-evk", "qcom,hamoa-iot-som", "qcom,x1e80100";
>> +	chassis-type = "embedded";
>> +
>> [...]
>> +	/*
>> +	 * TODO: These two regulators are actually part of the removable M.2
>> +	 * card and not the CRD mainboard. Need to describe this differently.
> 
> This is not a CRD, I think?

I will update.

> 
>> +	 * Functionally it works correctly, because all we need to do is to
>> +	 * turn on the actual 3.3V supply above.
>> +	 */
>> +	vreg_wcn_0p95: regulator-wcn-0p95 {
>> +		compatible = "regulator-fixed";
>> +
>> +		regulator-name = "VREG_WCN_0P95";
>> +		regulator-min-microvolt = <950000>;
>> +		regulator-max-microvolt = <950000>;
>> +
>> +		vin-supply = <&vreg_wcn_3p3>;
>> +	};
>> +
>> +	vreg_wcn_1p9: regulator-wcn-1p9 {
>> +		compatible = "regulator-fixed";
>> +
>> +		regulator-name = "VREG_WCN_1P9";
>> +		regulator-min-microvolt = <1900000>;
>> +		regulator-max-microvolt = <1900000>;
>> +
>> +		vin-supply = <&vreg_wcn_3p3>;
>> +	};
>> +
>> +	vreg_wcn_3p3: regulator-wcn-3p3 {
>> +		compatible = "regulator-fixed";
>> +
>> +		regulator-name = "VREG_WCN_3P3";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +
>> +		gpio = <&tlmm 214 GPIO_ACTIVE_HIGH>;
>> +		enable-active-high;
>> +
>> +		pinctrl-0 = <&wcn_sw_en>;
>> +		pinctrl-names = "default";
>> +
> 
> regulator-boot-on?
> 
>> +		regulator-always-on;
>> +	};
>> +
>> [...]
>> +};
>> +
>> [...]
>> +&mdss {
>> +	status = "okay";
>> +};
>> +
>> +&mdss_dp0 {
>> +	status = "okay";
>> +};
>> +
>> +&mdss_dp0_out {
>> +	data-lanes = <0 1>;
> 
> This is unneeded unless you really want to limit this to just 2 lanes.
> x1e80100.dtsi specifies 4 lanes by default.

Great reminder! I’ll rebase on top of the latest code.

> 
>> +	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
>> +};
>> +
>> +&mdss_dp1 {
>> +	status = "okay";
>> +};
>> +
>> +&mdss_dp1_out {
>> +	data-lanes = <0 1>;
> 
> Same here.
> 
>> +	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
>> +};
>> +
>> +&mdss_dp2 {
>> +	status = "okay";
>> +};
>> +
>> +&mdss_dp2_out {
>> +	data-lanes = <0 1>;
> 
> And here.
> 
>> +	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
>> +};
>> +
>> +&mdss_dp3 {
>> +	/delete-property/ #sound-dai-cells;
> 
> You need to define pinctrl for the HPD pin here.

Will do.

> 
> Thanks,
> Stephan

-- 
Best Regards,
Yijie


