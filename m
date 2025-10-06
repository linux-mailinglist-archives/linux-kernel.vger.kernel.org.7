Return-Path: <linux-kernel+bounces-843100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C34E8BBE679
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 16:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EB9B18952C2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 14:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132CC2D662D;
	Mon,  6 Oct 2025 14:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gZH/dAeA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA312D6621
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 14:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759762321; cv=none; b=XjikLxuNJsQuFJiNmCkWRfEYNT8qp6Qp1zBIRfAOBUgkPEjoxWnBrzmwbDWOQQ7ihNVuPcfGPEvSQrdx/DVxuKcbRmhpM69eVlqzMyY71eOJ3o8y7AziHidUqFt+EI/GOZ5S3VKysmmg4dknUvEk+8wAEcbAQjUBdJcgGZN0Jhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759762321; c=relaxed/simple;
	bh=10PEtw6twoEMwTGl0F8JEVM35Pm4DuZVOVadFVAmEhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qh8AkzEbR1pwITiPsmAhhcAImsVHJGZsC6jXW26K0qIDH2L0nXUAKBv0IppV2wQG3ymx9atXL3qYGnA8vzikvkknZ4cGSbd3Y8rUzV1d9/e+x2c/qmJMzMNc6bN8AquQHwyUosNRJXJz/8QWjcoyoBaOvYw/JQyyYydN0/opjuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gZH/dAeA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5961V5RZ012073
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 14:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uykABRp9hc8kRbSBpNRtLJa1EeJ+2rYcJ3127irL/TA=; b=gZH/dAeAjED6Djdw
	l2qx377PkuBGVZiofC9iJ1qxudZMCcOp7IH2VV7sJjAQ8KIcXHChf4cukIHDXK33
	MhJyXCjS4F9Xy9aEMukTffYsbc6KadkyJ3TKrDohhJfFyJ6D89DSVIarjO5D/Vfw
	GnVXkemJ+22pRDFPjKnZEL8fALTgx31mjK21z/5JJA6FItTRPp5f9EYxKQ5d3gHE
	/GESbJ+6AYpak1NZKFiuWL/UlhOXM5nMAU7RfkTtOtzFPgBmQCLQpgrLhNeawmFR
	md1hgwKbG1yGqIjeCEUw7QhcgFLuExUn3zszvpRHYjru8olWjh10HKdK88T1hEDy
	9w1lXw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jrxn4cpn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 14:51:58 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4d880ce17bbso5097261cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 07:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759762318; x=1760367118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uykABRp9hc8kRbSBpNRtLJa1EeJ+2rYcJ3127irL/TA=;
        b=puMvGahSFhjajBfYph/BEIaXKwm8kBh9GhYDrn+3pPon4Okqh+2Ow41jnoZLF+NniL
         wUKNmEyuERA3/xbj/Xpe11CSChcWHV03uSK+i9+S+1xp23fmXiaMl1eCZFYWpfXeI4Sd
         yjtdF+7mLgJIXaP9TCsX9LaHW0TrPDOIidVWcs2hiomkUKUA0Ej7vzoh/cBWKYT2DkFR
         WXTjVbZYTeo2lWe35RRCDADhivX2rweGPiTqI/OLyXR39MgHGEMCqediqibfRTdly0ZJ
         ut4HKmxSXYMJryx3n2p80NX+aI28JtYjPaC7VpVGt5EBu1E8Tu2NRphfQoPcyJp2P5Cy
         CmQA==
X-Forwarded-Encrypted: i=1; AJvYcCX1TKH6tnmyVFZzM+VZE6piWozOhjfC4vsmfek6i5hQbXQ04JjZNPqudvWI8G4u0mZYsxU68qa1mOpjfO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoyTXTmijN9J88fXuHKXrLeCwqZxjzZT9505p8wiv32brhy7PN
	5HKVrYh0bte94oBNfLUZDHrGEfqvqOlUg4L0mmcixODbwTJEaNORk1+MBPj7pvRALGZLk4PA8TI
	q1PUjpEGIh64PLywzaDaAb2cp77+VgDPYVwXWAf0fPZ3e37FRM0dhAQ9oRNlf4lHZZ3k=
