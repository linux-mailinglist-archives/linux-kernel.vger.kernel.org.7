Return-Path: <linux-kernel+bounces-628677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF39AA60FB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 17:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023FE1BC4B94
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 15:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A44F20C482;
	Thu,  1 May 2025 15:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GIa/SO1O"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C5E204C00
	for <linux-kernel@vger.kernel.org>; Thu,  1 May 2025 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746114804; cv=none; b=PVRCUZ/ISmsugiaG6c6gFY0MYWPNTTc3njI407retqVuzO4f+fG/KdvcMasAszdVWzIY23poaEaTL/ogmXDuC/NuQBph3p29tDQehHyRVDHdd6Yy9Dm5bIv9Bmw19CDRlXPO9RZdkcUWHSRhUJRSpkTzSs6tUJjic2WkRV9NZmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746114804; c=relaxed/simple;
	bh=q47reW8pLreeZHe0vOxLJ9XDePxfsiFx/O1A7ZwA/yI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LH40tfUl36BdXNGQZwluDv5A9oYXZMnqERy1dfTUpfOASGNnhcBNGanI6qvr+Y+WBN6TisVEUtlaUsClVAmt9WgXrLZ7pS1wnewnowUqaADTKBYsW/jvIlaNd3Lbw756wPXMhiCTetD6jUOLf2O/bCkvsaYTT/PZKZHh0cyaetc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GIa/SO1O; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541D29Ik009836
	for <linux-kernel@vger.kernel.org>; Thu, 1 May 2025 15:53:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e0jMJ9FtUEXRGsb2EEzfZbnaOe4VQC+t/gPRLz2w9wc=; b=GIa/SO1OUyCaIcmV
	2ikfWvOTGD/N41J0XUg8htRQ+32zMAJlt5xgSd1pppFAQ0J0HBndSzJj+GEwkdMK
	yHgB+qnm4uesnWnNyumId93IoL/16Gt7tOqXXLQRALBycBb1GZ+CsTcSD3YI1iOX
	GociqsyQszeyYfULj+5QbqSShT2sXAkIdnaCeiZ8b/DSWWi0TBZKIFTkLTdLFT0q
	qnEiipu4VWuvutXvpor8i98ym7jHoK/JcBkzknSP2MXbtC+Pz/Z5P17RhabBGG3E
	m49ubLpEz8nFLsVkYxzIGOjrR2B5oiheHuZuX+Y9XzJWTRBsLTkzcw9YlR97WZPj
	vT+z3w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6uawnpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 01 May 2025 15:53:21 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5466ca3e9so25557185a.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 May 2025 08:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746114800; x=1746719600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e0jMJ9FtUEXRGsb2EEzfZbnaOe4VQC+t/gPRLz2w9wc=;
        b=bVU1ghkJcel6gJQzCFPd74uPAIZ1IKPb5RvN8xZJ0mOGLDCaLPlt6ofyHDoA28nmAQ
         KJ2gBlAEf+lJXZL+t6zBso0kRBRcDHtL5Eb2hVE3uxVlWdVOp66yLyOQC2LlA7C9S5j6
         5A63H+aTxGXnxJRUPBiySGcNDHGUwU5w8tKuIEhmkF+gU+DDZJhrbd+LMJENFgUgXAYw
         kksZwTHbVJRE8owPLvf1nC/hs1Usq4Oxm5RLt9sKAMk8OCECxtxQYqRbsgQIQfUwjjMG
         JdUazLwtdfb4g9itK8QXolXVXhIt2oykIZn29goEi3DIVRPc9ObXdigk2wRWIz7CJDYb
         M7kA==
X-Forwarded-Encrypted: i=1; AJvYcCW3L18Z0fSFnSNyODcvBXvu54GLMrGLxrej8E/s1gHiFDgQmqVOI4kmp014P65ZOfGTP5HtV0+3hky5Tfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNeMMxk1qsM/9uo9nipEpTQnPFX1OGz4e4IbZmX7mcHBHxdx1i
	QnndeXCAKLg+IviAYdnTwRGaonhBPUD0pW4TXGWyQQAElr4Q/6+T8WeZ+5U51Fs3TZdJxxME82Y
	EVilljdpxIPN5XFtwhs5uG0Y/CkGJIkfOdnHKv1iu3y+bB87xiq7X0ndNIbbjEho=
X-Gm-Gg: ASbGncvn+KNq8gut9p/3eSBF+TTiWUVlRJZL8waqVVPqHUDBSI8ignEmoFFKVIyCRGY
	cATqIdRy4jd+h4LhlqrpRgGDGWVYOOgQcZ/NlhrhaopjgKskqrT1sQcLRa+JlgUqemflYoQPDnL
	TFG6ioq1LpxF4ni5HlbeNQoEKUxhf7pyUmAjjIGhhp7d7q/Y/qRkg1lVLedGAEfaf7TbOernbOH
	xkS9giv+5nSHR9ys4Z34SV+VucxWDlAQn72Dm6odx3b36iCDKAX2c/3vXsBWErG5Rzur3wpI//e
	9zPCc0PQDPxgBL20jBsU2kn0ezoXv8XxNWb7mQ9HOtaFU5JTnFoyMLvHhMPVxXi8+ro=
