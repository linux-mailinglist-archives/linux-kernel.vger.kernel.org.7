Return-Path: <linux-kernel+bounces-794027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA94B3DBA6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D69B53B8ECE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15979376F1;
	Mon,  1 Sep 2025 08:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f71gxjXC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB9F243954
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756713647; cv=none; b=TeVpIgVvXI/vQpQ2j1xwLafPgTmvza1eEJq4Ck2eeecjSQ2oe20VOhbG4l1aB4Ov2w10+Wsx8ONneYeQ+w+KYSogeF3cAwbDn3RaEgDuh0Am1eN92kdp4+Iz8X+7gNk+4YUUTvaTxBgMfH8bNEFLI1+1GSYZheB0R436WCOK/vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756713647; c=relaxed/simple;
	bh=WV0jKWlHfFl8DVLyZj//3pe4rq8eo4E4hj4SKoTm4i4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tyLfBuioRA+VnlKBNHVxVjhj7yab+4CRdwdkbffo/x0s6smOhiduDG54q/qOX8DZjYmHS/fM/SMf5KVh4RbRkezk4WgwepDCXgr+JFDwCqYMG9emJcuWfznqc4XlYu71zO520uJfA5eO7DV862qATPWtIAIcgOuNoZCOAF/Kxu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f71gxjXC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5817haFg031230
	for <linux-kernel@vger.kernel.org>; Mon, 1 Sep 2025 08:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KYaRk7MoHtD3LVVRYkOuF+SpuJ/lbz4krp9ArV0SG+w=; b=f71gxjXCpYOC0MXa
	RisNz17lf4Qkivuu/0H8dSDowTewnbwkrrL0nbIZsAmtNBJmH8l3lKnFfWJGVL3s
	8tGdQN0d92DXiX1nDVJV12SEnRX38Dk8Idyu9mjOwj8TjJRs5ssKRwIJ1TTTOsr2
	5HhJibYB3in5faAyT76sVtpfTEyybRctMeEthSAaDb16MPuOBI0+ewA9HK+u4kug
	J6+e2tz0uYok8bRTk+Fb0CSba6k+UcL0hnKYXtU6aIfwsRGB7JnfOIVQMOSRc+i+
	WQeyhAitOdyuJk3fxKqcXTnBFFoXLL8wn3RDbeFlhdhgPgDFV3hJRIgHy7dpXHuf
	ubEWpQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0ec2bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 08:00:45 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4c2c09a760so3204223a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 01:00:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756713644; x=1757318444;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KYaRk7MoHtD3LVVRYkOuF+SpuJ/lbz4krp9ArV0SG+w=;
        b=CycR2R/ZqFAQMt0gwGgThteh0L3esRH+cAMwdGNZ5H3LLt9JDB2o3jm0KOn5UHp031
         QYq9180TFO/Yc3ohUPYHz88yQw/5e03vFaErqnF923fgCtM/by6OHMWxQVmc0e7/pz6N
         E5WNlMo7ucoeLaCXbLktv0HCoT50fh1DkrGGTUkZl0Q0V0P2gzazKTSHtuFsBfqvOTth
         exB3YHRRwkmn8jLw7GlAOaVV2xV70y5A58WXbU7OlX4m+b5+YEUg/cQKuWXkfaPwf43S
         Az7cF5hmVTof8k+c8WIY6QA7eBSXVN+S3yQqxB+PB+EbmQ/P9WpB6F71C7ambpjgInbO
         MuYA==
X-Forwarded-Encrypted: i=1; AJvYcCWVrNt501FpJ9hIQzVdCLt/1O9t7jCPa05zgshQP+iXUEKsl3y1IJHPd6NToO6k5uFGaFgOb0WTJFylOFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqvhVSvou61sP4quM2tRlesQk2sLaviPTFPLtTdU2m1qVvx0Tj
	CR96Z6VYbF6wSLYFzemvnU/TYgyEL3+zn8Q7abVwF95/rFAzGDNvCx8cgd5cn0dxx8R7o30cVZk
	hT2sP1IPgXC9Hm23lbOB5yQUdmvp7d4AR+UWRrLCgzbZRdimXnqDDYIReR6NK9pnbxLc=
X-Gm-Gg: ASbGncuy5QgL/kxSSIb9psV7xBhskcR1/x3lcjs1G0MI/edyPqG1LsWmHQbKbRb+pmq
	2mDUeTAU6dOHKSVv5Jm00UUROtfwsikK9el23zIibl1L6PdTM+FMlnewLLBoNRqyyp9dMcjIwmZ
	fViv7Wva8RgyocvRgLlXGfrZnHuBzY3y9WztrJuYSg1uv+NEDjDKenZ8iiO6GHhsmb5TbsWJ8bp
	BG1sNgVtx20dVkhLF5EwoxQPrI9q04zKn/Vx7dpeDvGoUvxoCGTZvzlevLR5TruKCVskdKDTjr+
	nRA7cuqRLE6cLBE3Gy3WeqYsLBxYWZazoMyDncLRgY3iEvoVizsnq0WofmclLov2NlOA2wlGlJ5
	vmGxptTfnomianFZk/G9vj4TuiI+0F0DO
X-Received: by 2002:a05:6a21:6daa:b0:243:95c4:e681 with SMTP id adf61e73a8af0-243d6dd5ab3mr10192534637.2.1756713644079;
        Mon, 01 Sep 2025 01:00:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5BErEL9P03p2C8xYTsnkLZIGbazwvxs3FLkuBdUYZU1o01hwahxzEjYjIG04iZH2UqHajoQ==
X-Received: by 2002:a05:6a21:6daa:b0:243:95c4:e681 with SMTP id adf61e73a8af0-243d6dd5ab3mr10192490637.2.1756713643609;
        Mon, 01 Sep 2025 01:00:43 -0700 (PDT)
