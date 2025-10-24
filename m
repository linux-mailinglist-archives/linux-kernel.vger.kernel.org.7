Return-Path: <linux-kernel+bounces-867993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9045DC0416E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 04:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 62AE24E6654
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 02:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462EC223DEA;
	Fri, 24 Oct 2025 02:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C/z3P8Gh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6281C5D59
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761271818; cv=none; b=OpWXn/v2mvLCQ7L3k99wdi6oDievSdZv1OwRYTP5TK+4n9FOnulgGjCebMTNQafK+Txj31ukFNcYtowdw63JJVM6FPMyAUMQmIDhWU7andOCj9DeIC1qAwQC0m/j6ldFyK4ssSK4OZyV34jNuHApFLWS6cJTEtkkMIYxx2nkR+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761271818; c=relaxed/simple;
	bh=bWhghqbkZF5R6OM/wCGrP0IOos+1Kse2GUZQVx+q0nY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLaL8PuGZOYTuiNAN3x8TJiEQBqRqvA+T698G0+u0Qn8/QrEPwp5kTwSIcaXKCk1M/HmKP4O/gymjFCrLKOwR+L2UiuOJborNK0OzBjnJswE4/ACyWmxsiB+R6g0+5pdAOhXCIayo8vSotm6z012HVnHtMaG/Ull01HfGTqIyak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C/z3P8Gh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NEYF4I007459
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:10:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PGCvJi9rEoMOgH9ee/rqu2BrVYz/eqz38q5hdOmWyuU=; b=C/z3P8Gh3PHag14N
	Pjfp0iJb/cqnKyA1AVEapwbGM/cJfYmN8DWtrIyANYnt3O/SxvWyxKBG1CnVpm1i
	xiaeyezCZl0+/zDaqLQJW4YAlNRe+6c5OVsmgu0x4F3e5qisqxDc3QE6IOMrLk78
	yRJNl7uTKrqzirSsLiMOHoOmSYRZR2iqZSGOIJ9KtiOEr+l50NMUCMDvdcpNM9P7
	kU3Y+DvJCvmYm6EX1MQLOytQ4zfZxbBLfkzUlAHAFR0JS4fuw8sKl3P0f1hDtOI0
	zSCAh6sfZRvOJ1ybyrqX6wbD8UlEX/BYbBw/X4eGrIqCZ7ABrICt+hCgRQPeFULs
	xfc3ZQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v344ahj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:10:15 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-28a5b8b12bbso40507815ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 19:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761271815; x=1761876615;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PGCvJi9rEoMOgH9ee/rqu2BrVYz/eqz38q5hdOmWyuU=;
        b=mzQPDRyH5lDHsaX8L605+Cuw9riqH68CYIRwIA6k73r3dhNdre9CuSxtGfXqu1JfSz
         wCaQNjPc1rK2kCdnMYjtJYH8+08NWsGSKk2dDsVdyf1kNlHm7Bf0PNJUv1mBzBa3LylA
         do/VBm3ocH0D2ellEioRF0to9jI5cQLBO1GBjVEhIDKVfm/zfXwbgcOMaz8WnMR9dVVW
         Mt8mWQuWQRPgL0Y5TyK4TtK3zv6JrcRQpsG2p4LgyaWTMkeqGhb1yocY7xvxCA5rxPP7
         GUcDdw6HtiQdnwCLTceYjrg16uVSiTAr+ToTCzL1OChZJWQzaTY5I3GVTq5KpD0q7L+Y
         6WXw==
X-Forwarded-Encrypted: i=1; AJvYcCUXMFscAMqbseeQkNjh5r+UfBKDVEKxVSMA8nVlSpLUJrPfV4wl9aHmfzponooWXpHXd4SDIOOCTuOS3D8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN/ALV6vy6nstPPMitCuR/RbCaWHWYPwtJRliOKgNHHQfPNwcV
	Ya7OjPQ0eIr7zwSkYuXdjKjdCvcGh2eOC07glGoihiz0TdBrjRFb9LDXl7vbDbsPN3ZYyJvblN3
	DwKyY5lML2senbCdT/qknISfgwrkA+/OG2EO6HxrJGUUv1L7poC5rELHIusgAf+9ic30=
