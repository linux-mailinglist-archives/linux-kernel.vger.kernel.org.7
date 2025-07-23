Return-Path: <linux-kernel+bounces-743221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E557B0FC1A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 23:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BAAB7AFECC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A443A26CE36;
	Wed, 23 Jul 2025 21:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZRh9zb5o"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943441E7C1C
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753305783; cv=none; b=e5SPAN430040nbIcMNThpU66HDbjPxzPCCZ/N7qJtLjd8ZjkrA9JZQWLYFzJ2sSckPDWjkgzutGXDUeeOR/7xNCFqygym+t7o3Ekc9gcp+X/eC3DmYUEt3ZHWjRJbfeUs3BBX/iydm875+DBAjr3XVj504YL63htonoTM/cpHpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753305783; c=relaxed/simple;
	bh=WiLRhzaU6WowDU04zrVRVnlRApdMC9elWLi/01V1GeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KVRr40+ROuomOVaztk03xZXpI2KGjDlld6mFtmllmG8RfcrYcFovlh04i1PrHrcX5O4VdUjvk3Obn6iZAB34c3i9RSeV8h9/HmS7dtfyUhp+u1Lv2Zn4oa9ZaLM+Aq3K3irTMxDrckEBK7OV99lYz6uvp6StvgrElmyR+ROZTjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZRh9zb5o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NIcoiG019659
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 21:23:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5/z+nOL74D8w9vAYW+IhxAClZgEjiAjEMElrQIQE8RM=; b=ZRh9zb5op1HY/obI
	UCGTeWI5u9C68rNnudRJA34p1jMqbwcBS3oO0Re3H2Bwvf6ubd3nDCmPJZaQE9Qx
	FBYC6VP1VnBlcGGQlJdg7NOqrDvab9MLLvYYuAL8f4rsBZPVyrVTp+3fSwYmtPn4
	e/pQaDhpbOnS5/CIGWcm6mctTuLCPhSuZdVNc1Fe7yvd39HycAOnbOw08ictgRza
	lChhdyVun5sAXIEi6peN11qjkgxculfH3n0CBBhS+45FQfO0FMuCHkBJ2IoiRZwf
	ep9Lqjh02Tmn6/nMojFb81fg9n7OkKxAFrBObXS4TRCj3IZnjhqEf4CMWWrCCAH4
	l+ysnA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481qh6rr8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 21:23:00 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-234b133b428so1850735ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:23:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753305779; x=1753910579;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5/z+nOL74D8w9vAYW+IhxAClZgEjiAjEMElrQIQE8RM=;
        b=vTtGRYTUu1VVfh3XAWs+Y1Z0Gmsksn/CIfBYb0x6EMZr40uLKi8CAATYbbddsGzLx/
         lcsjmnKdf039quhDBvP6uJosIE9mJC4A5dYjhE/VejT6ICHVcOvN2IJ/zvlaBNzFbC8O
         bGrX8K3iatgd2Q5uhUidOu3OQ+C265RXWCZwaYX1Rm4N3HBJaUWPgExRx01UXV8Ru87e
         Up8fhHLO7EPPVS2KOQmeU58BOpPLCkiq4xkLRWBlQJ6wLmvZoFhAkQQoAc4CMzHB45G3
         CEY68UFNqmkch+omNyymFfiwGyUlvz8J3AMblmn908b1Ec/eVDK+fqZezdeYN6+W3Njv
         cQSA==
X-Forwarded-Encrypted: i=1; AJvYcCXPzxaGpR2uMAu5kc5HtVKTSDNHF2yfybV3LvXPFoHW6HBcnkVTzaJ33uKonuUCT8uUpy1mb3cQYp+ZuTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF49cL2oaekbSKya9EHs8o6+jex6teVSwxzCBBT9IbqEuPea8o
	dT4QjZ1yCn3hRxpc+c8Ll83DlCPYlZX3Wz6WOiVVcDtTQZmNLEbbRbgpfzxiX3QfYOjEE099K88
	wgmvPpd5AwabXLYYQwRIVOBn2koGkSLZv5kykBOSj3xzBPDbDFD3r1IRhIORONzGJLJ4=
X-Gm-Gg: ASbGncsPj3vsZexBb9MprYS8I6hZE2Fp2a2Sis2kcBh1fxzY0eGdI1NG+4AnJ/gCvLN
	5GTQTTgmxg/9+MQJoxhcR/9fYyXigRx7UkVh5GKk3VCJA9NfbDiZV3h1y8ERM+V6KTd7o2qRSRG
	Ry+AvNM2al+8WmhNxWYycyP8TO9l4psHa6mMiuipe3EbZLvNVJDFWPsij2jzO8EEj7MRKSjMYoE
	viLHudemWA1lO1Zxn/4ApGjMTqv1YLdsWnO3HNZml04dAQ6Pwi9G6hf6RzsvVswkQrfL8wBASCK
	xQiLj55guoTVqIddrqWwk0wSft96g03J/wQqr+/eX0AWmS6EgKqLE6iw+6AjOw==
