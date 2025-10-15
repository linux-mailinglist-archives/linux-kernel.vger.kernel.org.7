Return-Path: <linux-kernel+bounces-853680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B59ABBDC530
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 05:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DD303BD78A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A0A1A9F93;
	Wed, 15 Oct 2025 03:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iZAg+JuE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EED71990A7
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760498476; cv=none; b=K1cX9sVlF/rfhio2tS60cp5Mx60O4yH3YV+uLzOb2QlkYonmpMRCDZIAsW2BZIqdtMKNZGsuPFXOu7/O6xLkllHLuQ8iiwCHcmn+p4K3ZEqdXr5b9EY3gumSveq5jUj4s0mVCJRrrCg80y3QNBtlOYaO710mNok7tQf1O9bRI0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760498476; c=relaxed/simple;
	bh=M2p1ZN+5Xjl1QG9++mRp4SlbLr6IXjEbwxJhvs6kBUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHupv5Y5mPL8NewbmeOP+IaLcwcc3LJmYmdOPTwge3fEHzUY2pksMshRNkZ6qKkn9p1pTJdOL3SvHeTkkhQeSbMoihS6+EyGcdE69Q32ChhfoPFFLzJE6ukuEPBzlD2sJriQPLw7U4IcWQLUy/Ykg+hBPII0HCfuBx7ENi677WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iZAg+JuE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2s68t002496
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PAzWDXrNmyO6DLAmky6NWm+cn7OHuxBHBUdw9FN3WzA=; b=iZAg+JuEcr31i5do
	QZZcybSGCQjR9XdhRu+l/PC8hL53X9fW+O0imR5gPqPSAFyGAs0K7uFdSWNyEkgZ
	VPxgbY9mHacJRPRPkRHpO4Ww4pLsM0AkFWELMoOZBZQzup+1a80kksYnUMomvt8A
	jbyVv3bYwCFtQIr1pn0QhhBct77+I+aGnWAuJcSM4x011kfEUyu7GiU32BWYV+sN
	ChATyZ99FYzKjHEJONVeBoDuhDEoMP5/ovXW5gyeSqB7SgCQbLeF8U0FTC4OF+Ju
	2jMc6YfdUzFo/mToNeL83nevcUCNnUBw3Xb6kxQwZuot3bsre25AkYm8EmB38d+0
	QoiynQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfa8awwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:21:13 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2681623f927so103582055ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 20:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760498472; x=1761103272;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PAzWDXrNmyO6DLAmky6NWm+cn7OHuxBHBUdw9FN3WzA=;
        b=gTOvr2BxUkxsOk46Gyeq8fSYNuZCkgbrrIQN1FMnK00UDcVoMXcChgtkEeKkFfGgC+
         BV/XYKusZAIYQn0oChgqiVNxBmh+1N29iiOnwQC4nrrxeOxsPYSLJrLWlEnaLp/kEe/8
         pYrUOu8DBQPJT92J0Sds7Gq7PkylUkMW4IrRXYvvt3MI9ZBu6GqPMJPJy8oO32A/aD3e
         5n2gj7sNv6knBXlJm/4c32+E3tvvExKCguDR1/8FLe+NZ1/mETUU0Apo2Bk+JCx8jlDd
         SxMiFYY7yA2nakcPyUWgz1TG49bTAc4KgKq59HHgtwTd1FR8Bz/w/hEBx3bw0zQOlkjJ
         rhcw==
X-Forwarded-Encrypted: i=1; AJvYcCVQX0JEP/Nw4r7xSobOXrLEBfoQ5+Vp3x0T6Z3MhEw0+IjrfHYUV6tdtLZGW3m/qlkycs4VnlMfN+dLD20=@vger.kernel.org
X-Gm-Message-State: AOJu0YysKGKl33pbfZaYqvshvrToRKksfcOW/SfJSw64uwrQjTn3Infj
	6zhym/goMehEhGycyZaVKZCDoZkVndDazOwB5G+9ax5AlfeQ5Iv+tqlCe+7dll+S1KsgvX8vr5Q
	vZnge8tQoHW5PgkSz0ea+uKFYvFujv8L2HZHvX5enIZv1SaNt9sKwnmJq4413AocUIPU=
X-Gm-Gg: ASbGncuPRszJpn139DU6FwUiOSbuVZyOB94x5uMYCWF2W5Zwt8p1QeWnGNK4UFj3UP7
	SwXQKDVyeOQwvS2WnXQUCDe29iCQhmlTv8iZLqZC7A6XItIVD6s4tTKaBkXGjseUZyx8wLUh4Za
	rGyu6dDozX0lzp2Pd2vgZrSy27ZLbDihAP3Gsg+L5aouFgCUr7bru7GyV0M44Zeto235aZAcvpM
	7+XMhaBWf7aFyQW5Td3jPwo/DvUJ9rZxHtm96y936zeHVJgrvB3GUdbyDddf8BXBfWfMwfKah51
	gmbDvHyAqXGH+79NzleLK0hsZVHTnibkAothpgTMiF74uDY9UUwa/jabk8BWk066AlanMqIWbV9
	k3nRMwxVVGPAPLZ2j+SnNK035y4p565bYKWw=
