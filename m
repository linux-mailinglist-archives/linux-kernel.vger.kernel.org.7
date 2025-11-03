Return-Path: <linux-kernel+bounces-882743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C53C2B4F7
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 12:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20443B6AFA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 11:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0A43019D8;
	Mon,  3 Nov 2025 11:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pnLOgxBl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="akzN7B/O"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD86301461
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 11:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169018; cv=none; b=MwKCY7jNnrgjrpAtgihYl/IjS9UcnF2jbfVeVoFyvwMK44BS2UMAYD2hO1JCJdKb1ldmpbys7q9FhdRC72e8oQlaIfxg4+IiiiMMCmclbYBsOCwWDGjjZuvO+BFR8bt6wL1lfNfzt1eCusxu8fQHOKQimcZ9+k2V2fJJEQ6noIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169018; c=relaxed/simple;
	bh=4/8WP3/8KyyzzaZycL4PjwRartXnOK5+lfg70dZVDxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OCguQZh+Y//gBSDoAw3ZSkuOo3M4urjKOm7B3hkOHK6Qf6GOq9S3PnmWDsdonyTJy3fiSC4qDMnlJNgQPRpS58eGsxwlJTn1MIHNIX/u179bhSdIq+jWUcNJ/wxZXxU7V/eCk5tnPBrMi4Pcj1wQbJv07B81KpYKUR0Nv5deHNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pnLOgxBl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=akzN7B/O; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3AV6Im1941375
	for <linux-kernel@vger.kernel.org>; Mon, 3 Nov 2025 11:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5b10FLwdc0HwfhtHnLEhX+TKUMxjRqrZdtiXlxAFFhw=; b=pnLOgxBl6+dCHxKW
	lAlsG/z2cU0VId0oT3LbCKmtvWPxR3REb+eQM7EyiVfXDaPLUyuE/2nm5TG/DKDY
	diRj+4sRVi53bHFaIa9sMN+h+BlCjWOGKwigyiK6cRZwa6GaqCMJyZhO29+RekOv
	sQykdJ5ZemSYs4LIcO8g2nPi8kFC/0c78+agaj5OJvkEiVdy+0OO4AxoCl2ADcaP
	iQOzlHbe3zoQbZ7N5bDcyGuu5VnB/Z+xb1Y41Mtf6pVCj9e66W399KbQvtFXqgB4
	8R1E9KlfOPA0+uRByYIeg2vZqE82hA+rxNmiM7EWd3DlCs5G95IVqJL6fZY/ZzBd
	9Jowtg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6m9w9a4v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 11:23:34 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e8934ae68aso19041561cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 03:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762169014; x=1762773814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5b10FLwdc0HwfhtHnLEhX+TKUMxjRqrZdtiXlxAFFhw=;
        b=akzN7B/OJ2YJa3MSJThD3J642zoOtFyRr44q+yEXxFAtHuljhSKinNr1PNS6uMYqsj
         h1NSluTJ0yTX+DOSQECPx0ZRJySA6D54BByAo0lheii1UMAzwnQrayUnPAurlLCBaCfK
         kiSpqroordh4+55WJYgAqvdFhdtm9Qm+lGINri6dJqzH9i+81ZDt5Zk1lk0ZplT9dtyO
         QTjjYNbvg0IXfUZWoRtXg2wENdxqFs6OBgP/bPybQA7RPgMGLBxgs9alLJpWQRF6BHKB
         6sTIBLe/XqThcRzVTv2qFWB0MEFMaQL8Vu7SHFZiZKWHX1XXGA3TX4Cxwdm2fi7PQN48
         b4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762169014; x=1762773814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5b10FLwdc0HwfhtHnLEhX+TKUMxjRqrZdtiXlxAFFhw=;
        b=d1q2oj4tn8NOU9biLG0lv3DfjbcvcAFNnZ4emMbXIfobrsZNWc3tRet43+Oam/n2Hp
         7wcdSUQGfbuMZllIg2o53rrgV9S3QxIwXRjCivcSmqdvlM9OPLrSsD7CeJEQqhQqzxyJ
         jkTr7UUy7VIIOwg8FgeEoWGNho/QmWuYyi9fznRYtesgzBnaqNm42GD0jX7LdubkydJd
         SnRUjI+qDcfcwn5QnvD4LwjSF368MlsTW25xQi64OTPQP5p7rsRmfO5WroP892nCfgdd
         QESqbOdsHxiATKvN3TIOoV8rresoiycRR+dSgRXsrv+wgBysVWBsG1kP2ZFHJTjm24IW
         7+9A==
