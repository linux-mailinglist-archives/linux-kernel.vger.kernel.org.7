Return-Path: <linux-kernel+bounces-851785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E896BD73F4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4222F3BC004
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9C830B509;
	Tue, 14 Oct 2025 04:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kMdmEn00"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DBE30B513
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760416151; cv=none; b=YNsBylPuG5XIk18c6i41w0hHc/A+gOZaK7o6HSLA+GjBGi5GrampUVDMGle1qMC1hlMwoRTy6QtRuz0pqkAaVTjYUDXGWaLEqUawNFUYJonj8kcSuYIc3rmpEpSVVErCEIxypT6TK4TnldQYCT3Nd/Q0zk8ht0QXrkQivgS0DEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760416151; c=relaxed/simple;
	bh=9sCf1XLCcsUswVl3Rkx1h9I82mM+ztc4hZsli0CE2lY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VvZkjtyOkgHVFx49ZmRC+1WxY/ButdohjSqVL6F826TD7lA1d3RD+AlfMCa3oKsVg8V5IchH+HHimC/+9r4028b2ik1izDkuXbiAJsWMlIwrAsMTesSakmFNLsDlBTRM44oBSBoAMbe++0TPxhM8gi6pDQCkkAPHl0DN+DcC8CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kMdmEn00; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DHDAql012186
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:29:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	76Uf+fwA3Xpg7xvSPdyXGE020wdT1FMcByxhgc0urqI=; b=kMdmEn00yS6M83CC
	4k6Kg8VTjQHYM0O3XuRJPOO1RMFCDqxguOz7bNKnmjiD7/mb79wWj4NRk9Mpfx7L
	VAtH1BPjRCgErvv5EkAAYoQbl3OZQz2N0byqnUS1qQOpzEXGqgEfjFFbND/ziTzP
	qDzpqrDf/6yBxFtHiNitsof8mqQXnca7FOw8UuuGyFiDvv3b0cZZj6Q5u9F8x8EZ
	vEb9yt2MmQukxdq2EENiz8D0wBB+cRSdwTMpT+KVdv5Qp/kTSlKKflh8Si+zvkq7
	4JduH/WlJ3tPVPdescQriRWUXs4e0Y/MYDUK3/i2cjkqYwjxYoK4SIKT6R3/OJV+
	PgyVGQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfm5f4j0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:29:08 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2907948c307so14037955ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 21:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760416147; x=1761020947;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=76Uf+fwA3Xpg7xvSPdyXGE020wdT1FMcByxhgc0urqI=;
        b=fvUX/5ROzCsaEnNh4fHlh9+ZO/WUCb2MSW4VL1xSPSOaTwMKr5J9PUUCewsdGF4tz8
         IGm1biVh16S0hVCM1W4v/76i//tgS53v3iaDDUiVJA1+/49cuWNlqBVplIczF1bgSIpk
         B9Iek3qvH45NMrkFoTbR69irK608lQUccR95/NLM5IdyJL14zl5KEikus9QSN/rlIRZ1
         bw2hPRrE5OlBwzyEVSYdfg9VG1N+Wg4w0817BsxwytiA+t3Bl52MwTSvFUjGx1wOukcm
         vbI0gYNUYWhrV3YC7szmUemZ+vecm2nuMaObRNZizor/z8SOl25jEPRqU+okfAKB8gfT
         nFnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpEx+qDo786v2EedY3PYZRgkRgCE8Fi9MtKnRV/cEylC00YVQGKcMsNOiJS77PUX894V3TfQD7bA2asG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUs5ICKQ0d7w0eQfqifHIv677EMIymgpr146JQKIcq2U4g0xKb
	YAKNTNH/ugA9dRqwQjeixJ5DY5fx8r0c1E0jVAlPpt3r9aft8AiRkTIuOC315tgyBvPZHOWlkaD
	VW2SPJG1bFRzws/tSEjJflFhe7yWNVUspJ9FUR0aMobPJ8pevJzGmSpYF4ZObiETx14I=
X-Gm-Gg: ASbGncsVLqtrgWZeYjDLYt7GqsBKB4Es3W3rLXeOZxIbDvG3FJjBwH72oITUcPryUqX
	yLqK+rwlUiZ8TeXN4zK3ce1alVw7Bmgq0nftVigYad5jeB6moo4fa+xIW5j1na+TvePwP3hyqm/
	RqBMT2suCuSZVNxzVuXNqSd7+2P/CIZOkuAWp24vpOExpq6wEblR2sjDM+Sb50/0lW72QeZYCqe
	VpuzCQZVT0A4U5cuoyEPz6D60OuxRV48FJvNvQ8kh6Y9Sx4tCQDxZ54c1xroWvPF5GdsRkP7cuL
	b1+qsHW6UcWnOsHvsVr1MDkVI5NhJCHXg3g/loeANFz46eU82E13cfJKFW6sR6vVSUauWrN1B2E
	jrRUQtQBzZQKpqtvUaA2JLC8KDk4yvEe066c=