X-Received: by 2002:a17:903:2a87:b0:269:aba0:f0a7 with SMTP id d9443c01a7336-29027212f47mr365376955ad.2.1760498472000;
        Tue, 14 Oct 2025 20:21:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdNWBjKeLeNUS4h2lLtfgUKsI8vFvc2mvlgVV7+FZSuN0cdYp1EPr8L0atoBEmT9D3LRygxg==
X-Received: by 2002:a17:903:2a87:b0:269:aba0:f0a7 with SMTP id d9443c01a7336-29027212f47mr365376635ad.2.1760498471529;
        Tue, 14 Oct 2025 20:21:11 -0700 (PDT)
Received: from [10.133.33.56] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e1cbadsm179489675ad.33.2025.10.14.20.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 20:21:11 -0700 (PDT)
Message-ID: <a7be3a42-bd4f-46dc-b6de-2b0c0320cb0d@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 11:21:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] dt-bindings: media: camss: Add qcom,kaanapali-camss
 binding
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
References: <20250924-knp-cam-v1-0-b72d6deea054@oss.qualcomm.com>
 <20250924-knp-cam-v1-2-b72d6deea054@oss.qualcomm.com>
 <CAFEp6-1o11B9o3HjdJY-xQhDXquOTknXo0JeW=HfpTxXcEaK3g@mail.gmail.com>
Content-Language: en-US
From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
In-Reply-To: <CAFEp6-1o11B9o3HjdJY-xQhDXquOTknXo0JeW=HfpTxXcEaK3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: EjveF4KfInF2E2Npg5C5k1JsulqAoz6S
X-Proofpoint-ORIG-GUID: EjveF4KfInF2E2Npg5C5k1JsulqAoz6S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX9NM5+5K8K0p7
 kdHHDreoojmszJNhkNt6LnMfHAXHPpOz2HKc1Ili7xDHt6JM0HfwXT5N6GFTrRI8bsMF5zuAL6P
 BWuRu2DnRiwO5S16o2xAGRXnMjFH8TAQINGyeMbRftqx1wPnIycGMXA5OUb9HyhZGNJwhOCoF+s
 rKf3bGROyI3Z1XNYmiB672wwJPDXA5Y/WOfjmtJnxNvLAGD0QyzveE1JFNVUBwaicw7uyefWiBV
 DxSYWltkuqatbCov55FRYgXnjTpAXhNPPn6P1Awo/SJ6mIM/fiP/OXSrl4w/ccUuz9GaHeTnzYi
 lDi93i3YmbFMod11ECUwm+aqv2VvOnLVGHAbWMO4boHKedHDPrGrWiyeLhHsN9+wDjM/1TSbnKp
 V9naJp2YmDMv+oMxW4Qs7o6Z7qgisA==
X-Authority-Analysis: v=2.4 cv=JLw2csKb c=1 sm=1 tr=0 ts=68ef1329 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=ww7spySswV7EKFqp46gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110017

On 10/7/2025 4:04 AM, Loic Poulain wrote:

> Hi folks,
>
> On Thu, Sep 25, 2025 at 2:03 AM Jingyi Wang
> <jingyi.wang@oss.qualcomm.com> wrote:
>> From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
>>
>> Add bindings for qcom,kaanapali-camss in order to support the camera
>> subsystem for Kaanapali.
>>
>> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> ---
>>   .../bindings/media/qcom,kaanapali-camss.yaml       | 494 +++++++++++++++++++++
>>   1 file changed, 494 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/media/qcom,kaanapali-camss.yaml b/Documentation/devicetree/bindings/media/qcom,kaanapali-camss.yaml
>> new file mode 100644
>> index 000000000000..ed0fe6774700
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/qcom,kaanapali-camss.yaml
>> @@ -0,0 +1,494 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/media/qcom,kaanapali-camss.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Kaanapali Camera Subsystem (CAMSS)
>> +
>> +maintainers:
>> +  - Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
>> +
>> +description:
>> +  The CAMSS IP is a CSI decoder and ISP present on Qualcomm platforms.
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,kaanapali-camss
>> +
>> +  reg:
>> +    maxItems: 16
>> +
>> +  reg-names:
>> +    items:
>> +      - const: csid0
>> +      - const: csid1
>> +      - const: csid2
>> +      - const: csid_lite0
>> +      - const: csid_lite1
>> +      - const: csiphy0
>> +      - const: csiphy1
>> +      - const: csiphy2
>> +      - const: csiphy3
>> +      - const: csiphy4
>> +      - const: csiphy5
>> +      - const: vfe0
>> +      - const: vfe1
>> +      - const: vfe2
>> +      - const: vfe_lite0
>> +      - const: vfe_lite1
> Wouldn't it make sense to simplify this and have different camss nodes
> for the 'main' and 'lite' paths?
>
> [...]
No such plan till now. Other series may take this into consideration.

