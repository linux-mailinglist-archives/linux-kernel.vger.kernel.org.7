Return-Path: <linux-kernel+bounces-757169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA47B1BE91
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 04:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA4307AC93A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 02:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDFC19ABD8;
	Wed,  6 Aug 2025 02:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MOplgINl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ADB43AA1
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 02:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754445802; cv=none; b=UyoKbwhkG9Klo8L4tL4YJcwbYHk6fiDQn2Hv992dcw3NyOWXAJAf1h+as7rzs6OesX2s2MO5uJZQM0gNWx6USp6d7G0eplsfMVCySXgH3ImcCUToK3uyqfEshm5suRVI7XdM9uJ0RmYkt2bnTO3ZJFRIBwtj1Ukdcy4mZ5vWsRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754445802; c=relaxed/simple;
	bh=yQ0X5Sh2IRFr6+WChcckko5DuqGHABmbY7j2aD3oLhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CcetuMx6DwGPf+uhyA5wEjVD6mAARpdwC3KcdeaYbivtuje+c3nLJRwfvRl7kqOM9Lo429vaO4WKOwotBt7qt3D5KihUkhwOSPjZKmaUm4ZimDiIcQdIRLI0uHcR/f+dv5PlzK1RPu74tdKUiOyoCHiBbfBuHbxbAHZzucNrk5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MOplgINl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5761exx8022254
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 02:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Pa6eon19WOoAfQ7dFcaevq1RhDE8WqrMwPaomjOaHfE=; b=MOplgINlR29H83KC
	016aSkAkanGrhhijQXj6ThKqAZVKR5SxiiyM2AFT2rDMJTMF0tXbkIkYYRan1hYU
	ailacuvphKKO5w+TVFa7poLXFJ1EU/cOl3XxxSt5sM8Xz0aAMOU3j4FlF5Z6nyTD
	V2cEL82GUfQSku7WbGp5A4ZLnPMCU5fH8ajosMYtlw40gdx3/erFner+A8Nj+ZOj
	vGSUXignxHF30OkyRJ+XVUDK/hI03wm+SEnUUQym4uIkp5aHWAsS1+aznqa2oh9G
	6+ro+LUyabusj7uzbMcoxvdz62YbatkIkzqVCTueJZud5FNu52luo/tib6KoiVFV
	TBMYiQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw311jm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 02:03:19 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b42249503c4so370836a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 19:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754445798; x=1755050598;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pa6eon19WOoAfQ7dFcaevq1RhDE8WqrMwPaomjOaHfE=;
        b=V4dvQh2beQP2yCaAgAAvXK3hHiHMabY8XnqXpjXGj2syeMzx21lSXrPjgIodyWnpxe
         cKeSgihmm1XhfH+rIG6jGRKZjqj3sTUCAHVvIU8pc+7ypGpgNnGKn+TP8/5QHAKiMI8b
         6p3XDVEy6knrXcRJwyQV3DlR15yADjWVdhzoC5MFdU/dU580mDh6IVUA4h41DEK1PoyW
         QZ8p1XHIR4hK2Itsz7krLODQ0nH2/2GYGLTGg/bQ4ZUy3ii/PzKMEr5WGvRUM4AFWPtT
         VtsAkoW/IBRw8G5F3UjItln+T14zaHskcxj1y1qKGfg2QIcUtlEYn+5y43gyXkjVI8WF
         AIVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVczM203qP+Inu/wmL1CTVWFB4u2Gem4VvzFtj/Yo2aY2RpnbSJRysFveLev5G3hdK2ahECnh8qf42qGmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzgmciM4IfS+35HZTzpgARVSOzyeGQD0a0n/jwDVoJE4wHpIEY
	TN4teP0YkD86s0aHv8AAlnHAsl7/XqN9mxPTMm3AMPbpPjoIK4NLg8pGKHl8Ljp8Zzm8uYQXZ6W
	YHYKUPhA01jJ4T2ZgFcS0ceuriDHnw5l+/d57q0vs5xRd9555pFHwCeMiSErufr5KU4k=
X-Gm-Gg: ASbGncu4qjJSrgZaRIo11Tfbgh5h/ZtT2eNIaRNFH7OYHn2xBVXFc7jAj/JbZtutH0+
	9pccwKdhUZdnMhDFczNjwS8Ja6WfQkbykw+tvPOpfGt4wy268fObd2dTutpNDoUvHhNifeLFFoK
	YVT5L/xpMphzjCulIvb132Luw4G2EjIYIc6jvz7n/pALeUwe5bUcv2Hn2mNrDv7PnJDviHJhIPI
	H1S09waIis28N9DQj1Gl+hJumcB5cwl5fCKVuoACoqspSxf+EjeWv3HNrNuqqk1ou8uS/Lizuy+
	pxQODXmHXdhy3yZiwfmgM4YX4fVMBwVkjfExo9e5f3PLaH+T42o1HnN1FJ6ez/Sgm5Xuo7nE7rz
	b8eRN+znTQf8H3w7cLEUJW6T8cqKRCFM=
