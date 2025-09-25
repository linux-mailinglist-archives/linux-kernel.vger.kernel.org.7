Return-Path: <linux-kernel+bounces-832485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B9CB9F720
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD88177D24
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE9821CA0C;
	Thu, 25 Sep 2025 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FC/e12P1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F369216E1B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805905; cv=none; b=qrsqZf8Ks6xDMU1aumDt0TocfykJCxvYFXYcD/kHbLdB291V/4ZSTOVAhPwYk1nWFTrr51091dQLlvNzjT7Wx6Uj4QeMa8HFn+y3kXDjHSIjmhpBu6RnKWE6H2kDmsj2bmfG59gS2Ar9rmqqeDTDawxLlOLhfIc9Ki+4VuFpY1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805905; c=relaxed/simple;
	bh=lINE7NkSUvaMRUN5kdpq2iupYa9Jn//uSqQB9Wso/oA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pafNRlrGyXCiRZCunYxr9uWV/jY0yOwxjettTJzn33AuAbFpvZVz8o5sifI+SfdMVaZprYQsPhtayiVgc/zsHHmXzr+oHd/WYhTW1t+Y1yNE/MBxvw8m9bBucc+MX/2UJVfUM4GI9yumZNO9HP/2JL3k7uf7y65NCsrjjt1Z1ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FC/e12P1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P8Wbpq027912
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:11:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l822Z63KISA17qDDKSQgq4rvN0cBPgBN2THLZWvJPpw=; b=FC/e12P13NLUWpHV
	yn9nF77c84gm6r25egvyDqWqGVf7XzyO5R6ZzZnyqQdj6jifb6f7T2OZKCF+EQB/
	gRHQzPV9c0tNarU4/ldKcb8UNb1xz08z+d1gfOcr8NEqUZNLays2hE7QsZ8DKx8X
	3g4rsWZawnCYP74amBZmYjW+gKxUjXAqiEdL9+GkGLLlmY1JcaH/hM8rElZvRk56
	pRjlDDNEBHVMFCU6fX9V6n72ADgp45+EFIwEuAHezOGWCU0TlNtvnQN1yIYX5Iqc
	bs7nExANPp8Oj6hojAJCAn87yPIWO645FZt6dBG9CRHXCafVgOTEh8z+WSjoLrVO
	h0AmfQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmp0j1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:11:43 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-721b84d7bb4so1395536d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758805902; x=1759410702;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l822Z63KISA17qDDKSQgq4rvN0cBPgBN2THLZWvJPpw=;
        b=rgGtcDrRAf6CAtsogaNsvefrIXF6oNS76XhOcVuNTeVBUt0SteQkQsFXXRl/sSp+5+
         zhQ31cMtJ2djS5cm0DIwD6DTJcHzwaQCjVoRPN3Axs7TbJqOP6ITjFAOKsHUNWXvE4pS
         jmdXMfOeDjMpRqS887MIQ+pWkp3RlLt2+zCJasUxD3fW905/eFXZd1ii12NwcCDNfS3j
         BccMvhYhwBnnT//6sFFJCIw0+7tN+UPcRK7AMt0VzhB5+I1wOKSyhLyr53f8+TtB69vu
         2ESJzQRqeuYnrEf1tjIP79scnB7QiN7Sul0RvW8W9ehN/l+Y1zqzikVHzZYHiF6xT+0M
         pNwA==
X-Forwarded-Encrypted: i=1; AJvYcCXtFTwVLOwcxViofy5ctguip6kOTlmUOlD3WVUbiRhcSQ8qbWu37dBY4+BMmKofUwpLoDzj1FTqGhu8jvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx+i8fvUhvtXQ5VHJlkSVems5ksumu7IxVIOfUIrRb/O7NWOcp
	vARB5pyskaFOwRaNVw15Q/iwgaPs+XCzW6aFVYZYTD1pdDsR8q1wEmPVcfVJEF7ZnH0UlVXfrFv
	wc2VzufTh9yn4khltxpTKhq1CPsKj7gkjNNLCpqznlI3HT9BsnUX+BZQQ3bpEH6P2sA8=
X-Gm-Gg: ASbGncuTGYgtICwSoa2qqhly86alJcvx8ISrgsfAqSOfh+adsiIRB5uUEDmZ6G+6o2D
	GIFEMlKnr539JOCxZFJLADZbQeCsIdiipkLZ065W1aDIbYqorpgOFk6i5d0HOAykAMmf8AKv166
	/XZc0WuHgHYvtt/xA2Gox5blvD9CuJiNYw3ocxCgSIcAfSeaFHwcqsFCW/c6C4A1qYblnh7ReIZ
	X4a1oLWDzJ6/vVATFa53hOEXyBVRF2UQDL3GGfEbwdquqeNpRNfcJi/lZbk9SWTwTITmESymna1
	9w/Z5ypUWgwKSQBou5PYD9XR8EEfuiFI0vLj1Rm7gj8fQP/+RxWJjQvUNMjHejZZAw9l1IAuAvn
	b3dPyXuh4K0RSIczwfhGSMA==
