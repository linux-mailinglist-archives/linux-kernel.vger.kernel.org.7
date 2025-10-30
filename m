Return-Path: <linux-kernel+bounces-877940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7545C1F648
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E67434E8722
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE1B34D92A;
	Thu, 30 Oct 2025 09:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SiQEN4RF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EW5Ll5sX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D6634A3B1
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817980; cv=none; b=ZqQwBeihit1/gCXMUzLN1uORrrNEz/YIGTBWpkQcsdk1IuszHmK5Md6FUqqiWy44PruUOtroclpMssXfXncoZ4Bp2NJ7JLfWaZVBV1Yq8YNYRxRzc8iuwuLBmCb888SwFy/2aXoCuoNoDIx1rFyjffOUSDd2Qf/wWjVvwrR3QG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817980; c=relaxed/simple;
	bh=FlrkaRoQxudA8Iqh8NIum21kvoD9XsF6BxhBChsHk4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTEafpN/BTIJgb1xD/ZLohNWHAy14C8N9WLu89WrJOJ7jcOA+exWEhPVA4FUVETtGjZfFu2hB929C7ts3wYNmbEZVyLZw8WSc6TfO0l2Ky9DgU095Cy0BDwkPax20qDBNdENnlIR0vx5oIpeDPocMHttJYd/FLjWNS1DzukPF1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SiQEN4RF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EW5Ll5sX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U9PDTF3508734
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:52:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v7Q8Gm4q1rlF4zxFf+h3/o0rNZAjE7F9daCHt68XXws=; b=SiQEN4RF9xbpJ1w9
	ooeOXGozPjTyHk/CPlMcm1ta05F+QIx2DzgNqWZYlDpcCjRqAqGcy+dyftb+Nyp0
	aDHX6W+XeNsxr+B/loSsfqhe5mUUGb+5xkc2hmKgkRtfYZgU7UlsUzS9ywvBEz69
	YrZFHq1IYQMGfQ1lUi9YO+b4qKPSm7qJU5x8oTZp3PwPrBWWC/DjSZxtXIGjnIHU
	uJnNykCqajYoLlHjuGuensKCBZS0mXYeTkSG8pZqRiamm9usd/v/mtFvythb6EiY
	pKe/A0+VwZq3h45hlMfV9bvbsdCT/WpYpBK2RA9n5SzNjuOpGh1y1vmatxvXQ7xZ
	S9DOkA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a45cdg36h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:52:58 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-826b30ed087so2472176d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761817977; x=1762422777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v7Q8Gm4q1rlF4zxFf+h3/o0rNZAjE7F9daCHt68XXws=;
        b=EW5Ll5sXNoWqxgksu5WyjLKMIQm/2AF5iKIQJijyW6FwRZnYREuN2aaqONLwbRQlU/
         jfA/JiWAiVjTctfys48aZi/A5DxSGZ2RdojILikDPl3D4XEAQWub0f+h3FDHgIajrTLV
         ezHOgv5Q5AnKYyYfSdGShBJAaNE1Pywam9z9oHRIaatv8MINej0MNmu4l2nYfrqqjijh
         oni13RXcLdsip9zSPcsOvjw0I8TbDZtn97kNqRnIrV4O8Jcf4zOp30xLyoxGKX4qZvR0
         DDa6yNnxFOB+TkOgr+xz1Xjw+UfKWomqYlDCtoYWs6BQsuvb664T5HSbP5k8ze7qsERV
         gawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761817977; x=1762422777;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v7Q8Gm4q1rlF4zxFf+h3/o0rNZAjE7F9daCHt68XXws=;
        b=WdzeOUFGKAmooly/eEg3+tax5Zl8r2W4HExwjAHYcXMyHL0tjIbBFrBTc1xaqZmDHY
         DeCiZYTK5w8uPSB9vkVMCSISlAL3b3LO1UAePtaiq1/knFXv/5UzmsIX1mwPksEpXSed
         KOlA3jk8km+qi6AEwXFEX8OcJkhKRwyp6SKP4cyEIOfoA1YMIYP7qR5f++G34XDYYpjw
         04npAsR3GYG1WcB+GYwltX4gr+UE3duZVCpuTOCLGeYu0zg4WMfVwwNriuzLmhmCRZaO
         bM3e5Q2Tnh4LGt2KBu9wwjTAin2SzFvtY4vjfMdXiby8Q16Q33ry01i12BTuvHkbdVfU
         rObA==
