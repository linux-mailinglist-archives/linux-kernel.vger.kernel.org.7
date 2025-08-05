Return-Path: <linux-kernel+bounces-756393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E061B1B374
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117B4188C725
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA05926CE30;
	Tue,  5 Aug 2025 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SS92I8lU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EED374C4
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 12:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754397062; cv=none; b=G9guDbJKQqrG8H1iDSfnd+mlAB//FLR891EuxvVatnWRp74LOLk1Q07VEJ+DzWKc4K7N6GukoKKTAzqK8INtGESeKueBhhd92HRE9gy86cQ/igfaHCobPQgFYn1O0zFJ7dl4Ww4Th+RS/ZBjmas0ehcxR3nrwH40yLtMiAm3R/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754397062; c=relaxed/simple;
	bh=QcRSA3ObR5miAp51l5eibI2C+rqXlRUN/sFaHZCntdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GgaV45aSNC3VdTJr1rW5AcnbySjFZ5namPxIMppFnkBw5AOBV5yXS5iXs/QmM1mvxHo1gegUiSbXJ4JMXi0pOmP0rZGTZniHM1983OeFB3Nca1RJLuK6lRl/K+vciaJApAwVonvP9CXFSw7nO0302xmWRNuYt4bPedWfDMq296g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SS92I8lU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575AKTh9017446
	for <linux-kernel@vger.kernel.org>; Tue, 5 Aug 2025 12:31:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s3le+/lRo6lFhwerueafNlEHaf5TdAoJ7u8vQoJNvQ8=; b=SS92I8lU9d0zXZtg
	RJECfIhtV2GhFJG/FsrlurugPbzRKZ405XKz/BWvRpRA56QqFMIMF67KXbolHmvR
	Ef3K5F/zFmkLVBt8fqJ3KAmwMpKo28CR2RxTS/pLmzVMYNl2xmIGqYJbpz/6TY48
	HuHot+MnS8zqWQzc05ZvIUlzbMU9/UXJPYFK5PAB9ujTIpwFepIACUT1Fpyacwjr
	M2xO+DiH7DSB2JO9eu8ZRe2GYbdmIa95AXOUv1nk8oPyqetdr4qLAmw7/vjHsiFL
	CC/pcSs+6hSm0YrXZKhlnjg+WFhvEo5zSoWIn9wLaR0uBpJSWmxWcQsIQGBv26wR
	A4kE+A==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48aqyv4pmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 12:30:59 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70778c8179eso9882756d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 05:30:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754397058; x=1755001858;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s3le+/lRo6lFhwerueafNlEHaf5TdAoJ7u8vQoJNvQ8=;
        b=QMO6lraOPugDZvgA1Udigy0uMXLdslFfyZ0KPJbA/tjupIUPxlx/F+c0syuZ93BZ6e
         ocE1dYkB3mU++w0WC+uTX0sdFZBrXbiEK3bFbtYqumm/6aKeXJ5vEkyiw2t2f522fuNC
         OlmhWd6L8bZ2cAYpybHMumALSWWLlJ+pHFEzjINA3Dofx3fdmr5BCTcjtDJam6ZOGWNd
         MEFTH+EbK8dRtZ5lRXcgQyxBuQ/H2gc0NNt8KCFSMjvCBzieiKOsDr2YEvFRG/0Hor+w
         2zyEmGssFSfoLlEPxSRWY63N2dtuAIErATxWjFBIZcu6bk+iHY7KQFQEdd0KsInRLt6w
         n/eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI8VtJWCU+m+BlFjnYJt5uomIPwKQzGovC2R7wyf5hCrqSETc1x88JqTu3oU1ZbRSFyc3JkIiePlngmlI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5XSH/fQOvBlmyK0EUZg/IXLk1MEfM9fnqnEBhxmHg3rLlYOXF
	A4ef9qV+MIy9OyDOTqKwo53zxGF8OTWBKWnroFQmLBT9W4M5tOmZ47H/9603VfeJZmN7l+NaSk8
	F7ynPBbOKokBUklZMpe+hDdU9RQwaeKLkwFDi+NcFV7x94L8NP+AyUmFp3UYzeXULwFU=
X-Gm-Gg: ASbGncubUxxKFAjVJ6ZEC56vVh/ca09+uxnUp5ldCOwTtIEnrTKOnFU+jxSZfpNIITz
	XmAnHHSRFqKcXI6YMCh7+eoTH/hZc6n9wBBsBQCtbuMFV0AJtZ0g8MJd8tTPWKsOi2Cmzpopo+X
	F+cfyt+YZlnUsnRSduz0s9WTRchPaJ+xnRMqUzuSUT0v1u4NF8hrgPZ16fY1yPuLqkGdJIbM7gY
	vfJpX/22oFZUBNo7Y1ouG1BhrBD+OUxZVu9JNZoEjIyOVuN3jRusbQ5p91L8kTWAsTYFAQSb4pi
	9XTFbLLtve9adgbPo1sTBcLFGCak70mDQ2psAK+3BT6SIxwDNbnL6CVNSt8fG/ipnxZnDeUujRd
	sNV9bd37bjqEt45a6Mw==
