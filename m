Return-Path: <linux-kernel+bounces-846485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F632BC8232
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBCD14F64AA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039602D47F4;
	Thu,  9 Oct 2025 08:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xrw+H4t2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8B12D3EF8
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759999961; cv=none; b=uIezZympNENYFN5bt/I4WwN5Ry7U3TB6eYPWlO9kOSKgeLCrRY1leZwoYI1B+E9RvrXGSEuesO3xkpZe3epSnIHoTm1AoyXAI5gHgnuAvOFcTeMxe05FBZgmLGTermuHP2AKILJdbxlztAv+UH57tEmtYKDHonPP89KcqBof53M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759999961; c=relaxed/simple;
	bh=SvL6QwL2kbfoDMu7swIfDh31Z4SBAEEr16lTQLxGnf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SWdoGmgYB+u7W46GWqZibQIsOgNzloASwmlwiFLUk8WBveiXpIOVw8l/QYMfX64bp8VnUKg3PpLEqDz42iStLHLgFCB3G70/SZly5MkuUnnWjaNa/U21RZPzqstSaYbc2CZwB7qtJIs2Dx0wZhsh1A9vLM9/79fa9+vpywztw2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xrw+H4t2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EOJC029759
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 08:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mz3R/+d2HRB2j4ZAAYNbKPbcU1+9mJalbUWZyK8B4cM=; b=Xrw+H4t2gQxnEgFS
	dxv+K9WlSIoBBBrj/ny7tiQn2lGq3Y+40pV21TdG40PO0bvvblR5bscNgV8ZBOn0
	NR5ZYiWL8QWFoguVwfz/fuQfFrppThsY3Q6L0ubkm6qsz5BlViVelyt6shk7GNjg
	avD6M4JFFF5Q7ZU3EEXJ3AI/QwJ9mtGweAHnTnft2xYkzftNm04PoQN2Jnbs0dtB
	PiXMI2iiKa+pVEaaVykHgKIiFJpoNi3Gq+3SzjvHtA0bqUvBQ6RsfKL74sJvSRbc
	AYFN1sIRcanio+cS6t5fRfrGcpOXBkpeoFpQ5OX2bXJdDG/WoLXi/SwnFEPSGQLv
	HNQbAw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4na4aa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:52:38 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ddf2a2d95fso2679481cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 01:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759999957; x=1760604757;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mz3R/+d2HRB2j4ZAAYNbKPbcU1+9mJalbUWZyK8B4cM=;
        b=Q0fzOCsv33wh75rdzol7SfZSNRH5w+HcyhJRXwSvUYzXjAAj+kadR6Y2qBkG8PsgK+
         tik1VtJqZVyVaD12F2awB0dCgbX4s5rev1XHzl0U+hr2dVEyzDPVD/FT7DE/xgsokRgi
         JTQDntQrBPCvw1BFYvYcYCSb54vpdXNQhXPM527MgCATcZQBXU4eScCFk2pv3A2LRNVh
         9l4egG07vr4lBZ2rOuF8hEZLqacXDJ+o4ghhGDhIGuQBqnW4xzNr+T0vaD0Ry5PdNGq6
         ZoUHGHxLMnK9MmD8BFuEtSaoxSCdPHoRsa8Hy+ywEw7V1izfmkv0/ywvXH5VpkXkQKdq
         X3nQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5IgNiA8KusTJCxd8wDttkj3HNrbj78pqK01A/ufqTFDv8UhC8rrQZuO7PiclNBPZH3md82NSngnxZGSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG/NRPT+mdYu7GtMWB+zdkoMlN0ogSmRxGdJxWj5L6LKAzCBwq
	DOkvxEREL1XExew/M5kLwCnI61iLFYiWgOUGkGDplYqOcPIlTxQ6B+wv7mLtxwsRg+2+JhhAzeh
	QdcydgxsympTpcM3Z0uY9YdbgA1YWazQyYlCsjocwnje9ug+WfH7wmoLHsTqHfnZW8oo=