X-Gm-Gg: ASbGncslcls+o3URFlS/rMPH+hNEome6beVqEiZy2AXUz5Z3loT65Fz712l28Uvd4aY
	CRlgNyNxhu/GQVD/tLvo7x1D7Yei8zq4EmNgdnrwk4IP+E1kuaU5JyVzbJy5l/VSrdKFrQu7FDw
	mhr5YeWdvPTrMWdnSxbiRnQi9Ac0EGXcbqvmKQd10xNl18Lh26xz+KSqjTgUNh5Hi6nxkHlJ2z+
	8ZjwZmyGQM3zIHaGBK5INPUDdCIdovOzNyc/7EwTMZN2ghNtyih7xmj3uuQDcDGwB3qPwcHEUY0
	P+X84UvcftbezCiGv5m5XqLwE018ad4ZVcidCz1noYmbHUcR8HrQDr/MXBO0o950yLg8L+RBBQG
	bVYvPkufCpSZqT8nU//DUztFvObUdqUCxi8L2FOX6vQa1lBqouOJtyP5XFVvW4H3VaQvEmg==
X-Received: by 2002:a17:903:2444:b0:264:8a8d:92e8 with SMTP id d9443c01a7336-2948ba950b8mr7646635ad.59.1761271814906;
        Thu, 23 Oct 2025 19:10:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0Th1WmQpEggqKtoeq8EtSC4CLCeFVp3H06Pt4dnKJUtaqYK88vCk/JQeaiuW7BPm22gLpXg==
X-Received: by 2002:a17:903:2444:b0:264:8a8d:92e8 with SMTP id d9443c01a7336-2948ba950b8mr7646255ad.59.1761271814441;
        Thu, 23 Oct 2025 19:10:14 -0700 (PDT)
Received: from [10.133.33.160] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dfc274csm38536765ad.74.2025.10.23.19.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 19:10:13 -0700 (PDT)
Message-ID: <1f98f83f-328f-47c8-84e7-2c77abb37a6a@oss.qualcomm.com>
Date: Fri, 24 Oct 2025 10:10:05 +0800
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
 <7952ed3d-f019-4593-af43-b2df7f738d04@oss.qualcomm.com>
 <c0e6b667-2e87-4419-81ad-3366ed56830e@gmail.com>
Content-Language: en-US
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <c0e6b667-2e87-4419-81ad-3366ed56830e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LjayAy9YMgHeJG72UfqKFb4sxVywLqdq
X-Proofpoint-ORIG-GUID: LjayAy9YMgHeJG72UfqKFb4sxVywLqdq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfXyPyRBO+YvClv
 81xRrQkDreXPj/UVwdMrK4tnd/R3Opc6M3C8PSDKg//LvvbBAnoUpoLUng8VOp9tRX/npS6EmRb
 RRQjxKbG4devZrsFTaedKvcoE3D2HK+1P3oSjf8YqYtXURBVwIhKSu4psX/zxS5LVzzNOnfR6Ui
 n2MWXh2iUxpS209MN0qvc18KzzQIJzftt5p2yKu7DQZYNQp/v2S+rfJAmzySLYirD2xF+gqzQ5S
 sPr3C0vkZGEG5y7bMLDEIDwJQF6gz15ZKbSAAhpzUPTZ4ip3bSUQGHTRaxnKwtNyNW3bDuH0qha
 jQbz3qC1i50GHhjleQC2g1pVQcYsHeFMZ+IPWBHLikoIDGAjTkxvDmX72sclCkiY95oXj9sle8J
 N+oDd9wVJvkbhDMzV01rcfbTVQqKoQ==
X-Authority-Analysis: v=2.4 cv=E/vAZKdl c=1 sm=1 tr=0 ts=68fae007 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=UIbmj66A9DVWYICVwn8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180023



