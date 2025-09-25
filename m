Return-Path: <linux-kernel+bounces-832390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 880CAB9F377
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A7D1C2168A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0204F2FD1CF;
	Thu, 25 Sep 2025 12:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ER/ymupR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2E22F3C00
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802926; cv=none; b=aWaxcCpPEYdm/uy2HnG2lt89it2fqdiFYAhVfl3S0UWPNtkhucWaSW+rBB0wgdmsl2uj2yC8UCsYjx7r8xMAUjgoC9IVtS3x0QDsY38AiWlNOa51dlhCqt3QLMj99VKwwd5+yxgo8exkaynL+XGhrZTlpJbF6BHv5M3oijN7Pzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802926; c=relaxed/simple;
	bh=2XqVg0dmLhS4rgfpAaBmZZFswjnXfLDwZ3YAEXR7JI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SVShcuMKW1xoE7t3XejcMGul6GbcfvtKYImsNxbdWLlysLm9Js1fiCsqSNFaJMxeW3FRbPx/nutL4xgfCZvl523kVrmjrzXajGjN7UOHFO4viNG9NKrqkAcD/jJezrGQag3aPC8EpvriW0efbIKzstG3kSlUjLLNXDTajznbNyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ER/ymupR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9QL2b025572
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9DR5cpyOH/BxeCbJMQgTb1MvE86nj0ENnimkpeYOk2w=; b=ER/ymupRzR6PbkCp
	p96ZuAClQAY9Sy3sQFmb9t0KmyWZxY2iImSsxGawYB1++b4BCxS4kbYK8ZBPaanG
	jlUt2hGPMr+UnXW/rZ4eZO8AeAyw3HlJhfxI5D7lzhPlu7vsZly3037N+AJNoglK
	JjRgzWpceQkJtJ83/U/U6p1teC7i9isMbyBnTjFD9IVXNrpBC1h/qYq1a7SzqTxc
	lQEJBVFNQlUdNG11FdYiITJyPvwzFHozLb8j26nplChPTW4hCDYKOVPp4uPhthuI
	tjFV6SVnAwOdy6E5MqCBIqAzBPDlndTRnI8Q8ty4NFg92pbKKHbm3G7BeY3PHvhJ
	JH0TnQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyf0c4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:22:03 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-85e95d986e2so2514185a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 05:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758802922; x=1759407722;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9DR5cpyOH/BxeCbJMQgTb1MvE86nj0ENnimkpeYOk2w=;
        b=uiT2Qbxb3p9PhyX+LKeo6n279dtViHysKO3oCAH5aMQZ0mvlL2lpaRMoVYJ9m8qDmk
         TXLQKuJz5g9UC6RqbJB3hZchiPb8u4DgjctrH0owpUhLgKKlzQw523vj1zuJ884K7qZ4
         OqovYIy377cnd1+ZIt+mvwWVVlVeohP/DWxTvvBtFx4F7UoM9nDvQCLRVFmbTam1/dos
         1lbWffdkJqTiCFIB2x+4jglXnGOcTBBAQpq1aBMF+TI3CIjM5IuguAjjdLu61+6SnIHC
         qu8gQav2t8KmycpQwx10z+M0jAo6l/WzahZ1i5NdkY3fb/jfjxRV73hP/6mUF/zTTQ3c
         2lKw==
X-Forwarded-Encrypted: i=1; AJvYcCXMHoxQawCnTllcIMGxaRd7tJf9WzYhG/oaj7CE1Mj1/cL1QtbEKO4qVoQmxyx0SSBb9cqvERAbJxCRu5A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxcaa/XJHZl4HxpKPElKCYB2Oa/II8rZUsTot9aqPr/2ZMBIMO
	aShTJGPQPHAoXtMGG4k463RnFexP5nkis7zAt9ckoJPbw0FoOA1TFSNmJwT8HOvEQuNbv1FwnZw
	u1CucrDuTAAthxPwiGhevC/00eUaQwSVrQegXU74akqmp5yiSUUkqOhasiAFgFhm8QAA=