X-Gm-Gg: ASbGncsS1gx1eqXgFFc42URUkUtfpzfnuTxxyL+YOmKeDPfcJ9wRaVDm/jhxYs0tVOQ
	uypHa9Fkw8rIPTRyxOn2mpKd3PskpXS4uD0+Ib+Deoe/MERzmCUBXHPRTbkFvVaM2xDa0nym32H
	DI+n16WF89zRxVOlHK8xChEw/nlg7Xa73Ox7xv6rNiR3pVLe7Aqwh4eg0g+yRdXRJ23cMDyYP2n
	PKarqWfkFWyg05RWNaasF1DfUYEpU7Y6+5EJ/6t2ROZNOjzei/mUJUZiuWtndGND05XpltMUDBK
	dIxOCtagw3xTXq3kwJ636YuD6DYGSpOED0xbjqyLQz/szFg4DshPDOYmjf+BdmhIgHYTJUsPfIb
	gOFLVLT9y3eL/0qCA0Ls0A6ZiDdQ=
X-Received: by 2002:ac8:5fc3:0:b0:4b5:e9b6:c96 with SMTP id d75a77b69052e-4e6ead1deb0mr60152791cf.7.1759999957493;
        Thu, 09 Oct 2025 01:52:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEt0uEiEbh1bGs1o55s5jlT8wv6t3qr229hu5kTSl6GIzd3si4d6C3k4g7aU0DhbZYlQXIyoQ==
X-Received: by 2002:ac8:5fc3:0:b0:4b5:e9b6:c96 with SMTP id d75a77b69052e-4e6ead1deb0mr60152511cf.7.1759999956930;
        Thu, 09 Oct 2025 01:52:36 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652a9bfcsm1836499866b.17.2025.10.09.01.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 01:52:36 -0700 (PDT)
Message-ID: <3e115b9c-41b2-47c8-ac92-22969766ec3e@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 10:52:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] drm/panel: Add Samsung S6E3FC2X01 DDIC with
 AMS641RW panel
To: david@ixit.cz, Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding
 <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
References: <20251008-s6e3fc2x01-v2-0-21eca1d5c289@ixit.cz>
 <20251008-s6e3fc2x01-v2-5-21eca1d5c289@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251008-s6e3fc2x01-v2-5-21eca1d5c289@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ZJzaWH7b c=1 sm=1 tr=0 ts=68e777d6 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=WFa1dZBpAAAA:8 a=bBqXziUQAAAA:8
 a=cYgmbtr1Y_meZTC9yNIA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=MZguhEFr_PtxzKXayD1K:22 a=BjKv_IHbNJvPKzgot4uq:22
X-Proofpoint-ORIG-GUID: sVap3uKdWn8pjt4GFcYpBBdxeca9tk7W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXzbakYKSMLCD6
 R5rRPFaiApSzd5CLvOlIMpcZRKhT8ucabYd+cBYK654AXgsYZydQlKM4dP2ErE2JpuDGxpFFHh2
 SUx4KmrffGE5DDdsxzYt8GmkpsAiZKfppJJbvKeRcquKMiZ9kX9WHu4R0PxrcaULq5P/P4tdDcl
 WmKt9Ph+19js7DCmXODM9BKFYya5o4g0dyOGt7+oPciFdlnrbNcw3yQfzfMMgazCe8xM9Nv1+e6
 +XkIxWHHY75z1tUnccXiirEcvgeDlu1LoZRgKlNsemNTaKpDzffG/jjAzxkaqc/jikei7P9Ys0X
 H0C0DITDZzFp7WIfLe/razEhcqTPNzFpHfc5YyVpBUaaoco962NOPMTCTdTwLCsqsb72P3cZwWT
 qGejR8UKNqZyyLLByoja3tIX9UUfaA==
X-Proofpoint-GUID: sVap3uKdWn8pjt4GFcYpBBdxeca9tk7W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On 10/8/25 4:05 PM, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Add panel driver used in the OnePlus 6T.
> 
> No datasheet, based mostly on EDK2 init sequence and the downstream driver.
> 
> Based on work of:
>   Casey Connolly <casey@connolly.tech>
>   Joel Selvaraj <foss@joelselvaraj.com>
>   Nia Espera <a5b6@riseup.net>
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---

[...]

> +	/*  This panel needs the high and low bytes swapped
> +	 *  for the brightness value
> +	 */
> +	brightness = __swab16(brightness);
> +
> +	err = mipi_dsi_dcs_set_display_brightness(dsi, brightness);

mipi_dsi_dcs_set_display_brightness_large()

Konrad

