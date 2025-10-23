Return-Path: <linux-kernel+bounces-866174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9025ABFF115
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7B6263588F5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 04:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723F32BF016;
	Thu, 23 Oct 2025 04:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MKRjy+F+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D4425EF87
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761192437; cv=none; b=qxncDJlReDWuEnksbUfAVwvS7f018XF5BHH3dT6VVMmj6L+4xrGbW5p7H6ZDUoeYIKF7P53RTjnUNkbVMA3/Hke5r1P3WW8dFGWQKw4XjjgDLKwy5HLEwfIuN7LfJ3/zttO048Dq6+n9v2lgaEvss6tu1c2V/Ui/dh+TfnZeglo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761192437; c=relaxed/simple;
	bh=1Nck7j3+aab8fsmv17FGOG9aPhFb9ZRUy/2LYccp1mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qEAk1VMNuJ6cSQd1kRMENM7yZ627Hd+FAp/d6TH72TqHYlO/2LD+6JNDbK/WHh4qTml/nJiBcFFngje3hjYEqjtxv2MxadWAR1HElGyOtyUz3IB1rJJmgaCsaoo5mk6S4iM2EWJ4bVtuLPeTQsZAe4fN+rvbs39Af6BFw4wTn38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MKRjy+F+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MIeqWf030315
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PcgkgDXlyRkmY4EE/OGwg8TcZ9P8qqS+vWBVxf6Za2Q=; b=MKRjy+F+KxXu/pLQ
	OXPZFVo1dHVV3/0IZsrBcSAKl0wbE82JfWMlc6GyVg/hdYXEsCN+lEVmJ40jmB6y
	9Mt7ou2FDJ/7kyP04lK8zXLc4INbWSGCC1NikCsJ4WXxtCA7elDqyvWSqf1aXa46
	VSGiFKRu5YiS8tztpjB2PaGnI+MJqVz3oVoBVStTrXAmeJvxOwnrboPeIsYEi7IR
	ujT9yz6QXc8Bd+uadlU+0Nis+GGKFJQvbYSPsUcX0tpqRjyj+n+4oVhJA+Ihiwpg
	sP41FKePnzo6ui5Sp4UPlkx/KZft7IRELfTD5yBdQYVGXXJNdz4OwBbR+bj26lf8
	C3u90A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2ge6wd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:07:13 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-33428befc08so989678a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 21:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761192432; x=1761797232;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PcgkgDXlyRkmY4EE/OGwg8TcZ9P8qqS+vWBVxf6Za2Q=;
        b=sxge0Z8TMGdFbz4nXy7AdiE0HnOc9zRO5ZY9dVDTGLO9ffu4cky3Swox6CjKeA9QGQ
         zt2oFWe+vLhfMa/ksUBaTzJzLe9aJgs3zEm1Y86pHArSCaF4RjkTyfuyAJ9UfekVdlG9
         aGuKQkQTYC5zP8ra7YCfhcBM7ni1TuMs+HTLNA7xWwLbec4KblDaJNfndvk3xskBi8IH
         ZN+98tnrLOucXObe3JFFnH6kVAZZFMnvzkwBr+/NFuZdzKmsUmo2BwG3HwLyZN2BEZ5j
         YrePIhTxUFexCFh9R2mCdh9HgN5Q4Llh3DxMZLBF8QtmHbyOMz9f/GTBdx2hTpwKcXku
         ZAEg==
X-Forwarded-Encrypted: i=1; AJvYcCXJleQfEow6R7tlgQl7rv7ZLUPaRh6fQQ4+XeEOVXfFXcn/0riRcfXC5oZV/kM9PcDNlk8N968+Hc4TBRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy82GhUJsnDB9qCvM4zqJUmQBI5r59Q5FulBafwU0z54mjnFKUC
	vuNAAhZvdqoLXFergcG52x8nBe99l8fhBs7rs5b1JpdemYQzBHAh2OlAHocGK9NQc1LrN2zf+63
	Zg3fGIYLIbWGj0xUc4X5m5TwWZkBJpSbyUWVOjEo5jaVdtbMAgTUjRbnpkHgdTrInn/4=
