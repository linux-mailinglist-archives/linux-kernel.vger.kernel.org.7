Return-Path: <linux-kernel+bounces-835805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 861EABA8191
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51B91891959
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F83253954;
	Mon, 29 Sep 2025 06:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iBz9Lq7K"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7EC239581
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759126872; cv=none; b=NLtWkuIQRwlKf1bERxWnZ6Fz59iKM/g28JItw+iC5huz8LfOeiu4IK1gKdj5VvQrn5fW263CTv8NAO1iUuIETSgTSjcnUQrm7t5vW4GmeqOJFnQVjeEdyolNlE28w0dlh/otxsDapVua4DJh4c8UAX1RixaMyUgUXHacd8OpJAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759126872; c=relaxed/simple;
	bh=q2Ex45lu0UO1PvLVxP8lWfrNJZYuJYUaYkJPz++bp7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ct7eH3cUeFJsIRRHCASZYEvt0mOgrlBC9wgeFTt0apJW+q5ebdP9chGxZ2TuTYa470lNC6lt7sbUtcvh+sT9yTEnB7SbgpxUrG654NvFTbY3j5dkKBep6yiqbtscEi/+x6+KLv/DMs4yGd0zaP5ZsUmymAgiXnkp/fVGIwOCKgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iBz9Lq7K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SNrQo0010542
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:21:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T5RCAnxQPgz+f42q/uUJ/xybCFPufzjjYf6jemuzLns=; b=iBz9Lq7KZUAWV5e2
	M2gRNFr9+vsxwYogYHviBud2IpabKlqDVZIp38xfQ9RDWLmS6ghYCO2RbJOtrroT
	UrT6chIkaQSSw8VmH/E5qavZtSEHXfUtuPjOdUqerdCSMJWaOzcHJA0lORQyrh7s
	WXnvoCj7puHQ//FiCls57Et4m2cehQ8TpTXyqf44sW3Wx6AcFQqOzVx6C0Bqhj4y
	rZe1iUjb1pKlxN3B91CM5Zpp/rUjzjz/KHE5gFM4Ybss48ei139M2ZsWj+ttlAZY
	nn50H+OCzMEZBD27ssozrEVZrTm9YlXWXB67itOyQHBHWGatMpDBJ0MmRewKTkfE
	0I9+1A==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e851c0gb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:21:03 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-77f64c5cf62so3131152b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 23:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759126863; x=1759731663;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T5RCAnxQPgz+f42q/uUJ/xybCFPufzjjYf6jemuzLns=;
        b=PdttT4laCo5bFfiq/WT+jT5CgfTtOlCKCjZaCVFEOWV/BBYtG+DxClvx0wWNNkDusK
         LErsdnBW/m8wX4+1yJ6O8v5QK+J+9SjPR87dYEFcacrfGQC/ZLkCretImUFAycCwGByy
         XEZl9JK7gO/JNl6h0qojWwhdg62CuM5Enqrixw1IgiwN85L0xgbvVPi736WjaP6/1b5f
         LpdeE8/l0YFGaLH7OMtIm1earHz5vEjlgEcmWeUnsFBtTBv8XG99YaFTTNxLe3DWQIpg
         P3mD1Xiu01XwdPJa41847YJHPVbrwkamP5gMqEA0pyPpbqNUVh2lR1qcGhyOotJI2EEN
         MHew==
X-Forwarded-Encrypted: i=1; AJvYcCVGrXj67uvKD/2GmWzAIp+rKS5GIZrChJIOkdjjx0yLI8IWRppybIPPx1oFG+gMn/k9xkw53utQTxeT0ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHL16n8QDm2YgfCLEtqH3jw7vBFF15SJvnN45qQTEI+OIngFCa
	W7vj0ecnySfsZHtsYIWomk38wbYV34j7lYL1ADXg5Mz1tzqob+b/Q42cPlOE2opd5Rujqdd+WPU
	k+IouE/n65aKu9GkzSQwlJBvFYuFuaVKy3TMsZgEqkNsmEvh+0LIT9kN4RubGz3cDOdI=
