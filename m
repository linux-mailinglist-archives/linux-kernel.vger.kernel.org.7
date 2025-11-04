Return-Path: <linux-kernel+bounces-885500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA431C33244
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 23:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EBE918C1F4B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 22:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E130234963;
	Tue,  4 Nov 2025 22:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FCFKYNr/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K33pKP2B"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061BC2BB1D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 22:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762294512; cv=none; b=BBVu5FmkRkMWUccYQEDisCkB9HVZncrvPDa4f9FCXUtKvY2wH4wytH32kNt6q319iLg01sqvzyk+vRyLENcp92yMOQM5MNWIpTDA0EP8YVlMtcRPptsVPaKTQDZZNjg67tnTwp/bxoK2SR9gOzQ9w1f3GXPqDqHFe82QVNAwftY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762294512; c=relaxed/simple;
	bh=Dc4kqL4A0k+kCirDqu7t00i8lKGuYTBpwR/YdNPIuAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SfgIPSWkW/0iFdgEM+VP2+xHp7wp3zGucLRK4KeKl/lWR0SYLnvOh/Nb43PqhHLyMEKs7vHM8zlIlJZK1XrlHcnQmUZN2jeqjXEBkKCJgLsV8VRie9qV5OioJk2r+bnsJ8CKaO7OSbllDwZ2AcLr/pPTA3FisxiP85A6pLR7d4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FCFKYNr/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K33pKP2B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4KgDb73086286
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 22:15:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ogbBgd/Tv25LIQg1F6++n7axOZ48HuYuD70xNJM/fEQ=; b=FCFKYNr/ialbd9JR
	pHORa2NYr5qUtOAxtzEzhdloSYdIhKvmqVj9ntsGL0McN4s1pCOmXirkCBE31WGq
	snFcuo17qKaA1mtkbA8rlxUoVfseOylW8Az5aOM5x1XlwdXVcpUkwT4qzu9l+CRw
	MDCsSObf3ojBQmlgtLvhrDrFFiVRfivzXt6I8vnLyR+SuGewkxNp2qbcCNmqDUoW
	WCiZnQq5ff0T8eW11zjyxPFl5vvKf/yfkicTo64QeyZW4bijiJrqZV8jvYu8fDF6
	4QnqP6zgn6t3NqtvTfd/OGL6CysJLMZLacxK3IQHI8ekUcZs09lx3U0i+KzJJiAG
	Xp4Gkg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a79jju34f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 22:15:09 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-79e43c51e6fso230765b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 14:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762294509; x=1762899309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ogbBgd/Tv25LIQg1F6++n7axOZ48HuYuD70xNJM/fEQ=;
        b=K33pKP2BTFixdM70iOG/3Kd3gFe9sp97LTpnr73YurtTY+bK4nrozBknFiKzZgiVmD
         qj34TWnMDImE3cV5yTIuEOO/npfFWvMK/AVkcJ67N1Hbkwcj7hJmBUV0cAN3jBPIetmU
         x5FrnzdY2/eDv3iUv6oXZKFj3cS6ZCmuK4OTVQfKLhkHsfZ4W8tXR6seJ/vDfakUH0sf
         NE5OUc9BObfPTVvb1G/ua9nkVa96MFPIrvz/EBAkAHN2Q66daY7Nl2amozbx32jgs3DB
         BJtxZSRzVcoT/cawt2p7AVkae4MpAjtPbVoW4akvJf3o2zJLaSSLWghSQUc1fV2jM3aS
         E/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762294509; x=1762899309;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ogbBgd/Tv25LIQg1F6++n7axOZ48HuYuD70xNJM/fEQ=;
        b=mnxwUvJeXqgJCfdni7UAHvudEeo/wm+Gg4/MoDgOqmfrlHHc8AB8M2XLeCsRhGb340
         aJH/3JSGhzMS3vNdrr6Kt8I/9qWuQkkADFe6pgB73ivns6WK08BjYBVbYrB9Ywy6cCUZ
         8iK4HIX5zVOR8Yvf2sqdCecgWDcbEIeyLz0e+qS8DfK05R1lCZv3d8GTPUxuyh4EsCY3
         C2XUfJuItFG+PfrDQEdbjFspDTvZ+xbqFqROEc7GHkACibeixt9MZrz+z0i8uLbCrcBC
         XqtJcYqGlVlIqv4WMILT300hDeE82+U1k4MGqauq/A0S4ihnDQW7Bimsjn9yVXpyXtSd
         x1Ig==
