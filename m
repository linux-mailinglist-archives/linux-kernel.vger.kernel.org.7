Return-Path: <linux-kernel+bounces-842804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F29BBDA69
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 12:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 904BF34A4C9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 10:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692682264AA;
	Mon,  6 Oct 2025 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ix2ep30w"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3492A14D29B
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745781; cv=none; b=UXdBNp8j/VAVLOxRD6I5QsQJL2FotdUlruM6PeyR8yBdu/RPV8aZQgv8OivQdzfJPrQOdk0Ck0i7s//vk1m2Kz2C9S+oL1mZNZhIaVKhHDIv4yVZLjxcRfCs8QBWbHTDepG3mgi/nBaxgc1XMgFcYiOD0khU4BMEABA3q9tO/2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745781; c=relaxed/simple;
	bh=Eh0d0qZba8BtpAV24kNLwWp4pX6k+8EBFDG1/TTxghE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IadMk7BKSp26NZm8Z6qnznJJy3qfJmuNHQu1KwR8Pz/eiLTpV0+nBfjDclYifO/IdheP0TUb9AWaYwze0PEDisKZIyPMmQDsVkEJfVsCUQt1/8NM6ejZzFQzBTEF9r/SmQoRdPDFcn8wuY5Q0tlGbQsX4casNB3XVqLk+vqm800=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ix2ep30w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 595NJbQ2018627
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 10:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9HMZPOeln5HgZr8mqiZ5+a+U8n0huJ7s/8ub16Ui27Q=; b=ix2ep30wcLX1e/2B
	GWNuTi8+6aA4bntOApoh/Iu8O4cZgIEWYYMQNNiYKKRDgep2Eh5gase833c96zR7
	wy6bvnzMV9AJ7BokPIXpQASHjQb2kLpIGvFLF8jjWHRBaJ38scnazrHas/SKMuFr
	PKc77AyJJcZLYwKGpHIpzADt7+wPuP2NVkpel3g5FRU3Kah2kcmvIm/BOpAr/qkB
	D7tChDwVwzw90cnHRSeFIO1gYb18JcSBIIIxTbGwxa1RKW0JSYKCQWSg2VotO3zN
	tEL6LnvqPKhJkaq1KgYcRQaq6yhGok9XO0DPzeUC8hO3NN8ytkgM7oB8QeJA2tz0
	X6lVSQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49ju5xbjdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 10:16:19 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4dd729008d7so11104841cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 03:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759745778; x=1760350578;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9HMZPOeln5HgZr8mqiZ5+a+U8n0huJ7s/8ub16Ui27Q=;
        b=LNAAGKBZT3ZWqzaiQurVE+eqHA64TBW0IRWVmuM5jTlFCXv8TJ2KdQvw6y1YPPTlaL
         +UaW9wdMbUV69UAGXKcuEEMsLJpPkTP6vdp0Jyrox0CzPhTTDB5zZacAgZBNHGxNJ2fX
         Db16LhXEosOFeJkc7BEaeyG2JtxBEjbzYiSe+Gimutfb/uEC609hWKBqvp91JFppsL82
         veHX2+h7lvrCrc57iWJSAz+QRut0SnYcNh1sanWfhpEGiKngNU6I/FaXL0LMZ1DFuR+5
         jlNGZ//vfkl5Dg1xqrWZWgiegxCmnrMTmCUTHFHk91/5VTyAhK3CZ+cNKECjycEM3PIK
         t+Hg==
X-Forwarded-Encrypted: i=1; AJvYcCVWa7Ph1HZywiCZNYmSdoDWl8ckpMLzSjZw4MwyIOZ/8sJtKd0sGAPLsV1Ej09FsUG/gDGlaVCrq40sB3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsQHbjPuHRkEA/Sv3+JeKY76BNB7rVOY+bIs5JdThIu3r4w8iM
	/ATWeBkJnX+Q84/EPDMFCFIxAjwbmwr3Zo/m3BbXjqDwhm8KrIRkewk91kojgodgETkg/v31FbH
	XAP2OEmV9SyM7NoHE5orkDHM4Taionpo+/0cy5NkQtXGC/rOswHrqI1q0DeXwQWxsSAI=
X-Gm-Gg: ASbGnctiVUYMeT0+IGOaS9zwWPldOmL7k4iBZgfvPxNrcZ1nq8KN1x0gFPxLJWQEIKe
	GHVtePUc6J1qvfmdXbiDsQLUVZTT/89n+tp9WaUJwLNz+rVbMo+OUcxZclGj317Jn9La0CbM6Xp
	uml205ZHnClFimLH5kcUucm0DfEZlFq/FRrnG/kBfOC0DQuVFPlXQEvFjqYdkaZ27QhxHsTgHaH
	YEvtHJ35Wh9k9c1CVUR5FyAHH9T7kK2nmGnrT/I1rljHhsVbaV7A10h+r79Bea4P2WEexanPOgf
	BHY1m0unu2e+9MrCTEBirNwpAEXP07h3AoPPeUaT93x7+7jmlQqmcRf8fS3kZa1pbkIQCHhox4Q
	nnF8xi0Dc7OZBBfOrxJLs7H1XzcM=
