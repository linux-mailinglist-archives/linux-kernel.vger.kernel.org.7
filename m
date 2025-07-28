Return-Path: <linux-kernel+bounces-747735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71201B13775
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC3477A46A8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A7623534D;
	Mon, 28 Jul 2025 09:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pBbJn40v"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203DF224B04
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753694708; cv=none; b=WSRTYASvcQgk2q/UmtN96A/8lRvNsWb1FxNO0Jg6oaBI5JkftwF8CTgUAqvRhcQCNzVcLifdlV2HcaGOFsgzsjXVHyftzyltFbM1wBTQjWtO2WFlxE3BCRLZYpA7FzPZXoj2a+pFPdYXCnM3KzLuX+cIM8nab1d1egjGWTTOH2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753694708; c=relaxed/simple;
	bh=PvPKcE3eALATxUJe1yT+rLheC5LBnXtwdUiRFngfSqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q0HXxTSfCscxImvLnMHl3+jdEZt5QEoE5Q/NzTVhCjwh91Imb5ZRtvYzdtuNpcdjeYEJJvGeg6pNBFky6/qrnizjGRWo+Urm1jTB9htg65dKdJJfQYekY3rjDOWAy6Rhi59w092l7PNeOeBVOYo0vMN1rm6ocnNGbhnNwGGOs6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pBbJn40v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56S4rMkn014362
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:25:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xO1DkZAA9DCroi1+CycGEgMcsvDK1LPRrUiGmAaML1o=; b=pBbJn40v9A1yBZb+
	L95XkkmCpRgxUZx1VEtq7L2Sx/PamdGr4//heZn9OqRMMFTkPAGQCLMvulXn+uNP
	QzFHiRCknpCBjIHU9rrn4QpCywqzVr9oJPgRZ/kdd3+zvW5he3zEQz/+KDhAoQ2w
	QTuMKv8KFPSKWbvfPQ72L3tXcYsncM39Ft4pWlOz/fi7vfFk6YH9PO+nASgt9Rpl
	itjUvh5ol0Zzhat49B2hetJXw1iUxFN4HUsMvUXj4/ndSlsJVYEciOhvO1R8/mCM
	sMGTb6v1iUsuTAWd6HC0nX0vGq0HPt7HEMa/84xlI6nFZ0FZlBbhM856c3VQMzfj
	VBMcvg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484p1ac0r0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:25:04 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab7077ad49so7573721cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 02:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753694704; x=1754299504;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xO1DkZAA9DCroi1+CycGEgMcsvDK1LPRrUiGmAaML1o=;
        b=F2WGcHUVNcUWI3v4maPgC+SIpSr8HcvmV8E5lnjEC24ejuBPgQRa3O8zYvHd/gTyPf
         lu27evnMHoEDzK1Dz8fpudpFCvznRiKogJ08Chnvj/sTBXXeArIoPLvQlVnRkhTmhu3S
         QDrlNHeKoe/R9RvgPWdZT59qNssB+/tbGfwcsua1pkT3Ax2irY2kTpiaIRCbSVOwKiEN
         lJh9LeE3Rs/TClcBxz6k7CG5aieQruCtGZfnAChxSQKTYwhF2yjgZ5WbKxfFXQWSxIN6
         q4g6Vp8C9Udgh5O1wVclcFWtLMcOL7rjzFxN2Ofo8cjgFW9vk/nUi5hq/4dPfhl7vkF5
         S8qg==
X-Forwarded-Encrypted: i=1; AJvYcCUzdGLbC7H83Nhv5wrntTpNmLb2DiIL9isAiy5+Zld0ZU2GZ83YpxMCxLmxdDxPcaQoqTDa9AdnqbdwxtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI0rOxssj+Ziazhvkr4xcfPxc2Qmk3ZjsHtY2A0JRpBI+KjyuK
	4flIkH26PwIuy8AEb/va9y57yf/FNf7Qs07/UIWFbpxkzIV152Z00+vl4OGVN3puBLZNHCH9exZ
	lIvn+tRygcs4WxWZ05kQDDVYlu1AhFuOiBp//35XPstqL5gCHAHhuHofgTu4OWC+k6zY=
X-Gm-Gg: ASbGncsfWZgnDG3zM9vAV/E+K8kz8sEw9Y0/mHVHRRSpslYuEpSCICateyItM8PdglN
	PQ0cz1u3rlkV9iU37AyARwqtS7UHAEr3h2j0sNDFOHthapLJv23COaR0cxVH1TM7z6yezbORSg/
	G+m7tykghH4z+I+X3ynTs7oI870XBCaz4EQFXxZ7RugooqSl7bcuYJ83/5KDb+9D7nAaQ/fugAM
	a6+IlIygRWzp0NEpwdWeiFYbYxr1nGPMR9ttFIkbdFnYDwQMjRK2lDiYO/SK+3TwuzUQgoc7FcD
	5l1s+Mck223ndCsXBbnzaMPOwUdDIHp/Ln2QGhRDOcaMaomkLBSu5W/zKaNCoqzhHauLm/ncXLM
	d9OIXEe1ssk8H0ZNzYw==