X-Received: by 2002:a05:622a:5cb:b0:4ae:73dc:3896 with SMTP id d75a77b69052e-4af10a82fd9mr86977341cf.12.1754397058498;
        Tue, 05 Aug 2025 05:30:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjPK46kGEs3pc1RDAynXgcof2Ji8nE/G9nnh49KnsMRv34OIW/Bz1yjYcoLC3FvpS5If86WA==
X-Received: by 2002:a05:622a:5cb:b0:4ae:73dc:3896 with SMTP id d75a77b69052e-4af10a82fd9mr86977001cf.12.1754397057886;
        Tue, 05 Aug 2025 05:30:57 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c0afsm903708166b.117.2025.08.05.05.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 05:30:56 -0700 (PDT)
Message-ID: <7fddb531-51a5-4ee3-9626-3e59f1dac364@oss.qualcomm.com>
Date: Tue, 5 Aug 2025 14:30:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] arm64: dts: qcom: qcs8300: add display dt nodes
 for MDSS, DPU, DisplayPort and eDP PHY
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Yongxing Mou <quic_yongmou@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250730-dts_qcs8300-v4-0-5e2dd12ddf6d@quicinc.com>
 <20250730-dts_qcs8300-v4-1-5e2dd12ddf6d@quicinc.com>
 <f3aeacf5-f178-4e61-b34a-60353f89daae@oss.qualcomm.com>
 <d6559256-81e7-475f-b91f-04ae237a92f1@quicinc.com>
 <a4b2a06c-31c5-427c-a618-1f1c3704781f@oss.qualcomm.com>
 <mj6hqitpp5nsmixo7udhbe7pbcr4qctbebhyvqtmamevq7zm5s@q7tpzaggabhn>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <mj6hqitpp5nsmixo7udhbe7pbcr4qctbebhyvqtmamevq7zm5s@q7tpzaggabhn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dFVr5SMMxuf29Clqr5eT8XlNN0Nc3Y8d
X-Authority-Analysis: v=2.4 cv=F/xXdrhN c=1 sm=1 tr=0 ts=6891f983 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=c-rZqItlf4WWe7PyqWgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: dFVr5SMMxuf29Clqr5eT8XlNN0Nc3Y8d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA5MCBTYWx0ZWRfX83UJCEeM+J1A
 jNzDFP3Jdozs/GHvkq4tYrdzr1ggjLAMNSVVlF6j3ViiTqYTJpmZ2mDXf9E5vorE5J1+HNrhk6Y
 1S6hQuaEaeDNG7lv6djMuFeHuW0O3IOlPXluNy7zi0FQtiO4XcUo8nDjx2C/iVk8WsWduBhyXWj
 ebrpn2JGzxoXnbS6BQPhjaZ2+EjYQDI9g5rrHinxwRoBHttttQVUX5SVSCsYNsXBYSmg5nmDIus
 RbFiT/rWhEvU7LDJU7Iiyb7GzkdOBr0Ed7yeLZMqetW7RRdeKCm++odsMtuDDhDrfzXhtkEo9tm
 ajyL9dNyTjz+sqGLBTn6acddhhKxB1kBa9RUcYY08JWAEUbh+WlZhCcnVtNyemJY2gyVj7ojR7m
 n/er/3aEuEUu1SuJToF8NyFYjCPLjH/qTdToWoHSio1gYIgFz8fsUE269g02AEmdZc8WxgqW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 clxscore=1015 mlxlogscore=832 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508050090

On 8/5/25 7:15 AM, Dmitry Baryshkov wrote:
> On Mon, Aug 04, 2025 at 02:34:56PM +0200, Konrad Dybcio wrote:
>> On 8/4/25 6:39 AM, Yongxing Mou wrote:
>>>
>>>
>>> On 2025/7/30 18:25, Konrad Dybcio wrote:
>>>> On 7/30/25 11:49 AM, Yongxing Mou wrote:
>>>>> Add devicetree changes to enable MDSS display-subsystem,
>>>>> display-controller(DPU), DisplayPort controller and eDP PHY for
>>>>> Qualcomm QCS8300 platform.
>>>>>
>>>>> Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
>>>>> ---
>>>>
>>>> [...]
>>>>
>>>>> +
>>>>> +                assigned-clocks = <&dispcc MDSS_DISP_CC_MDSS_VSYNC_CLK>;
>>>>> +                assigned-clock-rates = <19200000>;
>>>>
>>>> is this necessary?
>>>>
>>> Emm, i try to remove assigned-clocks and assigned-clock-rates here, device can still work.. here we just want to keep consistent with sa8775p.
>>
>> Dmitry, do you remember whether this is some relic of the past that
>> was required at one point?
> 
> I think it was necessary for old platforms (MSM8916, MSM8939, MSM8953,
> APQ8084, MSM8974, MSM8992/94, MSM8996, MSM8998, SDM630/660), which can
> source vsync_clk_src either from the XO or from the GPLL / MMPLL.

The RCG has more than one input, but the Linux driver (checked about
half of the ones you listed) only lists the XO-derived frequency so I'm
not sure it was ever *really* an issue

Konrad