X-Gm-Gg: ASbGncvu0wAtqOiR9LIw+SW9O2etNAIT93WasJZBBN3cLhjUxYZ1Zb8WPTyp+wZfqvR
	xFfFZ+9biICxdkwRVbZ8unAYS1PwDG4mQ7Y26+v+zjeq3/d/74xQGjrCRDBIahuxKJjpmv6XSt0
	VrdUMzcLLQL6L7Fx7AdlfQoFXadUmzWsQHS/1lEV8LtRj57zeXVxYTL/35Ve44L2B4XNgzZoQfO
	6zOvjsYoiQOcwxehueoWHrE1Xiq/0EoNa4Zb1TpkM+Na78uvMbv3DdNoAUt4oCQ3n+ECe++tMIk
	evSZcnY4qScDyb0BV7aD+YtR8gaB4w+yV7P+gE6WonGtVqsB+byhIzhZOmq4c0BMnte7BdHe/oq
	cgKIvkahuPsEDRclGd18RBDgs52A=
X-Received: by 2002:ac8:7f08:0:b0:4db:1bd:c21c with SMTP id d75a77b69052e-4e576ac746amr103555551cf.12.1759762317675;
        Mon, 06 Oct 2025 07:51:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNQFQNaOw+YDqi93+F/z85X3qTNZ4A1Fy6bJXByTp8nf40QE5W21EnEc61g5O03NMlZ9vJFw==
X-Received: by 2002:ac8:7f08:0:b0:4db:1bd:c21c with SMTP id d75a77b69052e-4e576ac746amr103555261cf.12.1759762317030;
        Mon, 06 Oct 2025 07:51:57 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4c855585d1sm441287466b.67.2025.10.06.07.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 07:51:56 -0700 (PDT)
Message-ID: <9d503228-2a54-40f3-ad6d-500144e14b2a@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 16:51:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-oneplus: Correct gpio used for
 slider
To: David Heidelberg <david@ixit.cz>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>
References: <20250927-slider-correct-v1-1-fb8cc7fdcedf@ixit.cz>
 <babe2e5e-87a4-4871-a836-ddbd9cc8d868@oss.qualcomm.com>
 <8a21a653-4dcf-4418-9bb7-76e940ddcab2@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <8a21a653-4dcf-4418-9bb7-76e940ddcab2@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwMSBTYWx0ZWRfX7MSNE4YQt7Xv
 BuKMBc6wwe/wgpdHXmljz5aK2ypUGhVxwb1VaqV9natGSNpZhd0Lx+3r+BOCwGVk5fda6DvNsrB
 F+OxZD3IF/y/t7iC6JN+5H9ODbxLq0Hczk6/nkqDRPHRqLH+4sB/2QiFqkrAuq5SIs6DTPlRgcR
 GPZcwO1OcNULOVz29Nbu0LHQgT8BfaRs/fY/mg02q1Y8CNDTE+GIGfgCTIggCK6xEPYNIVVImSN
 ouiGH5C9gIGSoK5O01dsmLMCStSm9AcQTXaAiqkqYYHTmsTxglVkKlkGY4lJTTmQVSsVdnHgjy4
 QmXQpANfhbaCaFL+rlofkcpiwIrQiorfQ23nwVA3WGbStbIKo+a9DlDTTLXb9+L/hRZ5RMCMgDu
 j8ZYg38D19U/ivH+N0wkrcfE9SZ+5g==
X-Proofpoint-GUID: l1REcWiSiJ1FYJaR5CsrCSQ3zFSl5ud7
X-Proofpoint-ORIG-GUID: l1REcWiSiJ1FYJaR5CsrCSQ3zFSl5ud7
X-Authority-Analysis: v=2.4 cv=EqnfbCcA c=1 sm=1 tr=0 ts=68e3d78e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=L94DSdHg0uYc9iSAjtcA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_04,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040001

On 10/6/25 4:32 PM, David Heidelberg wrote:
> On 06/10/2025 16:15, Konrad Dybcio wrote:
>> On 9/27/25 1:20 PM, David Heidelberg via B4 Relay wrote:
>>> From: Gergo Koteles <soyer@irl.hu>
>>>
>>> The previous GPIO numbers were wrong. Update them to the correct
>>> ones and fix the label.
>>>
>>> Fixes: 288ef8a42612 ("arm64: dts: sdm845: add oneplus6/6t devices")
>>> Signed-off-by: Gergo Koteles <soyer@irl.hu>
>>> Signed-off-by: David Heidelberg <david@ixit.cz>
>>> ---
>>
>> This is currently unused, can you bundle (or squash?) this with the
>> "add slider" series instead?
> 
> The seriess didn't received any attention or reviews, so I hoped in least fixing the upstream device-tree before someone will have time to look at the whole.
> 
> Would you recommend sending the "Add support for sound profile switching and leverage for OnePlus 6 slider" again, just with this small split improvement now?

It's been a good 2 months, so it wouldn't hurt.. perhaps wait
one more week for -rc1 to come out, in case anyone you depend on
is *that* pedantic..

Konrad