X-Gm-Gg: ASbGncvmtMpCIfEYyyYflBJ7/Y+hvg2iSRzV4C1D8jQ/kTk7MMFkzBP2R8PSsXL44LD
	khHEX0Jp9bJKNe1qwM16e22EdMsDZ3M9ULWCWUhUHuGnGcfmUlnJEVa/sZwOpRkJxtokzlujoHN
	c0noLxFy+i8KSgkAgj27On1fEEW+2zX30a+OcajGLmxMrXC5zd5aMMyseKFlNDM9cigptOHQ8oq
	GLECP5bNZdOoY/dYimJQs2swgkeN0gW511opsYKFSMVy9OGe0pZ3b2AOo2ZM1+kgQuFLVOnn+Rs
	ZtTFEA8a9vpjmeMHidJj9hzcbbRMU7aY448i/fVp4qaONSjfby9NWNRQKHO5tI3vY3XNCYpUuFZ
	dW9XGoGhljR3oSkUAqcn9Qsy+hEvAyR7/RRA1c5SsuuVFWYbuZtxYWhfg4ixdxHSpTIus2g==
X-Received: by 2002:a17:90b:2ec7:b0:33b:6650:57c3 with SMTP id 98e67ed59e1d1-33bcf8ec60dmr30315331a91.21.1761192432156;
        Wed, 22 Oct 2025 21:07:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFPMyfbfKQ6gBFWgcEHzbQ+WlKqxr4cKLnz5nrXjMEa0Y17iULEXCPmyWg4Rg7nanHfqwGkg==
X-Received: by 2002:a17:90b:2ec7:b0:33b:6650:57c3 with SMTP id 98e67ed59e1d1-33bcf8ec60dmr30315307a91.21.1761192431653;
        Wed, 22 Oct 2025 21:07:11 -0700 (PDT)
Received: from [10.133.33.160] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e224a2662sm4200672a91.17.2025.10.22.21.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 21:07:11 -0700 (PDT)
Message-ID: <7952ed3d-f019-4593-af43-b2df7f738d04@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 12:07:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] dt-bindings: remoteproc: qcom,sm8550-pas: Add
 Kaanapali CDSP
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
References: <20250924-knp-remoteproc-v1-0-611bf7be8329@oss.qualcomm.com>
 <20250924-knp-remoteproc-v1-2-611bf7be8329@oss.qualcomm.com>
 <CAJKOXPc57_0pJ2ZWf2cKSKAcQMc3S_mHKQxJDzWH7t=mgim3CA@mail.gmail.com>
 <5820a9a9-4474-4c4d-905c-0efd9442e5e1@oss.qualcomm.com>
 <o6dzhmlicwiezmxlb5uqitx7e3pjpyuhbjqfumivbdkru42hvn@r4ksfa6m5nd2>
 <540b1de6-c959-4911-925f-8163f5fa5147@oss.qualcomm.com>
 <fdfzoemfxdz2p622hvixpaznh2n22hweit2e43plfu2kdd6kad@reulvi4vs5v4>
 <cdc01b6d-370d-45dd-a3fd-9866d2a5f36d@gmail.com>
Content-Language: en-US
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <cdc01b6d-370d-45dd-a3fd-9866d2a5f36d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfX2x616HeC5I6s
 S25QqxuxsAcXNGRn1zthp1lDwJH9fmBNGeQLCu+Acp1nivf9Qs7ZQa9IFDVBa41ZCIcV1MwNH7q
 Lh3C/ZT2x2am/le3buToXEe0yX1ROSesWPiVVseFyyEqNc6Q2XdJPlGFIzAvyxMBi8/fFHawspb
 xU5XRXTC1if1EUDupq10JSKT2wEuvxfTmJNyDksg7JqfjL+e4GJ+VLnMBjx6OGkS9RHEFRhqqQk
 j5d14av3vTbX55M3geQmZxPSJCShTzvi++PnmPsl+jzoNXh1ug7R4iJMRcwqcCnMA0aTHdoRg7a
 n0eylSDMxLXyhIpxgNwCulqp/YUkatiMUh9IvSXeW/kVrWZY4EBC4e7QLgNJz/jK+qIvYkpu8jR
 NXXounvdOJTQsegH2m5xd+NuHdJmLg==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68f9a9f1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=VbD8AgmwhZIDVUnwpcMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: olokHySzkeDb4rep9HbLZk5ksV6q9lRX
