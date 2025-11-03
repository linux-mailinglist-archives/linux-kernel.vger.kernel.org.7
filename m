Return-Path: <linux-kernel+bounces-882792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 857E9C2B836
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 12:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFF254F4E41
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 11:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8977D303A35;
	Mon,  3 Nov 2025 11:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HTFTJTyj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YdZBY49r"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14720302141
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 11:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762170279; cv=none; b=pwszx+gBtnwEcorKLXSCKHYVfdCzKu5J+S0Vo7g1wabekb2TKe4zWKgn3ucCMUUyUCs8AFHYlUqTf43ceHVjq97VnoF6U1czFrPy1kr8CZa4XW6SMWfMyG75gtJeswiTUTvOowPrqyxr9LVZnwmcKlUWSg1O+/RuT64Kn2xPSLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762170279; c=relaxed/simple;
	bh=rYQmWo6untjuQnk65ZXCDd7qRmOrWGj40uijeGuIyAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pb4oXhud6gC8yvR5zQbSHiJ5q1UnUI77DKMn0gqNPT/K7pH8l47gcRNfWIbHwFAhd34tBBjZ1S/OHwm/2C7ft3mS0pvpxu2NbAN9hTxCceBti5mKqmAWkmzmbm/qkHre7k1lRl+HHuu12xgdIupNCzvgqYf+Lwa/YNFVu/icPAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HTFTJTyj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YdZBY49r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3B7ZA32984015
	for <linux-kernel@vger.kernel.org>; Mon, 3 Nov 2025 11:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YvOf+kp0ZdmTGQTGoezpj45yRTsjMynuJPHhSZjrogk=; b=HTFTJTyjdyo/guLM
	WX2vhQ8wZOIyFsXCe36gsy0kBRphrIR62eb+610H9EB0TpCX8aYS5LqQynP6PtJ/
	6v+T8yCOh51+nVYc+9+fyonlatXL5oZtPb5+QNDkR+KcVdeY4cDJ9z3ZRmOo4UPq
	ZSx8rk9SRhZ3XWifvdQ2otIH7ayKm/JmEkSY2KsrCUT+z2IuWHB71WJaZjm9zUFZ
	lc0VSywiqw7rv9DgUol3LcQ1PHggRN+37CxwNJYlaN7OaXZDAg3avUFpAfqdaW61
	/UA7nBFmgSyZKTwAj136tyNbR5RcHBgA4TtkrGS2Ro7hi5iLxAI/Xy9EIi0RzGIC
	A5Y6qQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6u8b037q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 11:44:35 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e56b12ea56so12246671cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 03:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762170275; x=1762775075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YvOf+kp0ZdmTGQTGoezpj45yRTsjMynuJPHhSZjrogk=;
        b=YdZBY49rjSFkC9TPN4loBWI6UrKb+1rqRmbHBKgYmqKdOOR6lO4JhAmNsobCCPntTl
         z4BFanUdcCIPLb3kVTQK3nTAvOptLAcmVwxsdMJZoZIwum7th6vYoJkMqxB41m9MO0J/
         fmP/8hRF3Kq9UtMwSQPof4HvS/gwjhq3O6zMt8g2X1iqAksZ0kcHTXx1XVrpc5H+0tdy
         e5dkeXqPNpmF/QllJxbG73bpK9HrW4TcpJgNLJe18RSKyG9f9tXH33z9fiaSYwugF/A7
         w/cHNjB4hFd6/jHijeTU/vjE6lqPScYTRKeTVeJ2/d/MZSKLkezIuLRhQh8sL5dDiJZe
         gpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762170275; x=1762775075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YvOf+kp0ZdmTGQTGoezpj45yRTsjMynuJPHhSZjrogk=;
        b=LNpNjGXDDfYzqHncBrXtojPNghHeiS73AsNXw58JLEzrSKi4BQjgQTfKw7w+3ALHgz
         sRxXnm+E/OxCX0ZHZoUs95zFTNc0N4vNCwTVt6FLRuTEegY+tj/bEMZ1IcXq97XTe4BM
         wfyGFu9PuutLdFzvqPM/sQA3dk12pR83gix+W9Aw49U7hkKKlyx6TX79VDbbvhUDPEnd
         mvTc8VtfLRzNY9jylcvjIMG6rjtkEjQ4kypa006GU+ZwSWnfjcUQjC5qieDy4rljOHNc
         TgbSC7P3YQ+U5XQ6IH6NqXFdHpUSj5rLdG2BOMARUSFMpOycjk0gTrfsryfn4/rLqA95
         DdvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzsKPC+wevNOUnTaKHQi6RmjRHkEaa70ljFL9PfMX0RBbJGFH4BjiZuM5aM4c1xLNoxnN4fO6bzmKw6js=@vger.kernel.org
