Return-Path: <linux-kernel+bounces-832188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB328B9E988
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C93637A4A19
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BB12EA141;
	Thu, 25 Sep 2025 10:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I8wPf8Ld"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF91523C516
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758795395; cv=none; b=nakcJ2JSvX2KAb3WqIxvffqlwQI4rgbQC/IIQ2MNIDm5QcDvWGHqp+ZJJ4hNXYxmXIxhSsy0xccA7FP+o7Pn/XjAr/tlKiEVQ/c8jmfJdxxbnkKCFVa48eLG5Utjaa4BWJgFs/OPu9eSswZZ1eI09Qgt8ijDLhwizIJBJY8vWKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758795395; c=relaxed/simple;
	bh=cnn9q+ZNxb1vh4X93U+qnl1z7nRJBqd+eW3oqS4POSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SbhoSJ0XoYy/jmZWfFAgio9+MhLt8wFpaXZV+0NZt5uqS5dZLxMDawKt1CTDogfAaqxWKED3A/+Tmf8AaCZWttkUqTjtvxV3LlTwsBTCkar7JIYIX4z+oCw26Ox6/NU3Bk3XPAcH8OM4iupMTwngV3lRIE4brFWVpFQGKttgyjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I8wPf8Ld; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9QLop025572
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QR933LWNJjgWeV7dMuTp3Litc5ZgQRud23Dp4IEYYhk=; b=I8wPf8LdDryNGvMi
	Qqhexk6IBIILJmX3o+8U95J9cq0Zi1Fs8olQNYl4jZBxPAZQ9mA8or191pWMytyl
	9/OxvI/NMAbzyxf1jQsxIqTc3BPeoX015Fr1v2pCk1MtpNZKOTGJXWZGUeS+BIj7
	2wpzal0xjcRjXH0woU/jGFgmfMLKegVK5VeWilMPrgtAS4R0//XYWZXE9qQkKl4+
	a3wqUoWFAJCepDACtZHX7LGicAHBk6GFI6WJLhrnBDZ+rydJYjh6LOGDTw57uY+r
	GVLjMzYq+raZV9saG29Vb4jCGoOSmS0sFNwY1QS3340dv24i/8rrXnax9GexZuTP
	oLEkBg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyf01r5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:16:32 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-78f40a59135so2063246d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758795392; x=1759400192;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QR933LWNJjgWeV7dMuTp3Litc5ZgQRud23Dp4IEYYhk=;
        b=P2ZJ/d2BjlfqI1oItfBqQlqfVquuPsJMf3/c5TYhYTLTLV8w4XGRYxlldnndwCY5L8
         19w4JLAB64Zmhw6H9tY8H+4NWyn9o7I7s40rV3zSgPWgdDnmWfAFPoUpCI3I9OZdp5Ty
         qkfvbUQXZhjCmpJW3yenCDTpudJtVR7frVR2RGUWbAJPtxGQkYteoioZoy9P3Sz/vzaw
         DdGSoSfHXBdKR64Ryv8RiktPVGvCdL4ummAvBgX2h9eTD5HY7vzJCyqtx1p/HyYc9O04
         bamjny5QDikTBOFlC3BllGEUVa1wvlSdHwKZftipgaxlWvrLu7tMZ7WavPBTWu9xt4TG
         D+BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbx5csaQl/ACgacWHKbDHwexljgXdNhCGUJRdJjnhW6hBsd3fl5S/A0pfIH2ZSm55NW2rVehkaeRlrXy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoN07fYtdtWkbVUF8nzFLrgZK0a0m/KZ+R4LVaXKZg9lNo6nfK
	knf5k6Jk3i9+TJwF75BwjWaEltWgZfWOeg7vkAxF0pnhN+1kNxfzdc25XIh3q3qjSy/Pd7hAl+n
	2gMNaDHs4VhXymqJ2uF4jSN3rsKd+TRsES8WyeU3mEEOWg/JIryg9n+wQfIM3NJ+D8NM=
X-Gm-Gg: ASbGncuKbztffUlxAXF9irjAFR1JLDfR50KLjjtOvgC9vVgLMXQ84OccCH9MRbwh0F8
	Z2Yo9qVvUewh5fbefM1MnHuqfU5VycmLs4Vol6gnVbQKR/0MZKDyx1FywI/VwhxNB3pl7QED/Hm
	ASFOovJlIUi34HnMu1JPmRuZbhsI+1WRJHsXi7UbxlpzNtPhXrAPk/OkW3akbs3H4d2aPi/0hQ9
	BtXe9mHTWv5ukDiOBc33TNHAdbe3YcHJaKvyoS4tLTRbYo+78Lj34c/ejEuxyATRzyp32hFnIhI
	h7ZnSKnbKsv1FYLTYLY9k9hbOxblTk3EFMl7xht/Jt1B0OBFGyBLPBpVimsnWLU+kuB+xkDmc+T
	RNz7bMDlE6Ek/BvIbd8WT3A==