X-Forwarded-Encrypted: i=1; AJvYcCXk9QKmlq66nZFusMLhFyBQe9NegRoIeLXP/NNdJOnAmw2BdBnWTfWFG1dbwj981KDRsK6OjKKCDRsQQzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzNMpy32zMOTh7p/FGG/fS+aAyyFUIEdTHbCPycSagPrX6iGMp
	PD6ry/7BhRyrJJxp9/T57nd/gmdQiE7sbYTrL0G/nh708nwQll+nzhzZ1KWXwCQTYSEfYQ7NxEQ
	kNE4nzkmHgtDb1YocRZwcJM/lrJWeUGJB6PoilImYgc0jCvSErXTgRgXDWlwTgm0ujGI=
X-Gm-Gg: ASbGncspUXX8+p6ifTJiNAbjXauv4g1QteeXChFbHmIAvJNw0JUWCqVnepwn3/xfW1x
	Kw49TCd3FwX8linI+FgqWY9wCkjaYpmA0+V3W9kh+/or0Y/Ve5SQJG2d/l96Oil/cYExQkb3jWK
	7nEZWK0rWMbR0bmCZ4TwK50fnmEHh6grbJli5kmwCUnTSjW2xoXsplNnYwYPUAUKtw6kDqYeXoD
	3ONLhnaTR2qXJwpNS6TrW+84pWaoqKSTtpnnLQH5bhSSxEds+mtgdsNQVOsNhA1vZ23vAp8+Qb0
	XsYn2baSml7kyjykWcuES8i31CGY5oIyawdec8uHC2PcLnYPJVbGy+3l9AFkVOAR8Boby7W/SfS
	gqbtaP7g3aupMg6cU1x6c3LnAS/JsQ07d60Nhlp2cs+n76x7XcALVWqH8
X-Received: by 2002:a05:6214:c6c:b0:815:e14a:1f44 with SMTP id 6a1803df08f44-880099ac8d8mr52250826d6.0.1761817977019;
        Thu, 30 Oct 2025 02:52:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPEnRfdgeY9SqFksQVxRyzlmk8WoSCfnN23Yxc6FUxQBSZpZ7uQW7zVih/5H4U1d6Rw4R1pg==
X-Received: by 2002:a05:6214:c6c:b0:815:e14a:1f44 with SMTP id 6a1803df08f44-880099ac8d8mr52250596d6.0.1761817976393;
        Thu, 30 Oct 2025 02:52:56 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640342e5acesm6138757a12.28.2025.10.30.02.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 02:52:55 -0700 (PDT)
