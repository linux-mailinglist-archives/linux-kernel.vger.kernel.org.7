Return-Path: <linux-kernel+bounces-773796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC139B2A9C6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11E05567B2F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7BE32252B;
	Mon, 18 Aug 2025 14:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D/UeaWEp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE8A321F4F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755526025; cv=none; b=dEwvkhxq0YBZ4qUy4ZCRnsy5Gxlv/IxLWpNTZLJnAFh06mXD9jTa3njHzI/SSF5Z7r+aYLg66Gc6tQYRZbm7yPt7sCs65HkKYDOqLhPnHdoeV6Kphy/KBgnNsaZ+4FBTx8o0RQFj0/IgXF7KdKdaEa3cXERqP5XhJg6f/J3qsck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755526025; c=relaxed/simple;
	bh=iDJR1tfwk7UFUubIp+MA5lVvSTge8acmqtK4SGQWHBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KGKE/oZl8oXflCr0B36Ddiu1G0/gCalAQ3k8wTAlhX9NU7FrIRdVadUn8T0AC5LfcTZtDABQNKVtj+V6mDT4wb84mhPAf0EjJIlCWGC04QKybhWQ3x8opqnXVXavn5dkDkvbdmcD0LU6cQqLIvpeAdPqXi5pn4NyDhQ9+KWwhaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D/UeaWEp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I8ISs1030458
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	chLwK+SsPQhHTytM+7iGONL6X0o4wGCEiPMrGgw75ts=; b=D/UeaWEpAUWr/gmE
	WZwGHoUPLUcKr79Zd51wp7wQI0dwsdSBaOAHu78btslcr/KrdR/bGGhyK46HZqo+
	d7CcZ88NvoPaijN+ZaCV8SJ4Zoj3k42YheITNwu2EepURGBWsBIFaUTcebUiIHLb
	veAudXcNEk8HxCuQxsDLGlmR4tPaVw/UrcHpJ59RwxUDMnybMAmOYjfuT2tRS3YF
	+Z7W4DKOF2aMyJ98APKMORCikS8re5V3SDR/IIxj1CzopHIGKJgRGXIXnNxACm9e
	Crv+BISMW5jApN6gq6ZqrIOVlOMeklP7vUddhJ/ES0OIpOdFZGY5XWuNmliBTg3v
	RSDmFg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jhagvx9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:07:01 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e1ff27cfaso4438823b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755526020; x=1756130820;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=chLwK+SsPQhHTytM+7iGONL6X0o4wGCEiPMrGgw75ts=;
        b=GIgDOo5K9gXktiX2FdfuLsPLKNlyaO2g6Lfiq+Qyl4/EyIFxWGf9aY81lz3x00GrAX
         mfOMqdJOuXBUfc3BdIFOdX1L+SQS04sCRyCAD8Yp9vP7Hsm51ghcx01w3KN5s6HVWS04
         9uzZshi4oavjYyXCSE003Rq+EgxUK14mYyqfBheWlLkVFmTHh7B+4768ch0a5YHUzzDT
         lThMCUmOHSa6oRpeMYo+pTqGt5R3ikYXlLTwR7QEGLx2nHl7UO8L8Ssoul6TtGFFu9HY
         vpu7xBjkl8Pqn4rU/RWgaa4CdkceBWrh4sRpv/JVnogzpSHca27KHqLQnJY8nONd5tB9
         gl9w==
X-Forwarded-Encrypted: i=1; AJvYcCXno4W+t9rd1OWP/XuizwB0oqhQ2jq8MRYvUGeIohUFOoeV6Nq8YZH1jnu9E4ZJHTmTxIMLemE5SIwd1nI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAvz8Ho3LFTRYXsFpdHiv6HxmEOpCDeLmgJiaZHPM1nqHSFqUQ
	4F+0kmh9q0Cv5GFbpp3CtVF45dCphDluXv0TX1WK9UiBsH/PWQxKvx78Z/RGgGu9mEBQ6XT3jeZ
	JcuReUVsirtvH7oj3zMKgyrbjolA5r2MTHsCj0OQRHPP6x3Pmpox/undOg5hmoa4ys9Q=
X-Gm-Gg: ASbGncvx03LnXO4DawB2aQQMrnRkHhuHe/xnttuYuN8WazcALfFujiLRxfVAK1lCAKP
	tId3OJZaGD2p8qGmYw5xO5mMxgoW+qji3juOSqzAsqOCWwk58aDTPkSUMOBALDjymQ2OdqREP0c
	zbqA0wgFZh+FmBkPdtAczOpRIhzxS7FVMfEl8Ci5kDKxQwp5QJcAxGTKNmWaHEW8aQCkfDq+3EB
	0x/tdknh9sV422XssLy+/mD59EOv1DdiYVSOdAgK5c3MdXjo70tN66zNaRCj3QQiutHuYQBsYoB
	wBhG1PI5m2dru6yxRaOjH6CpJXXws2lkJ84d9x3dY9jhVzGTzEU307s3GMyDC1Sa
