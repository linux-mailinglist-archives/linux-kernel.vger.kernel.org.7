Return-Path: <linux-kernel+bounces-783909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15808B33413
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 04:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D00822028DB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 02:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107761C8629;
	Mon, 25 Aug 2025 02:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HAkcIalf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA311F8ADD
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756090056; cv=none; b=RBXZz0ZyW/gpXgIsd+q6vcKgxs3t1Te0tpbl2vIDwTcyDTSvZYbvea25qn7ReOHU4npMFz/f9xL+WxD+CFpsM8i15yOAXYyIBvbQf4OJQWc9ZSwf6u0Y/o0xQExTOZlxbYN7+T3uVVmo7e1aJW9iJZKPa3zrW5uiLMsSATgiU8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756090056; c=relaxed/simple;
	bh=jQfOcv0qAZgmoBS52zIxnB5tEXBhDfuQ+QjUbe2iqG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nIiHGz7ywachxvb+Pk2HM4FZHWULR1jQ3jQXCcK3hLT9xo4upZ533GM/CmKrKlQRoUGtCgOgCzF1Skv1ruw+Jweay1uYztrrAcw1tUL5URvm53TLdZQq7zvhei2jhqnX8FcdVNpS3MtHIEnRC6wTHduvuwopFn0ypfb49RkJssY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HAkcIalf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57OAF39A018862
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VfwCKQQQnYyOyRVHfRHX+KeL2RRlkeV3bTTxzNTzSBA=; b=HAkcIalfRFlYnUX8
	t9Gzy/Ods4IqfajOAUimn8GjZEAtfxRbSeDjKrGoOJ3z5YC2vfDmssj2vtntw1sa
	jiITs0f1QgvCFoUrddkM/1h8e04zxf0vn9xQjij1M0WIYWr/pi/tYbiEZj4myC+z
	Q77AtddiSuPE0nRaPBaXXhbCW2fAjeLHYFWZtsLI8/XZmrmHdvwTHqZMABJ53tV6
	Vgz7gDUf+/fQ7wuRLIbL9C2csNqtVt5DatRF4uTW9jybniGxBrZ8avLxM2OXPyFJ
	bJjDk7jGQsU7IfNvTN33cBB7ecPOyRFZMfKaU4Q3TwYZJZzHRngCDRtPmj8Jrjza
	fuHK/A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xpkgs5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:47:32 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-246cf6af2f4so11347035ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 19:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756090052; x=1756694852;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VfwCKQQQnYyOyRVHfRHX+KeL2RRlkeV3bTTxzNTzSBA=;
        b=VEVkID20kEfJUph0AXRffWEr+FWUmlvsEOpMmoY3O8X0f/JhucQe+Fb74IEkx+Bosh
         YZBchnVKDLB8t29JX8T1/jiuS3eeMmB5SqBijGmuNy8VGuaINceWCcHKfX6yRVOA2a0G
         Xnx8Xmh6oD7eC8s2vB1vWBcjFY7yHYXspu0o7xz86xzp2Ix3P+UxAIYglkDYABceTYpw
         LvYvCtHJsZcCXKtvlhV8LN6NKe+StLBfuI3gcCT61/r46uW5UjuA7mP85xczg7T4vpbU
         cJIa/7LVqKaeKLFWy/j/DfTvxThq9jI3WwbcDhrZdinXoTSJ8QCpxr0AIyVN6kyHnJEZ
         t/3A==
X-Forwarded-Encrypted: i=1; AJvYcCV10QaX5a7FUaAWG+pI/k1ZAVcNuRHSyw/9BLwtbKUOdfS7IFnbwgZG5uojNXT2GseMCdDjpnKZ2sLaARk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1m9m38U2nPRuN/QkNGs9qGuHDJSp1b77Jb3uuMBqVb4wgCtRP
	DzEfSMjZv/c+ZbTwFLetbz3S1XoNqM03MJOYBbwjfd7mLYqZ2+vlsikFms7VCy9XmmLbKqRwORU
	yyG9F9V4RpKCmaYo9Xqbf5pjJPbiyB4Omu9w6H5DHJIwscLrivhwIpUV1k82ndLOmtwI=
X-Gm-Gg: ASbGncunl2C59AFzQ8KzVvzn0gyiXItoXl6tk8FdJX1y0HKflDVe8wo4zle4rODBN0f
	zmafgxpsJ1KMY5U37ako+VXAhJjp/ursXP8UYDmrQzTZx2nUcsHGdb4vtZUTLAvuM6qRk/Ztr+V
	rXBgiMqS5dslHFpZfHBKF2iDLa+F+Abh/9tGqiR3utTLzlJE85rQnxox56TJDREWJT6IpuXGNtS
	02+HSG7DU2SKU752n1kH+HzGYv9kOUjzd/zXgB26tNFDhtqFn+RiMHnh7zgpnI0G39+YC4n4BED
	FkrRHNBaXiVW6utAPq8jn16yPQLmJ/Pd1GzFdT0M2v9FNce6WKNQhr9CT3Ia8L1YkjkzmugkZyN
	eppu94HrLy7WyPGysJsQKgmSqaBycyJyU3Q==
