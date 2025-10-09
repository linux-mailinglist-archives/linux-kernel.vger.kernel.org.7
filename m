Return-Path: <linux-kernel+bounces-846582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12052BC868F
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 12:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 560AA3C1D6B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 10:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01E72C11EB;
	Thu,  9 Oct 2025 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JXCcBTPR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3191EF36B
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 10:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760004558; cv=none; b=tpdXz6thXY9Y96C22hq+pKSL/fc4mK111MOP7u6Lc0hLh5ViaMMc0T+hy16KMQSF3Fpegr+H4757kiufMTnUf4x3ES0u/Sqa1RXq9zzbeHBt2A3J3db2F7VhD4VUvWUV9sikATkK45oRvTnYtU0gkVCEN2SIVoPVaZjrdUTJP18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760004558; c=relaxed/simple;
	bh=puyXQak5xCPes5C3V32+uKNZqqPJViEywLe19Swh2E4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JlYeT5BRwshnD8mevrzYK+ACSplryw6oSQ3PTXtdLebiMyqC+msKzIxF84JZta52JLzZqfkbqjZGdWUjGBQRRLAlbR84fMbVH2VSVjE1wmaTWxXK4Hz6PVkWm2DShteM/ym869IAM1hpy5aN6vZN0SAS1iVZqsy+lMT6JOWW8qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JXCcBTPR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EI4U004368
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 10:09:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ht1MeJWzpyV8az6qvFclkme+Dolv3sGsYlW3nKW5fGk=; b=JXCcBTPR4EY5gF5K
	J4dWhqNDnBYI2yBzkAuq1/y32hI4tJDw9PAnK9FNmfJEyw8yzdYvl6bKsaLAjQXp
	U0+eHrgth5ZZ4fN/hZvTag2Mm+vTi5T7zFhHasj03bvzg4OHiLS/DCZxvaUYTB4x
	5yM5NXMAM+mar9U7bmnLMeUcVIzc8BPWZL7LOu4zguO9Rb93vN2ARtE26Hc2kd+w
	p5CF6fNCDKsSFJwl2Zbb47lyBKABZd8DmvS35gx9hLttNvbWxdEpBW2Xvw5S/1+H
	x2YHgYhgKwOzvudlJZXJK0YU3eYCrldJYixlzF3+KkHpvFd11xNPDaeYASF2a7jD
	bQFFog==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4j2bv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:09:15 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2697410e7f9so28633325ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 03:09:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760004555; x=1760609355;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ht1MeJWzpyV8az6qvFclkme+Dolv3sGsYlW3nKW5fGk=;
        b=iykdXyRZbOY5MRkBRd7FK7nIrUJuCsxCsASZwhYOi4jjksSy5lIPC3LQKTq7x8j3ff
         +5+RVoSo2LzR5Pf9JmqzV/hL+jnXY65bHEpfUtZw9Bke/bVA4J5KVVO+jaNkpD8Gzu4h
         1tSDZJKga2CtOZUjcR3JKG3/6uE9+Cd/4KOSPdhV49qhZZjW1YEROHoqpoP5aFXhfUXx
         N+2aYQOauQCLqWepBmMCaplpqnFtcYwQRl472T+bSbG9pht4VFhpMGU4DupIL10+TOC3
         OZd0PLUyzPG0avOqKzl5xf3rZv4mj0fkNix/FN95LwpcD8wTkwHUxfOZCYszF+675eNj
         Fb5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTrGbKM/alHWlIwwFbvu7gBRu9vojPMnc6LFwK1pblItxxGbRQd/VzIauHYpv+Tx8AqTRUJP3RIIrtcjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YybAeHgHve7Q2Mve0LV+9k7WFr+/5WWm7lKotp6/HYYuc8MilYb
	ccqHZBsHvIDbwSCe9e2JRyVUZZJrftRXAZVMXuliSf8XFsAHImwe0xDTgK6grIJ3bXLdTc0xCz9
	Wn2zcYjsfYX65dxp33UbljjUpfnjbIMZf+1yDpZs8pivuyBfwtduFYAfij00b7jgXipQ=
X-Gm-Gg: ASbGnctM91J2X+VIcj5cgO1buSNkC8d7PS1C5dV2tDNmdxsx4qtKrMdqeWt1fPQX0hp
	ad6Nk+oeWgCWM9SqPJ3+IN3YfpsF1U1S92bAj6WIW4nK7kcurHVPeOU5CT70GMLMkDcO0PqdTR+
	zv388iHeLW271ylNoHuKQo8ZXS9G6ajvRt/jnG3+39uG8XpoOkAh5zSIl2YXbyBceP4f2NfZoPL
	sOhTAklzheyOTyAQOG4Y8qp8Jo6wlC6T3hh5VBV05QM+QHBK0tqTtuN9vkwWiI1jJzwlSYTjurx
	q7JYzB/UnryLHgbFlYwKTJy2dTA2q14R53wf+fIT5BgAJy09M34eLsfB8ClrhSmCDMoGaBPSj/T
	kXLB/DaCRYvLkosa0DvlsxiWtkX0rwjOy5uAd7SNLJXeWEHwB1lZJoFzXICshd80=