X-Gm-Message-State: AOJu0YziuRrgJOoeIqwtaKZP3L2H++8DVDoaBuiACCVngnz/u6j7DT7C
	SubRStgXmdblBoP4tZFXGezVsNRBmk/Wz9clG6uzVgV8p8FiEUIVDYVs4sECviqxowSaBmeK/YE
	CJQ4lR8fqWPPUbzPavhi3rPEoDB8zXdzVRN+pLA3GjSrcHhUx+8Hu9jgy5f9zgRc672Y=
X-Gm-Gg: ASbGncul+Zw0XzZ3JTmygXFm6kE9yjoMViwpuqUJtETsgt/zZXQONnXqipiLe2jfcBv
	jQSeOVlLYVEUgy3LcAqk6fl9o7uLwhSzKqyB4wtEz8iMEw1i39HDeTK5p8pwgxmCkX2z65/NUpS
	Any/gp9rJ2yYPMeBFuYesSCO6bAR5PRKwirxRinhbxJnmPcgTNhNwJ8E0b/cJ2OBBWeOk3ElLeB
	F4SPIzvpR8auEsfNYPvf5M8HNRHEzL/QwTK+86RE2Ghpk8eTbcTdW+GLudX7sdxzRdF67BUadrh
	CqDytSl55u97Jw+xxnTZZuHHSMgaYjKeKncOey7beM6+Oyq/VKIfD+oX2gTlEWF3wXvdX5i6uVD
	SUKyiVdZMTSSLv0y+gYqgCGKwn60XDwc2Fp5+Vel57jKj5H732pGXOZTm
X-Received: by 2002:a05:622a:607:b0:4ec:f123:230a with SMTP id d75a77b69052e-4ed310020c8mr119136041cf.13.1762170275336;
        Mon, 03 Nov 2025 03:44:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnGpJTNO4VxSLqtGK2GRrVTvl345j+n/5/IOWSW5sFL9hZhQS5EOwv6lu1y5X00EWO5TIXYA==
X-Received: by 2002:a05:622a:607:b0:4ec:f123:230a with SMTP id d75a77b69052e-4ed310020c8mr119135761cf.13.1762170274838;
        Mon, 03 Nov 2025 03:44:34 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b34a808sm9435758a12.8.2025.11.03.03.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 03:44:34 -0800 (PST)
Message-ID: <ff74fd52-1191-4a0f-8c3f-1dce1830c8ea@oss.qualcomm.com>
Date: Mon, 3 Nov 2025 12:44:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] drm/msm/a6xx: Add support for Adreno 612
To: rob.clark@oss.qualcomm.com
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jie Zhang <quic_jiezh@quicinc.com>
References: <20251017-qcs615-spin-2-v1-0-0baa44f80905@oss.qualcomm.com>
 <20251017-qcs615-spin-2-v1-1-0baa44f80905@oss.qualcomm.com>
 <44ff81bf-8970-475c-a4f5-c03220bc8c3f@oss.qualcomm.com>
 <97aeb6a1-fda2-440f-b14b-2f3dbc2d7e8e@oss.qualcomm.com>
 <5e64c246-a424-42c9-b102-e1a2af579936@oss.qualcomm.com>
 <CACSVV00vwbNtH47S_BVet7uP7u9t4RY=xTBn_r3u4sS91Y7Muw@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CACSVV00vwbNtH47S_BVet7uP7u9t4RY=xTBn_r3u4sS91Y7Muw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDEwNiBTYWx0ZWRfXyXFE8h0ek46s
 7VT1fU97/by5gRPyG7r5DYV08EEMAMJiho6NFb1aaXgnamXnrKO3qra4JlPFPVcoxN4OV0nA26V
 4jH+k8MEvPPGP+QsmGL01rPQEXkPzaP6OG/jb9FPYNR4yoqGWGO/tMLMEdoWCEiUwu7lgyQdis+
 rny7IhjOEHpPR0XYm+qukX/glNwcq65GzrHlCJef/kbI+OnAqM9FNH0HeMQRAwNhWBbaIPCra2i
 XNoohmlNvVu5k9+VMxjwOpLB7cRJf8sufhXy171JYwvL6VvaD+B6aw3fzgCp3fz4InTFGNIhNfZ
 XgEf5QNNfLEsk1MDO1aNgXBPbAFrODWmQEaSqG1if20YzIt3CsBnUJvr4fCj8QhqEf2u2hgyRt1
 b6E6kvkRw38omgYWi11AZo8mOj5xNw==