X-Received: by 2002:ac8:5d92:0:b0:4b7:a9cf:91f with SMTP id d75a77b69052e-4da4b0490f1mr22401351cf.8.1758795391365;
        Thu, 25 Sep 2025 03:16:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjj/ZfVdzvXfp9gg2UszZ5VwMxNEejpTeP4g5NzZPK6LH2TSxAGBDvZNIGOmOLXvDGg2Yp/g==
X-Received: by 2002:ac8:5d92:0:b0:4b7:a9cf:91f with SMTP id d75a77b69052e-4da4b0490f1mr22401161cf.8.1758795390724;
        Thu, 25 Sep 2025 03:16:30 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3b05bafsm975284a12.53.2025.09.25.03.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 03:16:30 -0700 (PDT)
Message-ID: <2960a6fc-106b-4280-b4d4-9c1a3a449454@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 12:16:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/24] arm64: dts: qcom: Introduce Glymur base dtsi and
 CRD dts
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-3-24b601bbecc0@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v1-3-24b601bbecc0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: QIjWrxvvAy3w7vV4Z6l8W2ywsZHaN9Tv
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d51681 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=h9bIO8qCkgbVbkUqMQIA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX07hun3OkpYIG
 eWaL/NiFbgivXNigewVZzbKTNlG2EWI7oqeKbQm2RAHFmKdOIk9b1WOqsFvX00upS8Q3oc81tAR
 oxKyWoryeLPPmKNNWkEmoV8lfLOBnxzgiyETrox3D+eP/p4X0YPsW8oNnNrA7AjXuRP2svSZXmP
 l4xoxe9Cb9gAyJNCsMlLda0TqNCiIvjnJTlzLovxhzWP5dsdhxBcJum2e/1voj4KIU936AFDttU
 +J0ExpRJ5yWV5qhOhrPAeInnl1IhRA0XhkBJhYJoPOINYme65KKVVHeorvetTCH0FbSLIYb6Nsv
 opIbF9uc0sG4E4hjwov+of5eqsiBfYUen1PwKyWjJXzqzkNk+80HTPQWCvJ1GpErB9GJaVpzyxL
 ths/pj8F
X-Proofpoint-ORIG-GUID: QIjWrxvvAy3w7vV4Z6l8W2ywsZHaN9Tv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

On 9/25/25 8:32 AM, Pankaj Patil wrote:
> Introduce initial device tree support for Glymur - Qualcomm's
> next-generation compute SoC and it's associated Compute Reference
> Device (CRD) platform.
> 
> The dt describes CPUs, CPU map, GCC and RPMHCC clock controllers,
> geni UART, interrupt controller, TLMM, reserved memory,
> interconnects, SMMU, firmware scm, watchdog, apps rsc, RPMHPD,
> SRAM, PSCI and pmu nodes.
> 
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---

[...]

> +#include "glymur.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. Glymur CRD";
> +	compatible = "qcom,glymur-crd", "qcom,glymur";
> +
> +	aliases {
> +		serial0 = &uart21;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <4 4>, <10 2>, <44 4>; /*Security SPI (TPM)*/

Please add a space between the comment begin/end markers and the content

> +};
> diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..f1c5a0cb483670e9f8044e250950693b4a015479
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
> @@ -0,0 +1,1320 @@
> +// SPDX-License-Identifier: GPL-2.0-only

This is different..

[...]

> +		cpu0: cpu0@0 {

"cpu@"

> +			device_type = "cpu";
> +			compatible = "qcom,oryon";

We've beaten this horse to death, over and over again.

This compatible is meaningless, incorrect and shall not be merged

[...]

> +	cpu-map {
> +		cluster0 {
> +			core0 {
> +				cpu = <&cpu0>;
> +			};
> +			core1 {

Please ensure a \n between subsequent subnodes

[...]


> +	soc: soc@0 {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		compatible = "simple-bus";

compatible goes first

[...]

> +		tcsrcc: clock-controller@1fd5044 {
> +			compatible = "qcom,glymur-tcsr";
> +			reg = <0x0 0x1fd5044 0x0 0x48>;

We can map 0x1fd5000 - 0x1fd5094 inclusive, as that seems like a
logical subblock (this would require adjusting the driver)

There's also a laaaarge pool of various TCSR_ registers between
the previous node and this one.. but we can leave that in case we
need to describe it in a specific way some day
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +		};
> +
> +		tcsr: syscon@1fd6000 {
> +			compatible = "syscon";

"syscon" alone was not allowed by the dt checker at one point.. 

> +			reg = <0x0 0x1fd6000 0x0 0x20000>;
> +		};

[...]

> +			frame@17811000 {
> +				reg =	<0x0 0x17811000 0x0 0x1000>,
> +					<0x0 0x17812000 0x0 0x1000>;

Odd spacing (more than 1 space after '=')

Konrad

