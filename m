Return-Path: <linux-kernel+bounces-869129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8D8C070C2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0590A4FD332
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0F132B9B2;
	Fri, 24 Oct 2025 15:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iF0tJPBo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1FC313552
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 15:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761320687; cv=none; b=uo+m1+jPsz9aZKuEVgeHM+xah3ppzet/Yop41T8cpPLK5SJgtbRrlDk1ZHxGk8lEbzZg2zHFcO9BqANewKYFaXU15lq9q3zF3KmYZinmGD/TrBEt5q0T0psgH4RKEURxEpHrR4g0r8dEWaubDRB6SMb/OFFOZxE9w65QMKB8gWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761320687; c=relaxed/simple;
	bh=BzlFR1sP1LDfQnnqVDneaWvFJahhmEcC/MtNUN+39ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CQcPhMk9xXOQTcP7UdibDZltOpXXGCDCINlzsjkOPSDDOcCNk82QeKHDY/bqWFz2IP9m6yqe+f3eAbdCry+zCGCCmYNTUJ6U59x+qV7q8UBsafQhZjG6GrFAnso88O2csVBUUbyPwLRpY77A0xrIRdz1e44NUFiz7PJUB3mg1DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iF0tJPBo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OBxT5o003638
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 15:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RsSIFOmPwOHfjKgaufxErN9BuxGH1hiiSVvvEFdeNg4=; b=iF0tJPBo7tivlT9j
	X+fqeHS8Rs4DZQz14wcCn53jSzoIqO5bF0p9DEMxaija/ThZbcObPxbhJiE9peGQ
	58Z0Z2A5ZBft8IjHJiVPghwENeecPSdzrGihxFsRUj0u350iuTUTannpLVuT1/HZ
	toR0UUtX+aqfd/xj9YCSP4V0OyqJdzBIIwH5hWq0nSjsqwPuvjNDDILkXuUkR2WI
	A1wipld5nQ7CQjd/htIEi86dMLveLc4/0YIBoAY23uVBKeahV2Iqub9NEPz7VnBn
	KgX2JLIbKzgNj/9ssPQ3b+i+hy1j0JKO/cts0ln2iJ1JWEgmEW+D6GgRdB4X0QMz
	KrawDw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2gecfgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 15:44:44 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-33bdd0479a9so2441840a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:44:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761320683; x=1761925483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RsSIFOmPwOHfjKgaufxErN9BuxGH1hiiSVvvEFdeNg4=;
        b=AAC36BgIIOOHPKbPkdyytEDVFQXhzbBD9tziknW2P20HdYJ2B6em0+tPPlszzlXTkc
         P9+PmPDoUekDl7DD+NIpVK69qMqvwb/l/nXAZeN3xjmUYgP1kalVJLwfleNhUe93jMYY
         XMnUTzs5ePBf1Ztb2v8Ni1Z1uQEV+ZWvW+feFTiB4kv8SPtqMkeUUezMhnTDYxatLS+l
         coW2J4khc+jzLr5XOgUZs71ZiwihKNfTiLV6FUSNvGWrFwzVgSxikZ+UGxIAgv/tpFzk
         YYb/bAiSIB2rHz1FQvAz+e/TpUk4Ho0pdcQZXKAz5bAPJcx55hKaEx/8i0NqbQsdATnd
         yM2w==
X-Forwarded-Encrypted: i=1; AJvYcCX2Jw7f37vO+1g38TBaLqwgy92g5K8Ey0iL+EXXnBiZXuNvBrTe9Yu1h9bE41sDDjYGTkFfrJim13jyTaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoAIkjjZAmTvIhE91mwb/VbfEg/NxFMei5qAyT/aHbABEypUjo
	a2YVJF8BFGN0AoAtdslY+qzN7ZFAv8GR8KIuwg6txlGjvPO/9Q3Im/5Ybc3gIWRlyv1okXktj8z
	fyUT5p/Qm9+1/x3dWDO/GVRuUaSpV3D3fsAY0aZlikWkXNv9EibyxHrZCUk6hZvvodV0=
X-Gm-Gg: ASbGncv2gTllpaPcQ9zTt6wgqzv5FYMpShjIeA8/HKnH9156A3Fb/P4ijnUXS2qiKHE
	Ms6y2hayElxHaIGShk5MnBag1tHbwqzFu1Ioyexs1wCXv/0BPf3xQhFQmojOP6JgbQr10vHFkYi
	kZsisYdO0VhU0zLPaVnG5h47/hW1btkkx4yvBPqSU7TayoKx29ca8afx0Oc+QMeB/Ui6wYkjfrF
	6/TzhuMTjwd/kqrKy80/obNUCeF9V4Jqt0UUGNf9z6owloJPJMWu2si+EME8+I1jEUdSd0BvEFt
	it/mEkW7rEzy9vrXn58LcnHawDDdZCISRy0jSqNjWIoEk++czh49PTrjsoL1eiLBYXhcxiYLGlf
	Ejy4a+WjOasWgZoj14apPJw==