X-Received: by 2002:a05:622a:1b92:b0:4a9:a2d2:5cd5 with SMTP id d75a77b69052e-4ae8ef7e796mr58446291cf.6.1753694704005;
        Mon, 28 Jul 2025 02:25:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxAT4whBsHT+qBFJmzRTiibTXpVW5iNbuG0sn1pmyCWfzieUITf0fIw8UP0wtE2IZXWRpuTA==
X-Received: by 2002:a05:622a:1b92:b0:4a9:a2d2:5cd5 with SMTP id d75a77b69052e-4ae8ef7e796mr58446161cf.6.1753694703376;
        Mon, 28 Jul 2025 02:25:03 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61500ae2f31sm3003928a12.51.2025.07.28.02.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 02:25:02 -0700 (PDT)
Message-ID: <6e8bcafc-da00-424a-81a3-439e7ed6e080@oss.qualcomm.com>
Date: Mon, 28 Jul 2025 11:24:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: qcom: Add SM8750 GPU clocks
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250723-topic-8750_gpucc-v2-0-56c93b84c390@oss.qualcomm.com>
 <20250723-topic-8750_gpucc-v2-1-56c93b84c390@oss.qualcomm.com>
 <20250724-blazing-therapeutic-python-1e96ca@kuoka>
 <7d444f4c-fa1f-4436-b93a-f2d2b6d49de2@oss.qualcomm.com>
 <a3846433-f1f8-4b83-a965-baec24ee5159@kernel.org>
 <adffdc2f-7dbc-41ea-ac9a-015af251b43b@oss.qualcomm.com>
 <a16c19e2-a4be-4c62-87f3-5d0354893bcf@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <a16c19e2-a4be-4c62-87f3-5d0354893bcf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: eWZG340iaxic9iD1l8v1zRHXb0tdScx4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA2NyBTYWx0ZWRfX10xBYMBU0Gba
 UT9BbPZaMot8TADYcZJzpJyEt+y8rQJg8kN9s/WAMh1cEt41nk/NoeD6eEIndJtPDWmZsnAUyVM
 arUQOx5m9u9OTsJ0M4WdvFHHiilFK3Ey9jbtml03kGuTDzt8yQ1jNzO/MIro/sNJsT0PaiPygcN
 JDe+j2v0Iqa0XdKXcU2fRUXJiYjPYBLF1QiHchjaRuDNZYSlGQIPkhJSf9q7P+JWhZUj8F4B6Y7
 6/g2EDCMP+ZoefiEgIe+XVawkSRv8humGdFnXozBPCIUNBmAD7zwNY6zPd/s1OLpatozMhNNWmB
 WdRPDryDPnJBBy7yCFrhYqwJPz0gOiGnr/dQI9pOIqWu7tuLuwSRwnsrei/+3ib7h5D4vl//dSz
 zN3EEdYnn4JsIGhmBtzHqIHWUOs9gz3hcYYywBm2w7LPgxNs8gYqoP9iLS5uYmfwr/bWfPs2
X-Proofpoint-GUID: eWZG340iaxic9iD1l8v1zRHXb0tdScx4
X-Authority-Analysis: v=2.4 cv=KtNN2XWN c=1 sm=1 tr=0 ts=688741f0 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Rh5PIcw8VRhVldmlYEYA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507280067

On 7/28/25 7:05 AM, Krzysztof Kozlowski wrote:
> On 25/07/2025 11:23, Konrad Dybcio wrote:
>> On 7/24/25 4:42 PM, Krzysztof Kozlowski wrote:
>>> On 24/07/2025 12:53, Konrad Dybcio wrote:
>>>> On 7/24/25 10:18 AM, Krzysztof Kozlowski wrote:
>>>>> On Wed, Jul 23, 2025 at 10:38:48PM +0200, Konrad Dybcio wrote:
>>>>>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>>>
>>>>>> The SM8750 features a "traditional" GPU_CC block, much of which is
>>>>>> controlled through the GMU microcontroller. Additionally, there's
>>>>>> an separate GX_CC block, where the GX GDSC is moved.
>>>>>>
>>>>>> Add bindings to accommodate for that.
>>>>>>
>>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>>> ---
>>
>> [...]
>>
>>> Yes, qcom,gcc. If that was missing intentionally, it is fine assuming
>>> you implement the rest of comments.
>>
>> With the description addition that you suggested above, should I keep
>> this file in clocks/ after all?
> 
> Good point, I don't know, this is unusual case. The question is whether
> there could be user of this binding/DTS, which would need/use
> clock-cells? If none of possible users could use it as a clock
> controller, I think it is not a clock controller from how SW sees it.
> IOW, it does not matter what it is fully (in bigger picture) if it
> cannot be used in that way.
> 
> If all users of the binding can use it only as power domain provided, I
> would move it to power with rest of power domains. Also rename the node
> name to power-controller or power-domain.

The hardware block can be accessed from the CPU directly, skipping
the microcontroller (although that is undesirable and the only "real" use
for it I can think about is someone trying to get rid of a blob).

I can add clock/reset-cells to describe the hardware accurately, but
the Linux driver(s - this is a block that exists on many >=2024 SoCs as
you may imagine) will continue to only provide a single power domain.
With that, I think clock/ makes sense, as this is essentially the same
hardware template as other instances of QCOM_*CC

Konrad