X-Proofpoint-GUID: aNgrsVyV704ypfv1bKUPDVWU0JOcmPa4
X-Authority-Analysis: v=2.4 cv=Ha8ZjyE8 c=1 sm=1 tr=0 ts=690895a4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=Kgau_Mukr_2Uqyo6pRUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: aNgrsVyV704ypfv1bKUPDVWU0JOcmPa4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-11-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511030106

On 10/24/25 3:16 PM, Rob Clark wrote:
> On Fri, Oct 24, 2025 at 12:55 AM Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
>>
>> On 10/24/25 12:57 AM, Akhil P Oommen wrote:
>>> On 10/22/2025 8:43 PM, Konrad Dybcio wrote:
>>>> On 10/17/25 7:08 PM, Akhil P Oommen wrote:
>>>>> From: Jie Zhang <quic_jiezh@quicinc.com>
>>>>>
>>>>> Add support for Adreno 612 GPU found in SM6150/QCS615 chipsets.
>>>>> A612 falls under ADRENO_6XX_GEN1 family and is a cut down version
>>>>> of A615 GPU.
>>>>>
>>>>> A612 has a new IP called Reduced Graphics Management Unit or RGMU
>>>>> which is a small state machine which helps to toggle GX GDSC
>>>>> (connected to CX rail) to implement IFPC feature. It doesn't support
>>>>> any other features of a full fledged GMU like clock control, resource
>>>>> voting to rpmh etc. So we need linux clock driver support like other
>>>>> gmu-wrapper implementations to control gpu core clock and gpu GX gdsc.
>>>>> This patch skips RGMU core initialization and act more like a
>>>>> gmu-wrapper case.
>>>>>
>>>>> Co-developed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>>> Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
>>>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>>> ---
>>>>
>>>> [...]
>>>>
>>>>> @@ -350,12 +350,18 @@ static const struct a6xx_gmu_oob_bits a6xx_gmu_oob_bits[] = {
>>>>>  /* Trigger a OOB (out of band) request to the GMU */
>>>>>  int a6xx_gmu_set_oob(struct a6xx_gmu *gmu, enum a6xx_gmu_oob_state state)
>>>>>  {
>>>>> +   struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
>>>>> +   struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
>>>>>     int ret;
>>>>>     u32 val;
>>>>>     int request, ack;
>>>>>
>>>>>     WARN_ON_ONCE(!mutex_is_locked(&gmu->lock));
>>>>>
>>>>> +   /* Skip OOB calls since RGMU is not enabled */
>>>>
>>>> "RGMU doesn't handle OOB calls"
>>>
>>> Technically RGMU can handle OOB calls. But we are not initializing rgmu.
>>
>> Oh, I glossed over that..
>>
>> IIRC the reason we delayed 612 support in the past was to make sure
>> that the RGMU FW is consumed, so that runtime requirements don't
>> suddenly change one day.
>>
>> If you have no interest/way in getting it wholly supported right now,
>> can you at least make sure that the driver requests the firmware and
>> exits if it's absent?
> 
> adreno_load_gpu() calls adreno_load_fw() first thing, and will bail if
> gmu fw is missing.  (zap fw is a bit more awkward since that could
> come from dt or device table.)

Indeed you're right

Konrad