X-Received: by 2002:a17:90b:3a46:b0:33b:b0f7:fdc3 with SMTP id 98e67ed59e1d1-33fd65ca640mr3482669a91.8.1761320682856;
        Fri, 24 Oct 2025 08:44:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoydupJwYWbjfP4d6gKx6bLId6YhXa84WjCyAv6FuMrHrk33VGVoOGz0iiaQM3Gv/lfWoJJw==
X-Received: by 2002:a17:90b:3a46:b0:33b:b0f7:fdc3 with SMTP id 98e67ed59e1d1-33fd65ca640mr3482638a91.8.1761320682339;
        Fri, 24 Oct 2025 08:44:42 -0700 (PDT)
Received: from [10.204.104.20] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33faff37c14sm6200687a91.2.2025.10.24.08.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 08:44:42 -0700 (PDT)
Message-ID: <7cc6b184-e192-4d57-ba3a-82d4c7069fff@oss.qualcomm.com>
Date: Fri, 24 Oct 2025 21:14:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Remove Jessica from drm-msm reviewers
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <rob.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robin.clark@oss.qualcomm.com>
References: <20251024-remove-jessica-v1-1-f1bb2dfc2e18@oss.qualcomm.com>
 <fe898b57-2b96-4f8a-8f27-58dca1c11ffa@linaro.org>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <fe898b57-2b96-4f8a-8f27-58dca1c11ffa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfX+2QbWXI6wbma
 k2d+TbyKWDwP7CLDfA7nP15RT2N6VZNKY8w5YiwPQ5E1r8U2AD9S7T1nFFDRmiIgMs2E0NzZ3w2
 /M2yGThatA+7eKW9Y3PuRZAunG20mlFekqM7+GSXVXiKg51Jqxt5vrODHhvQ7YJzDEPWs91SjO7
 dra9UbN3h3E2VqSxuFwXurQi9GclPZfBAdejxQbHiiqUJwPObLxtcY40FCs1R1ASFErew36zV6N
 KEcCmC/hf2KzmNF6juvvqh966+dYCHl2dQHqNkWoPkIfoNAH9jFdcx0e0u07r28fLaoZ0lKp3km
 DSSJXaz9dp9HtLVrcOIosWxATOWNDdba4A87cgrmmvnX1yOvenVf2SwKOnD6Ij/onkPNtcq+g13
 qk52H4eqPFpxbd+z732I+RlrON2p3A==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68fb9eec cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=tVI0ZWmoAAAA:8 a=-IAwFrDFS_yr-AoREdYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=-BPWgnxRz2uhmvdm1NTO:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-GUID: SJoS4Ce-XEjfU8bO_exGhy-wnWel0jYt
X-Proofpoint-ORIG-GUID: SJoS4Ce-XEjfU8bO_exGhy-wnWel0jYt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020

On 10/24/2025 8:41 PM, Neil Armstrong wrote:
> Hi,
> 
> On 10/24/25 16:56, Akhil P Oommen wrote:
>> Jessica has left Qualcomm and her Qualcomm email address is bouncing.
>> So remove Jessica from the reviewer list of drm-msm display driver for
>> now.
>>
>> Cc: Rob Clark <robin.clark@oss.qualcomm.com>
>> Cc: Dmitry Baryshkov <lumag@kernel.org>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>   MAINTAINERS | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 5889df9de210..064aecda38cf 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7889,7 +7889,6 @@ DRM DRIVER for Qualcomm display hardware
>>   M:    Rob Clark <robin.clark@oss.qualcomm.com>
>>   M:    Dmitry Baryshkov <lumag@kernel.org>
>>   R:    Abhinav Kumar <abhinav.kumar@linux.dev>
>> -R:    Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> 
> The email has already been updated in drm-misc-next, but .mailmap change
> is needed now:
> https://lore.kernel.org/all/20251002-quit-qcom-
> v1-1-0898a63ffddd@oss.qualcomm.com/

Thanks. I didn't notice that. We can drop this patch.

-Akhil

> 
> Neil
> 
>>   R:    Sean Paul <sean@poorly.run>
>>   R:    Marijn Suijten <marijn.suijten@somainline.org>
>>   L:    linux-arm-msm@vger.kernel.org
>>
>> ---
>> base-commit: 6fab32bb6508abbb8b7b1c5498e44f0c32320ed5
>> change-id: 20251024-remove-jessica-1abd363a4647
>>
>> Best regards,
> 