X-Proofpoint-ORIG-GUID: olokHySzkeDb4rep9HbLZk5ksV6q9lRX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020



On 10/9/2025 6:29 PM, Krzysztof Kozlowski wrote:
> On 29/09/2025 19:03, Dmitry Baryshkov wrote:
>> On Mon, Sep 29, 2025 at 05:41:10PM +0800, Jingyi Wang wrote:
>>>
>>>
>>> On 9/29/2025 5:34 PM, Dmitry Baryshkov wrote:
>>>> On Mon, Sep 29, 2025 at 02:20:54PM +0800, Jingyi Wang wrote:
>>>>>
>>>>>
>>>>> On 9/25/2025 9:48 AM, Krzysztof Kozłowski wrote:
>>>>>> On Thu, 25 Sept 2025 at 08:37, Jingyi Wang <jingyi.wang@oss.qualcomm.com> wrote:
>>>>>>>
>>>>>>> Add remote processor PAS loader for Kaanapali CDSP processor, compatible
>>>>>>> with earlier SM8550 with minor difference: one more sixth "shutdown-ack"
>>>>>>> interrupt.
>>>>>>>
>>>>>>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>>>>>>> ---
>>>>>>>  .../bindings/remoteproc/qcom,sm8550-pas.yaml          | 19 +++++++++++++++++++
>>>>>>>  1 file changed, 19 insertions(+)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
>>>>>>> index be9e2a0bc060..031fdf36a66c 100644
>>>>>>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
>>>>>>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
>>>>>>> @@ -35,6 +35,9 @@ properties:
>>>>>>>        - items:
>>>>>>>            - const: qcom,sm8750-cdsp-pas
>>>>>>>            - const: qcom,sm8650-cdsp-pas
>>>>>>> +      - items:
>>>>>>> +          - const: qcom,kaanapali-cdsp-pas
>>>>>>> +          - const: qcom,sm8550-cdsp-pas
>>>>>>
>>>>>>
>>>>>> This time maybe without HTML:
>>>>>>
>>>>>> This looks wrong. This is not compatible with SM8550.
>>>>>
>>>>> Could you point out what is the difference from your perspecetive?
>>>>> it is the same as SM8550 except for there is one more interrupt,
>>>>> which is also described in this patch.
>>>>
>>>> I'd second Krzysztof here. Your description points out that it is _not_
>>>> compatible to SM8550.
>>>>
>>>
>>> Here is the binding for sm8750 cdsp. Fallback to sm8650 but describe the
>>> difference in interrupt:
>>> https://lore.kernel.org/all/20250221160036.159557-1-krzysztof.kozlowski@linaro.org/
>>
>> Interesting. Let's wait for Krzysztof's response then.
>>
> 
> 
> Because it is evolution of sm8750, so it did not go back to old design.
> from three generations ago. This is compatible with sm8750 or with sm8650.
> 
> 
> Best regards,
> Krzysztof

Hi Krzysztof，

I tested with falling back to sm8650 cdsp but it will fail with:
[    4.739615] qcom_q6v5_pas 26300000.remoteproc: unable to resolve shareable memory-region index 0

sm8550 and kaanapali define 2 memory regions: 
"memory-region = <&cdsp_mem>, <&q6_cdsp_dtb_mem>;"

sm8650 and sm8750 define 3 memory regions:
"memory-region = <&cdsp_mem>, <&q6_cdsp_dtb_mem>, <&global_sync_mem>;"
with the driver:

static const struct qcom_pas_data sm8650_cdsp_resource = {
        .crash_reason_smem = 601,
        .firmware_name = "cdsp.mdt",
        .dtb_firmware_name = "cdsp_dtb.mdt",
         <...>
        .region_assign_idx = 2,
        .region_assign_count = 1,
        .region_assign_shared = true,
        .region_assign_vmid = QCOM_SCM_VMID_CDSP,
};

When kaanapali fallback to sm8650 it cannot parse this region_assign_idx.

So shall we still fallback to sm8550 or define a new node "kaanapali_cdsp_resource"
in the driver?

Thanks,
Jingyi













