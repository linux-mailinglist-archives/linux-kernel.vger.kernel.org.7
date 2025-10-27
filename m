Return-Path: <linux-kernel+bounces-870831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA436C0BCBD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 05:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D10DD189DD68
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 05:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E154127FD62;
	Mon, 27 Oct 2025 04:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JuzDYkXv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60E023D7C3
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 04:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761541187; cv=none; b=GPMpj1ikJKJhra/guwmj/J6VG+5E75Vx6IAzBTyYUQMbS/vHzhqRFW2k8/eyhFd1+0U7QZ1MvSTK6ASfWPuxg+QbzVfb1ACh9vKNkajLwAuM+KsSLuQkfEzjFONUXBGD11bt3HYjni9jeWrteScscAQcXTcrhAmUWd98hveJGyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761541187; c=relaxed/simple;
	bh=NXOAHiSNmxOiOS7HVDbazr8bykt6LWHHKDDuEoEkaxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dwSWR1l+FTgZmI+jpFpMJNqjWM1+lNX1VTEkXeuC4q9++W6f9SxDgD8pA/8QQ2W5cxwH+EqtX5XykpHoO9L1DCVh4NENCStgB5/asITVSk/wqRwCv9ckmNf3bsfS742vTUxEpfV0MmvKJUUQLDyMuz+JI7OvNv+pBSxYh908ku0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JuzDYkXv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59QLoSe8860371
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 04:59:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mD3eW8Q+X7VqXorSBBv6tEIzWjDaO0115Pe6L0VYuqQ=; b=JuzDYkXv6gvnOp2i
	bK+BXGbJDxdjchicRRYIHbQ1csoaD+b4m21NwrkVWU7HoTQrrkF5EYjM3AXnfg6p
	HHyUTlbCviz1Fizj2hsUNS5576oD8yGOcZZC3hsFysMaEJhCNexNSgbGMl31QPn9
	QIjiUmTrX/lFkQn9RVRh4PscGam0ACJcccjhKSwcWGsKfu98ws14jKzhDMYhBIT4
	YVvpIbyhghJrGb0hkuOrjde5y08ZlGmca+RANhjIXB2uatOLB173dmrpLNuMCqdd
	cQsn6g0Rh9Y64CqwM6k74zssKDhJ4pvkZMDFvlJbIpKSb3jwAProYA0Ruxw12M42
	nKArdg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0ps137g1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 04:59:44 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-272b7bdf41fso47569715ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 21:59:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761541184; x=1762145984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mD3eW8Q+X7VqXorSBBv6tEIzWjDaO0115Pe6L0VYuqQ=;
        b=kFDE3xOGSsMK3OJpjcRIkF+dQXjQCCmK1cY/LRZTwlJckvd8YBGx3Nnt0faHLygciT
         LPPKqUSdfjg3K6p8AMhEZwvzvDiluvZuA0eA7b3LBOAeaXXUWdVY8hLnoXCudL3sR7bX
         ZN8bo9WM+v6zEEnK2Y6kK7SDtJ8GchUCbAC6ca05xC5KL7Yaqyz3K0W/11cqtpE+t52i
         EDqLc5qXDXTrZu7FKzZMcb19Jribl5WAmEOZItmaO4rJ73zMctvVAxg+Z868m7C/UKTX
         WUVeyMj7jlM9OPqR/XobsTPqJLA52qmannGhTcllG1wxlm8G3XAwPtx+abzQAIRir9KE
         o6jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhcqmTX+aFCmx4etCEQIPsm4fpz+7xhN/bOIOEq+o5E3kdq31OtH+dxlZj/WNlKBu3JRCq5B6hZ/HgwbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YylaOWlGJdvD9UgxBvwHIcudDRdPAhkw5Z65qpYK2lWgAkiRHhk
	PYMzdtj9E1T6xNy1U4VxbrFn16ZLTS6zD01Oh/7UcHFlvO2bMorKIY+9X5dLjj67fE7nxDk3ddu
	vnK4F64hCnOQ+b5DS39+HBoQ0/uT7QjJwVzI7AQ6J04Y7Ppz9ii4EXNIMtA/gNEj4W5A=
X-Gm-Gg: ASbGnctouHl0otJGj7sakQ4TZwSgk43i912P6W110UC/RNVHuHp0Dm+aIKNpm95+CEu
	WVzqAgzTgnV5PcoiOlBo/jGrsXwQnB9N5MlDn2uJD3ktvaW3Ii3WyURtxhmqhr1ULQTcsuM7g8a
	dgqvIz9KT7fTC2zO/cf9XU3e9STnGvDcfw/YxHzydcOm02VwCdoXI580WT/oPFmMLRCRbIDZqmc
	mTSVUW2/yuVf/rXKvKUSiAPIaxh+mamSPGQB3Ycm+sejUCmbttgTMZHBDrpJH8i31F6uAEk5WUt
	XBiKn9MWvR/1DdWn2r8fBGmgrn6f99Y7YwRVgg3aVUtLqMGbOfIVxd+A8V8riC1UGGw3bsDmf3O
	AN9kWsIdxto8YDrUu4tytKhsspXO/Up17/+OyKVNVFIM=