X-Received: by 2002:a17:903:1a2b:b0:242:9d61:2b60 with SMTP id d9443c01a7336-2462edac937mr157895115ad.6.1756090051606;
        Sun, 24 Aug 2025 19:47:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKKIMXe43+T6NFMjiAvVF6JqkUeNAVwNxuN1RJ80TidJr0d/oJGkVlSukrU1thyXtU+ftllA==
X-Received: by 2002:a17:903:1a2b:b0:242:9d61:2b60 with SMTP id d9443c01a7336-2462edac937mr157894865ad.6.1756090051160;
        Sun, 24 Aug 2025 19:47:31 -0700 (PDT)
Received: from [10.249.29.105] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324f3c94c05sm4432718a91.3.2025.08.24.19.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Aug 2025 19:47:30 -0700 (PDT)
Message-ID: <33ac5fef-f855-46f3-acd3-daa8fc34d918@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 10:47:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] arm64: dts: qcom: Add base HAMOA-IOT-EVK board
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Quill Qi <le.qi@oss.qualcomm.com>, Jie Zhang <quic_jiezh@quicinc.com>,
        Shuai Zhang <quic_shuaz@quicinc.com>,
        Yongxing Mou <quic_yongmou@quicinc.com>
References: <20250821-hamoa_initial-v6-0-72e4e01a55d0@oss.qualcomm.com>
 <20250821-hamoa_initial-v6-3-72e4e01a55d0@oss.qualcomm.com>
 <jj3mvad27kdpfxo4p2c3jfpjq2icao6mltpx4uu3sretqgkfap@vpqgfwzl3sjs>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <jj3mvad27kdpfxo4p2c3jfpjq2icao6mltpx4uu3sretqgkfap@vpqgfwzl3sjs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KOlaDEFo c=1 sm=1 tr=0 ts=68abcec4 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=DkPH1XLGW4EbIkNXeAUA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: EcfP7pt8tgXyPXH_BsC4MklfP922ZPsA
X-Proofpoint-ORIG-GUID: EcfP7pt8tgXyPXH_BsC4MklfP922ZPsA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX9AhDyFNDLYZH
 i8tdit0v1W6/9fttsyw2F+f1rw3oWvlDLE0UmFO/+dFlpngZ2a40MYtlKZEVlBkp46PVlAw16wM
 qo7Ih7sPCR6PO3LL/WJWXDUXYlSwQOMEacMN1BmpdOxSQhUmxPvJ0kJ5G/1+L+p0FKoup2jIQHK
 O/xfRt/xomTSIh+FWTJTEFUHYxLWgbc3AIKNbw3MdZim69lO3c8GXsIi+7rXSl0/E0FNvrGqPeb
 hlx0TlWjZXbqfJxXjLYSk9ILfTr2UQh70oIotZv7zGxk27ltk5rfF31jsUcTe6i+BuPSKGRjqx4
 7iQlg5SG+LhsvJi8hKRu+Bp14Zdxfam8jlXeqlsFVHKwyVzuPdSN1UvtBxBqW+/LIRKy20NaGfm
 Jcjacwvh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_01,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033



On 2025-08-22 19:56, Dmitry Baryshkov wrote:
> On Thu, Aug 21, 2025 at 04:20:24PM +0800, Yijie Yang wrote:
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
> 
> No WiFi?
It's in patch 2/3.>
>>
>> Co-developed-by: Quill Qi <le.qi@oss.qualcomm.com> # Audio
>> Signed-off-by: Quill Qi <le.qi@oss.qualcomm.com>
>> Co-developed-by: Jie Zhang <quic_jiezh@quicinc.com> # Graphic
>> Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
>> Co-developed-by: Shuai Zhang <quic_shuaz@quicinc.com> # Bluetooth
>> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
>> Co-developed-by: Yongxing Mou <quic_yongmou@quicinc.com> # USB DisplayPorts
>> Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
>> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/Makefile          |    1 +
>>   arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 1247 ++++++++++++++++++++++++++++
>>   2 files changed, 1248 insertions(+)
>>
> 
>> +
>> +	vreg_edp_3p3: regulator-edp-3p3 {
>> +		compatible = "regulator-fixed";
>> +
>> +		regulator-name = "VREG_EDP_3P3";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +
>> +		gpio = <&tlmm 70 GPIO_ACTIVE_HIGH>;
>> +		enable-active-high;
>> +
>> +		pinctrl-0 = <&edp_reg_en>;
>> +		pinctrl-names = "default";
>> +
>> +		regulator-always-on;
> 
> Why? If it supplies the panel, then the panel should be able to control
> its power supplies.

You're right, I will fix.

> 
>> +		regulator-boot-on;
>> +	};
>> +
>> +		wcd-playback-dai-link {
>> +			link-name = "WCD Playback";
>> +
>> +			codec {
>> +				sound-dai = <&wcd938x 0>, <&swr1 0>, <&lpass_rxmacro 0>;
>> +			};
>> +			cpu {
> 
> MIssing empty line between nodes.

I'll update.

> 
>> +				sound-dai = <&q6apmbedai RX_CODEC_DMA_RX_0>;
>> +			};
>> +
>> +			platform {
>> +				sound-dai = <&q6apm>;
>> +			};
>> +		};
>> +
> 

-- 
Best Regards,
Yijie


