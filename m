Return-Path: <linux-kernel+bounces-875641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCF5C197D6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB06405BA0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0A5301037;
	Wed, 29 Oct 2025 09:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nO/CMfSu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bJOyBa7U"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C112C1D63EF
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731321; cv=none; b=RzUNugezRlq/t9QfTOmQ5KcwSAChMBRUDFucrxBCBBKFX+uqlAZdeIA9EI0Ozvkf20yN5gx+6tES5LzOuSNXNylyb7aRo0qnuoYW+cYkSmhhFB/IwKMl+lSIhWQfy4TRwrGLRIJgyH70AlOcDUcMuOSnhoJiiM4W67WXblmW8/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731321; c=relaxed/simple;
	bh=mSRviZJT8nrfv6oBTvNwoSXnVUlvfTZTNBlekRcUmq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lIK5I5qoe8b0Ngufbfe5ZJjFCzMA79oy3TKkDvjMK4+YfzF+TAi8N7RfuFGUMOBJZZoIGPp0jKt7fEzIa2w0ldp3pBa5U+k/MY1rnHgIWHxDcLdzPxI+TEigpmnJkTbZ2Y1vTj9iShYkwtlsdVHgS9LZQJfCji2VDEIxrn5xTVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nO/CMfSu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bJOyBa7U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4v0r13664616
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NXDJ/8mR0gw8cqrsb4EfbpEgu/FMCndzU0gyJwlxJA0=; b=nO/CMfSuJgXwZrsB
	YE+XH/1kPNG8FZ5xCpIE6LmWig76BSInQpp0cgV5alWrfp/5Wuuw1FXPBSwadAcr
	STCYgJbM8MAze1N/XVAjYSHHZn72PgbHkKrX06XB1rZaB8vLC0kclkOq29RhH9jp
	bOoZM4CkvHPzZfJYJruybBCPvDOVh1Vq8V7jvsljdmjNnzr0WDrPV+Ua6uHJ5tgy
	iZMNKcDbX7RsbEgsrMI6Ub4nd1a8Uj4ovZ0GM6RLFYIUs+ekSi6euimzvRUsC4so
	VicIKSzmvDWl7awoLeGR4TOjw74n7GiVfxIv5BZ2LLcsWp/juN7uHyxY3ExWYdGR
	QPKF/A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a3t2jt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:48:39 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4eb9cfa1b72so17420971cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761731318; x=1762336118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NXDJ/8mR0gw8cqrsb4EfbpEgu/FMCndzU0gyJwlxJA0=;
        b=bJOyBa7UlumeEP2844E4+c9faKK7Edxe/2g4A9DE+sVuUaYW2pY/PTlL3Ycv36oO8z
         ubtQT6c5YpISvgvVYDDjcyqrYFCnlnEbeQ/EDfsi5PkG2CamMFxGuhaq6qVVjLGANThc
         DfHWQUlry0qHE5i3N2Q+6FHfbnPL9pnreKplaogj1JCLS3fE+ITUd/UI5dlx13cEHGhU
         /ws330l8V2Qi3Db3G9oISB9cumPYwK0PD2AIyQUWf41QzrjmDT7usEiXXSqNx51vz2qg
         8+VEdg7k22nUgGEK0ZcSycyZfMwzHfoIGI3TTLq5iXVWu4bAeFdiDZHM85hYoOAxoiw1
         Bv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761731318; x=1762336118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NXDJ/8mR0gw8cqrsb4EfbpEgu/FMCndzU0gyJwlxJA0=;
        b=lCkZnpwhJ52amD2Io833QJ6bFWSMtCkyVO79P96IubvwITSSHbSHjUj0LexggMP/7B
         Kldu8bI/LghyZUDqRbD7xUi0b7GlWC4Jcbiz6+mO0w7ShaNl9OtfbJZv4Ofz2ymjn8bK
         nYeGQBeeiPD7gUjccDIGV+kAFqNoTzbMa+lTZA5SzVlutFHGmlTRksfjho7koeCbCbBE
         +5nM8y6Ld0XSkghsiJxStv1RmaudL8/SdBlRJNBA1UF1ep6M18wL9bXMaslUk6P2rUC0
         bNgm377cp69H4ReBeu2O6itUyjxOinQoVfqali2Gm2sZTsgV25Po5qLbVlomWl3QaCIr
         ZfPw==