X-Gm-Gg: ASbGnct+UJDHok8rUh1Wt4+bKAOYB2S4RwUCI3hOPAhunKkS986brFy4NsohOj6Z1kY
	pfHVt+8Enyq1ISLiaSGKTHU8DhSDIRWx2HFZkawqb8cwu+7SFj6xHMu0EFdzaJNpRMtfghYkcR4
	jqXEVnmIltPXPONPKXBkagtw74ZDURy2mGnOM5yAKfaU0Fr/5J+osYs+G8ncJcw4OeWI1u4kiBi
	TBD4Vz0Saf+s/gJ2i8H4pV6gbLM+BDYoWK38jyRBmUrANaBDzij5SikB09vvwH0oB+C7O7O/F+4
	a2gko5gT85X2Kes1HrgyZqOHs/HtENWqaEzGhA9zBsNY5fp3ZHS2xJQ9gDUKKDWct4MGl6YXj3P
	dkzXEImKeS4ZKWYdAlPEtvA==
X-Received: by 2002:a05:620a:40cb:b0:855:b82a:eba5 with SMTP id af79cd13be357-85adf5d276cmr260962885a.2.1758802922345;
        Thu, 25 Sep 2025 05:22:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkv+k6t8AORrT51fuAymrjcGmjeXtdiNAouIlWNN19Pm2PP8RbzkJ3wR5/uExqQ4VNoCqwfQ==
X-Received: by 2002:a05:620a:40cb:b0:855:b82a:eba5 with SMTP id af79cd13be357-85adf5d276cmr260958885a.2.1758802921627;
        Thu, 25 Sep 2025 05:22:01 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3544fd0a7dsm156717766b.83.2025.09.25.05.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 05:22:01 -0700 (PDT)
Message-ID: <7dfd14ed-18d2-423e-abbc-33ef8bdc0a75@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 14:21:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/20] arm64: dts: qcom: Add PMH0104 pmic dtsi
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-10-3fdbc4b9e1b1@oss.qualcomm.com>
 <CAJKOXPetzYdOvYkzeWmm9pVM1MwJhng4JLn2jsoAuey4jtfrqQ@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAJKOXPetzYdOvYkzeWmm9pVM1MwJhng4JLn2jsoAuey4jtfrqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: hSqEDfXrZa53BEDYxuYkUYUC5VVb4H6T
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d533eb cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=9Zr-VXZqQWZOgLseAA8A:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfXywZXefulvIyb
 iJeWQ9KkT4xrBide1Rm5Uh+f10tqY8ymHYj92Vw20GsW23nbgSYkn01qz2J0GC1Xn2I84Iwxl9l
 41cdAngDUI5zk4avhVUOBi54373g5veAvLuA8rwpscBrqT8FIMY0ghkjsWbC9EKCTfDJXvD1Jth
 NM1DBEhpdibp4n1eEitjttjeVDERZVaQHf/FbnEc7sDXYji0VtVNqHQIe3HNRZivASIiFGPaELC
 5vf4amodJ+9xSxDEXt8tOWhSrAgijUcslVpVfu+/T4y/+GluQJAZZ/jqlLGs8CFUpzqqHjPwou1
 pcv+tM+sG0+gHSLEh1/XshAa6cWceZcyc61xdQX01CkyZmK4wko56rVO60/uXUYK2VF7UhDkzQ1
 CURnHmO3
X-Proofpoint-ORIG-GUID: hSqEDfXrZa53BEDYxuYkUYUC5VVb4H6T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

On 9/25/25 9:59 AM, Krzysztof Kozlowski wrote:
> On Thu, 25 Sept 2025 at 09:17, Jingyi Wang <jingyi.wang@oss.qualcomm.com> wrote:
>>
>> From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
>>
>> Add base DTS file for PMH0104 inclduing temp-alarm and GPIO nodes.
>>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
>> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/pmh0104.dtsi | 33 +++++++++++++++++++++++++++++++++
>>  1 file changed, 33 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/pmh0104.dtsi b/arch/arm64/boot/dts/qcom/pmh0104.dtsi
>> new file mode 100644
>> index 000000000000..f5393fdebe95
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/pmh0104.dtsi
>> @@ -0,0 +1,33 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/spmi/spmi.h>
>> +
>> +&spmi_bus1 {
>> +       pmh0104_j_e1: pmic@PMH0104_J_E1_SID {
> 
> 
> This might be fine for Kaanapali, but it's wrong for Glymur.
> 
> We discussed it already and I'm surprised you come with completely
> different solution, not talking with the community, not aligning to
> solve it properly.

I think I omitted said discussion.. if it was in public, could you share
a reference here, and if not, would you happen to have it saved somewhere
that you could forward to me?

Konrad
> 
> Judging by other patches sent now, I recommend to drop it.
> 
> And instead just join the talks... Otherwise how am I suppose to look
> at this? Everything I said should be repeated?
> 
> Best regards,
> Krzysztof
> 