X-Forwarded-Encrypted: i=1; AJvYcCVYEkwFtXpXRWgRqJZZu+vIYIXBUXuHxHn+GEfUXEZEX2YaLM4I6yTIv6u2yua5N/29K59FMZeSrXUweOs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybalp4w6C8t+DwlwPZM2bZ0zy73QsYp9yowp5nDNGBfYdrrpit
	BEQmuPPi+ljz1Xos8DGDK5jWMsn38rh8HY1v/yJ+rP8tVqY+k5J7Htxva21qWxcOBPqyhu/Qtmg
	dOCDsf0f7v7a4fCmyTNH2m10n9X1ZRv1Y37aVqzOrLJUC6y+rmQSBny0OaXM0U3i5wqA=
X-Gm-Gg: ASbGncvuAR2om/v4HC2yghjp7s0jJSY1sM8ZPhYKBuLnisfrhfevMa42ySxIhtM6gWg
	B/u6/Wkbe71x8P92Fh8fn3iiO0izgNf5/7LnUl7eW0f+gMVHxM/nVjP8iOjyRrsA2aV1hHTtMTR
	oaVM83MymgSXy3cVebci05xZ/WolEaT4U9zXQ42+Ma2ipa//TRcJQHxXa6NQAx7bpaLh1DdqQ5l
	a3BQAIDvvuHVMy7airyooo3kd1/H6AOS8NKTda1UWnhoqTJ95niCskfpHxUtrAeWVSfo0CDs8Xr
	oSlbAMXDMnA0Kh246lbm+FRP9xA1sMb26wqrGbeKeBfofw86gdB58VOnhGJ+Cl07TysZ164ii48
	TTjMy5j1HtDaz5NYJpZ/PbvqHRa7iJzduH+nLAsjJrYWjRu+3oio1U/50
X-Received: by 2002:a05:622a:38e:b0:4ec:fff:2815 with SMTP id d75a77b69052e-4ed30df2e79mr102046741cf.6.1762169013910;
        Mon, 03 Nov 2025 03:23:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZBwX1D3jJCH15p0kqXDXLz16GUl/rSLJBQ9cfFvv8QZ1FAc1bO2rtImHjVEhSEJLcC8qRzA==
X-Received: by 2002:a05:622a:38e:b0:4ec:fff:2815 with SMTP id d75a77b69052e-4ed30df2e79mr102046551cf.6.1762169013507;
        Mon, 03 Nov 2025 03:23:33 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6408ef1c486sm7892631a12.36.2025.11.03.03.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 03:23:33 -0800 (PST)
Message-ID: <e516564b-5e43-4628-836c-ff227a68d20e@oss.qualcomm.com>
Date: Mon, 3 Nov 2025 12:23:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: msm8953-lenovo-kuntao: Add
 initial device tree