Message-ID: <a15e8316-96cb-452d-b2b8-731eeb6d25d3@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 10:52:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC RFT] drm/msm: adreno: attach the GMU device to a
 driver
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20251022-topic-adreno-attach-gmu-to-driver-v1-1-999037f7c83e@linaro.org>
 <5d6e7303-cc57-4a50-a9ad-b45d3c89d045@oss.qualcomm.com>
 <25e829f8-60b2-4b69-8d57-ded846b5206a@linaro.org>
 <c79c55fb-3aaa-4256-a71b-fa86cd0166f7@oss.qualcomm.com>
 <bed92353-da4e-4447-97d2-10e8a333e4e0@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <bed92353-da4e-4447-97d2-10e8a333e4e0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: cXDDmlh30xmmLwpCNdZOTVY1ynfXTiF_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA4MCBTYWx0ZWRfXwfQxJiA3jdUG
 zAN1AzYIE0ED/RwidbJlrOSglGZUKmvqJRpe7S6qljKdDk31YjrFo27MbR/0nzKTbIxJ8atyClh
 tMGHV+D4zwMCbDgs5wfOpWTkhbrx7LguIB6dQlPvFEE1uy/6YrVEzdbR2ftG+v5TSgCuSUl0Kr0
 xPqL10aMb236aSqdbCjfhJG9hUzfhmvITZAkBpiqfSnwXMx9HFsxDk4gMm5kX3eSX1/9NjYwHRk
 Cw5nazcFiIqTAbqzPS4Dleu2wlzAc9czhJEmSIsiT59akglUE6dLbc7IzLvTTmjiKIS0BY7XOEM
 sk5wtBwWaFIw3xrCrq4o+7dA7s0rdsM7KnvoerPoHNjlt4epEWJS5kkDzfoWA+ih6GG/55T8mdS
 bFAQ6nN2wwbvyUz+A5Z30l05lXIPUw==
X-Proofpoint-ORIG-GUID: cXDDmlh30xmmLwpCNdZOTVY1ynfXTiF_
X-Authority-Analysis: v=2.4 cv=ItUTsb/g c=1 sm=1 tr=0 ts=6903357a cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=M5-gK5ubkblMbbE14A4A:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300080

On 10/24/25 11:11 AM, Neil Armstrong wrote:
> On 10/24/25 10:55, Konrad Dybcio wrote:
>> On 10/23/25 10:27 AM, Neil Armstrong wrote:
>>> On 10/22/25 19:09, Konrad Dybcio wrote:
>>>> On 10/22/25 2:44 PM, Neil Armstrong wrote:
>>>>> Due to the sync_state is enabled by default in pmdomain & CCF since v6.17,
>>>>> the GCC and GPUCC sync_state would stay pending, leaving the resources in
>>>>> full performance:
>>>>> gcc-x1e80100 100000.clock-controller: sync_state() pending due to 3d6a000.gmu
>>>>> gpucc-x1e80100 3d90000.clock-controller: sync_state() pending due to 3d6a000.gmu
>>>>
>>>> Does this *actually* cause any harm, by the way?
>>>
>>> ?
>>>
>>>>
>>>> For example on x1e, GMU refers to 2 GPU_CC GDSCs, GPU_CC refers
>>>> to a pair of GCC clocks and GCC refers to VDD_CX
>>>>
>>>> and I see these prints, yet:
>>>>
>>>> /sys/kernel/debug/pm_genpd/gpu_cx_gdsc/current_state:off-0
>>>> /sys/kernel/debug/pm_genpd/gpu_gx_gdsc/current_state:off-0
>>>>
>>>> /sys/kernel/debug/pm_genpd/cx/current_state:on
>>>> /sys/kernel/debug/pm_genpd/cx/perf_state:256 # because of USB3 votes
>>>>
>>>> I'm not super sure where that sync_state comes from either (maybe
>>>> dev_set_drv_sync_state in pmdomain/core?)
>>>
>>> The way we handle the GMU so far is wrong, it abuses the driver model.
>>>
>>> And this is a symptom, whatever the impact it has, it needs to be fixed
>>> in a proper way.
>>>
>>> The sync_state is retained because the gmu device is never probed but
>>> has some clocks and power domains attached to it, which is clearly wrong.
>>
>> Yes I agree, however I'm only debating the commit message claims of
>> 'leaving the resources in full performance', which doesn't seem to be
>> true
> 
> OK so the wording may be a little bit extreme, perhaps something like:
> the GCC and GPUCC sync_state would stay pending, leaving the unused
> power domains enabled for the lifetime of the system.

The debugfs reads above suggest this is actually not happening

Konrad