On 10/23/2025 2:28 PM, Krzysztof Kozlowski wrote:
> On 23/10/2025 06:07, Jingyi Wang wrote:
>>
>>
>> On 10/9/2025 6:29 PM, Krzysztof Kozlowski wrote:
>>> On 29/09/2025 19:03, Dmitry Baryshkov wrote:
>>>> On Mon, Sep 29, 2025 at 05:41:10PM +0800, Jingyi Wang wrote:
>>>>>
>>>>>
>>>>> On 9/29/2025 5:34 PM, Dmitry Baryshkov wrote:
>>>>>> On Mon, Sep 29, 2025 at 02:20:54PM +0800, Jingyi Wang wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 9/25/2025 9:48 AM, Krzysztof Kozłowski wrote:
>>>>>>>> On Thu, 25 Sept 2025 at 08:37, Jingyi Wang <jingyi.wang@oss.qualcomm.com> wrote:
>>>>>>>>>
>>>>>>>>> Add remote processor PAS loader for Kaanapali CDSP processor, compatible
>>>>>>>>> with earlier SM8550 with minor difference: one more sixth "shutdown-ack"
>>>>>>>>> interrupt.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>>>>>>>>> ---
>>>>>>>>>  .../bindings/remoteproc/qcom,sm8550-pas.yaml          | 19 +++++++++++++++++++
>>>>>>>>>  1 file changed, 19 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
>>>>>>>>> index be9e2a0bc060..031fdf36a66c 100644
>>>>>>>>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
>>>>>>>>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
>>>>>>>>> @@ -35,6 +35,9 @@ properties:
>>>>>>>>>        - items:
>>>>>>>>>            - const: qcom,sm8750-cdsp-pas
>>>>>>>>>            - const: qcom,sm8650-cdsp-pas
>>>>>>>>> +      - items:
>>>>>>>>> +          - const: qcom,kaanapali-cdsp-pas
>>>>>>>>> +          - const: qcom,sm8550-cdsp-pas
>>>>>>>>
>>>>>>>>
>>>>>>>> This time maybe without HTML:
>>>>>>>>
>>>>>>>> This looks wrong. This is not compatible with SM8550.
>>>>>>>
>>>>>>> Could you point out what is the difference from your perspecetive?
>>>>>>> it is the same as SM8550 except for there is one more interrupt,
>>>>>>> which is also described in this patch.
>>>>>>
>>>>>> I'd second Krzysztof here. Your description points out that it is _not_
>>>>>> compatible to SM8550.
>>>>>>
>>>>>
>>>>> Here is the binding for sm8750 cdsp. Fallback to sm8650 but describe the
>>>>> difference in interrupt:
>>>>> https://lore.kernel.org/all/20250221160036.159557-1-krzysztof.kozlowski@linaro.org/
>>>>
>>>> Interesting. Let's wait for Krzysztof's response then.
>>>>
>>>
>>>
>>> Because it is evolution of sm8750, so it did not go back to old design.
>>> from three generations ago. This is compatible with sm8750 or with sm8650.
>>>
>>>
>>> Best regards,
>>> Krzysztof
>>
>> Hi Krzysztof，
>>
>> I tested with falling back to sm8650 cdsp but it will fail with:
>> [    4.739615] qcom_q6v5_pas 26300000.remoteproc: unable to resolve shareable memory-region index 0
>>
>> sm8550 and kaanapali define 2 memory regions: 
>> "memory-region = <&cdsp_mem>, <&q6_cdsp_dtb_mem>;"
>>
>> sm8650 and sm8750 define 3 memory regions:
>> "memory-region = <&cdsp_mem>, <&q6_cdsp_dtb_mem>, <&global_sync_mem>;"
>> with the driver:
>>
>> static const struct qcom_pas_data sm8650_cdsp_resource = {
>>         .crash_reason_smem = 601,
>>         .firmware_name = "cdsp.mdt",
>>         .dtb_firmware_name = "cdsp_dtb.mdt",
>>          <...>
>>         .region_assign_idx = 2,
>>         .region_assign_count = 1,
>>         .region_assign_shared = true,
>>         .region_assign_vmid = QCOM_SCM_VMID_CDSP,
>> };
>>
>> When kaanapali fallback to sm8650 it cannot parse this region_assign_idx.
>>
>> So shall we still fallback to sm8550 or define a new node "kaanapali_cdsp_resource"
>> in the driver?
> 
> And partially the point here is that you might need the third region, no?
> Best regards,
> Krzysztof

On kaanapali, the global_sync_mem region is not managed by kernel, so it should
be removed.

Thanks,
Jingyi