X-Forwarded-Encrypted: i=1; AJvYcCU1Za3W4lYl+bFbAbm+dPfVpAPV7L6t9li1JTmsLgxx1mnXvGRNRpwPRf4GRIXJiz1NdhIywSYYEU9vdt8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb30aFgt38ZNNkeA7oTDT10GR8xxlu4OBacjYjsvBa1+W9hakh
	nsjr3b8eZR3IsZogMEV5SUqX8SLdySTK4aGFemOGAy79PXjXmoqYUJDQNuQBhsI5PYv8UQ56TZL
	p3+egA7P6P6IoHRnuFmVE3izbG6TXQfHkwLBZva4tUPM7YyK+OuKjFX4Vu90ptd6JMwY=
X-Gm-Gg: ASbGncsuH38iXs0d6JNZdzTzTYUD14SilhtDPoACvqAvACZZY0TZ24dWjuv1MF9izmk
	5IJnF6k/B0LauAi0IdTkGNNiAbKTZVBGNkEiqS3evSQ2miUemi/Vq2gpvO6L7W8bQSMQ1zbNHFB
	JccztXoU7rC4zHwidQ6/g1DrSWRo6T00XMHJHhhoSJvqgSl0lLqoxDO7cjXMYilygchPPZtRJGm
	Th1M4MK4EbpFKJRoINVmAoyLJoQefYWfMk1+s0+PPpccQO4WdMpVP1EkkPFzPpHQHad5rLZk8EN
	9I4jKZX0aWy8Xhwlo0fH9fb1n2dkomL5cnWX/+qZrVp2FdOk+Bv5i0PLgHV/elTkdbfVmvNE3zY
	KkCRdLruTZ2o3PSPCsI6045s=
X-Received: by 2002:a05:6a00:4188:b0:7ad:8299:6155 with SMTP id d2e1a72fcca58-7ad82997336mr2710630b3a.2.1762294508745;
        Tue, 04 Nov 2025 14:15:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMSaGzu4ogexmgVVatd2/255fBbWIxfGY0+4QCkMTk6DFn3f8QXyGVUkFdUAVjo2NXiMQ6Dg==
X-Received: by 2002:a05:6a00:4188:b0:7ad:8299:6155 with SMTP id d2e1a72fcca58-7ad82997336mr2710598b3a.2.1762294508107;
        Tue, 04 Nov 2025 14:15:08 -0800 (PST)
Received: from [192.168.1.6] ([106.222.228.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd3b10bd1sm4013047b3a.30.2025.11.04.14.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 14:15:07 -0800 (PST)
Message-ID: <b94eff34-8a10-44fe-ac8b-304407922984@oss.qualcomm.com>
Date: Wed, 5 Nov 2025 03:45:04 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add Akhil as a reviewer for the Adreno
 driver
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>
References: <20251104220245.240480-1-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20251104220245.240480-1-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ym13rcUiFYSJ7wDvHoe3wE04alZXbuNC
X-Proofpoint-ORIG-GUID: ym13rcUiFYSJ7wDvHoe3wE04alZXbuNC
X-Authority-Analysis: v=2.4 cv=TuPrRTXh c=1 sm=1 tr=0 ts=690a7aed cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=oSIXvc0h2ZBec1W313aPdA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=e5mUnYsNAAAA:8
 a=V8cJkdWAq56nonIdhLQA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDE4NyBTYWx0ZWRfX/fM19y57h9LM
 LyVlMAULw+pWWUBnHwAep4+48jxpBTt+Q54lbvjtBYlbz2VLK1PR2UVI/bWpo8MLcd+09GohN4n
 fhLmVK7whLXEmoqS/d+eemLtOfg1cwPM2KSbjoCVhroxid9Dw8WKriOyEEHYjYBLkIToXyiIF1L
 K7Ob2PWhRyaq3C8wJYxPnTSA7X5e0QqbgMehqWfrg00iQ77fdbZ61VvVOMg/Nw6CyO/dZ+enlUV
 Py+ehXbcOlthCWamleNRVfi3/OJ9MqrQMwggTfr2FQh8ierXFIA/zEJ3MXOdlkbgVNOVTp/CP7Z
 9Vkp1M7KD6dfanz5vAfTBKckgbXX5eZiaykkH3cJkzI4yx0W20d26JCRFNHTYk6PVyXl2Vju1V+
 GMimk9DJvGS1d/H7PSmzdAYsF17h/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 spamscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511040187

On 11/5/2025 3:32 AM, Rob Clark wrote:
> Akhil should be getting tagged to review GPU patches.
> 
> Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>

Acked-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1083598bb2b6..033675aab0d0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7880,6 +7880,7 @@ DRM DRIVER for Qualcomm Adreno GPUs
>  M:	Rob Clark <robin.clark@oss.qualcomm.com>
>  R:	Sean Paul <sean@poorly.run>
>  R:	Konrad Dybcio <konradybcio@kernel.org>
> +R:	Akhil P Oommen <akhilpo@oss.qualcomm.com>
>  L:	linux-arm-msm@vger.kernel.org
>  L:	dri-devel@lists.freedesktop.org
>  L:	freedreno@lists.freedesktop.org