X-Received: by 2002:a05:620a:40cf:b0:7c3:d3a0:578d with SMTP id af79cd13be357-7cac88397b7mr412121885a.14.1746114800355;
        Thu, 01 May 2025 08:53:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjkDWZYxp5ISUoJ4Ti9lg9jEL3XcSgYQbAqGImU3wp6ixHLFW+pV+VENpXRoH9ZN2mgChWRA==
X-Received: by 2002:a05:620a:40cf:b0:7c3:d3a0:578d with SMTP id af79cd13be357-7cac88397b7mr412119785a.14.1746114800013;
        Thu, 01 May 2025 08:53:20 -0700 (PDT)
Received: from [192.168.65.219] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad0c7122a5esm57713366b.86.2025.05.01.08.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 May 2025 08:53:19 -0700 (PDT)
Message-ID: <d73c6151-91bb-4c96-ad2a-972ad392624b@oss.qualcomm.com>
Date: Thu, 1 May 2025 17:53:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT v6 2/5] drm/msm/adreno: Add speedbin data for SM8550 /
 A740
To: Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        neil.armstrong@linaro.org
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, David Airlie <airlied@gmail.com>,
        Simona Vetter <simona@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
References: <20250430-topic-smem_speedbin_respin-v6-0-954ff66061cf@oss.qualcomm.com>
 <20250430-topic-smem_speedbin_respin-v6-2-954ff66061cf@oss.qualcomm.com>
 <13cd20c6-f758-45ff-82d1-4fd663d1698c@linaro.org>
 <886d979d-c513-4ab8-829e-4a885953079a@oss.qualcomm.com>
 <b838f9bd-0537-4f8d-b24b-d96700d566c8@linaro.org>
 <98a4ad20-c141-4280-801e-015dafd1fb39@oss.qualcomm.com>
 <a26213ec-808f-4edf-bb0d-ab469ee0a884@linaro.org>
 <281ab1b6-498e-4b29-9e15-19b5aae25342@oss.qualcomm.com>
 <63105bce-6b8e-4b99-bca1-3741f27ea25a@linaro.org>
 <892fc1eb-efd3-4fb6-9110-2df3349960a6@oss.qualcomm.com>
 <b989522d-bd41-4d76-91a9-3cf680214003@linaro.org>
 <f5734944-1ed2-4acc-a015-0c638c331bbe@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <f5734944-1ed2-4acc-a015-0c638c331bbe@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 38e8pPY2I6mRswtiOvjDFSeJOYrobP7L
X-Authority-Analysis: v=2.4 cv=KtlN2XWN c=1 sm=1 tr=0 ts=681398f1 cx=c_pps a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=KKAkSRfTAAAA:8 a=-MVukwTEXeiimiWxaQcA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 38e8pPY2I6mRswtiOvjDFSeJOYrobP7L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDEyMCBTYWx0ZWRfX+1andj4DQsGv sxuRRrQ3z+6lsy9HlRRHLgErHCZHDAucQ0pooazsNceU6zk19OC3wSpk3lct5cgT2yzTm5OE0Qt 19DCAcWECvoh5EbgmmOvaibNJO5cJZC4aM2aOpuhQ69YRtb+XxT0afbjN7rtCceVLMA4rrVOcqC
 mZLnFJndEBDsDZmorMKCXB0SlsYWmQkRJ6r6bwB9JE5KGG3gfYs3sA4TKUJhtlmtqfnQrU3jp4s aOfxvmgiFmMka/l23OCtUSAAuN7A+gahmkHYTJT7/bBi12EArT6//1M9sJc3b/RorGYHJr11W3/ MvIjGckGAihJOpt8Ze88pTxhW5e+pBcmQ9TP/+YYJp/OyssgpQs51E1tyA8EuzK01fzGeZA3ve3
 bjfk+CNeNOtQ8B9iO3N0jgUcnyGHS9gnp+WTeXSN/ULbXiJZFQ7Zvscbk44+ht9o1k3tDDzq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=694 spamscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505010120

On 5/1/25 11:29 AM, Akhil P Oommen wrote:
> On 4/30/2025 10:26 PM, neil.armstrong@linaro.org wrote:
>> On 30/04/2025 18:39, Konrad Dybcio wrote:
>>> On 4/30/25 6:19 PM, neil.armstrong@linaro.org wrote:
>>>> On 30/04/2025 17:36, Konrad Dybcio wrote:
>>>>> On 4/30/25 4:49 PM, neil.armstrong@linaro.org wrote:
>>>>>> On 30/04/2025 15:09, Konrad Dybcio wrote:
>>>>>>> On 4/30/25 2:49 PM, neil.armstrong@linaro.org wrote:
>>>>>>>> On 30/04/2025 14:35, Konrad Dybcio wrote:
>>>>>>>>> On 4/30/25 2:26 PM, neil.armstrong@linaro.org wrote:

[...]

>> This behaves exactly as I said, so please fix it.

Eh, I was so sure I tested things correctly..

> 
> Konrad,
> 
> iirc, we discussed this in one of the earlier revision. There is a
> circular dependency between the driver change for SKU support and the dt
> change that adds supported_hw bitmask in opp-table. Only scenario it
> works is when you add these to the initial patches series of a new GPU.
> 
> It will be very useful if we can break this circular dependency.

Right. Let's start with getting that in order

Konrad