X-Received: by 2002:a17:903:2f88:b0:235:e8da:8d1 with SMTP id d9443c01a7336-2946de3ddbcmr113941245ad.8.1761541184071;
        Sun, 26 Oct 2025 21:59:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2IPsDoUoRRbxLruyTRMj23/2P6SPWPhK/AySX1U9OdkkR/gxEhSC6+HDgwzasnTw0x5TNow==
X-Received: by 2002:a17:903:2f88:b0:235:e8da:8d1 with SMTP id d9443c01a7336-2946de3ddbcmr113941055ad.8.1761541183628;
        Sun, 26 Oct 2025 21:59:43 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d09a59sm66527395ad.35.2025.10.26.21.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 21:59:42 -0700 (PDT)
Message-ID: <cfb94b1a-7ad0-4067-a08b-2af358edb768@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 10:29:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: sram: qcom,imem: drop the IPQ5424 compatible
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251015-ipq5424-imem-v1-1-ee1c1476c1b6@oss.qualcomm.com>
 <20251021-quaint-hopping-tuna-0dade2@kuoka>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <20251021-quaint-hopping-tuna-0dade2@kuoka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ju78bc4C c=1 sm=1 tr=0 ts=68fefc40 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=og02JtxI0NfJW1qUVyoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: vnvixPrYfUnVqpYD3w9c35AKXM7WbmVC
X-Proofpoint-GUID: vnvixPrYfUnVqpYD3w9c35AKXM7WbmVC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA0MyBTYWx0ZWRfX50CzxlhJEGAw
 56fo4ffj+Qp7Gxv1MAEYKj+gVd/CvBhrjZrcNTUEvLAgiIsMQgsxHTknp/WLfQxvx1C8y1oRk0A
 P/ISEosZ3ibeLU9midD6dM7Hr/8KKjtcXdg322N72vY8gWrtoCQQd/TYyeeINvAKqtAICgVjfMZ
 imtItXC7TJxPPWmsA8BoPZa0HBkZHTN6eVJ0ENwzoxjAljuS3J2obFwFtWi1uXwx6lUr/yJPEj5
 3T/mxKG+KtwVl2CWxVyHo3bjjZB8Bpjp1I8bBOiWN5jMpFmTiwDl1adfobsm+LII6kJPPtHu6LK
 2i8tLZblMSJQJ3Z+cp+8WVHdCsCzjYUtETCuL3FrlqwWyD6gZo8ZQVh3jxAYhZ32eUaCjhspi9U
 MddQntbnaeu9iBBp0lUMOJnw+V0Teg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270043


On 10/21/2025 12:32 PM, Krzysztof Kozlowski wrote:
> On Wed, Oct 15, 2025 at 11:46:58AM +0530, Kathiravan Thirumoorthy wrote:
>> Based on the recent discussion in the linux-arm-msm list[1], it is not
>> appropriate to define the IMEM (On-Chip SRAM) as syscon or MFD. Since
>> there are no consumers of this compatible, drop it and move to
>> mmio-sram.
>>
>> While at it, add a comment to not to extend the list and move towards
>> mmio-sram.
>>
>> [1] https://lore.kernel.org/linux-arm-msm/e4c5ecc3-fd97-4b13-a057-bb1a3b7f9207@kernel.org/
>>
>> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
>> ---
>>   Documentation/devicetree/bindings/sram/qcom,imem.yaml | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>> index 6a627c57ae2fecdbb81cae710f6fb5e48156b1f5..3147f3634a531514a670e714f3878e5375db7285 100644
>> --- a/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>> +++ b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>> @@ -14,11 +14,10 @@ description:
>>     transactions.
>>   
>>   properties:
>> -  compatible:
>> +  compatible: # Don't grow this list. Please use mmio-sram if possible
>>       items:
>>         - enum:
>>             - qcom,apq8064-imem
>> -          - qcom,ipq5424-imem
> And where is qcom,ipq5424-imem added? This is supposed to be one patch.


Kindly excuse for the delay in the response as I was out of work.

This is supposed to be added in the sram.yaml binding, but I haven't 
completed that yet. Between Konrad has done some rework [1] on removing 
the imem.yaml and combined with sram.yaml (in his dev tree). So I hope 
it will be taken care along with that.

Konrad, Can you help to share the plan on when the patches will be 
posted for review? It will be helpful for reviving my other series[2] 
and obviously yours too :)

[1] https://github.com/quic-kdybcio/linux/commits/topic/imem_sram/

[2] 
https://lore.kernel.org/linux-arm-msm/20250610-wdt_reset_reason-v5-0-2d2835160ab5@oss.qualcomm.com/#t


Thanks,

Kathiravan T.


>
> Best regards,
> Krzysztof
>