Received: from [10.133.33.23] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd006ef70sm8770327a12.7.2025.09.01.01.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 01:00:42 -0700 (PDT)
Message-ID: <2de9fa44-0d77-4631-9d09-32c48a93a7f6@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 16:00:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/3] arm64: dts: qcom: Add base HAMOA-IOT-EVK board
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250828-hamoa_initial-v8-0-c9d173072a5c@oss.qualcomm.com>
 <20250828-hamoa_initial-v8-3-c9d173072a5c@oss.qualcomm.com>
 <qgirqibqvsld7n2ac4cvuvtqknhqkq535jkxnxjjqvss5wpm36@i3mbp7qgqxju>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <qgirqibqvsld7n2ac4cvuvtqknhqkq535jkxnxjjqvss5wpm36@i3mbp7qgqxju>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: olFBfO1ha3IecO_vsrcn9DYJr87sTaVI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfX8e/CA+6rjTWC
 Wyw745iypSp1h9nLea2gjr6OVGL+QSIl0I4WjkjyqcUYEGkN/MbwMiFJRCsNMEzaQCElz00jlL+
 Z+6cXFXSdplpxz2gcp01gnJRgcBzP7NmbsZ0LVnVoYgAWVkARHhXdFV/sJgE+SJwfo2CSC6JBXO
 5NnOh/2pfldewjugczYVZm7xDbJoqmgVxavphJ598NZKdCMjHIxMqf2T7480yrF2+ea/V7Ou5Kk
 5uUoxWMBlFP91xb0Se15qKKrT6TubURhnrdRormSzFxpf6PT+8PvBtnuXyC0S3xeIAWuzFQPkVo
 vNXVhGvJF6OGyRz7jzQENnV+WXtmhpLcFrC3kucOpKYQ/ZTZ2FGaGhGqM4WhMdOSCokAtdMkjtk
 Oxu34lBz
X-Proofpoint-ORIG-GUID: olFBfO1ha3IecO_vsrcn9DYJr87sTaVI
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68b552ad cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=sn0vIxX-2wHjl4zpZ4MA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300004



On 2025-08-28 19:18, Dmitry Baryshkov wrote:
> On Thu, Aug 28, 2025 at 12:48:47PM +0800, Yijie Yang wrote:
>> The HAMOA-IOT-EVK is an evaluation platform for IoT products, composed of
>> the Hamoa IoT SoM and a carrier board. Together, they form a complete
>> embedded system capable of booting to UART.
>>
>> This change enables the following peripherals on the carrier board:
>> - UART
>> - On-board regulators
>> - USB Type-C mux
>> - Pinctrl
>> - Embedded USB (EUSB) repeaters
>> - NVMe
>> - pmic-glink
>> - USB DisplayPorts
>> - Bluetooth
>> - Graphic
>> - Audio
>>
>> Written in collaboration with Quill Qi (Audio) <le.qi@oss.qualcomm.com>,
>> Jie Zhang (Graphics) <quic_jiezh@quicinc.com>, Shuai Zhang (Bluetooth)
>> <quic_shuaz@quicinc.com>, and Yongxing Mou (USB DisplayPorts)
>> <quic_yongmou@quicinc.com>.
>>
>> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/Makefile          |    1 +
>>   arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 1247 ++++++++++++++++++++++++++++
>>   2 files changed, 1248 insertions(+)
>>
>> +
>> +	wcd938x: audio-codec {
>> +		compatible = "qcom,wcd9385-codec";
>> +
>> +		pinctrl-0 = <&wcd_default>;
>> +		pinctrl-names = "default";
>> +
>> +		reset-gpios = <&tlmm 191 GPIO_ACTIVE_LOW>;
>> +
>> +		qcom,micbias1-microvolt = <1800000>;
>> +		qcom,micbias2-microvolt = <1800000>;
>> +		qcom,micbias3-microvolt = <1800000>;
>> +		qcom,micbias4-microvolt = <1800000>;
>> +		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000
>> +		500000 500000 500000 500000>;
> 
> Other platforms use a single line here. If you don't want to do it,
> align data to start from the same column rather than restarting from the
> column 1.

I will update it to a single line.

> 
>> +		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
>> +		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
>> +		qcom,rx-device = <&wcd_rx>;
>> +		qcom,tx-device = <&wcd_tx>;
>> +
>> +		vdd-buck-supply = <&vreg_l15b_1p8>;
>> +		vdd-rxtx-supply = <&vreg_l15b_1p8>;
>> +		vdd-io-supply = <&vreg_l15b_1p8>;
>> +		vdd-mic-bias-supply = <&vreg_bob1>;
>> +
>> +		#sound-dai-cells = <1>;
>> +	};
>> +
>> +	wcn7850-pmu {
>> +		compatible = "qcom,wcn7850-pmu";
>> +
>> +		vdd-supply = <&vreg_wcn_0p95>;
>> +		vddio-supply = <&vreg_l15b_1p8>;
>> +		vddaon-supply = <&vreg_wcn_0p95>;
>> +		vdddig-supply = <&vreg_wcn_0p95>;
>> +		vddrfa1p2-supply = <&vreg_wcn_1p9>;
>> +		vddrfa1p8-supply = <&vreg_wcn_1p9>;
>> +
>> +		bt-enable-gpios = <&tlmm 116 GPIO_ACTIVE_HIGH>;
> 
> Okay, so how is WiFi controlled? Is there a GPIO? The DT should be
> describing the hardware, not the UEFI behaviour.
> 
>> +
>> +		pinctrl-0 = <&wcn_bt_en>;
>> +		pinctrl-names = "default";
>> +
> 

-- 
Best Regards,
Yijie