X-Received: by 2002:a17:903:4b50:b0:240:1ed3:fc28 with SMTP id d9443c01a7336-2429f957616mr15542775ad.12.1754445798485;
        Tue, 05 Aug 2025 19:03:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL2wny7m01oo9UXpqJQf/8c7aXFeRWf4P3nmdOkRL20z1AyuApVrl5radxSkk4RNf5Mx+owA==
X-Received: by 2002:a17:903:4b50:b0:240:1ed3:fc28 with SMTP id d9443c01a7336-2429f957616mr15542315ad.12.1754445798000;
        Tue, 05 Aug 2025 19:03:18 -0700 (PDT)
Received: from [10.249.10.160] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8975acbsm146214855ad.85.2025.08.05.19.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 19:03:17 -0700 (PDT)
Message-ID: <972e0ef6-9068-438e-b02b-f48a2fe22e2a@oss.qualcomm.com>
Date: Wed, 6 Aug 2025 10:03:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] arm64: dts: qcom: Add display support for QCS615
To: Krzysztof Kozlowski <krzk@kernel.org>,
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
 <e2dbef3b-89b4-41cb-b94f-9b432de36802@kernel.org>
Content-Language: en-US
From: Fange Zhang <fange.zhang@oss.qualcomm.com>
In-Reply-To: <e2dbef3b-89b4-41cb-b94f-9b432de36802@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOCBTYWx0ZWRfX2nV8rGcUc0Kg
 BJ5rHa5atMoXXO0b0SU5WaToE/meHnuh/5w0K0D/wRAFTI2APKyfJM8ohiAVDWUSBPmVhyZyyuu
 WQ9yPhg8AKLIzJt8V9iF6UN0I84tOMkip3GEXPqrVA7W+tKbD9YF3kWbAPFrhOc32g0xIy5euTd
 HsbKXroZHEAtwRkqH5aj4Cj6t6sw04eh+AWb81AsBzQYUXP9IxbZPLG+w/iphHnPgbqD/nNZCOd
 Xjjpkt6h3l68eYOgOZrZpFAUIniK5seCJP4+2Lj+J6wEz/DCpa+Rmw2xrhWoQ5gJpWTCkgc9nXc
 a5vAKKeuO92JbOegic3bnb9Hm3z55uvBme/Q6z78D91Z+nWjK2tit3bCQgFkkn5AHkXlZe3WFqW
 +4nCMN7K
X-Authority-Analysis: v=2.4 cv=J8Cq7BnS c=1 sm=1 tr=0 ts=6892b7e7 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=BaePNsoVr1Wy0kwGYTwA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: f2ICyIIhgB1sVFIsVgehtHS4fGLPsFQS
X-Proofpoint-ORIG-GUID: f2ICyIIhgB1sVFIsVgehtHS4fGLPsFQS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060008



On 7/29/2025 8:36 PM, Krzysztof Kozlowski wrote:
> On 18/07/2025 14:56, Fange Zhang wrote:
>> From: Li Liu <quic_lliu6@quicinc.com>
>>
>> Add display MDSS and DSI configuration for QCS615 platform.
>> QCS615 has a DP port, and DP support will be added in a later patch.
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Signed-off-by: Li Liu <quic_lliu6@quicinc.com>
>> Signed-off-by: Fange Zhang <fange.zhang@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/qcs615.dtsi | 181 ++++++++++++++++++++++++++++++++++-
>>   1 file changed, 180 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcs615.dtsi b/arch/arm64/boot/dts/qcom/qcs615.dtsi
>> index 142338069a74cc6c263e17d84efa22ccd0c26813..24299430b195026e896c365d80a0036713f00d35 100644
>> --- a/arch/arm64/boot/dts/qcom/qcs615.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/qcs615.dtsi
>> @@ -10,6 +10,7 @@
>>   #include <dt-bindings/clock/qcom,qcs615-videocc.h>
>>   #include <dt-bindings/clock/qcom,rpmh.h>
>>   #include <dt-bindings/dma/qcom-gpi.h>
>> +#include <dt-bindings/gpio/gpio.h>
> 
> Don't add completely redundant/unused headers.
> 
> Drop

Got it, will remove it in next patch>
> 
> Best regards,
> Krzysztof