X-Received: by 2002:a05:622a:1488:b0:4c8:39e0:95a9 with SMTP id d75a77b69052e-4da489a1c99mr25435481cf.6.1758805902320;
        Thu, 25 Sep 2025 06:11:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVLJC5KlSybFStb+ck2Af033JMceOo9M492BbMXbBa0IliIzYWZPhJGlQ0ZMIsN2rkol5KUg==
X-Received: by 2002:a05:622a:1488:b0:4c8:39e0:95a9 with SMTP id d75a77b69052e-4da489a1c99mr25435301cf.6.1758805901862;
        Thu, 25 Sep 2025 06:11:41 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353e5cf32asm167836166b.1.2025.09.25.06.11.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 06:11:40 -0700 (PDT)
Message-ID: <60d2cfed-5018-4afb-9db2-6bf423defc7d@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 15:11:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: max77705: add interrupt-controller
 node
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20250912-starqltechn-correct_max77705_nodes-v3-0-4ce9f694ecd9@gmail.com>
 <20250912-starqltechn-correct_max77705_nodes-v3-1-4ce9f694ecd9@gmail.com>
 <a3ce0aa6-41d3-4ce8-adff-14c767d7f871@oss.qualcomm.com>
 <CABTCjFAO=iLauq37M7LOXOmrgAnPxh210bcoujUsL4zEC3634A@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CABTCjFAO=iLauq37M7LOXOmrgAnPxh210bcoujUsL4zEC3634A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68d53f8f cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=D19gQVrFAAAA:8 a=EUspDBNiAAAA:8
 a=qdIrdHMtB0OfU3cIBJoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=W4TVW4IDbPiebHqcZpNg:22
X-Proofpoint-ORIG-GUID: pXwartNUSXYR4WwOZMOuvDX7zTY-8ZuX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfX0w2FHF8oUtu4
 DgvTsps1n0Ku88JjYKVJF9khoqhwqxlFzwBlfHCCLCIcZ1uvkSSbG6Tn/UyU9VLGQwL6yPIWCs2
 r/kKdEYIbRN1ecsC52Q57FqSJe7xwwdR3ffIrSflD9OBU8Vv4EOz2GVKmDWI5jjy9LUxx8JAJ5D
 srcju2sS1CKe5jfDd9r4yKD2vTpSXwakicnvkOLU4xmSNBRQurmmrd27z1E7FPhV71QRqMzJ7OR
 /7lxAGT/lFASwBdjmAixN0ylMHNxXQNyhFeIPOjqHknZS9060Ss2G4MrhVzbAfcrAThq6tEsLci
 yRJmZ1SSpFv32Z5BpyMs6a03kcuSRBAffG6aS065Sl6Xf5R4BpAP8JODFj9360RmdqBqI+7x4Gb
 oUlrsy8U
X-Proofpoint-GUID: pXwartNUSXYR4WwOZMOuvDX7zTY-8ZuX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000

On 9/15/25 5:46 PM, Dzmitry Sankouski wrote:
> пн, 15 сент. 2025 г. в 10:49, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>:
>>
>>> +      The driver implements an interrupt controller for the sub devices.
>>> +      The interrupt number mapping is as follows
>>> +      0 - charger
>>> +      1 - topsys
>>> +      2 - fuelgauge
>>> +      3 - usb type-c management block.
>>
>> The MFD driver registers one more interrupt, and these don't seem
>> to be what you say here:
>>
>> static const struct regmap_irq max77705_topsys_irqs[] = {
>>         { .mask = MAX77705_SYSTEM_IRQ_BSTEN_INT, },
>>         { .mask = MAX77705_SYSTEM_IRQ_SYSUVLO_INT, },
>>         { .mask = MAX77705_SYSTEM_IRQ_SYSOVLO_INT, },
>>         { .mask = MAX77705_SYSTEM_IRQ_TSHDN_INT, },
>>         { .mask = MAX77705_SYSTEM_IRQ_TM_INT, },
>> };
> 
> MAX77705_SYSTEM_IRQ_TM_INT(and others you mentioned) is a part of 'topsys' irqs,
> which is kinda MFD own irqs. They are unused at the moment.
> 
> See also [max77705 rework interrupt patches](https://lkml.org/lkml/2025/8/31/27)

This would be useful to mention as a dependency..

Perhaps >this< patch should be part of that series you referenced, too
(or they could come together with this DT change even)

Konrad


