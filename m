Return-Path: <linux-kernel+bounces-851682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C924BD70CB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 106ED4EE4FE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 02:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5CE303A3D;
	Tue, 14 Oct 2025 02:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j8gnlcHi"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E959DEACD
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760407960; cv=none; b=dE2n50BJwkXH0CAA385GaD2oRWXoR7hUWeZPWhKM8DtSstNK6rYFgRrZITjGsW1imBWu11yn4TB8nyG4XdAKtCadirMGe77zF/fU41SVdyBrr2xCD2lSkMbl44q50EeQtFyqRnFhRnxq88Ww2fgB8vJhulGGjMdLxyh1ySZKN5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760407960; c=relaxed/simple;
	bh=dZ0o8gmckY6rxJxNnA+9DhSm4fDov9EDAmj2Dlk3h1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H42N1qKPvyNrDLEJfkYBvxjeYdfX4Qw9gQxMz7stYSILImzvyehsvjzHCZzxx1SRInEeNrIRfQl/hVhrmWLitrPHawXYm/8NwW1JaAa9HHApWWH/M6Z4vIhN10mAkOBclRE+4wt9GMfR5njoGVHwFUc9BMJ4kjzj7h4XqKMXPw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j8gnlcHi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DLh8SX013448
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D0lOk/NcTeNYZ+rZud7vj+3w2lY0WDQ73Jso4LKOB7M=; b=j8gnlcHizbYvJum8
	Kex6wTX9yqOUU4P+Ui/4433j9CRG4a6gkC7icUteLJaC6JVVMwJvBsnITlJfVtiW
	gLIP7kLjhB0jIStGrKWjTTXmy2y2ykjbMWCgiqi4wOAW7LXVsJmIZ3R1kPjYJqsK
	WdHfcbLjr63d9Hng602av2LvF5ILYikwbWPnsM6ZFYsWSOp1AfCyeNHu/IdvXBua
	pzonkVW8VPJd7p/QEZPTQKPKzG4B6J5D8aXPukEvyotlCZm0vPwCtMjl1IPn3CD1
	bFX4t2Cc/ioZjHrBlHSpaU5suoRP/B823OZlKL9s5Td7HqRxZZ8PnfNCWMu9s5pn
	fU7Xlw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qgdfxp29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:12:38 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-339ee7532b9so24614526a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 19:12:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760407957; x=1761012757;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D0lOk/NcTeNYZ+rZud7vj+3w2lY0WDQ73Jso4LKOB7M=;
        b=VvcVI704BsueBuLLLtEdwsbAbxFUAzEmZ61RYTRySl1hQPlxKD9xTzoZjd5cHd5jGh
         6roK5CLIJ7CZGOQekxpsNj+lkj4jZZyTSFrrS74MfUAuWzjFVNrIps9RShPqAtITRqb2
         dku5Tpsr6O8kj807pAqogPBCG2TXXmRXUKeC+c7QTAbuS8LRxfhiyPu7pjbP8tMiA2VW
         /Hv3zBDDleZ35HmN6LV/08a1jMK6VVpLDqua3GPFS+sTNbD72ZFDrNRKTRch5wgvQgV7
         7V6Kt/8OTvVBZDcw729s4zGxDjBKvaJK9Nrgm6o3iavaH5BHCDq+MirmAnaBV8gWQoYV
         8RnA==
X-Forwarded-Encrypted: i=1; AJvYcCWUgUTkHWtlDr75FyRDFkd/TGVlV271QFxmqTrC2et3HCBqotcfZToKyu1dRPlhhW8mrW6K20+nvkzduAg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+rwd127LczqIXGrYRXUq1yONUJGqwu0B7c0fmPXyYEVVJlghR
	Dg1P1hnv8qOkzTiIU+258IuIA0REC2E9wUE4hVKAGOVIbNB7I3iCyraKxzHB54tHRtqIy1NfnP/
	LyWwNDUXS8B1QRVyTCIzo8Kvma7nBdRtnj/uKD6cPzM0p+FH/tNWFCHKOumlPhbjFZ2c=
X-Gm-Gg: ASbGnctd9zgkB5HhRcnJ88ZQQ77ZcwwbSmg5RbRr5gr4nsw6V3FwO1D+WJNWwfkusPi
	PdjeZ1yQXn7kKlHHe8vrfZIHhqcvPTE74y8pBH0UlA2+T/sglFqqiGUqTmypRlhJn9epJiUwfej
	LKZWZrMKyKdC8c8sjIcgR2FntLo3/gJSpkE5t1lP64UO7Aa+nrcdSVJhTH/Ul3CtmW6PsIS4kgN
	pVUAm5L6VqKAZ2DUKK4VbbLL8HIyTpjUWK2B87sizBmrHl0PcUmqtWD0NINtY9rLLtVL0If3pNP
	eY/KHRzVcSz7hwwsUX+TUCLflS666h8T6IcaU5nNXSGzJinl11CInSN2y4/8t7ZruBmpLeXhnc9
	AgrzNdgjT8vDb+xPea/SL9xyi/HFm7fpmt9o=
X-Received: by 2002:a17:90b:3ec2:b0:332:3d8c:eca9 with SMTP id 98e67ed59e1d1-33b513a1e6cmr33075541a91.33.1760407957237;
        Mon, 13 Oct 2025 19:12:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE65yjJCx1wFZNMlx2LX749Bsa1eRsElAuiu1yH85h6pf7w3J7S6qmbL2DLJjNDglyATuJXRw==
X-Received: by 2002:a17:90b:3ec2:b0:332:3d8c:eca9 with SMTP id 98e67ed59e1d1-33b513a1e6cmr33075490a91.33.1760407956674;
        Mon, 13 Oct 2025 19:12:36 -0700 (PDT)
Received: from [10.133.33.138] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b52947843sm10647419a91.1.2025.10.13.19.12.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 19:12:36 -0700 (PDT)
Message-ID: <ecf617d5-7a53-4e61-9741-f8e2535ebf66@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 10:12:26 +0800
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyNSBTYWx0ZWRfXzVP4ghOign2C
 4ZQc48Z0MpnvKW0HapYaB3a9RpGeFzExAUB5hSAikpPr4i+24+F0EOYS7SN0yXzdo+igBXFOXGX
 94YS0jYdfS+CnJZNqDeJP3XOQFONCR8StDYBnntcwy5v24pnYekjsS/oEP2E30QoWY+eKXiWA+o
 GGmN4DeOjVXT3QR+Sk/StFDCYLJ4+GO2Z/VPBazFSR6Qdt7+nQGNXwGRrpWNWq6Am1XTd3tQVOA
 WovjpR5SF5ME0GzuOJBtS0iwQ3kg1RZzViGMFqMK0RT19hKTFfW9bZl27MV+zdE3XRfNX60Wdzb
 yCTdvIHbiGsdJjT64+AtY2F8TmRV1e8uoTOYV/HPa9ZMC4BpX5fNEJcKevT5Q+/4m+Zp7IGnfsi
 /eXulRImUhhsKQ+ax15BAdveUBHg+w==
X-Proofpoint-GUID: t4tXy0RiaOQDJHpkZ8OP9f0U5_UWonxK
X-Proofpoint-ORIG-GUID: t4tXy0RiaOQDJHpkZ8OP9f0U5_UWonxK
X-Authority-Analysis: v=2.4 cv=J4ynLQnS c=1 sm=1 tr=0 ts=68edb196 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Z4Cr7gmSjbT-dz-ffA8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_09,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110025



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

sure, will fix in next version.

Thanks,
Jingyi