X-Received: by 2002:a05:6a00:14cc:b0:736:4e14:8ec5 with SMTP id d2e1a72fcca58-76e438f0ec5mr15651398b3a.11.1755526019860;
        Mon, 18 Aug 2025 07:06:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaW5O7M2POFlUVEtIHKn+I++/iHZWm/6mA4hEC46cPlJZweEv7D5U88CqdrtLREpBxLoXmhw==
X-Received: by 2002:a05:6a00:14cc:b0:736:4e14:8ec5 with SMTP id d2e1a72fcca58-76e438f0ec5mr15651177b3a.11.1755526017550;
        Mon, 18 Aug 2025 07:06:57 -0700 (PDT)
Received: from [192.168.1.4] ([106.222.229.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e45588c05sm7492056b3a.82.2025.08.18.07.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 07:06:57 -0700 (PDT)
Message-ID: <9f94c6d7-7b39-455c-83d1-81c694672775@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 19:36:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm: skip re-emitting IBs for unusable VMs
To: rob.clark@oss.qualcomm.com, Antonino Maniscalco <antomani103@gmail.com>
Cc: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250813-unusable_fix_b4-v1-1-3218d166b8a8@gmail.com>
 <272d2a39-19ce-4ac5-b3c6-3e3d6d9985c5@oss.qualcomm.com>
 <CACSVV00Yo=cZxUztB5Jf7153bsnnuATrh3L1utw4SrOQmYERug@mail.gmail.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CACSVV00Yo=cZxUztB5Jf7153bsnnuATrh3L1utw4SrOQmYERug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=D9xHKuRj c=1 sm=1 tr=0 ts=68a33385 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=9Q8gPALlkHEzzDxkdHlyxw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=1QxSUWC4Tu4TNCmoOX8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: EIycykTKCqoCOq3LP1EwPXY7UCtvJsuI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyNCBTYWx0ZWRfXwRugKa2drxbk
 7YSoTwAGVHiXR8VZrjcecFacWnLfsBaIQxotgxVTdSGaGxseaCDela6i9B3Z/PVDoSaosLkEVZS
 Cpq/WaY0w/EslhH//WL2CT7syr11Au6J6+EpNb69nFgIvAGcxN/NY3DY7CRZYBh4xt0X5uvsKrh
 j+8/YzT9WUvvMHgw3eOPCQswt7VWSHrxshTU781ULSpdYGvxRJ7cki9rSld/p84Px4bBlXzWn2M
 Ea2idtuWsbYLFq5FMEzCcHp3kZPkfKEEmgQypDBleU3j0lmtVAq22gavu+4itt5P/O1bro3Zqqf
 nMaFc0+vGhGXV77BHabmi5hR2XpQg71bUIPyS87Wr0GEY+6Wm+g/kKS2ZTZU6M/jQJ79IzrcjOF
 FeP6sPls
X-Proofpoint-GUID: EIycykTKCqoCOq3LP1EwPXY7UCtvJsuI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160024

On 8/18/2025 6:48 PM, Rob Clark wrote:
> On Mon, Aug 18, 2025 at 5:10 AM Akhil P Oommen <akhilpo@oss.qualcomm.com> wrote:
>>
>> On 8/13/2025 6:34 PM, Antonino Maniscalco wrote:
>>> When a VM is marked as an usuable we disallow new submissions from it,
>>> however submissions that where already scheduled on the ring would still
>>> be re-sent.
>>>
>>> Since this can lead to further hangs, avoid emitting the actual IBs.
>>>
>>> Fixes: 6a4d287a1ae6 ("drm/msm: Mark VM as unusable on GPU hangs")
>>> Signed-off-by: Antonino Maniscalco <antomani103@gmail.com>
>>> ---
>>>  drivers/gpu/drm/msm/msm_gpu.c | 9 ++++++++-
>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
>>> index c317b25a8162edba0d594f61427eac4440871b73..e6cd85c810bd2314c8bba53644a622464713b7f2 100644
>>> --- a/drivers/gpu/drm/msm/msm_gpu.c
>>> +++ b/drivers/gpu/drm/msm/msm_gpu.c
>>> @@ -553,8 +553,15 @@ static void recover_worker(struct kthread_work *work)
>>>                       unsigned long flags;
>>>
>>>                       spin_lock_irqsave(&ring->submit_lock, flags);
>>> -                     list_for_each_entry(submit, &ring->submits, node)
>>> +                     list_for_each_entry(submit, &ring->submits, node) {
>>> +                             /*
>>> +                              * If the submit uses an unusable vm make sure
>>> +                              * we don't actually run it
>>> +                              */
>>> +                             if (to_msm_vm(submit->vm)->unusable)
>>> +                                     submit->nr_cmds = 0;
>>
>> Just curious, why not just retire this submit here?
> 
> Because then you'd end up with submits retiring out of order (ie.
> fences on the same timeline signaling out of order)

Yeah, that makes sense.

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil

> 
> BR,
> -R
> 
>> -Akhil
>>
>>>                               gpu->funcs->submit(gpu, submit);
>>> +                     }
>>>                       spin_unlock_irqrestore(&ring->submit_lock, flags);
>>>               }
>>>       }
>>>
>>> ---
>>> base-commit: 8290d37ad2b087bbcfe65fa5bcaf260e184b250a
>>> change-id: 20250813-unusable_fix_b4-10bde6f3b756
>>>
>>> Best regards,
>>


