Return-Path: <linux-kernel+bounces-749111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 557A8B14A3D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 073563AE490
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3785D2857E2;
	Tue, 29 Jul 2025 08:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yqnr8IP5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A41285C97
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753778287; cv=none; b=oKiW0pyQZC0L3TLrBxqTj3EPylyphgULhFZTZXHeGXpQlwEsU5ioFQoljIb0880WvO/I8Fv0LS6RNK2YTBARGoJmE2deg1tqSryd7F3vRnW/ToTk8iidhgVulWkLwRcsvAigmAW/pw2FDoPkK6lwq/jPQwCt1LCCd9vUdZATlDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753778287; c=relaxed/simple;
	bh=2CKRoTOlakoVAgoUoXVDppdXBBkLdTwPeVGLg7uldsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mc3wSLOtB3iRS/7hqu+tP2MiMvjLZZb1UL8aqUshJubKBCcoDsBMyaSqa4Sw1v32CBccEu2pLHjK/61QZlBwSrQ6d4ogp9BsIL2MtZbDvY9MrM8VV5l5vsg6FQCsmFY9/8bnjTbUW8CBb4sAFxK0d7KtKs09gkyeG7kj861x+OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yqnr8IP5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SLgjLo006589
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:38:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3gghsUYc5xKakDXh6woUpeDalKj8wf6qzVK3HfipwTc=; b=Yqnr8IP5tQmqwuCH
	8larnZuta/+U8dsWfNr+tyBYywiAoB6ITRP0tVqG85kwyRZmvpi0zjxwbrk3KSm6
	ecHaW3RSWIX3zFf6TsnRqajGd8a7Zt2tKA9QExLceoSyogqmIuvdpU7LUdZNY9C3
	9+xfAaHqz9hPRmzmj2ZhGQHr0ju1cfU00qTfIeiJMF96sGkXi8bhrkDakDXm73mh
	qnX0OcOBXruC731vuCZwtvGeD+w0WylYAY4SwmIWG/cz/H0SkhNBU0KZyYMukbe9
	3Uqcou0jmE5huLEDkDyhxwNKlEL75SFJ8r8ICY46L7Dmhgx++YGLHFGxCKFCTq5F
	hRDAPw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484nytymhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:38:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ab7077ad49so10912281cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 01:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753778282; x=1754383082;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3gghsUYc5xKakDXh6woUpeDalKj8wf6qzVK3HfipwTc=;
        b=I55rurfDk3Q9wbpr3QG9Y3q++jDCVRSkkGtdKN/CK2NCWlbZrCp1ANMz2S/AbnmMpX
         c716Nex8DC8z5QkvcelFGPO69rL/DCheo2J/u8BHDLGuQeN6pfzgrCCnK2Bu692wU3EM
         XTmuu4tV0zbW2AVQIr5Ly8wMrgs+wcE1Vm2mf5Dr9onU5TgLk91nnUBYHUadt+2cV8Ux
         p0cTrVyc3jadQiql/BEiqI4b4k1fpz43j4xYNmIU4dEJivlwjALeG/9G9Vxl75+l8rob
         4KQ/KcJeQQGJE78qvJMJeDKgzCANlpHRJdWmdzO7r4DpiQs07lrP9gfBbOgpWq70A3R0
         BX+w==
X-Forwarded-Encrypted: i=1; AJvYcCUwzDFNtT3h97e6VtQI1ExFmHPIEox1M0ZAZ303xyCVRECc3+yTlMiK47GDwW024MtJA0mJARD4ryG9oO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT8cAcM31O0TIeCgPl4UIlerQ3ykn6YvJqs7g0EN4jUc6TSFXs
	YP7bT9ylH8Dkag7cPcx15cjWtcoKirQbpjXJ0rnM8iy4VmcqKyShnRA5ConHi7BQvsuEoJbJPiR
	yZZo61QxAl+AfB9SJK5M9dWfhH/v9+z1MDmDXFX94Xk5DM0ES4Nf2l7rJvBOEbzZscO34mEuuGx
	8=
X-Gm-Gg: ASbGnctY6S8CRxSGaoqvchAAyNZczEM6jk1GWky5xNS8wV5DBeBDfgwAKYn9M8nJGNd
	3iERwcgq1TBhvzla45p9/uJP28P9xwX3q1efy3HgaJnT943rLFpYhFW7C+PMYJ3ciSJZJPy1gJn
	8izkBU0acLnOWCGkPm5+GQ8YyVCTiqHHNcyKBh+r8YKIINiTWNVAxlZBGKn5OJIzuu/2nVxhef0
	99ISTwKlvxXbwh25cvx9Gly94EQzI12Ewth896C5353jMJKH70HlVaQZmttYokCE4rPkh/R/ohQ
	iNNv/IbefhL4H1h3AluB/oISE+lipgPPE+8pmTiI8jFHNpJkUtwevL90IoA8PcoSHt/aEjuoOra
	6Frg79JvsMX1fFPDLNw==