X-Received: by 2002:a17:902:dace:b0:231:d0a8:5179 with SMTP id d9443c01a7336-23f981ab03dmr63604465ad.23.1753305779145;
        Wed, 23 Jul 2025 14:22:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAnCXs/FfPCFuiouSfivDnKR2aZyEWeXP92FqAGxP/yYXM4uPOB9jhUhkeFLnVtSM7YSM/Iw==
X-Received: by 2002:a17:902:dace:b0:231:d0a8:5179 with SMTP id d9443c01a7336-23f981ab03dmr63604205ad.23.1753305778738;
        Wed, 23 Jul 2025 14:22:58 -0700 (PDT)
Received: from [192.168.1.5] ([106.222.235.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23f8c3f14d5sm41141445ad.192.2025.07.23.14.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 14:22:58 -0700 (PDT)
Message-ID: <9322badb-9f94-4bd1-9e3f-447a9134cd7d@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 02:52:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] drm/msm/a6xx: Set Keep-alive votes to block IFPC
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
 <20250720-ifpc-support-v1-8-9347aa5bcbd6@oss.qualcomm.com>
 <jvn44gmttkidyy4emnz6mytqqjbwltlxibywfr6bfbqjfbq35e@fuvvefesqbzw>
 <0427769f-62a1-4a20-af94-b340413296ab@oss.qualcomm.com>
 <644a81ff-bbce-4cc7-a364-8e0c591898b3@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <644a81ff-bbce-4cc7-a364-8e0c591898b3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CZ4I5Krl c=1 sm=1 tr=0 ts=688152b4 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=pSIa2sKh8ADkebnh61Ypzg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=CLd7HrSr3Nb56GcGzJUA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: inBTi8Up_oe85NVKkmOcP-QzRjVUSywH
X-Proofpoint-GUID: inBTi8Up_oe85NVKkmOcP-QzRjVUSywH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE4MyBTYWx0ZWRfX3uoLIL67wHB1
 eS/QfUlD2Er6HsmG8EP9F41dndeGp8e3H7M6/bYXucvLKPa4iyXRTNfFDyPdQ1pYFmzcJL25TRj
 v/r4Iqubho2ARMohSfoxQMi7MeOckyI7kWiOWzPzBVhDLk8f8yBo2hAUsb/zCAdcD3pRWQEf3eP
 XyW5nHS3AP/nZJ3qy/M7Z0Cp0IXaBy2u8npJeiyCyb6cI65VY/zQh30HEbOh64tLCX8Z4j6ZwsW
 vRImBnWmZ+Gvw7zOrOsxRQeIYMy21OBkpelN8Ef3UB5d0IgN/4fjOA6MThRCM8OKKwz+Bwp6Mxm
 gAhB3nJhV2ZkGBJPPowvVK0GTcJwKykGRKH6hrz0Xvl4XrMnK69DFgjFaDH5gcY8hGfMtetPPRL
 Y/bpVJz2rKf2JslJE4DbOeHqqGSOFaMfRellUuFvGRVOL7yXHFoUMN+MeTv2L3PM8vvub0pm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 mlxlogscore=730 impostorscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230183

On 7/23/2025 3:35 PM, Konrad Dybcio wrote:
> On 7/22/25 11:24 PM, Akhil P Oommen wrote:
>> On 7/22/2025 7:14 PM, Dmitry Baryshkov wrote:
>>> On Sun, Jul 20, 2025 at 05:46:09PM +0530, Akhil P Oommen wrote:
>>>> Set Keepalive votes at appropriate places to block IFPC power collapse
>>>> until we access all the required registers. This is required during gpu
>>>> IRQ handling and also during preemption.
>>>>
>>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>> ---
> 
> [...]
> 
>>>> +static void set_keepalive_vote(struct msm_gpu *gpu, bool on)
>>>
>>> a6xx_set_keepalive_vote()
>>
>> static fn! Why do we need prefix here?
> 
> It's good practice to namespace-prefix your functions, so that you
> can more easily find them, e.g. in a backtrace.

It would be obvious from the parent functions in the backtrace, right?

A bit subjective! I feel that the prefixes are unnecessary for small
local helper fns. Prefix for *every* single routine in a source file
makes the code look a little bit bloated.

-Akhil.

> 
> For a prefix, adreno_gmu_ would be even better, as the register doesn't
> seem to have changed across generations
> 
> Konrad