X-Forwarded-Encrypted: i=1; AJvYcCURMomi8dnTqiSIuF5K2nr/L6zciXeQN6YMFEHtCYLMipP5WVGk0TX1qJKlxApXAlboCPxIZlgDIpfCjLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd+vNVAGXUew4bgJAWSXuwapDUY8MTGhl6j/sFb9vUDcuvxNQ0
	vtJYqtoahCXwPsDCBZ4eUHThdXrsNckwjnJQJlwgA53B74ythUIP9Esv8bSHbuvqkZd3zzWEThK
	WGTc7AcgBhEM1j97OSvYj4btIgfXqus0hFYqZBYEt7sOGf8ykPO+6Ck4yG5jIyroPwhk=
X-Gm-Gg: ASbGncs1GOIur2V0hP+5h4encIFi8uG1Ksw1q7JaNPlcUsxjqU6E2huP7iU/PSQLVPi
	a5WEQX/f2AJNaB3ivlbdKTYcyJ2iBNPQ3FD2qGsFdaMRt3FWwWqSDnzclAFQ8yARH1s3elKXASH
	krxgevdRvBvQvWhbu6NFODQ5+reXWDjbGPx1NgZDgeUtgRsS2Ag28wGsRz0u7h/zN1xYkcuvP2W
	kfMvbnjbPNay9qhVh6WVlqVUz2Bu2dM4gDTgQTVbpDAOrt1fZZcoJlPcm4oRLfpK6b4jfD1fJfN
	hivB1HW/lZklDtdCUSMrNpsj2r34VrEWWSdxYR1UcdhPb/fjUt3z0s+7wsIT3/3WZCVvmFmtsIu
	+6VmqodkSOk1pL4ZvVzCB8km6UUzFh9ksRRZe2nHzhqUd0X/TPo3mULiF
X-Received: by 2002:a05:622a:24a:b0:4ed:7ce:8497 with SMTP id d75a77b69052e-4ed15b5b4admr21772731cf.3.1761731318138;
        Wed, 29 Oct 2025 02:48:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYOEqIUpR3rqvcOHQdFhJnl6mL7OfMUA6zGCTArqO2LmMgBKniIZv31BF5P5aE2+XJqdUc6w==
X-Received: by 2002:a05:622a:24a:b0:4ed:7ce:8497 with SMTP id d75a77b69052e-4ed15b5b4admr21772471cf.3.1761731317612;
        Wed, 29 Oct 2025 02:48:37 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6404de640fcsm757954a12.8.2025.10.29.02.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 02:48:37 -0700 (PDT)
Message-ID: <c7c26f26-4e18-4f54-8c88-69ce97345e86@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 10:48:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] drm/msm/dsi/phy: Add support for Kaanapali
To: yuanjiey <yuanjie.yang@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mkrishn@quicinc.com, jonathan@marek.ca,
        quic_khsieh@quicinc.com, neil.armstrong@linaro.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023075401.1148-2-yuanjie.yang@oss.qualcomm.com>
 <omlhiywjr46ik6bj2aiutgcf4aifen4vsvtlut7b44ayu4g4vl@zn4u3zkf6cqx>
 <ad906eb5-c08f-4b66-9e37-aaba99889ad4@oss.qualcomm.com>
 <aPryORKIuSwtXpon@yuanjiey.ap.qualcomm.com>
 <einog245dsbqtx3by2cojyzmyctk2fffpwndwoe24puwqq4fta@cu6iiidxqgr4>
 <0291d0f2-483f-48d8-8c75-f1bbcd1ab18f@oss.qualcomm.com>
 <ehgdx7av3jewowkvtsqrbnsphgxm5hryl6n5otnapi4xneldze@gcwvpssisv2x>
 <aQGHyN19/a/tl0BH@yuanjiey.ap.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aQGHyN19/a/tl0BH@yuanjiey.ap.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 5FWR5rQqz2hLBoC2PXLTF3zTRsPA2TgE