X-Received: by 2002:a05:622a:4d3:b0:4ab:23fe:a743 with SMTP id d75a77b69052e-4ae8f04c25bmr88571821cf.9.1753778282405;
        Tue, 29 Jul 2025 01:38:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFk+8osi5NjoyJJc0sozN4PRSplo5UEsJysdEFgi1ECjypp4pJyuHqbEQ1g7FkQEOFLo3MQA==
X-Received: by 2002:a05:622a:4d3:b0:4ab:23fe:a743 with SMTP id d75a77b69052e-4ae8f04c25bmr88571721cf.9.1753778282010;
        Tue, 29 Jul 2025 01:38:02 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635aa21fcsm557954666b.95.2025.07.29.01.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 01:38:00 -0700 (PDT)
Message-ID: <d14b2a0c-8304-497f-a662-5b93dbaaa1ed@oss.qualcomm.com>
Date: Tue, 29 Jul 2025 10:37:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: Add base HAMOA-IOT-EVK board
To: Yijie Yang <yijie.yang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250729-hamoa_initial-v3-0-806e092789dc@oss.qualcomm.com>
 <20250729-hamoa_initial-v3-4-806e092789dc@oss.qualcomm.com>
 <a6456802-3d19-4da5-a995-c8f00553c7fa@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <a6456802-3d19-4da5-a995-c8f00553c7fa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4zG77PBJcVCMGup24wGsgyoFPVOYt4Wx
X-Proofpoint-ORIG-GUID: 4zG77PBJcVCMGup24wGsgyoFPVOYt4Wx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA2NSBTYWx0ZWRfX3nR21860w3+e
 k8tarKepnYT7nCIIaGttzis36A6wCDb+cVj1Hy2Fz7enBzu4jeo3WX/KUydMvn0P+UeIRMumrA8
 oi43EstGoEuaMH6MlR/eUgZzkgLlFy1r6u/nj8Zh1Eerkbxv452DmhsEmeUCswldLIPZMM1964S
 4ZnhcLn+V5DuEpqAoXe87LCHQOFALgoDrq9Ykk8mCvKQ2G7m29on6musb2Wj+4i86TeYAOgXNCX
 QOylmO1C8fFSets40GbuANG9ksu5ZrE6jTd+TGt2/3mV2vDXAIm5q4HXiYlICiiyE3grR47nSxT
 5wd3lZstzIknfV9W+VRMvVnuC1Divimx6lCG6cppyCmU7s5D7xQ6mmYAWgZ4DFRP9KWz5PlMpQZ
 T1cFPcs34HAxapMu8a0mfpijNzrpvFEXT8ZeRvphUW4O7xr+DtEuWPMK2fbcfT/rNUmTRU6v
X-Authority-Analysis: v=2.4 cv=CLoqXQrD c=1 sm=1 tr=0 ts=6888886c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=ZOIhAQMpLvIksW73xekA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_02,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290065

On 7/29/25 7:51 AM, Yijie Yang wrote:
> 
> 
> On 2025-07-29 09:32, Yijie Yang wrote:
>> The HAMOA-IOT-EVK is an evaluation platform for IoT products, composed of
>> the Hamoa IoT SoM and a carrier board. Together, they form a complete
>> embedded system capable of booting to UART.
>>
>> This change enables and overlays the following peripherals on the carrier
>> board:
>> - UART
>> - On-board regulators
>> - USB Type-C mux
>> - Pinctrl
>> - Embedded USB (EUSB) repeaters
>> - NVMe
>> - pmic-glink
>> - USB DisplayPorts
>>
>> Written with contributions from Shuai Zhang (added Bluetooth) and Yongxing
>> Mou (added USB DisplayPorts).
>>
>> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
>> ---

[...]>> +    vreg_wcn_3p3: regulator-wcn-3p3 {
>> +        compatible = "regulator-fixed";
>> +
>> +        regulator-name = "VREG_WCN_3P3";
>> +        regulator-min-microvolt = <3300000>;
>> +        regulator-max-microvolt = <3300000>;
>> +
>> +        gpio = <&tlmm 214 GPIO_ACTIVE_HIGH>;
>> +        enable-active-high;
>> +
>> +        pinctrl-0 = <&wcn_sw_en>;
>> +        pinctrl-names = "default";
>> +
>> +        regulator-boot-on;
> 
> It should be set to 'regulator-always-on'.

Are you sure? Turning off Wi-Fi sounds like a valid usecase..

Konrad