To: Raihan Ahamed <raihan1999ahamed@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli"
 <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20251031135506.214025-1-raihan1999ahamed@gmail.com>
 <20251031135506.214025-2-raihan1999ahamed@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251031135506.214025-2-raihan1999ahamed@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=P7Q3RyAu c=1 sm=1 tr=0 ts=690890b6 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=iN3SH9SwNKT8slD2fOUA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: 80B2qps6KkSPACUZPv7P8lkfEg9CI8lt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDEwNCBTYWx0ZWRfX7v6imZ5nBba8
 t+MlZi3gk1dwCfKgF/KDVTbBDiIKVapmbN9fJVCcG/kuMV09IATW6f/RFmJdDimtGzDZXyehEac
 2H7v7CKmKevtzEvpIVNa3FCqQKBxIIrXep5xbcec3NyaPSsUhn8Ax7PaPlNQ1QntoeIHVoHknzZ
 hiRsFz3x09uvWycZH0mqRKb4B3UHFV0JXaVOcV1RCqNog5wBxBafulMP9MvX4ssOjsy9aSbQiuj
 uFlOPpVHlrBwAPzGBU0CumG4iz6tlYHlyJQ2d71nLCLA029gMcIgxgYnMd+TKTZa5rdNsQnK4Df
 HTcl90SHI3WZqyKg94q0xab+m9qqrYcjdm1/k1r4uP1xD7xPVP4knMmLuBG84C0LIqIKnHc6pvH
 SMXgEbC8ebZCQ51qp0YA2V9amv+6/w==
X-Proofpoint-ORIG-GUID: 80B2qps6KkSPACUZPv7P8lkfEg9CI8lt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1015 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030104

On 10/31/25 2:51 PM, Raihan Ahamed wrote:
> Lenovo P2 is a handset using the MSM8953 SoC released in 2016
> 
> Add a device tree with initial support for:
> 
> - Enable accelerometer sensor
> - Enable pinctrl for GPIO keys
> - Enable gpu and add gpu_zap_shader
> - GPIO keys
> - SDHCI (internal and external storage)
> - USB Device Mode
> - WCNSS (WiFi/BT)
> - Regulators
> 
> Signed-off-by: Raihan Ahamed <raihan1999ahamed@gmail.com>
> ---

[...]

> +++ b/arch/arm64/boot/dts/qcom/msm8953-lenovo-kuntao.dts
> @@ -0,0 +1,294 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2024, Raihan Ahamed <raihan1999ahamed@gmail.com>
> + */
> +/dts-v1/;
> +
> +#include "msm8953.dtsi"
> +#include "pm8953.dtsi"
> +#include "pmi8950.dtsi"
> +
> +/delete-node/ &qseecom_mem;
> +
> +/ {
> +	model = "Lenovo P2";
> +	compatible = "lenovo,kuntao", "qcom,msm8953";
> +	chassis-type = "handset";
> +	qcom,msm-id = <0x125 0x00>;

QCOM_ID_MSM8953 (dt-bindings/arm/qcom,ids.h)

> +	qcom,board-id = <0x41 0x82b1 0x41 0x83b0>;
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gpio_key_default>;

property-n
property-names

in this order, please
> +
> +		key-volume-up {
> +			label = "Volume Up";
> +			gpios = <&tlmm 85 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_VOLUMEUP>;
> +			debounce-interval = <15>;
> +		};
> +
> +		one-key-low-power {
> +			label = "onekeylowpower";
> +			gpios = <&tlmm 86 GPIO_ACTIVE_LOW>;
> +			linux,code = <ABS_HAT1Y>;
> +			debounce-interval = <15>;
> +		};
> +
> +		homepage {
> +			label = "homepage";
> +			gpios = <&tlmm 132 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_HOMEPAGE>;
> +			debounce-interval = <15>;
> +			gpio-key,wakeup;
> +		};

Please sort these nodes without an address by their name> +	};
> +
> +	reserved-memory {
> +		qseecom_mem: qseecom@84a00000 {
> +			reg = <0x0 0x84a00000 0x0 0x1900000>;
> +			no-map;
> +		};
> +
> +		ramoops@8ee00000 {
> +			compatible = "ramoops";
> +			reg = <0x0 0x8ee00000 0x0 0x80000>;
> +			console-size = <0x40000>;
> +			ftrace-size = <0x15000>;
> +			record-size = <0x5000>;
> +			pmsg-size = <0x2000>;

Usually ecc-size = <8> is desired, as the traces are often corrupted

[...]

> +&tlmm {
> +	gpio-reserved-ranges = <0 4>, <135 4>;

Any chance you know what is on these GPIOs, and could document it (e.g.
like in x1-crd.dtsi)

Konrad