X-Received: by 2002:a17:902:d481:b0:24c:7bc6:7ac7 with SMTP id d9443c01a7336-2902723d3e5mr91832285ad.18.1760004554661;
        Thu, 09 Oct 2025 03:09:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbx041+jdp7rBtoEFzf+vebUcsdFZtILyK/9Cau44Kb79AycvWz2CsWtBIsKytzaPmMQlspg==
X-Received: by 2002:a17:902:d481:b0:24c:7bc6:7ac7 with SMTP id d9443c01a7336-2902723d3e5mr91831775ad.18.1760004553869;
        Thu, 09 Oct 2025 03:09:13 -0700 (PDT)
Received: from [10.190.201.224] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e1ccc4sm23764105ad.42.2025.10.09.03.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 03:09:13 -0700 (PDT)
Message-ID: <6aed71d1-ece7-4b33-8060-ea3a51015a26@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 15:39:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] dt-bindings: remoteproc: qcom,sm8550-pas: Document
 Glymur ADSP
To: Rob Herring <robh@kernel.org>
Cc: jassisinghbrar@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org,
        mani@kernel.org, andersson@kernel.org, mathieu.poirier@linaro.org,
        konradybcio@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
References: <20250924183726.509202-1-sibi.sankar@oss.qualcomm.com>
 <20250924183726.509202-5-sibi.sankar@oss.qualcomm.com>
 <20251002005434.GA2796203-robh@kernel.org>
Content-Language: en-US
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
In-Reply-To: <20251002005434.GA2796203-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: R82L76U5pb9ryrhnvph1wLb7VZ-jNV3B
X-Proofpoint-ORIG-GUID: R82L76U5pb9ryrhnvph1wLb7VZ-jNV3B
X-Authority-Analysis: v=2.4 cv=f91FxeyM c=1 sm=1 tr=0 ts=68e789cb cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=K0PDbwUCbj7d31mOmPMA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX6rUy0Qld9tXC
 HX1KyxsGAGU0Ea5Re5OI9x7OgU+qA0RN3wypT7JMafqXj9K+StIRBnF1yQdvy5t5ZiUall5eqWW
 W5O3m2pSAgPcOuEWqkW6CVGjhHhyWHpIDsEOsFsmC6BzA4/CJuUUgnGfRB5xQ7XrIel838UWJzc
 C9NXd1Rd+LiPe+s5TOoUv5LDmt4iXWcT4oGVjb0XNmCyxjphHcEzjBz/daboggzwekEf5OAL/jw
 OTuwO+SvDeAU9QxKZrtCYcyQ4COmNvvkfMxeYX3tuplDQY0TSAp8qSTZQZEWBpBlnEN8j8tAvd5
 v4c4n2nt6XNbHnJEYdxa9uPEUNNyuAmk/DHFStUmk8Tr2V5nnlBSLpv3ZiaHOmq73NqOJ727WuQ
 d2mZ/wUTWasjuXOSMY1igc+qlyEBNQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121


On 10/2/2025 6:24 AM, Rob Herring wrote:
> On Thu, Sep 25, 2025 at 12:07:25AM +0530, Sibi Sankar wrote:
>> Document compatible for Qualcomm Glymur SoC ADSP which is fully compatible
>> with SM8750 ADSP. Also with the Linux Host running on EL2, the remoteprocs
>> need to be hypervisor independent, the iommu property is mandatory to
>> ensure proper functionality.
>>
>> Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
>> ---
>>
>> Dependencies:
>> Peripheral Image Loader support for Qualcomm SoCs running Linux host at EL2:
>> https://patchwork.kernel.org/project/linux-arm-msm/cover/20250921-kvm_rproc_pas-v3-0-458f09647920@oss.qualcomm.com/
>> This patch has a dependency on the iommu binding added in ^^ series.
>>
>>   .../bindings/remoteproc/qcom,sm8550-pas.yaml     | 16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
>> index 2dd479cf4821..cba45ce2865e 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
>> @@ -28,7 +28,9 @@ properties:
>>             - qcom,x1e80100-adsp-pas
>>             - qcom,x1e80100-cdsp-pas
>>         - items:
>> -          - const: qcom,sm8750-adsp-pas
>> +          - enum:
>> +              - qcom,glymur-adsp-pas
>> +              - qcom,sm8750-adsp-pas
>>             - const: qcom,sm8550-adsp-pas
>>         - items:
>>             - const: qcom,sm8750-cdsp-pas
>> @@ -95,6 +97,7 @@ allOf:
>>           compatible:
>>             contains:
>>               enum:
>> +              - qcom,glymur-adsp-pas
>>                 - qcom,sm8750-adsp-pas
>>       then:
>>         properties:
>> @@ -185,6 +188,7 @@ allOf:
>>           compatible:
>>             contains:
>>               enum:
>> +              - qcom,glymur-adsp-pas
>>                 - qcom,sm8550-adsp-pas
>>                 - qcom,sm8650-adsp-pas
>>                 - qcom,sm8750-adsp-pas
>> @@ -238,6 +242,16 @@ allOf:
>>               - const: cx
>>               - const: mxc
>>               - const: nsp
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          enum:
>> +            - qcom,glymur-adsp-pas
>> +    then:
>> +      properties:
>> +        iommus:
>> +          minItems: 1
> The min can never be 0, so it is already 1. Drop.

Ack, will drop it.

- Sibi Sankar

>> +          maxItems: 1
>>   
>>   unevaluatedProperties: false
>>   
>> -- 
>> 2.34.1
>>