X-Gm-Gg: ASbGncsZutTnSc2HLs7g/JqC8dpm47Y0zP6Im9YcMSZ/slnzkhA7fqCnnE116wqg5xs
	lHP3cENYEzh02P3qzfh2f+mrBOcodv5cGEiYWCZ7eRd93YHpwA+BOiqNmXQXB81dTsZv5zPzkdn
	Z5Xovr2lpoKOEqSul63/wvz/gT7ouQRTmjMKF8kWcCnm4X2MJ/ts5wsCYuq+kWwoXT48Yptt8lX
	fC7P2X3zo1kUwcj3FMz2AKBg0fzrCXO6AOA+nwctG0dlSR1mhPT7oKybzURutnMmQtZhmgEz5/m
	48MrV8ka1WP9rP97BrhyItpapF25NG53EPC034Pinsb43XrW/8/oA8jxdI+OCSjQqd4Yxbbxqqr
	v0K5Wizs8Sqmduaqd37d5ZK3At4oQSOARZ1M=
X-Received: by 2002:a05:6a00:23cc:b0:774:615b:c8ad with SMTP id d2e1a72fcca58-780fce0a094mr16191369b3a.9.1759126863005;
        Sun, 28 Sep 2025 23:21:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyXhVu5YJr/Bl08pETVz+ZdPLkfd/FjtkIFppmpYj1TwDX2jO0Olrp/Qot5cdvw17ItUB60g==
X-Received: by 2002:a05:6a00:23cc:b0:774:615b:c8ad with SMTP id d2e1a72fcca58-780fce0a094mr16191351b3a.9.1759126862600;
        Sun, 28 Sep 2025 23:21:02 -0700 (PDT)
Received: from [10.133.33.234] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-782634d2a7bsm3892488b3a.29.2025.09.28.23.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 23:21:02 -0700 (PDT)
Message-ID: <5820a9a9-4474-4c4d-905c-0efd9442e5e1@oss.qualcomm.com>
Date: Mon, 29 Sep 2025 14:20:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] dt-bindings: remoteproc: qcom,sm8550-pas: Add
 Kaanapali CDSP
To: =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>
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
Content-Language: en-US
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <CAJKOXPc57_0pJ2ZWf2cKSKAcQMc3S_mHKQxJDzWH7t=mgim3CA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OJoqHCaB c=1 sm=1 tr=0 ts=68da254f cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=yr-pD6fi0WPqCAYln34A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMiBTYWx0ZWRfX457WbwKCRlyo
 tVRzOFeyOzU/gBH6ch0FoExeVYtLI7fVGnwmUizS8CLwVSCSOM3gPUDv8t5pT4gJx5YG36ujlCb
 9tDDVk7YRdWw5QtZW/S4MdiN8EsCnG4e+eFKqZXkL8LB68qyYvNnH3FO55wZzQJPbG05gcJDXTV
 VAAEPP+0dSoDTkVC64L8c+9qr1vtND64so9BcYS8f4H1D7JdVkrf1ZbwuATf0nZ2cuv6hiCVJrr
 sCWLXKV1lf01wOcWbL2Z26gsFmZfJ5hnz1WtjTwkFlMf8jTrFN3F8msigTL1/kNAwyTfmnJahdV
 jJ8L7QIJl+WGxIYmNiNOAuIl3MHcLvzyremaO/dhyyaha7CDMM4MfYcCH7NbxJ9u2mipLacGzE0
 ILjA25yKcaMJxmz5P7rrxROdomSbKQ==
X-Proofpoint-ORIG-GUID: owOmktGqv-60HnBXSc3W-r9HKHfCfYNF
X-Proofpoint-GUID: owOmktGqv-60HnBXSc3W-r9HKHfCfYNF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_02,2025-09-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270032



On 9/25/2025 9:48 AM, Krzysztof Kozłowski wrote:
> On Thu, 25 Sept 2025 at 08:37, Jingyi Wang <jingyi.wang@oss.qualcomm.com> wrote:
>>
>> Add remote processor PAS loader for Kaanapali CDSP processor, compatible
>> with earlier SM8550 with minor difference: one more sixth "shutdown-ack"
>> interrupt.
>>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> ---
>>  .../bindings/remoteproc/qcom,sm8550-pas.yaml          | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
>> index be9e2a0bc060..031fdf36a66c 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
>> @@ -35,6 +35,9 @@ properties:
>>        - items:
>>            - const: qcom,sm8750-cdsp-pas
>>            - const: qcom,sm8650-cdsp-pas
>> +      - items:
>> +          - const: qcom,kaanapali-cdsp-pas
>> +          - const: qcom,sm8550-cdsp-pas
> 
> 
> This time maybe without HTML:
> 
> This looks wrong. This is not compatible with SM8550.

Could you point out what is the difference from your perspecetive?
it is the same as SM8550 except for there is one more interrupt,
which is also described in this patch.

Thanks,
Jingyi