X-Authority-Analysis: v=2.4 cv=HM3O14tv c=1 sm=1 tr=0 ts=6901e2f7 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=fe0abWBLJpTHcFswpKQA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA3MyBTYWx0ZWRfXyGCbf0EJx2Pk
 b4eTrGcJVk01O/V2uzua5XGFs2bN7zJ4J3/Oq/ALVEWZpihZRG0sje8CfePBnAX7nDvVqvsmDDR
 y3odWTW213bHRrsKxVQOpmu+4dU3OoezyYSe5vwqrsGmd94DNr227y1cikRRoE6HO7Idai7IQym
 VRbrSCNmjV0st5OvAHx1otGMm3alCaqo0wSAR/mPaReVGdP5KTghuLaU7QrD0lhklK/HR8qb03y
 /JawUpPqnAvmC/NLK9+5xe27CWvyOiENhyuonyv4Mx8DJ9VKssdubiSswWGhhLAy4UyEq6Bf242
 QQoXWtigAO/QtfGaKrjjFV4Cj2S20+TmQmlsfU1PvLDIdRSXcf61szgUDzeUSnCTG1eZwQPQGyi
 lab0qgYKyRq2vNI3Fgri9mYw74nV6A==
X-Proofpoint-GUID: 5FWR5rQqz2hLBoC2PXLTF3zTRsPA2TgE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290073

On 10/29/25 4:19 AM, yuanjiey wrote:
> On Mon, Oct 27, 2025 at 03:29:40PM +0200, Dmitry Baryshkov wrote:
>> On Mon, Oct 27, 2025 at 02:20:26PM +0100, Konrad Dybcio wrote:
>>> On 10/27/25 2:14 PM, Dmitry Baryshkov wrote:
>>>> On Fri, Oct 24, 2025 at 11:27:53AM +0800, yuanjiey wrote:
>>>>> On Thu, Oct 23, 2025 at 02:02:45PM +0200, Konrad Dybcio wrote:
>>>>>> On 10/23/25 1:48 PM, Dmitry Baryshkov wrote:
>>>>>>> On Thu, Oct 23, 2025 at 03:53:50PM +0800, yuanjie yang wrote:
>>>>>>>> From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
>>>>>>>>
>>>>>>>> Add DSI PHY support for the Kaanapali platform.
>>>>>>>>
>>>>>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>>>>>> Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
>>>>>>>> ---
>>>>>>
>>>>>> [...]
>>>>>>
>>>>>>>> +	.io_start = { 0x9ac1000, 0xae97000 },
>>>>>>>
>>>>>>> These two addresses are very strange. Would you care to explain? Other
>>>>>>> than that there is no difference from SM8750 entry.
>>>>>>
>>>>>> They're correct.
>>>>>> Although they correspond to DSI_0 and DSI_2..
>>>>>>
>>>>>> Yuanjie, none of the DSI patches mention that v2.10.0 is packed with
>>>>>> new features. Please provide some more context and how that impacts
>>>>>> the hw description.
>>>>>
>>>>> Thanks for your reminder.
>>>>>
>>>>> Correct here:
>>>>> io_start = { 0x9ac1000, 0x9ac4000 }  DSI_Phy0 DSI_phy1
>>>>>
>>>>> And v2.10.0 no clearly meaningful changes compared to v2.9.0.
>>>>> just some register address change.
>>>>
>>>> Addition of DSI2 is a meaningful change, which needs to be handled both
>>>> in the core and in the DSI / DSI PHY drivers.
>>>
>>> DSI2 was introduced in 8750 already, but it was done without any
>>> fanfare..
>>>
>>> I see a diagram that shows an XBAR with inputs from DSI0 and DSI2,
>>> and an output to DSI0_PHY (same thing on kaanapali - meaning this
>>> patch is potentially wrong and should ref DSI1_PHY instead?)
>>
> Yes, I check ipcata Doc, I see DSI0\DSI0_PHY DSI1\DSI1_PHY DSI2\DSI2_PHY in Kaanapali, 
> addition of DSI2\DSI2_PHY compared to SM8650.
> 
> look like I should add: config io_start = {DSI0_PHY, DSI1_PHY, DSI2_PHY},
> 
> Do you thinks this fix is OK?

The MDSS documentation says there are only two DSI PHYs, so perhaps one
is not exactly implemented. Let's get confirmation of which one that is
and keep the two functional ones.

Konrad