X-Received: by 2002:a17:903:2f0e:b0:272:a900:c42b with SMTP id d9443c01a7336-290273ef03dmr293435235ad.31.1760416147284;
        Mon, 13 Oct 2025 21:29:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGo56hdv0/dwNtL5Wxo+sarDBi14f7clvza/iuR1VsNREYq6JiByn196MwLZ/ftVk8FAoGsTQ==
X-Received: by 2002:a17:903:2f0e:b0:272:a900:c42b with SMTP id d9443c01a7336-290273ef03dmr293434895ad.31.1760416146825;
        Mon, 13 Oct 2025 21:29:06 -0700 (PDT)
Received: from [10.133.33.138] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f56c04sm149462735ad.110.2025.10.13.21.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 21:29:06 -0700 (PDT)
Message-ID: <e9813a47-c40b-475a-8faf-de0811c9066e@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 12:28:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] dt-bindings: remoteproc: qcom,pas: Document pas for
 Kaanapali SoCCP
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
References: <20250924-knp-remoteproc-v1-0-611bf7be8329@oss.qualcomm.com>
 <20250924-knp-remoteproc-v1-4-611bf7be8329@oss.qualcomm.com>
 <a8796335-bec3-4c1f-afea-b5b7909d8ba3@kernel.org>
Content-Language: en-US
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <a8796335-bec3-4c1f-afea-b5b7909d8ba3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 0S-KJTIkxufLEe5_H1Z_JKr13LmQ-BIC
X-Proofpoint-ORIG-GUID: 0S-KJTIkxufLEe5_H1Z_JKr13LmQ-BIC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMCBTYWx0ZWRfX3I0udWtBT3mg
 NuXHTDmNVoDfU5mSaLYlLftpGLFJ/oQVtm2WtMZcYfs7TSwb+57CLoTzWMfG7pt5D7Cy+Tzw0SV
 ZDHKqIz51oXx3PgZRchGpeDSwhC20jv2MFY8drF+tU0akESOUvO7NwU9uhVZ1A8R5YBcXon3Vkd
 T2xEKirT01J+Gvr3cJLzNwtVTHkwkFsssC3uK+fSrencWmduiQjv/n0cH4oj9VQG36U/nsJXzxc
 l5JDDoUKrwUvxgfIi4BfToF6Hy8x3PvL2PEt6AFAJt6r6lzvrYA+ckS0r7Y14SRxXSdGp2tJwG8
 zru0zhEu1LbMcWM7sGCB54u8f3W9xgJ8Lgu2oaa1PhDKAcurpEX8XEVgS8r3ZrzCR+z4L3lMgNA
 a4+8V+Psi3oDmgXzQfkSg/yRzowl+w==
X-Authority-Analysis: v=2.4 cv=V71wEOni c=1 sm=1 tr=0 ts=68edd194 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yaF9TFSo-8KvDqLiQccA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_09,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110020



On 10/9/2025 6:27 PM, Krzysztof Kozlowski wrote:
> On 25/09/2025 08:37, Jingyi Wang wrote:
>> +
>> +  glink-edge:
>> +    $ref: /schemas/remoteproc/qcom,glink-edge.yaml#
>> +    unevaluatedProperties: false
>> +    description: |
> 
> Drop |
> 
> 

Will fix

>> +      Qualcomm G-Link subnode which represents communication edge, channels
>> +      and devices related to the Remoteproc.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - memory-region
>> +  - clocks
>> +  - clock-names
>> +  - interrupts
>> +  - interrupt-names
>> +  - qcom,smem-states
>> +  - qcom,smem-state-names
>> +
>> +unevaluatedProperties: false
> 
> That's wrong in this context. But if you add missing (and corrected
> pas-common) then it would make sense.
> 

Sorry I didn't get this point, could you make it more clear?

The property for Kaanapali SoCCP doesn't follow qcom,pas-common.yaml
(the interrupts are different) so it was not included here, like
"qcom,qcs404-cdsp-pil.yaml"

So I think just adding the missing "power-domains","power-domain-names"
under "required" will be okay?

Thanks,
Jingyi

> 
> Best regards,
> Krzysztof