X-Received: by 2002:ac8:5890:0:b0:4d7:e0ed:421f with SMTP id d75a77b69052e-4e576a2e554mr104006801cf.3.1759745778344;
        Mon, 06 Oct 2025 03:16:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPvGGEXMKSW3PR78XzS/AjAzDzBYLQ9l2XV3dnRRFJTzKidEAVeQO5t8uTCr9+KbX0iB5dOw==
X-Received: by 2002:ac8:5890:0:b0:4d7:e0ed:421f with SMTP id d75a77b69052e-4e576a2e554mr104006501cf.3.1759745777846;
        Mon, 06 Oct 2025 03:16:17 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865e78242sm1110936866b.35.2025.10.06.03.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 03:16:17 -0700 (PDT)
Message-ID: <f5526ac7-6e5a-43c3-a8eb-9f75cd3c6c36@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 12:16:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Documentation: dt-bindings: arm: qcom: Add Pixel 3
 and 3 XL
To: David Heidelberg <david@ixit.cz>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251005-pixel-3-v1-0-ab8b85f6133f@ixit.cz>
 <20251005-pixel-3-v1-1-ab8b85f6133f@ixit.cz>
 <bq3jeaxksk33ntdk32ojsdyh2d3qkglvgj6segtc3acizlkrhm@fvdsccdbuook>
 <6807638b-b212-44b9-b7cb-e53e1f11c0d9@oss.qualcomm.com>
 <012fdcbf-3089-4f49-9c65-1d0cc24ea2d5@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <012fdcbf-3089-4f49-9c65-1d0cc24ea2d5@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FooIPmrq c=1 sm=1 tr=0 ts=68e396f3 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=U46Y8RmMCvoGOKAdW7wA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: Trdu5DBrIPFbGXwWAWfLFCe021TKS5jS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMiBTYWx0ZWRfX1VxQbbAJM1QC
 2Pv6dfJcvBlwPD/FaIokKYVvpDC/o1MB4/Pa7vHirPQndrLodluyd2CUgxmWn4fVJ7kmyi9krU7
 mCtrObwKiApLrTMXemHZnU1Z5S5ngjm1/Q6scpzzTnubCSU8JONOrlMI9xvBr1s226Xl0aX0WM9
 qzcMfAycj2Ux0Fs2lGrKjNc92SJxBob+NFOj6hrI8BhxsjNYOCxz2vIXC9o9vcal4jF17GzE1v1
 fIGQRvJepdWqk7k0kt6bsLT+nLELRJxwA5PObIyzQEbGT6kQ+Dh7eL+2/LieE+GHw7/yz5W0JOC
 lT71c66a+c81OFXCtofXLGe+ab9kEReALlFJa0dJAhjTw/FUPIa0rAtKe4MBRDBht48XB1HSEiJ
 YTWChNyIwHCZQtBLmnEKEq1X/E8gBA==
X-Proofpoint-GUID: Trdu5DBrIPFbGXwWAWfLFCe021TKS5jS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_03,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040022

On 10/6/25 12:09 PM, David Heidelberg wrote:
> On 06/10/2025 10:09, Konrad Dybcio wrote:
>> On 10/6/25 12:21 AM, Dmitry Baryshkov wrote:
>>> On Sun, Oct 05, 2025 at 03:16:28PM +0200, David Heidelberg via B4 Relay wrote:
>>>> From: David Heidelberg <david@ixit.cz>
>>>>
>>>> Document the bindings for the Pixel 3 and 3 XL.
>>>>
>>>> Signed-off-by: David Heidelberg <david@ixit.cz>
>>>> ---
>>>>   Documentation/devicetree/bindings/arm/qcom.yaml | 5 ++---
>>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>>>> index ae43b35565808..2190c5b409748 100644
>>>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>>>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>>>> @@ -976,9 +976,8 @@ properties:
>>>>           - items:
>>>>             - enum:
>>>> -              - google,cheza
>>>> -              - google,cheza-rev1
>>>> -              - google,cheza-rev2
>>>
>>> Why are you removing those?
>>
>> I removed these a long time ago, the base for this series is 6.17-release
>> instead of -next :/
> 
> I did purposefully base on 6.17 (and sadly the downgrade from next brought this mess), because the support for Pixel 3 is a bit fragile and as I have only Pixel 3 XL at home (not the Pixel 3, which I always asking someone else to borrow or test for me), I decided to kept 6.17 base so I know it's the state where blueline boots (in case sdm845 or blueline gets broken in the -next).
> 
> If you want me to, I can base the next version on -next.

-next currently contains changes from the past ~3 months, which
you're missing out on

You unfortunately have to rebase, or your patches will simply
generate merge conflicts

Konrad

